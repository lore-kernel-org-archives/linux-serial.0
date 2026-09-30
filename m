Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D251119E;
	Wed, 30 Sep 2026 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782568; cv=none; b=YsvTtq1lo6lLczygwSJI+nfWmKUOEol1zP+cA3iHW6RPowYVhch6bPkbZkjvzSCLcxJdHBdVxLymUvBbWhXf2NboeI+vklgYMG7tsi7/sTfi6CzyXQAVFGje7HbvGieRzndZXkLMl2vDyDhJyu7qqKW+HqTnIU8klLpUa69JdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782568; c=relaxed/simple;
	bh=0wDVpf8cWsXR2u3nRe2LLt52zHxl8zQ3Obk1jlWxk3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXTOwKHMq/O8F+M8oSEvJ1k6vdiXusH7drzGmzKCKPQ3qROPhJY/9WYAzJMUQKeLidlK3rQrt44cgtB0qKYMp72vn+obF+Bdf1L7TwN0kMduN5ELucM7yyK2RueUGXMWW7OhMp/80xNgeOGlDZVLM8l+ckrbpNz5xF+7XLbbE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENsxnJqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENsxnJqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F6C1F0089B;
	Wed, 30 Sep 2026 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782551;
	bh=wS4LjSmeazs7ipEDl8K4WoxVwnKJqPAAcY7mjsKl19I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ENsxnJqmKcCzQZ8LtzXYoty9iQBgyMbQ5ouiTwV+pPSNRRJa/HzE3uVwu9gdjL2Qu
	 cCcprq6/VuytjCI2cRuOnwFqzy1pvxOZRSh41CRX5PzT/drKE5NCvDjy/p3sTUpM6t
	 dOQ4QNR7D+dfaHgZ7jHN5N8niUKBGd8uSADoEm7ByRsKdm4v1vChc59Q12OrriwIjt
	 o7rJpNBR2QMSvHDhF/XgZqzMQUnDdVx9ThN7t3o+mTjRM8TsengaDQDexOQKMckmES
	 VGYiJRAbQIWfUbpgF2CXcgKYyvvOiD+8IwoTjZfbgAc28SA04z8OYLlOyQQ3kHb12G
	 BMKs34GfPoovg==
Date: Wed, 30 Sep 2026 23:15:48 +0800
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
Message-ID: <ar0npPCHX1P5Gjzx@xhacker>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-9-jszhang@kernel.org>
 <20260929-sprang-stir-af07a907ccb2@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929-sprang-stir-af07a907ccb2@spud>

On Tue, Sep 29, 2026 at 08:44:13PM +0100, Conor Dooley wrote:
> On Tue, Sep 29, 2026 at 02:14:05PM +0800, Jisheng Zhang wrote:
> > Add device tree bindings for the resets on Synaptics SL261X SoCs.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  .../bindings/reset/syna,sl261x-reset.yaml     | 40 ++++++++++
> >  include/dt-bindings/reset/syna,sl261x-reset.h | 80 +++++++++++++++++++
> >  2 files changed, 120 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reset/syna,sl261x-reset.yaml
> >  create mode 100644 include/dt-bindings/reset/syna,sl261x-reset.h
> > 
> > diff --git a/Documentation/devicetree/bindings/reset/syna,sl261x-reset.yaml b/Documentation/devicetree/bindings/reset/syna,sl261x-reset.yaml
> > new file mode 100644
> > index 000000000000..8cfec17df800
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/syna,sl261x-reset.yaml
> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2026 Synaptics Incorporated
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reset/syna,sl261x-reset.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Synaptics SL261X reset controller
> > +
> > +maintainers:
> > +  - Jisheng Zhang <jszhang@kernel.org>
> > +
> > +description: The reset controller node must be a sub-node of the chip
> > +  controller node on SL261X SoCs.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - syna,sl261x-soc-reset
> > +      - syna,sl261x-system-reset
> > +
> > +  "#reset-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - "#reset-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    chip: chip-control@f7e10000 {
> > +        reg = <0xf7e10000 0x1000>;
> > +
> > +        chip_rst: reset {
> > +            compatible = "syna,sl261x-soc-reset";
> > +            #reset-cells = <1>;
> > +        };
> 
> Why can't this just be part of the parent node?

Good question! IMHO, the reasons are:

1. the so called Gbls(Gbl means global) such as mcuGbl and
chip control Gbl contain not only reset, pinctrl and clk/plls
but also some other registers for different purposes, e.g in the
chip control gbl, there are some registers to control eth phy sel(RMII
or RGMII), and TXC 90 degree selection etc. These registers will
be used by the Ethernet driver;

While there's no pinctrl regs in avioGbl and vppGbl. In the vppgbl,
there are some registers for DPHYTX etc.

As can been, in different Gbls, there maybe different purposes registers, no
obvious patterns.

So the question here is why not split the gbl into different register
spaces, and abstract each space for each function group? Two blocking
points make this impossible and ugly: different reg space may not be
aligned at 4KB boundary, e.g reset: 0x350 ~ 0x37c; eth phy sel:0xa18;
some registers which belong to similar functionality, e.g clks, may not be
adjacent.

So the best way is to abstract these GBLs via. "syscon", "simple-mfd", and
put necessary subnodes such as reset, pinctrl and clks under the GBL
node. If the registers in GBL is misc control, pass the syscon phandle
to the main driver, e.g I planed to pass the syscon phandle to GMAC
driver to control the RMII/RGMII selection.

2.follow current bg2 and bg2q style
e.g arch/arm/boot/dts/synaptics/berlin2q.dtsi

IMHO, why bg2 and bg2q dtsi files are implemented as current
style is due to the above point 1.

Kindly let me know if there's a better solution.

> From a quick check of the dts, the node with this subnode didn't also
> have a system-reset node too, so there's no conflict or anything of that
> nature.
> 
> > +    };
> > diff --git a/include/dt-bindings/reset/syna,sl261x-reset.h b/include/dt-bindings/reset/syna,sl261x-reset.h
> > new file mode 100644
> > index 000000000000..7034f58aae5b
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/syna,sl261x-reset.h
> > @@ -0,0 +1,80 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +/*
> > + * Copyright (C) 2026 Synaptics Incorporated
> > + *
> > + * Author: Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +#ifndef _DT_BINDINGS_SL261X_RESET_H
> > +#define _DT_BINDINGS_SL261X_RESET_H
> > +
> > +/* ACPU subsystem */
> > +#define RST_SOC_SDIO0		0
> > +#define RST_SOC_USB0		1
> > +#define RST_SOC_EMMC		2
> > +#define RST_SOC_GETH0		3
> > +#define RST_SOC_SDIO1		4
> > +#define RST_SOC_USB1		5
> > +#define RST_SOC_GETH1		6
> > +#define RST_SOC_USB0PHY		7
> > +#define RST_SOC_USB0CORE	8
> > +#define RST_SOC_USB0MAHB	9
> > +#define RST_SOC_USB1PHY		10
> > +#define RST_SOC_USB1CORE	11
> > +#define RST_SOC_USB1MAHB	12
> > +#define RST_SOC_UART0		13
> > +#define RST_SOC_UART1		14
> > +#define RST_SOC_UART2		15
> > +#define RST_SOC_UART3		16
> > +#define RST_SOC_I2C0		17
> > +#define RST_SOC_I2C1		18
> > +#define RST_SOC_SPI0		19
> > +#define RST_SOC_SPI1		20
> > +#define RST_SOC_SPI2		21
> > +#define RST_SOC_SPI3		22
> > +#define RST_SOC_APBTIMERS	23
> > +#define RST_SOC_APBSYSCNT	24
> > +#define RST_SOC_APBWDT		25
> > +#define RST_SOC_APBGPIO		26
> > +#define RST_SOC_APBDMA		27
> > +#define RST_SOC_GPUCORE		28
> > +#define RST_SOC_NPUCORE		29
> > +#define RST_SOC_AVIOAIOG	30
> > +#define RST_SOC_AVIOVPPG	31
> > +#define RST_SOC_AVIOVIPG	32
> > +
> > +/* system subsystem */
> > +#define RST_SM_ADCCORE		0
> > +#define RST_SM_ADCPRST		1
> > +#define RST_SM_CAN0PRST		2
> > +#define RST_SM_CAN0SRST		3
> > +#define RST_SM_CAN1PRST		4
> > +#define RST_SM_CAN1SRST		5
> > +#define RST_SM_GPIOPRST		6
> > +#define RST_SM_GPIOSRST		7
> > +#define RST_SM_I2CM0PRST	8
> > +#define RST_SM_I2CM0SRST	9
> > +#define RST_SM_I2CM1PRST	10
> > +#define RST_SM_I2CM1SRST	11
> > +#define RST_SM_I3CPRST		12
> > +#define RST_SM_I3CSRST		13
> > +#define RST_SM_PDMPRST		14
> > +#define RST_SM_PDMSRST		15
> > +#define RST_SM_PVTHSRST		16
> > +#define RST_SM_PVTPRST		17
> > +#define RST_SM_PWMPERIRST	18
> > +#define RST_SM_PWMPRST		19
> > +#define RST_SM_SPIMPRST		20
> > +#define RST_SM_SPIMSRST		21
> > +#define RST_SM_SPISPRST		22
> > +#define RST_SM_SPISSRST		23
> > +#define RST_SM_UART0PRST	24
> > +#define RST_SM_UART0SRST	25
> > +#define RST_SM_UART1PRST	26
> > +#define RST_SM_UART1SRST	27
> > +#define RST_SM_UART2PRST	28
> > +#define RST_SM_UART2SRST	29
> > +#define RST_SM_UART3PRST	30
> > +#define RST_SM_UART3SRST	31
> > +
> > +#endif /* _DT_BINDINGS_SL261X_RESET_H */
> > -- 
> > 2.53.0
> > 


