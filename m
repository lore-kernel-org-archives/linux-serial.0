From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 4/7] ARM: meson: add basic support for MesonX SoCs
Date: Sun, 17 Aug 2014 16:21:15 +0200
Message-ID: <20140817142115.GB15297@lukather>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-5-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+5G7L20VUoXZHCOn"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48686 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751575AbaHQTFm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Aug 2014 15:05:42 -0400
Content-Disposition: inline
In-Reply-To: <1408272594-10814-5-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com


--+5G7L20VUoXZHCOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Sun, Aug 17, 2014 at 12:49:51PM +0200, Carlo Caione wrote:
> Signed-off-by: Carlo Caione <carlo@caione.org>

A commit log would be nice

> ---
>  arch/arm/Kconfig             |  2 ++
>  arch/arm/Makefile            |  1 +
>  arch/arm/mach-meson/Kconfig  | 13 +++++++++++++
>  arch/arm/mach-meson/Makefile |  1 +
>  arch/arm/mach-meson/meson.c  | 36 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 53 insertions(+)
>  create mode 100644 arch/arm/mach-meson/Kconfig
>  create mode 100644 arch/arm/mach-meson/Makefile
>  create mode 100644 arch/arm/mach-meson/meson.c
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c49a775..cc52a8f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -888,6 +888,8 @@ source "arch/arm/mach-keystone/Kconfig"
> =20
>  source "arch/arm/mach-ks8695/Kconfig"
> =20
> +source "arch/arm/mach-meson/Kconfig"
> +
>  source "arch/arm/mach-msm/Kconfig"
> =20
>  source "arch/arm/mach-moxart/Kconfig"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 0ce9d0f..320aa57 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -168,6 +168,7 @@ machine-$(CONFIG_ARCH_IXP4XX)		+=3D ixp4xx
>  machine-$(CONFIG_ARCH_KEYSTONE)		+=3D keystone
>  machine-$(CONFIG_ARCH_KS8695)		+=3D ks8695
>  machine-$(CONFIG_ARCH_LPC32XX)		+=3D lpc32xx
> +machine-$(CONFIG_ARCH_MESON)		+=3D meson
>  machine-$(CONFIG_ARCH_MMP)		+=3D mmp
>  machine-$(CONFIG_ARCH_MOXART)		+=3D moxart
>  machine-$(CONFIG_ARCH_MSM)		+=3D msm
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> new file mode 100644
> index 0000000..2c1154e
> --- /dev/null
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -0,0 +1,13 @@
> +menuconfig ARCH_MESON
> +	bool "Amlogic Meson SoCs" if ARCH_MULTI_V7
> +	select GENERIC_IRQ_CHIP
> +	select ARM_GIC
> +
> +if ARCH_MESON
> +
> +config MACH_MESON6
> +	bool "Amlogic Meson6 (8726MX) SoCs support"
> +	default ARCH_MESON
> +	select MESON6_TIMER
> +
> +endif
> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
> new file mode 100644
> index 0000000..9d7380e
> --- /dev/null
> +++ b/arch/arm/mach-meson/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ARCH_MESON) +=3D meson.o
> diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
> new file mode 100644
> index 0000000..4528312
> --- /dev/null
> +++ b/arch/arm/mach-meson/meson.c
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright (C) 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + */
> +
> +#include <linux/of_platform.h>
> +#include <asm/mach/arch.h>
> +
> +static __init void meson_init_machine_devicetree(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

This is the default, you can just remove it

> +
> +static const char * const m6_common_board_compat[] =3D {
> +	"amlogic,8726_mx",
> +	"amlogic,8726_mxs",
> +	"amlogic,8726_mxl",
> +	"amlogic,meson6",

Why are all those compatibles needed? Usually, you add a single one
per SoC (which would be the last in your case I guess.

> +	NULL,
> +};
> +
> +DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
> +	.init_machine	=3D meson_init_machine_devicetree,

And since you don't need the init machine, you can just use the
generic machine support. I'm not sure what's been decided on this,
should we remove such empty machines?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--+5G7L20VUoXZHCOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT8LpbAAoJEBx+YmzsjxAgoZgP/iBAlbM3o7KPTrZPTCErtkD3
oPjcd5NlZNjsX4nHuJeoBHFCngClRLs7A2jJXSMkuKXq3U9eWsUIh2qPbNgamzYG
3FeIK9XdT0FFRFBv6gA1tfTHpkv3Z4RYdzwZ2j72MrQL14VpHe9mw+N2DEM3w92Z
8emAIOQgmSOEtQ9hvKYgbQisSfHJZwh0h7hjTIkaUz03p2Bqcs7YMwFXDIUYwA+8
4BgI10mf5xPeGlSoKsvo/p+cE1/kJi37fnOcJRsJ7+V4kXgCrZmj6z5hJD6LsWaI
VAAP5PDDG6Y+DBcA36qX7LACsTuW9GRCdMAbNaKAjLKVAk6RONisim5QrDCTa///
SoUaKmUNHsoE3tc7zfXuhdmKEgdnLSSaPdRicwaAJrFhW12SNcwBsJcmf6/go/b8
ZE2jfZvFGyyUtfsuZ11+dzXQISGytXJO+igfOrqio7mAI8MfS65lr3nNsEsihWjX
IfrYQqDpgJqn1091XsLZ8y2Bkw4cXkHgGnA2TcO5FqI4kowyWAOfDRdX0/1ao9tc
JqIjctSSBvKFkX2xvjY6QtZTbWniaayMoarDP1zK5lF7MF+AHtORmzQ6hOQioviv
J9bMTlkSDr9CTmNua1HJ7NgUsfV/MI7Gdi9SNRFRHKA8iViABSN7YlDfEpkniQ1P
HIOarXQIJlhcMk9apeUv
=QagS
-----END PGP SIGNATURE-----

--+5G7L20VUoXZHCOn--
