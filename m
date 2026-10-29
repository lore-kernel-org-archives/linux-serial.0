Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302877;
	b=hZqxa0C54+Kq07WA/MTAQ4zmbioaWy7+nxlxNRHR7Ni3fbWEk52FAbsgbdtF3M/NIKNN
	 +FggVHxg+k51Y8PjNl1Kvje8z6ysVwUFqN6YEyqikDEB5HSXAnrF24hGBH4sOwzA6cTuH
	 kLNyq+X7hFXoLz//uNBM0dxhW3qCQckiVRl/4ncBnshMd3FmQFvP4kF49mrSLAk7KqOjg
	 49LAcIFh10xvK1qoUF5Z7LVJSSrkfx4MTLGeLW+cZGTkTjoH4pc5R4hse/mGw/qV+dGPK
	 l536wEhskhkd0n3Bzv8nJxIVCc+FNf/iKMtoTcRJmOuRcJow3uOnvHXsF3pzs2RkoQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302877;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JW9ShaqnOqu+ozNR37/PYpM6YA1fyctYmCNgkAZekas=;
	b=RLbalc6qdrvRgNSlLcjwzdRTHziNT7wCPCAWp/EeURJ6q1YdXMqdYdpmgIJWb5USmpE4
	 Wx1lziTZ/g0Qzre4+nF6gY+2Cgb0R3c3aEoBNdj6KAFoMcmknbaH61kIqOCat/fhZTmNh
	 PE7aFm5Aw8BfINhFOhpO2YTAEei0xbYd4TV78zeDaZDvz3RuYnvq7pCb/cK10OB464Tp4
	 5oOZFojgv/12dBrYp+k0x4K+zD170lI0bQNncGvwiw5fsxNY6ZaUchBMHQW4K643H/zge
	 qtEoqY13kcVWNTFmN0EtOueAHDo9d3QUyinMulhRGCKmiMMX+ZOzNp12K+iBHscc5ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfOw6A2m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0CC606A31D;
	Thu, 29 Oct 2026 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfOw6A2m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1A51F01816;
	Thu, 29 Oct 2026 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793302876;
	bh=JW9ShaqnOqu+ozNR37/PYpM6YA1fyctYmCNgkAZekas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bfOw6A2mfUULCZsCUv6wBi3RPqwoIxb3xaUYIrIy06X9+g3Auipr2uqQ1QiotdfTj
	 1G4KNK8Nwhv+vXtaHQ4D1C9UUxsU03bs9TpaH9/kvwlhy790UxNXvVn4HigP/zgPC5
	 bLkugYVI/MZEFJFP6E4bQk4KPgVD/5etIPWSap5iCowFnPi4z7e0x2/jUTSYWY8QiU
	 LTQzP/GB3i2NeeUY/Xp7NIjbb8fjzZLOB4awtiFYekEvLCsQHFDXRoaXZ8QhTit9fo
	 R5xzzW0y64vb0kdnOWibzKkcDpiDBQhIyaAL/UgvUD+0YEJrVdbPtcl3NVaxoUQKh1
	 L/IlYazKCD+jw==
Date: Thu, 29 Oct 2026 19:41:07 +0000
From: Conor Dooley <conor@kernel.org>
To: gaohan@iscas.ac.cn
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>, linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 06/18] dt-bindings: pinctrl: add Zhihe A210 pin
 controller
Message-ID: <20261029-cleft-other-eb7371c8fa3b@spud>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-6-74d58ce85bd8@iscas.ac.cn>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GVWyK+sZmFzjJVAj"
Content-Disposition: inline
In-Reply-To: <20261027-a210-scmi-v1-6-74d58ce85bd8@iscas.ac.cn>

--GVWyK+sZmFzjJVAj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:36:57PM +0800, Han Gao via B4 Relay wrote:
> From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
>=20
> Add bindings for the four A210 pad controllers. Describe the shared
> PERI3 SDIO mux, the per-pad bias controls and the optional pad
> controller reset.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  .../bindings/pinctrl/zhihe,a210-pinctrl.yaml       | 211 +++++++++++++++=
++++++
>  1 file changed, 211 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/zhihe,a210-pinctrl=
=2Eyaml b/Documentation/devicetree/bindings/pinctrl/zhihe,a210-pinctrl.yaml
> new file mode 100644
> index 000000000000..ae8eebbb0be2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/zhihe,a210-pinctrl.yaml
> @@ -0,0 +1,211 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/zhihe,a210-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ZhiHe A210 pin controller
> +
> +maintainers:
> +  - Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> +
> +description: |
> +  Pinmux and pinconf controller of the ZhiHe A210 RISC-V SoC.
> +
> +  The pads of the A210 are split into four groups, each managed by its
> +  own pad controller with a separate register range:
> +
> +    AON pad controller     -> zhihe,a210-aon-pinctrl
> +    PADCTRL0 (peripheral1) -> zhihe,a210-peri1-pinctrl
> +    PADCTRL1 (peripheral2) -> zhihe,a210-peri2-pinctrl
> +    PADCTRL2 (peripheral3) -> zhihe,a210-peri3-pinctrl
> +
> +  Each pad can be muxed individually to up to 8 different functions,
> +  though for most pads only a few of those configurations are valid.
> +  A few pads in the AON group do not support muxing or configuration
> +  at all.
> +
> +  AON, PERI1 and PERI2 pads support configurable drive strength, bias,
> +  input enable, Schmitt trigger and slew rate.

> PERI3 has a separate pad
> +  layout: its six dedicated SDIO pads, named SDIO_CLK, SDIO_CMD and
> +  SDIO_DAT0..3 in the SoC pin list, share one mux bit that selects SDIO =
or
> +  GPIO4 for all of them. Select their function with the "sdio" group.
> +  Per-pad bias can be configured independently.

Quite frankly, PERI3 seems just too different and should not actually be
in here at all. That said, I think this should still be just done as
pins + function, and drop the overcomplicated binding. The driver for
peri3 should know how this device works and be able to handle the fact
that all pins share one mux - the set_mux op works on groups and
functions, so you can just apply the setting once and return.

I assume it cannot be just a group and a function because the individual
pins can have different configuration?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - zhihe,a210-aon-pinctrl
> +      - zhihe,a210-peri1-pinctrl
> +      - zhihe,a210-peri2-pinctrl
> +      - zhihe,a210-peri3-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: pclk
> +
> +  resets:
> +    maxItems: 1
> +
> +patternProperties:
> +  '-[0-9]+$':
> +    type: object
> +
> +    description:
> +      A pinmux group referenced by a consumer's pinctrl phandle. It
> +      contains one subnode per set of pads sharing the same pinmux and
> +      pinconf settings.
> +
> +    additionalProperties: false
> +
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        $ref: /schemas/pinctrl/pincfg-node.yaml#
> +
> +        description:
> +          A pinctrl node describing the pinmux and pinconf settings of
> +          one or more pads.
> +
> +        properties:
> +          pins:
> +            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pins
> +            description: List of pads that properties in the node apply =
to.
> +
> +          groups:
> +            items:
> +              - const: sdio
> +
> +          function:
> +            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/function
> +            enum: [ aouart, aouart_ir, aogpio0, aogpio1, aoi2c0, aoi2c1,
> +                    aospi, jtag, reset, por, pmic, dvs, uart0, uart1,
> +                    uart2, uart3, uart4, uart5, uart6, uart7, uart8,
> +                    uart9, uart0_ir, uart1_ir, uart2_ir, uart3_ir,
> +                    uart4_ir, uart5_ir, uart6_ir, uart7_ir, uart8_ir,
> +                    uart9_ir, gpio0, gpio1, gpio2, gpio3, gpio4, gmac0,
> +                    gmac1, spi0, spi1, qspi0, qspi1, pwm0, pwm1, pwm2,
> +                    can0, can1, can2, i2s0, i2s1, i2s2, i2s3, i2c0, i2c1,
> +                    i2c2, i2c3, i2c4, i2c5, i2c6, i2c7, i2c7_smb, sdio,
> +                    isp0, dptx, usb31, sata_p0, sata_p1, hdmi, zmac,
> +                    bsel, dbgm, cdbg, pdm, tdm, pcie_x1, pcie_x4,
> +                    sen_vclk ]

Commentary here still applies.

> +            description: The mux function to select for the given pins.
> +
> +          bias-disable: true
> +
> +          bias-pull-up: true
> +
> +          bias-pull-down: true
> +
> +          drive-strength:
> +            enum: [ 1, 2, 3, 5, 7, 8, 10, 12, 13, 15, 16, 18, 20, 21, 23,
> +                    25 ]
> +            description: Drive strength in mA.
> +
> +          input-enable: true
> +
> +          input-disable: true
> +
> +          input-schmitt-enable: true
> +
> +          input-schmitt-disable: true
> +
> +          slew-rate:
> +            maximum: 1
> +
> +        oneOf:
> +          - required: [pins]
> +          - required: [groups]
> +
> +        additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: zhihe,a210-peri3-pinctrl
> +    then:
> +      patternProperties:
> +        '-[0-9]+$':
> +          patternProperties:
> +            '-pins$':
> +              properties:
> +                pins:
> +                  items:
> +                    enum: [SDIO_CLK, SDIO_CMD, SDIO_DAT0, SDIO_DAT1,
> +                           SDIO_DAT2, SDIO_DAT3]

Commentary here also applies.

> +                function:
> +                  enum: [sdio, gpio4]
> +                drive-strength: false
> +                input-enable: false
> +                input-disable: false
> +                input-schmitt-enable: false
> +                input-schmitt-disable: false
> +                slew-rate: false
> +              if:
> +                required: [function]
> +              then:
> +                required: [groups]
> +    else:
> +      patternProperties:
> +        '-[0-9]+$':
> +          patternProperties:
> +            '-pins$':
> +              properties:
> +                groups: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pinctrl@2026000 {
> +        compatible =3D "zhihe,a210-peri1-pinctrl";
> +        reg =3D <0x2026000 0x1000>;
> +        clocks =3D <&clk 0>;
> +        clock-names =3D "pclk";
> +
> +        gmac0-0 {
> +            gmac0-pins {
> +                pins =3D "GPIO0_0", "GPIO0_12";
> +                function =3D "gmac0";
> +                bias-disable;
> +                drive-strength =3D <13>;
> +                input-disable;
> +                input-schmitt-disable;
> +                slew-rate =3D <0>;
> +            };
> +        };
> +    };
> +
> +  - |
> +    pinctrl@542000 {
> +        compatible =3D "zhihe,a210-peri3-pinctrl";
> +        reg =3D <0x542000 0x1000>;
> +        clocks =3D <&clk 0>;
> +        clock-names =3D "pclk";
> +
> +        sdio-0 {
> +            cmd-data-pins {
> +                pins =3D "SDIO_CMD", "SDIO_DAT0", "SDIO_DAT1",
> +                       "SDIO_DAT2", "SDIO_DAT3";
> +                bias-pull-up;
> +            };
> +
> +            sdio-pins {
> +                groups =3D "sdio";
> +                function =3D "sdio";
> +            };
> +        };
> +    };
>=20
> --=20
> 2.55.0
>=20
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--GVWyK+sZmFzjJVAj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOhUwAKCRB4tDGHoIJi
0taNAP0esfYBxcUs7wBMKsjRJttdS0nAoQfhzAFUrn/9FtbC8wEAlmVGW79Bx6oM
U/o8Go9AnCeZDbRpgmVOVmfZLNaJCw0=
=a5fu
-----END PGP SIGNATURE-----

--GVWyK+sZmFzjJVAj--
