Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B6B3E1CF3;
	Mon,  4 May 2026 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910367; cv=none; b=VV6h5dnONxBHgs2/XabCEGEWI0mbBsgvonvnpcTEx5Ci7vWeq6RmyUgI6tc/g1eFIQ9vuokajFEs4GBZ3EaswQoj2r8xoOpAFhimUit63h925cUfc4PfNZ5nHar7/DKbYK6SwOeWn6QJAsbX/0MR0eYPXdN3yI61fNT8M7Un7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910367; c=relaxed/simple;
	bh=9gTE2u6o3j63E4Qjcm+zx1ZZYfejw6R4BnF+qjWHMmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV9qF/asWWfk+rF5l1HwOLf9TZJOtkuaaQ+6feLCZKqpaKe+kCbb/HnKX7aC6WbENihln8f5Jk0BIfCNW911WaDSvmfBAPXzyoJAGIkWniX5aITfdFV8eycuvKZvozvJhGK51w2pTJjJrHZVKeoitFusphQe3gD9A8C1IYzFzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RanXxlGU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RanXxlGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777910365; x=1809446365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9gTE2u6o3j63E4Qjcm+zx1ZZYfejw6R4BnF+qjWHMmQ=;
  b=RanXxlGU8HYDf+Ma3rZfJPQuIDt5avnR+vGo45GO5UyqzYhE5O8n1FxC
   V51H/JpNw9M1zCvLPs+BoeCi283PmmZXubgrjcknUHJRdsgUljfTSoemC
   7GvmLpKOKK4VLrlFRgrUOGgZSGh4H2yWx14sIUUbmfs+PssCjDi25HyJH
   cOrJpRwKiwUwG/UWJQgebPInxC7gzMCGXSFLTmZ0M61Sz5x+GAXHoA+tI
   YoAPppxKe4Fyc9WSb1SJ8aGvUPLr6+s4UhAFCCuNEm4Xf/b7ZTG8BNAhY
   qKwQgd9DMEinHsnNLXLdm616DTVRqOXfn9z1fu7e4Aw1uMgkJJ6TPQVTT
   A==;
X-CSE-ConnectionGUID: LlIBodXCSoW0VL2pnwwYCg==
X-CSE-MsgGUID: tRvaTceDRAi9maQY2WuX7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89354709"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89354709"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:59:24 -0700
X-CSE-ConnectionGUID: WGKF0TgMTLeW1zlcDDVQ2w==
X-CSE-MsgGUID: 5OUc0mOYQRi8w6w+0WmbHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="232888676"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:59:23 -0700
Date: Mon, 4 May 2026 18:59:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 05/15] serial: core: replace snprintf with more robust
 scnprintf
Message-ID: <afjCWFFjmZL-lcu9@ashevche-desk.local>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
 <20260428-tty-upio-v2-5-01c1857cf761@dimonoff.com>
 <afNwH01y_6Dk2hVb@black.igk.intel.com>
 <20260504112712.7f3d74b47d76d0956b1911fc@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504112712.7f3d74b47d76d0956b1911fc@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 11:27:12AM -0400, Hugo Villeneuve wrote:
> On Thu, 30 Apr 2026 17:07:11 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Apr 28, 2026 at 01:53:51PM -0400, Hugo Villeneuve wrote:

...

> > >  	default:
> > >  		strscpy(address, "*unknown*", sizeof(address));
> > 
> > Side note: This may use 2-argument strscpy().
> 
> This section is now removed in patch:
>   serial: core: use uart_iotype_*() to simplify uart_report_port()
> 
> But interesting to know this 2-argument variant :)

Yep, we have a handful of functions (actually macros) that use some magic
to allow supply different number of arguments to the same macro and behave
accordingly.

-- 
With Best Regards,
Andy Shevchenko


