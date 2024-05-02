Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C25C15B104;
	Thu,  2 May 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662956; cv=none; b=dUMhZuiB0b3jLKUOUo9eDMOmaHj9YQbxodZCYGJQ7lb0JHNjXLY/HaND/WRqVNPjJe8u72KRCNAJ4snqCqwfdsTV72TvO0hdCk9ROGNsuJQa5hxtxUFzy0BfaecxzcdVyyeEmSo2O4pB8ZA3PqjEAIXahgUgTnfWDmDoHZCE3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662956; c=relaxed/simple;
	bh=yhtMbrbMPDv/iKoCEbGAbo//epyTLe07+dULFYfPs/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fu88l1s57NaLi7cPqhfdG42QGHrrNb+8jNxsEZ3ze2AVO1nEOPYynhLt6suF4IqtSDXgFLp5DbdthhB5JMZ9AYgcHAWvqCYeDivOtnKuuHUxt4z4PaRIVV85iEOPd84xqWuVkTyuflcwyBs9KvDse7/fxK0xbNMjtOHpfJXt19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTZi/F95; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTZi/F95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714662954; x=1746198954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yhtMbrbMPDv/iKoCEbGAbo//epyTLe07+dULFYfPs/0=;
  b=ZTZi/F954P2SyaHyXIaIHB+cXiYY5QlrrDGdlUI1qc8c/IWeyBf2b1oN
   EGZ3zdAQzgwqRjjNj2awiUi7gJQ8taeUneI2jj+1XXXXMVH6KPg4OaNkq
   H1LUhVKggQ2xTqKhUyi6vhKBaO/AujZMUrRRpor7ctiFnUqI6xRwT7jAV
   hWEs6bLizJgIoqGcWUnrQ2DaiVPOrOxzugCGqTDOPpYwgDHjjz254UdBn
   lIIeIm4OoHwvnFjJoO2tTxAX3ypIN40auM5TT0PDI5VvS7zgntx5x87kr
   Cr7WDjbdyKFUCaARA9ZTdqWN3yzs6NjGEbtNGeacP9JNE26zWzglhrg0U
   g==;
X-CSE-ConnectionGUID: lHLlUhq4Q0+SqZLI91wEoQ==
X-CSE-MsgGUID: VP+mtfR2RNKF9TlvnmuOZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10312004"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10312004"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:15:53 -0700
X-CSE-ConnectionGUID: U/65pNpXQnGfqAqhItqp8w==
X-CSE-MsgGUID: mKgdWI7BRqKUjn/LEL8QqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31643319"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:15:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s2YA1-00000003MHp-1CQw;
	Thu, 02 May 2024 18:15:49 +0300
Date: Thu, 2 May 2024 18:15:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH 2/2] platform/surface: aggregator: Log critical
 errors during SAM probing
Message-ID: <ZjOuJC9NcYHvgWcY@smile.fi.intel.com>
References: <20240502040255.655957-2-weifeng.liu.z@gmail.com>
 <20240502040255.655957-4-weifeng.liu.z@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502040255.655957-4-weifeng.liu.z@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 12:02:47PM +0800, Weifeng Liu wrote:
> Emits messages upon errors during probing of SAM.  Hopefully this could
> provide useful context to user for the purpose of diagnosis when
> something miserable happen.

...

> -	if (gpiod_count(&serdev->dev, NULL) < 0)
> +	if (gpiod_count(&serdev->dev, NULL) < 0) {
> +		dev_err(&serdev->dev, "no GPIO found\n");
>  		return -ENODEV;

Why not

	return dev_err_probe(...);

?

Also while at it, unshadow the error code

	status = gpiod_count(&serdev->dev, NULL);
	if (status < 0)
		return dev_err_probe(..., status, ...);

> +	}

...

>  	astatus = ssam_serdev_setup_via_acpi(ssh->handle, serdev);
>  	if (ACPI_FAILURE(astatus)) {
>  		status = -ENXIO;
> +		dev_err(&serdev->dev, "failed to setup serdev\n");

In the similar way

		status = dev_err(&serdev->dev, -ENXIO, "failed to setup serdev\n");

>  		goto err_devinit;
>  	}

...

>  	status = ssam_log_firmware_version(ctrl);
> -	if (status)
> +	if (status) {
> +		dev_err(&serdev->dev, "failed to get firmware version\n");
>  		goto err_initrq;

Use dev_err_probe() everywhere for the sake of uniform output format.

> +	}

...

>  	status = ssam_ctrl_notif_d0_entry(ctrl);
> -	if (status)
> +	if (status) {
> +		dev_err(&serdev->dev, "failed to notify EC of entry of D0\n");
>  		goto err_initrq;

Ditto.

> +	}
>  
>  	status = ssam_ctrl_notif_display_on(ctrl);
> -	if (status)
> +	if (status) {
> +		dev_err(&serdev->dev, "failed to notify EC of display on\n");
>  		goto err_initrq;

Ditto.

> +	}

-- 
With Best Regards,
Andy Shevchenko


