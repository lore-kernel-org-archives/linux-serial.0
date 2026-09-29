Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F751DDEB;
	Tue, 29 Sep 2026 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678508; cv=none; b=uLYIX2fZC+AheiCLDMSTGVauK88y3NgJ6geRRX2CZZZkLbsk1qhXdEhMio/6qvsX7+10WOraqN249H4XnBUjJR3MXLtrEF+1lWNbmAGKmvAt95qCzt1xl+9ug9nUxb9thxqIQ9lxcLv/kcWKcKitidxuUUZIzwBexS0dUvoNTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678508; c=relaxed/simple;
	bh=GQ5XtEJaeNn9D4Jj0IjrScGUo+gbDuCeiBy8kwo/5Pg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mU9le//ojcKKkVUyjVgeF8/xSJn5JX2FVKQsolfeGGmydZnaELTX+TvPPZMs2v85dzHJrG+Rdx5PmSeB8dB46KldiTyhahNyZsceK0dP3ktz1W19ZHWQdEy0u62UEZqEGI2HYBYR5EKgcMpaLJzow7+89kVFfXKHMjkMxShrap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=joo1t7FG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=he3mz/qu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="joo1t7FG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="he3mz/qu"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790678486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fgAnEFy2bPSl3OHZEd8eWmU0JUH6K+IrNP9zUpKqkbo=;
	b=joo1t7FGeFn8Kq6sISCF6KMAPrTYtzhCUP0odubToKPqpZa1NGu0aCv1s8nKqzWMdYK6Sj
	C26nMy2uEjD0eYzAJhcbEPbKEa6iDOv7IvNei1kWBeL/5aykxH7lzXf0rUkIjeGbN6v72Y
	BG/5DeJqOdcoSBuCoHuTAtjfMCql46q1PBBWh6YMrXpS0Fn6xnxcr20iQz+5apNR989SdH
	mCPDjO85bAiOuVTDR7zsqeAtkZX2DFmspIo9qg4zr3d0iWG3adfq+lDS/5p6Vk16lFiaC5
	c+ldj5aj4ojglIHTNwB3P1OdqHM2s6OjZc7jrT7xFZBVzV5dzK88jqtqTNO0jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790678486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fgAnEFy2bPSl3OHZEd8eWmU0JUH6K+IrNP9zUpKqkbo=;
	b=he3mz/quGhlhweuXNM8DncrW8RLZmGqdLPBR/PVNtjk+ygMp9P5Q36A4L7LYKeOI4GmTIZ
	ZTC0xZC0aM+R1EBQ==
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
Subject: Re: [PATCH v2 1/1] braille: nbcon: Allow to use a serial console
 with NBCON API as Braille console
In-Reply-To: <20260925141729.173943-2-pmladek@suse.com>
References: <20260925141729.173943-1-pmladek@suse.com>
 <20260925141729.173943-2-pmladek@suse.com>
Date: Tue, 29 Sep 2026 12:47:26 +0206
Message-ID: <874if8cpbd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-09-25, Petr Mladek <pmladek@suse.com> wrote:
> The Braille console is integrated with the virtual terminal (VT) and
> writes its data using the legacy con->write() callback of the associated
> serial console driver.
>
> When the associated serial console driver gets converted to the NBCON API,
> the braille write callback should use con->write_atomic() callback
> with an appropriate locking.
>
> It must be the atomic variant because it can be called under a spin_lock,
> for example via:
>
>   + kbd_event()
>     + kbd_keycode()
>       + atomic_notifier_call_chain(&keyboard_notifier_list)
> 	+ vt_notifier_call()
> 	  + vc_refresh()
> 	    + braille_write()
>
> In addition, it can be called from printk() in any context via
> the graphical tty driver (vt code) even when the Braille driver is not
> in console_list directly.
>
> The locking is inspired with nbcon_legacy_emit_next_record(),
> nbcon_kdb_try_acquire()/release(), and the original serial driver locking:
>
>   1. IRQs are explicitly disabled to prevent CPU migration and nested
>      calls into the serial driver code.
>
>   2. New nbcon_braille_try_acquire()/release() API allows to initialize
>      the write context and acquire the ownership. It is using
>      NBCON_PRIO_NORMAL because it competes only with the other operations
>      on the serial console driver which are serialized using
>      nbcon_device_try_acquire().
>
>   3. It uses a busy loop until it acquires the ownership. Otherwise,
>      the messages would get lost. [*]

There could only be ownership issues if userspace is playing with the
/dev/ttySx device node, which userspace should not be doing.

>   4. It does just the best effort when oops_in_progress is set.
>
> Also, adjust __serial8250_console_write() in the 8250 serial driver to
> exclude Braille consoles from the newline prepending logic.

Note that all NBCON drivers cause this issue, not just the 8250. Later I
mention why it does not matter and no changes to the 8250 are required.

> The serial
> port is not used for standard printk logging which might be interrupted
> in the middle of the operation. In the Braille mode, the serial driver
> is supposed to write exactly what it gets. In fact, it does not print
> any newlines at all in this case.

Well, it still performs the "\n" -> "\r\n" conversions. But I guess that
is appropriate.

> [*] The busy loop is not safe on PREEMPT_RT where the current owner
>     might sleep. We will need another solution there.

If we are knowingly breaking PREEMPT_RT then this series should also
include:

diff --git a/drivers/accessibility/Kconfig b/drivers/accessibility/Kconfig
index 6b2f79d1f1b81..d4faa6e0e01b1 100644
--- a/drivers/accessibility/Kconfig
+++ b/drivers/accessibility/Kconfig
@@ -21,6 +21,7 @@ config A11Y_BRAILLE_CONSOLE
 	bool "Console on braille device"
 	depends on VT
 	depends on SERIAL_CORE_CONSOLE
+	depends on !PREEMPT_RT
 	help
 	  Enables console output on a braille device connected to a 8250
 	  serial port. For now only the VisioBraille device is supported.

The console_braille "driver" needs to be made into a proper driver and
make use of the serdev subsystem. I am currently working on this, but
the changes are not trivial. And, optimally, the vt_console should also
be switched over to NBCON. So this is not something we are going to get
fixed in an rc6. For that reason, I support moving forward with this
series until a proper solution is developed.

> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  .../accessibility/braille/braille_console.c   | 43 ++++++++++++-
>  drivers/tty/serial/8250/8250_port.c           |  5 +-
>  include/linux/console.h                       |  8 +++
>  kernel/printk/nbcon.c                         | 64 +++++++++++++++++++
>  4 files changed, 117 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
> index 06b43b678d6e..bae177cb8cf9 100644
> --- a/drivers/accessibility/braille/braille_console.c
> +++ b/drivers/accessibility/braille/braille_console.c
> @@ -62,14 +62,36 @@ static void braille_write(u16 *buf)
>  {
>  	static u16 lastwrite[WIDTH];
>  	unsigned char data[1 + 1 + 2*WIDTH + 2 + 1], csum = 0, *c;
> +	struct nbcon_write_context wctxt = { };
> +	unsigned long flags;
> +	bool locked;
> +
>  	u16 out;
>  	int i;
>  
>  	if (!braille_co)
>  		return;
>  
> +	if (braille_co->flags & CON_NBCON) {
> +		/*
> +		 * Braille console might be called from unknown context via
> +		 * vt_console_print() from console_unlock() from printk().
> +		 * Use the atomic callback and synchronize it just using
> +		 * the console context. Disable interrupts to prevent a nested
> +		 * call into the driver code which might cause a deadlock when
> +		 * trying to acquire the console ownership, see
> +		 * __nbcon_atomic_flush_pending_con().
> +		 */
> +		local_irq_save(flags);
> +		do {
> +			locked = nbcon_braille_try_acquire(braille_co, &wctxt);
> +			if (!locked)
> +				cpu_relax();
> +		} while (!locked && !oops_in_progress);
> +	}
> +
>  	if (!memcmp(lastwrite, buf, WIDTH * sizeof(*buf)))
> -		return;
> +		goto release_nbcon;
>  	memcpy(lastwrite, buf, WIDTH * sizeof(*buf));
>  
>  #define SOH 1
> @@ -102,7 +124,24 @@ static void braille_write(u16 *buf)
>  	*c++ = csum;
>  	*c++ = ETX;
>  
> -	braille_co->write(braille_co, data, c - data);
> +	if (braille_co->flags & CON_NBCON) {
> +		if (braille_co->write_atomic &&
> +		    !(braille_co->flags & CON_NBCON_ATOMIC_UNSAFE)) {
> +			nbcon_write_context_set_buf(&wctxt, (char *)data, c - data);
> +			braille_co->write_atomic(braille_co, &wctxt);
> +		} else {
> +			pr_warn_once("Braille requires a safe braille_co->write_atomic callback\n");

This needs to be caught in braille_register_console(), not here.

> +		}
> +	} else {
> +		braille_co->write(braille_co, data, c - data);
> +	}
> +
> +release_nbcon:
> +	if (braille_co->flags & CON_NBCON) {
> +		if (locked)
> +			nbcon_braille_release(&wctxt);
> +		local_irq_restore(flags);
> +	}
>  }
>  
>  /* Follow the VC cursor*/
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 38fa45e74a37..6eb0b439e433 100644
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
> +	if (unlikely(!up->console_line_ended && !nbcon_is_braille(wctxt))) {

This change is not necessary because there will never be
handovers/takeovers for Braille. It is not registered as a console.

>  		if (use_fifo)
>  			__serial8250_console_fifo_write(up, wctxt, "\n", 1);
>  		else
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 502d1abe3f50..d780f6de303a 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -615,6 +615,10 @@ extern bool nbcon_allow_unsafe_takeover(void);
>  extern bool nbcon_kdb_try_acquire(struct console *con,
>  				  struct nbcon_write_context *wctxt);
>  extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
> +extern bool nbcon_is_braille(struct nbcon_write_context *wctxt);

nbcon_is_braille() is not needed.

> +extern bool nbcon_braille_try_acquire(struct console *con,
> +				      struct nbcon_write_context *wctxt);
> +extern void nbcon_braille_release(struct nbcon_write_context *wctxt);
>  
>  /*
>   * Check if the given console is currently capable and allowed to print
> @@ -678,8 +682,12 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
>  static inline bool nbcon_kdb_try_acquire(struct console *con,
>  					 struct nbcon_write_context *wctxt) { return false; }
>  static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
> +static inline bool nbcon_is_braille(struct nbcon_write_context *wctxt) { return false; }

nbcon_is_braille() is not needed.

>  static inline bool console_is_usable(struct console *con, short flags,
>  				     bool use_atomic) { return false; }
> +static inline bool nbcon_braille_try_acquire(struct console *con,
> +					     struct nbcon_write_context *wctxt) { return false; }
> +static inline void nbcon_braille_release(struct nbcon_write_context *wctxt) { }
>  #endif
>  
>  extern int console_set_on_cmdline;
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index d17704fe93ae..e5a0506330eb 100644
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
> @@ -2002,3 +2003,66 @@ void nbcon_kdb_release(struct nbcon_write_context *wctxt)
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
> +bool nbcon_is_braille(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +
> +	return con && con->flags & CON_BRL;
> +}

nbcon_is_braille() is not needed.

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
> +
> +	memset(ctxt, 0, sizeof(*ctxt));
> +	ctxt->console = con;
> +	/* Keep in sync with nbcon_device_try_acquire(). */
> +	ctxt->prio = NBCON_PRIO_NORMAL;
> +
> +	return nbcon_context_try_acquire(ctxt, false);
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

John Ogness
