Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD51A1B394C;
	Fri, 25 Oct 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866130; cv=none; b=ievY4+jBrAnTLRhA6VyMKSvljur64fD5CWxCSa9nk/XVeYhdDqhz6neZ9+bewkKm8KDLIPiVT/vpwG00YJRrHAkUUIVw+ipGXPna7MsKrtOQhm761ArsP5qBXOrylgywu98Ob6hdiV9dWy4//3tAuAXBJRK1aIJhwLH73VexkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866130; c=relaxed/simple;
	bh=TN4OxRFHbJ1BMTjYvFnIlBeAF/2g+OdJo63VyblCr8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOnZvwuHrXnH1s8+1e3qi5tPsTUg9CJ/XYTKnuDRVwgOeCAJuLAUcouaeR9VnU4/lNlo2/7USkWDkR71ZDGeolsewhEveSB9t32LwG9svchCMhGWDh8uSeonScoD5SPLCRy3MuwcxwUNBvPUpy+eQlMzG6zfBDaO7EAN/Misk5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ugz6iAdv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ugz6iAdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729866129; x=1761402129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TN4OxRFHbJ1BMTjYvFnIlBeAF/2g+OdJo63VyblCr8k=;
  b=Ugz6iAdvDdpH7n/D05hEpPc2FOwaE2d6o58JHq507eLoAP/yrh8lf7fp
   8DgtsDGyWmJANQLxFKJKY1TA1Kqkud8tI4A1ewL4H2zl0dsywoyh+CWXj
   nuSamU7y9qn7DKRLOXBM50NlOL7lkpP68mzk81LFy/N8q4Jm6xemj1BRM
   B7N7z1kxnj2Lnk/YDkmTr2JMoqFKqGyQQbffIFiph1fFZ8NLvlKOpSp5I
   2p6JssK/+BtRzgJhCKpvpkkwq8cVzshOoZuWLfcwuF6bUw4nmu2DdSw24
   GNacxnBCanNwX+dPpN0xhlEXw4kEzCvqjsRQTFXtMM0T2SMelcYq8vtn0
   w==;
X-CSE-ConnectionGUID: h76bQ+1QTDGKOp/7ay1xog==
X-CSE-MsgGUID: mFQQpUV4TaWQJ+EZSSbZtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40088835"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40088835"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:22:08 -0700
X-CSE-ConnectionGUID: acPrhvPuSuWyAPKLyt2B7g==
X-CSE-MsgGUID: IkEUIwJARqeWoHaAOOINBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80522955"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:22:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4LCS-00000006wFw-24xi;
	Fri, 25 Oct 2024 17:22:00 +0300
Date: Fri, 25 Oct 2024 17:22:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Peter Collingbourne <pcc@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH tty-next v3 5/6] serial: 8250: Switch to nbcon console
Message-ID: <ZxupiKSSpZlyKhz-@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025105728.602310-6-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 01:03:27PM +0206, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks (write_atomic,
> write_thread, device_lock, device_unlock) and add CON_NBCON to the
> initial flags.

Again, use consistent style for the references to the callbacks.
it may be .func, or ->func(), or something else, but make it consistent.

> All register access in the callbacks are within unsafe sections.
> The write callbacks allow safe handover/takeover per byte and add
> a preceding newline if they take over mid-line.
> 
> For the write_atomic() case, a new irq_work is used to defer modem
> control since it may be a context that does not allow waking up
> tasks.

...

> +/*
> + * Only to be used directly by the console write callbacks, which may not
> + * require the port lock. Use serial8250_clear_IER() instead for all other
> + * cases.
> + */
> +static void __serial8250_clear_IER(struct uart_8250_port *up)
>  {
>  	if (up->capabilities & UART_CAP_UUE)
>  		serial_out(up, UART_IER, UART_IER_UUE);

>  		serial_out(up, UART_IER, 0);
>  }
>  
> +static inline void serial8250_clear_IER(struct uart_8250_port *up)
> +{
> +	__serial8250_clear_IER(up);

Shouldn't this have a lockdep annotation to differentiate with the above?

> +}

...

> +static void serial8250_console_byte_write(struct uart_8250_port *up,
> +					  struct nbcon_write_context *wctxt)
> +{
> +	const char *s = READ_ONCE(wctxt->outbuf);
> +	const char *end = s + READ_ONCE(wctxt->len);

Is there any possibility that outbuf value be changed before we get the len and
at the end we get the wrong pointer?

> +	struct uart_port *port = &up->port;
> +
> +	/*
> +	 * Write out the message. Toggle unsafe for each byte in order to give
> +	 * another (higher priority) context the opportunity for a friendly
> +	 * takeover. If such a takeover occurs, this must abort writing since
> +	 * wctxt->outbuf and wctxt->len are no longer valid.
> +	 */
> +	while (s != end) {
> +		if (!nbcon_enter_unsafe(wctxt))
> +			return;
> +
> +		uart_console_write(port, s++, 1, serial8250_console_wait_putchar);
> +
> +		if (!nbcon_exit_unsafe(wctxt))
> +			return;
>  	}
>  }

...

> +/*
> + * irq_work handler to perform modem control. Only triggered via
> + * write_atomic() callback because it may be in a scheduler or NMI

Also make same style for the callback reference in the comments.

> + * context, unable to wake tasks.
> + */

...

>  struct uart_8250_port {

>  	u16			lsr_save_mask;
>  #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
>  	unsigned char		msr_saved_flags;
> +	struct irq_work		modem_status_work;
> +
> +	bool			console_line_ended;	/* line fully output */
>  
>  	struct uart_8250_dma	*dma;
>  	const struct uart_8250_ops *ops;

Btw, have you run `pahole` on this? Perhaps there are better places for new
members?

-- 
With Best Regards,
Andy Shevchenko


