Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D39253340;
	Fri,  2 Oct 2026 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956526; cv=none; b=EpmU0MP0lTIRU1BCSfhfzHczPu84Ly6uOR32Y8zzf8F6BXwH2jruS2eMitOWzjKfWIYka9hkbeGPww9aDYDq+2HDyCWOyXkN0OoCEpTNr9jD7bUdqw5JRk8IniUptgu21fxHZnOLKQa8b+emYMYo1bnMbxsB/D0rBJhfLGiAhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956526; c=relaxed/simple;
	bh=KH1UWl5VeB6hAgaMlflVxWfiK3gRO3gxjWFR2LGVmBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srA6UN8KTK/LBBo3QKAHScRQHYw8EG9oBz/nX58gTFn9l1dYQPofKb2bMU2pPWnwAOGTyL/72BDNsu4/SM7gxEKFskgtH8JqPUZSe9jzuJgZ68DehP6d122I0DI+CuVl4GK3Sna5SbA30IMC5kUknGc9Qm9fcQneJaxHUbAjH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qs/IrjqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qs/IrjqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEBB1F000FF;
	Fri,  2 Oct 2026 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790956524;
	bh=2ng9SKCBg1G/ma+Mp8f8fqCiS/P7/Xy23pBv8pxKv/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qs/IrjqB1Fc4QXRM78/IxqxrbUDRfXuKWx4/HkQc/Qf2RPMIY8kQ36WSK9afD395N
	 ZTZ8FsvQ7uXl39Z7acfyIsMBim0yT+UDCv2ZKGTymhY3dXOe738+yuDCuxGXEx2nB0
	 RTX8MgDZPm5lAvR9zGa3Tj/+rqrJKQxwh/cYF9aJBCy3MhG9oE7ifiiXMBBlIzBSa+
	 4m6Hung47p0R1viXVIc01IsbDmq9PB8dGndCgFnROC3NdQ+7VbKkC8GaNBZ5rEV4nd
	 +oWMBTMAq0Me/VNlktgtU/NTES73bNqhghGgjbDbmCO/CEOmqqr8+SecjlnKKx+RL/
	 ri+Vw89AUx1MA==
Date: Fri, 2 Oct 2026 23:35:23 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>
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
Subject: Re: [PATCH 08/20] dt-bindings: reset: add Synaptics SL261X SoCs
Message-ID: <ar_POzPRppAwK7ui@xhacker>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-9-jszhang@kernel.org>
 <20260929-sprang-stir-af07a907ccb2@spud>
 <ar0npPCHX1P5Gjzx@xhacker>
 <20260930-legend-helium-ca5a0ff56709@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930-legend-helium-ca5a0ff56709@spud>

On Wed, Sep 30, 2026 at 05:49:18PM +0100, Conor Dooley wrote:
> On Wed, Sep 30, 2026 at 11:15:48PM +0800, Jisheng Zhang wrote:
> > On Tue, Sep 29, 2026 at 08:44:13PM +0100, Conor Dooley wrote:
> > > On Tue, Sep 29, 2026 at 02:14:05PM +0800, Jisheng Zhang wrote:
> > > > Add device tree bindings for the resets on Synaptics SL261X SoCs.
> > > > 
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > ---
> > > >  .../bindings/reset/syna,sl261x-reset.yaml     | 40 ++++++++++
> > > >  include/dt-bindings/reset/syna,sl261x-reset.h | 80 +++++++++++++++++++
> > > >  2 files changed, 120 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/reset/syna,sl261x-reset.yaml
> > > >  create mode 100644 include/dt-bindings/reset/syna,sl261x-reset.h
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/reset/syna,sl261x-reset.yaml b/Documentation/devicetree/bindings/reset/syna,sl261x-reset.yaml
> > > > new file mode 100644
> > > > index 000000000000..8cfec17df800
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/reset/syna,sl261x-reset.yaml
> > > > @@ -0,0 +1,40 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +# Copyright (C) 2026 Synaptics Incorporated
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/reset/syna,sl261x-reset.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Synaptics SL261X reset controller
> > > > +
> > > > +maintainers:
> > > > +  - Jisheng Zhang <jszhang@kernel.org>
> > > > +
> > > > +description: The reset controller node must be a sub-node of the chip
> > > > +  controller node on SL261X SoCs.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - syna,sl261x-soc-reset
> > > > +      - syna,sl261x-system-reset
> > > > +
> > > > +  "#reset-cells":
> > > > +    const: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - "#reset-cells"
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    chip: chip-control@f7e10000 {
> > > > +        reg = <0xf7e10000 0x1000>;
> > > > +
> > > > +        chip_rst: reset {
> > > > +            compatible = "syna,sl261x-soc-reset";
> > > > +            #reset-cells = <1>;
> > > > +        };
> > > 
> > > Why can't this just be part of the parent node?
> > 
> > Good question! IMHO, the reasons are:
> > 
> > 1. the so called Gbls(Gbl means global) such as mcuGbl and
> > chip control Gbl contain not only reset, pinctrl and clk/plls
> > but also some other registers for different purposes, e.g in the
> > chip control gbl, there are some registers to control eth phy sel(RMII
> > or RGMII), and TXC 90 degree selection etc. These registers will
> > be used by the Ethernet driver;
> > 
> > While there's no pinctrl regs in avioGbl and vppGbl. In the vppgbl,
> > there are some registers for DPHYTX etc.
> > 
> > As can been, in different Gbls, there maybe different purposes registers, no
> > obvious patterns.
> > 
> > So the question here is why not split the gbl into different register
> > spaces, and abstract each space for each function group?
> 
> No, you misunderstood. I'm not asking for the register space to be
> split, I am asking why you cannot do
> | syscon@f7e1000 {
> | 	compatible = "syna,sl2610-soc-syscon", "syscon";
> | 	reg = <0xf7e10000 0x1000>;
> | 	#clock-cells = <1>;
> | 	#reset-cells = <1>;
> | };
> With this kind of thing, you can either use the auxiliary bus or
> MFD_CELL_NAME() to create the other devices. The latter is good if
> you've got a region with clocks that also has resets thrown in, the
> former is probably better if you have a syscon with a genuine
> assortment of different functions that you're going to be looking up via
> phandle.

I see your points now. But there are two problems with this solution:

1. Besides reset, pinctrl and clk, the so called "Gbl" also contains
registers for other purpose, e.g DPHYTX, when we need the driver for
DPHYTX, I assume I could also go with the auxiliary bus or MFD_CELL_NAME(),

2. where should the driver(s) and dt-bindings doc be put?
I assume drivers/soc/synaptics/ and
Documentation/devicetree/bindings/soc/synaptics?

Kindly correct me if I misunderstood something.

Thanks
> 
> > Two blocking
> > points make this impossible and ugly: different reg space may not be
> > aligned at 4KB boundary, e.g reset: 0x350 ~ 0x37c; eth phy sel:0xa18;
> > some registers which belong to similar functionality, e.g clks, may not be
> > adjacent.
> 
> This sort of thing, with non-adjacent clocks is still possible, you have
> a regmap just like before.
> 
> > So the best way is to abstract these GBLs via. "syscon", "simple-mfd", and
> > put necessary subnodes such as reset, pinctrl and clks under the GBL
> > node. If the registers in GBL is misc control, pass the syscon phandle
> > to the main driver, e.g I planed to pass the syscon phandle to GMAC
> > driver to control the RMII/RGMII selection.
> 
> And you can get the regmap from other drivers by doing phandle or
> compatible based lookups just like before.
> 
> > 
> > 2.follow current bg2 and bg2q style
> > e.g arch/arm/boot/dts/synaptics/berlin2q.dtsi
> > 
> > IMHO, why bg2 and bg2q dtsi files are implemented as current
> > style is due to the above point 1.
> 
> Unfortunately, this is the berlin2q devicetree showing its age, we've
> been pushing people away from nodes that exist just to probe a driver
> and don't provide any additional value. Something like
> | chip-control@f7e10000 {
> |     reg = <0xf7e10000 0x1000>;
> | 
> |     chip_rst: reset {
> |         compatible = "syna,sl261x-soc-reset";
> |         #reset-cells = <1>;
> |     };
> | 
> |     chip_clk: clock {
> |         compatible = "syna,sl261x-soc-clock";
> |         #clock-cells = <1>;
> |     };
> is exactly the pattern we are trying to avoid.
> 
> Cheers,
> Conor.
> 
> > 
> > Kindly let me know if there's a better solution.
> > 
> > > From a quick check of the dts, the node with this subnode didn't also
> > > have a system-reset node too, so there's no conflict or anything of that
> > > nature.
> > > 
> > > > +    };
> > > > diff --git a/include/dt-bindings/reset/syna,sl261x-reset.h b/include/dt-bindings/reset/syna,sl261x-reset.h
> > > > new file mode 100644
> > > > index 000000000000..7034f58aae5b
> > > > --- /dev/null
> > > > +++ b/include/dt-bindings/reset/syna,sl261x-reset.h
> > > > @@ -0,0 +1,80 @@
> > > > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > > > +/*
> > > > + * Copyright (C) 2026 Synaptics Incorporated
> > > > + *
> > > > + * Author: Jisheng Zhang <jszhang@kernel.org>
> > > > + */
> > > > +
> > > > +#ifndef _DT_BINDINGS_SL261X_RESET_H
> > > > +#define _DT_BINDINGS_SL261X_RESET_H
> > > > +
> > > > +/* ACPU subsystem */
> > > > +#define RST_SOC_SDIO0		0
> > > > +#define RST_SOC_USB0		1
> > > > +#define RST_SOC_EMMC		2
> > > > +#define RST_SOC_GETH0		3
> > > > +#define RST_SOC_SDIO1		4
> > > > +#define RST_SOC_USB1		5
> > > > +#define RST_SOC_GETH1		6
> > > > +#define RST_SOC_USB0PHY		7
> > > > +#define RST_SOC_USB0CORE	8
> > > > +#define RST_SOC_USB0MAHB	9
> > > > +#define RST_SOC_USB1PHY		10
> > > > +#define RST_SOC_USB1CORE	11
> > > > +#define RST_SOC_USB1MAHB	12
> > > > +#define RST_SOC_UART0		13
> > > > +#define RST_SOC_UART1		14
> > > > +#define RST_SOC_UART2		15
> > > > +#define RST_SOC_UART3		16
> > > > +#define RST_SOC_I2C0		17
> > > > +#define RST_SOC_I2C1		18
> > > > +#define RST_SOC_SPI0		19
> > > > +#define RST_SOC_SPI1		20
> > > > +#define RST_SOC_SPI2		21
> > > > +#define RST_SOC_SPI3		22
> > > > +#define RST_SOC_APBTIMERS	23
> > > > +#define RST_SOC_APBSYSCNT	24
> > > > +#define RST_SOC_APBWDT		25
> > > > +#define RST_SOC_APBGPIO		26
> > > > +#define RST_SOC_APBDMA		27
> > > > +#define RST_SOC_GPUCORE		28
> > > > +#define RST_SOC_NPUCORE		29
> > > > +#define RST_SOC_AVIOAIOG	30
> > > > +#define RST_SOC_AVIOVPPG	31
> > > > +#define RST_SOC_AVIOVIPG	32
> > > > +
> > > > +/* system subsystem */
> > > > +#define RST_SM_ADCCORE		0
> > > > +#define RST_SM_ADCPRST		1
> > > > +#define RST_SM_CAN0PRST		2
> > > > +#define RST_SM_CAN0SRST		3
> > > > +#define RST_SM_CAN1PRST		4
> > > > +#define RST_SM_CAN1SRST		5
> > > > +#define RST_SM_GPIOPRST		6
> > > > +#define RST_SM_GPIOSRST		7
> > > > +#define RST_SM_I2CM0PRST	8
> > > > +#define RST_SM_I2CM0SRST	9
> > > > +#define RST_SM_I2CM1PRST	10
> > > > +#define RST_SM_I2CM1SRST	11
> > > > +#define RST_SM_I3CPRST		12
> > > > +#define RST_SM_I3CSRST		13
> > > > +#define RST_SM_PDMPRST		14
> > > > +#define RST_SM_PDMSRST		15
> > > > +#define RST_SM_PVTHSRST		16
> > > > +#define RST_SM_PVTPRST		17
> > > > +#define RST_SM_PWMPERIRST	18
> > > > +#define RST_SM_PWMPRST		19
> > > > +#define RST_SM_SPIMPRST		20
> > > > +#define RST_SM_SPIMSRST		21
> > > > +#define RST_SM_SPISPRST		22
> > > > +#define RST_SM_SPISSRST		23
> > > > +#define RST_SM_UART0PRST	24
> > > > +#define RST_SM_UART0SRST	25
> > > > +#define RST_SM_UART1PRST	26
> > > > +#define RST_SM_UART1SRST	27
> > > > +#define RST_SM_UART2PRST	28
> > > > +#define RST_SM_UART2SRST	29
> > > > +#define RST_SM_UART3PRST	30
> > > > +#define RST_SM_UART3SRST	31
> > > > +
> > > > +#endif /* _DT_BINDINGS_SL261X_RESET_H */
> > > > -- 
> > > > 2.53.0
> > > > 
> > 
> > 


