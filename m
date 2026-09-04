Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B993EF66B;
	Fri,  4 Sep 2026 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535743; cv=none; b=XFUcNMp+ajhv1Caco4r2ttgy4MDyMBlsO8o0hDVUjreondlIhD7adaoqjDxH29F689mid5Fy5W0tXPohqoDCpfKV+6h8VI/Rg2UHv1tK8kZth49x7XUCNcSZRdL5AYvF2l40TQUOtD6k626wWjJNbbXdDwJ+ugdj4WqA5Fh7EOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535743; c=relaxed/simple;
	bh=6JZB0w29LQ4lg/CRMhk4MHcw92V0Fm8ZlMDdCZRPypc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRVeuIw+XiM6/VqiXr3V+ypxvXbLScjlZZ1uTNZE80eAuGYOdN8z1sTPKHjDvPrSKDLMYy7JAPbnMEyd1O3V86g9F/JRuq5DTuIpMa3bKtUXw9OWG3GHkNuloMJ7dqkSKRQB9q2ZcoYzo/Ovlc+bOdOoBZlIpZWQR8RHHb/Ralk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhhAeBGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhhAeBGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA871F00A3D;
	Fri,  4 Sep 2026 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535741;
	bh=SzTVWioPMn/eUN8JebTME7TENuk6Gd+DFGYc+ZIXvoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KhhAeBGXWdHD0WOVo+1LUWvHKbix/TMAGxcYwlKoET6AwtHthxRdv8Pw9ChYa04oV
	 OWERxbB4cokq2hrGmNQSgJPU8pb+NvWxOz9ExWCnctwl2NtgzyOt8ev2rPEAi5lxSr
	 2lx3COPOTk6xw/XdcvwSyTeB/lp23fNATH0UiuxmfaNaYcZQYVB04LhW5+YjNhlP1i
	 kNmO3Eb2gTzve72n5gGSMni95M4N5HxXa5rOZTZm9wOIlZLdjRctvxntLlCquMzAzN
	 QIo1BLOo7HMXgZIQ+DHj/r4n6i4NIjVUPAztH8t3SU375vx/64SNNlQ7B+/hz42/9y
	 WlUD9k+fS0Irg==
Date: Fri, 4 Sep 2026 16:28:57 +0100
From: Conor Dooley <conor@kernel.org>
To: zjzhao <zjzhao@edatec.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: serial: Document WK2xxx SPI UART
 bindings
Message-ID: <20260904-satisfy-ocean-69c916e07d1e@spud>
References: <20260904093341.100826-1-zjzhao@edatec.cn>
 <20260904105243.120769-1-zjzhao@edatec.cn>
 <20260904105243.120769-3-zjzhao@edatec.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4wPLBzKbDJ+R/WxB"
Content-Disposition: inline
In-Reply-To: <20260904105243.120769-3-zjzhao@edatec.cn>

--4wPLBzKbDJ+R/WxB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 06:52:43PM +0800, zjzhao wrote:
> Add a DT binding for the WK2xxx SPI to UART bridge ICs (WK2124, WK2132,
> WK2168, WK2202 and WK2204) from WKmic (Chengdu Weikai Microelectronics).
> Each UART channel is described by a serial@N child node that carries its
> own serial and RS-485 properties. Also register the wkmic vendor prefix.
>=20
> Signed-off-by: zjzhao <zjzhao@edatec.cn>
> ---
>  .../bindings/serial/wkmic,wk2xxx.yaml         | 115 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  2 files changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/wkmic,wk2xxx=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml b=
/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml
> new file mode 100644
> index 000000000000..c781482c0f2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml

Filename patching a compatible please.

> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/wkmic,wk2xxx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: WKmic WK2xxx SPI to UART bridge
> +
> +maintainers:
> +  - EDATEC Technology Co., Ltd. <zjzhao@edatec.cn>

This should be your name. We want people here.

> +
> +description:
> +  The WK2xxx family (WK2124, WK2132, WK2168, WK2202 and WK2204) are SPI =
to
> +  UART bridge ICs from WKmic (Chengdu Weikai Microelectronics). Each IC
> +  exposes two or four full-duplex UART channels with 256-byte RX/TX FIFOs
> +  through a single SPI slave interface and one interrupt line. Each chan=
nel
> +  is described by a "serial@N" child node that carries its own serial and
> +  RS-485 properties.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - wkmic,wk2124
> +      - wkmic,wk2132
> +      - wkmic,wk2168
> +      - wkmic,wk2202
> +      - wkmic,wk2204

Why are these devices not compatible with one another?
If they aren't, state why in your commit message.
pw-bot: changes-requested

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      When missing, the device driver uses polling instead.
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description:
> +      Crystal or external clock frequency for the IC in Hz. The WK2xxx h=
as
> +      no internal clock, so this must match the connected crystal.
> +    default: 11059200

I think I would drop this default and make the property required.

> +    minimum: 1
> +    maximum: 30000000

I find the 1 Hz minimum hard to believe!

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^serial@[0-3]$":
> +    type: object
> +    description: A single UART channel of the chip.
> +    allOf:
> +      - $ref: /schemas/serial/serial.yaml#
> +      - $ref: /schemas/serial/rs485.yaml#
> +    properties:
> +      reg:
> +        description: UART channel number on the chip.
> +        maximum: 3
> +    required:
> +      - reg
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - wkmic,wk2132
> +              - wkmic,wk2202
> +    then:
> +      patternProperties:
> +        "^serial@[23]$": false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        serial@0 {
> +            compatible =3D "wkmic,wk2132";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <10000000>;
> +            clock-frequency =3D <11059200>;
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <24 IRQ_TYPE_LEVEL_LOW>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            serial@0 {
> +                reg =3D <0>;
> +            };
> +
> +            serial@1 {
> +                reg =3D <1>;
> +                rs485-rts-active-low;
> +                linux,rs485-enabled-at-boot-time;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index ba2002969373..654fc8525559 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1907,6 +1907,8 @@ patternProperties:
>      description: Wireless Tag (qiming yunduan)
>    "^wits,.*":
>      description: Shenzhen Merrii Technology Co., Ltd. (WITS)
> +  "^wkmic,.*":
> +    description: Chengdu Weikai Microelectronics Co., Ltd.

"wkmic" doesn't come naturally to me as a non-chinese speaker from
"Chengdu Weikai Microelectronics". Usually we use stock ticker symbols,
or website URLs to form the vendor prefix. I tried lookig for one here
but could not find it. Why not use "weikai," here?

Cheers,
Conor.

>    "^wlf,.*":
>      description: Wolfson Microelectronics
>    "^wm,.*":
> --=20
> 2.43.0
>

--4wPLBzKbDJ+R/WxB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaprjuQAKCRB4tDGHoIJi
0tMmAQDxtZxa0dn7niH7wpAcwm1fJ/ofF5H/1qTzlvjmEDXhMAD/YB3txuD+xFX2
PC3iOTuP7j+1rmwoPM8aqIPGd+r4/Qk=
=G2Gz
-----END PGP SIGNATURE-----

--4wPLBzKbDJ+R/WxB--
