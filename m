Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75F14B835
	for <linux-serial@vger.kernel.org>; Fri, 23 Feb 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685474; cv=none; b=HcAV3Bh0vqs1XzNtvl4F9msqRQ73m+WWVdxALArzluHIQRUj/YYFC1axQ7yUMCgJC6MBJKzH5UXBFThaMyAGWcPG0c2Po+ZnlpE5YCMLQmLUUUJ0+8MLLnTI8sG8xINvs5G9jyhqFD0Kn/jRzMp3ZEYtQIsnAE33NsmPe74m1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685474; c=relaxed/simple;
	bh=4lGutqyo4dW9a6KP2ZL7SNHCNAMaFYQkz047+ucEuGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTn0Hu+ejvoPe2XCIY+uh7YLgebe+JFPhbzcYk1wrq2LrU3SEz+S9VdfAkWqdvUZYFUbR4L8pXBm3J3fuYcoZbNzHy4hR5UBLpQxXEqxWD/pTrtaut159ksgzkSK2Gj0FUa4o4RAw1qll0ZoI5jPF9JY/r6d68Zf8Y57JdEIT0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tbt/L38g; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tbt/L38g"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso757875a12.2
        for <linux-serial@vger.kernel.org>; Fri, 23 Feb 2024 02:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708685469; x=1709290269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKDsxXZSstfhqJQ2dtwyOtBufFR+CeoE5e1IxvLjwQk=;
        b=Tbt/L38grhnpeaoFSFkwx6kDfkBBrAYBEaZPOJR6Gc+JV/KD898x9SRm4nwA0IXQ7t
         OANnSw221U3Ofgq+Qz97q3tg0Z2VGjJJai/QDGvWnBdNxfq8P1wtQ7qUIctGWeEKFoak
         nk4+6Kyl+8eLNIaUhOcvtSoVkfx6Nd4lCABWJpY6x0BSIxOfN/KwPuyEOkp+GQ9Y+IoX
         o4Jb9Fye8KsERv0QBTB6WCK1MpxWfQB2mSCp2mZMCy6LbRAwCfgRPXg9n+HUghyseoP9
         OGKBSMJZv0RhKRWV+N+He335U2P50XsEVsxsj+Zx4xsZNo/lq+93UPV+2wvchO8AmSxd
         jfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708685469; x=1709290269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKDsxXZSstfhqJQ2dtwyOtBufFR+CeoE5e1IxvLjwQk=;
        b=Wud8BBAH9xE0Vru6cKOX36v7FSTF9kyyOqV+EQfI8CEme0TynvhUl9x0J6qO7ypD8k
         rOdMf/p6To3wgH4kgDrE9XCMPtmKlj7LdT8OAvwouDQ+RVtnD3uAF2rKF7r1vmU31LSR
         NdgAAz3xz79ncQB39KZAIVFqih+NraH918MKCIt0W5hWsKpTMsOLSgOlcHaUUDQ6dZOZ
         I+WqrJZtdbSjJE1UiO2T0Ndw8+ATeu3BWq3/7OPdcn2KreZYJ/773gzI3Qih1Tmi6UDM
         JjCrKN+B2IU35iaHT5lMWRqaAIlGydr+43YJhnMUQExLR60RADhopHZOH29rw5qJ0r2L
         h+ug==
X-Forwarded-Encrypted: i=1; AJvYcCVdu3pAfRA/210a+xFG8BiZSpGZczoXWATaP1HVUqOUOzGf6athd2afaXvQ/Ei7iGPKBzT6nd3qOpV8UMztypmgC3goKflDhYAyvrw6
X-Gm-Message-State: AOJu0YxK6eiYH9WR2b6J6N0GlI8kxKINzgnEq7kTB7cXdR2sDNY69Oxo
	UIBchRaADXQUijppLkGPKqIl7HeO7WWv+nO57dqDCDPQhq68LJO/Ieb3GPPiwPkDHtzrIX3ed9g
	M
X-Google-Smtp-Source: AGHT+IEUj9j3jrUO5dyI/q5UuKxsP9cOduD3sa2z8DCI3IJFvYGU6XuEy30KKUKwgtHpdmZ+xvx+bg==
X-Received: by 2002:a05:6402:180a:b0:565:719b:d10e with SMTP id g10-20020a056402180a00b00565719bd10emr791620edy.1.1708685468779;
        Fri, 23 Feb 2024 02:51:08 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id b30-20020a50ccde000000b005643b41d128sm5951823edj.5.2024.02.23.02.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:51:08 -0800 (PST)
Date: Fri, 23 Feb 2024 11:51:06 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Justin Chen <justin.chen@broadcom.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 08/26] printk: nbcon: Implement processing in
 port->lock wrapper
Message-ID: <Zdh4eEJJpasEWqa5@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-9-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-9-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:08, John Ogness wrote:
> Currently the port->lock wrappers uart_port_lock(),
> uart_port_unlock() (and their variants) only lock/unlock
> the spin_lock.
> 
> If the port is an nbcon console, the wrappers must also
> acquire/release the console and mark the region as unsafe. This
> allows general port->lock synchronization to be synchronized
> with the nbcon console ownership.
> 
> Add a flag to struct uart_port to track nbcon console ownership.

The patch makes sense.

My main (only) concern was the synchronization of the various accessed
variables, especially, port->cons.

Note: I am not completely sure how the early and valid console drivers
      share the same struct uart_port. So, maybe I miss some important
      guarantee.

Anyway. synchronization of port->cons looks like a shade area.
IMHO, the existing code expects that it is used _only when the console
is registered_. But this patch wants to access it _even before
the console is registered_!

For example, it took me quite a lot of time to shake my head around:

#define uart_console(port) \
	((port)->cons && (port)->cons->index == (port)->line)

  + port->cons and port->line are updated in the uart code.
    It seems that the update is not serialized by port->lock.
    Something might be done under port->mutex.

  + cons->index is updated in register_console() under
    console_list_lock.

Spoiler: I propose a solution which does not use uart_console().

See below for more details.

> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3284,6 +3284,7 @@ void serial8250_init_port(struct uart_8250_port *up)
>  	struct uart_port *port = &up->port;
>  
>  	spin_lock_init(&port->lock);
> +	port->nbcon_locked_port = false;

I am not sure if the variable really helps anything:

   + nbcon_context release() must handle the case when it
     lost the ownership anyway.

     It is the same as if it did not acquire the context
     in the first place [*].


   + nbcon_acquire() is called under port->lock. It means that
     nbcon_release() should always be called when the acquire
     succeeded earlier.

We just need to make sure that port->cons can be cleared only
under port->lock. But this would be required even with
port->nbcon_locked_port.

[*] I am not super-happy with this semantic because it prevents
    catching bugs by lockdep. But it is how nbcon_acquire/release
    work and it is important part of the design.


Apology: It is possible that I suggested to add this variable. I just
	see now that it does not really help much. It rather makes
	a false feeling about that nbcon acquire/release are always
	paired.

>  	port->ctrl_id = 0;
>  	port->pm = NULL;
>  	port->ops = &serial8250_pops;
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -995,3 +996,79 @@ void nbcon_free(struct console *con)
>  
>  	con->pbufs = NULL;
>  }
> +
> +static inline bool uart_is_nbcon(struct uart_port *up)
> +{
> +	int cookie;
> +	bool ret;
> +
> +	if (!uart_console(up))

This function accesses up->cons. I am not completely sure how
this value is synchronized, for example:

  + serial_core_add_one_port() sets uport->cons under port->mutex.
    The function is called uart_add_one_port() in various probe()
    or init() calls.

  + univ8250_console_setup() sets and clears port->cons with
    no explicit synchronization. The function is called from
    try_enable_preferred_console() under console_list_lock.

IMHO, the assignment is done when the drivers are being initialized.
It is done when the port might already be used by early consoles.

Especially, according to my understanding, newcon->setup() callbacks
are responsible for using the same port by early and real console drivers.

I guess that uart_port_lock() API is used by early consoles as well.
It means that they might access up->cons here while it is being
manipulated by the proper driver.

A minimal solution would be access/modify port->cons using
READ_ONCE()/WRITE_ONCE().

But I think that we do not need to call uart_console() at all.
We do not really need to synchronize the consistency of
con->index and port->line.

Instead, we could read up->cons using READ_ONCE() and
check if it is defined. Or even better would be to always
set/read port->cons under the port->lock.


> +		return false;
> +
> +	cookie = console_srcu_read_lock();
> +	ret = (console_srcu_read_flags(up->cons) & CON_NBCON);
> +	console_srcu_read_unlock(cookie);

Hmm, console_srcu_read_flags(con) is called under
console_srcu_read_lock() to make sure that it does not
disappear. It makes sense when it is used by registered consoles.

But uart_port_lock() might be called even when the console
is not registered.

I suggest to remove the SRCU lock here. In this code path,
it does not guarantee anything and is rather misleading.

I would use a READ_ONCE(), for example by splitting:

/*
 * Locklessly reading console->flags provides a consistent
 * read value because there is at most one CPU modifying
 * console->flags and that CPU is using only read-modify-write
 * operations to do so.
 *
 * The caller must make sure that @con does not disappear.
 * It can be done by console_srcu_read_lock() when used
 * only for registered consoles.
 */
static inline short console_read_flags(const struct console *con)
{
	return data_race(READ_ONCE(con->flags));
}

/* Locklessly reading console->flags for registered consoles */
static inline short console_srcu_read_flags(const struct console *con)
{
	WARN_ON_ONCE(!console_srcu_read_lock_is_held());

	console_read_flags();
}

> +	return ret;
> +}
> +
> +/**
> + * uart_nbcon_acquire - The second half of the port locking wrapper
> + * @up:		The uart port whose @lock was locked
> + *
> + * The uart_port_lock() wrappers will first lock the spin_lock @up->lock.
> + * Then this function is called to implement nbcon-specific processing.
> + *
> + * If @up is an nbcon console, this console will be acquired and marked as
> + * unsafe. Otherwise this function does nothing.
> + */
> +void uart_nbcon_acquire(struct uart_port *up)
> +{
> +	struct console *con = up->cons;
> +	struct nbcon_context ctxt;

I would add:

	lockdep_assert_held(&up->lock);
> +
> +	if (!uart_is_nbcon(up))
> +		return;
> +
> +	WARN_ON_ONCE(up->nbcon_locked_port);
> +
> +	do {
> +		do {
> +			memset(&ctxt, 0, sizeof(ctxt));
> +			ctxt.console	= con;
> +			ctxt.prio	= NBCON_PRIO_NORMAL;
> +		} while (!nbcon_context_try_acquire(&ctxt));
> +
> +	} while (!nbcon_context_enter_unsafe(&ctxt));
> +
> +	up->nbcon_locked_port = true;
> +}
> +EXPORT_SYMBOL_GPL(uart_nbcon_acquire);

I would prefer to split the uart and nbcon specific code, for example:

/**
 * nbcon_normal_context_acquire - Acquire a generic context with
 *	the normal priority for nbcon console
 * @con:	nbcon console
 *
 * Context:	Any context which could not be migrated to another CPU.
 *
 * Acquire a generic context with the normal priority for the given console.
 * Prevent the release by entering the unsafe state.
 *
 * Note: The console might still loose the ownership by a hostile takeover.
 *	 But it can be done only by the final flush in panic() when other
 *	 CPUs should be stopped and other contexts interrupted.
 */
static void nbcon_normal_context_acquire(struct console *con)
{
	struct nbcon_context ctxt;

	do {
		do {
			memset(&ctxt, 0, sizeof(ctxt));
			ctxt.console	= con;
			ctxt.prio	= NBCON_PRIO_NORMAL;
		} while (!nbcon_context_try_acquire(&ctxt));

	} while (!nbcon_context_enter_unsafe(&ctxt));
}

/**
 * uart_nbcon_acquire - Acquire nbcon console associated with the gived port.
 * @up:		uart port
 *
 * Context:	Must be called under up->lock to prevent manipulating
 *		up->cons and migrating to another CPU.
 *
 * Note: The console might still loose the ownership by a hostile takeover.
 *	 But it can be done only by the final flush in panic() when other
 *	 CPUs should be stopped and other contexts interrupted.
 */
void uart_nbcon_acquire(struct uart_port *up)
{
	struct console *con; = up->cons;

	lockdep_assert_held(&up->lock);

	/*
	 * FIXME: This would require adding WRITE_ONCE()
	 * on the write part.
	 *
	 * Or even better, the value should be modified under
	 * port->lock so that simple read would be enough here.
	 */
	con = data_race(READ_ONCE(up->cons));

	if (!con)
		return;

	if (!console_read_flags(con) & CON_NBCON)
		return;

	nbcon_normal_context_acquire(con);
}

Note that I did not use up->nbcon_locked_port as explained above.


> +
> +/**
> + * uart_nbcon_release - The first half of the port unlocking wrapper
> + * @up:		The uart port whose @lock is about to be unlocked
> + *
> + * The uart_port_unlock() wrappers will first call this function to implement
> + * nbcon-specific processing. Then afterwards the uart_port_unlock() wrappers
> + * will unlock the spin_lock @up->lock.
> + *
> + * If @up is an nbcon console, the console will be marked as safe and
> + * released. Otherwise this function does nothing.
> + */
> +void uart_nbcon_release(struct uart_port *up)
> +{
> +	struct console *con = up->cons;
> +	struct nbcon_context ctxt = {
> +		.console	= con,
> +		.prio		= NBCON_PRIO_NORMAL,
> +	};
> +

I would add here as well.

	lockdep_assert_held(&up->lock);


This deserves a comment why we do not complain when this function
is called for nbcon and it is not locked. Something like:

	/*
	 * Even port used by nbcon console might be seen unlocked
	 * when it was locked and the console has been registered
	 * at the same time.
	 */
> +	if (!up->nbcon_locked_port)
> +		return;

Wait, if up->cons might be set asynchronously then it might also
disapper assynchronously. Which would be really bad because we would
not be able to release the normal context.

IMHO, we really need to synchronize up->cons acceess using up->lock.

> +
> +	if (nbcon_context_exit_unsafe(&ctxt))
> +		nbcon_context_release(&ctxt);
> +
> +	up->nbcon_locked_port = false;
> +}

Again I would better split the nbcon and uart part and create:

/**
 * nbcon_normal_context_release - Release a generic context with
 *	the normal priority.
 * @con:	nbcon console
 *
 * Context:	Any context which could not be migrated to another CPU.
 *
 * Release a generic context with the normal priority for the given console.
 * Prevent the release by entering the unsafe state.
 *
 * Note: The console might have lost the ownership by a hostile takeover.
 *	 But it should not happen in reality because the hostile
 *       takeover is allowed only for the final flush in panic()
 *	 when other CPUs should be stopped and other contexts interrupted.
 */
static void nbcon_normal_context_release(struct console *con)
{
	struct nbcon_context ctxt = {
		.console	= con,
		.prio		= NBCON_PRIO_NORMAL,
	};

	if (nbcon_context_exit_unsafe(&ctxt))
		nbcon_context_release(&ctxt);
}

/**
 * uart_nbcon_acquire - Release nbcon console associated with the given port.
 * @up:		uart port
 *
 * Context:	Must be called under up->lock to prevent manipulating
 *		up->cons and migrating to another CPU.
 */
void uart_nbcon_release(struct uart_port *up)
{
	struct console *con;

	lockdep_assert_held(&up->lock);

	/*
	 * FIXME: This would require adding WRITE_ONCE()
	 * on the write part.
	 *
	 * Or even better, the value should be modified under
	 * port->lock so that simple read would be enough here.
	 */
	con = data_race(READ_ONCE(up->cons));

	if (!con)
		return;

	if (!console_read_flags(con) & CON_NBCON)
		return;

	nbcon_normal_context_release(con);
}

Best Regards,
Petr
