Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C20CC4332F
	for <linux-serial@archiver.kernel.org>; Fri, 16 Dec 2022 17:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiLPRIL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Dec 2022 12:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiLPRIJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Dec 2022 12:08:09 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BD56C725
        for <linux-serial@vger.kernel.org>; Fri, 16 Dec 2022 09:08:07 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id s10so2841069ljg.1
        for <linux-serial@vger.kernel.org>; Fri, 16 Dec 2022 09:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=teEFEW/rtVkVgcoh3M9xl3xcNwVdDZW27foUY/evSyc=;
        b=Q/fxSL+SE0Z6Wa4YG3M+mKYuu3ZZj6+hkcRE6E8CawLZBNnWn+xmJB+Ok0/+g/HOpg
         528zSTnfTBat2iGXyf3IpVSUDzyGBjnXQXePTF53uRrwASLU24Qr9e7aVG4s2CyBnsq+
         WL9b2z1KzLoa4NzWIstVlGVABcKdsaKQW4fmMWGHy7AigXz1MxrRFHF0YMCEqyd2TID7
         kMk7LbCt7QXyQZafN/kPwbL83wD9HxGoG2ds2yoSDnFl6El+Ljxc6yJopDBePCy6wPNN
         u6B2nYwEfkw1UkUEJPusNf9emygx9SJH3EbvmeG+mAtnmThpa1NgtFB0VmuW5X+n9ML6
         sPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teEFEW/rtVkVgcoh3M9xl3xcNwVdDZW27foUY/evSyc=;
        b=g59wff3MYZxB8fQn9TODh3yEBpa2h2S35VjCPZyrw6p7eJLB/rE8eSKjjkTYRW7Ek5
         bjR5Rf83wFDX3hL1CIBjBUqY+3VX7lL9nyHfdxF1UM5i4IU1UwQnZOdFx3FH8sceVbZx
         TM3f5pIbG1uR6gkPw0J6fyNFaLoVwDIh5vkeaMae+jPK7Ltz4WTZ7KyWiYlXNjJcBr4n
         w4j5nrFejNMBftQfT8XdJFWEmdv4R7X9nKmLdQrmVSi7ETMuGCWtNlXuDczQGgCbcqd2
         Fdg386Q4JfDF1SpZOYyu5GYvkjwMn/spbf/7r7PRdOVgNmInEXveCNUX1klVb6Rt175S
         MioQ==
X-Gm-Message-State: ANoB5pmbzBeYmzq14PiR2sRpdyztyb9lmTlskodW2MVxAVS65JDtpExy
        kkz2taq7fMayCS5M9kJn7L8=
X-Google-Smtp-Source: AA0mqf70vjCU5Mi2tC3Og84zjBI7pK5OdGOUpF0AJ74KoGbBFES34jDTn5foY71lgiLkjDZPqShB1w==
X-Received: by 2002:a05:651c:24b:b0:279:be20:c72d with SMTP id x11-20020a05651c024b00b00279be20c72dmr8212761ljn.10.1671210485952;
        Fri, 16 Dec 2022 09:08:05 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h27-20020a2eb0fb000000b00279cbcfd7dbsm196308ljl.30.2022.12.16.09.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:08:05 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        =?utf-8?Q?Tomasz_Mo=C5=84_=3Ctomasz=2Emon=40c?=
         =?utf-8?Q?amlingroup=2Ecom=3E?= 
        <k.drobinski@camlintechnologies.com>
Subject: Re: serial: imx: sudden rx flood: hardware bug?
References: <87bko4e65y.fsf@osv.gnss.ru>
        <CAOMZO5DFth_0wzBb8HHeHoNGkT1rexb7xvakvfiNgdY=cHJSfg@mail.gmail.com>
Date:   Fri, 16 Dec 2022 20:08:04 +0300
In-Reply-To: <CAOMZO5DFth_0wzBb8HHeHoNGkT1rexb7xvakvfiNgdY=cHJSfg@mail.gmail.com>
        (Fabio Estevam's message of "Thu, 15 Dec 2022 18:38:58 -0300")
Message-ID: <87k02ruvij.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Fabio,

Fabio Estevam <festevam@gmail.com> writes:

> Hi Sergey,
>
> On Thu, Dec 15, 2022 at 5:57 PM Sergey Organov <sorganov@gmail.com> wrote:
>
>> An effective method to reproduce the issue is to send isolated start bit
>> at baud rate that is about 2.4 times higher than the one configured on
>> the iMX UART while corresponding TTY is open on iMX. At these
>> conditions the problem appears with about 90% probability, i.e., about 9
>> out of 10 "sent" 0xff chars provoke continuous "receiving" of 0xff
>> chars by the UART, at intervals corresponding to the UART baud rate,
>
> I recall seeing this storm of receiving 0xff  before.
>
> I fixed it a long time ago with the following commit:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.1&id=b38cb7d2571197b56cefae8967f9db15c9361113

This patch looks correct to me, and it's there in my version as well.

> Looking at the current code, I see that the UCR3_ADNIMP bit is only
> set conditionally.

I don't see how it is relevant, as the bit is set on both ways of
corresponding condition, i.e., correctly set anyway.

>
> Could you try the change below?

This change looks wrong though, as the bit is now first set, and then is
cleared afterwards, see below.

Anyway, I checked that UCR3_ADNIMP bit is set in UCR3 register when the
problem appears in my case. Overall, I figure the problem is still there
even if UCR3_ADNIMP is set, and is only more difficult to reproduce.

>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 757825edb0cd..997681ec354f 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2399,6 +2399,12 @@ static int imx_uart_probe(struct platform_device *pdev)
>                 imx_uart_writel(sport, ucr2, UCR2);
>         }
>
> +       if (!imx_uart_is_imx1(sport)) {
> +               u32 ucr3 = imx_uart_readl(sport, UCR3);
> +               ucr3 |= UCR3_ADNIMP;
> +               imx_uart_writel(sport, ucr2, UCR3);
> +       }
> +

Here we set the bit in UCR3.

>         if (!imx_uart_is_imx1(sport) && sport->dte_mode) {
>                 /*
>                  * The DCEDTE bit changes the direction of DSR, DCD, DTR and RI
> @@ -2416,8 +2422,7 @@ static int imx_uart_probe(struct platform_device *pdev)
>                  * (confirmed on i.MX25) which makes them unusable.
>                  */
>                 imx_uart_writel(sport,
> -                               IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP | UCR3_DSR,
> -                               UCR3);
> +                               IMX21_UCR3_RXDMUXSEL | UCR3_DSR, UCR3);

And here it's now cleared.

>
>         } else {
>                 u32 ucr3 = UCR3_DSR;
> @@ -2426,7 +2431,7 @@ static int imx_uart_probe(struct platform_device *pdev)
>                         imx_uart_writel(sport, ufcr & ~UFCR_DCEDTE, UFCR);
>
>                 if (!imx_uart_is_imx1(sport))
> -                       ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP;
> +                       ucr3 |= IMX21_UCR3_RXDMUXSEL;
>                 imx_uart_writel(sport, ucr3, UCR3);

And here it's cleared as well, as we don't read-modify-write UCR3 here.

Thanks,
-- Sergey Organov
