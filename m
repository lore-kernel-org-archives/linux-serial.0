Return-Path: <SRS0=ea2O=BO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673AEC433E0
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 12:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5290B208A9
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 12:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHDMi3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:38:29 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:45452 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgHDMiY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Aug 2020 08:38:24 -0400
Received: by mail-oo1-f65.google.com with SMTP id a9so7959088oof.12
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2020 05:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TA5+HHwuIzFlcU2riTr+RNEckYwT0rC0OMjmmi16ILI=;
        b=CfD3DKvdg3H0Fh00Y5jntTdcez338DCC3ot/BTaqzEnCS7edrNz8xFPc1p+Y4HLr3X
         8ahSNFeWA1f+7SG1MqXy93wo8JE4s36g/Z/tSeVUI6Wx3pWVvf7w9Heu0va8dYcKbE/l
         u+2FKGVwDriwqXlYaMMUVvBM47Xpibmwgv0cww2niFJoVjvrTAOMwvNlidtNbsQ9Hhqj
         IqHlCqWA8W1uq7dpJTGZGv1mgl2Im7VdrGMU9uvrq0wNAF1F2zT8VEdd6x6hATYirE7W
         3Cg7tSB30PzNm/zj9q6HrNzdDN2czHU/jP7QYLj/sRawF8EH6FKK5Ja89Ppc4tCIZ40q
         p6Aw==
X-Gm-Message-State: AOAM530VV9j+EISQEsnDdLv7D4wN8WKNup/1Z4p/uZwoz68UXsq5uUcL
        wRIp6ZlJSSXmn0gjTbr/Y78ftSgv9yMK4bxfg9SwsbMD
X-Google-Smtp-Source: ABdhPJyqDRQAdUkatLx6q9K6XgMJk3Rt1Ouqivfv/Czlpai/biwc24O2sHnun8PXE4XrQ4wdsAdqDgcD/HzFtossGxM=
X-Received: by 2002:a4a:275e:: with SMTP id w30mr18424112oow.40.1596544703549;
 Tue, 04 Aug 2020 05:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200724070815.11445-1-fugang.duan@nxp.com> <20200724070815.11445-3-fugang.duan@nxp.com>
In-Reply-To: <20200724070815.11445-3-fugang.duan@nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Aug 2020 14:38:12 +0200
Message-ID: <CAMuHMdUJw1rqzNMUduE0qVO=f1dBuXGMf+vcgkhRkc-x-4TAvg@mail.gmail.com>
Subject: Re: [PATCH tty/serial v3 2/2] tty: serial: imx: add imx earlycon driver
To:     Fugang Duan <fugang.duan@nxp.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Fugan,

On Fri, Jul 24, 2020 at 9:17 AM Fugang Duan <fugang.duan@nxp.com> wrote:
> Split imx earlycon driver from imx serial driver "imx.c" as
> separated driver. imx serial driver can be built as module,
> but earlycon driver only support build in.
>
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>

Thanks for your patch, which is now commit 699cc4dfd14071e4 ("tty: serial:
imx: add imx earlycon driver") in tty-next.

>  drivers/tty/serial/Kconfig        |  8 +++++
>  drivers/tty/serial/imx_earlycon.c | 50 +++++++++++++++++++++++++++++++

Seems like imx_earlycon.c is never built, as no Makefile update is included?
Else this patch is just an obfuscated way to enable SERIAL_EARLYCON
for all OF platforms? ;-)

> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -515,6 +515,14 @@ config SERIAL_IMX_CONSOLE
>           "console=ttymxc0". (Try "man bootparam" or see the documentation of
>           your bootloader about how to pass options to the kernel at boot time.)
>
> +config SERIAL_IMX_EARLYCON
> +       bool "Earlycon on IMX serial port"
> +       depends on OF

Obviously this should depend on "ARCH_MXC || COMPILE_TEST".

> +       select SERIAL_EARLYCON
> +       help
> +         If you have enabled the earlycon on the Freescale IMX
> +         CPU you can make it the earlycon by answering Y to this option.
> +
>  config SERIAL_UARTLITE
>         tristate "Xilinx uartlite serial port support"
>         depends on HAS_IOMEM

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
