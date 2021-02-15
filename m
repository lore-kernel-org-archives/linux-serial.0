Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C79C433E6
	for <linux-serial@archiver.kernel.org>; Mon, 15 Feb 2021 10:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB49C64E05
	for <linux-serial@archiver.kernel.org>; Mon, 15 Feb 2021 10:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBOK0o (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Feb 2021 05:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhBOK0Y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Feb 2021 05:26:24 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E1AC061756;
        Mon, 15 Feb 2021 02:25:31 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id h67so3986445wmh.1;
        Mon, 15 Feb 2021 02:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xzlWG7IXSmL2eGjXVT7Tn/g8jQeTsF9IX2YIiH3MEIM=;
        b=hvACttY1S+cPUYKTlA5ro5YHH21PVuKzXjJ5EeJNDpTA2qJ85SGAelpFJRIqzCfL18
         48OewTlpOCD/i3GDXX11yxk4QIXFwyAWGCauT+bYacj+A5WYpQOu4ZPN6wdKwJgfb8ls
         w1isD5qF23Roo/p4c1pj+TwZhh8jvDCuCN8tNzdy/rJbAVN46/yp175coouhSnGOwDoB
         KaJ00UQ5aEGPOyz36JPmCIM5Bdn79Us2YhVHSYItlppd4fnJOElwHAR9XcUP3Z2j9D9V
         le2h8a/dGTNgmjmLaXx8GCJPKJJm6jrSrg40FdrDf0+hroKJYLzBT9LkWg39gRdrGLVx
         eEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xzlWG7IXSmL2eGjXVT7Tn/g8jQeTsF9IX2YIiH3MEIM=;
        b=rOJrzXliVjjLkG6OqNOeqcX5S6qP9or/v8Lvw99R0zUmRPu/wGpYaA+P+gjEiEkfFR
         sq0mSb1jylpHoFQCKxlCUXYBNpPuk6H7NSKaLKAzwj6NkK/OFAQv0thQ79tiJVH4YP9e
         uevUSHnbrUie5EbJgMKWkolV+FxmyG72CJ3SCS03xPtFjULmRrGcAGADceWseI019RfR
         e8R/6VdwI9rigtNGwz+5Hkn3PaiyHsFGQv2dyQA1rrddybuddWN039X4TO9x1putlQUv
         On832wJmjnfDPdclwHyds1xpPf9ZKErMkV6vAjpWdbSo4p2IYCG2KmCq9stV0fAYaKye
         fSdA==
X-Gm-Message-State: AOAM533EoAkEMK/Rn7WDhKTczamXapdmYXdbBNSNERAhfLYeaMTdEmU0
        Asj8KUMrH5oPgeuvEbusgtI=
X-Google-Smtp-Source: ABdhPJwFaUJK5TMILw8ZXXUDuIDatLHYVC4Kl8jky0tFiORDMTEK9pwtISp+LaYoCK8JFTY5hJbK5g==
X-Received: by 2002:a1c:8096:: with SMTP id b144mr14114028wmd.169.1613384730299;
        Mon, 15 Feb 2021 02:25:30 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id m13sm4168972wmc.22.2021.02.15.02.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 02:25:29 -0800 (PST)
Date:   Mon, 15 Feb 2021 11:25:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] tty: serial: Add earlycon driver for Tegra Combined UART
Message-ID: <YCpMF7MyJYB8x7Zi@ulmo.localdomain>
References: <20210213115824.3306965-1-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OOpQ8jVg06hQ2UFP"
Content-Disposition: inline
In-Reply-To: <20210213115824.3306965-1-mperttunen@nvidia.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--OOpQ8jVg06hQ2UFP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 13, 2021 at 01:58:24PM +0200, Mikko Perttunen wrote:
> Add an earlycon driver for platforms with TCU, namely Tegra194.
> The driver is compatible with boot parameters passed by NVIDIA
> boot chains.

I'm not sure I understand the latter part of this description. What boot
parameters is this compatible with? Looking at the setup function there
doesn't seem to be anything out of the ordinary here, so I'm wondering
if that's just confusing. If there's anything special, it might be worth
specifically pointing out what that is. Perhaps both in the commit
message and in a code comment, so it's properly documented.

>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/tty/serial/Kconfig              | 12 +++++
>  drivers/tty/serial/Makefile             |  1 +
>  drivers/tty/serial/tegra-tcu-earlycon.c | 72 +++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 drivers/tty/serial/tegra-tcu-earlycon.c
>=20
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 34a2899e69c0..d941785e3f46 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -331,6 +331,18 @@ config SERIAL_TEGRA_TCU_CONSOLE
> =20
>  	  If unsure, say Y.
> =20
> +config SERIAL_TEGRA_TCU_EARLYCON
> +	bool "Earlycon on NVIDIA Tegra Combined UART"
> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	select SERIAL_EARLYCON
> +	select SERIAL_CORE_CONSOLE
> +	default y if SERIAL_TEGRA_TCU_CONSOLE
> +	help
> +	  If you say Y here, TCU output will be supported during the earlycon
> +	  phase of the boot.
> +
> +	  If unsure, say Y.
> +
>  config SERIAL_MAX3100
>  	tristate "MAX3100 support"
>  	depends on SPI
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index b85d53f9e9ff..408144326fed 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_SERIAL_XILINX_PS_UART) +=3D xilinx_uartps.o
>  obj-$(CONFIG_SERIAL_SIRFSOC) +=3D sirfsoc_uart.o
>  obj-$(CONFIG_SERIAL_TEGRA) +=3D serial-tegra.o
>  obj-$(CONFIG_SERIAL_TEGRA_TCU) +=3D tegra-tcu.o
> +obj-$(CONFIG_SERIAL_TEGRA_TCU_EARLYCON) +=3D tegra-tcu-earlycon.o
>  obj-$(CONFIG_SERIAL_AR933X)   +=3D ar933x_uart.o
>  obj-$(CONFIG_SERIAL_EFM32_UART) +=3D efm32-uart.o
>  obj-$(CONFIG_SERIAL_ARC)	+=3D arc_uart.o
> diff --git a/drivers/tty/serial/tegra-tcu-earlycon.c b/drivers/tty/serial=
/tegra-tcu-earlycon.c
> new file mode 100644
> index 000000000000..9decfbced0a7
> --- /dev/null
> +++ b/drivers/tty/serial/tegra-tcu-earlycon.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017-2021, NVIDIA CORPORATION.  All rights reserved.
> + */
> +
> +#include <linux/console.h>
> +#include <linux/io.h>
> +#include <linux/serial_core.h>
> +
> +#define NUM_BYTES_FIELD_BIT	24
> +#define FLUSH_BIT		26

This one seems to be unused.

> +#define INTR_TRIGGER_BIT	31

I wonder if this could somehow be integrated with the existing TCU
driver since we have these bits defined there already. And really this
is basically a skeleton version of the same driver.

> +/*
> + * This function splits the string to be printed (const char *s) into mu=
ltiple
> + * packets. Each packet contains a max of 3 characters. Packets are sent=
 to the
> + * SPE-based combined UART server for printing. Communication with SPE i=
s done
> + * through mailbox registers which can generate interrupts for SPE.
> + */
> +static void early_tcu_write(struct console *console, const char *s, unsi=
gned int count)
> +{
> +	struct earlycon_device *device =3D console->data;
> +	u8 __iomem *addr =3D device->port.membase;
> +	u32 mbox_val =3D BIT(INTR_TRIGGER_BIT);
> +	unsigned int i;
> +
> +	/* Loop for processing each 3 char packet */
> +	for (i =3D 0; i < count; i++) {
> +		if (s[i] =3D=3D '\n')
> +			mbox_val =3D update_and_send_mbox(addr, mbox_val, '\r');
> +		mbox_val =3D update_and_send_mbox(addr, mbox_val, s[i]);
> +	}
> +
> +	if ((mbox_val >> NUM_BYTES_FIELD_BIT) & 0x3) {
> +		while (readl(addr) & BIT(INTR_TRIGGER_BIT))
> +			cpu_relax();
> +		writel(mbox_val, addr);
> +	}
> +}

For example this function already exists in the Tegra TCU driver and
perhaps some of that could be refactored to work for both cases.

Thierry

--OOpQ8jVg06hQ2UFP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAqTBQACgkQ3SOs138+
s6H4hRAAgbEdLV0psQGZMIiBU/x5LxPg/2BQ+QQMvTvcs7hqenf5Y6GyvVSko+7X
Uz8Yo432ivikJsmvKcKQ00ObA23XxUvc1lnYj8cpw+G5bQtp2HaINWvoUOfzgOJy
G1UtFD7pG/jIUXt5eng037qnIjhsmB9nUsJcyChqv3Ipd1UjsMGo1c2u46FD/SKW
xzLgaj5iyHC5xwq/1Z8TogKezUGVtEaYkKM2n9/5qwUoJRSjfwYg6e2O/05mg71M
kOi8jX0r7bT6IetzQBd5geS/fswFUVGX53W5TiZpR6PXe0O7aBdxdKCl0hb3yVz3
j31N1rgGCAtxZF00PGmSnfZkmwQsDV6pl/8HCN9rWZVF725/WSPiP1CW4onN6KYg
aGImRqJBbhAa8D1zBydFS/BpCfIjRSwBr7NaD9TQPe+QpxbayiXm+iosnkh3XLLc
VkoX3Fe5dWDbn613g3280WmSWsJ8Ja6SaaHekX/3Fec+cvWfzy8StQ62qF6rd5aK
WBQThSG98qZjqgdXCj9XylMx3Dw3z7eFU7wV+qRJg3whZ52nWtuRh0XwK9PxsmRm
40u0LYtRHcMUqKOjfZtBg2f3foumJTrZIZZ7o5rfo81414lsOCk057QiQRx1pGMy
i9B56j2KBImUecor+VM6hdl3bgx3zf4W1Pi3DSYG1dSWBcJaD9Y=
=mBE7
-----END PGP SIGNATURE-----

--OOpQ8jVg06hQ2UFP--
