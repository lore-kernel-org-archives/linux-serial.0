Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F981CD13;
	Sun,  4 Aug 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722761005; cv=none; b=VaXO8pfnHn6+ixrKQfyygWuHxdz/jN/RdJORIUP7AEsrvhICNQfmZjBfuGo10z9w3gf4Gpa2zyq0/BlKJxBrCKpMb19ifKMmHexBCdDu9addqQwBlgcjSTzSGFp0iT/qU7BqQGA/lJsRG1CX/jXvb05btTOprJhjv13WklVJv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722761005; c=relaxed/simple;
	bh=yu8JR2r310uHdZfQ80kMnDz/ATjnOx1BnBm1P51VF6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJf5ARicYHDiF34U76mXCty/+JOPau7/sY0OxPZahX/K7L0awxdnA4wyI3AWQfLkxiqoSRm44aYeJeHF11WnBNpJhb3mvOyqHUObmLsD7fzGLabMBOY7yIDhHPrsdTar7OE1/xA0Onps6fdI7x0V8EGKPz6z3VlZ+Jsy/P/pL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/PUAMkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/PUAMkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C6FC32786;
	Sun,  4 Aug 2024 08:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722761004;
	bh=yu8JR2r310uHdZfQ80kMnDz/ATjnOx1BnBm1P51VF6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l/PUAMkNTce527p75JtliDIMQQMoAnAXKNAJrMhcBllpsGng7p8HDocFwujQryWYb
	 eWDNcG3BcO4nMofMjJbG18eh4CXGkVxmIlSo1uyNlwnuA6oOjdwOgLTiqD4hAgX2gp
	 mFpNgU+d0gVSRelJ3DWHaeAKOcu6w4TEXslyDT5u0VoQFkaKF/FVNtYV545SytExNh
	 H2NjRCcYqtIymVw1hCalAMR1Q+WKzoyo2yFFZuZ40IZxPiJj3cCxdy0acO4x8rXDJI
	 U+USs+4McTw7ZWG1sASiNjCwS739VCSyxsgN6grL2NMyIGcNJAdXPHSNTE0xuGIwjs
	 RSnBxdHRg5MbQ==
Message-ID: <4d1f2426-b43c-4727-8387-f18edf937163@kernel.org>
Date: Sun, 4 Aug 2024 10:43:18 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: Add Loongson UART controller
To: zhenghaowei@loongson.cn, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 p.zabel@pengutronix.de
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20240804063834.70022-1-zhenghaowei@loongson.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240804063834.70022-1-zhenghaowei@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/08/2024 08:38, zhenghaowei@loongson.cn wrote:

Due to lack of changelog, I assume you send the same patch, so:

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

Also:

> +
> +  clocks:
> +    maxItems: 1
> +
> +  fractional-division:

Where are this and following defined? In which schema?

> +    description: Enables fractional-N division. Currently,
> +      only LS2K1500 and LS2K2000 support this feature.
> +
> +  rts-invert:
> +    description: Inverts the RTS value in the MCR register.
> +      This should be used on Loongson-3 series CPUs, Loongson-2K
> +      series CPUs, and Loongson LS7A bridge chips.
> +
> +  dtr-invert:
> +    description: Inverts the DTR value in the MCR register.
> +      This should be used on Loongson-3 series CPUs, Loongson-2K
> +      series CPUs, and Loongson LS7A bridge chips.
> +
> +  cts-invert:
> +    description: Inverts the CTS value in the MSR register.
> +      This should be used on Loongson-2K0500, Loongson-2K1000,
> +      and Loongson LS7A bridge chips.
> +
> +  dsr-invert:
> +    description: Inverts the DSR value in the MSR register.
> +      This should be used on Loongson-2K0500, Loongson-2K1000,
> +      and Loongson LS7A bridge chips.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +allOf:
> +  - $ref: serial.yaml
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> +
> +    serial@1fe001e0 {
> +        compatible = "loongson,ls7a-uart";
> +        reg = <0x0 0x1fe001e0 0x0 0x10>;
> +        clock-frequency = <100000000>;
> +        interrupt-parent = <&liointc>;
> +        interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
> +        fractional-division;
> +        rts-invert;
> +        dtr-invert;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8766f3e5e87e..a6306327dba5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13189,6 +13189,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
>  F:	drivers/i2c/busses/i2c-ls2x.c
>  
> +LOONGSON UART DRIVER
> +M:	Haowei Zheng <zhenghaowei@loongson.cn>
> +L:	linux-serial@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/serial/loongson,ls7a-uart.yaml
> +F:	drivers/tty/serial/8250/8250_loongson.c

There is no such file.

Best regards,
Krzysztof

