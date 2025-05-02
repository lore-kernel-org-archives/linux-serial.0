Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA801E47A8;
	Fri,  2 May 2025 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179485; cv=none; b=SYdfKjeepab7Hol6WI8tda8FYMGSVPTSpp6faHD8XWRZEZZIZ4YnjUweJGa9zJvXxaxaZfAxxWMSGbJ378AZGnuIV6saLHHK6GUirXBOBzmzFpsrQ5tRh/seZCJaz23ocMnPTXko7ahcm85fkDVrYxxpKnrwmTMyyBWbOI30470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179485; c=relaxed/simple;
	bh=rz+pku6fFVNGDWSjBpK/e58/3Yur8CiXbKPaTU2oPoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaqI8wUzw6Ynyek0060C90v3gvGr+RDCylxW1lHIe5a5eOArctyw7Yg8IFCp6g+Nw+XG6uMu0XS2tq0UnaWVarhIDjRFBZzGBKIVchLYLEwqfPudimXXlrRTajzEa7Vh8tRLqnIGQK2uSNdNeaJ9BdjxbhiEZDSZexTesn/9SK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSzZNp6L; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSzZNp6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746179483; x=1777715483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rz+pku6fFVNGDWSjBpK/e58/3Yur8CiXbKPaTU2oPoc=;
  b=fSzZNp6LBtmGhZE2Tw1RxNeSkgI3W7EhO8UTRHvNiggy1JZ364gjUxg/
   FFmZVJgJ60iqORv/kk7Bpwf9fJUsX8zCMzsYatZ5/kphcrJe5629gta4q
   CEUbK+ldiFFTCxFDABSpoSGxIcmtN7U7igjLY0ihfPgKOB26Ct0e86y6v
   pZjVdkgROGsliwaKO5T27AiF1mmFvwFoXa70OMKhNeUdImVYAlCwDqLkX
   EBdT8He6nm0x20lTVsGY7CpM9sTgeZJeZEynpV1eashWHHUF3muVDriuK
   9M5eQDYS/KRWqXhyJwtD8rMGwM6BQaJ/wNZ1XqF/p4cKPGpBP591BqGuG
   w==;
X-CSE-ConnectionGUID: G7doo2ZBRw63EA3QEeHSZw==
X-CSE-MsgGUID: sqHyzFJFRK+mcApdThtAlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="65390983"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="65390983"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:51:23 -0700
X-CSE-ConnectionGUID: QWSz0uvJRK6SZyxAkMWHtg==
X-CSE-MsgGUID: q6Hsr9EZSySoxE4RUSqrDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="139780542"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:51:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uAn37-000000029RW-2ltu;
	Fri, 02 May 2025 12:51:17 +0300
Date: Fri, 2 May 2025 12:51:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Judith Mendez <jm@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH RFC 0/2] Introduce PRU UART driver
Message-ID: <aBSVld3HKL_M1agq@smile.fi.intel.com>
References: <20250501003113.1609342-1-jm@ti.com>
 <2025050103-graduate-anteater-e6f6@gregkh>
 <406ae5d2-9a4a-47be-9663-d746d9661f1f@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406ae5d2-9a4a-47be-9663-d746d9661f1f@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 01, 2025 at 09:47:34AM -0500, Judith Mendez wrote:
> On 5/1/25 12:18 AM, Greg Kroah-Hartman wrote:
> > On Wed, Apr 30, 2025 at 07:31:11PM -0500, Judith Mendez wrote:
> > > This patch series is sent as an RFC to get some initial comments
> > > on the PRU UART driver.
> > > 
> > > The ICSSM modules on am64x SoC and the PRUSS module on am62 SoC or am335x
> > > SoCs have a UART sub-module. This patch series introduces the driver and the
> > > corresponding binding documentation for this sub-module.
> > > 
> > > The DTS patches for adding PRU nodes and enabling PRU UART will be added
> > > in a later v1 version of the series if accepted.
> > > 
> > > This driver has been previously tested on the following boards:
> > > am64x SK, am62x SK, and am335x SK boards.
> > 
> > Why is this "RFC"?  What needs to be done to make it something that you
> > actually feel works properly and should be merged?
> 
> Nothing needs to be done IMO, the only reason it was sent as an RFC is
> to get initial thoughts/issues that anyone might have with the driver
> before sending v1.
> 
> If none, I will go ahead and send v1. Thanks for your attention Greg.

I have tons of comments, please read my replies before sending a v1.

-- 
With Best Regards,
Andy Shevchenko


