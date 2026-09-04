Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BCD4C0439;
	Fri,  4 Sep 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533130; cv=none; b=QsjpzgNP7+dvxHJ8Temt4N7rXS3wJpIQnOlIKlJ+XULhgrJNn5dxlg2oK2lGIexXAZXsPVCv76dU/ZX6UEMvrFCF3fKJl5ucoUcgaTEq3sep67TVWF9D8wbFoSWsDk4XthYpxriQz4ymESd0sOFInjm0dz3aLrl5Wm+kC60inZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533130; c=relaxed/simple;
	bh=z40PlCcBMbHpLqAuaCFHvHiEa61oCALcMXpCz+OzGjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irmHKozXXMgcaQ7hKdLAYM1p2XficsaTTEB4LT1yZXm/lFbjZR4yRnrGhMd9bENkk1cze6Ct7m7gzHZGtQH7JQY7Bc1HrFE2hoh5LyQN39LsFdSDgTFjwxl5ZE9l39PlSsTm1tbL/E7rkkG3Vr9XceqZwVhJYCeS56G6Le6KLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKKsQRV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKKsQRV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B641F00A3D;
	Fri,  4 Sep 2026 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788533128;
	bh=LHADSBXrcRzI2pjE8Mt5DYoJu2ZeRffm/k2PyoibQUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bKKsQRV+2W8er9W9zPMxZVTQT9FXVczm0YCODHPaQKTW6Idf3VqWYDSXczRD4OOP+
	 iNbsQJjqHF9WA2hMn1R71omIQ7U5KN5gUaJr0j8OrEBhC5b4RDCR0pXzcA5rXfLHiD
	 xB5GiekqsUIKLQmk5cG9lWaKNpw3Ggb6kzeEfx3C2YmdiZ1kgrALE0azCLwZZ9raPP
	 LjQpDBvJRUnlaYc+IUUedU+VLlL1uooExGNgzPeQ1mFshbVv41yzzVUeAqg2P8+duB
	 RLx1nIUjLnZrsG75K6fKNuMDaF2jX8T6Jr5DPOLQxtAPaR8f7wLXr++b0JWKfePYeX
	 LcVkugdihZnIQ==
Date: Fri, 4 Sep 2026 09:45:25 -0500
From: Rob Herring <robh@kernel.org>
To: Long Zhao <longzhao@ambarella.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>,
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/13] dt-bindings: gpio: pl061: add Ambarella CV75
 variant
Message-ID: <20260904144525.GA582418-robh@kernel.org>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-5-e918514cb3b1@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-cv75-v5-v6-5-e918514cb3b1@ambarella.com>

On Fri, Sep 04, 2026 at 02:38:12PM +0800, Long Zhao wrote:
> Document the Ambarella CV75 GPIO bank compatible and the synthetic
> arm,primecell-periphid used with the PL061 binding.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../devicetree/bindings/gpio/pl061-gpio.yaml       | 32 +++++++++++++++++++---
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
> index 4d970e55104b..5a6d95e84df2 100644
> --- a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
> @@ -15,7 +15,9 @@ select:
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
> @@ -24,9 +26,13 @@ properties:
>      pattern: "^gpio@[0-9a-f]+$"
>  
>    compatible:
> -    items:
> -      - const: arm,pl061
> -      - const: arm,primecell
> +    oneOf:
> +      - items:
> +          - const: arm,pl061
> +          - const: arm,primecell
> +      - items:
> +          - const: ambarella,cv75-gpio
> +          - const: arm,primecell

items:
  - enum:
      - ambarella,cv75-gpio
      - arm,pl061
  - const: arm,primecell


>  
>    reg:
>      maxItems: 1
> @@ -46,6 +52,10 @@ properties:
>  
>    clock-names: true
>  
> +  arm,primecell-periphid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Override for the PrimeCell peripheral ID.

Add a $ref to primecell.yaml at the top level and drop this.

> +
>    "#gpio-cells":
>      const: 2
>  
> @@ -64,6 +74,20 @@ required:
>    - "#gpio-cells"
>    - gpio-controller
>  
> +allOf:
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
>  additionalProperties: false

And this will need to be unevaluatedProperties.

Rob
