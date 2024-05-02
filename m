Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC315B542;
	Thu,  2 May 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663180; cv=none; b=a+DlaxlFnASogJ2SwsqzELpfX18d4e/z0ONJNEw/qJroq3Jfb+VnfWVihASnpNZZg6YS1G21jgZ/ZQ57QgZRcu7rsNmO41X03TV1bNfYaaA80yF+vimb6f6Lfx5Kze5I55tKztXNxmK7oE9c3/bL4BjqDYECivmTEiipXQvC6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663180; c=relaxed/simple;
	bh=n1DeKUM4aLNcooNqYpGbDSVGwX6VR+Afv8wFc8GMbkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZA7+oBiaqTpK2eCI7ZbB3rSb6oIt2z3dp+HEeTk186TKGOxWSFH0wRP+wzGY48fxmCdN88h5TkgLkDWF0ePHdsDVyKsPW4RqJFkcQOCqc6i6JpoRHeUAyBDimxdJMIiYA5YukzylhMDGX8Cu7sJ+zWunPOvi2f3Sx2yq8wpTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnYL2Wel; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnYL2Wel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714663178; x=1746199178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n1DeKUM4aLNcooNqYpGbDSVGwX6VR+Afv8wFc8GMbkI=;
  b=OnYL2WeltcsyRovVM/zlc2f7kcHZcPu3lcxpHWq9jnF4Zc6QajL3qq9U
   Zx5yF5ST+/fjN7uXXMyzDJqWBGR+duS/SFN0zLszq17OV7Isot183bNIe
   IhAsLfCLC12K14N/wZJ5bxo6l75B9AfH0XrIy0VxrqKg4RirnrEeLndcf
   PZWbCL6c7SNLT1qw5W421nj5zkBCKWhF13xRnlS6byUim4WtjI2HX4ixL
   DoR3i8Sa1mfWAeiynTBVkQIuO17/1THdFdGAUyQz+weki92YIyF/82QCH
   aLrNUGQwZPQKwEMC++IjBRvbBUqSUOQ5m0u6f3BrlKWEDcfwUdHqejcf8
   g==;
X-CSE-ConnectionGUID: c4OmON4MS92qFESS9zmWxQ==
X-CSE-MsgGUID: NFOFAUKwSPaKkvjhd5koOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21842113"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21842113"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:19:37 -0700
X-CSE-ConnectionGUID: CXEHONopTVuw2k/4+H0Zog==
X-CSE-MsgGUID: 7+3dj0IOSH+O8NEXTU5TUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31960845"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:19:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s2YDd-00000003MMd-1Kl0;
	Thu, 02 May 2024 18:19:33 +0300
Date: Thu, 2 May 2024 18:19:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH 1/2] platform/surface: aggregator: Defer probing when
 serdev is not ready
Message-ID: <ZjOvBeNi-R81EX63@smile.fi.intel.com>
References: <20240502040255.655957-2-weifeng.liu.z@gmail.com>
 <20240502040255.655957-3-weifeng.liu.z@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240502040255.655957-3-weifeng.liu.z@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 12:02:46PM +0800, Weifeng Liu wrote:
> This is an attempt to alleviate race conditions in the SAM driver where
> essential resources like serial device and GPIO pins are not ready at
> the time ssam_serial_hub_probe() is called.  Instead of giving up
> probing, a better way would be to defer the probing by returning
> -EPROBE_DEFER, allowing the kernel try again later.
> 
> However, there is no way of identifying all such cases from other real
> errors in a few days.  So let's take a gradual approach identify and
> address these cases as they arise.  This commit marks the initial step
> in this process.

...

> +	/* The following step can fail when it's called too early before the
> +	 * underlying uart device is ready (in this case -ENXIO is returned).

UART

> +	 * Instead of simply giving up and losing everything, we can defer
> +	 * the probing by returning -EPROBE_DEFER so that the kernel would be
> +	 * able to retry later. */

/*
 * Use correct style for the comments.
 * Here is the example.
 */

>  	status = serdev_device_open(serdev);
> -	if (status)
> +	if (status == -ENXIO)
> +		status = -EPROBE_DEFER;
> +	if (status) {
> +		dev_err_probe(&serdev->dev, status,
> +			      "failed to open serdev device\n");
>  		goto err_devopen;
> +	}

...

Hans, not sure if it helps, but we added similar into I²C and SPI code.

2dea645ffc21 ("i2c: acpi: Return error pointers from i2c_acpi_new_device()")

9c22ec4ac27b ("spi: Return deferred probe error when controller isn't yet available")

-- 
With Best Regards,
Andy Shevchenko


