Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2572563FAE;
	Tue, 29 Sep 2026 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711221; cv=none; b=nJh1Gno+9AC7/nC+v7t8vadEUtNw0fM45LLf68tpNxdgtLbmmfrHx5STv9gvqKNEgXIZvRHNSMwr9YJSL6ImHw/lcNvlMmizXcXarlLYmLvuv2USekcsiGYged3hrHpPy9qffQIG0nM49TTu2OEud830MGhbcXq3zKxdV+RE1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711221; c=relaxed/simple;
	bh=wH/dwFvDVQbeyUnQoPA8e6l433TlwlBl8onkNJyr0uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG9+BYT0kYD4rG9flBrVoAU+wydVQT+lPgEA/YmIJJkOpO7jseN1w4LUHBgp75/hCecSA9DQbF9jF1oM1hWCUUYWJJKfAU3X7yqYvE6iYuAAPDIP8sQL3TXRleDnPZpwGe1lZ4B/eXCVP2c+74xo0YSGeyx3rP6Vf1lqS0Alxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNvqdL2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNvqdL2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7431F000FF;
	Tue, 29 Sep 2026 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790711219;
	bh=HiNTupmKwpfKkS3g9iNzLPQ0hs/1u+N8ruRyY8+XoYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UNvqdL2cKc38mjozqD7PUzdm+2vHKtkorsESKmgrgCEpz25D0NnjnQ6bRCSrxXhm6
	 LX+QqFM1ozAqGgTyZRQmsKlvvbqD2arvR8UY5GETNP697pWIZBc/foOZv8Wu/7sz/o
	 WFcw24KeL6Eukj2j04hm3LXLRvfq7aUadK5h69KZVbnnEAl3OrNeZzFopAZn/sPP7n
	 Gw4JdWx2m3IF/Gik4j7cBl+5xSoTDmGDWf3Pdt9S4b+garshxpxESKaPhn827aWbm2
	 cE1gDIiGtpIr77KaTgTdV1PAmUGyj3ygB/jvOKKfAQiYyb/rElCCW7/QDShNGOXr5W
	 b9TgTVzGdUxOQ==
Date: Tue, 29 Sep 2026 20:46:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org, mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 15/20] dt-bindings: clock: add Synaptics SL261X clock
Message-ID: <20260929-triage-unpiloted-cf3734477487@spud>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-16-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8PUm9dCOOcXFVem5"
Content-Disposition: inline
In-Reply-To: <20260929061417.20733-16-jszhang@kernel.org>

--8PUm9dCOOcXFVem5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 02:14:12PM +0800, Jisheng Zhang wrote:
> Add support for clocks, plls in Synaptics SL261X SoCs.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/clock/syna,sl261x-clk.yaml       |  92 ++++++++++++
>  include/dt-bindings/clock/syna,sl261x.h       | 131 ++++++++++++++++++
>  2 files changed, 223 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/syna,sl261x-c=
lk.yaml
>  create mode 100644 include/dt-bindings/clock/syna,sl261x.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/syna,sl261x-clk.yaml=
 b/Documentation/devicetree/bindings/clock/syna,sl261x-clk.yaml
> new file mode 100755
> index 000000000000..3fd380c1dd39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/syna,sl261x-clk.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/syna,sl261x-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synaptics SL261x clock controllers
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +description: |
> +  The SL261x clock hardware is divided into SoC, CPU, AIO, and system
> +  manager register blocks. Each clock controller is a child of the node
> +  containing its register range. The CPU clock node has a phandle to the
> +  global chip control syscon.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - syna,sl261x-soc-clk
> +          - syna,sl261x-cpu-clk
> +          - syna,sl261x-aio-clk
> +          - syna,sl261x-system-clk
> +      - items:
> +          - const: simple-mfd
> +          - const: syscon

What's going on here? You're entirely missing specific compatibles for
your syscon nodes (which aren't clock controllers and shouldn't be
defined here.
Similarly to the reset stuff, why can't these just be parts of their
parent nodes?

Thanks,
Conor.

> +
> +  reg:
> +    maxItems: 1
> +
> +  syna,gbl-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the SL261x global chip control syscon.
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: Reference clock used as the input to the PLLs.
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: syna,sl261x-cpu-clk
> +    then:
> +      required:
> +        - syna,gbl-syscon
> +    else:
> +      properties:
> +        syna,gbl-syscon: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    osc: clock-osc {
> +        compatible =3D "fixed-clock";
> +        #clock-cells =3D <0>;
> +        clock-frequency =3D <25000000>;
> +    };
> +
> +    chip: syscon@f7e10000 {
> +        compatible =3D "syscon", "simple-mfd";
> +        reg =3D <0xf7e10000 0x10000>;
> +
> +        clk: clock {
> +            compatible =3D "syna,sl261x-soc-clk";
> +            #clock-cells =3D <1>;
> +            clocks =3D <&osc>;
> +        };
> +    };
> +
> +    cpu_wrap: cpu-wrap@f7e30000 {
> +        compatible =3D "syscon", "simple-mfd";
> +        reg =3D <0xf7e30000 0x4000>;
> +
> +        cpuclk: clock {
> +            compatible =3D "syna,sl261x-cpu-clk";
> +            #clock-cells =3D <1>;
> +            clocks =3D <&osc>;
> +            syna,gbl-syscon =3D <&chip>;
> +        };
> +    };
> +...
> diff --git a/include/dt-bindings/clock/syna,sl261x.h b/include/dt-binding=
s/clock/syna,sl261x.h
> new file mode 100644
> index 000000000000..4649b233f08a
> --- /dev/null
> +++ b/include/dt-bindings/clock/syna,sl261x.h
> @@ -0,0 +1,131 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Synaptics SL261X clock tree IDs
> + *
> + * Copyright (C) 2025 Synaptics Incorporated
> + *
> + * Author: Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/* SoC domain */
> +
> +/* GBL common clks */
> +#define CLK_CPUFASTREF		0
> +#define CLK_MEMFASTREF		1
> +#define CLK_CFG			2
> +#define CLK_SYS			3
> +#define CLK_PERIFSYS		4
> +#define CLK_APBCORE		5
> +#define CLK_APBSER		6
> +#define CLK_ATB			7
> +#define CLK_HPC			8
> +#define CLK_EMMC		9
> +#define CLK_SD0			10
> +#define CLK_SD1			11
> +#define CLK_GETHRGMII		12
> +#define CLK_GETHRGMII1		13
> +#define CLK_GE0_PTP_REF		14
> +#define CLK_GE1_PTP_REF		15
> +#define CLK_USB2TEST		16
> +#define CLK_USB2TEST480MG0	17
> +#define CLK_USB2TEST480MG1	18
> +#define CLK_USB2TEST480MG2	19
> +#define CLK_USB2TEST100MG0	20
> +#define CLK_USB2TEST100MG1	21
> +#define CLK_USB2TEST100MG2	22
> +#define CLK_USB2TEST100MG3	23
> +#define CLK_PERIFTEST125MG0	24
> +#define CLK_PERIFTEST200MG0	25
> +#define CLK_PERIFTEST200MG1	26
> +#define CLK_GPU			27
> +#define CLK_NPU			28
> +#define CLK_AVIOSYS		29
> +#define CLK_AIOSYS		30
> +#define CLK_AVIO_LCDC2SCAN	31
> +#define CLK_AVIO_IPI		32
> +#define CLK_AVIO_P		33
> +#define CLK_AVIO_DPHYRXTXESC	34
> +#define CLK_AVIOFPLL		35
> +#define CLK_AVIO_RX_SCANBYTE	36
> +#define CLK_AVIO_RX_SCANTEST	37
> +
> +/* GBL gate clks */
> +#define CLK_USB0CORE		38
> +#define CLK_SDIOSYS		39
> +#define CLK_EMMCSYS		40
> +#define CLK_GPUAXI		41
> +#define CLK_GETHRGMIISYS	42
> +#define CLK_SDIO1SYS		43
> +#define CLK_USB1CORE		44
> +#define CLK_GETHRGMII1SYS	45
> +#define CLK_USB0PHYREF		46
> +#define CLK_USB1PHYREF		47
> +#define CLK_APBUART0		48
> +#define CLK_APBUART1		49
> +#define CLK_APBUART2		50
> +#define CLK_APBUART3		51
> +#define CLK_APBI2C0		52
> +#define CLK_APBI2C1		53
> +#define CLK_APBSPI0		54
> +#define CLK_APBSPI1		55
> +#define CLK_APBSPI2		56
> +#define CLK_APBSPI3		57
> +#define CLK_APBGPIO		58
> +#define CLK_APBTIMERS		59
> +#define CLK_APBSYSCNT		60
> +#define CLK_APBWDT		61
> +#define CLK_APBDMA		62
> +#define SL261X_CLK_MAX		63
> +
> +/* cpuss */
> +#define CLK_CPU0		0
> +#define CLK_CPU1		1
> +#define CLK_DSU			2
> +#define SL261X_CPU_CLK_MAX	3
> +
> +
> +/* sysmgr domain */
> +
> +#define CLK_CFG_UART0		0
> +#define CLK_SER_UART0		1
> +#define CLK_CFG_UART1		2
> +#define CLK_CFG_UART2		3
> +#define CLK_CFG_UART3		4
> +#define CLK_CFG_GPIO		5
> +#define CLK_CFG_I2CM0		6
> +#define CLK_CFG_I2CM1		7
> +#define CLK_CFG_SPIM		8
> +#define CLK_CFG_SPIS		9
> +#define CLK_CFG_I3C		10
> +#define CLK_CFG_XSPI		11
> +#define CLK_AXI_XSPI		12
> +#define CLK_CFG_PVT		13
> +#define CLK_CFG_ADC		14
> +#define CLK_CFG_PWM		15
> +#define CLK_BUS_CAN0		16
> +#define CLK_BUS_CAN1		17
> +#define CLK_CFG_PDM		18
> +
> +#define CLK_SER_UART1		19
> +#define CLK_SER_UART2		20
> +#define CLK_SER_UART3		21
> +#define CLK_DEB_GPIO		22
> +#define CLK_SER_I2CM0		23
> +#define CLK_SER_I2CM1		24
> +#define CLK_SER_SPIM		25
> +#define CLK_SER_SPIS		26
> +#define CLK_SER_I3C		27
> +#define CLK_SER_XSPI		28
> +#define CLK_HS_PVT		29
> +#define CLK_CORE_ADC		30
> +#define CLK_SER_PWM		31
> +#define CLK_SER_CAN0		32
> +#define CLK_SER_CAN1		33
> +#define CLK_SER_PDM		34
> +#define CLK_REF_CALIB		35
> +
> +#define CLK_MCU_REF		36
> +#define CLK_MCU_PLL		37
> +#define CLK_MCU_IO_PLL		38
> +#define CLK_MCU_APB		39
> +#define CLK_MCU_AXI		40
> --=20
> 2.53.0
>=20

--8PUm9dCOOcXFVem5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarwVrAAKCRB4tDGHoIJi
0lBNAQDZMOYK+Svkt7bavpqwDnNzw0s9RrPE7ghr2xnd802PkwEAz6WsjFxD+d2k
18PAB7WNfoQN2zckLdyXXfOvE+NmmQw=
=A6nB
-----END PGP SIGNATURE-----

--8PUm9dCOOcXFVem5--
