Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39003812DD;
	Wed, 29 Jul 2026 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329067; cv=none; b=YDm44r4rB+9VyvwJwMFajH20by5b5sdGA/GeKtO6FCNiSLZ2+YLS+wLBkssvmyCj5c7DyafA8eQEUmDIdd3l1ZL4rxyYEEyLyO2CpjmxI1W63esxl/EZL7hgn8cE/aSc6Tr0o1ifRbcsUfLxBOuMf7ocKGobmne58Be3uw9jSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329067; c=relaxed/simple;
	bh=nYUeec3OHZsjhEJ0YxH2l841AVCq5AJDaP6zGlw8+x4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DkNKgZs8KlMR6Z5u8QbNWlhazkDIYp7yP/K4Uc2MIuKmf7nND/XleawPZvcaBlivzN8ppqWdVJcKy3UVvrMZe4CG3UTEAN5+VGg8mKAcEim6fKjGyeM22JYiiQlVPuck/HuF27k9YUOoZftoY/UvHRVaAomzP1ZR/CtWlWcCrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d+iaIly0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1L958/BE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d+iaIly0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1L958/BE"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785329058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RjJMHw7hTK5/4rB5GysIqlPw08S3P5IHO8SEocRWpcY=;
	b=d+iaIly09LKf/0L25TtRstbRftyPsOX+pqSUTDda0uj7qG8hvQ3DYn1q3e9/w6tjIXIWQW
	JLxCwy4J4DCh0MN8leByuhELnkqqiYWGLU5thFGL3nlvnTASg5LZ+f+wYZ8rcQs+ESD2JG
	m9wMVkobWJg1NWWtG1VZJ4oA5SCr+SRAJpyQYO5ZhPGhW23vTrY/2YRY0YE4HHjlG6Ef6a
	ieej4gWmfnHBgHUX51qa1GjOL9lNJJ++oVMQuLLC1v6lmNNJfODZX8RRxDc2vmUNMBwFWh
	0LNl/jwvIg/kIRsqWUm4pDZVlidXyqOj3zKUi52DrJIY+90q8ojBzgJPv4uJ1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785329058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RjJMHw7hTK5/4rB5GysIqlPw08S3P5IHO8SEocRWpcY=;
	b=1L958/BE6Cgyvh7w0YGacW0BheG4LjqqJ7uVUilpKOy5ANeZa+hgUWqxS0D62tmeYjMwwm
	Oy1z9EZICWv4D+BQ==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Petr Mladek
 <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>, Stepan Ionichev
 <sozdayvek@gmail.com>, Xin Zhao <jackzxcui1989@163.com>, Osama Abdelkader
 <osama.abdelkader@gmail.com>, Fushuai Wang <wangfushuai@baidu.com>, Marco
 Felsch <m.felsch@pengutronix.de>, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <20260729120439.281252-2-john.ogness@linutronix.de>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
Date: Wed, 29 Jul 2026 14:50:17 +0206
Message-ID: <87y0eurmn2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Sashiko did not find anything legitimate with this version. The two
issues are incorrect (I explain why below).

If anyone has been waiting for Sashiko to "finish", this is the version
that is ready for human review.

John

On 2026-07-29, Sashiko wrote:
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 8c241ec7f4f29..b9ea4f898474e 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -3286,39 +3339,92 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
> [ ... ]
> >  /*
> > - *	Print a string to the serial port trying not to disturb
> > - *	any possible real use of the port...
> > - *
> > - *	The console_lock must be held when we get here.
> > - *
> > - *	Doing runtime PM is really a bad idea for the kernel console.
> > - *	Thus, we assume the function is called when device is powered up.
> > + * Print a string to the serial port trying not to disturb
> > + * any possible real use of the port...
> >   */
> > -void serial8250_console_write(struct uart_8250_port *up, const char *s,
> > -			      unsigned int count)
> > +void serial8250_console_write(struct uart_8250_port *up,
> > +			      struct nbcon_write_context *wctxt,
> > +			      bool is_atomic)
> >  {
> >  	struct uart_8250_em485 *em485 = up->em485;
> >  	struct uart_port *port = &up->port;
> > -	unsigned long flags;
> > -	unsigned int ier, use_fifo;
> > -	int locked = 1;
> > -
> > -	touch_nmi_watchdog();
> > +	unsigned int ier;
> > +	bool use_fifo;
> >  
> > -	if (oops_in_progress)
> > -		locked = uart_port_trylock_irqsave(port, &flags);
> > -	else
> > -		uart_port_lock_irqsave(port, &flags);
> > +	if (!nbcon_enter_unsafe(wctxt))
> > +		return;
> >  
> >  	/*
> > -	 *	First save the IER then disable the interrupts
> > +	 * First, save the IER, then disable the interrupts. The special
> > +	 * variant to clear the IER is used because emergency and panic
> > +	 * printing is synchronized only by nbcon ownership without
> > +	 * holding the port lock.
> >  	 */
> >  	ier = serial_port_in(port, UART_IER);
> > -	serial8250_clear_IER(up);
> > +	__serial8250_clear_IER(up);
>
> Will this race with normal driver paths since the port lock is no longer
> acquired for atomic printing?

No. This is synchronized by nbcon ownership, which normal driver paths
also acquire via the port->lock locking wrappers. It is even within an
unsafe section.

> > @@ -3378,11 +3502,25 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
> >  	 *	call it if we have saved something in the saved flags
> >  	 *	while processing with interrupts off.
> >  	 */
> > -	if (up->msr_saved_flags)
> > -		serial8250_modem_status(up);
> > +	if (up->msr_saved_flags) {
> > +		if (is_atomic) {
> > +			/*
> > +			 * For atomic, MSR handling must be deferred to
> > +			 * irq_work because this may be a context that does
> > +			 * not permit waking up tasks.
> > +			 *
> > +			 * But no irq_work may be queued when suspending.
> > +			 * In that case, the MSR handling will occur during
> > +			 * resume in serial8250_resume_port().
> > +			 */
> > +			if (up->console_msr_work_allow)
> > +				irq_work_queue(&up->console_msr_work);
>
> Is there a race condition here between checking the flag and queuing the
> work?

Ditto.

John
