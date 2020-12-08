Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A7EC4361B
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 10:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD5623AA9
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 10:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgLHKrz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:47:55 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:42832 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgLHKrz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Dec 2020 05:47:55 -0500
Received: by mail-oo1-f68.google.com with SMTP id x203so20131ooa.9
        for <linux-serial@vger.kernel.org>; Tue, 08 Dec 2020 02:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=70c3UheYz7e/JpRrObEHC9XVHOuSXOaln1TlziBfzLo=;
        b=ih7ccREktt8sU7A/lTfZ3a3jaa1dtF7JNV+IY/GRHAXiQ8OXq1Cu5X5e5aRMIFIT5w
         FbtlXPvknyffMRXueY7eYDjHyby7FUTNtaNJ7BVDM+G0cWi4Yh1hwz50u+CxxLJ0ju7o
         cOZlk7hwfKBWGob+mfgu4aSfO2gjx9BcDCWfFTLTeazyo+zygqqh0ZGT2tIBIIVBpJCu
         xMtO/g6ddHHOWdxarbU+bFtx3du4j3U5rg0+2YNJ25WHn33HEWarcC4iXzCVL0DjMTPt
         dJVgRCU4P5exx4Ak1Ehngs3J5BSan6U7TV59nAr+s7GFQOC03l7/mvH0P7R4AjFwf93T
         YIAg==
X-Gm-Message-State: AOAM530iMyyVfsuujpaKf7wltLS5VJGdE96D52B3XNZ4C89O+pZCiAtY
        Z4k2GzLYkpfyi7T0TWSSpol1yC6SPf94416hZjU=
X-Google-Smtp-Source: ABdhPJxNJ/SGZjyaf38+lOivJ1oA++Bcy9PILqrKNMI3/yDItVyy1R3OvagiCKhfol4IuLiH0pnBo+vxmqeADynqB3s=
X-Received: by 2002:a4a:dc1:: with SMTP id 184mr15810864oob.40.1607424434125;
 Tue, 08 Dec 2020 02:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20201125081352.25409-1-zajec5@gmail.com> <20201125090608.28442-1-zajec5@gmail.com>
In-Reply-To: <20201125090608.28442-1-zajec5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Dec 2020 11:47:03 +0100
Message-ID: <CAMuHMdUGNk2U-o5omSW-tOE3HeAUz62ir+vYFUei0o5Vu4cs_g@mail.gmail.com>
Subject: Re: [PATCH V2] tty: serial: bcm63xx: lower driver dependencies
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 25, 2020 at 10:08 AM Rafał Miłecki <zajec5@gmail.com> wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
>
> Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
> is ARM64. In future more architectures may need it as well. There is
> nothing arch specific breaking compilation so just stick to requiring
> COMMON_CLK.
>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
> V2: Just drop all ARCH_* dependencies. Thanks Greg!

Greg, please stop suggesting to make the user's life harder.

> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1133,7 +1133,7 @@ config SERIAL_TIMBERDALE
>  config SERIAL_BCM63XX
>         tristate "Broadcom BCM63xx/BCM33xx UART support"
>         select SERIAL_CORE
> -       depends on MIPS || ARM || COMPILE_TEST
> +       depends on COMMON_CLK
>         help
>           This enables the driver for the onchip UART core found on
>           the following chipsets:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
