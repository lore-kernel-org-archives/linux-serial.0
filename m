Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23F4087C;
	Mon, 16 Sep 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489111; cv=none; b=GNOA3LTvP7TOgvHFP8/u07LjiW2BWbCaNGm7v+lyxlC/so0gjAc24m29cOWGlsx9gGYf2BHh+4F3K6xkw+xX6a8vUEmR0/f8p73Khz8V66+0GutTFe04IL6HCGhd3a7mPp5ws/cdUuL/pB7SXCN31AH0DJ4L86zbm7pesH2Z/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489111; c=relaxed/simple;
	bh=bih7NtWKBsW8pZ2uAhBjyl1V2gWQzF6yEOi2em21bDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkxN2q6CSchnc2c+OaPGhhqNgRmPQ8YHTwz/xJCYOrICLnMzTtGUDXL6P9+oLlvBLHBT9O3/wHEiww6M37U3KRKYs9KZHBXGp3PY4eX38M54fPw/0bIsl5zBmuDPr1D/wJZqr90egkq5tLLzg5s3GQv03PpwIlkmJyYktf+CPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Df/SYPum; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Df/SYPum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726489109; x=1758025109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bih7NtWKBsW8pZ2uAhBjyl1V2gWQzF6yEOi2em21bDM=;
  b=Df/SYPumej73Rnn1N6Pr4O4pQWEL/vF86PrDeZEGSoF9qvXFhd9X0Ueo
   Uw+4ZZ0aEmiMVsDenTx5I6xUdIe0TztYXeIEDWYpSzG01NecOR0GFxZqx
   vLJa+iRuHuwDvtX02o9UgAhfzGyurKrQxUb90VrX00miZTJW1G0y/UIZv
   jkNPcIhIOIx6Obt37ZC6MUVtyDtkag71r9Yl7X0QZbF/jDl4/EPsWSLpl
   7UZo0x+uFZD6iwpjHTF3Ap8cMW2WJozojj8CLLEH63Trq2OTraBgpE5uF
   QMGDyN0Ron1l8mpArk3O+rNfJtCuc84qjFNUiZKEYh+SznVrpoiv5XgPl
   w==;
X-CSE-ConnectionGUID: 390A4T3uToCo1iijxxD3Aw==
X-CSE-MsgGUID: SbSdTwBcR5KpdZywbEPVLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="25511733"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25511733"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 05:18:20 -0700
X-CSE-ConnectionGUID: x3dG418tQQeFLCVpqq8lig==
X-CSE-MsgGUID: cYx9rhtHSdiy00idnX8UEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="106304318"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 05:18:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sqAgJ-00000009S9y-237A;
	Mon, 16 Sep 2024 15:18:15 +0300
Date: Mon, 16 Sep 2024 15:18:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace
 printk(KERN_ERR ...) with pr_err()
Message-ID: <ZugiB0GoNF50OdYC@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
 <2024091438-charity-borough-54b3@gregkh>
 <ZugAeVWeMZGtjYme@smile.fi.intel.com>
 <2024091632-oboe-subfloor-afc8@gregkh>
 <ZugJT4nl1l04biJd@smile.fi.intel.com>
 <20240916080410.464c2b5f@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916080410.464c2b5f@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 16, 2024 at 08:04:10AM -0400, Parker Newman wrote:
> On Mon, 16 Sep 2024 13:32:47 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Sep 16, 2024 at 12:25:52PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Sep 16, 2024 at 12:55:05PM +0300, Andy Shevchenko wrote:
> > > > On Sat, Sep 14, 2024 at 08:58:50PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Sep 13, 2024 at 10:55:40AM -0400, Parker Newman wrote:

...

> > > > > > -			printk(KERN_ERR "%s: timeout\n", __func__);
> > > > > > +			pr_err("%s: timeout\n", __func__);
> > > > >
> > > > > It's a device, please use dev_err().
> > > >
> > > > The problem is that this library doesn't know about this fact. I.e. it would
> > > > need a new member just for this message. Instead, maybe drop the message as we
> > > > anyway get a unique enough error code?
> > >
> > > Fair enough, although adding real device pointers would be good to do in
> > > the future...
> >
> > Let's then do it when it will be the real need? Because I don't think this
> > message is _so_ important. I believe one of the upper layers (whichever calls
> > this function) should propagate the error code up to the user space. If it's
> > not the case _that_ has to be fixed.
> >
> > TL;DR: Let's remove the message for now.
> 
> I can remove the message or leave it as is and drop this patch from the series.
> One could make the argument that any error indication it is better than none
> in this case.

I think you can drop the message and make the patch to be last in the series,
so it can be easily abandoned (in case that decision will be made) without
throttling the rest. At the same time in the commit message explain that with
move to read_poll_timeout() we drop the seems redundant message. I'm fine with
that approach. But at the end of the day it's not that critical to the main
purpose, i.e. cleaning up the Exar serial driver.

-- 
With Best Regards,
Andy Shevchenko


