Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520EA10A1C;
	Wed, 18 Sep 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726678997; cv=none; b=TvLiB8w3lrPQuWAcCvTswAhc7+ykf6Zu679YwwPxg5SYC4vMznCaS2LNztCcJy/08lrrZO898bUYQ1BrPFzrBB9ctDpKSHDZvUeoZ5FIqZ0EcKCM+nFfmonJe3vvalaJPcYB65adZIu9/WR7JRS0vy2pVoe8/7h/k9+Rz85tlqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726678997; c=relaxed/simple;
	bh=7Bm6YYpbYacPnkSdouuFXqtsLgbXV3+G8KG/QnHbllg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED0vhXbLxRVMZLWsKILA8KPGdUJgSi/FLecKx9G+BnYTskMXM8yjC6eQSsA3kQuQDGJ4gLHxwR9Uh18mbU16PFr1mFdlP+NnPXpv+RwYfC3oSU4R0YTiEsV7YpWJgy2oM5vf3vnt+Fwa9cJlUF18xuS8Bg5FqrjqHVeNlHE9QGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lsa+qU29; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lsa+qU29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726678996; x=1758214996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Bm6YYpbYacPnkSdouuFXqtsLgbXV3+G8KG/QnHbllg=;
  b=Lsa+qU29s8u/42oLxdg6HdGm0HWXik8aZjB1iM50P5phJSPc6auzmH/3
   sSJp1Six0gQzGLvjuYE4U2tdlY+yGL3tX3P/nWcXBFhiPjgtJ7rcz/sNL
   FcALABj5YCF4jlms1d6JJrDXIH8rdiqeD4Y9hLYbPNUeHsI3n/wdWQdjQ
   HstmjLofbnn+M08nmaiYIq24BGF90xzVlwJtZ6W0SsOUdAtfQ1QnXTgSd
   0Mgw5rYB5DUMvpcGSlCliVastWaqKIwnsXRNq2uAtBAgEceuEPzh8acm+
   9SovH0il38rbKT/Lbmi0GDz78PWJBTxcQORN5o4q33sdQmG8m0/MWn7r/
   w==;
X-CSE-ConnectionGUID: MhV4LHheRM2C77T2YHVGqQ==
X-CSE-MsgGUID: /1u25JrnSJ+eEIeNZTuQ4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25091375"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="25091375"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 10:03:12 -0700
X-CSE-ConnectionGUID: x4d7AHz3Q0y2AvaBMlF6wg==
X-CSE-MsgGUID: 2Xi0IePWSuitWqYxxLX3JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="74637804"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 10:03:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sqy51-0000000AFKw-24Ag;
	Wed, 18 Sep 2024 20:03:03 +0300
Date: Wed, 18 Sep 2024 20:03:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH next v2 3/4] serial: 8250: Switch to nbcon console
Message-ID: <ZusHx53h5H9JhJVt@smile.fi.intel.com>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-4-john.ogness@linutronix.de>
 <ZurG8YMmBmVVxttj@pathway.suse.cz>
 <ZurdNw6lRYwClbuf@smile.fi.intel.com>
 <ZurlGqIdCbeSjYDj@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZurlGqIdCbeSjYDj@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 18, 2024 at 04:35:06PM +0200, Petr Mladek wrote:
> On Wed 2024-09-18 17:01:27, Andy Shevchenko wrote:
> > On Wed, Sep 18, 2024 at 02:26:25PM +0200, Petr Mladek wrote:
> > > On Fri 2024-09-13 16:11:37, John Ogness wrote:
> > > > Implement the necessary callbacks to switch the 8250 console driver
> > > > to perform as an nbcon console.
> > > > 
> > > > Add implementations for the nbcon console callbacks (write_atomic,
> > > > write_thread, device_lock, device_unlock) and add CON_NBCON to the
> > > > initial flags.
> > > > 
> > > > All register access in the callbacks are within unsafe sections.
> > > > The write_thread() callback allows safe handover/takeover per byte.
> > > > The write_atomic() callback allows safe handover/takeover per
> > > > printk record and adds a preceding newline if it took over mid-line.
> > > > 
> > > > For the write_atomic() case, a new irq_work is used to defer modem
> > > > control since it may be a context that does not allow waking up
> > > > tasks.
> > > 
> > > It would be fair to mention that it does not longer support fifo in
> > > the 8250 driver. It basically reverted the commit 8f3631f0f6eb42e5
> > > ("serial/8250: Use fifo in 8250 console driver").
> > > 
> > > It is not usable in write_thread() because it would not allow
> > > a safe takeover between emitting particular characters.
> > > 
> > > It might still be used in write_atomic() but it is probably not
> > > worth it. This callback is used "only" in emergency and panic
> > > situations.
> > 
> > This is unfortunate. It will drop down the efficiency of printing.
> 
> The FIFO mode has been added by the commit 8f3631f0f6eb42e5
> ("serial/8250: Use fifo in 8250 console driver"). The interesting
> parts are:
> 
> <paste>
>   While investigating a bug in the RHEL kernel, I noticed that the serial
>   console throughput is way below the configured speed of 115200 bps in
>   a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
>   I got 2.5KB/s.
> 
>   In another machine, I measured a throughput of 11.5KB/s, with the serial
>   controller taking between 80-90us to send each byte. That matches the
>   expected throughput for a configuration of 115200 bps.
> 
>   This patch changes the serial8250_console_write to use the 16550 fifo
>   if available. In my benchmarks I got around 25% improvement in the slow
>   machine, and no performance penalty in the fast machine.
> </paste>
> 
> I would translate it:
> 
> The FIFO mode helped with some buggy serial console. But it helped to gain
> only small portion of the expected speed. The commit message does not
> mention any gain with the normally working system.
> 
> It has been added in 2022. It was considered only because of a
> "broken" system. Nobody cared enough before.
> 
> > I think it should be done differently, i.e. the takeover the code
> > has to drop FIFO (IIRC it's easy to achieve by disabling it or so)
> > and switch to printing the panic/emergency message. But still at
> > some baud rate speeds draining the FIFO to the other end may be
> > not a bad idea as it takes a few dozens of microseconds.
> 
> Sure. it is doable. But I am not convinced that it is really worth it.

Fair enough. But perhaps Cc to the author to at least notify them about
this change?

-- 
With Best Regards,
Andy Shevchenko


