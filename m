Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158D157E91
	for <linux-serial@vger.kernel.org>; Mon, 15 Apr 2024 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209810; cv=none; b=D5n+ojQGA2qnxbiMsMXAfCpeqaEGsu1BvE4r0blT2Vk3ekqqAjF4lbSxLtEJQU8sihcFu8TfSS4WFq6Ba3pCXDkeJF2EpfPbyAwpjDmGXL84OR2VltC3MOcQmP9pEfelsffM/lSvSqV+F8GIKjcOTRmKXslcHP7nGu5k8ZghydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209810; c=relaxed/simple;
	bh=O6fuuNfBKglyBl+KJ4BoRa6i92FJ0RbI90yJ/WVYvOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfQ3RDts7iz1/O198ThpL9JJR+maQqyPNYODbF5ICbV90TmlWDQrsWA9wu1QgEQFTcXKKV3E+kQnYW0Svc3uUbGPJF8ub0emJBJmguk2cbn/6FiJc86+zH9muB1FDKUfaekWgE13zo3zNRqdZFqVRcHyzEdIcM7WrrQsucv4y+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Km7L2OLI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Km7L2OLI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713209809; x=1744745809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=O6fuuNfBKglyBl+KJ4BoRa6i92FJ0RbI90yJ/WVYvOw=;
  b=Km7L2OLI4gqAgk5i8I/1UQcMni2dj3yZ3M9c4VDEMTmSS9KgD6Gr9EQ5
   fC7DtO3NMqIrUYle8Vv1lQp6d3eiCOX8xcRSdExFpJQAI9n8ge2Ble1i2
   fcnFZsL/dbKMlPGOxDF2I5P45mHwik8BV+EtJTy9x5Y1/thbbY5Vv66bM
   0+VFk4kDMQ6KCpnYXcDtNhzHEWUP8xJ8+xvxOBrodD43ggNuEiGm3uTsO
   hMIXDhOXTmgzkaxPf7TjEmQSqbWIBTDcv92X3nrRp2RXAyduAowtuJOa4
   LXtGla8v8oHWV26twmEZJRYJ9u91DjDFTS1OLhhIDouh2SeBbXqFfEOZg
   A==;
X-CSE-ConnectionGUID: aR3GUt5kSOa2SmIAmP0YRA==
X-CSE-MsgGUID: 6XghwENVT8WJyiVOL9MSrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12410275"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="12410275"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 12:36:49 -0700
X-CSE-ConnectionGUID: xwcu790zS/CZgMDNL9URcQ==
X-CSE-MsgGUID: osRnboaDQgyrLWKr9G6lbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="52967756"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 12:36:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwS8C-00000004Vge-3aqF;
	Mon, 15 Apr 2024 22:36:44 +0300
Date: Mon, 15 Apr 2024 22:36:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: Re: NULL pointer dereference when closing a busy UART
Message-ID: <Zh2BzD3qW1j1GR_o@smile.fi.intel.com>
References: <luomji4bv5c54xq442csgd2ifdacjrme7bomnwbviw6pmalpgv@5uusgu3vgybm>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <luomji4bv5c54xq442csgd2ifdacjrme7bomnwbviw6pmalpgv@5uusgu3vgybm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 15, 2024 at 07:15:54PM +0200, Uwe Kleine-König wrote:

...

> I didn't try to test if older kernel behave better, yet.
> 
> Any ideas? Does this ring a bell?

Does this

9cf7ea2eeb74 serial: core: Clearing the circular buffer before NULLifying it

fix it?

You might need this

1aa4ad4eb695 serial: core: Fix missing shutdown and startup for serial base port

on top btw.


-- 
With Best Regards,
Andy Shevchenko


