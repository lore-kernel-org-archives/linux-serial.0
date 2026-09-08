Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651217A2FC;
	Tue,  8 Sep 2026 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863921; cv=none; b=ox+jeLvxle0nr5RfM82PhhM2V5Rqx1xS51E7Nr9WOgWSYCwhKXbm5GAzmCbzZESZROnajGDuWlOpu95d55i4sqv9QjFVk2rAdhbfMV+/xeWWCFfeEhgRK7GCNArjagK5uQBgkLqjuy30rpt0NbHASRVbx0lg/1KJKAl+2K0qM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863921; c=relaxed/simple;
	bh=NAi8XXgRyXJH8fDKHf2lP/sIwQf5HuYQWjvCKC0FMV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=doU40/unGrSjt+RsFjGrezr+SEInurj0aqHgJsHssFJemJUaTCAJ2UGh4EKkkf3ebSFXIZ1J3A51SoqxizU673GIMl1lddslQt+jao8ZjLkqp1sGNVruMubYO8cXlsV2Up1Q8V+Yt3bOG/vnCeVOxFzJoo7WVuqmJTKkEr6kW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUCdW0XB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUCdW0XB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D7F1F00A3A;
	Tue,  8 Sep 2026 10:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788863919;
	bh=2tI15rjPSxV81apgRivvntF4zVwRCqWJPdSpif4iA5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUCdW0XBaT3c10io/TvXCgABk7O+LeTZfUAAMk/RJaolok7GtR31TsEcZHJIVprw/
	 0DvzFvF5XIrZ8Qr709bFzVuMsItIBrToNJyxpPlE2HrXhWcGnyVP5ax0kx6PebRGKQ
	 APyxKiEQaeBXlGAdIvuIrqrI+mxDyCZEZirO6lXnDqZ9mCM2scPQFryqUygzDrOep+
	 4/IOfyHaOF8Mgy9EgXHCgI0wIoWUBUJAp+xbLhHdW59YUqQ0yVWpiMTFUtByn04vvh
	 AtwA8hA3GxaiVQtYV5NT/ZgnOjKAGRJGuzHtjBoyueGJGKN6ZyNeREenn6fmcyoFbp
	 SnmLObfCuTXkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: serial: Document WK2xxx SPI UART
Reply-To: sashiko-reviews@lists.linux.dev
To: zjzhao@edatec.cn
Cc: robh@kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260908103129.58085-2-zjzhao@edatec.cn>
References: <20260908103129.58085-1-zjzhao@edatec.cn>
 <20260908103129.58085-2-zjzhao@edatec.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:38:38 +0000
Message-Id: <20260908103839.61D7F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The binding schema and example contradict the commit message reg=
arding RS-485 and flow-control support for the WK2132 and WK2202 variants.
--

commit 812f6612c7639102da515af64bd9d5022ac17f75
Author: Zi Jie Zhao <zjzhao@edatec.cn>

dt-bindings: serial: Document WK2xxx SPI UART

This commit adds a device tree binding schema for the WK2xxx family of SPI
to UART bridge ICs. It specifies required properties for each channel and
aims to differentiate compatible strings by channel count and register
availability, specifically noting missing RS-485 and flow-control registers
for WK2132 and WK2202.

> diff --git a/Documentation/devicetree/bindings/serial/wkmic,wk2124.yaml b=
/Documentation/devicetree/bindings/serial/wkmic,wk2124.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/wkmic,wk2124.yaml
[ ... ]
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

[Severity: Medium]
The commit message states that the binding accounts for missing hardware
flow-control and RS-485 registers on the WK2132 and WK2202 variants. Howeve=
r,
this conditional block only restricts the channel count by rejecting the
higher serial nodes. Should this block also explicitly restrict the RS-485
and hardware flow-control properties to prevent invalid configurations from
passing schema validation?

[ ... ]
> +examples:
> +  - |
[ ... ]
> +        serial@0 {
> +            compatible =3D "wkmic,wk2132";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <10000000>;
> +            clocks =3D <&xtal>;
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

[Severity: Medium]
Does this example incorrectly demonstrate RS-485 capabilities on the WK2132
variant? The commit message indicates that WK2132 is missing the hardware
RS-485 registers, but this example actively applies RS-485 properties to its
serial child node.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908103129.5808=
5-1-zjzhao@edatec.cn?part=3D1
