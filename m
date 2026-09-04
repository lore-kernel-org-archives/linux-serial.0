Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBE433E9D;
	Fri,  4 Sep 2026 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522955; cv=none; b=Xv8YGefsHcgl5l0Y1/V5bakgDCjMXCTlDWDyN/BlndoUlcGbsehcJKekty9Ymh47TDGt2Lm8a/7KPvRq/F38zkKGdWR7HSLVLQytHxnKd27Kg7KzwJXLmODmBZTJpzjvoTjnJpaRZ6RM91/5mS0Mvl6Gwx/GcJW2hf8NT8nb/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522955; c=relaxed/simple;
	bh=SQpI4I09fd14R+BxKv83yrD2WKM66SRsC9Z6WdfEhNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0q37qyme7AMQdmgvO1wYnV5B2w10ZbJ41H9Yi79CnoCUmqMcHg5raWtjqfMgral9KbtL/1mMNv6n58mf7ZOEg1jQNslSiK9hHFLv5s9e0B5FIPIKr3x47hWzR4ehwKZ3rsyNMNyNNKlEwZFNWwgEwXhY5/AnJGFYTYbsThlz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBD7niyF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBD7niyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788522954; x=1820058954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SQpI4I09fd14R+BxKv83yrD2WKM66SRsC9Z6WdfEhNU=;
  b=FBD7niyFGUBvRR/kfy0GHYlsX6l5j/utPRm7GtmTSxsLgnDQzURE2w3S
   l6y0aCsOufuBt4hj0L5pooOi31DTXaAcGurouEN1aiBPf6bNJtDc5c1sF
   J7EW8mCE3kOBzUHl9ZSy5On4RRGSmxYmGFNL3i5VbteofRdWBJf6Gjqq+
   FYaiGI3FoZAq5z044fvQKg5PuvwYQNYv2DW5cCsxgeMT7kALPmRXaJUxk
   9jh6Rww3Wo/a7Ot4XY6gX1CG4x5QtAcunwO+tBTU210E6rHHJp/4WPktT
   5AUZ6vQ4Qx46+ZWR/48wiU1XQW9RhJCvy/Z3xSwclPtZYgK1b1USaAlwe
   w==;
X-CSE-ConnectionGUID: /6djwOFdRaW/uvyEPqR3og==
X-CSE-MsgGUID: sdUAvO3jTaajzxOLpAj54w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100381142"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="100381142"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 04:55:53 -0700
X-CSE-ConnectionGUID: 0yJ5hwEYTn+ZBPfL4jfyNQ==
X-CSE-MsgGUID: DK4Sk+7SSmC/yGDtit4SKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="273548667"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.224])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 04:55:47 -0700
Date: Fri, 4 Sep 2026 14:55:45 +0300
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
Subject: Re: [PATCH v6 08/13] gpio: regmap: support write_data_after_dir and
 girq
Message-ID: <apqxwRgi-uVKkOpr@ashevche-desk.local>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-8-e918514cb3b1@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-cv75-v5-v6-8-e918514cb3b1@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 02:38:15PM +0800, Long Zhao via B4 Relay wrote:

Thanks for this change, my comments below.

> Add an optional write-after-direction-output quirk for controllers
> that ignore data-register writes while a line is still configured as
> input,

The chips that require this are buggy. Are you going to fix this HW in the next
version of the SoC?

> and allow drivers to pass an existing gpio_irq_chip through
> gpio_regmap_register() so IRQ setup can stay with the caller.

This needs to be in a separate update. Also we need to understand why
it is required. The caller should be able to create the respective IRQ
domain which is important.

...

> struct gpio_regmap {
>  	unsigned int reg_dir_out_base;
>  	unsigned long *fixed_direction_mask;
>  	unsigned long *fixed_direction_output;
> +	bool write_data_after_dir;

Is `pahole` happy with the layout?

>  #ifdef CONFIG_REGMAP_IRQ
>  	int regmap_irq_line;

...

> static int gpio_regmap_direction_output(struct gpio_chip *chip,

>  	gpio_regmap_set(chip, offset, value);

^^^ (see below)

>  
> -	return gpio_regmap_set_direction(chip, offset, true);
> +	ret = gpio_regmap_set_direction(chip, offset, true);
> +	if (ret)
> +		return ret;
> +
> +	/* Some controllers ignore data writes while the line is still an input. */
> +	if (gpio->write_data_after_dir)
> +		gpio_regmap_set(chip, offset, value);

This can lead to two writes to the same register, the above needs to be
conditional as well.

-- 
With Best Regards,
Andy Shevchenko


