Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51E212177;
	Fri, 25 Oct 2024 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864304; cv=none; b=bVhixkqoPuQE5jzIjRmojD208wFkHr+gMAMdOmFEpsbBVl//KdjPJjctLUnH3mKVQWP95uODTPXN2HjHGgqsddr4WbsdabpjDVmJTqfuqF4U8m2RQyBEuvx0BvqaBVFZXPFzPLgg/iPosrOJmj65QmpazIbQ8ErF7uOlCY7FeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864304; c=relaxed/simple;
	bh=JFuBAWwhZ64OtJ2J+upd1f+bDnaJQjFGuWo4p/GII44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCe6QhKGw0//eh7JcJKViahEiucoFrcNWNw+xDC0Z1fNnH7gWN3Idk0OInDg9AgN364/hQrYYKmG1Eywt+KpJjX6/R/3kRzR/iyBK8le8yF7fxlsX5Zj5I65gNXYJl8F3rEWOnydgqq7HFJq9KzUckh6ubxkfhdsNjr0mLrqpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXc6RNSn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXc6RNSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729864303; x=1761400303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JFuBAWwhZ64OtJ2J+upd1f+bDnaJQjFGuWo4p/GII44=;
  b=LXc6RNSn0QjoKsxJWVIwS+aZiO00wINdiK0LAmir8MqCdZKtK6xV6VgP
   vvuBDKAtyPs97WZB4KMQKlLsSRZuLEsKCmmqho4W9StvrC75xHNEu1q+L
   wvgJW9I9Y1gJiCO+zXOp5s0il3cQsJmn1psJYMZSXr44NKgpZLY4q0DT/
   WChWE39YeJv9dvWr4c8lQHQglg/z87+Ae0ujyHefO1yPrfHhqp+b/yuId
   zgqkR48H+vpZOiJtuiqH1dJV+ojK8XlM+6K1v725Y6PUIWE8KpzeBpiK/
   fNSCPzZVqNPvarH9GDhJtPEptzupUdnhgGvgy4ObW9m0lKlR4/TQhlXi9
   A==;
X-CSE-ConnectionGUID: OuOypAb5STyG51/a/5rAsg==
X-CSE-MsgGUID: HSA0WkPXTceyFX7Z8WSDeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29642563"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29642563"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:51:42 -0700
X-CSE-ConnectionGUID: U/FOFjRxRR+22jsIy2Wa9A==
X-CSE-MsgGUID: TXln7RFnTZCXnflLWWAkcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85703401"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:51:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4Kj0-00000006vlf-4BjN;
	Fri, 25 Oct 2024 16:51:35 +0300
Date: Fri, 25 Oct 2024 16:51:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rengarajan S <rengarajan.s@microchip.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for
 FIFO mode
Message-ID: <ZxuiZtqWA_5cmy63@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-2-john.ogness@linutronix.de>
 <Zxug3qF9KUOn4VaM@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxug3qF9KUOn4VaM@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 04:45:02PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 25, 2024 at 01:03:23PM +0206, John Ogness wrote:
> > After a console has fed a line into TX, it uses wait_for_xmitr()
> > to wait until the data has been sent out before returning to the
> > printk code. However, wait_for_xmitr() will timeout after 10ms,
> 
> printk here is a function reference or module?
> For the latter I would use the filename to be sure it's clear,
> like printk.c. For the former (and it seems you know that)
> we may use printk().
> 
> > regardless if the data has been transmitted or not.
> > 
> > For single bytes, this timeout is sufficient even at very slow
> > baud rates, such as 1200bps. However, when FIFO mode is used,
> > there may be 64 bytes pushed into the FIFO at once. At a baud
> > rate of 115200bps, the 10ms timeout is still sufficient.
> > However, when using lower baud rates (such as 57600bps), the
> > timeout is _not_ sufficient. This causes longer lines to be cut
> > off, resulting in lost and horribly misformatted output on the
> > console.
> > 
> > When using FIFO mode, take the number of bytes into account to
> > determine an appropriate max timeout. Increasing the timeout
> 
> maximum
> (in order not to mix with max() function)
> 
> > does not affect performance since ideally the timeout never
> > occurs.
> 
> ...
> 
> >  /*
> >   *	Wait for transmitter & holding register to empty
> > + *	with timeout
> 
> Can you fix the style while at it?
> 
> >   */
> 
>  /* Wait for transmitter & holding register to empty with timeout */
> 
> ...
> 
> >  static void serial8250_console_fifo_write(struct uart_8250_port *up,
> >  					  const char *s, unsigned int count)
> >  {
> > -	int i;
> >  	const char *end = s + count;
> >  	unsigned int fifosize = up->tx_loadsz;
> > +	unsigned int tx_count = 0;
> >  	bool cr_sent = false;
> > +	unsigned int i;
> >  
> >  	while (s != end) {
> > -		wait_for_lsr(up, UART_LSR_THRE);
> > +		/* Allow timeout for each byte of a possibly full FIFO. */
> 
> Does the one-line comment style in this file use periods? If not, drop,
> otherwise apply it to the above proposal.
> 
> > +		for (i = 0; i < fifosize; i++) {
> > +			if (wait_for_lsr(up, UART_LSR_THRE))
> > +				break;
> > +		}
> 
> > +	}
> > +
> > +	/* Allow timeout for each byte written. */
> > +	for (i = 0; i < tx_count; i++) {
> > +		if (wait_for_lsr(up, UART_LSR_THRE))
> > +			break;
> 
> This effectively repeats the above. Even for the fix case I would still add
> a new helper to deduplicate.
> 
> >  	}
> >  }

Forgot to add, with the above being addressed, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


