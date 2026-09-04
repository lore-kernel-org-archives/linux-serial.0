Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3B352010;
	Fri,  4 Sep 2026 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527684; cv=none; b=GwSmL/iShmH+8n1693a6yRKNFdlCmu3MXUnu1XcmUxe8ImzoeD2l2lOfQFVxkwYHZW/WQa1EbzWzMuTBmrACfOLTFhvs/9BFv+U73AAKrrugEr9u7u1xr5/OlyP8GJ4o5bUeuxmoBCGswnVUsGZhX9quwZ2AcvsBGALtf2u46Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527684; c=relaxed/simple;
	bh=FYT6/iyY31UJEUUxpTSXKwCdDX8cAQywGqhNs1TpiuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=samzkkq4PQcSyNNeBsHrTEZzOwyLqPY+oycZfMkzNHXjZIm/xCJUmY78W59sG9jR/m+d1UZuGUcbxLmgWjoq2qE6hoj8TYFi0QNNZg+9Vj4NmO6LHWV60D8W5p0sCCuast4Jla77Ro79RTjkWj7k+hfiq5zrT75kdMGfl9YG/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jq/cqtgU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jq/cqtgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788527682; x=1820063682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FYT6/iyY31UJEUUxpTSXKwCdDX8cAQywGqhNs1TpiuM=;
  b=jq/cqtgUgEmOezbKv1II3jAHDim3U//5LZywn0gHJ1LuUsdHjY3bS7gl
   IVP6pIuyYe0ofVYvk04m59A0ZAt+qQQ06qj2CEOdf4/ATK7TUVMkkzTZW
   IQd0+pi/CI8ndtj0iOraFW0qraA1gTcu7v9sTRnAiNFt1h86HcWLtT9mX
   5NQ4l21QsDFNVmOfiB+v+uIkrDPj8sG5SZHq/Oeym2cObB/IFzUCARaJ6
   IJ7yYI5PA4GGyD+s2H9SMa4mWxi+lYi5ebKrcw3J+h59dRT9arvuVRsqY
   iA5Sk6lW4epVRThJuzFNhncCbGNEKw3F8DROgZfu/ZBMSSa+t6kVRA5M9
   Q==;
X-CSE-ConnectionGUID: i7LT8UrZSb6LvcrxB3Ms7Q==
X-CSE-MsgGUID: OeLubQw2SLqfNbKuJJwNnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="91540830"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="91540830"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 06:14:40 -0700
X-CSE-ConnectionGUID: unw6z+dxSXa0kQr2G8pHcA==
X-CSE-MsgGUID: +XaBCkDbTp2V2UqV7nszHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="273823407"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.224])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 06:14:34 -0700
Date: Fri, 4 Sep 2026 16:14:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
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
Subject: Re: [PATCH v6 09/13] gpio: pl061: use gpio-regmap and add Ambarella
 layout
Message-ID: <aprEOB7AZQWNed4D@ashevche-desk.local>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-9-e918514cb3b1@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904-cv75-v5-v6-9-e918514cb3b1@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 02:38:16PM +0800, Long Zhao via B4 Relay wrote:

> Convert PL061 data and direction handling to gpio-regmap while
> keeping the existing PL061 irqchip path.

> Add an Ambarella CV75 register layout variant on the AMBA bus, without
> claiming unverified GPIO suspend/resume support for Ambarella.

This part should be in a separate patch.

So far I see at least 2 patches against gpio-regmap and 2 patches against
gpio-pl061.

...

> +struct pl061_variant_data {
> +	unsigned int data;
> +	unsigned int dir;
> +	unsigned int is;
> +	unsigned int ibe;
> +	unsigned int iev;
> +	unsigned int ie;
> +	unsigned int ris;
> +	unsigned int mis;
> +	unsigned int ic;
> +	unsigned int mask;
> +	unsigned int enable;
> +	unsigned int ngpio;
> +	bool access_32bit;
> +	bool masked_data_address;
> +	bool write_data_after_dir;
> +	bool clear_irq_on_type;
> +	bool pm_save_restore;
> +	const struct regmap_config *regmap_config;
> +};

Should not be like this. Part of it is in the respective regmap config (with
all volatile, precious, et cetera registers, and part of it comes from driver
data (in other words based on the compatible string or other ID).

...

>  struct pl061 {
>  	raw_spinlock_t		lock;
> -

Stray change.

>  	void __iomem		*base;
> -	struct gpio_chip	gc;
> +	const struct pl061_variant_data *variant;
> +	struct gpio_irq_chip	girq;
>  	int			parent_irq;

Here (in this structure) we should get a struct regmap instead of base and
gpio_chip.

>  	struct pl061_context_save_regs csave_regs;

This is not needed, see how gpio-pca953x does that with enabled regmap cache.

>  };

...

> +static u32 pl061_read(struct pl061 *pl061, unsigned int reg)
>  {
> -	struct pl061 *pl061 = gpiochip_get_data(gc);
> -	unsigned long flags;
> -	unsigned char gpiodir;
> +	if (pl061->variant->access_32bit)
> +		return readl(pl061->base + reg);
>  
> -	raw_spin_lock_irqsave(&pl061->lock, flags);
> -	writeb(!!value << offset, pl061->base + (BIT(offset + 2)));
> -	gpiodir = readb(pl061->base + GPIODIR);
> -	gpiodir |= BIT(offset);
> -	writeb(gpiodir, pl061->base + GPIODIR);
> -
> -	/*
> -	 * gpio value is set again, because pl061 doesn't allow to set value of
> -	 * a gpio pin before configuring it in OUT mode.
> -	 */
> -	writeb(!!value << offset, pl061->base + (BIT(offset + 2)));
> -	raw_spin_unlock_irqrestore(&pl061->lock, flags);
> -
> -	return 0;
> +	return readb(pl061->base + reg);
>  }

> -static int pl061_get_value(struct gpio_chip *gc, unsigned offset)
> +static void pl061_write(struct pl061 *pl061, u32 value, unsigned int reg)
>  {
> -	struct pl061 *pl061 = gpiochip_get_data(gc);
> -
> -	return !!readb(pl061->base + (BIT(offset + 2)));
> +	if (pl061->variant->access_32bit)
> +		writel(value, pl061->base + reg);
> +	else
> +		writeb(value, pl061->base + reg);

This is achieved by different regmap config — one for 32-bit, one for 8-bit
access.

>  }

...

I guess it's enough for now. this needs one more round of designing this.

-- 
With Best Regards,
Andy Shevchenko


