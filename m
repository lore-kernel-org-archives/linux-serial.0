Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F7F4189C2;
	Fri,  2 Oct 2026 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926896; cv=none; b=rnORQnls+CcDgG1X9Zmqh0ZXMbazsNMt/PXkVU3FMp/4l0jTDc3Xi0cqhNiVwKAjM2b+ON/Wlrtdz9mP2D5TsE4RTs0ljHuwjBwZZHl9vMAzdRegkh05ObHsYF/sEYD5V+ZY4og4L3k/0vYAEC17XihPxrI1RMffkJRDNatKfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926896; c=relaxed/simple;
	bh=C/kv6wcM0+ohmmG/4GwabO9Kw2Wi6mMW0E4cJ8FNzUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7lISjQBq3T4oOlJx/52TNjs9Oybkr09LT6BzAv3hLarS4ln22WDkCujUVjAPHypG44NrDNVKAb9uhKla9FnoPfJdM/jHNnAPK26xAcnzcm8MI6PmUE4uwX1F6z0FGpbn3X6TnaTX3vOl75YBRFtNUei20PSSYRo0tzB4VeNd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0Aijr7T; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0Aijr7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790926895; x=1822462895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C/kv6wcM0+ohmmG/4GwabO9Kw2Wi6mMW0E4cJ8FNzUM=;
  b=O0Aijr7T6JyIud/Ad9DCQ+/66RwaG1KTHRT4wcJZlQHrBWx3g+D0I4NC
   UwwGqjxzkWfJVKN3CVbp+MUv+M+GBZE0+dbS907QYoiaF9BuaSJq1yRZV
   wQpo4zLmlD64Whf6Lz0UH/Jed+bRm5Ymqe1eLyCOEHJJ/iUVjGsbjx51V
   rdkqvUMcVQIPeqDU3xaRgzKQZ3xLgUvD3pQwgBmh2MrBwSO5awORFKAWH
   f3F7AKMsD2CU8Oo4YWgLQtpvE3vBtyEUtPa5mKFo/LwAOeq60JRgluCXS
   smUEKSImKT0UANKH1bLfN/tnHjAZSlBtGqyViW49UxmDhikVRfYggQybn
   Q==;
X-CSE-ConnectionGUID: aTXUn50XQ9Gh2An7N7bZxQ==
X-CSE-MsgGUID: U9ECSFcLRwCalgIgZBP9hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90723487"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90723487"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:41:34 -0700
X-CSE-ConnectionGUID: Wr8ybAupREydeJzXx1ceWw==
X-CSE-MsgGUID: VX/xtgwiQPOs9W6Qu5jQYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="280935559"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:41:29 -0700
Date: Fri, 2 Oct 2026 10:41:25 +0300
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
Subject: Re: [PATCH v9 07/15] gpiolib: regmap: add
 GPIO_REGMAP_QUIRK_SET_AFTER_DIR
Message-ID: <ar9gJRVZxExBwDyn@ashevche-desk.local>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-7-486cc289a4b8@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-cv75-v5-v9-7-486cc289a4b8@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 08:40:56PM +0800, Long Zhao via B4 Relay wrote:

> Some controllers ignore output writes while a line is still an input.
> Add a behaviour flag so the output value is written after the direction
> change. This is a legacy quirk. New hardware must not use it.

A nit-pick below.
In general looks good to me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> struct gpio_regmap {

>  	unsigned int reg_clr_base;
>  	unsigned int reg_dir_in_base;
>  	unsigned int reg_dir_out_base;
> +	unsigned long quirks;

I think I have told at some point that this location is not the best, I woul put it...

>  	unsigned long *fixed_direction_mask;
>  	unsigned long *fixed_direction_output;

...here, after the group of the direction related offsets and masks.

> -	gpio_regmap_set(chip, offset, value);
> +	if (!(gpio->quirks & GPIO_REGMAP_QUIRK_SET_AFTER_DIR))
> +		gpio_regmap_set(chip, offset, value);
>  
> -	return gpio_regmap_set_direction(chip, offset, true);
> +	ret = gpio_regmap_set_direction(chip, offset, true);
> +	if (ret)
> +		return ret;
> +
> +	if (gpio->quirks & GPIO_REGMAP_QUIRK_SET_AFTER_DIR)
> +		gpio_regmap_set(chip, offset, value);
> +
> +	return 0;
>  }

...

>  /**
>   * struct gpio_regmap_config - Description of a generic regmap gpio_chip.
>   * @parent:		The parent device

>   * @ngpio:		(Optional) Number of GPIOs
>   * @names:		(Optional) Array of names for gpios
> + * @quirks:		(Optional) Behaviour flags, OR of GPIO_REGMAP_QUIRK_*.
>   * @reg_dat_base:	(Optional) (in) register base address
>   * @reg_set_base:	(Optional) set register base address
>   * @reg_clr_base:	(Optional) clear register base address

>  	int ngpio;
>  	const char *const *names;
>  
> +	/* Regmap GPIO behaviour flags */
> +	unsigned long quirks;
> +
>  	unsigned int reg_dat_base;
>  	unsigned int reg_set_base;
>  	unsigned int reg_clr_base;

I would follow the same location as it's in the above struct, id est after

	unsigned long *fixed_direction_output;

member.


-- 
With Best Regards,
Andy Shevchenko


