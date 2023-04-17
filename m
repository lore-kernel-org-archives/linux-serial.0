Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C888C77B76
	for <linux-serial@archiver.kernel.org>; Mon, 17 Apr 2023 16:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDQQuP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQQuO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Apr 2023 12:50:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078547AB9
        for <linux-serial@vger.kernel.org>; Mon, 17 Apr 2023 09:50:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4eca0563b31so1539376e87.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Apr 2023 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681750211; x=1684342211;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XuT0QpKG32bluWHsGuKYdPqz6z2AfCFTPZVbZ1HAEbY=;
        b=opybyQYQ/2GBQ74PbWWXC4WHAu6uPi9v5yr2W6Dzt39A3kBnQo3sL8BTHXlbwRGHXu
         uZRzM60uZIS+FQAU6Kskr+3x0A5uy9MMfsHoQMgHx8HS1v5IrKzENbN2Uc4BQpaLVyeW
         SzFoHtS7b+CmY7JsnsqvCYnt+wfqsDurSq95j/wDq4Rn4XUFmO3PcrJe1YvesTXRTydM
         AR2pi+UWiYPoN37rwh1yF4/CRiJEXOZ4JqBj/0ckiFNzYy7ZbQlDh6hDGPHM3Q5iu5j/
         zWmIrzIpBCu5MrXITmFukLa974lg6AmMkhlVNNvPa1Im4q7yX0kQu2D4ISr3S4gxP5dw
         Za4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681750211; x=1684342211;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuT0QpKG32bluWHsGuKYdPqz6z2AfCFTPZVbZ1HAEbY=;
        b=Td0qmZZYTkAvxG11gOVErHv6LFs1pP8Ei6KfSJ6DohvyiVYtG4fV5xuPjXCrAngkdn
         yhvDi2ssylw+9ZLB7YddPKRklO4eqEuetOvZ/KH62iJl4weZgY8SpXi+gmX7IGrwYI/4
         025kJ7f+te07KGhC+fkEdswBlM5ZxN/Pna5keWn7rGlbm/dIlT+txZJ3XE/BFakwqDDA
         mUKE9XdnpnYcrnIwY7SuqsNCFBBhnBLzEdEtxotbcgsk8cM/H+huWog74RH71dyehpLZ
         nM+h420Ru92IT7Bbsz7Kun32L6ZWgDOGLEqrRes2DMelx4FhV/4R5z+9J+9wA3kdzmPY
         /phA==
X-Gm-Message-State: AAQBX9dcv9f2cijDYVuEKrjxymvmMgeQDkKjIvhnRwIqJBQ16q+ZcbRJ
        8UyEL4T4sSsI08lScLSCYXs=
X-Google-Smtp-Source: AKy350ZHoC1Dcvb/dqestVmHBSpHQ+gvkgENCzAYhZE3V6enWoLJBonNP8PZlgpYh5/1fiivFNTbZw==
X-Received: by 2002:ac2:4427:0:b0:4eb:4fad:1627 with SMTP id w7-20020ac24427000000b004eb4fad1627mr1763758lfl.59.1681750211128;
        Mon, 17 Apr 2023 09:50:11 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d8-20020ac25ec8000000b004e792045b3dsm2102068lfq.106.2023.04.17.09.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:50:10 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
        <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
        <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
        <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
        <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
        <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
        <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com>
        <87mt3ynsa7.fsf@osv.gnss.ru>
        <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com>
Date:   Mon, 17 Apr 2023 19:50:09 +0300
In-Reply-To: <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com> (Stefan Wahren's
        message of "Sun, 16 Apr 2023 15:43:09 +0200")
Message-ID: <87sfcy8ncu.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Stefan,

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Sergey,
>

[...]

> i had some time today to investigate this a little bit. I thought it
> would be a good idea to use debugfs as a ugly quick hack:
>

[...]

> Using this i was able to better compare the behavior with RXTL_DEFAULT
> 1 (without overrun errors) and RXTL_DEFAULT 8 (with overrun errors) on
> my i.MX6ULL test platform. After doing my usual test scenario (copy
> some text lines to console) i got the following results:
>
> RXTL_DEFAULT 1
> 21f0000.serial/stats:total_duration_us: 61
> 21f0000.serial/stats:rx_duration_us:    36
> 21f0000.serial/stats:tx_duration_us:    48
> 21f0000.serial/stats:received:          28
> 21f0000.serial/stats:send:              33
>
> RXTL_DEFAULT 8
> 21f0000.serial/stats:total_duration_us: 78
> 21f0000.serial/stats:rx_duration_us:    46
> 21f0000.serial/stats:tx_duration_us:    47
> 21f0000.serial/stats:received:          33
> 21f0000.serial/stats:send:              33
>
> So based on the maximum of received characters on RX interrupt, i
> consider the root cause of this issue has already been there because
> the amount is near to the maximum of the FIFO (32 chars). So finally
> increasing RXTL_DEFAULT makes the situation even worse by adding
> enough latency for overrun errors.

Yep, looks like an issue.

What's the baud rate? 115200? If so, it means that interrupts are
apparently blocked in your system for up to about 28/(115200/10)=2.4
milliseconds. This is very large number, and it may negatively affect
system performance in other places as well, I'm afraid.

Best regards,
-- Sergey Organov
