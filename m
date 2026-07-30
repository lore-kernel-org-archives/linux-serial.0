Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7801F3B85;
	Thu, 30 Jul 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420711; cv=none; b=NcKriSZcRaocYpqwYOPN0T2O8UAU/2r+VGzxWTTj/LK9HRBi7SGU0yhT+cjArSHfh858GFh8dCp2jEs8ej5KaoNRJrlV1Elc2/8JJggAwCkqnW+oUG3Ie3/UBCe5pHYSjjpsg0ZD0Hl5nOhGD9N1YlSe/cHFo9q0nujcm+hO/XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420711; c=relaxed/simple;
	bh=58yU4qPtja/6Fpw6sKzfo0PGAqgv65nlsTPh9rhr31k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7hNYVqfVEw6x+f69UB5Yeky8poQwKw39aosaywx7leZSebMsjs7MRIF1iX5M8lKA4lJx2jLPjpM1lv+0QHiLSUVmme1jZLexdO8VcBrCRmwzuEw2M+aoFy9w17p602++y4SKldtIQIvgvnr3SDpqE/wQWUk/bUfGnPmjQ6SZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8vLubTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8vLubTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AC31F000E9;
	Thu, 30 Jul 2026 14:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785420709;
	bh=xOfZ1XZtmIGv5xPs/JpL5IA5kDeBp4wZjvToK2htZEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z8vLubTbVrC5ggTk1y2XualK8J6337oJ22xbo6bslpP7b4zn0dWTkMpUIQ9r2F1vd
	 wVgQx4rddZtSPRahJAUSCohb8kgDwjkOe/0FJzH9ieNLIiG6MR96um9+5hEimKYvL/
	 al4vXaF0SYqn4yr3k9vm1F4IHLxrex+cFKMj2FP2iwvdYCeY1dESMqfjP+wKT1aSAZ
	 DOyOQN5S1xNyPYjdZL9wIk5mMYrO+1bNzh1stF/vmBLT6xHQnRp4VP8U81ldpWcz6t
	 jEgq4ctZt4/UPYwlQeQl+RD46/tA3FfeX5ZVxDfq/wxEzU60d6kQ+0ZhQ/eG3ndBTN
	 mjIFhls78msYw==
Date: Thu, 30 Jul 2026 09:11:48 -0500
From: Rob Herring <robh@kernel.org>
To: Long Zhao <longzhao@ambarella.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: clock: add Ambarella CV75 RCT clock
 controller
Message-ID: <20260730141148.GA2828054-robh@kernel.org>
References: <20260730104330.81367-1-longzhao@ambarella.com>
 <20260730104330.81367-4-longzhao@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730104330.81367-4-longzhao@ambarella.com>

On Thu, Jul 30, 2026 at 06:43:23PM +0800, Long Zhao wrote:
> Add the CV75 RCT clock controller binding and clock ID header.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../bindings/clock/ambarella,cv75-rct.yaml    | 94 +++++++++++++++++++
>  .../dt-bindings/clock/ambarella,cv75-clock.h  | 17 ++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
>  create mode 100644 include/dt-bindings/clock/ambarella,cv75-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml b/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
> new file mode 100644
> index 000000000000..5ff5b6a4a0b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ambarella,cv75-rct.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ambarella CV75 RCT Clock Controller
> +
> +maintainers:
> +  - Long Zhao <longzhao@ambarella.com>
> +
> +description: |
> +  The RCT (Reset and Clock Tree) block on the Ambarella CV75 SoC provides
> +  PLLs, clock muxes and dividers for on-chip peripherals.
> +
> +  The same register region is also exposed as a syscon for other drivers
> +  (e.g. pin drive-strength), hence the "syscon" compatible.
> +
> +  Clock indices are defined in
> +  include/dt-bindings/clock/ambarella,cv75-clock.h:
> +
> +  - CV75_GCLK_UART0: UART0 mux/div clock
> +  - CV75_GCLK_CORE: Core PLL (gclk_core)
> +  - CV75_GCLK_AHB: AHB bus clock (core / 2)
> +  - CV75_GCLK_APB: APB bus clock (core / 4)
> +
> +allOf:
> +  - $ref: /schemas/mfd/syscon-common.yaml#

Drop this.

> +
> +properties:
> +  $nodename:
> +    pattern: "^clock-controller(@.*)?$"

"^clock-controller@"

unit-address is not optional.

> +
> +  compatible:
> +    items:
> +      - const: ambarella,cv75-rct
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: Reference crystal oscillator (typically 24 MHz)
> +    maxItems: 1
> +
> +  clock-names:
> +    const: osc
> +
> +  "#clock-cells":
> +    const: 1
> +

> +  assigned-clocks: true
> +
> +  assigned-clock-parents: true
> +
> +  assigned-clock-rates: true

Drop. These are implicitly allowed for any node with 'clocks'.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#clock-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ambarella,cv75-clock.h>
> +
> +    / {
> +        compatible = "ambarella,cv75-evk", "ambarella,cv75";
> +        #address-cells = <2>;
> +        #size-cells = <2>;

Drop all this, not relevant to this binding.

> +
> +        osc: oscillator {
> +            compatible = "fixed-clock";
> +            #clock-cells = <0>;
> +            clock-output-names = "osc";
> +            clock-frequency = <24000000>;
> +        };

Drop. We don't put providers in examples.

> +
> +        rct: clock-controller@ed080000 {
> +            compatible = "ambarella,cv75-rct", "syscon";
> +            reg = <0xff 0xed080000 0x0 0x1000>;
> +            clocks = <&osc>;
> +            clock-names = "osc";
> +            #clock-cells = <1>;
> +
> +            assigned-clocks = <&rct CV75_GCLK_UART0>;
> +            assigned-clock-parents = <&osc>;
> +            assigned-clock-rates = <24000000>;
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/ambarella,cv75-clock.h b/include/dt-bindings/clock/ambarella,cv75-clock.h
> new file mode 100644
> index 000000000000..3d3314446e75
> --- /dev/null
> +++ b/include/dt-bindings/clock/ambarella,cv75-clock.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Copyright (C) 2026 Ambarella, Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_AMBARELLA_CV75_CLOCK_H
> +#define _DT_BINDINGS_CLOCK_AMBARELLA_CV75_CLOCK_H
> +
> +/* Boot / bus clocks */
> +#define CV75_GCLK_UART0                0
> +#define CV75_GCLK_CORE         1
> +#define CV75_GCLK_AHB          2
> +#define CV75_GCLK_APB          3
> +
> +#define CV75_CLK_NUM           4
> +
> +#endif
> --
> 2.34.1
> 
> NOTE: This email (including attachments) contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.

You must remove this or we can't do anything with your patches.

Rob
