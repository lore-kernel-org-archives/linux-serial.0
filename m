Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F4C6FD1C
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 21:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCXV5J (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 17:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjCXV5H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 17:57:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2786ACC04
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 14:57:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c29so3968557lfv.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679695023;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u6ntX+wZ07Qy820TjP32SvoGWE/t77AuYM9cOcO54hU=;
        b=UvnvJF4eRzZmofRjVZqFpY1plcA5tA5Ph7tkCNXcyxXFz3Hxlvt5HrKJGKCElJpEsR
         dzRL6N07LtSVxcIoLCBlTSHZpwNO66BtwPNkmIdZNP+VxVZ/Ho80T9qQucKJHVRYhBBI
         smTZy84MYi+gPw68qtac1aN/tehefg9GJiHl9pmKDMJeJmqnnj/82CJTgCjPklYLSWfW
         cyjRvRXXp/1gJJdyqzqklyQKBnxvNbH14O5vaVX18E59NUDUZqfrdPZnZQV1DPdwzOa6
         doU2FVGqjIt4DzvLT/IrYJyQbXiaphlwe8umfxgSlOxv3AAes5eFpNnVHppo4pQq8Viy
         MQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679695023;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6ntX+wZ07Qy820TjP32SvoGWE/t77AuYM9cOcO54hU=;
        b=wMb4+dqiYHlAqi7zgn1yBdzhoexotgfxevMF6wVsLKQ8v/jENRx2VLqopMGetdTSam
         5E3z7DlQt9ohcrPrZLjdotqOO7GS5o/lsg85XmfZLRWyWLbT/vFnE5XJxZ0+kRX2jBRY
         4PqUhWQCDBQmZwX+u4t1Wswa9Oee9Tst+38104fqWAZH0umQRn+Ehh5zvZrPsh/3un3d
         9FYIRmRoU5bC6ozXw30i/KG81R5ezeI9i0eJl3imyvHsBzz4tmyfD+mSxNnNOjjp03mC
         U+sVFw5Vqtajc21EBGelGF5rOGEqnrbxIKXA+JnKe1zQa+Dvwwb9xVVZbdhcLtOfj3GU
         JqqA==
X-Gm-Message-State: AAQBX9dkc1Y05YqhnYHlxIC3pI8FOY7TRBQVIrRJbMBzNN6Secicf7GB
        RCxO4KsjDGHQMlELtyvI8drsZxASKqc=
X-Google-Smtp-Source: AKy350ZTGL3e/kTStDdbrh3FgqBboRD6sjWuALaGF3Pccf8CzYdgFiDJd0rdHFrZWB6URZqKwJDCCg==
X-Received: by 2002:ac2:5966:0:b0:4e9:d85d:9032 with SMTP id h6-20020ac25966000000b004e9d85d9032mr1124152lfp.54.1679695023042;
        Fri, 24 Mar 2023 14:57:03 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512218600b004e8452972a2sm3503296lft.247.2023.03.24.14.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 14:57:02 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
        <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
        <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
        <20230324133739.rwo6yr75vrwatbhb@pengutronix.de>
        <547ab600-3630-4645-75c4-ff29610c9437@i2se.com>
Date:   Sat, 25 Mar 2023 00:57:01 +0300
In-Reply-To: <547ab600-3630-4645-75c4-ff29610c9437@i2se.com> (Stefan Wahren's
        message of "Fri, 24 Mar 2023 15:19:46 +0100")
Message-ID: <87y1nliziq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi,
>
> Am 24.03.23 um 14:37 schrieb Uwe Kleine-König:
>> On Fri, Mar 24, 2023 at 09:57:39AM -0300, Fabio Estevam wrote:
>>> Hi Stefan,
>>>
>>> On Fri, Mar 24, 2023 at 8:48 AM Ilpo Järvinen
>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>
>>>> This has come up earlier, see e.g.:
>>>>
>>>> https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.int.toradex.com/
>>>>
>>>> My somewhat uninformed suggestion: if the overrun problems mostly show up
>>>> with console ports, maybe the trigger level could depend on the port
>>>> being a console or not?
>>> Does the change below help? Taking Ilpo's suggestion into account:
>> I wonder if it's a red herring that having the console on that port
>> makes a difference. If I understand correctly the problem is pasting
>> bigger amounts of data on a ttymxc after having logged in via a getty?
>>
>> @Stefan: Can you try to reproduce with the port being also a console?
>
> Sorry, for the confusion. Maybe i should have mentioned that the debug
> UART was configured as a console.

Chances are that you might experience the same problem that I've
described here:

https://marc.info/?l=linux-serial&m=158504064609504&w=2

Essentially, any serial console output out of printk() could easily
cause 10 milliseconds or even up to 1 second interrupts latency, that
will definitely cause overruns on serial ports and gosh knows what other
problems.

This issue hasn't got any resolution as far as I'm aware. To me it means
that I can't use Linux serial console at all on my non-SMP system,
unless I remove the offending lock.

-- Sergey Organov
