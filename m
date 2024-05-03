Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F63FE37;
	Fri,  3 May 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754203; cv=none; b=ooO8cHLB+vYNoJOPglIl3mYCyqA4mcGx8qYRk4w0/q6Uu3ViGatxGcz7eh5LqRUgpBMBwrDETkNJ8ZeSa20ZIuQQiOGKr48urdrtnx5qRzHACDiWTC5czbGpBFOifsLBTEtvYRwSkwgB/Xse1OC1khnLrtScm2yQ91Z+a7tbu7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754203; c=relaxed/simple;
	bh=TbsE5XWoVWXOvVkel0jaEgt8y2oJdFmW18kZ/X9G25k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAmC+PLx4GdUGSBCWVjlAlYLyOKkkYtnrdUfcL1mwC2FW5niEG1rcN4m/2qlRwSVARbQOk3brnFa9nS87VQtvsKmwNI7TIxXHHsVcJVRxytC8NoEisbwGVFPVXb3fwFf6JgKPlh6mbwBfigJXJR3pqSRDzD6/V0GZZsU1LZUnzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDYYR+Mt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDYYR+Mt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714754202; x=1746290202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TbsE5XWoVWXOvVkel0jaEgt8y2oJdFmW18kZ/X9G25k=;
  b=hDYYR+MtSgtYVjSUrnUOK5T8RN86Hz5H9+Ko0+nit7V/GIIUL/JdrD5N
   oO52kLVjZXnGRcTO2Mgmrq8CIQ2JENOk5dbEGzD7OjeAtXfZl9FPiK6qs
   WWg1CP1FZnfd5+6mhSMY3Co+vTkcvqnlYf+X6EAaO9an9EQr/ZrSoRk2Z
   km26oNK+9I0ewDERJkcYxcUAOhB7udNv8t2q/WItiWIfRwd1qPypSEcD6
   ZlalwyN1/w6KKrp6ILDBr9KE7JqtYYxtJOSTHi7Br4fdG+PYO/RBKE1XY
   0fA7CshfGvFJbN+95KWLb27YJq9o4SHWg4B47En4tZd/UszTuv8T458Zf
   g==;
X-CSE-ConnectionGUID: VXYVNuHrSGqcyAxG2uys3g==
X-CSE-MsgGUID: q82k83d5Qzu9bTXUSHNAPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14377493"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="14377493"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 09:36:41 -0700
X-CSE-ConnectionGUID: 9uS3u0VIT9WCzQzkIKCixQ==
X-CSE-MsgGUID: nCic0Oq1SeOKQmul+nqp3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27584532"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 09:36:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2vtl-00000003hya-0V3q;
	Fri, 03 May 2024 19:36:37 +0300
Date: Fri, 3 May 2024 19:36:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/2] platform/surface: aggregator: Log critical errors
 during SAM probing
Message-ID: <ZjUSlNKVvtROHNnl@smile.fi.intel.com>
References: <20240503030900.1334763-1-weifeng.liu.z@gmail.com>
 <20240503030900.1334763-3-weifeng.liu.z@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503030900.1334763-3-weifeng.liu.z@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 03, 2024 at 11:08:47AM +0800, Weifeng Liu wrote:
> Emits messages upon errors during probing of SAM.  Hopefully this could
> provide useful context to user for the purpose of diagnosis when
> something miserable happen.

...

>  	acpi_status astatus;
>  	int status;
>  
> -	if (gpiod_count(&serdev->dev, NULL) < 0)
> -		return -ENODEV;
> +	status = gpiod_count(&serdev->dev, NULL);
> +	if (status < 0)
> +		return dev_err_probe(&serdev->dev, status, "no GPIO found\n");

Note, with

	struct device *dev = &serdev->dev;

this and other lines become shorter and you may join some of them...

...

> +		status = dev_err_probe(&serdev->dev, -ENXIO,
> +				       "failed to setup serdev\n");

...like here:

		status = dev_err_probe(dev, -ENXIO, "failed to setup serdev\n");

...

> +		dev_err_probe(&serdev->dev, status,
> +			      "failed to get firmware version\n");

...or here.

...

With the above being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


