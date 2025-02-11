Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005781F2BAF;
	Tue, 11 Feb 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268254; cv=none; b=WoQcIkGjvmhntJabN1yA7L6Fxqqg9rh16Ep0McExP5oFYXOmeRQxpnFt2MTYTnZoLUlGerBG/Id18NyJbAbxjGXbJ0WfR1fC+u+jnuYPZb3zoZZTafTJG6ruCIHZ/UMcnqLdG8pCZyG+vskvwrkM5fUgVb84MY4Qqgb9kxYROkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268254; c=relaxed/simple;
	bh=MMdhM2PCYrwcCpaZ5LdDu5P1WhORMrCUj31a4hpCOKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H34hkkIeYMNJ8Iuuf+ukXbUv0BkXfXsHMoTYigr7iGJjZTZ+ecY64Nx1Qhmpj8ypnhg7hiBtovQhCM5hI9IR42i5i4slz2+uJQLFT/h9Z1RkJd01TryTWqOiiVLiak6qtO93nNLAuB+uBa6RkbkvkhIth/Otx5BPfwMwfum5E9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdvuKrP1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdvuKrP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739268253; x=1770804253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MMdhM2PCYrwcCpaZ5LdDu5P1WhORMrCUj31a4hpCOKc=;
  b=MdvuKrP1c8V9x92g/OFFlnv2ixPPbtKekkKfPM4v3WsyWnEfp5bcJJRV
   AGMIv3le15of3jbuOocLvpthZ4NQRB4jmEaBr2VOrW/EXdXWjpaPrO2ro
   gYGZKXSew3TBN4NsORU5CBYm5rJUGw1id7SwBvkhQVzfpR5BqGh0FjclB
   DqpxqYJQtdtQ6WTlz7VwYEONWoxHGAOadGQLCjveKjJVJYDyqD6Fn3ePr
   CzogI7jO73vSfx9J8s0YXAp/HUri6ud2JyWLyXGeGBR+Fz2cynuOUrryT
   dPTVazkZ1SJdvumSXn96F9jxOT6L7DsZAw+Nu/TNXAEHIbHraDIV1VZTm
   Q==;
X-CSE-ConnectionGUID: fhkF4c0STHOSiu4HhojoNw==
X-CSE-MsgGUID: t49wnCc4SraOHWG+jKxKjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="27477567"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="27477567"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 02:04:12 -0800
X-CSE-ConnectionGUID: AenVwpHaT8WtXmPJpO5V0w==
X-CSE-MsgGUID: /RG7ppNdT6Cs9KPXbzL0pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="112679482"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 02:04:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thn7d-0000000ASsk-2U9m;
	Tue, 11 Feb 2025 12:04:05 +0200
Date: Tue, 11 Feb 2025 12:04:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hvilleneuve@dimonoff.com, arnd@kernel.org,
	geert+renesas@glider.be, robert.marko@sartura.hr,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Message-ID: <Z6sgkiHSQtojdQ9L@smile.fi.intel.com>
References: <20250211061945.18836-1-kkartik@nvidia.com>
 <20250211061945.18836-3-kkartik@nvidia.com>
 <Z6sf58j4HJH4OCX9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6sf58j4HJH4OCX9@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 12:01:11PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 11, 2025 at 11:49:45AM +0530, Kartik Rajput wrote:

...

> > +#include <linux/of.h>
> 
> > +#include <linux/of_device.h>
> 
> Use property.h (see also below).

To be more precise. The above proposal is to _replace_ linux/of*.h with
linux/property.h and use APIs from there.

-- 
With Best Regards,
Andy Shevchenko


