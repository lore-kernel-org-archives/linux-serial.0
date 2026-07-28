Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8343F0A0;
	Tue, 28 Jul 2026 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245659; cv=none; b=ppuhFAModV4zKk4PfaV9TgzCQ1EYVBuallYiP09uwKbuVDEFloUyr/XQQp7RGjHok5rLgZLiBd8V1Ql0n3PSUbdwLOrntA0+622v7xoZar3mogbJhYLR2jMUJIm2XEsnQm2xxQNDeTTmF4QnEuHOLA3min3+NTeXW7z5qN7bwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245659; c=relaxed/simple;
	bh=XJdeUgEE3lIj86OtSX8h+5GxFGMhgGSbfUk1qlw3REE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FpCDT6iuFw1kSC5MzWY59LpwNW1ceSZkAuQ1BCifgmLU4Pd92UZaNxvEMOr2mFTExGMO7uQgTQ9Z2vcNfANFnm8QBOMpjXtr3M89ieF+XyGM2skjF9mLbwh0AZ/8M4YzXGVyueF6EC3dVN3ijjkYX+4LXwUxq7e4knRcSzuof7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0zxl+qcZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bO7Z60xT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0zxl+qcZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bO7Z60xT"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785245647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HNT9jalz1w6cL1ychE/yuwQ08r/BZLdFNp2PnzQnBM=;
	b=0zxl+qcZP8tC91RTjUNr8ZFQGLQ4LzeOVpyMtONx5DDhSvetcddmKi3MUkd8s7O2/d3PbB
	CB0juddDKBuTwQ2L0H7oonCr/xsl91GhNoCdJPCVWfUO5h3IMt6JlU1c/FuM67Gemq86Ji
	DYqneWIqSOWIWrPiP8ms4tqfB9iPmNOvV/rOLmREeBZ4jrapCzwU158EQtzeyh/5wvRVCs
	EPSwc4jymYev30lV7NEMz7sCltdxR+kKTnv+GPIgNJ6uUNswms6Bp2hpD+ogSBcxgRjL24
	4tty+xR+x7lBpL/tX4pCFAeEihC+1NXodyYOVmvJB10728+w6waWJiTwuGTwuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785245647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HNT9jalz1w6cL1ychE/yuwQ08r/BZLdFNp2PnzQnBM=;
	b=bO7Z60xTzAdj7Ne9O19+YcpAdix99d5WuMrMPU3+GS0pGCoWOWwyoimE9IZSGDuN4CbREI
	0z5qBaIMfHtfxKAQ==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Petr Mladek
 <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Stepan Ionichev <sozdayvek@gmail.com>, Kees
 Cook <kees@kernel.org>, Fushuai Wang <wangfushuai@baidu.com>, Jacques Nilo
 <jnilo@free.fr>, Peng Zhang <zhangpeng.00@bytedance.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v10 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <20260727145332.231949-2-john.ogness@linutronix.de>
References: <20260727145332.231949-1-john.ogness@linutronix.de>
 <20260727145332.231949-2-john.ogness@linutronix.de>
Date: Tue, 28 Jul 2026 15:40:06 +0206
Message-ID: <87ecgntf01.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-27, Sashiko wrote:
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 8c241ec7f4f29..5bcbb6deb12f7 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> [ ... ]
> > @@ -3332,6 +3405,18 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
> >  		mdelay(port->rs485.delay_rts_before_send);
> >  	}
> >  
> > +	/* If ownership was lost, no writing is allowed */
> > +	if (!nbcon_can_proceed(wctxt))
> > +		goto skip_write;
> > +
> > +	/*
> > +	 * If console printer did not fully output the previous line, it must
> > +	 * have been handed or taken over. Insert a newline in order to
> > +	 * maintain clean output.
> > +	 */
> > +	if (!up->console_line_ended)
> > +		uart_console_write(port, "\n", 1, serial8250_console_wait_putchar);
> > +
>
> Will this cause the newline characters to be silently dropped if the
> hardware FIFO is already full from a preempted context?
>
> When uart_console_write() calls serial8250_console_wait_putchar(), it
> relies on wait_for_lsr() to wait for transmitter room. The timeout in
> wait_for_lsr() is calculated based on frame_time, which is only enough
> for a single character. If the preempted context left a full FIFO (e.g.,
> 16-64 bytes), the wait_for_lsr() timeout will expire before the FIFO
> drains, causing the hardware to drop the injected newline characters.

Sashiko is correct. For v11 I am writing helper functions to handle
@console_line_ended and the console line printing for fifo and
non-fifo. This causes a bit more churn than I would like to see at this
point (v11) but it will handle all situations, has increased code
re-use, and should be easier to read/maintain.

> [ ... ]
> >	while (!nbcon_enter_unsafe(wctxt))
> >		nbcon_reacquire_nobuf(wctxt);
> >
> >  	/*
> >  	 *	Finally, wait for transmitter to become empty
> >  	 *	and restore the IER
> >  	 */
> >  	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
> >  
> > +	if (em485) {
> > +		mdelay(port->rs485.delay_rts_after_send);
> > +		if (em485->tx_stopped)
> > +			up->rs485_stop_tx(up, false);
> > +	}
> > +
> >  	serial_port_out(port, UART_IER, ier);
>
> Could the hardware state be corrupted here if a hostile takeover occurs
> while waiting for the transmitter to empty?
>
> The wait_for_xmitr() call can take a significant amount of time to let the
> FIFO drain. If a system panic triggers a hostile console takeover during
> this window, the panic context might reconfigure the hardware. Once the
> original context finishes waiting, it will unconditionally execute
> serial_port_out(), potentially undoing the panic context's configuration
> or causing interrupt storms.
>
> Should we check nbcon_can_proceed(wctxt) again before modifying the
> hardware state?

nbcon_can_proceed() is not enough because these final actions are
necessary. It would need to be:

	nbcon_exit_unsafe(wctxt);
	while (!nbcon_enter_unsafe(wctxt))
		nbcon_reacquire_nobuf(wctxt);

Although this does not close the window, it does make it quite
small. And if we are really in the unlikely situation of:

- a panic occurs
- the panic is unable to stop all the CPUs
- a console printer is actively printing from a non-stopped CPU
- the panic CPU performs a hostile takeover

then we should probably do everything we can (within reason) to avoid
interfering with the panic printing.

As Sashiko points out, the wait_for_xmitr() and mdelay() calls could be
relatively large. I agree that it makes sense to peform unsafe toggles
in these two locations. I will add that for v11. It will look something
like this:

@@ -3481,10 +3487,21 @@ void serial8250_console_write(struct uart_8250_port *up,
 
 	if (em485) {
 		mdelay(port->rs485.delay_rts_after_send);
+
+		/* Toggle unsafe after possibly long delay */
+		nbcon_exit_unsafe(wctxt);
+		while (!nbcon_enter_unsafe(wctxt))
+			nbcon_reacquire_nobuf(wctxt);
+
 		if (em485->tx_stopped)
 			up->rs485_stop_tx(up, false);
 	}
 
+	/* Toggle unsafe after possibly long delay */
+	nbcon_exit_unsafe(wctxt);
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire_nobuf(wctxt);
+
 	serial_port_out(port, UART_IER, ier);
 
 	/*

> > @@ -3400,8 +3509,24 @@ static unsigned int probe_baud(struct uart_port *port)
> >  	return (port->uartclk / 16) / quot;
> >  }
> >  
> > +/*
> > + * irq_work handler to perform modem control during console output.
> > + * Only triggered via ->write_atomic() callback because it may be
> > + * in a scheduler or NMI context, unable to wake tasks.
> > + */
> > +static void console_msr_handler(struct irq_work *iwp)
> > +{
> > +	struct uart_8250_port *up = container_of(iwp, struct uart_8250_port, console_msr_work);
> > +	struct uart_port *port = &up->port;
> > +
> > +	guard(uart_port_lock)(port);
> > +
> > +	serial8250_modem_status(up);
> > +}
>
> Does this code introduce a race condition that could cause invalid hardware
> accesses on a suspended device?
>
> If CPU1 is executing serial8250_console_write(), it reads
> up->console_msr_work_allow locklessly before queueing the work...

Sashiko is not correct. Both code blocks (reader and writer) are within
unsafe sections and therefore synchronized.

John
