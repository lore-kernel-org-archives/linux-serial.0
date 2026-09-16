Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426B94E80BF;
	Wed, 16 Sep 2026 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554112; cv=none; b=OsmLvLZc1XJ2dv9bj4F3prYAtC5Yesjrmvro5+d0TgeDT3KCl7bUa3vInAM9Eh38GvzwAh811mHmCDSl9zQ3OyA/PGZITXfVs8WasdFYIiqT8noYI+M1fg3pPFvmzq163zXxgQufWBUHtywdJ1cFYxLeT4abgA6DbAl7/K7s9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554112; c=relaxed/simple;
	bh=n152J+oW0inBpcepl+1yWkdMqbhm6d/xZ403pWrV3Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5O3pF5JLmMFyV74eljYMuqeHIHUtIRNdjLbHb5Ur8HW8UXbTj+w1fgnfyVqCIFXUrHfPu6CPtsTDJTz4riNYguiCsOJSKEVGbxJBTJ0DRw12QLuNcLzNN95yjfYigWFbrwHUypn1XfP2Ynm8I/j2mNT643/djgX90tWuR3w7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNz56Cnk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNz56Cnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789554094; x=1821090094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n152J+oW0inBpcepl+1yWkdMqbhm6d/xZ403pWrV3Ew=;
  b=iNz56CnkopDNW1QLXWeZ72rrUCZndyI3DOTe7pKnXKArlq1SvHhhffwq
   ih5iolx4Y9dPQRIttQQeDzwNxngOsAGsGxhurv42Y7XdLuW8T4T9ro37q
   JBVtwDWAWloAFxI19HdR2ziT4wlnIfTiMB6cVjIDDgYw4Sl6scxJEvjhc
   fCUNhChcRltb3fEOVf1FvwssKqHVsT0rLj92i/1UceEHHY52x2piUwQZu
   VwPiPGeicNqEfgMNe3pRySXZ3QQy/nro417nMQDj3Dt/9HBpcIhaoWnld
   088iFY3lQXOVGtFJ29DjmjWo0WbDizOvLkuPW8H1m8TD14Lr/yHxZzBlT
   A==;
X-CSE-ConnectionGUID: vXszHvNLRh+aZdznTx1vVQ==
X-CSE-MsgGUID: /M0pCoGMRUeYk4eRSvs0rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89062964"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89062964"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 03:21:29 -0700
X-CSE-ConnectionGUID: DcsR/rdNR8SqKlqBIDDynw==
X-CSE-MsgGUID: 6lqV8nerQouNtUP4U2SofA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273266901"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 03:21:24 -0700
Date: Wed, 16 Sep 2026 13:21:21 +0300
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
Subject: Re: [PATCH v7 10/15] gpio: pl061: convert to gpio-regmap and a
 custom irqchip
Message-ID: <aqptoZYyclWSE_-A@ashevche-desk.local>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-10-3297d3fbc9c0@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-cv75-v5-v7-10-3297d3fbc9c0@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 15, 2026 at 07:15:40PM +0800, Long Zhao via B4 Relay wrote:
> 
> Move line get/set/direction onto gpio-regmap. Keep the existing ARM
> masked data addresses and write-after-direction behaviour.
> 
> Do not use gpiochip irqchip setup (girq) or regmap-irq. gpio-regmap
> owns gpiochip registration, so girq would have to be plumbed through
> that helper. PL061 IRQ type programming needs IS/IBE/IEV, including
> both-edge, plus a hardirq chained demux from the parent AMBA IRQ;
> regmap-irq is a poor fit for that.
> 
> Create a linear irq_domain with gpio_chip as host data, attach it with
> gpiochip_irqchip_add_domain(), and chain the parent IRQ in this driver.

Besides some comments below about splitting more of this patch to better
isolated logical changes, this one can also be split to a few stages. For
example, one stage is to move to regmap (from direct MMIO access) without
really switching over to gpio-regmap.

...

> +#include <linux/err.h>
>  #include <linux/errno.h>

Now errno.h can be removed as basic errno is provided by err.h.

...

> -#include <linux/irqchip/chained_irq.h>

> +#include <linux/irqchip/chained_irq.h>

Unneeded churn.

...

> -	if ((trigger & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) &&
> -	    (trigger & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)))
> -	{

> +	if ((trigger & IRQ_TYPE_LEVEL_MASK) && (trigger & IRQ_TYPE_EDGE_BOTH)) {

See below, this belongs to a separate change.

...

> @@ -142,14 +121,19 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
>  		return -EINVAL;
>  	}
>  
> -
>  	raw_spin_lock_irqsave(&pl061->lock, flags);

Stray change. If required, should be in a separate patch.

...

> -	if (trigger & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) {
> +	if (trigger & IRQ_TYPE_LEVEL_MASK) {

This change should be in a separate patch.

...

> -	writeb(gpiois, pl061->base + GPIOIS);
> -	writeb(gpioibe, pl061->base + GPIOIBE);
> -	writeb(gpioiev, pl061->base + GPIOIEV);
> +	ret = regmap_write(pl061->regmap, regs->is, gpiois);
> +	if (ret)
> +		goto out;
> +	ret = regmap_write(pl061->regmap, regs->ibe, gpioibe);
> +	if (ret)
> +		goto out;
> +	ret = regmap_write(pl061->regmap, regs->iev, gpioiev);
> +	if (ret)
> +		goto out;
> +	if (pl061->data->clear_irq_on_type)
> +		ret = regmap_write(pl061->regmap, regs->ic, bit);
>  
> +out:
>  	raw_spin_unlock_irqrestore(&pl061->lock, flags);
> -
> -	return 0;
> +	return ret;

Make an additional patch to move current driver to use cleanup.h, id est
guard()() and possibly scoped_guard() from there.

Then in this patch those ton's of goto:s should be replaced with simple
'return ret;'.`

>  }

...

> +	if (!regmap_read(pl061->regmap, pl061->data->regs->mis, &mis) && mis) {

Why not handling error properly here?

	ret = regmap_read(...);
	if (ret)
		goto out_irq_exit;

> +		pending = mis;
> +		for_each_set_bit(offset, &pending, pl061->data->ngpio)
> +			generic_handle_domain_irq(pl061->irq_domain, offset);
>  	}

...

> +static int pl061_irq_domain_map(struct irq_domain *d, unsigned int virq,
> +				irq_hw_number_t hwirq)
> +{
> +	struct gpio_chip *gc = d->host_data;
> +	struct pl061 *pl061 = pl061_from_gpio_chip(gc);
> +
> +	irq_set_chip_data(virq, gc);
> +	irq_set_chip_and_handler(virq, &pl061_irqchip, handle_bad_irq);
> +	irq_set_noprobe(virq);
> +	irq_set_parent(virq, pl061->parent_irq);


Is lockdep happy with this?

> +	return 0;
> +}

...

> +static void pl061_remove_irq(void *data)
> +{
> +	struct pl061 *pl061 = data;
> +
> +	irq_set_chained_handler_and_data(pl061->parent_irq, NULL, NULL);
> +
> +	for (unsigned int i = 0; i < pl061->data->ngpio; i++) {

> +		unsigned int virq = irq_find_mapping(pl061->irq_domain, i);

Split assignment

		unsigned int virq;

		virq = irq_find_mapping(pl061->irq_domain, i);
		if (virq)

> +		if (virq)
> +			irq_dispose_mapping(virq);
> +	}
> +
> +	irq_domain_remove(pl061->irq_domain);
> +}

...

>  	struct device *dev = &adev->dev;
> +	const struct pl061_drvdata *data = id->data;

Split assignment as it is validated later on.

> +	const struct pl061_regs *regs;
> +	struct gpio_regmap_config config = {};
> +	struct gpio_regmap *gpio_regmap;
> +	struct gpio_chip *gc;
>  	struct pl061 *pl061;
> -	struct gpio_irq_chip *girq;
> +	void __iomem *base;
>  	int ret, irq;
>  
> +	if (!data)
> +		return -EINVAL;

-ENODATA?

> +	regs = data->regs;

...

> +	for (offset = 0; offset < pl061->data->ngpio; offset++) {
> +		if (!(dir & BIT(offset)))
> +			continue;

for_each_set_bit(), but make sure the type of the variable is unsigned long
(might require a temporary one).

> +		ret = regmap_read_bypassed(pl061->regmap,
> +					   BIT(offset + PL061_DATA_OFFSET),
> +					   &val);
> +		if (ret)
> +			return ret;
> +		pl061->saved_dat |= val;
>  	}

...

> +	for (offset = 0; offset < pl061->data->ngpio; offset++) {
> +		if (!(dir & BIT(offset)))
> +			continue;

Ditto.

> +		ret = regmap_write(pl061->regmap,
> +				   BIT(offset + PL061_DATA_OFFSET),
> +				   !!(pl061->saved_dat & BIT(offset)) << offset);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return regcache_sync_region(pl061->regmap, regs->is, regs->ie);
>  }

...

> static const struct amba_id pl061_ids[] = {
>  	{
>  		.id	= 0x00041061,
>  		.mask	= 0x000fffff,
> +		.data	= (void *)&pl061_arm,

Oh, this is something that needs to be fixed (but it's not your issue).
Why on earth this is not const?

>  	},
>  	{ 0, 0 },
>  };

-- 
With Best Regards,
Andy Shevchenko


