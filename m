Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF41CFA8;
	Fri,  3 May 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755830; cv=none; b=V47IMioM4xBzFKwWVqGBCzx77yzREa7t0qcyRE91OL3VdF3p6tHuLBu78bLLshjiAcir/88eedvJ+cd67z0zExUQov8SyPYqssCfmMQEiE3AIJiglKygCiZA4+zO9xTv+x1KZrXY/F0+cKlrsNFmVojs938ve04N3C9nAnugd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755830; c=relaxed/simple;
	bh=IHaogS4BpfHwwVZgIjmFoYz8T5L3ZgNwBy07RNbf7/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMQScZo5NncxfVEBa4mpo/qwKHq3gzJkj6b2utOAMDnLseWme9ssj4jRH51kfWWQejY3bdejIJNcsMQIq/1cIJwqeOoQa5wKESEzYz4eYGWIlDWfFl5yro6bYmPDC0ustpf9bYhpdWiBmJuk6WkmDMXj1W/Z+8vYVEzlilyQqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwMRHz9u; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwMRHz9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714755829; x=1746291829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IHaogS4BpfHwwVZgIjmFoYz8T5L3ZgNwBy07RNbf7/o=;
  b=QwMRHz9uEMZ/sJJyUny/bhnlyl34vs+WTBBYflwGcguWHe6m9kel6rzX
   JdbHx42MrSZmkG91oI0YbXIQ/e3ImAA7mEE1qQoM04x1t6bM+9UhQYIhR
   BnCV1d5NJwSdJsrBcE9TLCa2dwT7VCkESCOdngeFOar1TzjV2/0M7rCcu
   YSFjd/qPcoEG8jP2Jhnxf15TkQCwMTOZtYpAxduMLk8d80y5Dk2Apd6RF
   sYiJMBz4y83aCOaJ3V+vGP2m+LdD8uLz6PsycfFKRleckrtRA5vjlJX2v
   Ofr/KRLbF0Sg/PQhiU4X11QnXI+RauIGxPmrKNdwb2qmu1eZXBXBVW3/D
   A==;
X-CSE-ConnectionGUID: T8DhYVMrSmuRkdyTWi9AcQ==
X-CSE-MsgGUID: xVM68qkkT2GmR+CgwrNKZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10727252"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10727252"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:03:48 -0700
X-CSE-ConnectionGUID: cdnab/rgS9ierNcdHnZvwA==
X-CSE-MsgGUID: tfr1HdQWT5qFCac/A5T6nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="32311759"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:03:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s2wJz-00000003iQ0-3au3;
	Fri, 03 May 2024 20:03:43 +0300
Date: Fri, 3 May 2024 20:03:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/2] platform/surface: aggregator: Defer probing when
 serdev is not ready
Message-ID: <ZjUY7xPXszBulKap@smile.fi.intel.com>
References: <20240503030900.1334763-1-weifeng.liu.z@gmail.com>
 <20240503030900.1334763-2-weifeng.liu.z@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503030900.1334763-2-weifeng.liu.z@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 03, 2024 at 11:08:46AM +0800, Weifeng Liu wrote:
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

> +	/*
> +	 * The following step can fail when it's called too early before the
> +	 * underlying UART device is ready (in this case -ENXIO is returned).
> +	 * Instead of simply giving up and losing everything, we can defer
> +	 * the probing by returning -EPROBE_DEFER so that the kernel would be
> +	 * able to retry later.
> +	 */

You can add the following to the
serial_core.c (at the top after the headers)

#undef ENXIO
#define ENXIO __LINE__

And I'm pretty much sure it will point out you to the uart_port_activate().
If it's the case you may elaborate this in the comment.
Otherwise you may add the same hack to other files and find the culprit.

Also it might be that we add some error code substitution inside serdev core.
At least there more data is available to make the (better) decision.

-- 
With Best Regards,
Andy Shevchenko


