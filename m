Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76948136672;
	Sat, 28 Dec 2024 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735423876; cv=none; b=R506VZEpUNT2Yz2MUiaoSyGgOO0Dq80qM1yeyKNwjkFn6lsaH11OXWnUptZR/x0hIptnY1Dg5IgWaG9VXsX7pKxAny+tn2BfbKtxn/NuTXOZ5AxhzaekVd0oEki1utEi+0nJqHmxnmmCtWy6s/COPqEZDwcFjeZ8LgFL00aMyBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735423876; c=relaxed/simple;
	bh=1KyEfRlDjo8ghE1XWwnIh6L3lj1TMyU9WMnPZnLMdwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLSw/Lc+anRsikFR72ei7muN9H3AW41ds4fXIt0L8b3REu9+L2XixF+rff5EL8o/nfy3OgCYcVanGqJ8ZmFMvPQ2InfTCLH6RuoqimnyKh3MsiX7xVqBV0uq3LwtmDIUZhA8mh1Zf5JIvq3X0derWHPsPyUnB0gk8Gi55q+8IuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeQqV/xG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeQqV/xG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735423874; x=1766959874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1KyEfRlDjo8ghE1XWwnIh6L3lj1TMyU9WMnPZnLMdwY=;
  b=NeQqV/xGjy8QPRugXqFlg5Ugq2l1n22UNxGdrO4MvjbwJR0sy30kpvlj
   8PEvSSxleb3nqV6KRpQ2dhk56+xfPYIh+zmPVIzqfl8dggmXStuBaEWSD
   jXqlFhqZMemzZEVVULW/MxWbiJAWediALRnKA1CO++yzbzuWszngpa12k
   7Z8/c5PKMWCFP4/vhZJ9v9S0Og0S/0g2upwS845FY/0nGyOHqmFH+LUZq
   ALCYQcuen/vnp2rj/xoWI2fQdjfMY196A0GJmUf810OVbyJfdt1uNhn9R
   1JHvIUntfjC6nwIAmcj70snTEdtsGSFYXTVFlUDTsBzpFjVJ4xH1AxnzU
   Q==;
X-CSE-ConnectionGUID: zrLdSbioQ06w+8k6w9LF/Q==
X-CSE-MsgGUID: n11Si/hERv+qw8kx7fdCsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39545769"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="39545769"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 14:11:14 -0800
X-CSE-ConnectionGUID: WBveGcbfTrKgYvfgnXd0xw==
X-CSE-MsgGUID: NbIoEZ6YTG+eGLpxKGT5+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="100193417"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 14:11:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tRf1X-0000000DUuM-1cTB;
	Sun, 29 Dec 2024 00:11:07 +0200
Date: Sun, 29 Dec 2024 00:11:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
	Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH tty-next v4 5/6] serial: 8250: Switch to nbcon console
Message-ID: <Z3B3e6ppZc94Pdck@smile.fi.intel.com>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <20241227224523.28131-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227224523.28131-6-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 27, 2024 at 11:51:21PM +0106, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks:
> 
>   ->write_atomic()
>   ->write_thread()
>   ->device_lock()
>   ->device_unlock()
> 
> and add CON_NBCON to the initial @flags.
> 
> All register access in the callbacks are within unsafe sections.
> The ->write_atomic and ->write_therad() callbacks allow safe

->write_atomic()

> handover/takeover per byte and add a preceding newline if they
> take over from another context mid-line.
> 
> For the ->write_atomic() callback, a new irq_work is used to defer
> modem control since it may be called from a context that does not
> allow waking up tasks.
> 
> Note: A new __serial8250_clear_IER() is introduced for direct
> clearing of UART_IER. This will allow to restore the lockdep
> check to serial8250_clear_IER() in a follow-up commit.

...

>  		if (toggle_ier) {
> +			/*
> +			 * Port locked to synchronize UART_IER access
> +			 * against the console

Missing period in multi-line comment.

> +			 */
> +			lockdep_assert_held_once(&p->port.lock);
> +
>  			p->ier |= UART_IER_RLSI | UART_IER_RDI;
>  			serial_port_out(&p->port, UART_IER, p->ier);
>  		}

...

> -static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
> +static int fifo_wait_for_lsr(struct uart_8250_port *up,
> +			      struct nbcon_write_context *wctxt,
> +			      unsigned int count)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < count; i++) {
> +		if (!nbcon_can_proceed(wctxt))
> +			return -EPERM;
> +
>  		if (wait_for_lsr(up, UART_LSR_THRE))
> -			return;
> +			return 0;
>  	}
> +
> +	return -ETIMEDOUT;
>  }

...

>  static void serial8250_console_fifo_write(struct uart_8250_port *up,
> -					  const char *s, unsigned int count)
> +					  struct nbcon_write_context *wctxt)
>  {
> -	const char *end = s + count;
>  	unsigned int fifosize = up->tx_loadsz;
>  	struct uart_port *port = &up->port;
> +	const char *s = wctxt->outbuf;
> +	const char *end = s + wctxt->len;
>  	unsigned int tx_count = 0;
>  	bool cr_sent = false;
>  	unsigned int i;
>  
>  	while (s != end) {
>  		/* Allow timeout for each byte of a possibly full FIFO */
> -		fifo_wait_for_lsr(up, fifosize);
> +		if (fifo_wait_for_lsr(up, wctxt, fifosize) == -EPERM)
> +			return;

Perhaps it was already discussed and I forgot about it or hadn't read,
but I don't get how per-byte check for NBCON permission can help if there
is something already in the HW FIFO?

I mean in _this_ case wouldn't be enough to check FIFO to drain and only after
that check the permission?

>  		for (i = 0; i < fifosize && s != end; ++i) {
>  			if (*s == '\n' && !cr_sent) {

>  	 * Allow timeout for each byte written since the caller will only wait
>  	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
>  	 */
> -	fifo_wait_for_lsr(up, tx_count);
> +	fifo_wait_for_lsr(up, wctxt, tx_count);
> +}


...

> +	if (up->msr_saved_flags) {
> +		/*
> +		 * For atomic, it must be deferred to irq_work because this
> +		 * may be a context that does not permit waking up tasks.
> +		 */
> +		if (is_atomic)
> +			irq_work_queue(&up->modem_status_work);
> +		else
> +			serial8250_modem_status(up);

Hmm... Shouldn't this be part of _modem_status() for all drivers using this call?

> +	}

...

> +	bool			console_line_ended;	/* line fully output */

Sorry, I didn't get the comment. Do you meant "line is fully printed out
[to HW]"?

-- 
With Best Regards,
Andy Shevchenko


