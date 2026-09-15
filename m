Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD44AA3F7;
	Tue, 15 Sep 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486260; cv=none; b=suKYoOIxr6+Ggud9Nylz18N9cRyotWRY5WIsx0JTtOzGlEIZMVrALqGR0sfI0FQWn9JdG0gW5bEb9Lhe/eagmLiZjqR9krxEWXM8uHwW1oNiCffTWco6VzM+FH1uiqpyeORl6PBBiXua6kMjzyN4uroBszsE4dlscVY0M3uXoi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486260; c=relaxed/simple;
	bh=g8LXI+FLmIC86HxvAHNU7lIP6/5lrj8l5npIS9TK1TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/u7NH05Wn6KOclRrmjZnVfpa6IGOsgpvLp6lMbaaS5QonucsGfMBBg3ht+g0543abNUWoDM80WtFkliJoX+mCuKqpLSlsJsQEaGvGFau68wQ4MH7dgUmfSS93SOZWgJlFN0gpUaL+r8/0plD8HYbl2CZLd6nabX71to8DfKWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr3qnXCc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mr3qnXCc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789486254; x=1821022254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g8LXI+FLmIC86HxvAHNU7lIP6/5lrj8l5npIS9TK1TE=;
  b=Mr3qnXCcGwEPuTkdF+lpTH28VhpIDJh6IazWU1A+nV6uPLS2EaDubZs6
   OVdowbEn8lhshHCJiSq2G1/QXFNX62i0odnxIwngcPIN704yjWgFL0EU5
   Resd0UtZ6Ffsp4Wm8ovbzs5uqImRL+H4sw78bnBQ45yua5ky8Y5HTz+IQ
   3aala5GaoPc3BNZT4t+2sKNYNJTyTK8BpezGIBSeoBwgi2WqGuNgE3C2V
   o1x8rm3t9BVsW+b+JNFmLLWL49QQ5RAdRJpDAKFNMJ9twykZB90737wDe
   kNFhy03i9jDALpHLrmeyBNpqJapdqQYLpUNdXq1qxk0fz9TWS6RB011wL
   A==;
X-CSE-ConnectionGUID: KT3oeAHqSCGkBo32Wsx0Xw==
X-CSE-MsgGUID: A98FRR3xSvi6YbTrBRJ3uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101202655"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101202655"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 08:30:47 -0700
X-CSE-ConnectionGUID: 6C7AqoZuRhSZQAKatvE9Iw==
X-CSE-MsgGUID: L/Rwoq4CRxqPHw3+KDO9Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="302924565"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.57])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 08:30:41 -0700
Date: Tue, 15 Sep 2026 18:30:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>,
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/15] gpiolib: regmap: add gpio_regmap_get_chip()
Message-ID: <aqlknvOejkE5zutq@ashevche-desk.local>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-9-3297d3fbc9c0@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-cv75-v5-v7-9-3297d3fbc9c0@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 15, 2026 at 07:15:39PM +0800, Long Zhao via B4 Relay wrote:

> Let drivers that implement a custom irqchip retrieve the gpio_chip
> after registration. Attach a caller-provided irq_domain only when it
> is present.

...

>  struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config)
>  {
> -	struct irq_domain *irq_domain;
>  	struct gpio_regmap *gpio;
>  	struct gpio_chip *chip;
>  	int ret;

>  #ifdef CONFIG_REGMAP_IRQ
>  	if (config->regmap_irq_chip) {
> +		struct irq_domain *irq_domain;
> +
>  		gpio->regmap_irq_line = config->regmap_irq_line;
>  		ret = regmap_add_irq_chip_fwnode(dev_fwnode(config->parent), config->regmap,
>  						 config->regmap_irq_line, config->regmap_irq_flags,
> @@ -420,12 +427,15 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
>  			goto err_remove_gpiochip;
>  
>  		irq_domain = regmap_irq_get_domain(gpio->irq_chip_data);
> +		if (irq_domain) {
> +			ret = gpiochip_irqchip_add_domain(chip, irq_domain);
> +			if (ret)
> +				goto err_remove_gpiochip;
> +		}
>  	} else
>  #endif
> -	irq_domain = config->irq_domain;
> -
> -	if (irq_domain) {
> -		ret = gpiochip_irqchip_add_domain(chip, irq_domain);
> +	if (config->irq_domain) {
> +		ret = gpiochip_irqchip_add_domain(chip, config->irq_domain);
>  		if (ret)
>  			goto err_remove_gpiochip;
>  	}

I do not understand how it's different from the original one. Can you elaborate?

-- 
With Best Regards,
Andy Shevchenko


