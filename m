Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30523FFD;
	Fri,  4 Sep 2026 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506898; cv=none; b=SLj+ZVlqgCytSFndKE3e9AK6ARGdlncIHeJfnbkaojaDQdh7ky+ntwttLbTbdzrfyBny8LiYhuSB5DTzPR/w37DSornN8Pv0eVp3C1upfWJdHX7rIvMjgje0XFcX4pskvY0vMKNOL20kG2L5aLOQNS3hIcATAWhqrXWtUxvXpqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506898; c=relaxed/simple;
	bh=vB4kGG7dJ6w8KtI38TzlADTZPcWPia2HFQAsK42A9ZM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AT+Ejoclitdp6j64GjBz0a4b1/8iSedy0u8r728M8xHYfEC2w0f5dffS3jAG6agmRtHg1AutdLicvmh31kiReta8BjmZZccY2Qdk118IbKlw8fmHdjmfoEdv8za3q9Ehz5b2XQaOmgGsJ3rPqQLaCgGah3+DhGNbnSoz8JaFoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXquAhgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXquAhgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435FA1F00A3E;
	Fri,  4 Sep 2026 07:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788506894;
	bh=9SfNPWUxt92j4L5AMUeIuNGabF2yRCrMlRcUDc6/l5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nXquAhgoDEl3ItARjEh7ZbYZncq4dT/UC2QrBthCDIO/dzkesB8CWi4HsQE/Kx4zK
	 V9LgSw9o70FoR2mmvjh20m0cm1yMUxLA5ak3ZSDFN+yw+2m7m01eZxkJKqTdtEe+yP
	 /EA8HV6uhgXcKfRwMde/jYUB/Dq/I9sG7uC9bWF+XFPt6bpGfDYWP4XzRPcQifl1H1
	 0hKrEZWSa29cLZxpHqDc+qVyBgqXNkPFhBsFA+pqaMAAapiwy2uO0+/Gj2hacqhzQn
	 /ouuu9BYnAWN7e5zYdSefmZDafGuPFYAxxZyV4muUtbQycCtoW7RreJp8xwnNtmJAP
	 GVBB5bVl8DHag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: serial: Document WK2xxx SPI UART
 bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: zjzhao <zjzhao@edatec.cn>
Cc: conor+dt@kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904072027.67473-3-zjzhao@edatec.cn>
References: <20260904072027.67473-1-zjzhao@edatec.cn>
 <20260904072027.67473-3-zjzhao@edatec.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 07:28:13 +0000
Message-Id: <20260904072814.435FA1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Multi-port UART device incorrectly modeled as a single flat node w=
ithout subnodes, preventing per-port independent configuration.
- [Low] Missing trailing newline at the end of the YAML file.
- [Low] Missing `default` property for `clock-frequency` despite the descri=
ption claiming a default exists.
--

commit beaa6c014e093e4f6483f239f3024922536014b5
Author: zjzhao <zjzhao@edatec.cn>

dt-bindings: serial: Document WK2xxx SPI UART bindings

Add a DT binding for the WK2xxx SPI to UART bridge ICs (WK2124, WK2132,
WK2168, WK2202 and WK2204). It covers the compatible strings, SPI propertie=
s,
interrupt line, and the crystal clock frequency. It also registers the wkmic
vendor prefix.

> diff --git a/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml b=
/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml
> new file mode 100644
> index 0000000000000..0ef76957d73f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml
> @@ -0,0 +1,69 @@
[ ... ]
> +  clock-frequency:
> +    description:
> +      Crystal or external clock frequency for the IC in Hz. The WK2xxx h=
as
> +      no internal clock, so this must match the connected crystal. Defau=
lts
> +      to 11059200 Hz when the property is absent.
> +    minimum: 1
> +    maximum: 30000000

[Severity: Low]
Is it possible to include the default property value of 11059200 alongside
the minimum and maximum constraints?

Schema validation tools and external parsers cannot automatically infer the
default fallback value because it is documented in text but not defined as a
JSON schema constraint.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - $ref: /schemas/serial/serial.yaml#
> +  - $ref: /schemas/serial/rs485.yaml#

[Severity: High]
Does this single-node model prevent independent configuration of the
individual UART ports?

Because this binding applies the serial.yaml and rs485.yaml definitions
directly to the parent SPI device node, rather than defining child nodes li=
ke
serial@0 and serial@1, all configuration properties apply globally to every
channel.

If a user needs to configure RS-485 on only one of the 4 UART channels using
device tree properties, the single flat node approach would force the driver
to apply the configuration identically to every port. Should this binding be
structured to support child nodes for individual port configuration to prev=
ent
permanently restricting these hardware capabilities in the ABI?

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
> +        };
> +    };
> \ No newline at end of file

[Severity: Low]
Could a trailing newline be added to the end of this file?

Text files without a trailing newline violate standard POSIX conventions and
kernel coding styles, which can cause issues with git diffs, patching, and
text processing tools.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904072027.6747=
3-1-zjzhao@edatec.cn?part=3D2
