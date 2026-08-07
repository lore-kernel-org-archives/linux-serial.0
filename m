Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6804477E5;
	Fri,  7 Aug 2026 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082574; cv=none; b=ooye2mwd3RSnCj1RpuZrV9FVln5jnFVeavJCuDLleVKV8J52vpZkg/x4I84LR/kgQdWOjVmanVzWlpQbffmFaJ5jJohpF0lqP6y0b95e5JqM2g+TKIDPIwpV2bBC8BzK+zjRz1zc96xFGgRh6qS9VWALMjI1M2y2Ps303Q32TIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082574; c=relaxed/simple;
	bh=hsU6zjEBxyI7ynx446bxCARVQEa/lhayq7hcka7c4tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqrae+dzl/6+/hrEZ+GwWBk/XmBB9QdXERjfNhs1Cek3WxSY1vuvUCL+fStkm/W0cGBAfV3eoBmaUZQubLydsztt4BaohnYYIQoppdM3fcsH4KCCZjuHDaZ5le1REzz19DRiS9cGGkzZGSOUSDJqnhDPE7E7L6nabeHdWCnR4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llhmIwY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llhmIwY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CA81F000E9;
	Fri,  7 Aug 2026 06:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786082572;
	bh=jN7NwkzTocd2FlSwa1R0rfmLdiaXf+uOPMz4D3ztXas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=llhmIwY66ZzJWc26yOgFnh1pPrPXqMm9fdc3Ke9nrfKtQdf1AxUZq+yrWvCwIHPlm
	 bdqE28A71H2FJfUW+hc5Sr1E4jX0EcGUpQQwwFR6bcwijvWrm4XBuQlkYR+vdbbRlu
	 j3XGg0Rb63ZqFeZlhkEOxPhdobk/qFiaE9jx9joYRXvj/hjoVO0l/eYIP5OM0FBJcO
	 lfpjbZs/KknLLqyf2k3nemuo7cwn8zXER/IZMtxuKLXawAoXfqXIHmNfyuM5ncIFse
	 j/G0YdbCSsG2Z73luIkRBzI1JOcZV0inZLtH1s1oqeIE9z3ZqaHzi9JLtJowERzJ/3
	 DQ8YZkwNJMyEA==
Date: Fri, 7 Aug 2026 08:02:48 +0200
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
Subject: Re: [PATCH v2 03/10] dt-bindings: clock: add Ambarella CV75 RCT
 clock controller
Message-ID: <20260807-horned-blazing-whippet-c3eb73@quoll>
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-3-6b09707c5fe9@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-3-6b09707c5fe9@ambarella.com>

On Thu, Aug 06, 2026 at 05:34:11PM +0800, Long Zhao wrote:
> Add the CV75 RCT clock controller binding and clock ID header.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../bindings/clock/ambarella,cv75-rct.yaml         | 66 ++++++++++++++++++++++
>  include/dt-bindings/clock/ambarella,cv75-clock.h   | 17 ++++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml b/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
> new file mode 100644
> index 000000000000..aa96533bab9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
> @@ -0,0 +1,66 @@
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
> +  The same register region is also exposed as a syscon for other SoC
> +  blocks (e.g. pin drive-strength), hence the "syscon" compatible.
> +
> +  Clock indices are defined in
> +  include/dt-bindings/clock/ambarella,cv75-clock.h:
> +
> +  - CV75_GCLK_UART0: UART0 mux/div clock
> +  - CV75_GCLK_CORE: Core PLL (gclk_core)
> +  - CV75_GCLK_AHB: AHB bus clock (core / 2)
> +  - CV75_GCLK_APB: APB bus clock (core / 4)
> +
> +properties:
> +  $nodename:
> +    pattern: "^clock-controller@"

Drop nodename.

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
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@ed080000 {
> +        compatible = "ambarella,cv75-rct", "syscon";
> +        reg = <0xed080000 0x1000>;
> +        clocks = <&osc>;
> +        clock-names = "osc";
> +        #clock-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/ambarella,cv75-clock.h b/include/dt-bindings/clock/ambarella,cv75-clock.h
> new file mode 100644
> index 000000000000..3d3314446e75
> --- /dev/null
> +++ b/include/dt-bindings/clock/ambarella,cv75-clock.h

Filenames must be the same.

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
> +#define CV75_GCLK_UART0		0
> +#define CV75_GCLK_CORE		1
> +#define CV75_GCLK_AHB		2
> +#define CV75_GCLK_APB		3
> +
> +#define CV75_CLK_NUM		4

Drop, not a binding.

> +
> +#endif
> 
> -- 
> 2.34.1
> 
