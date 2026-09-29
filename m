Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C53D47AB;
	Tue, 29 Sep 2026 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711062; cv=none; b=duOciSDFB1BdugwEFjOTzBXRsls3L3CjjpWkiusA2jUlj6EWW1/G2Bw4BPXBkrXxSEKsKC0GJdwyKYyFq3zczr1CTkHDmeKUyM+UVueiVf2yq4RrCBD48FTwMCWP5lHNpE2RiyoC0nj2/ATWc1+1DabmGStnqlg+KD68Hnh48Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711062; c=relaxed/simple;
	bh=Q4BPCRwbTR7n23+GnQ0TvWEr+3voAJfiGzKEGdJnkOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoACk5TfLuKk0cGOLybks0usEVYPzQasJNN4T3D2x3P38RgtdR6wMwbqsdsxx3oja76mJX4QLOvTcx2feLDPbSOa1BsisG7YuLFIdTdZZDDrGvuP8VwDIFUZYbh7vQs0mGG1vqKF66iYAglQpNJ0kRcW6vb3xLwNO++GlN2EyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3CdhxMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3CdhxMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB941F000FF;
	Tue, 29 Sep 2026 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790711060;
	bh=q3QKjMvgAUkuQ17t6YdqoLww5IfrGk8hudIFHctZSl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z3CdhxMvpO05S2GgF2NZcveZP8lKIPhs7HlQHh6JwjS1CdumoqzZY3CzYY0Dy12x+
	 FqbBLDsmkXJBRJsPr5MEuclQkEbdHXeibLfySXgXA4FSqzSrTjG8+unEq2/mnNe9MY
	 Z6101ZT+tNWCw/LONh33tvF4SUb1OXgrcNT+tDRfievI3hEMYcPyI68GX0ziI9050k
	 IcwWnZyUg2tDZPaYu1JNMEDYZSEiNwtM4Y8WYz+FZvu+gto+yzQeKLTEjjIc8n+w6Q
	 fyuIqGlEQgpeV/GQwMvAyQRVR7kSMBQH6qR/9hF46TZ6Uen9cy5H+12FYsUSXQoj3K
	 oN/Er3jEluMng==
Date: Tue, 29 Sep 2026 20:44:13 +0100
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
Subject: Re: [PATCH 08/20] dt-bindings: reset: add Synaptics SL261X SoCs
Message-ID: <20260929-sprang-stir-af07a907ccb2@spud>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-9-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/eZs2VEqyPUB++Zv"
Content-Disposition: inline
In-Reply-To: <20260929061417.20733-9-jszhang@kernel.org>

--/eZs2VEqyPUB++Zv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 02:14:05PM +0800, Jisheng Zhang wrote:
> Add device tree bindings for the resets on Synaptics SL261X SoCs.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/reset/syna,sl261x-reset.yaml     | 40 ++++++++++
>  include/dt-bindings/reset/syna,sl261x-reset.h | 80 +++++++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/syna,sl261x-r=
eset.yaml
>  create mode 100644 include/dt-bindings/reset/syna,sl261x-reset.h
>=20
> diff --git a/Documentation/devicetree/bindings/reset/syna,sl261x-reset.ya=
ml b/Documentation/devicetree/bindings/reset/syna,sl261x-reset.yaml
> new file mode 100644
> index 000000000000..8cfec17df800
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/syna,sl261x-reset.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2026 Synaptics Incorporated
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/syna,sl261x-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synaptics SL261X reset controller
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +description: The reset controller node must be a sub-node of the chip
> +  controller node on SL261X SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - syna,sl261x-soc-reset
> +      - syna,sl261x-system-reset
> +
> +  "#reset-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    chip: chip-control@f7e10000 {
> +        reg =3D <0xf7e10000 0x1000>;
> +
> +        chip_rst: reset {
> +            compatible =3D "syna,sl261x-soc-reset";
> +            #reset-cells =3D <1>;
> +        };

Why can't this just be part of the parent node?
=46rom a quick check of the dts, the node with this subnode didn't also
have a system-reset node too, so there's no conflict or anything of that
nature.

> +    };
> diff --git a/include/dt-bindings/reset/syna,sl261x-reset.h b/include/dt-b=
indings/reset/syna,sl261x-reset.h
> new file mode 100644
> index 000000000000..7034f58aae5b
> --- /dev/null
> +++ b/include/dt-bindings/reset/syna,sl261x-reset.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (C) 2026 Synaptics Incorporated
> + *
> + * Author: Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#ifndef _DT_BINDINGS_SL261X_RESET_H
> +#define _DT_BINDINGS_SL261X_RESET_H
> +
> +/* ACPU subsystem */
> +#define RST_SOC_SDIO0		0
> +#define RST_SOC_USB0		1
> +#define RST_SOC_EMMC		2
> +#define RST_SOC_GETH0		3
> +#define RST_SOC_SDIO1		4
> +#define RST_SOC_USB1		5
> +#define RST_SOC_GETH1		6
> +#define RST_SOC_USB0PHY		7
> +#define RST_SOC_USB0CORE	8
> +#define RST_SOC_USB0MAHB	9
> +#define RST_SOC_USB1PHY		10
> +#define RST_SOC_USB1CORE	11
> +#define RST_SOC_USB1MAHB	12
> +#define RST_SOC_UART0		13
> +#define RST_SOC_UART1		14
> +#define RST_SOC_UART2		15
> +#define RST_SOC_UART3		16
> +#define RST_SOC_I2C0		17
> +#define RST_SOC_I2C1		18
> +#define RST_SOC_SPI0		19
> +#define RST_SOC_SPI1		20
> +#define RST_SOC_SPI2		21
> +#define RST_SOC_SPI3		22
> +#define RST_SOC_APBTIMERS	23
> +#define RST_SOC_APBSYSCNT	24
> +#define RST_SOC_APBWDT		25
> +#define RST_SOC_APBGPIO		26
> +#define RST_SOC_APBDMA		27
> +#define RST_SOC_GPUCORE		28
> +#define RST_SOC_NPUCORE		29
> +#define RST_SOC_AVIOAIOG	30
> +#define RST_SOC_AVIOVPPG	31
> +#define RST_SOC_AVIOVIPG	32
> +
> +/* system subsystem */
> +#define RST_SM_ADCCORE		0
> +#define RST_SM_ADCPRST		1
> +#define RST_SM_CAN0PRST		2
> +#define RST_SM_CAN0SRST		3
> +#define RST_SM_CAN1PRST		4
> +#define RST_SM_CAN1SRST		5
> +#define RST_SM_GPIOPRST		6
> +#define RST_SM_GPIOSRST		7
> +#define RST_SM_I2CM0PRST	8
> +#define RST_SM_I2CM0SRST	9
> +#define RST_SM_I2CM1PRST	10
> +#define RST_SM_I2CM1SRST	11
> +#define RST_SM_I3CPRST		12
> +#define RST_SM_I3CSRST		13
> +#define RST_SM_PDMPRST		14
> +#define RST_SM_PDMSRST		15
> +#define RST_SM_PVTHSRST		16
> +#define RST_SM_PVTPRST		17
> +#define RST_SM_PWMPERIRST	18
> +#define RST_SM_PWMPRST		19
> +#define RST_SM_SPIMPRST		20
> +#define RST_SM_SPIMSRST		21
> +#define RST_SM_SPISPRST		22
> +#define RST_SM_SPISSRST		23
> +#define RST_SM_UART0PRST	24
> +#define RST_SM_UART0SRST	25
> +#define RST_SM_UART1PRST	26
> +#define RST_SM_UART1SRST	27
> +#define RST_SM_UART2PRST	28
> +#define RST_SM_UART2SRST	29
> +#define RST_SM_UART3PRST	30
> +#define RST_SM_UART3SRST	31
> +
> +#endif /* _DT_BINDINGS_SL261X_RESET_H */
> --=20
> 2.53.0
>=20

--/eZs2VEqyPUB++Zv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarwVDQAKCRB4tDGHoIJi
0hGwAP4ptyfAiZ/Hyv5m5DXC1l4L5OIOyvVbaRVAxy6CVrteRgD7BDhIbPYIHQMg
hqZCgq4VRutWdr432OpL5OAfu0MmLQM=
=RY0u
-----END PGP SIGNATURE-----

--/eZs2VEqyPUB++Zv--
