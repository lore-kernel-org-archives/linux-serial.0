Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21293B5311;
	Thu,  1 Oct 2026 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851722; cv=none; b=EsY/vaJrxgchUncn8BxKJ4OetiqTLx5vIZ3RKv2tR7spYPb6cFqIlm25KZ3WIzdiL1v9aPJsku4FnafrikK5psE9ctM0QU3q3kGldNjJITnepj5Te5N3EMcyMVccQ0KJCcvOYEOOTAaKdWgo2zF3AucV1Afgz2WD/XWiJJR6gwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851722; c=relaxed/simple;
	bh=GfdvcaJ60+dRkV13HqC79jVUwBkOeA7/lEXVgzzieKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gFGG0FF/gZuW31lsGnO8kQ6wddj9wFYKniOoJiJD4gvlgDoAKcMOe58QcIbhSM11+evyrO18iafYUGMnzaegoZutFDAeGnq15sGMFtIG0H6qVxrQhhCyB21p+yP3YHXO5Gs4Q/u4lVe2UNaq1t+7hvyr/MYpNSKoRlmBAh99Y44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jhy6JzJ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4JNTkNQV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jhy6JzJ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4JNTkNQV"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790851718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fWj8byMvLs+HQStKdX4riKt9qoysbfVhJDH4QPV2mI=;
	b=jhy6JzJ+0ZUVAwcS+yC3dgyoO04UodU0CtlQUl3QNrz0Ar7ZljlAN6yAi5dVCkKpZkjSpO
	BEO/JKZJGUHXCIqQ/0qTuLymr/xTtf4thNLnlUSTlIw02qmBk4bdD2CEPPxONZxC1mNeEl
	7IkW2fc4m+ScvsAq/4r1F+CCAYyyrA0ZHdL1vrKg4fjGPtCHsuMI3KEOigUkhQImefjd6f
	Eem8qZT0KZqrYqXqIRpp17UEMADGtE5LbvRDS3SdsMj9omaSDeZcMV94Ihgb8FgPLP7wpW
	JwAI1eNcxtPFDL8h9CbeACBquO6cBmpAUkecGw/dxZoW5rTl9W4EbzjsROtexQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790851718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fWj8byMvLs+HQStKdX4riKt9qoysbfVhJDH4QPV2mI=;
	b=4JNTkNQVRHlMN3IFUAkxvFRSexhW+l3Nn16JvraMiJhjBn0RWFp37T0J7fTCs3+8Y4ITVB
	QQ42UQGMD9Wd0UBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, Samuel
 Thibault <samuel.thibault@ens-lyon.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Fushuai Wang <wangfushuai@baidu.com>, Kees
 Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
 linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>,
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 1/1] braille: nbcon: Allow to use a serial console
 with NBCON API as Braille console
In-Reply-To: <20261001093946.112999-2-pmladek@suse.com>
References: <20261001093946.112999-1-pmladek@suse.com>
 <20261001093946.112999-2-pmladek@suse.com>
Date: Thu, 01 Oct 2026 12:54:37 +0206
Message-ID: <87jyo18zne.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-01, Petr Mladek <pmladek@suse.com> wrote:
> The Braille console is not registered in console_list. Instead, it is
> integrated with the virtual terminal (VT) and shows what is displayed
> on the terminal. It writes the data using con->write*() callback
> of the associated serial console driver.
>
> braille_write() is called from the VT code under console_lock().
> The associated serial console driver can be converted to the NBCON API
> though. The situation is similar to flushing nbcon consoles in the legacy
> loop when some boot consoles are still registered, see
> nbcon_legacy_emit_next_record().
>
> But there is a big difference thouhg. braille_write() is not directly

                         though ^^^^^^

> called from the code paths flushing registered consoles. The VT code
> expects that braille_write() succeeds. It does not replay the message
> when it can't acquire the ownership. As a result, braille_write():
>
>   + must try harder to get the ownership.
>
>   + has to be synchronized only against non-printk serial console
>     which depend nbcon_device_try_acquire() using NBCON_PRIO_NORMAL.
>
> Let's look at it from another side and try to simulate the original
> locking using the NBCON API:
>
>   1. Take con->device_lock(), aka the port->lock in the legacy serial
>      console driver.
>
>   2. Acquire nbcon context to provide some synchronization for a panic()
>      context. Use NBCON_PRIO_NORMAL because it fightling only against

                              contends only with ^^^^^^^^^^^^^^^^^^^^^^

>      nbcon_device_try_acquire() users. Do it in a busy loop. It should
>      always succeed when con->device_lock() succeeded because all other
>      users do the same. The only exception is when the context get acquired
>      by a CPU handling panic.
>
>   3. In panic, disable interrupts and try to acquire the nbcon context.
>      Use NBCON_PRIO_PANIC. And try even an unsafe takeover because
>      otherwise the Braille console won't see the text shown during panic().
>      It is similar to the oops_in_progress/trylock handling in the legacy
>      serial console driver.
>
> Finally, avoid the newline prepending logic in the existing serial console
> drivers when they are used as a Braille console. As explained above,
> the Braille console shows the last modified line on the terminal (VT).
> braille_write() is called when single characters are added. Most
> messages are not ended by newline. Anyway, the VT code does not have
> logic to reply partially printed messages.
>
> Fixes: 13189fa73afa ("printk: nbcon: Rely on kthreads for normal operation")
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  .../accessibility/braille/braille_console.c   | 64 ++++++++++++++-
>  drivers/tty/serial/8250/8250_port.c           |  5 +-
>  drivers/tty/serial/amba-pl011.c               |  2 +-
>  drivers/tty/serial/imx.c                      |  2 +-
>  drivers/tty/serial/sifive.c                   |  2 +-
>  include/linux/console.h                       | 15 ++++
>  kernel/printk/nbcon.c                         | 78 +++++++++++++++++++
>  7 files changed, 162 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
> index 06b43b678d6e..78611019b671 100644
> --- a/drivers/accessibility/braille/braille_console.c
> +++ b/drivers/accessibility/braille/braille_console.c
> @@ -62,14 +62,45 @@ static void braille_write(u16 *buf)
>  {
>  	static u16 lastwrite[WIDTH];
>  	unsigned char data[1 + 1 + 2*WIDTH + 2 + 1], csum = 0, *c;
> +	struct nbcon_write_context wctxt = { };
> +	unsigned long flags;
> +	bool locked;

There is no need for @locked because on failure, the function returns.

>  	u16 out;
>  	int i;
>  
>  	if (!braille_co)
>  		return;
>  
> +	/*
> +	 * Braille console is not registered in console_list. Instead, it
> +	 * is integrated with VT and shows what appears on the graphical
> +	 * console under console_lock(). From this POV it is a legacy
> +	 * console. But is calls serial console driver which might be

                     it ^^

> +	 * converted to the NBCON API. It is similar to
> +	 * nbcon_legacy_emit_next_record() except that we should try
> +	 * harder to get the lock. Othewise, the Braille device won't show

                         Otherwise ^^^^^^^^

> +	 * everything what is displayed on the terminal.
> +	 *
> +	 * In short, simulate the original locking using NBCON API.
> +	 */
> +	if (braille_co->flags & CON_NBCON) {
> +		if (panic_on_this_cpu()) {

How about adding here:

			if (!braille_co->write_atomic)
				return;

I see no reason to forbid Braille device usage just because it cannot
show panics.

> +			local_irq_save(flags);
> +			locked = nbcon_braille_try_acquire(braille_co, &wctxt);
> +			/* NBCON API strictly requires the ownership. */
> +			if (!locked) {
> +				local_irq_restore(flags);
> +				return;
> +			}
> +		} else {
> +			braille_co->device_lock(braille_co, &flags);
> +			while (!nbcon_braille_try_acquire(braille_co, &wctxt))
> +				cpu_relax();
> +		}
> +	}
> +
>  	if (!memcmp(lastwrite, buf, WIDTH * sizeof(*buf)))
> -		return;
> +		goto unlock_nbcon;
>  	memcpy(lastwrite, buf, WIDTH * sizeof(*buf));
>  
>  #define SOH 1
> @@ -102,7 +133,27 @@ static void braille_write(u16 *buf)
>  	*c++ = csum;
>  	*c++ = ETX;
>  
> -	braille_co->write(braille_co, data, c - data);
> +	if (braille_co->flags & CON_NBCON) {
> +		nbcon_write_context_set_buf(&wctxt, (char *)data, c - data);
> +		if (panic_on_this_cpu())
> +			braille_co->write_atomic(braille_co, &wctxt);
> +		else
> +			braille_co->write_thread(braille_co, &wctxt);
> +	} else {
> +		braille_co->write(braille_co, data, c - data);
> +	}
> +
> +unlock_nbcon:
> +	if (braille_co->flags & CON_NBCON) {
> +		if (panic_on_this_cpu()) {
> +			if (locked)
> +				nbcon_braille_release(&wctxt);

There will never be a locked=false scenario here. We already returned.

> +			local_irq_restore(flags);
> +		} else {
> +			nbcon_braille_release(&wctxt);
> +			braille_co->device_unlock(braille_co, flags);
> +		}
> +	}
>  }
>  
>  /* Follow the VC cursor*/
> @@ -353,13 +404,22 @@ int braille_register_console(struct console *console, int index,
>  	if (!console_options)
>  		/* Only support VisioBraille for now */
>  		console_options = "57600o8";
> +
>  	if (braille_co)
>  		return -ENODEV;
> +
> +	if (console->flags & CON_NBCON &&
> +	    (!console->write_atomic || console->flags & CON_NBCON_ATOMIC_UNSAFE)) {
> +		pr_err("Braille console requires a safe braille_co->write_atomic callback\n");

IMO it is not necessary to restrict to !CON_NBCON_ATOMIC_UNSAFE consoles
because if the acquire fails, an unsafe acquire is tried anyway. But as
I suggested earlier, I think even NBCON consoles without
->write_atomic() should be allowed. Just no panic message for them.

> +		return -EINVAL;
> +	}
> +
>  	if (console->setup) {
>  		ret = console->setup(console, console_options);
>  		if (ret != 0)
>  			return ret;
>  	}
> +
>  	console->flags |= CON_ENABLED;
>  	console->index = index;
>  	braille_co = console;
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 38fa45e74a37..548fd68ad1fa 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3417,8 +3417,11 @@ static void __serial8250_console_write(struct uart_8250_port *up,
>  	 * If the console printer did not fully output the previous line, it
>  	 * must have been handed or taken over. Insert a newline in order to
>  	 * maintain clean output.
> +	 *
> +	 * Braille consoles are an exception. The serial port is not used
> +	 * for printk(). The driver is supposed to write exactly what it gets.
>  	 */
> -	if (!up->console_line_ended) {
> +	if (unlikely(!up->console_line_ended && !nbcon_write_context_is_braille(wctxt))) {
>  		if (use_fifo)
>  			__serial8250_console_fifo_write(up, wctxt, "\n", 1);
>  		else
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index c4824c201e1c..e67f2ac454b6 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2656,7 +2656,7 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
>  				uap, REG_CR);
>  	}
>  
> -	if (!uap->console_line_ended)
> +	if (unlikely(!uap->console_line_ended && !nbcon_is_braille(co)))
>  		uart_console_write(&uap->port, "\n", 1, pl011_console_putchar);
>  	uart_console_write(&uap->port, wctxt->outbuf, wctxt->len, pl011_console_putchar);
>  
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 513dbe95f7e9..986fefb45c63 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2136,7 +2136,7 @@ static void imx_uart_console_write_atomic(struct console *co,
>  	imx_uart_writel(sport, ucr1, UCR1);
>  	imx_uart_writel(sport, old_ucr.ucr2 | UCR2_TXEN, UCR2);
>  
> -	if (!sport->last_putchar_was_newline)
> +	if (unlikely(!sport->last_putchar_was_newline && !nbcon_is_braille(co)))
>  		uart_console_write(port, "\n", 1, imx_uart_console_putchar);
>  	uart_console_write(port, wctxt->outbuf, wctxt->len,
>  			   imx_uart_console_putchar);
> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index 110d67613192..c44183cbdd8b 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -821,7 +821,7 @@ static void sifive_serial_console_write_atomic(struct console *co,
>  	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
>  	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
>  
> -	if (!ssp->console_line_ended)
> +	if (unlinely(!ssp->console_line_ended && !nbcon_is_braille(co)))

   unlikely ^^^^^^^^

>  		uart_console_write(port, "\n", 1, sifive_serial_console_putchar);
>  	uart_console_write(port, wctxt->outbuf, wctxt->len,
>  			   sifive_serial_console_putchar);
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 502d1abe3f50..94b926ad8c9c 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -615,6 +615,15 @@ extern bool nbcon_allow_unsafe_takeover(void);
>  extern bool nbcon_kdb_try_acquire(struct console *con,
>  				  struct nbcon_write_context *wctxt);
>  extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
> +extern bool nbcon_write_context_is_braille(struct nbcon_write_context *wctxt);
> +extern bool nbcon_braille_try_acquire(struct console *con,
> +				      struct nbcon_write_context *wctxt);
> +extern void nbcon_braille_release(struct nbcon_write_context *wctxt);
> +
> +static inline bool nbcon_is_braille(struct console *con)
> +{
> +	return con && con->flags & CON_BRL;
> +}
>  
>  /*
>   * Check if the given console is currently capable and allowed to print
> @@ -678,8 +687,14 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
>  static inline bool nbcon_kdb_try_acquire(struct console *con,
>  					 struct nbcon_write_context *wctxt) { return false; }
>  static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
> +static inline
> +bool nbcon_write_context_is_braille(struct nbcon_write_context *wctxt) { return false; }
>  static inline bool console_is_usable(struct console *con, short flags,
>  				     bool use_atomic) { return false; }
> +static inline bool nbcon_braille_try_acquire(struct console *con,
> +					     struct nbcon_write_context *wctxt) { return false; }
> +static inline void nbcon_braille_release(struct nbcon_write_context *wctxt) { }
> +static inline bool nbcon_is_braille(struct console *con) { return false; }
>  #endif
>  
>  extern int console_set_on_cmdline;
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index d17704fe93ae..228c75f90662 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1887,6 +1887,7 @@ bool nbcon_device_try_acquire(struct console *con)
>  
>  	memset(ctxt, 0, sizeof(*ctxt));
>  	ctxt->console	= con;
> +	/* Keep in sync with nbcon_braille_try_acquire(). */
>  	ctxt->prio	= NBCON_PRIO_NORMAL;
>  
>  	if (!nbcon_context_try_acquire(ctxt, false))
> @@ -2002,3 +2003,80 @@ void nbcon_kdb_release(struct nbcon_write_context *wctxt)
>  	 */
>  	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb));
>  }
> +
> +/**
> + * nbcon_is_braille - Checks whether the nbcon write context is using Braille console
> + *
> + * @wctxt:	checked nbcon write context
> + *
> + * Return: True when the write context is associated with a Braille console.
> + *	   Othrewise, return false.
> + *
> + * Context: Can be called in any context but only when Braille console is
> + *	registered and the struct console could not disappear.
> + */
> +bool nbcon_write_context_is_braille(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +
> +	return con && con->flags & CON_BRL;

I suggest parenthesis around "con->flags & CON_BRL".

> +}
> +
> +/**
> + * nbcon_braille_try_acquire - Try to acquire nbcon console for braille_write()
> + *
> + * @con:	The nbcon console to acquire
> + * @wctxt:	The nbcon write context to be used on success
> + *
> + * Context:	braille_write() for emitting a single buffer on Braille console.
> + *
> + * Return:	True if the console was acquired. False otherwise.
> + *
> + * Braille console is not registered as a proper printk consoles. Instead,
> + * it is integrated with the graphical virtual terminal.
> + *
> + * This function is going to synchronize the Braille write against other
> + * operations on the used serial port. The port can be used also for a user
> + * input but printk() won't emit the messages there directly. It means
> + * the other operations will get synchronized using nbcon_device_try_acquire().
> + */
> +bool nbcon_braille_try_acquire(struct console *con,
> +			   struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	bool success;
> +
> +	memset(ctxt, 0, sizeof(*ctxt));
> +	ctxt->console = con;
> +	/* Keep in sync with nbcon_device_try_acquire(). */
> +	if (panic_on_this_cpu())
> +		ctxt->prio = NBCON_PRIO_PANIC;
> +	else
> +		ctxt->prio = NBCON_PRIO_NORMAL;
> +
> +	success = nbcon_context_try_acquire(ctxt, false);
> +	/*
> +	 * Try hard in panic, othrewise the Braille console would

                    otherwise ^^^^^^^^^
> +	 * miss a text on the related VT.
> +	 */
> +	if (panic_on_this_cpu() && !success) {
> +		ctxt->allow_unsafe_takeover = true;
> +		success = nbcon_context_try_acquire(ctxt, false);
> +	}
> +
> +	return success;
> +}
> +
> +/**
> + * nbcon_braille_release - Release the nbcon console
> + *
> + * @wctxt:	The nbcon write context initialized by a successful
> + *		nbcon_braille_try_acquire()
> + */
> +void nbcon_braille_release(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	nbcon_context_release(ctxt);
> +}

The rest looks OK.

John
