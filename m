Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E73FADF8;
	Mon, 20 Jul 2026 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552834; cv=none; b=eqBe7k7vZQIx3gcy6XF8JW446KNxGRZ03LBNWf9PhUtmNjuWO/nm9c20avAHcBGGoIhLwcuHsyGyr+/WI+jx0eWhWWGNkXyqRmwWYj+F5y1BHosjPMLP4meRAwroUYQ2KXqJZ6VC2oZOSVpHPbdD4MX6HikyluQmfyeW6lHpgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552834; c=relaxed/simple;
	bh=YJjeQGeoqjKE3iSQ94F0GPxif7VgHKcgJC9WJ+aE65Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n4gKtoVWg792ZAb5SBnHGVgNAS5SYTbajs57ZFDkP4y0t0g8vBy+Svki0wGbMu1ikvyLGDK4JCIywfU+Lk4ewj1dkVWP2q4Q9MEdqpyM42ZsAirX/ga2RILKV8Q4YmV9OfwCtinBzxvo31+X8CCSB8RA0I3xu2WEDedsEI2J/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3EBFBdI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UBmqfv/T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3EBFBdI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UBmqfv/T"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784552828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=azf5ctK92wQiYDQaB5BrOW+I1g3lgmyYcXIFhobANK8=;
	b=L3EBFBdIi1Ddhaya4TpojKB8ug+RCX0zYiZ/UPxIr2JinV1os/wDDhk/c3l3o/pTFWGDBW
	ljwBGR72REGgm6v8Ml325yRlsO1t/92tDYmU+g6LsRU7ahOe4DtZAtvDf2siNtMUdt90d2
	xu1v9Efc6LEoAzPCGrtkfc5ODdDbtVdefh2ZLBgvBr67ukT6agzBGHHEaWDBRB+hyMtzIG
	6olPfLRVkEWb2F5JUSf1fERZjp1/v8hGXQIOmoYChdeO77dee+P0eyuE/RrMe8qvDi7ja0
	KpqWuln6HGTAs81Wt5cqiwzaTLruDT8o4fkStXn01v+SCzcwLZyZjLjyfmeBuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784552828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=azf5ctK92wQiYDQaB5BrOW+I1g3lgmyYcXIFhobANK8=;
	b=UBmqfv/T0IEJJmrLQ5vwYr99Utb6AD639GjJ/v3Xcp9ZzqTrQTD6eOTEt6ibagSaxk/VBg
	POkBjttmDc14WeBQ==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Petr Mladek
 <pmladek@suse.com>, linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4r?=
 =?utf-8?Q?vinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Osama Abdelkader <osama.abdelkader@gmail.com>,
 Stepan Ionichev <sozdayvek@gmail.com>, Kees Cook <kees@kernel.org>, Xin
 Zhao <jackzxcui1989@163.com>, Fushuai Wang <wangfushuai@baidu.com>, Yunhui
 Cui <cuiyunhui@bytedance.com>, Jacques Nilo <jnilo@free.fr>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v6 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <20260720103242.7265-2-john.ogness@linutronix.de>
References: <20260720103242.7265-1-john.ogness@linutronix.de>
 <20260720103242.7265-2-john.ogness@linutronix.de>
Date: Mon, 20 Jul 2026 15:13:07 +0206
Message-ID: <87bjc1u7wk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-20, Sashiko wrote:
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index c0e8a4efbdcc8..f504621c5e24a 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -584,6 +609,9 @@ void serial8250_suspend_port(int line)
>>  	struct uart_8250_port *up = &serial8250_ports[line];
>>  	struct uart_port *port = &up->port;
>>  
>> +	/* No irq_work may be queued when suspending. */
>> +	up->avoid_modem_status_work = true;
>> +
>>  	if (!console_suspend_enabled && uart_console(port) &&
>>  	    port->type != PORT_8250) {
>>  		unsigned char canary = 0xa5;
>
> Is a call to irq_work_sync(&up->modem_status_work) needed here to
> flush any already queued work before the port is suspended?
>
> If an atomic console write triggers irq_work_queue() just as the
> system initiates suspend, this flag blocks new work but doesn't
> synchronize existing work.
>
> The asynchronous handler could then execute after the device clock is
> gated or memory unmapped, which might crash on serial_in(up,
> UART_MSR). (A similar teardown might also be needed in
> serial8250_console_exit()).

Sashiko is correct. For v7 I will add irq_work_sync() here and in
serial8250_console_exit().

>> -void serial8250_console_write(struct uart_8250_port *up, const char *s,
>> -			      unsigned int count)
>> +void serial8250_console_write(struct uart_8250_port *up,
>> +			      struct nbcon_write_context *wctxt,
>> +			      bool is_atomic)
>>  {
>>  	struct uart_8250_em485 *em485 = up->em485;
>>  	struct uart_port *port = &up->port;
>> -	unsigned long flags;
>> -	unsigned int ier, use_fifo;
>> -	int locked = 1;
>> -
>> -	touch_nmi_watchdog();
>> +	unsigned int ier;
>> +	bool use_fifo;
>>  
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
>>  	 */
>>  	ier = serial_port_in(port, UART_IER);
>> -	serial8250_clear_IER(up);
>> +	__serial8250_clear_IER(up);
>
> Since UART_IER is now read and saved into a local variable without
> holding port->lock during an atomic write, can concurrent driver
> updates be clobbered?
>
> If a normal driver operation like serial8250_start_tx() runs
> concurrently on another CPU, takes port->lock, and modifies UART_IER
> (e.g., setting UART_IER_THRI), the atomic console writer will later
> restore UART_IER from the stale local ier variable at the end of this
> function.
>
> Does this cause the concurrent driver update to be lost?

No, this is safe because the the port->lock is taken via wrappers
uart_port_lock*(), which also acquire nbcon ownership. For atomic
writes, nbcon ownership is acquired.

>> @@ -3352,10 +3425,23 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>>  		 */
>>  		!uart_console_hwflow_active(&up->port);
>>  
>> +	nbcon_exit_unsafe(wctxt);
>> +
>>  	if (likely(use_fifo))
>> -		serial8250_console_fifo_write(up, s, count);
>> +		serial8250_console_fifo_write(up, wctxt);
>>  	else
>> -		uart_console_write(port, s, count, serial8250_console_wait_putchar);
>> +		serial8250_console_byte_write(up, wctxt);
>> +skip_write:
>> +	/*
>> +	 * If ownership was lost, this context must reacquire ownership and
>> +	 * re-enter the unsafe section in order to perform final actions
>> +	 * (such as re-enabling interrupts).
>> +	 */
>> +	if (!nbcon_can_proceed(wctxt)) {
>> +		do {
>> +			nbcon_reacquire_nobuf(wctxt);
>> +		} while (!nbcon_enter_unsafe(wctxt));
>> +	}
>
> Does this path leave the nbcon unsafe section unbalanced?
>
> If console ownership is not lost, nbcon_can_proceed(wctxt) evaluates
> to true, so the if block is skipped and nbcon_enter_unsafe() is never
> called.
>
> This leaves the subsequent hardware access wait_for_xmitr()
> unprotected, and the final nbcon_exit_unsafe(wctxt) call will
> underflow the unsafe section tracker because it was never re-entered.

Sashiko is correct. Because nbcon ownership can be lost at any time,
such underflows cannot be detected. For v7 I will change this block to:

	/*
	 * Re-enter the unsafe section in order to perform final actions
	 * (such as re-enabling interrupts). If ownership was lost, this
	 * context must reacquire ownership.
	 */
	while (!nbcon_enter_unsafe(wctxt))
		nbcon_reacquire_nobuf(wctxt);

>> 	/*
>> 	 *	Finally, wait for transmitter to become empty
>> 	 *	and restore the IER
>> 	 */
>> 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
>> 	serial_port_out(port, UART_IER, ier);
>
> Since serial8250_console_write() no longer holds port->lock during an
> atomic write, do calls to wait_for_xmitr() and
> serial8250_fifo_wait_for_lsr_thre() introduce data races on
> up->lsr_saved_flags and up->msr_saved_flags?
>
> For example, wait_for_xmitr() calls serial_in(up, UART_MSR) which
> updates flags like so:
>
> wait_for_xmitr()
>     msr = serial_in(up, UART_MSR);
>     up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
>
> This read-modify-write races with the normal
> serial8250_handle_irq_locked() IRQ handler running concurrently under
> port->lock, potentially overwriting and permanently dropping hardware
> events like parity errors or modem control changes.

No, this is safe because the the port->lock is taken via wrappers
uart_port_lock*(), which also acquire nbcon ownership. wait_for_xmitr()
and serial8250_fifo_wait_for_lsr_thre() are called with nbcon ownership.

John
