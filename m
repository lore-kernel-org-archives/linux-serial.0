Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D1533D6;
	Sat,  5 Sep 2026 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788593517; cv=none; b=ewDiT5vQAR1Ma27EnjjNhP321ISR1h+lwjvGCD+36/hvb5JMcBMYoE5rDuFn29W50FCNxt+Zgc30sQT1TxQ7F8geLEOB+7aoXECoT/ekzweDmrLVXrR4N+WdnO5PygNOFmEbjaPJMPGxy+0/SMbIJrNsyLwyWRvsBmZI9LR7S7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788593517; c=relaxed/simple;
	bh=HzsF5LIPdAlI0Q7emey2p4/Jjga+gEVKbQp8VM0ufeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MffEy2zqI91rX+VM7hyjGJR7j4KpOT163AdUbjqNmIAvWntrh5tgGy2Z9+k/0UO3Zlr9z3IWN6ljR/qYW4cz9uaZK/5aapBxOleaGpJkhr8ZE2ClyPAprOoMGygTJ6hW+gfVAR3RfYZqnsX9+mGf4+SotGAjr+dc1SkoCTg6T0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUKtADE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUKtADE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0601F00A3D;
	Sat,  5 Sep 2026 07:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788593516;
	bh=5mHo8SjrBEf9u+knYT70i14y1p1YkauoIqOw8dwSdZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZUKtADE7/q5bihIeyJGKaiN34x/tEPPmlwf94FRG5ksxOJFpc2EWDERzvKm3E7EPh
	 nY5SduUjFRf+GuNLwsM0Yy1dfCLLVE42Qz1+905hykdZOWaD7XorET+X4jDcHXx9A5
	 kxb4CA0MkX0WYA04HgNOfjhba89aP7HOLBCFtP4FfC2AFqgjYJr4MJyLU+L79CbqLh
	 3bsNRAw/cklQF5/i70AGI5caHLN64yM0GJpClVnH5cRWb8NV312lX4B3DY2rwLYgKD
	 XzPUC22QYcYCsW6BRkkyz2JbQaKpGmqLowrOq2/juYMEhwMEEY6g8YrAAwJuZ8IOtM
	 yEhebg7uf3kqw==
Message-ID: <d96e02ee-86cd-4c55-8ff1-cc247aa22ae5@kernel.org>
Date: Sat, 5 Sep 2026 09:31:50 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: Document WK2xxx SPI UART
 bindings
To: zjzhao@edatec.cn, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org
References: <20260904072027.67473-1-zjzhao@edatec.cn>
 <20260904093341.100826-1-zjzhao@edatec.cn>
 <20260904093341.100826-3-zjzhao@edatec.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260904093341.100826-3-zjzhao@edatec.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/09/2026 11:33, zjzhao@edatec.cn wrote:
> From: zjzhao <zjzhao@edatec.cn>
> 
> Add a DT binding for the WK2xxx SPI to UART bridge ICs (WK2124, WK2132,
> WK2168, WK2202 and WK2204) from WKmic (Chengdu Weikai Microelectronics).
> Each UART channel is described by a serial@N child node that carries its
> own serial and RS-485 properties. Also register the wkmic vendor prefix.
> 
> Signed-off-by: zjzhao <zjzhao@edatec.cn>

Same problems as v1...

1. Name is a copied login.

2. drop second/last, redundant "bindings". The "dt-bindings" prefix is
already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

3. Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also:
https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

> ---
>  .../bindings/serial/wkmic,wk2xxx.yaml         | 115 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  2 files changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml

Filename: wkmic,wk2124.yaml as explained in writing bindings.

> 
> diff --git a/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml b/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml
> new file mode 100644
> index 000000000000..c781482c0f2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml
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
> +
> +description:
> +  The WK2xxx family (WK2124, WK2132, WK2168, WK2202 and WK2204) are SPI to
> +  UART bridge ICs from WKmic (Chengdu Weikai Microelectronics). Each IC
> +  exposes two or four full-duplex UART channels with 256-byte RX/TX FIFOs
> +  through a single SPI slave interface and one interrupt line. Each channel
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
> +      Crystal or external clock frequency for the IC in Hz. The WK2xxx has
> +      no internal clock, so this must match the connected crystal.

Then this is a clock input, no? Use proper clocks in such case. Property
is discouraged.

> +    default: 11059200
> +    minimum: 1
> +    maximum: 30000000
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
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        serial@0 {
> +            compatible = "wkmic,wk2132";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            clock-frequency = <11059200>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            serial@0 {
> +                reg = <0>;
> +            };
> +
> +            serial@1 {
> +                reg = <1>;
> +                rs485-rts-active-low;
> +                linux,rs485-enabled-at-boot-time;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index ba2002969373..654fc8525559 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1907,6 +1907,8 @@ patternProperties:
>      description: Wireless Tag (qiming yunduan)
>    "^wits,.*":
>      description: Shenzhen Merrii Technology Co., Ltd. (WITS)
> +  "^wkmic,.*":
> +    description: Chengdu Weikai Microelectronics Co., Ltd.

What is the website URL?

>    "^wlf,.*":
>      description: Wolfson Microelectronics
>    "^wm,.*":


Best regards,
Krzysztof
