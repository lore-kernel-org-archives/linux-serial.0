Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE7344E02A;
	Fri,  2 Oct 2026 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929594; cv=none; b=CS+rAXLxizIm8AnpAJwWG/4ImGLuiY2SQtzeNWlrURA+umipCDbj26b4XFymdZnDniAF8a/C63TgW6rlnPDkM3gmKZVpNbSqT5ePIq8+7DU9Aw+j5fpqdbpkog8Gc4rucXYS5YphYj35d9DUcolv3Gl4LBHmT6BFx7E7HTgYBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929594; c=relaxed/simple;
	bh=siUcSXucLvCnlrb1Xgp4F7mBAS3yKi85NsJq4r2dfs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L33gLh7NYVuiR+huNij2HIcoHBnFsffkGyMDK6pLc0lbscRyqnRTMt7fm9y215SIekpW5Bjh/p4tKcCkO4wzmIByWj2V/TSRr2IUqGZs685xoLvqEVbpchSqoG9L0XlAdhVYdlcmmspgTVA8Hd+K+ii8oFH0dDS4HU/Lf4aeD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2DfacJd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2DfacJd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790929591; x=1822465591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=siUcSXucLvCnlrb1Xgp4F7mBAS3yKi85NsJq4r2dfs0=;
  b=R2DfacJdUc2QFaJKlpqs65hUfHLqaW+qz4flJ/SjCEpiLWPCvxrf1fa+
   Kvw1aI3aw2nKRiGBZ6Da4MRd3rWZktYCKzuAzfU9oNzZKLGspRMVfLkt2
   L7NfgHXi6/9wUGxm9uw5mkQ+mml25Pfe0MkXUQ7Kajwih90nMed0PxqeD
   olWHnChkeJ/yAWeLjHYSkUitPdeGGyyPwpkL04p6TTx6y1uopdVxlyxKk
   5apW6Ik9nwHdjgZnMnGM94TLYl8k/9NOEVylRyGH5OMkaw81HXXzXi5+M
   vBnvCYzunBslEMUJus6JnbUt41VxKe5tG3OEAhUWeyTeVS8tbaviD7vBE
   g==;
X-CSE-ConnectionGUID: dX22DuZ3Sv6ml/TXZrL1aw==
X-CSE-MsgGUID: NipYh+BhRyqnFyr9R93bFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90554348"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90554348"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 01:26:22 -0700
X-CSE-ConnectionGUID: v07VLHlTTZW/gpl9yVKxbA==
X-CSE-MsgGUID: AQTsk4EpQmuB2buWgQXH1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="284264249"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 01:26:15 -0700
Date: Fri, 2 Oct 2026 11:26:13 +0300
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
	Michael Walle <mwalle@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>,
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 08/15] gpio: pl061: convert register access to regmap
Message-ID: <ar9qpeOCU0fpmhse@ashevche-desk.local>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-8-486cc289a4b8@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-cv75-v5-v9-8-486cc289a4b8@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 08:40:57PM +0800, Long Zhao via B4 Relay wrote:

> Replace readb()/writeb() with a MMIO regmap while keeping the existing
> gpio_chip and girq irqchip. Use a raw spinlock so irq_ack() can run
> under the irq descriptor lock.

...

>  static int pl061_get_direction(struct gpio_chip *gc, unsigned offset)
>  {
>  	struct pl061 *pl061 = gpiochip_get_data(gc);
> +	unsigned int gpiodir = 0;
>  
> -	if (readb(pl061->base + GPIODIR) & BIT(offset))
> +	regmap_read(pl061->regmap, GPIODIR, &gpiodir);

Why not returning an error?

> +	if (gpiodir & BIT(offset))
>  		return GPIO_LINE_DIRECTION_OUT;
>  
>  	return GPIO_LINE_DIRECTION_IN;

I believe this can use regmap_test_bits().

...

> static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
>  {
>  	struct pl061 *pl061 = gpiochip_get_data(gc);
>  	unsigned long flags;
> -	unsigned char gpiodir;
>  
>  	raw_spin_lock_irqsave(&pl061->lock, flags);
> -	gpiodir = readb(pl061->base + GPIODIR);
> -	gpiodir &= ~(BIT(offset));
> -	writeb(gpiodir, pl061->base + GPIODIR);
> +	regmap_update_bits(pl061->regmap, GPIODIR, BIT(offset), 0);

_clear_bits()

>  	raw_spin_unlock_irqrestore(&pl061->lock, flags);
>  
>  	return 0;

...

> static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
>  {
>  	struct pl061 *pl061 = gpiochip_get_data(gc);
>  	unsigned long flags;
> -	unsigned char gpiodir;
> +	unsigned int mask = BIT(offset);
>  
>  	raw_spin_lock_irqsave(&pl061->lock, flags);
> -	writeb(!!value << offset, pl061->base + (BIT(offset + 2)));
> -	gpiodir = readb(pl061->base + GPIODIR);
> -	gpiodir |= BIT(offset);
> -	writeb(gpiodir, pl061->base + GPIODIR);
> +	regmap_write(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
> +		     !!value << offset);

_set_bits()

> +	regmap_update_bits(pl061->regmap, GPIODIR, mask, mask);
>  
>  	/*
>  	 * gpio value is set again, because pl061 doesn't allow to set value of
>  	 * a gpio pin before configuring it in OUT mode.
>  	 */
> -	writeb(!!value << offset, pl061->base + (BIT(offset + 2)));
> +	regmap_write(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
> +		     !!value << offset);

Ditto.

>  	raw_spin_unlock_irqrestore(&pl061->lock, flags);
>  
>  	return 0;

...

> static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
>  static int pl061_get_value(struct gpio_chip *gc, unsigned offset)
>  {
>  	struct pl061 *pl061 = gpiochip_get_data(gc);
> +	unsigned int val = 0;
> +
> +	regmap_read(pl061->regmap, BIT(offset + PL061_DATA_OFFSET), &val);
>  
> -	return !!readb(pl061->base + (BIT(offset + 2)));
> +	return !!val;

_test_bits()

>  }

...

...and so on...

-- 
With Best Regards,
Andy Shevchenko


