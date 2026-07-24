Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77441687C;
	Fri, 24 Jul 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900034; cv=none; b=TeTW5l/adZXsYYuEtcaR2jutLRP+6ABLKyawLc/wqkPQnBtSCr8n/HUuJ1Qnk1mZRNy+IfSEKX8yaEg0f2inzzRduKs7HAmfkLw87vJ9UPkKhI533ja2NdrUBO7KqLRgJWWZuezYg7oTk3p2uKgH8d+CowplH9V7THx9icCJ36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900034; c=relaxed/simple;
	bh=MKGpOzd3Ib7HDz5W0s6eUgMGGCnPFOyRD+qxx0r6YIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nO0hoOWpjK1fXgjzFeL0ze237FfIjbwP31d4To6KKHNOHH+xOSrVP27Luj8c4rpKHdwRKjSYhi37bWWAjM7np6dvL3NilUVYLTKefW5zGvQdjz5B9xi/OaYq9Lm/0daDLBRK6UlXKGrE5N3KaI8rzwMgwuM2xiwHIKUgL6gte0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b2Ado2m1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XvlrJYy4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b2Ado2m1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XvlrJYy4"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784900030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wgtdNT2vJ8LpFW5nt+jw4G9PJuDdpoRiCRaUAZWu0qM=;
	b=b2Ado2m1LzqOFzP0lQQPPVCL0Tsb5Om2tdchy1xNVUSwXJOgTVpUS1oHHGOdtKcFs48Wyc
	djsG+CZY7TuCOopZ1/CIcbORirqJDYEnAIceEjWZIklFgPFk+r3XPPybSs4izlOhVHfjn2
	1e3gt9Yn20uVnwJdqFGiZmWhm6yA8z41WC+fRBFbHcFDwCSk7c9xbNn26ltFvUJ4NBoPJn
	5ES/JNrBSv6ke0sLiqm0byfhj0az8S3FhSvH1idu7xcQBbANRgJSwAALCXABTHpKXmJdYf
	UwfaYxZZJoNQnL36J/MB9jfYPk9oRurv1VkGD9AW8WGyoU3GCIqabZ/dMwfcfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784900030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wgtdNT2vJ8LpFW5nt+jw4G9PJuDdpoRiCRaUAZWu0qM=;
	b=XvlrJYy4Tn93cOd1JBBLJCon0HDQGs6K60j4QuNoYO0QMZCssNQ4sG6Gu2PJH9duz0LhWi
	YEsTlm7i+ptR/hDA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Petr Mladek
 <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Fushuai Wang <wangfushuai@baidu.com>, Kees
 Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v9 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <20260724103654.133654-2-john.ogness@linutronix.de>
References: <20260724103654.133654-1-john.ogness@linutronix.de>
 <20260724103654.133654-2-john.ogness@linutronix.de>
Date: Fri, 24 Jul 2026 15:39:49 +0206
Message-ID: <87o6fwms02.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-24, Sashiko wrote:
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index c0e8a4efbdcc8..5042a8e8c6fb1 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -584,13 +609,19 @@ void serial8250_suspend_port(int line)
>>  	struct uart_8250_port *up = &serial8250_ports[line];
>>  	struct uart_port *port = &up->port;
>>  
>> -	if (!console_suspend_enabled && uart_console(port) &&
>> -	    port->type != PORT_8250) {
>> -		unsigned char canary = 0xa5;
>> +	if (uart_console(port)) {
>> +		/* No irq_work may be queued when suspending */
>> +		scoped_guard(uart_port_lock_irq, port)
>> +			up->console_msr_work_allow = false;
>> +		irq_work_sync(&up->console_msr_work);
>
> Does clearing up->console_msr_work_allow under uart_port_lock_irq
> properly serialize against serial8250_console_write()?

Yes.

> Since serial8250_console_write() performs atomic writes without taking
> the port lock, could a delayed execution check
> up->console_msr_work_allow locklessly, get preempted or delayed, and
> then serial8250_suspend_port() clear the flag and call irq_work_sync()
> before the delayed thread resumes?

No. uart_port_lock_irq() also acquires nbcon ownership. That is what
synchronizes against serial8250_console_write() when atomic printing.

>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 8c241ec7f4f29..855a7aa48c2d2 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -3198,13 +3218,28 @@ void serial8250_set_defaults(struct uart_8250_port *up)
>>  }
>>  EXPORT_SYMBOL_GPL(serial8250_set_defaults);
>>  
>> -void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count)
>> +void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up,
>> +				       struct nbcon_write_context *wctxt,
>> +				       unsigned int count)
>>  {
>>  	unsigned int i;
>>  
>> +	/*
>> +	 * For console writing, enter/exit an unsafe section for each byte
>> +	 * in order to pass the ownership as quickly as possible if a higher
>> +	 * priority context wants ownership. Otherwise, an attempt to take
>> +	 * over the ownership might timeout. The new owner will wait for
>> +	 * UART_LSR_THRE before reusing the fifo.
>> +	 */
>>  	for (i = 0; i < count; i++) {
>> +		if (wctxt && !nbcon_enter_unsafe(wctxt))
>> +			return;
>> +
>>  		if (wait_for_lsr(up, UART_LSR_THRE))
>>  			return;
>
> Does this early return on success bypass the cleanup of the unsafe
> section?
>
> If wait_for_lsr() returns true, wouldn't
> serial8250_fifo_wait_for_lsr_thre() return immediately without calling
> nbcon_exit_unsafe(wctxt)?
>
> Could this resource leak of the nbcon unsafe state prevent other
> contexts from taking over ownership?

It simply has the effect of joining this unsafe section with the next
one. In this case it really wouldn't matter. But still, it was not my
intention. I will fix this for v10.

How I plan for it to look for v10:

	for (i = 0; i < count; i++) {
		bool tx_ready;

		if (wctxt && !nbcon_enter_unsafe(wctxt))
			return;

		tx_ready = wait_for_lsr(up, UART_LSR_THRE);

		if (wctxt)
			nbcon_exit_unsafe(wctxt);

		if (tx_ready)
			break;
	}

I am wondering if we should add a WARN_ON_ONCE() to nbcon_enter_unsafe()
if the context is already unsafe. It is a simple one-liner. That would
at least catch these kinds of mistakes during runtime. (I would do that
in a separate printk patch, not in this series.)

>> @@ -3378,11 +3469,25 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>>  	 *	call it if we have saved something in the saved flags
>>  	 *	while processing with interrupts off.
>>  	 */
>> -	if (up->msr_saved_flags)
>> -		serial8250_modem_status(up);
>> +	if (up->msr_saved_flags) {
>> +		if (is_atomic) {
>> +			/*
>> +			 * For atomic, MSR handling must be deferred to
>> +			 * irq_work because this may be a context that does
>> +			 * not permit waking up tasks.
>> +			 *
>> +			 * But no irq_work may be queued when suspending.
>> +			 * In that case, the MSR handling will occur during
>> +			 * resume in serial8250_resume_port().
>> +			 */
>> +			if (up->console_msr_work_allow)
>> +				irq_work_queue(&up->console_msr_work);
>
> This is where the lockless read of up->console_msr_work_allow occurs.
>
> If execution is delayed immediately after checking this flag, could
> the port be suspended and irq_work_sync() finish before
> irq_work_queue() is called here?

No. Both the reader and writer must first aquire exclusive nbcon
ownership. Also, WRT @console_msr_work_allow, both reader and writer are
even in unsafe sections and so cannot lose ownership except for on a
hostile takeover during the final unsafe flush of a panic.

John
