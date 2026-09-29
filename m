Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE7399000;
	Tue, 29 Sep 2026 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711708; cv=none; b=gNOREV4lnEvHsbJrMHs/ZBI5HxvxuRHvtTTY36viJrV6PcTzbawVPi6zFr76WR2WkD5++6RyUfuOpAfzBMRVtRwfX1SHWoCdZmk2UzXcmOaA7CFlHWpeJ/6n5ZLLFR/yuwjhXtRoYIDMfwkHUMJxSaY2dSzB0v14bzjRpQaHEC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711708; c=relaxed/simple;
	bh=EWZ0MOYa/8t4M3Zhq9bhy/lAt6FtbsEMv4Re89iGVqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNlsa5IStuYC6czSQJfQmb7Mi2ry22sa7ZV9i9pEtsj2a1VZDf/9FzMocIcHosPE8YMXElq7Q3M7tmVb2p2aSUG3l2Z1/IggCE2YqTLbxFGItN7SrzfzucFCwvo9OuSMJBAYAMQJP8fmseht9HyWHO5HrvNLrH06XRwaK6mKxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnVI9pk/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnVI9pk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B111F000FF;
	Tue, 29 Sep 2026 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790711707;
	bh=4WYtVO5seJAuSUgV9wcL7uDSrkV53Em2i+FDrtDNOs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dnVI9pk/2GBJTKGok5UQMMwR5/xIZdds+aR6UkDfQ5or6+EcbFL2qWZ33BcjSLgYi
	 TjWrFvbg1gqy6Qo5T1R9jPxEvvkio+QW58kfR65MFF6grSOGdf1vbx//z35hVnduAN
	 NJk08yE8pttIvCwCDuHnnfQVzSU8AR0vrF5LFAYW02GVCea6qzR6bXNb27GYSSwCqf
	 AgnHB+QO3mrN1n+7OGQG0vNf/CHXYYY4rT3OI92DvXlwyjBu+FY0TVMLiwZg5Gaxxz
	 i9Wt7kGTec7w9unRyOqe/JlCZBLFgWyCCfdJi8/q9XbxWVZeDHF5h26wHCAlNI4jw4
	 VJ53nSaFC+Kpg==
Date: Tue, 29 Sep 2026 20:55:00 +0100
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
Subject: Re: [PATCH 17/20] dt-bindings: mfd: Add Synaptics SL261x global
 block binding
Message-ID: <20260929-handyman-penalize-0c5cbf13c5fd@spud>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-18-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GS+jVj3BFMGXFZD8"
Content-Disposition: inline
In-Reply-To: <20260929061417.20733-18-jszhang@kernel.org>

--GS+jVj3BFMGXFZD8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 02:14:14PM +0800, Jisheng Zhang wrote:
> Document the AVIO global, CPU wrapper, chip control, and MCU global
> register blocks on SL261x SoCs. Each block exposes its clock and, where
> applicable, pinctrl and reset functions through child nodes.
>=20
> Document the chip control syscon phandle used by the CPU clock
> controller.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/mfd/syna,sl261x-gbl.yaml         | 208 ++++++++++++++++++
>  1 file changed, 208 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/syna,sl261x-gbl=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/syna,sl261x-gbl.yaml b=
/Documentation/devicetree/bindings/mfd/syna,sl261x-gbl.yaml

Filename should match a compatible.

> new file mode 100644
> index 000000000000..3e5842169c4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/syna,sl261x-gbl.yaml
> @@ -0,0 +1,208 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/syna,sl261x-gbl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synaptics SL261x global and control register blocks
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +description: |
> +  The SL261x global and control register blocks contain clock, reset, and
> +  pin control registers. Each functional child uses its parent's register
> +  range. The CPU clock controller also refers to the chip control syscon.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: syna,sl261x-avio-gbl
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: syna,sl261x-cpu-wrp
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: syna,sl261x-chip-control
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: syna,sl261x-mcu-gbl
> +          - const: syscon
> +          - const: simple-mfd

This can be simplified significantly by using an enum for the variable
part.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clock:
> +    type: object
> +    additionalProperties: true
> +
> +  pin-controller:
> +    type: object
> +    additionalProperties: true
> +
> +  reset:
> +    type: object
> +    additionalProperties: true
> +
> +required:
> +  - compatible
> +  - reg
> +

> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: syna,sl261x-avio-gbl
> +    then:
> +      required:
> +        - clock
> +      properties:
> +        clock:
> +          properties:
> +            compatible:
> +              const: syna,sl261x-aio-clk
> +        pin-controller: false
> +        reset: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: syna,sl261x-cpu-wrp
> +    then:
> +      required:
> +        - clock
> +      properties:
> +        clock:
> +          properties:
> +            compatible:
> +              const: syna,sl261x-cpu-clk
> +        pin-controller: false
> +        reset: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: syna,sl261x-chip-control
> +    then:
> +      required:
> +        - clock
> +        - pin-controller
> +        - reset
> +      properties:
> +        clock:
> +          properties:
> +            compatible:
> +              const: syna,sl261x-soc-clk
> +        pin-controller:
> +          properties:
> +            compatible:
> +              const: syna,sl261x-soc-pinctrl
> +        reset:
> +          properties:
> +            compatible:
> +              const: syna,sl261x-soc-reset
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: syna,sl261x-mcu-gbl
> +    then:
> +      required:
> +        - clock
> +        - pin-controller
> +        - reset
> +      properties:
> +        clock:
> +          properties:
> +            compatible:
> +              const: syna,sl261x-system-clk
> +        pin-controller:
> +          properties:
> +            compatible:
> +              const: syna,sl261x-system-pinctrl
> +        reset:
> +          properties:
> +            compatible:
> +              const: syna,sl261x-system-reset

Most of this can just disappear because most of these subnodes don't need to
exist. In fact, maybe all of them can be removed, leaving you just with
the syscon nodes themselves containing the relevant properties for
resets/clocks/pinctrl.

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

Nodes like this will get simulated by the tooling, they're not needed
here.

> +
> +    avio_gbl: avio-gbl@f7490000 {
> +        compatible =3D "syna,sl261x-avio-gbl", "syscon", "simple-mfd";
> +        reg =3D <0xf7490000 0x4000>;
> +
> +        aioclk: clock {
> +            compatible =3D "syna,sl261x-aio-clk";
> +            #clock-cells =3D <1>;
> +            clocks =3D <&osc>;
> +        };
> +    };
> +
> +    chip: chip-control@f7e10000 {
> +        compatible =3D "syna,sl261x-chip-control", "syscon", "simple-mfd=
";
> +        reg =3D <0xf7e10000 0x10000>;
> +
> +        clk: clock {
> +            compatible =3D "syna,sl261x-soc-clk";
> +            #clock-cells =3D <1>;
> +            clocks =3D <&osc>;
> +        };
> +
> +        pinctrl: pin-controller {
> +            compatible =3D "syna,sl261x-soc-pinctrl";
> +        };
> +
> +        rst: reset {
> +            compatible =3D "syna,sl261x-soc-reset";
> +            #reset-cells =3D <1>;
> +        };
> +    };
> +
> +    cpu_wrp: cpu-wrp@f7e30000 {

Please don't make up new node names for your device, use something
established like "system-controller" or "syscon" please.

pw-bot: changes-requested

Thanks,
Conor.

> +        compatible =3D "syna,sl261x-cpu-wrp", "syscon", "simple-mfd";
> +        reg =3D <0xf7e30000 0x4000>;
> +
> +        cpuclk: clock {
> +            compatible =3D "syna,sl261x-cpu-clk";
> +            #clock-cells =3D <1>;
> +            clocks =3D <&osc>;
> +            syna,gbl-syscon =3D <&chip>;
> +        };
> +    };
> +
> +    mcu_gbl: mcu-gbl@e5025000 {
> +        compatible =3D "syna,sl261x-mcu-gbl", "syscon", "simple-mfd";
> +        reg =3D <0xe5025000 0x1000>;
> +
> +        sm_clk: clock {
> +            compatible =3D "syna,sl261x-system-clk";
> +            #clock-cells =3D <1>;
> +        };
> +
> +        sm_pinctrl: pin-controller {
> +            compatible =3D "syna,sl261x-system-pinctrl";
> +        };
> +
> +        sm_rst: reset {
> +            compatible =3D "syna,sl261x-system-reset";
> +            #reset-cells =3D <1>;
> +        };
> +    };
> +...
> --=20
> 2.53.0
>=20

--GS+jVj3BFMGXFZD8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarwXlAAKCRB4tDGHoIJi
0oZfAP961KDyuZuHW6X/Y8S1uq/6yK2664KS0xlfZKQ7Zncl0wD2KCI2eV4qMyE7
oBJLm3S1r/YSGvXdxZKpAP9pZT8LBA==
=32mr
-----END PGP SIGNATURE-----

--GS+jVj3BFMGXFZD8--
