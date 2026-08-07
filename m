Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9274B048E;
	Fri,  7 Aug 2026 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082816; cv=none; b=JqA7As3fom3rCN5DlabzxusDrn0ACm9SMQ5x3IPvnR5ZyB3QZZmK/fpyJDI4Fvcwexildgp5s8uQDjj1dukTSvmY9SVgeK+L+p7F4uN+2FfK27aHTXYNTeuv5OgED1wiSxnz3xBg0A7aZhvJ5W2zAnkbtE0UPlCsGFTd8wT9Xrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082816; c=relaxed/simple;
	bh=qMG02EPIVXOMn/7ueSsbGJRAVfznGl3cvBs9YZBspcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y473WulQfd8RlBfztgi4S5SRpEpQjFmhcxsc4GEFIuLVShDmSh3AoKZtUKbkMUmrq/BObAlvaJFXzTMklAPoIrdpyrkH5s23yviMEAGxHIthjfm8aiZTiqzBrElEKm6vjhbVtXxXtMN517yMPFViiqxPp6jpbJFxWgZDSziq8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL1GeBVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL1GeBVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0251F000E9;
	Fri,  7 Aug 2026 06:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786082815;
	bh=L9tU9pcxg+3S2Ft6tVACbmzA71Uk5jr59+MtaRvQsfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fL1GeBVzFTDJO+OxlnCdamnGAWnSq9h+zuv8RDed3xjeGl9LzXoDcTmyqgOSA6CCJ
	 dk5EwCirGTGyK1NCU/t1EAmcblh+EM4qd0uDl4Jh0auAZ3d7ezb7JWL/PacLHG+FE0
	 IPIkYFjBnaHPVb768H0qV1JnxFKganZt4p1bIRFK9QuzPv1Rfo3d0HtANkO7f9TREY
	 KXvEsQQ3EiLdlIbSzdzz7ZQxNsEwXBOG73tjKIkYom8KYJq7Nu7jYFoW/hxQOu5zcM
	 ZPwj/KtHYdiN3asbO6tkQkKsIxRe6+W1IBEBub6apb7BiCFW9ZVtm8SydeFREguI4f
	 hqEKO8qUfPosA==
Date: Fri, 7 Aug 2026 08:06:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Long Zhao <longzhao@ambarella.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH v2 04/10] dt-bindings: pinctrl: add Ambarella CV75 pinctrl
Message-ID: <20260807-slim-amusing-jaybird-0bd13a@quoll>
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-4-6b09707c5fe9@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-4-6b09707c5fe9@ambarella.com>

On Thu, Aug 06, 2026 at 05:34:12PM +0800, Long Zhao wrote:
> Add the CV75 pin controller binding.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../bindings/pinctrl/ambarella,cv75-pinctrl.yaml   | 175 +++++++++++++++++++++
>  1 file changed, 175 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
> new file mode 100644
> index 000000000000..3fa30b275e51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
> @@ -0,0 +1,175 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/ambarella,cv75-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ambarella CV75 Pin Controller
> +
> +maintainers:
> +  - Long Zhao <longzhao@ambarella.com>
> +
> +description:
> +  The Ambarella CV75 pin controller configures pin multiplexing, bias and
> +  drive strength for the main GPIO banks. Pin groups and their mux settings
> +  are defined by the pin controller driver and selected by function and group
> +  names.
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +properties:
> +  compatible:
> +    const: ambarella,cv75-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +    description: IOMUX registers
> +
> +  ambarella,drive-strength-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: RCT syscon containing the drive-strength registers.
> +
> +  ambarella,pull-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Secure scratchpad syscon containing the pull registers.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^gpio@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      gpio-controller: true
> +
> +      "#gpio-cells":
> +        const: 2
> +
> +      gpio-ranges:
> +        maxItems: 1
> +
> +      interrupt-controller: true
> +
> +      "#interrupt-cells":
> +        const: 2
> +
> +    required:
> +      - reg
> +      - interrupts
> +      - gpio-controller
> +      - "#gpio-cells"
> +      - gpio-ranges
> +      - interrupt-controller
> +      - "#interrupt-cells"
> +
> +  "^[a-z0-9-]+-pins$":

Mixing MMIO and non-MMIO nodes in a bus is discouraged. Sloppy code.

Why the pins aren't per gpio-controller?

> +    type: object
> +    allOf:
> +      - $ref: pinmux-node.yaml#
> +      - $ref: pincfg-node.yaml#
> +    additionalProperties: false
> +
> +    properties:
> +      function:
> +        const: uart0

If the function is fixed, then you do not need any of this.

You must post COMPLETE bindings, see writing bindings doc.

> +
> +      groups:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        items:
> +          enum: [uart0tx, uart0rx]

Same here, pointless/redunadnt.

> +        minItems: 2
> +        maxItems: 2
> +        uniqueItems: true
> +
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +
> +      drive-strength:
> +        enum: [3, 4, 5, 6, 7, 8, 9, 12]
> +
> +    required:
> +      - function
> +      - groups
> +
> +required:
> +  - compatible
> +  - reg
> +  - ambarella,drive-strength-syscon
> +  - ambarella,pull-syscon
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    rct: rct {
> +    };
> +
> +    scratchpad: scratchpad {
> +    };

Drop above, irrelevant. Do you see any other bindings doing this?

> +
> +    pinctrl: pinctrl@e4010000 {
> +        compatible = "ambarella,cv75-pinctrl";
> +        #address-cells = <1>;
> +        #size-cells = <1>;

You need to follow DTS coding style.

> +        reg = <0xe4010000 0x1000>;
> +        ranges;
> +        ambarella,drive-strength-syscon = <&rct>;
> +        ambarella,pull-syscon = <&scratchpad>;

Best regards,
Krzysztof

