Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D01C6FD1F
	for <linux-serial@archiver.kernel.org>; Sat, 25 Mar 2023 18:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjCYSac (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Mar 2023 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYSac (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Mar 2023 14:30:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAE5C170
        for <linux-serial@vger.kernel.org>; Sat, 25 Mar 2023 11:30:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h9so4968833ljq.2
        for <linux-serial@vger.kernel.org>; Sat, 25 Mar 2023 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679769029;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZAGnDYDwy+EfPH5YuYCiFqndH71GSU/qDTqOWjnek4k=;
        b=c/mxEMDRuUq3lT1zQtjt+CIfDNQ2IsHjMrrtxCdhC9S/xFlC9PMQbh+Yjo0tL7NWyV
         Fev3/zVRVhq6PXHR2lbIqTRnTdRAZB3eSvHEAzztktcxiYsCz+THFI+PPkx2eNf6dX5D
         J9L45HHafq/wJecTOvGcFqCAaZdp1ycYpJZLc19j6OCgdh/xIvVQRDblt7VNxoIH6Fzl
         l0MtzYM+7Wle6TqaaKLYYmPnydx5el1o/mg8GcOjCSPOpLxmHQlfKIXflBetg77H2N/Z
         LpIBLzNTQsXss+eCaUyI+9e8dEpHZyJfFjd+quojCDcR3MsRfdrFeHIlrs0mnKqDX2b9
         wgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679769029;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAGnDYDwy+EfPH5YuYCiFqndH71GSU/qDTqOWjnek4k=;
        b=LhA3gRxFNkDeGXtJ0o2St9PNxyYuf0JL4fm+4kMbBy1jUCvyIvIVpw161nBkal7aHG
         E2PZVU7+RLIrZoHY7G9B01Bbe/mN0OqCqFbDXKNuZphSXXHxFwYSe1FHNG2r9fkOYZI+
         bqVDiZhHO1rYINNguBx8PGk3ZgVy54fAeYVY+f4rmPVZN+TwVIsWxpWoxp6k6FyiWe2Q
         UXiInV9Thh1UJGPHYuSeQZseZ1Vd5qGE5n1xb1yX4vLx8uErGDEiDOYUArWcWIgWemIR
         2vpSBJCM+MaIsDoR3ll+f1bKVL0EGPfLJ3DtpUyxI3hcdmDuO+34nIK3Z6v8j/2AZsvl
         s3lg==
X-Gm-Message-State: AAQBX9cY6fDNF+YEiODhlM1h3b7veuMcC5YLTRhGRPYJ+oGKlYhByOr0
        kd9ZulznQDZxCvvDTrf4LEk=
X-Google-Smtp-Source: AKy350aLiZCE0feZw6DlWKMzCLfF21TKvmKzdFp7chc6KDbprDjDxzfHhD51bHhHEatAkRX7vdZFqw==
X-Received: by 2002:a2e:6808:0:b0:29a:f63d:d7bf with SMTP id c8-20020a2e6808000000b0029af63dd7bfmr2090330lja.22.1679769029079;
        Sat, 25 Mar 2023 11:30:29 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g21-20020a2e9e55000000b0029f3e2efbb9sm2004490ljk.90.2023.03.25.11.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 11:30:28 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
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
Date:   Sat, 25 Mar 2023 21:30:26 +0300
In-Reply-To: <20230325151100.mskydt3hwbnspqp4@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Sat, 25 Mar 2023 16:11:00
 +0100")
Message-ID: <87edpc65vh.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> Hello,
>
> On Sat, Mar 25, 2023 at 12:31:01PM +0100, Stefan Wahren wrote:
[...]
>
> So the current theory that the issue occurs because of a combination of:
>
>  - With a higher watermark value the irq triggers later and so there is
>    less time the until the ISR must run before an overflow happens; and
>
>  - serial console activity disables irqs for a (relative) long time
>
> right?
>
> So on an UP system the problem should occur also on a non-console
> port?

That's exactly what I've experienced, especially when console baud
rate was lower than that of other port(s). I had console at 115200,
and got immediate problems on another port working at 460800 whenever
relatively lengthy printk output has been emitted (in my case it was
info from wlan driver.)

> Local irqs are only disabled if some printk is about to be emitted,
> isn't it?

Yep, and this allows for easy check if it's indeed printk that causes
this by eliminating the output using

# echo 0 > /proc/sys/kernel/printk

> Does this match the error you're seeing?
>
> That makes me wonder if the error doesn't relate to the UART being a
> console port, but the UART being used without DMA?! (So the patch above
> fixes the problem for you because on the console port no DMA is used?)

Indeed DMA is likely to be able to hide the problem if the cause is
printk, though all my results were obtained on DMA-disabled ports, and I
never checked with DMA enabled, so unfortunately I have no tested
confirmation of this idea.

Best regards,
-- Sergey Organov
