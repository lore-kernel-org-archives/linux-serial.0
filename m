Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448AD15B153
	for <linux-serial@vger.kernel.org>; Wed, 10 Apr 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752518; cv=none; b=KQnFKcilJOLuZbOceGmBV25CwLqeAchlQgDKwBdx+WrNsHLAjCLFk5qgaxVQA/ycP4FYXJUtHwDhHgryQIvzNNYbcHefrkjbmLjvVzjgV0J7tKJgf3oNWCmmyB7KCdFccZJkGTE55bSLgaHeX5ZZEomm9BFeUZJd1eSAiblZjHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752518; c=relaxed/simple;
	bh=TPW7z25VA25IH4mn5QCCaLkAd9PHJishk0C3e8SbDJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRqcPHJ2bkOEsXI6z49HjgxGH1jSqNaZdvv5OQ2oRIJ3oTHTCGhBh+Ivsaz8cCu5H13MfW37ksN4+xF87kY6A7ROgxrr9dCOKBAaNT53sAHOWQl3M57t3rnJGXstvpkGWco3zICuW+SRMELZJAB2zyBg6ftrfZ1l8R/1cDYyM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T2qQDLhW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T2qQDLhW"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4165caf9b2dso35558805e9.1
        for <linux-serial@vger.kernel.org>; Wed, 10 Apr 2024 05:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712752512; x=1713357312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4u1OqKWT/Fd4SbXAWMEENZmlKxdBreylzgVp8nF4PA=;
        b=T2qQDLhWh41ry5rFPhC6iYX5FNt4LMYXseKCNjd9npLL+7OcoCGeXJJXlUw++LvZPT
         fYC4GyIoXoW1BK8XIHm9wj8MdgLPJfCqXsgPwSnGQcDKSd8WbwsmRji/x5A3KY0+1svQ
         hQzB8AJOkkex9oiSbblsjKib6P8/jk8a6XvhdhUuMxUQvMyEF2P2VQqF9NMfNVzOb5of
         dulY/KXHCMcnrUSAXCwMk5KKDBAQr2ql5OKusvgCPrzSfeyxg6t8c0kaVyMWO7J7HyHE
         dQto1hr563vJal9kV27brhn1butlcuzn6n9SE8ZRNd/GRD82rIzJoZvPvxCU9NzDLyo8
         mMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712752512; x=1713357312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4u1OqKWT/Fd4SbXAWMEENZmlKxdBreylzgVp8nF4PA=;
        b=sn0HwL1J4nQAeFy0h4yN1Rgyr7AmZ3PM/yRph1tIsJs6ojfZEDpSaQPJwwICiOpkra
         u/dp6XvWRdBNIwl8yYhn6fPI5qI2vX7BBp4GUAd4dw27nMAeGlULG4YSLbQ76bFRmp2z
         JS3SFkOcFK25vtcj3QV1nTVpRv2oReEpAjEP4ZgHTJxEuHN9zHc/mkauv2NIq2sALcD4
         EdUvkf9WggPRwWygePger/kzmD0IQXR7Q77Yqzxk7/6aa2nRHTCC5XXwSmRw444Ml0lC
         c6MPvxZyPiMCfrzdFnorZeTS7NzbwUWte/OdrVQjo1VtxcPJKe5MuQYyMe7DXoD80Hkh
         BsDA==
X-Forwarded-Encrypted: i=1; AJvYcCX5z9jKAwHPIACIHz5t3+JQgvJUh+/fA1sp9e+AZDZvznOiy8TXsEbtmBvvmoW+VS7UvgzYiWBDoGwgpPotJit7Q5dhczq2Xv8PdX+B
X-Gm-Message-State: AOJu0Yyxj+6WLUaTxCEqtQqCoRS4fhbDrw9alzHp7FPsNja+07dMMvve
	ojdnBwPFaP/H8TsFeYZeibhp++eJgLyQyc9TDdt5EpHmJdVImqINH0IUfzhmCfA=
X-Google-Smtp-Source: AGHT+IH2FhEGJj9PPXZonEhO5cFRUz79WOynjglzTpxIC4y/g1JAKl79K2BzAg/3ej09IDAqQtiWnw==
X-Received: by 2002:a05:6000:2a3:b0:343:8551:8d90 with SMTP id l3-20020a05600002a300b0034385518d90mr2856242wry.34.1712752511064;
        Wed, 10 Apr 2024 05:35:11 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id o14-20020adfe80e000000b003436a3cae6dsm13647300wrm.98.2024.04.10.05.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:35:10 -0700 (PDT)
Date: Wed, 10 Apr 2024 14:35:08 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Fabio Estevam <festevam@denx.de>, Arnd Bergmann <arnd@arndb.de>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v4 09/27] printk: nbcon: Implement processing in
 port->lock wrapper
Message-ID: <ZhaHfFa2LJ6zQic1@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-10-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:11, John Ogness wrote:
> Currently the port->lock wrappers uart_port_lock(),
> uart_port_unlock() (and their variants) only lock/unlock
> the spin_lock.
> 
> If the port is an nbcon console, the wrappers must also
> acquire/release the console and mark the region as unsafe. This
> allows general port->lock synchronization to be synchronized
> with the nbcon console ownership.
> 
> Introduce a new struct nbcon_drvdata within struct console that
> provides the necessary components for the port lock wrappers to
> acquire the nbcon console and track its ownership.
> 
> Also introduce uart_port_set_cons() as a wrapper to set @cons
> of a uart_port. The wrapper sets @cons under the port lock in
> order to prevent @cons from disappearing while another context
> owns the port lock via the port lock wrappers.
> 
> Also cleanup the description of the console_srcu_read_flags()
> function. It is used by the port lock wrappers to ensure a
> console cannot be fully unregistered while another context
> owns the port lock via the port lock wrappers.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -689,7 +689,7 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
>  			continue;
>  
>  		co->index = i;
> -		port->cons = co;
> +		uart_port_set_cons(port, co);
>  		return serial8250_console_setup(port, options, true);

I just noticed that this is a newcon->match() callback. It does:

  + univ8250_console_match()
    + serial8250_console_setup(port, options, true)   // @probe == true
      + probe_baud(port)

which manipulates the serial port.

We should call also the con->match() callback under console_lock()
in try_enable_preferred_console() like we do with con->setup,
see the commit 801410b26a0e8 ("serial: Lock console when calling into
driver before registration").

Maybe, we should just take console_lock() in register_console()
around these try_enable_*() calls.

Well, this is for a separated patch or separate patchset.

>  	}
>  
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -282,6 +282,25 @@ struct nbcon_write_context {
>  	bool			unsafe_takeover;
>  };
>  
> +/**
> + * struct nbcon_drvdata - Data to allow nbcon acquire in non-print context
> + * @ctxt:		The core console context
> + * @srcu_cookie:	Storage for a console_srcu_lock cookie, if needed
> + * @owner_index:	Storage for the owning console index, if needed
> + * @locked:		Storage for the locked state, if needed
> + *
> + * All fields (except for @ctxt) are available exclusively to the driver to
> + * use as needed. They are not used by the printk subsystem.
> + */
> +struct nbcon_drvdata {
> +	struct nbcon_context	__private ctxt;
> +
> +	/* reserved for driver use */
> +	int			srcu_cookie;
> +	short			owner_index;
> +	bool			locked;
> +};
> +
>  /**
>   * struct console - The console descriptor structure
>   * @name:		The name of the console driver
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -606,6 +609,83 @@ static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned
>  	spin_unlock_irqrestore(&up->lock, flags);
>  }
>  
> +/**
> + * uart_port_set_cons - Safely set the @cons field for a uart
> + * @up:		The uart port to set
> + * @con:	The new console to set to
> + *
> + * This function must be used to set @up->cons. It uses the port lock to
> + * synchronize with the port lock wrappers in order to ensure that the console
> + * cannot change or disappear while another context is holding the port lock.
> + */
> +static inline void uart_port_set_cons(struct uart_port *up, struct console *con)
> +{
> +	unsigned long flags;
> +
> +	__uart_port_lock_irqsave(up, &flags);
> +	up->cons = con;
> +	__uart_port_unlock_irqrestore(up, flags);
> +}
> +
> +/* Only for internal port lock wrapper usage. */
> +static inline void __uart_port_nbcon_acquire(struct uart_port *up)
> +{
> +	lockdep_assert_held_once(&up->lock);
> +
> +	if (likely(!uart_console(up)))
> +		return;
> +
> +	if (up->cons->nbcon_drvdata) {
> +		/*
> +		 * If @up->cons is registered, prevent it from fully
> +		 * unregistering until this context releases the nbcon.
> +		 */
> +		int cookie = console_srcu_read_lock();

[ later update: maybe skip 30 lines and read the "Hum, ho" part first]
[ even later update: or skip 60 lines and read "Win win" part first.]

OK, this makes sense. But I feel like we are in a lock cycle.
This code is called under "up->lock()". It will be taken also by
the newcon->device_lock() in register_console() so we would have:

  + register_console()
    + console_list_lock()   // serializes SRCU access to console list.
      + con->device_lock()
	+spin_lock(&up->lock)

  => console_list_lock -> up->lock

and here

  + uart_port_lock()
    + spin_lock(&up->lock)
     + __uart_port_nbcon_acquire()
       + console_srcu_read_lock()   // SRCU read lock serialized by console_list_lock

  => up->lock -> SRCU read lock serialized by console_list_lock

and for completeness:

  + unregister_console()
    + console_list_lock()
      + unregister_console_locked()
	+ synchronize_srcu(&console_srcu);


OK, it works because because scru_read_lock() is not blocking.
The synchronize_srcu() is called under console_list_lock(). So that
the only important thing is not taking console_list_lock() under
console_srcu_read_lock().


Hum, ho, it took me some time to create a mental model around this.
It is not that complicated after all:

    + console_list_lock(): serializes the entire (un)register console
	console operation. Well, it primary serializes
	the console_list manipulation, including up->cons->node
	which is tested below.

    + console_lock():  serializes emitting messages on legacy and
	boot consoles

    + con->device_lock aka port->lock: serializes more actions:

	1. any non-printk related access to the device (HW) like
	   a generic read/write.

	2. Access to the device by con->write() for legacy consoles.

	3. console registration, in particular console_list
	   manipulation, including up->cons->node. It is needed
	   to avoid races when the non-printk code has to decide
	   whether it needs to get serialized against nbcon
	   consoles or not.

	  For example, it should prevent races in
	   __uart_port_nbcon_acquire(up) and
	   __uart_port_nbcon_release(up) which are added in this patch.

But wait, we take con->device_lock() only in register_console().

Is this correct?

IMHO, it is a bug. We should (must) take con->device_lock()
also in unregister_console() when manipulating the
console_list and up->cons->node. Otherwise, uart_console(up)
would provide racy results.


Win win situation:

    If we take con->device_lock() in unregister_console() around
    console_list manipulation then the console could never
    disappear or be assigned to another port when both:

       uart_console(up) && hlist_unhashed_lockless(&up->cons->node)

    are "true"

    => we would not need to take console_scru_read_lock() here
    => we would not need to store/check up->line

    Heh, we even would not need "bool locked" because

       uart_console(up) && hlist_unhashed_lockless(&up->cons->node)

    would always return the same even in  __uart_port_nbcon_release()

    => easier code, straight serialization rules, no races.


> +
> +		/* Ensure console is registered and is an nbcon console. */
> +		if (!hlist_unhashed_lockless(&up->cons->node) &&
> +		    (console_srcu_read_flags(up->cons) & CON_NBCON)) {
> +			WARN_ON_ONCE(up->cons->nbcon_drvdata->locked);
> +
> +			nbcon_driver_acquire(up->cons);
> +
> +			/*
> +			 * Record @up->line to be used during release because
> +			 * @up->cons->index can change while the port and
> +			 * nbcon are locked.
> +			 */
> +			up->cons->nbcon_drvdata->owner_index = up->line;
> +			up->cons->nbcon_drvdata->srcu_cookie = cookie;
> +			up->cons->nbcon_drvdata->locked = true;
> +		} else {
> +			console_srcu_read_unlock(cookie);
> +		}
> +	}
> +}
> +
> +/* Only for internal port lock wrapper usage. */
> +static inline void __uart_port_nbcon_release(struct uart_port *up)
> +{
> +	lockdep_assert_held_once(&up->lock);
> +
> +	/*
> +	 * uart_console() cannot be used here because @up->cons->index might
> +	 * have changed. Check against @up->cons->nbcon_drvdata->owner_index
> +	 * instead.
> +	 */
> +
> +	if (unlikely(up->cons &&
> +		     up->cons->nbcon_drvdata &&
> +		     up->cons->nbcon_drvdata->locked &&
> +		     up->cons->nbcon_drvdata->owner_index == up->line)) {
> +		WARN_ON_ONCE(!up->cons->nbcon_drvdata->locked);

The WARN_ON_ONCE() would never trigger because
"up->cons->nbcon_drvdata->locked" is checked by the above
if-condition.

I hope that we would replace this by the same checks as in acquire()
part as proposed above.


> +
> +		up->cons->nbcon_drvdata->locked = false;
> +		nbcon_driver_release(up->cons);
> +		console_srcu_read_unlock(up->cons->nbcon_drvdata->srcu_cookie);
> +	}
> +}
> +
>  /**
>   * uart_port_lock - Lock the UART port
>   * @up:		Pointer to UART port structure
> @@ -654,7 +741,11 @@ static inline bool uart_port_trylock(struct uart_port *up)
>   */
>  static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long *flags)
>  {
> -	return spin_trylock_irqsave(&up->lock, *flags);
> +	if (!spin_trylock_irqsave(&up->lock, *flags))
> +		return false;
> +
> +	__uart_port_nbcon_acquire(up);

I would feel more comfortable if we created
__uart_port_nbcon_try_acquire(up). It would give up when it could
not acquire the context in the given timeout.

It would by similar to acquire(). The only difference would be that
it would return false on failure. And it would call:

/**
 * nbcon_driver_try_acquire - Try acquire nbcon console and enter unsafe section
 * @con:	The nbcon console to acquire
 *
 * Context:	Any context which could not be migrated to another CPU.
 *
 * Console drivers will usually use their own internal synchronization
 * mechanism to synchronize between console printing and non-printing
 * activities (such as setting baud rates). However, nbcon console drivers
 * supporting atomic consoles may also want to mark unsafe sections when
 * performing non-printing activities.
 *
 * This function tries to acquires the nbcon console using priority
 * NBCON_PRIO_NORMAL and marks it unsafe for handover/takeover.
 *
 * Return: true on success, false when it was not able to acquire the
 *	console and set it "usafe" for a takeover.
 */
bool nbcon_driver_try_acquire(struct console *con)
{
	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con->nbcon_drvdata, ctxt);

	cant_migrate();

	memset(ctxt, 0, sizeof(*ctxt));
	ctxt->console	= con;
	ctxt->prio	= NBCON_PRIO_NORMAL;

	if (!nbcon_context_try_acquire(ctxt))
		return false;

	if (!nbcon_context_enter_unsafe(ctxt))
		return false;
}

It is probably not that important because it should not block emitting
the emergency or panic messages. They would use NBCON_PRIO_EMERGENCY
or NBCON_PRIO_PANIC in the important code paths.

But it looks semantically wrong to use a potentially blocking function
in a try_lock() API. IMHO, it would be a call for troubles.

> +	return true;
>  }
>  
>  /**
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 2516449f921d..38328cf0fd5c 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -988,3 +991,52 @@ void nbcon_free(struct console *con)
>  
>  	con->pbufs = NULL;
>  }
> +
> +/**
> + * nbcon_driver_acquire - Acquire nbcon console and enter unsafe section
> + * @con:	The nbcon console to acquire
> + *
> + * Context:	Any context which could not be migrated to another CPU.
> + *
> + * Console drivers will usually use their own internal synchronization
> + * mechasism to synchronize between console printing and non-printing
> + * activities (such as setting baud rates). However, nbcon console drivers
> + * supporting atomic consoles may also want to mark unsafe sections when
> + * performing non-printing activities.
> + *
> + * This function acquires the nbcon console using priority NBCON_PRIO_NORMAL
> + * and marks it unsafe for handover/takeover.
> + *
> + * Console drivers using this function must have provided @nbcon_drvdata in
> + * their struct console, which is used to track ownership and state
> + * information.
> + */
> +void nbcon_driver_acquire(struct console *con)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con->nbcon_drvdata, ctxt);

Hmm, we need to store somewhere the "struct nbcon_context" for this
generic purpose. If we agreed to remove struct nbcon_drvdata then
I would store it in struct console as

struct console {
[...]
	/**
	 * @device_nbcon_context:
	 *
	 * nbcon_context used to serialize non-printing operations on
	 * the same device.
	 *
	 * The device drivers synchronize these operations with a driver-specific
	 * lock, such as port->lock in the serial consoles. When the
	 * device is registered as a console, they additionally have to acquire
	 * this nbcon context to get serialized against the atomic_write()
	 * callback using the same device.
	 *
	 * The struct does not require any special initialization.
	 */
	struct nbcon_context	driver_nbcon_context;
[...]
	};

It will be unused for legacy consoles. But the plan is convert all
console drivers anyway.

IMHO, passing it via an optional pointer is not worth the complexity.

> +
> +	cant_migrate();
> +
> +	do {
> +		do {
> +			memset(ctxt, 0, sizeof(*ctxt));
> +			ctxt->console	= con;
> +			ctxt->prio	= NBCON_PRIO_NORMAL;
> +		} while (!nbcon_context_try_acquire(ctxt));
> +
> +	} while (!nbcon_context_enter_unsafe(ctxt));
> +}
> +EXPORT_SYMBOL_GPL(nbcon_driver_acquire);

Best Regards,
Petr
