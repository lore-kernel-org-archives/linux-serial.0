Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED02391842;
	Fri, 18 Sep 2026 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715738; cv=none; b=ulj98p/qUCG9J1ztGJdFgfhL3P1TO69oIu8Pny+xHb2unEKAfNO3H3jzahWmtP7kZLRXSOmUhMGMYlzIUS2fBOKU/qLb/znfPSSipi/7Lr4+Ywoq+1JIXRkYQgSl22Xcuagzc3vge/ojdcFVpc50zd0eE5sEiGkeukOxGiEstH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715738; c=relaxed/simple;
	bh=IyQG4uF4U2HMYFS0whlenRlq0+4izpBq85YAFExkrKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDjMH4h+zmyPI1Af5WNUMlsKY/qPyC1fOYokACApIey0BCZHAFftodUORbt4P0Czg59AFqPXpZTratSABZ3XhspF+50p9/67exnLZ3SvZavZsrHR/6xKdd23skUVz85ZhR/p5EyNmL7im0yeSAf/+Quadc8OwecOShkGCf9GMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhrdEkJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhrdEkJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559BC1F00893;
	Fri, 18 Sep 2026 07:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789715725;
	bh=yGXP8T1zvW5Ml5ZoTKLO3915Guu8fl2jGwWEp0ekuH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hhrdEkJPsCM1e0xAT8nx+2dL6Mk346k4lOVF4xldrlPrjN5pRcKLlC36i5umsgAEX
	 Mp9h8oSRLYPkXnX0ofmhNPnYdlFaaDlt75luOA2LPxQMGglwZYxE8YneYoFFIrm9VI
	 BlQBv75lqp6fBDi3G2QcfvUEtdAqHwbvPo2DdlOaS6Q4KNMSO4H/eGby5OJ08w8Jj5
	 Rqe5dl6AsQrb2fKQkEJpUbf3d2BeXzwkYnUjSNr6T93S99i6Iv352HA7tpVBA4Q3UO
	 Lgv9HZaeycMuaLOLue3xeMnw41S7U8WqPV4QoW/jUnIAui9ss1pj6XqDza7wqdaL1k
	 YsEo9YjVPbeIw==
Date: Fri, 18 Sep 2026 09:15:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Long Zhao <longzhao@ambarella.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/15] dt-bindings: gpio: pl061: add Ambarella CV75
 variant
Message-ID: <20260918-affable-aardvark-of-superiority-6a5ed2@quoll>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-5-3297d3fbc9c0@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915-cv75-v5-v7-5-3297d3fbc9c0@ambarella.com>

On Tue, Sep 15, 2026 at 07:15:35PM +0800, Long Zhao wrote:
> Add ambarella,cv75-gpio as a PrimeCell-compatible PL061 variant, with
> arm,primecell-periphid and gpio-ranges required. Reference

You just described the diff, but this should explain why you do these
changes. Why a fixed periphid is needed? Isn't it implied by compatible?

> primecell.yaml and use unevaluatedProperties.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../devicetree/bindings/gpio/pl061-gpio.yaml       | 25 +++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
> index 4d970e55104b..00d0d8ddd2c9 100644
> --- a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
> @@ -15,17 +15,36 @@ select:
>    properties:
>      compatible:
>        contains:
> -        const: arm,pl061
> +        enum:
> +          - arm,pl061
> +          - ambarella,cv75-gpio
>    required:
>      - compatible
>  
> +allOf:

allOf should be placed after "required:" block.

> +  - $ref: /schemas/arm/primecell.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ambarella,cv75-gpio
> +    then:
> +      properties:
> +        arm,primecell-periphid:
> +          const: 0x000e8061
> +      required:
> +        - arm,primecell-periphid
> +        - gpio-ranges
> +
>  properties:
>    $nodename:
>      pattern: "^gpio@[0-9a-f]+$"
>  
>    compatible:
>      items:
> -      - const: arm,pl061
> +      - enum:
> +          - ambarella,cv75-gpio
> +          - arm,pl061

So a PrimeCell-compatible PL061 variant which is not compatible with
PL061? You have entire commit msg to explain that and say something
non-obvious about the hardware.

>        - const: arm,primecell
>  

Best regards,
Krzysztof

