Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC6533ADB9;
	Fri, 31 Jul 2026 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484129; cv=none; b=a14Y7kIHU+iAF9YA1cPhPYg/TDvVGaSWayUzHLNFPA/TWQcBzZFTlyVzacejCA6/O6VitE3n6DKgkzvexTe4UXPNyBDK051mcksfwFiDWu5ssLMFUu5xgGBgGgFa0IDYjXYQiPd+0BD7Z2xrIc3DJZ+wlj7KJjjLQBPyBS6i/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484129; c=relaxed/simple;
	bh=BMRFMjGkBCGqDtsgpb6AZyD92UJ9KxS07G91Sj//BVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jop1ZyeP9XiogcHmB0zCJybQhXGFUH3tYvWbvXPIlL6UfDLQkkIVJhW8Z9rM3w0Wvyt/hdPQlgj+V8N2jHRHO70Eh8FcouJC0FO24sA0fhcb8GTjqbm2bLO++02JPHl0CHdIsXrMJWmgqbGeDLRnX61MLNpm9l5qTfGQeouPtNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2t43xRBO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KjAotU0u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2t43xRBO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KjAotU0u"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785484125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bR97jOwqWlF374Kg04PRXSh6aXtYvOFhE65+sHwt4Tw=;
	b=2t43xRBOR0TAb7LrDptSqPc2cU+GBBvY9C4KxM9t+4wamDU6rUAYZuMFa6CDcKeUnVlutd
	p/I1wzRf+GO309YR8A4aVwbSrmeoiOFqG2uPMpe2Y2DhwXRR/qcEuYbAbMHdmWESdEOIm8
	xS5Nmh2QAy6oiOog6jihtmWieEKqTgwyItPIt4JkcR1bfUXi6mNRrYtUNiiaGXOcaHHN3x
	FIKyv3oNSJrfrL9dY2Tg0qPgzBBErybP0oIVNlnALPoP7uF/Uxq9gHAGUfHFK7shp/++Mu
	jrhR9o3dJ9pVxWlOc8zcZAvHj2lCCPIiDN+CcS8IbEzbzQouisj+yAYQiCm95g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785484125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bR97jOwqWlF374Kg04PRXSh6aXtYvOFhE65+sHwt4Tw=;
	b=KjAotU0uDoPRzo4PJsJDZCFf9LXtuSS2xtxPVeEtdjwe4RvxxoOHXuXLl76RPnhfag1tcr
	w0Xo1cGvLbB1xlDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>, Stepan Ionichev
 <sozdayvek@gmail.com>, Xin Zhao <jackzxcui1989@163.com>, Osama Abdelkader
 <osama.abdelkader@gmail.com>, Fushuai Wang <wangfushuai@baidu.com>, Marco
 Felsch <m.felsch@pengutronix.de>, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <amtepien519U578B@pathway.suse.cz>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <amtepien519U578B@pathway.suse.cz>
Date: Fri, 31 Jul 2026 09:54:44 +0206
Message-ID: <87ldarwqeb.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-30, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 8c241ec7f4f29..b9ea4f898474e 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -3352,10 +3458,17 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>>  		 */
>>  		!uart_console_hwflow_active(&up->port);
>>  
>> -	if (likely(use_fifo))
>> -		serial8250_console_fifo_write(up, s, count);
>> -	else
>> -		uart_console_write(port, s, count, serial8250_console_wait_putchar);
>> +	nbcon_exit_unsafe(wctxt);
>> +
>> +	__serial8250_console_write(up, wctxt, use_fifo);
>> +
>> +	/*
>> +	 * Re-enter an unsafe section in order to perform final actions
>> +	 * (such as re-enabling interrupts). If ownership was lost, this
>> +	 * context must reacquire ownership.
>> +	 */
>> +	while (!nbcon_enter_unsafe(wctxt))
>> +		nbcon_reacquire_nobuf(wctxt);
>
> If we are going to use this on more locations than I would add
> a new API, e.g.

Agreed.

The 8250 has already played a significant role in influencing other
NBCON implementations. I expect there will be a lot of copy/paste in the
beginning. Once we start seeing which code is copied and how it is used
in other drivers, we should be be able to do some general nbcon and
serial_core consolidation.

> /**
>  * nbcon_enter_unsafe_reacquire - Enter an unsafe region in the driver,
>  *	reacquire when needed.
>  * @wctxt:	The write context that was handed to the write function
>  *
>  *
>  * The function is allowed to reacquire the console ownership to make
>  * sure that the caller can enter an unsafe region in the driver.
>  *
>  * Warning: The caller must not longer access the text buffer. It is
>  *	lost when the reacquire was needed. The function is intended
>  *	for cleanup operations after emitting the message, for example,
>  *	re-enabling interrupts on a used serial port.
>  */
> void nbcon_enter_unsafe_reacquire(struct nbcon_write_context *wctxt)
> {
> 	while (!nbcon_enter_unsafe(wctxt))
> 		nbcon_reacquire_nobuf(wctxt);
> }

I would name the function:

	nbcon_enter_unsafe_reacquire_nobuf()

to make it clear that the buffer will be lost on a reacquire.

>> @@ -3365,10 +3478,21 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>>  
>>  	if (em485) {
>>  		mdelay(port->rs485.delay_rts_after_send);
>> +
>> +		/* Toggle unsafe after possibly long delay */
>> +		nbcon_exit_unsafe(wctxt);
>> +		while (!nbcon_enter_unsafe(wctxt))
>> +			nbcon_reacquire_nobuf(wctxt);
>
> The comment describes what the code does but it does not explain why.

Well, the _why_ is the same for all the toggling that we do throughout
the console code.

> My first idea was that it would allow to takeover the ownership
> as soon as possible in an emergency context.

Yes. That is one of the purposes. Even takeovers in panic will patiently
wait up to 2ms before becoming hostile.

> But the motivation seems to be to reduce the race with a possible
> unsafe takeover in the final panic flush, see
> https://lore.kernel.org/all/87ecgntf01.fsf@jogness.linutronix.de/

Yes, this is also valid, but for all other toggle situations as
well. The driver should avoid touching the hardware if it is no longer
the owner.

> It opens some questions:
>
> First, is it really necessary to finish the clean up when
> this CPU is supposed to be stopped and the panic CPU
> is about to enter the infinite loop?

Why even ask that question? The driver should try to do things
correctly. We want to avoid driver code like:

	if (panic_on_other_cpu())
		return;

The driver should not care about panic and instead focus on following
nbcon ownership rules.

> Second, it is actually safe in the emergency context?
> For example, the mdelay() is there for a reason. Maybe,
> we should repeat it when the ownership has been lost here?

If ownership has been lost, the new owner will have performed the
mdelay() and rs485_stop_tx() if needed. One could argue that if
ownership was lost, it should _not_ call ->rs485_stop_tx() at all. But
the new owner will also make an unnecessary call to
->rs485_start_tx().

If making these calls unnecessarily is a problem, the driver will need
to detect the situation and add this condition.

I have added "RS485-handovers" to my list of things to do some stress
testing.

> Third, is it necessary to call the mdelay() in the unsafe context?

No. It is not necessary. Worst case it will cause the printing thread to
handle a WARN that could have been printed atomically. But still, we
should avoid that.

> I think about entering unsafe only when really needed.
> Instead of releasing it and taking again immediately.
>
> Something like:
>
> 	/*
> 	 * Re-enter an unsafe section in order to perform final actions
> 	 * (such as re-enabling interrupts). If ownership was lost, this
> 	 * context must reacquire ownership.
> 	 */
> 	nbcon_enter_unsafe_reacquire(wctxt);
>
> 	/*
> 	 *	Finally, wait for transmitter to become empty
> 	 *	and restore the IER
> 	 */
> 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
>
> 	/*
> 	 * Exit unsafe section after a potentially long wait. It allows
> 	 * a safe takeover before another potentially long way. Also
> 	 * it reduces the race window when a possible unsafe takeover
> 	 * happened unnoticed.
> 	 */
> 	nbcon_exit_unsafe()
>
> 	if (em485) {
> 		u32 delay;
>
> 		nbcon_enter_unsafe_reacquire(wctxt);
> 		delay = port->rs485.delay_rts_after_send;
> 		nbcon_exit_unsafe(wctxt);

This unsafe enter/exit is unnecessary. This value does not change.

> 		mdelay(port->rs485.delay_rts_after_send);
>
> 		nbcon_enter_unsafe_reacquire(wctxt);
> 		if (em485->tx_stopped)
> 			up->rs485_stop_tx(up, false);
> 		nbcon_exit_unsafe(wctxt);
> 	}
>
> 	nbcon_enter_unsafe_reacquire(wctxt);
>
> 	serial_port_out(port, UART_IER, ier);
>
> 	/*
> 	 *	The receive handling will happen properly because the
> 	 *	receive ready bit will still be set; it is not cleared
> 	 *	on read.  However, modem control will not, we must
> 	 *	call it if we have saved something in the saved flags
> 	 *	while processing with interrupts off.
> 	 */
> 	if (up->msr_saved_flags) {
> 		if (is_atomic) {
> 			/*
> 			 * For atomic, MSR handling must be deferred to
> 			 * irq_work because this may be a context that does
> 			 * not permit waking up tasks.
> 			 *
> 			 * But no irq_work may be queued when suspending.
> 			 * In that case, the MSR handling will occur during
> 			 * resume in serial8250_resume_port().
> 			 */
> 			if (up->console_msr_work_allow)
> 				irq_work_queue(&up->console_msr_work);
> 		} else {
> 			serial8250_modem_status(up);
> 		}
> 	}
>
> 	nbcon_exit_unsafe(wctxt);
> }
>
> But I have to say that both approaches are quite hairy. I am not sure
> if it is worth it.

I would just move the unsafe_exit before the mdelay(). I think that is
sufficient here.

> Otherwise, I do not see any real problems in the code.

Thanks Petr for taking a detailed look at this!

I think v11 is OK for mainline (Greg has it in tty-testing now.) If
anything else comes up and I need to touch the code again, I will
relocate the unsafe_exit to before the mdelay().

John
