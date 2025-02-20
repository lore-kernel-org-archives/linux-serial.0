Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFF91D54FE;
	Thu, 20 Feb 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063429; cv=none; b=DBBIIgycSeRLVYNsJRz+eFrU7runuZL/iy+f76IXyXMd61vpwXkrwPwPwe7fDShLwAE+JmU3Lcs3uz/uo9bgK3XCYOdcpDXYp1hMgw0JhnwZiQ0YuqEmKaow02gme1b5bdwYY28ZeSEY/X7yc+1IMy5krY+nAQwdH/L4INU769E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063429; c=relaxed/simple;
	bh=LH20kw/qJxCzAmsecqE65RTaGen48dDN4X5aZDNUing=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJRF07AcyGTuSjNzSfq/mRz028sMCT3EzQGK3UA8NToAZu5v7FdopGGxZwBgfn2D1m1YZalWfKxgXHRkwxFBVUtLptcglUxB8b2qwN+/jK/wX3d0//0NK8x7NEfZWOCk83FQ/eK854+4aDma1cyGCZ/NY+WmriKG70a/a3TGUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPpj60w6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPpj60w6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740063428; x=1771599428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LH20kw/qJxCzAmsecqE65RTaGen48dDN4X5aZDNUing=;
  b=lPpj60w6DsDXbC/5RUSwOp4m0fbHkCNXZoFTe/WNeOsyAV8vYIqtbEw8
   aWDaHWtd0xhHa+s1RUFyR0/zI31fVKzdh+VLbKxaFzx5VcRFfLbYSoZDA
   r+ggUF9M8yrO2FOFx1Lh8CpUcuWM16njxjhwxC1OboeQqDPSE3RZvXBob
   QC/wjr+NPr9/zDekfHerU3C6lYE+VwG5YH/J64h+sHKZBBx2EmPbozcfn
   Th5S/JThf0ARCG39S7IZiplY14bz2hBkqmtBHGjiYHCVhuYqfGWddhBmp
   JDbZLy79V5iQXCtnVWuKBKIdqPhsIVPcZZi0SFwfw4JUODQbgK894Q2pd
   Q==;
X-CSE-ConnectionGUID: OAoups/yS0ajnFrPvPXlag==
X-CSE-MsgGUID: s4dqTRELRYOg5oUDieSrzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41052431"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41052431"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 06:57:07 -0800
X-CSE-ConnectionGUID: Exy/s7enRDGx97orsaGBFg==
X-CSE-MsgGUID: 12RvgFC0Tt+hlqdfv+M4FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="115267418"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 06:57:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tl7z4-0000000DMqN-38sj;
	Thu, 20 Feb 2025 16:57:02 +0200
Date: Thu, 20 Feb 2025 16:57:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 26/29] serial: 8250: use serial_in/out() helpers
Message-ID: <Z7dCvmLLk6P9rbs7@smile.fi.intel.com>
References: <20250220111606.138045-1-jirislaby@kernel.org>
 <20250220111606.138045-27-jirislaby@kernel.org>
 <Z7cfvXUCHXVXK_mp@smile.fi.intel.com>
 <2025022032-movie-citation-b267@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022032-movie-citation-b267@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 03:39:40PM +0100, Greg KH wrote:
> On Thu, Feb 20, 2025 at 02:27:41PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 20, 2025 at 12:16:03PM +0100, Jiri Slaby (SUSE) wrote:
> > > There are serial_in/out() helpers to be used instead of direct
> > > p->serial_in/out(). Use them in various 8250 drivers.
> > 
> > Is this just a mechanical (compile-only) conversion?
> > IIRC 8250 DW code is twisted in some cases and it might
> > be a possibility of dead loops, but I don't remember it
> > by heart and haven't checked myself before writing this
> > reply.
> > 
> > TL;DR: this needs a thorough review.
> 
> Wonderful, are you going to do it?  :)

Why not. Just give me some time.

-- 
With Best Regards,
Andy Shevchenko


