Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8781F16B;
	Wed, 18 Sep 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668099; cv=none; b=EOg0+RpKoW5DlrTcJYyE1nE58tFLKkT+vdig7+AmXaMP8Il+VT7OTilFjfFDHQxGGIhB7maMq9Yc41vFvglV1pcS1GFartSIODPGdrkeIiv9utdCAH5TfUuRFXZCXBNRCWVen1kk9Ed6GzrvN5o3M73W3jPFdtw9o3q6AVuvluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668099; c=relaxed/simple;
	bh=TC05tVa/tpsMqGnaGxHFacAi74RCpUHHCRaCpn7/MkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOXYUdzT6XJXGiKtwo1SS9Nf0gOhYlJEsmXiYLvjJqgJThUl1+PtThm7ffJDArgheYBBP/g9mNbhD3q2uwkyquC94LFDdB2ggn1PYSwJDKRuqqSYStTVxkRoaM3EYfs5n/VN3prWOucJIMYUsOqgWJXpTI2GtZfFQXyCnxJvgg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BV3eaoYt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BV3eaoYt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726668098; x=1758204098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TC05tVa/tpsMqGnaGxHFacAi74RCpUHHCRaCpn7/MkQ=;
  b=BV3eaoYtTxhneQVDRv2UcK8tANTcSQBOZ7L3LYmR3rDj7tOomd6gHScy
   8POL1C+Kx9Yf+8a1XofYHiBP8oqy5DswekJdoU/SKJ5oMAklFw2WUgql2
   xfMwoxxI/rWBvt8a3EJV6DfVcO1pGz7ri1zEOUiBl9G710P7mYmp2wkfG
   vPH3x7KegcH5mVW7jBTd0H67CbLF2kqO9FS0Xp3PdEiue/UeSY92TGx/H
   44AQ8eUWlYrY+6PGeowxOC/mxDFvyPn5pptbdtsNPHxO3mfE2P5I1F76J
   FpRI+68VfN9zFeQJUyjk21qMK4ChXO+AC+qNtDh9PXgMGszmvIUtudvH1
   A==;
X-CSE-ConnectionGUID: JXc3jD3uSFmjrZJIp8oQdA==
X-CSE-MsgGUID: co95DV1EQveHiyKLiigRlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="28487237"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="28487237"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 07:01:36 -0700
X-CSE-ConnectionGUID: j6C+cUOzTmaw/3LGnOiEvA==
X-CSE-MsgGUID: ecYhGilzT5WPQmxF1c2XHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="74399299"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 07:01:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sqvFH-0000000ACKv-2En7;
	Wed, 18 Sep 2024 17:01:27 +0300
Date: Wed, 18 Sep 2024 17:01:27 +0300
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
Message-ID: <ZurdNw6lRYwClbuf@smile.fi.intel.com>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-4-john.ogness@linutronix.de>
 <ZurG8YMmBmVVxttj@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZurG8YMmBmVVxttj@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 18, 2024 at 02:26:25PM +0200, Petr Mladek wrote:
> On Fri 2024-09-13 16:11:37, John Ogness wrote:
> > Implement the necessary callbacks to switch the 8250 console driver
> > to perform as an nbcon console.
> > 
> > Add implementations for the nbcon console callbacks (write_atomic,
> > write_thread, device_lock, device_unlock) and add CON_NBCON to the
> > initial flags.
> > 
> > All register access in the callbacks are within unsafe sections.
> > The write_thread() callback allows safe handover/takeover per byte.
> > The write_atomic() callback allows safe handover/takeover per
> > printk record and adds a preceding newline if it took over mid-line.
> > 
> > For the write_atomic() case, a new irq_work is used to defer modem
> > control since it may be a context that does not allow waking up
> > tasks.
> 
> It would be fair to mention that it does not longer support fifo in
> the 8250 driver. It basically reverted the commit 8f3631f0f6eb42e5
> ("serial/8250: Use fifo in 8250 console driver").
> 
> It is not usable in write_thread() because it would not allow
> a safe takeover between emitting particular characters.
> 
> It might still be used in write_atomic() but it is probably not
> worth it. This callback is used "only" in emergency and panic
> situations.

This is unfortunate. It will drop down the efficiency of printing.
I think it should be done differently, i.e. the takeover the code
has to drop FIFO (IIRC it's easy to achieve by disabling it or so)
and switch to printing the panic/emergency message. But still at
some baud rate speeds draining the FIFO to the other end may be
not a bad idea as it takes a few dozens of microseconds.

-- 
With Best Regards,
Andy Shevchenko


