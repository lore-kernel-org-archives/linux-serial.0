Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B91188CD5;
	Thu,  5 Sep 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564670; cv=none; b=p2DJMIctv/9VUGBC+4pFWA7b5Z2iGFdLrW0R11lgYei9BqlR3A/TN+zBPqt3hJJFXGhhXVg0mNj1yxaQLMpK1OiXCicVt1qYnD3JYwd2xexXA7yvPa8BQSfNsn1KNn5BJRX0ZREvWaAC0SvHq8hqusgW/SARGGxw6FwJ7+dRGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564670; c=relaxed/simple;
	bh=iAEhEzvy5tIJDz7skG0Tq7Bm+QgWg4x5so4Hw+5ILJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snmUlwdnnaEzOPOH43Iy9inl0pHFZxUl5w5xyPThahLNuHK6WvhPFPHSHd4WrpgC0vaJk9kKbZ0JLHkxtr1ELGKWT+fCw2TIagRquZfiNTXO8JFvoKxITEE6cEkanDL/xn6MIAosYtemW1ui9le/EU721qLL036L00KSs7KFKTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAg6PVKi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAg6PVKi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725564669; x=1757100669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iAEhEzvy5tIJDz7skG0Tq7Bm+QgWg4x5so4Hw+5ILJI=;
  b=NAg6PVKi1kqfgv/ZgdiXCRALBJsmFnb1KqgzRmZIBShKE+OG5qh+wRs0
   z/ANQhl8oMsgzyBHl9JWqtsCeP2fRT3gBiS0W5gJIhGXCeKqdp+aBJmlb
   w5zLmRtb70mYl3JdfEps7BU37xzF8C06V/8Wtm9FKqsFqQRLGUPlfxqc+
   0tV0WQf8wyujEOZ2Ts9qPp/2k6HV6HibJB88R5Sp7Z4SHcx29LJgFd3k6
   U2f84J46QL7rbSynWF8BVYfVbM+oMPwzNjo8LQkZ+QfQhPFZZrV3wSr80
   hvzCtItob+IejMP3e11rI1lqiiTxCZpuH3u0W3rEML3xArxF1MviEstKJ
   w==;
X-CSE-ConnectionGUID: SXU7xIMcThGmEKcdE4suyA==
X-CSE-MsgGUID: hyaDXeJ5RK2bGbHXaGXatg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24179015"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="24179015"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 12:31:06 -0700
X-CSE-ConnectionGUID: nFMf7UjDT92Az+E/U9y7UA==
X-CSE-MsgGUID: 7Ho9hBQZTbe8Cug6eUaBow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="103182845"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 12:30:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smIC0-00000005X00-1JW5;
	Thu, 05 Sep 2024 22:30:56 +0300
Date: Thu, 5 Sep 2024 22:30:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
Message-ID: <ZtoG74hR2_bLI4w1@smile.fi.intel.com>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
 <20240905134719.142554-2-john.ogness@linutronix.de>
 <Ztm85Y_mo5-OJveq@smile.fi.intel.com>
 <877cbp3nxh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cbp3nxh.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 09:29:06PM +0206, John Ogness wrote:
> On 2024-09-05, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Sep 05, 2024 at 03:53:18PM +0206, John Ogness wrote:

...

> >> +#ifdef USE_SERIAL_8250_LEGACY_CONSOLE
> >
> > Can it be done at run-time (theoretically or even practically)?
> > (Note that we have already knob to disable / enable consoles.)
> 
> We don't want to maintain the legacy variant and really people should
> not be using it either. NBCON is the way forward for all console
> drivers.
> 
> I will just remove it for v2. If someone wants to use the old code, they
> will need to revert the patch.

This is even better!

-- 
With Best Regards,
Andy Shevchenko


