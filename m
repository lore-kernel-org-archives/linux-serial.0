Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9437262E;
	Tue,  6 May 2025 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569876; cv=none; b=jku4zqxi4/EyVvhc5YikZpGA0vw0FNaxPsjBxS9HbJCUCdvbKfYG4SEVuL9h1Y329QK4HdYGWuhhfeiwiXPRKzxUZgAmcamsdiOOpmenJHwtvdcqjctDNc/ZwdmSIPKnZ9QIAqUW6u9Fi3dEVDi1rEKLdvGh8rlTi/OrLcLh40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569876; c=relaxed/simple;
	bh=qZH0GlY8+x6orE1nAMK2QAd0Y/5Cgrue4HjmDPfwwCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtK9cG5rS3vkOV76g3LPii3idDafmwCM/dR2Drpk5z15fSDP8KE88aLk059q6ajfym390WEAti3BMG63AcNcjfYM0Y6YdtaQIhd+xX7OrSfciU+zhuk4tG7r8mVTSzssUPlzJoRLyKKMdD+Y+cnG7CQm4fQsNvXm/LBze3PzEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APJI/q06; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APJI/q06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0486AC4CEE4;
	Tue,  6 May 2025 22:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746569875;
	bh=qZH0GlY8+x6orE1nAMK2QAd0Y/5Cgrue4HjmDPfwwCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APJI/q06j2akXY7u2+C+4m0YRb/FnyeGA4Vz87JUAjPBUPMcpOWHKDetoeis/cg5J
	 8lV9WzmyQDMK0MVoZPf/F8OuDSwxtkZSOr/mIWhNpmEnvkb/gRZI+JNsa/YD+1gU4t
	 iCQbo1Ep75GIR4TOqqjgpvzodEpDZbqUyhsmqTHp7yUhp/nX9lG9nGxN657hMCF1WZ
	 9mZPJ5iobHtDCGVSS5VXEQ3yh9zGiUtZo+gqgj6mgaOpeAHISM614F3m8yDR3Wz49g
	 ukqalCat3fCzm1a7Iq+24f0N0x6T6G3stZ6fcb11q4jGnejucTYi+vDN4TtV3ridzP
	 vpgHIW4/HgcKg==
Received: by pali.im (Postfix)
	id 0A00067E; Wed,  7 May 2025 00:17:51 +0200 (CEST)
Date: Wed, 7 May 2025 00:17:51 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] irq-names dt-bindings: serial: Convert
 marvell,armada-3700-uart to DT schema
Message-ID: <20250506221751.t3iwqquzjgysjaai@pali>
References: <20250506220044.2546706-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506220044.2546706-1-robh@kernel.org>
User-Agent: NeoMutt/20180716

On Tuesday 06 May 2025 17:00:41 Rob Herring (Arm) wrote:
> Convert the Marvell Armada-3700 UART binding to DT schema. It is a
> straight-forward conversion.
> 
> Drop the long deprecated single interrupt support.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../serial/marvell,armada-3700-uart.yaml      | 102 ++++++++++++++++++
>  .../devicetree/bindings/serial/mvebu-uart.txt |  56 ----------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 103 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/mvebu-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml b/Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
> new file mode 100644
> index 000000000000..fa454337f06f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/marvell,armada-3700-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Armada-3700 UART
> +
> +maintainers:
> +  - Pali Rohár <pali@kernel.org>
> +
> +description:
> +  Marvell UART is a non standard UART used in some of Marvell EBU SoCs (e.g.
> +  Armada-3700).
> +
> +properties:
> +  compatible:
> +    enum:
> +      - marvell,armada-3700-uart
> +      - marvell,armada-3700-uart-ext
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      UART reference clock used to derive the baud rate. If absent, only fixed
> +      baud rate from the bootloader is supported.
> +
> +  interrupts:
> +    minItems: 2
> +    items:
> +      - description: UART sum interrupt (deprecated single-element form)
> +      - description: UART TX interrupt
> +      - description: UART RX interrupt

I think that this is wrong description and does not match the old txt
description:

- Must contain three elements for the standard variant of the IP
  (marvell,armada-3700-uart): "uart-sum", "uart-tx" and "uart-rx",

- Must contain two elements for the extended variant of the IP
  (marvell,armada-3700-uart-ext): "uart-tx" and "uart-rx",

"UART sum interrupt" is not deprecated, it must be present for the
marvell,armada-3700-uart.

> +
> +  interrupt-names:
> +    minItems: 2
> +    maxItems: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +
> +unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: /schemas/serial.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: marvell,armada-3700-uart-ext
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 2
> +          
> +        interrupt-names:
> +          items:
> +            - const: uart-tx
> +            - const: uart-rx
> +    else:
> +      properties:
> +        interrupts:
> +          minItems: 3
> +
> +        interrupt-names:
> +          items:
> +            - const: uart-sum
> +            - const: uart-tx
> +            - const: uart-rx
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    serial@12000 {
> +        compatible = "marvell,armada-3700-uart";
> +        reg = <0x12000 0x18>;
> +        clocks = <&uartclk 0>;
> +        interrupts =
> +            <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +            <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +            <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "uart-sum", "uart-tx", "uart-rx";
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    serial@12200 {
> +        compatible = "marvell,armada-3700-uart-ext";
> +        reg = <0x12200 0x30>;
> +        clocks = <&uartclk 1>;
> +        interrupts =
> +            <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
> +            <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "uart-tx", "uart-rx";
> +    };
> diff --git a/Documentation/devicetree/bindings/serial/mvebu-uart.txt b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
> deleted file mode 100644
> index a062bbca532c..000000000000
> --- a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -* Marvell UART : Non standard UART used in some of Marvell EBU SoCs
> -                 e.g., Armada-3700.
> -
> -Required properties:
> -- compatible:
> -    - "marvell,armada-3700-uart" for the standard variant of the UART
> -      (32 bytes FIFO, no DMA, level interrupts, 8-bit access to the
> -      FIFO), called also UART1.
> -    - "marvell,armada-3700-uart-ext" for the extended variant of the
> -      UART (128 bytes FIFO, DMA, front interrupts, 8-bit or 32-bit
> -      accesses to the FIFO), called also UART2.
> -- reg: offset and length of the register set for the device.
> -- clocks: UART reference clock used to derive the baudrate. If no clock
> -      is provided (possible only with the "marvell,armada-3700-uart"
> -      compatible string for backward compatibility), it will only work
> -      if the baudrate was initialized by the bootloader and no baudrate
> -      change will then be possible. When provided it should be UART1-clk
> -      for standard variant of UART and UART2-clk for extended variant
> -      of UART. TBG clock (with UART TBG divisors d1=d2=1) or xtal clock
> -      should not be used and are supported only for backward compatibility.
> -- interrupts:
> -    - Must contain three elements for the standard variant of the IP
> -      (marvell,armada-3700-uart): "uart-sum", "uart-tx" and "uart-rx",
> -      respectively the UART sum interrupt, the UART TX interrupt and
> -      UART RX interrupt. A corresponding interrupt-names property must
> -      be defined.
> -    - Must contain two elements for the extended variant of the IP
> -      (marvell,armada-3700-uart-ext): "uart-tx" and "uart-rx",
> -      respectively the UART TX interrupt and the UART RX interrupt. A
> -      corresponding interrupt-names property must be defined.
> -    - For backward compatibility reasons, a single element interrupts
> -      property is also supported for the standard variant of the IP,
> -      containing only the UART sum interrupt. This form is deprecated
> -      and should no longer be used.
> -
> -Example:
> -	uart0: serial@12000 {
> -		compatible = "marvell,armada-3700-uart";
> -		reg = <0x12000 0x18>;
> -		clocks = <&uartclk 0>;
> -		interrupts =
> -		<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> -		<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> -		<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "uart-sum", "uart-tx", "uart-rx";
> -	};
> -
> -	uart1: serial@12200 {
> -		compatible = "marvell,armada-3700-uart-ext";
> -		reg = <0x12200 0x30>;
> -		clocks = <&uartclk 1>;
> -		interrupts =
> -		<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
> -		<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
> -		interrupt-names = "uart-tx", "uart-rx";
> -	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96b827049501..8b1306c14380 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14254,7 +14254,7 @@ MARVELL ARMADA 3700 SERIAL DRIVER
>  M:	Pali Rohár <pali@kernel.org>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
> -F:	Documentation/devicetree/bindings/serial/mvebu-uart.txt
> +F:	Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
>  F:	drivers/tty/serial/mvebu-uart.c
>  
>  MARVELL ARMADA DRM SUPPORT
> -- 
> 2.47.2
> 
