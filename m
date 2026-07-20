Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2443BE144
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559502; cv=none; b=hlL7+24PCKc6nVsxt2x3osXwCn/xAVLu8F/abfcqAGDezUXOeu4e0uZAwFKrPTLfmudKk5YbRpVZRrN1r9YsCEO8MtxGyKrR7rp3xeIn+uNGek9rksici1CM8GVWc/wBSR5h5cxFP1cNmJjAaedepgdS2HlBklIqojcKwgYuXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559502; c=relaxed/simple;
	bh=jzFQWnseWWxoyN1ShXRYtH2cU8pOwjWhXzAAGBHZ/o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHs8Dk9dERdhKySjm1OerA2+0OrXpq4aqBxFfrK0gCKmZkkZI0NJ15AKZDipYH8h8j5+e9nV7ax3ASKKWQdLTJ3ib9oFjjzWp1wkrPEnOX2OjcAOvxmvM+S3WLB1RJawtg1ik9CvKMVjBdyV17QLNcHEOxlCW9U61ZLPD7NAZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qxa7InTI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qxa7InTI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4955de8797cso6664765e9.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784559498; x=1785164298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b0HRbfmTok9CVSMITXJl4LP8yNtyhGJvNwreiAeO/rE=;
        b=Qxa7InTId4jxsi8L7wDj+tJXo2LRH9jkCs0AEiFJq/9XpGp+4Mufh96ShRko1JvwNu
         JjRDK2uBIz8S12cMRHUaeRAS791j7SlzpHHAFz1ICATh5zoUjqMils+HL6t+V69TUPP7
         +crIZ4ZHXNx4BBp225A1QpygzqY3lA6bj/NpQCPA1zGPB/J01w9jJYJKUzyF799xHswz
         0VeXTy9Z8OBAdIeREZwN4DwJPFID2DRtKosTIq+OqUXtvtBR/rLZ+rYcmpW/InFHt9Ln
         8oLbZbHBtqW04GezqBmjVWF01zGKSIxtqiksWoXs3GdNN30cz2O0hl6fCLZ2bvinqmHj
         nITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784559498; x=1785164298;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0HRbfmTok9CVSMITXJl4LP8yNtyhGJvNwreiAeO/rE=;
        b=Dn57ryPsx7kX0oCBr6W7mRr/9XLBGrEqe+xKhaVrgUWwyNLTVlI6/RYTa0Sog/iiyp
         zizx8H6yqOG9XBMsNEU5vej2q7Vo8h7iG4M9/gfoxuBL/fdEQCivDeC3Wwj9sIDbJTcT
         ArV94hvFEu9pTR0j9mB5SZhmFmc4gsL90zVnZiQ8cJQwg4cFdy5HV+EKmKbQ4uIfxKBD
         M/ZESvRH2+hTYkiId3BUyveHVkw1vnq6siDWumzPLd+y74tzjJ70iOyTQzOdVQoukYsF
         lH+dFKAWAZqOdSaKbXm6kLlgWpwCSTDwThrbYDI76J+mK6yK13xX+x4EcDsuthPa5u6p
         rI2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqn3oGvOsAgX/5rxlE/epCUGt+fNs7hmbl2iKOBJDo7FVXOWh7bJS1Oka7ZupcNhajOWVNzLbT6If1eD0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3DmyL9frWggzSrzoQTFFhWPPDmKmlGCe4vWkXXA0o5drUe89
	u1sEhWVf9Cm+RBCAsdJewRX/fRlykubhsD8i3gJ8z8q+W9Bk/WUfeouk932Qyw1tBSg=
X-Gm-Gg: AfdE7cnCRABbkAz5XRte+MrUhW+bmw6XojZFseq1yRezWuAB31MUxw1FYJhNPooO+b3
	vGm0KgpmP8ODp7NUXkGpRIOTb7nQszpudllXmIYUQWXAp+44bzEjagtfjG6agyi6O9/18o/BH24
	IsGCp0KS6DsfQn5fJjo7KqscVXQEZ6NDPJf5mi6sx3ToSWByF90DiG6GPTwV8Zj+yrqIzGlSECe
	6nc2N/1gyfXAM3ea8/PsSTJGWHuZvIEe/w2kARCB/XZqA4Xjw57YSP76u6Xaui94AS4nzWPoGLb
	opSXz/MrQTV0kRAOZAyIWJDIi/0YPddGCjVfTx4yNWCJmaVV8gPnUpgg2YXqsnKph1yZBO36trj
	kmlr49QrbXgxrd4Dv8I2BQ1azoZG1+Pm/1hiiDKLa0g7UcjPsTJQ944vgHvahUuhJGqt9z6kLF2
	LxCcMP
X-Received: by 2002:a05:600d:644d:10b0:495:5de0:d87 with SMTP id 5b1f17b1804b1-4955de00e16mr44746845e9.36.1784559498351;
        Mon, 20 Jul 2026 07:58:18 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a47de7sm292714245e9.7.2026.07.20.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:58:18 -0700 (PDT)
Date: Mon, 20 Jul 2026 16:58:16 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Stepan Ionichev <sozdayvek@gmail.com>, Kees Cook <kees@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, Jacques Nilo <jnilo@free.fr>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v6 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <al43iOyokb56SBF3@pathway.suse.cz>
References: <20260720103242.7265-1-john.ogness@linutronix.de>
 <20260720103242.7265-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720103242.7265-2-john.ogness@linutronix.de>

On Mon 2026-07-20 12:38:35, John Ogness wrote:
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
> All hardware access in the callbacks is within unsafe sections.
> The ->write_atomic() and ->write_thread() callbacks allow safe
> handover/takeover per byte and add a preceding newline if they
> take over from another context mid-line.
> 
> For the ->write_atomic() callback, a new irq_work is used to defer
> modem control since it may be called from a context that does not
> allow waking up tasks. During suspend/resume the irq_work is not
> used as this has been shown to cause suspend problems for some
> hardware. Upon resume, any pending modem control is performed.
> 
> Note: A new __serial8250_clear_IER() is introduced for direct
> clearing of UART_IER during console writing (which may not be
> holding the port lock for atomic printing). This allows restoring
> a lockdep check to serial8250_clear_IER() in a follow-up commit.
> 
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -584,6 +609,9 @@ void serial8250_suspend_port(int line)
>  	struct uart_8250_port *up = &serial8250_ports[line];
>  	struct uart_port *port = &up->port;
>  
> +	/* No irq_work may be queued when suspending. */
> +	up->avoid_modem_status_work = true;

Do we need to synchronize this against serial8250_console_write()
where this flag is checked, please?

My understanding is that we should be on the safe side. Otherwise
there might be bigger problems.

I believe that this is called after both console_suspend_all() and
console_suspend(uport->cons). The later makes sure that the console
is not longer used even when @console_suspend_enabled is false.
And these functions even call synchronize_srcu(&console_srcu).

This might even answer the question from Sashiko AI whether
we should flush the related irq_work() here, see
https://sashiko.dev/#/patchset/20260720103242.7265-1-john.ogness%40linutronix.de

That said, I am not sure about RT_PREEMPT. AFAIK, it handles IRQs
in a kthread. In this case, synchronize_srcu() would not make
sure that the irq_work was procceed.

Note that Sashiko AI suggests that we might need to flush the irq_work
even in serial8250_console_exit(). I guess that the situation is
the same there. It is called after synchronize_srcu()...

> +
>  	if (!console_suspend_enabled && uart_console(port) &&
>  	    port->type != PORT_8250) {
>  		unsigned char canary = 0xa5;
> @@ -620,6 +648,12 @@ void serial8250_resume_port(int line)
>  		port->uartclk = 921600*16;
>  	}
>  	uart_resume_port(&serial8250_reg, port);
> +
> +	/* irq_work allowed again. Handle MSR now if pending. */
> +	up->avoid_modem_status_work = false;
> +	guard(uart_port_lock_irqsave)(port);
> +	if (uart_console(port) && up->msr_saved_flags)
> +		serial8250_modem_status(up);

I would use scoped_guard() to make the scope clear. Something like:

	scoped_guard(uart_port_lock_irqsave, port) {
		if (uart_console(port) && up->msr_saved_flags)
			serial8250_modem_status(up);
	}

Motivation: The guard() is pretty hidden. It can easily get overlooked
	when people add more code at the end of this function.

Wait, this should not be needed if we make sure that the work
was flushed in serial8250_suspend_port().

>  }
>  EXPORT_SYMBOL(serial8250_resume_port);
>  
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3286,39 +3329,57 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
>  	 * Allow timeout for each byte written since the caller will only wait
>  	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
>  	 */
> -	serial8250_fifo_wait_for_lsr_thre(up, tx_count);
> +	serial8250_fifo_wait_for_lsr_thre(up, wctxt, tx_count);
> +}
> +
> +static void serial8250_console_byte_write(struct uart_8250_port *up,
> +					  struct nbcon_write_context *wctxt)
> +{
> +	struct uart_port *port = &up->port;
> +	const char *s = wctxt->outbuf;
> +	const char *end = s + wctxt->len;
> +
> +	/*
> +	 * Write out the message. If a handover or takeover occurs, writing
> +	 * must be aborted since wctxt->outbuf and wctxt->len are no longer
> +	 * valid.
> +	 */
> +	while (s != end) {
> +		if (!nbcon_enter_unsafe(wctxt))
> +			return;
> +
> +		uart_console_write(port, s++, 1, serial8250_console_wait_putchar);
> +
> +		nbcon_exit_unsafe(wctxt);
> +	}
>  }
>  
>  /*
> - *	Print a string to the serial port trying not to disturb
> - *	any possible real use of the port...
> + * Print a string to the serial port trying not to disturb
> + * any possible real use of the port...
>   *
> - *	The console_lock must be held when we get here.
> - *
> - *	Doing runtime PM is really a bad idea for the kernel console.
> - *	Thus, we assume the function is called when device is powered up.
> + * Doing runtime PM is really a bad idea for the kernel console.
> + * Thus, assume it is called when device is powered up.
>   */
> -void serial8250_console_write(struct uart_8250_port *up, const char *s,
> -			      unsigned int count)
> +void serial8250_console_write(struct uart_8250_port *up,
> +			      struct nbcon_write_context *wctxt,
> +			      bool is_atomic)
>  {
>  	struct uart_8250_em485 *em485 = up->em485;
>  	struct uart_port *port = &up->port;
> -	unsigned long flags;
> -	unsigned int ier, use_fifo;
> -	int locked = 1;
> -
> -	touch_nmi_watchdog();
> +	unsigned int ier;
> +	bool use_fifo;
>  
> -	if (oops_in_progress)
> -		locked = uart_port_trylock_irqsave(port, &flags);
> -	else
> -		uart_port_lock_irqsave(port, &flags);
> +	if (!nbcon_enter_unsafe(wctxt))
> +		return;
>  
>  	/*
> -	 *	First save the IER then disable the interrupts
> +	 * First, save the IER, then disable the interrupts. The special
> +	 * variant to clear the IER is used because console printing may
> +	 * occur without holding the port lock.

I would make the comment more clear when it might happen and if it is
safe. Something like:

	 * First, save the IER, then disable the interrupts. The special
	 * variant to clear the IER is used because an emergency and panic
	 * console printing is synchronized only by nbcon context without
	 * holding the port lock.

>  	 */
>  	ier = serial_port_in(port, UART_IER);
> -	serial8250_clear_IER(up);
> +	__serial8250_clear_IER(up);
>  
>  	/* check scratch reg to see if port powered off during system sleep */
>  	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
> @@ -3332,6 +3393,18 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  		mdelay(port->rs485.delay_rts_before_send);
>  	}
>  
> +	/* If ownership was lost, no writing is allowed */
> +	if (!nbcon_can_proceed(wctxt))
> +		goto skip_write;
> +
> +	/*
> +	 * If console printer did not fully output the previous line, it must
> +	 * have been handed or taken over. Insert a newline in order to
> +	 * maintain clean output.
> +	 */
> +	if (!up->console_line_ended)
> +		uart_console_write(port, "\n", 1, serial8250_console_wait_putchar);
> +
>  	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
>  		/*
>  		 * BCM283x requires to check the fifo
> @@ -3352,10 +3425,23 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  		 */
>  		!uart_console_hwflow_active(&up->port);
>  
> +	nbcon_exit_unsafe(wctxt);
> +
>  	if (likely(use_fifo))
> -		serial8250_console_fifo_write(up, s, count);
> +		serial8250_console_fifo_write(up, wctxt);
>  	else
> -		uart_console_write(port, s, count, serial8250_console_wait_putchar);
> +		serial8250_console_byte_write(up, wctxt);
> +skip_write:
> +	/*
> +	 * If ownership was lost, this context must reacquire ownership and
> +	 * re-enter the unsafe section in order to perform final actions
> +	 * (such as re-enabling interrupts).
> +	 */
> +	if (!nbcon_can_proceed(wctxt)) {

This should be:

	if (!nbcon_enter_unsafe(wctxt))

or even better:

	while (!nbcon_enter_unsafe(wctxt))
		nbcon_reacquire_nobuf(wctxt);

Otherwise, we would not be in the unsafe_context when
nbcon_can_proceed() succeeded.

Note: I have missed this. It was actually found by Sashiko...


> +		do {
> +			nbcon_reacquire_nobuf(wctxt);
> +		} while (!nbcon_enter_unsafe(wctxt));
> +	}
>  
>  	/*
>  	 *	Finally, wait for transmitter to become empty

Otherwise, it looks good to me.

Best Regards,
Petr
