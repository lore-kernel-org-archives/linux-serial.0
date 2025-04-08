Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D122171B;
	Tue,  8 Apr 2025 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141936; cv=none; b=fHsPauTyiv8X7vKD4Elwyf7Cz7PQBNUKUl/Kk8KnKmAolZYWF2jg7FaWc+HXfrc7TApLuOtOdTADP3klvKjtULwxmddTmpAE8ukPgaduuqW5H1CRM9jg9d2TXth4Iyefj5GodfaIbU6S3J3WwG6WuURSwZR+eyiNU4yHUSixSeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141936; c=relaxed/simple;
	bh=HKS7Ar6A7lqn1suRVTzjHjNCIc9YBZ0PeKtU7mMeSjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpsLjUKHIHJ3ihwTq2vh5QYGFcFnQiyi2uBhXudvIxWJNaty4XZv2s0H0cXoHzr4wcxu61w87tsWCK6P+WQ1iSV7nzerw79+VMk5fGAQ73j6bJV/qvvXOlaz5NhU59AaIEOmGZD/GcjXf+P74eeOeK7STe3q8nY7eaEQAkXjj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/xbRt6S; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/xbRt6S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744141935; x=1775677935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HKS7Ar6A7lqn1suRVTzjHjNCIc9YBZ0PeKtU7mMeSjc=;
  b=n/xbRt6S/iAO3eMSQ4VqqKLzQ57lI+WUvOCF2YQ72EI89wL71Kf1XFzq
   AC1GIbrPh/nogeaZ33CZpwB3t5/apoGZfu6+aKEwOoFv2bssDMW8pSBCK
   w/NAHV6g9101HGk52hAdMAf/fQjjP05EUj+05T7chRQklU+oyFISWTUhE
   ovvb6+wllvCoa+J5NKwxUR18t0vtyAlEghdRWq3EeHh0PmNN9HSSRB+Hj
   CXeqQqixq8v4Mef+NuGZz/uvyCoGvS2QmKAXTMOZ2EaaY0E12Gr3qxcgl
   jK49+p6NKrmNHKtLJ9f4SoVeqO3ZIL8WD9RjECFEbGXan9Juvfkqcn8B7
   A==;
X-CSE-ConnectionGUID: ywXs7NTsRPaeV9vZQBIIQQ==
X-CSE-MsgGUID: ssQ00d/FRPS0Laa7sn6OPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45757239"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="45757239"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 12:52:14 -0700
X-CSE-ConnectionGUID: YnWkD9miTgWM1NW6d+qmSw==
X-CSE-MsgGUID: 0ueH4Z0qS3aoF+VRoFZPeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="159351547"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 12:52:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u2EzQ-0000000AVLG-2SJ1;
	Tue, 08 Apr 2025 22:52:08 +0300
Date: Tue, 8 Apr 2025 22:52:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alex Elder <elder@riscstar.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	benjamin.larsson@genexis.eu, bastien.curutchet@bootlin.com,
	u.kleine-koenig@baylibre.com, lkundrak@v3.sk,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_of: add support for an optional bus
 clock
Message-ID: <Z_V-aKBOFHt-0RKz@smile.fi.intel.com>
References: <20250408175146.979557-1-elder@riscstar.com>
 <20250408175146.979557-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408175146.979557-3-elder@riscstar.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 08, 2025 at 12:51:43PM -0500, Alex Elder wrote:
> The SpacemiT UART requires a bus clock to be enabled, in addition to
> it's "normal" core clock.  Look up the core clock by name, and if
> that's found, look up the bus clock.  If named clocks are used, both
> are required.
> 
> Supplying a bus clock is optional.  If no bus clock is needed, the clocks
> aren't named and we only look up the first clock.

Code and description are not aligned. And What you are described above make
more sense to me than what's done below.

Also can we simply not not touch this conditional at all, but just add
a new one before? Like

	/* Get clk rate through clk driver if present */

	/* Try named clock first */
	if (!port->uartclk) {
		...
	}

	/* Try unnamed core clock */
// the below is just an existing code.
	if (!port->uartclk) {
		...
	}

...

>  	/* Get clk rate through clk driver if present */
>  	if (!port->uartclk) {
> -		info->clk = devm_clk_get_enabled(dev, NULL);
> +		info->clk = devm_clk_get_optional_enabled(dev, "core");
>  		if (IS_ERR(info->clk)) {
> -			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
> +			ret = dev_err_probe(dev, PTR_ERR(info->clk),
> +					    "failed to get core clock\n");

Can be still one line.

>  			goto err_pmruntime;
>  		}
>  
> +		/* If we got the core clock, look for a bus clock */
> +		if (info->clk) {
> +			info->bus_clk = devm_clk_get_enabled(dev, "bus");
> +			if (IS_ERR(info->bus_clk)) {
> +				ret = dev_err_probe(dev, PTR_ERR(info->bus_clk),
> +					    "failed to get bus clock\n");

Something with indentation happened here and below.

> +				goto err_pmruntime;
> +			}
> +		} else {
> +			/* Fall back to getting the one unnamed clock */
> +			info->clk = devm_clk_get_enabled(dev, NULL);
> +			if (IS_ERR(info->clk)) {
> +				ret = dev_err_probe(dev, PTR_ERR(info->clk),
> +						"failed to get clock\n");
> +				goto err_pmruntime;
> +			}
> +		}
> +
>  		port->uartclk = clk_get_rate(info->clk);
>  	}

> +

Stray change.

>  	/* If current-speed was set, then try not to change it. */
>  	if (of_property_read_u32(np, "current-speed", &spd) == 0)
>  		port->custom_divisor = port->uartclk / (16 * spd);

-- 
With Best Regards,
Andy Shevchenko


