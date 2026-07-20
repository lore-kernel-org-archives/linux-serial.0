Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090873FFFA4;
	Mon, 20 Jul 2026 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563664; cv=none; b=HEzoXqbMv1hC5ZG9KKqS4osSSd6jDUj3McBXiPkiSXHYRDyBrE9GQwLTTEoA4cHyr7RVwO56toYlHbozAA4ZmSmrKNS7cM6929ZCbKf9NY7MjXLSxP5QVQfjDOxoO5UKGHhFy2qLWu3QTZqt9lUmSmcAjz/qkicfx6dz5LvSzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563664; c=relaxed/simple;
	bh=YJr1kAwzzlA4rDxg7M9FZoCWCeuORZTy+mcCiSD2noA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MlMqxUZqBj+JER+Yf1tcUrvfiVlgnK33SAtQDEIq5V3vtlCIsxc7vfdYlusWLrCzXFC++b9nDiLzglKi3AXmHhi8TlW0T5suiyQqmbrmhHnt2zkJ5qgWBI5YTt1JnBvHEdTQ8/aGZ12ts9HaOaXBln5SLQstYZcD4RgRy1zaq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DzKyCTrY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MfdG4T91; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DzKyCTrY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MfdG4T91"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784563660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bBPRtopZ4VY3hY/gLpEr6H2aVYx6/LSsNbuhMMYWAc=;
	b=DzKyCTrYbjXnEd+CvkuvLUObVfZJJSSEaDqhUELxRFUdRGZUxjH34UuA5u+x1/0MXSa+yO
	N6LZfh1tcpxbye1BZPHO1swarZ/c/WivU9YRqq24SkTN1yzyu0aaTd+DvbbXgsorLhPA8g
	0YxNaqHres33MbrAAPMZVIOpwEaDcCO/adjKcKyQHuBzaXr6Tn2SSxALkFWbZRexR6eNZf
	b90tZ/G198EVmMWnSkqaqfxHZSGcb7U7974FwHSz5U3CK7WBe0fxxZhRPLzHwQZcbEE+Cl
	ARWvbfaQb7kfcQ72xHLzhobeywdLIGUH4UcXhYg9BgO2lzkFNij+gfa4zayLxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784563660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bBPRtopZ4VY3hY/gLpEr6H2aVYx6/LSsNbuhMMYWAc=;
	b=MfdG4T91dIDjDCZtDzZanL16BBu6qU0R18MeynYSCaC4XL6L9z9dBgDNtAsORxAAiv9UaZ
	bMnoJFdWfl1EcFCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Osama Abdelkader <osama.abdelkader@gmail.com>,
 Stepan Ionichev <sozdayvek@gmail.com>, Kees Cook <kees@kernel.org>, Xin
 Zhao <jackzxcui1989@163.com>, Fushuai Wang <wangfushuai@baidu.com>, Yunhui
 Cui <cuiyunhui@bytedance.com>, Jacques Nilo <jnilo@free.fr>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v6 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <al43iOyokb56SBF3@pathway.suse.cz>
References: <20260720103242.7265-1-john.ogness@linutronix.de>
 <20260720103242.7265-2-john.ogness@linutronix.de>
 <al43iOyokb56SBF3@pathway.suse.cz>
Date: Mon, 20 Jul 2026 18:13:39 +0206
Message-ID: <87v7a9lk50.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-20, Petr Mladek <pmladek@suse.com> wrote:
> On Mon 2026-07-20 12:38:35, John Ogness wrote:
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -584,6 +609,9 @@ void serial8250_suspend_port(int line)
>>  	struct uart_8250_port *up = &serial8250_ports[line];
>>  	struct uart_port *port = &up->port;
>>  
>> +	/* No irq_work may be queued when suspending. */
>> +	up->avoid_modem_status_work = true;
>
> Do we need to synchronize this against serial8250_console_write()
> where this flag is checked, please?

Yes. @avoid_modem_status_work needs to be modified under the port->lock
to ensure that serial8250_console_write() does not queue any new
irq_work. It is evaluated in atomic context, but taking the port->lock
also acquires nbcon ownership.

I will add this for v8 (in both places where @avoid_modem_status_work is
modified).

> This might even answer the question from Sashiko AI whether
> we should flush the related irq_work() here, see
> https://sashiko.dev/#/patchset/20260720103242.7265-1-john.ogness%40linutronix.de
>
> That said, I am not sure about RT_PREEMPT. AFAIK, it handles IRQs
> in a kthread. In this case, synchronize_srcu() would not make
> sure that the irq_work was procceed.
>
> Note that Sashiko AI suggests that we might need to flush the irq_work
> even in serial8250_console_exit(). I guess that the situation is
> the same there. It is called after synchronize_srcu()...

Yes, I will add irq_work_sync() in both locations.

>> @@ -620,6 +648,12 @@ void serial8250_resume_port(int line)
>>  		port->uartclk = 921600*16;
>>  	}
>>  	uart_resume_port(&serial8250_reg, port);
>> +
>> +	/* irq_work allowed again. Handle MSR now if pending. */
>> +	up->avoid_modem_status_work = false;
>> +	guard(uart_port_lock_irqsave)(port);
>> +	if (uart_console(port) && up->msr_saved_flags)
>> +		serial8250_modem_status(up);
>
> I would use scoped_guard() to make the scope clear. Something like:
>
> 	scoped_guard(uart_port_lock_irqsave, port) {
> 		if (uart_console(port) && up->msr_saved_flags)
> 			serial8250_modem_status(up);
> 	}
>
> Motivation: The guard() is pretty hidden. It can easily get overlooked
> 	when people add more code at the end of this function.

OK.

> Wait, this should not be needed if we make sure that the work
> was flushed in serial8250_suspend_port().

When !console_suspend_enabled, the driver will continue to print in
atomic mode, but will avoid the irq_work. It will however notice if
there are any MSR changes. Those changes are then handled here.

I suppose I should add an "if (!console_suspend_enabled)" to the
conditions.

>> -	if (oops_in_progress)
>> -		locked = uart_port_trylock_irqsave(port, &flags);
>> -	else
>> -		uart_port_lock_irqsave(port, &flags);
>> +	if (!nbcon_enter_unsafe(wctxt))
>> +		return;
>>  
>>  	/*
>> -	 *	First save the IER then disable the interrupts
>> +	 * First, save the IER, then disable the interrupts. The special
>> +	 * variant to clear the IER is used because console printing may
>> +	 * occur without holding the port lock.
>
> I would make the comment more clear when it might happen and if it is
> safe. Something like:
>
> 	 * First, save the IER, then disable the interrupts. The special
> 	 * variant to clear the IER is used because an emergency and panic
> 	 * console printing is synchronized only by nbcon context without
> 	 * holding the port lock.

OK.

>> +skip_write:
>> +	/*
>> +	 * If ownership was lost, this context must reacquire ownership and
>> +	 * re-enter the unsafe section in order to perform final actions
>> +	 * (such as re-enabling interrupts).
>> +	 */
>> +	if (!nbcon_can_proceed(wctxt)) {
>
> This should be:
>
> 	if (!nbcon_enter_unsafe(wctxt))
>
> or even better:
>
> 	while (!nbcon_enter_unsafe(wctxt))
> 		nbcon_reacquire_nobuf(wctxt);

Right. I will take the while loop variant.

Thanks for your review! (You can ignore my v7 as you caught everything
that I missed in my v7.)

John
