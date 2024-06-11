Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB5178CCF;
	Tue, 11 Jun 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111453; cv=none; b=ntQXTRHpUsyPOXq6MT4v69/9/8RZy7SCpuY7+FOkBt9j+/U8yrnXRLBycRfsr8zNImx7ycu1uTPTq5WuUp6o0oymuw/DwtG/jwTW2Xb1S7CYPvOUgxaIrfsbnS63kh/j4jJeU+GxsIl1s9trlXQUEUQ/xR+cidHS4lUGQJqQ3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111453; c=relaxed/simple;
	bh=EnAxaZOz7zMvm5pTwep/SQk/d5fTaRBdQ1QoLut1pWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHFalLfbgt/L6xmjcNgRN82sTtPPPJjvmU1ioOslaQPA9ZVlIOeNkluX8HKXJzLPJlpM3D+EJNX54a3N2XwqNAxqIV1RDQIW9O2KCYc0mHlTDh+nFlEg9cKQniPxt3hNliEViLBFRIwRjlSYg8nbu7GFJK7wBoZgwgxfK8fN620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nh929lAm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nh929lAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718111452; x=1749647452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EnAxaZOz7zMvm5pTwep/SQk/d5fTaRBdQ1QoLut1pWs=;
  b=Nh929lAmT1mH/g3s7HRVlohAo0FOrnaEmBGS3NhB7tLZgQOBZIKwZrnx
   4PGuS7HTCcitPJgzJjRlIEV6j8TIPDCC+Qo5Y2BDDItMlAPIM5dzL3unv
   nK3BOSX3+R0hrJhh5UM0NycrCKBg4a67G8k5LTLhicJsIyrNJUqfe9e3Q
   XebnmnbEI6tJSPncgwQnqleT2zMmobPjS0G0sdCMmpIUJXggLn4pz2es5
   +On+Uz/WZGMlsLO5rO8uhQtVJ+yNjvdBxbSHKo+1Yl7AtWuQrwifq0awt
   kUTRR84KAwNhtB2QhE5kSLvhw8By+HINr6t5VPMr+aKFH5pUFkUHv2kmp
   Q==;
X-CSE-ConnectionGUID: dGm38kltQpeF7tTFN74neg==
X-CSE-MsgGUID: S47zH5vTTHWjdtVddSD/mw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14974901"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14974901"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:10:52 -0700
X-CSE-ConnectionGUID: sfOzuFH7Rmi96jN9NYIDqA==
X-CSE-MsgGUID: zqzkO1oYQLGpkOfs/J8dHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39367941"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:10:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sH1Gw-0000000FXkU-08rP;
	Tue, 11 Jun 2024 16:10:46 +0300
Date: Tue, 11 Jun 2024 16:10:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Track command line console positions to fix
 console order
Message-ID: <ZmhM1VPWhuTggsgf@smile.fi.intel.com>
References: <20240606114149.118633-1-tony.lindgren@linux.intel.com>
 <ZmgIB2lQaW9oqn3O@pathway.suse.cz>
 <ZmgfZr5ccHATnkAA@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmgfZr5ccHATnkAA@tlindgre-MOBL1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 11, 2024 at 12:56:54PM +0300, Tony Lindgren wrote:
> On Tue, Jun 11, 2024 at 10:17:11AM +0200, Petr Mladek wrote:
> > On Thu 2024-06-06 14:41:46, Tony Lindgren wrote:

...

> >    So, the DEVNAME:X.Y to ttySZ mapping is:
> > 
> > 	00:00:0.0	-> ttyS0
> > 	serial8250:0.1	-> ttyS1
> > 	serial8250:0.2	-> ttyS2
> > 	serial8250:0.3	-> ttyS3
> > 	[...]
> > 	serial8250:0.30	-> ttyS30
> > 	serial8250:0.31	-> ttyS31
> > 
> >     Why is ttyS0 associated with "so ugly" DEVNAME "00:00"
> >     while the rest uses "nice" DEVNAME "serial8250"?
> 
> Because ACPI serial driver takes over the serial8250 port. Yes we are
> recycling the preallocated serial8250 ports for the hardware specific
> drivers.. That always adds some extra confusion on the top :)

FWIW, 00:00 type of DEVNAME is originating from PNP subsystem (drivers/pnp).

> >     I would expect:
> > 
> > 	serial8250:0.0	-> ttyS0
> > 	serial8250:0.1	-> ttyS1
> > 	serial8250:0.2	-> ttyS2
> > 	[...]
>  
> I believe this would be the situation if you make CONFIG_ACPI is not set
> in the .config.

This is interesting. So, we still have the DEVNAME differences depending on
the kernel configuration? OTOH, I can't imagine either how we can get the
device names more stable as long as some drivers instantiate the platform
device instead of using 8250 core parts (port, base, core) directly.

...

> > If the users defines a non-existing console=SBASE_DEVNAME:X.Y then
> > c->name and c->index will never be set. But it is OK. It will be
> > the same as when user defines a non-existing console=blabla
> > on the command line.
> 
> OK. I think we should keep it as DEVNAME though as it should not be
> limited to serial consoles.

I agree, users know about DEVNAME, like developers know about strcpy(),
there's no specific need for new name.

-- 
With Best Regards,
Andy Shevchenko


