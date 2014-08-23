From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 5/7] ARM: meson: dts: add basic Meson/Meson6/Meson6-atv1200
 DTSI/DTS
Date: Sat, 23 Aug 2014 13:27:55 +0200
Message-ID: <53F87ABB.6060207@suse.de>
References: <1408272594-10814-1-git-send-email-carlo@caione.org> <1408272594-10814-6-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46079 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913AbaHWL2A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Aug 2014 07:28:00 -0400
In-Reply-To: <1408272594-10814-6-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com

Hi,

Am 17.08.2014 12:49, schrieb Carlo Caione:
> The Meson6 SoC is produced by Amlogic inc. and it is based on 2 Corte=
x A9
> and an ARM Mali-400 GPU.
> This patch adds two basic DTSI for the preliminary support of Meson a=
nd
> Meson6 SoCs. Another DTS is also added for supporting the atv1200 boa=
rd,
> produced by Geniatech inc.
>=20
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  arch/arm/boot/dts/Makefile           |  1 +
>  arch/arm/boot/dts/meson.dtsi         | 75 ++++++++++++++++++++++++++=
++++++++++
>  arch/arm/boot/dts/meson6-atv1200.dts | 27 +++++++++++++
>  arch/arm/boot/dts/meson6.dtsi        | 44 +++++++++++++++++++++
>  4 files changed, 147 insertions(+)
>  create mode 100644 arch/arm/boot/dts/meson.dtsi
>  create mode 100644 arch/arm/boot/dts/meson6-atv1200.dts
>  create mode 100644 arch/arm/boot/dts/meson6.dtsi
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b8c5cd3..604acce 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -159,6 +159,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) +=3D kirkwood-b3.dtb =
\
>  	kirkwood-ts419-6282.dtb
>  dtb-$(CONFIG_ARCH_LPC32XX) +=3D ea3250.dtb phy3250.dtb
>  dtb-$(CONFIG_ARCH_MARCO) +=3D marco-evb.dtb
> +dtb-$(CONFIG_MACH_MESON6) +=3D meson6-atv1200.dtb
>  dtb-$(CONFIG_ARCH_MOXART) +=3D moxart-uc7112lx.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D \
>  	imx25-eukrea-mbimxsd25-baseboard.dtb \
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.d=
tsi
> new file mode 100644
> index 0000000..934bb2c
> --- /dev/null
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -0,0 +1,75 @@
> +/*
> + * Copyright 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the
> + * Free Software Foundation; either version 2 of the License, or (at=
 your
> + * option) any later version.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	interrupt-parent =3D <&gic>;
> +
> +	aliases {
> +		serial0 =3D &uart_AO;
> +		serial1 =3D &uart_A;
> +		serial2 =3D &uart_B;
> +		serial3 =3D &uart_C;
> +	};
> +
> +	gic: interrupt-controller@c4301000 {
> +		compatible =3D "arm,cortex-a9-gic";
> +		reg =3D <0xc4301000 0x1000>,
> +		      <0xc4300100 0x0100>;
> +		interrupt-controller;
> +		#interrupt-cells =3D <3>;
> +	};
> +
> +	timer@c1109940 {
> +		compatible =3D "amlogic,meson6-timer";
> +		reg =3D <0xc1109940 0x14>;
> +		interrupts =3D <0 10 1>;
> +	};
> +
> +	soc@c8100000 {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		uart_AO: serial@c81004c0 {
> +			compatible =3D "amlogic,meson-uart";
> +			reg =3D <0xc81004c0 0x14>;
> +			interrupts =3D <0 90 1>;
> +			clocks =3D <&clk81>;
> +			status =3D "disabled";
> +		};
> +
> +		uart_A: serial@c81084c0 {
> +			compatible =3D "amlogic,meson-uart";
> +			reg =3D <0xc81084c0 0x14>;
> +			interrupts =3D <0 90 1>;
> +			clocks =3D <&clk81>;
> +			status =3D "disabled";
> +		};
> +
> +		uart_B: serial@c81084dc {
> +			compatible =3D "amlogic,meson-uart";
> +			reg =3D <0xc81084dc 0x14>;
> +			interrupts =3D <0 90 1>;
> +			clocks =3D <&clk81>;
> +			status =3D "disabled";
> +		};
> +
> +		uart_C: serial@c8108700 {
> +			compatible =3D "amlogic,meson-uart";
> +			reg =3D <0xc8108700 0x14>;
> +			interrupts =3D <0 90 1>;
> +			clocks =3D <&clk81>;
> +			status =3D "disabled";
> +		};
> +	};
> +}; /* end of / */
> +

Trailing blank line.

> diff --git a/arch/arm/boot/dts/meson6-atv1200.dts b/arch/arm/boot/dts=
/meson6-atv1200.dts
> new file mode 100644
> index 0000000..b358402
> --- /dev/null
> +++ b/arch/arm/boot/dts/meson6-atv1200.dts
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the
> + * Free Software Foundation; either version 2 of the License, or (at=
 your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +/include/ "meson6.dtsi"
> +
> +/ {
> +	model =3D "Geniatech ATV1200";
> +	compatible =3D "geniatech,atv1200";
> +
> +	memory {
> +		reg =3D <0x40000000 0x80000000>;
> +	};
> +
> +	soc@c8100000 {
> +		uart_AO: serial@c81004c0 {
> +			status =3D "okay";
> +		};
> +	};
> +}; /* end of / */
> +

Since this is a new SoC, just override the status down here:

&uart_A0 {
	status =3D "okay";
};

That decouples it from how you name the SoC node exactly.

> diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6=
=2Edtsi
> new file mode 100644
> index 0000000..d62add4
> --- /dev/null
> +++ b/arch/arm/boot/dts/meson6.dtsi
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the
> + * Free Software Foundation; either version 2 of the License, or (at=
 your
> + * option) any later version.
> + */
> +
> +/include/ "meson.dtsi"
> +
> +/ {
> +	model =3D "Amlogic Meson6 SoC";
> +	compatible =3D "amlogic,meson6", "amlogic,8726_mx";

In the cover letter you said AML8726-MX - why underscore here?

In 3.17-rc1 at least I don't see the amlogic prefix documented. If so,
you should probably add it to
Documentation/devicetree/bindings/vendor-prefixes.txt. Similarly, shoul=
d
you document some of those amlogic,* compatible strings in a new
=2E../bindings/arm/amlogic.txt file?

Same applies to geniatech further above. checkpatch.pl should warn abou=
t
undocumented compatible strings.

Cf.
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/submitting-patches.txt

> +
> +	interrupt-parent =3D <&gic>;
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu@0 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a9";
> +			reg =3D <0x200>;
> +		};
> +
> +		cpu@1 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a9";
> +			reg =3D <0x1>;
> +		};
> +	};
> +
> +	clocks {
> +		#address-cells =3D <1>;
> +
> +		clk81: clk@0 {
> +			#clock-cells =3D <0>;
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <200000000>;
> +		};
> +	};
> +}; /* end of / */

Cheers,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrn=
berg
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
