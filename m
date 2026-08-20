Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420346C853;
	Thu, 20 Aug 2026 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787233200; cv=none; b=O96JjND8v4QraGHN1B8nbAmT+BhdsaaBmei4e5tjQd+wnr0wI3tad3no1bnVbINK+30dCKLm2DcwFvbrOinuzk7xvbclFDKj0UwwvNfPtgZnKKnnP5k81QtyX6REerCF2RQYOgqOqLyK84bSV6O7RXqVry3tCMgjwlsKsApMLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787233200; c=relaxed/simple;
	bh=daeYGy14rKITC6G79A9qYOEx4bXUYjnsup6+r1UjS2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MPfSZ1pAUBdQZ5lOrCraY0XGZRaYIPLyfeZss/fD/WRfKSsVcERJZD4ZwN9SPQvrMbPpLv6xCrTmmYcdap/ZCxh3ZlUgCjeyyqdCkkPMtEfS4xiBIf3IBZGA7ujdxL4YPGHbPW8cRVmy1jBnO2nILSarloNE6ap65DyNK7Aesf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CwK4fgsz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jsvg3V4C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CwK4fgsz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jsvg3V4C"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787233191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDs/8kNp+hulh+5oTqnISdWGjTNx4R4z0gDsI6z1/RU=;
	b=CwK4fgsz2C2H1o4SOf7VGETj7tOk5/IMSOAMRMhnhuNpqcId+wvd5x5UP/f9iPynQU+Oxk
	bi3c8F6ItV9lP/3lk9wwnbGD+54Dq2k8H9hERjKVjn1MtVdri9iSbX8hzp+cRF7aTKdYvj
	BmqfkZ8oiMhhnEEmylRLX2HBEPmPdWUkZlkNg4Ru7f5vsrACJPzCI7XjuImkXfg88iwNku
	SnU2BTeQTOt8TUf8Oj/neu1BD7FtWpAt/gPz0mm0cz8/PfS+gsnG+Re5T+tVQH9Cn1Tdus
	29wNpW29PG1IuJunyKhnqJHtp/HVw4N8t5Md8fu44TzI4JBSBMxZlzeVdLikTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787233191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDs/8kNp+hulh+5oTqnISdWGjTNx4R4z0gDsI6z1/RU=;
	b=jsvg3V4C9BMvUuPklm0X4mGGUAOt2oPhAZwuYxpSv9RcehPVKbzrKUQNbenvIlrZ+ZQFYm
	CbOSwBjNmX5DhsCg==
To: Petr Mladek <pmladek@suse.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>, linux-m68k@vger.kernel.org,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] m68k: nfcon: don't call console_is_registered in
 nfcon_device
In-Reply-To: <aob5oO_7qxII_qTB@pathway.suse.cz>
References: <87ecfzsv6h.fsf@igel.home>
 <CAMuHMdU4C+W6Tpsn3Vr_kqmuU2Vzg7ExXhspmB5qNWMZ3Wnfeg@mail.gmail.com>
 <aob5oO_7qxII_qTB@pathway.suse.cz>
Date: Thu, 20 Aug 2026 15:44:34 +0206
Message-ID: <874igoap45.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-08-20, Petr Mladek <pmladek@suse.com> wrote:
>> > --- a/arch/m68k/emu/nfcon.c
>> > +++ b/arch/m68k/emu/nfcon.c
>> > @@ -49,7 +49,7 @@ static void nfcon_write(struct console *con, const char *str,
>> >  static struct tty_driver *nfcon_device(struct console *con, int *index)
>> >  {
>> >         *index = 0;
>> > -       return console_is_registered(con) ? nfcon_tty_driver : NULL;
>> 
>> Interestingly, that call to console_is_registered() was added in
>> commit de61a1a3a0830710 ("tty: nfcon: use console_is_registered()"),
>> i.e. in the same series that added the extra locking...
>
> Sigh, we clearly did not check the callers of this function properly
> at that time :/
>
>> > +       return nfcon_tty_driver;
>
> Honestly, I do not feel comfortable with removing the check
> completely.
>
> The commit de61a1a3a083071 ("tty: nfcon: use console_is_registered()"
> used console_is_registered() instead of (con->flags & CON_ENABLED).
> And CON_ENABLED is historically cleared when the console is suspended,
> see console_suspend().

Since the NatFeat console driver never implemented suspend/resume
callbacks, I assume it was intended to identify if the console was
registered.

> Is is OK to return a valid struct tty_driver for a non-registered
> or suspended console for all con->device() callers?
>
> I have found only 4 callers:
>
>   $> git grep "\->device("
>   drivers/tty/serial/kgdboc.c:            if (cons->device && cons->device(cons, &idx) == p &&
>   drivers/tty/tty_io.c:           struct tty_driver *drv = cs[i]->device(cs[i], &index);
>   fs/proc/consoles.c:             driver = con->device(con, &index);
>   kernel/printk/printk.c:         driver = c->device(c, index);
>
> These are:
>
>   + configure_kgdboc() in drivers/tty/serial/kgdboc.c
>   + show_cons_active() in drivers/tty/tty_io.c
>   + show_console_dev() in fs/proc/consoles.c
>   + console_device() in kernel/printk/printk.c
>
> , where
>
>   + configure_kgdboc() is used during the system initialization
>     when the console should not be suspended
>
>   + show_cons_active() and show_console_dev() are questionable.
>     Maybe, we should not advertise the device to the userspace
>     when it is suspended.
>
>   + console_device() is used in tty_kopen() -> tty_lookup_driver().
>     Also here we likely should not allow to open a suspended device.

All of these callbacks are done when the console is guaranteed to be
registered (or not yet fully unregistered).

> Let's take a step back:
>
> We should define the locking context for con->device() callback.
> It seems that it is called under console_lock() and
> console_srcu_read_lock() in:
>
>   + configure_kgdboc()
>   + console_device()
>
> and under console_list_lock() and console_lock() in
>
>   + show_console_dev()
>   + show_cons_active()
>
> I would put aside the console_lock(). We are trying to obsolete it.
> So it is down to
>
>    console_srcu_read_lock() vs console_list_lock()
>
> Both of them look reasonable. So, I think about adding a variant
> of console_is_registered_srcu_read_locked() which would work
> with both locking. Something like:
>
> diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
> index d41260672e24..d211b6c4da26 100644
> --- a/arch/m68k/emu/nfcon.c
> +++ b/arch/m68k/emu/nfcon.c
> @@ -49,7 +49,7 @@ static void nfcon_write(struct console *con, const char *str,
>  static struct tty_driver *nfcon_device(struct console *con, int *index)
>  {
>  	*index = 0;
> -	return console_is_registered(con) ? nfcon_tty_driver : NULL;
> +	return console_is_registered_srcu_read_locked(con) ? nfcon_tty_driver : NULL;
>  }
>  
>  static struct console nf_console = {
> diff --git a/include/linux/console.h b/include/linux/console.h
> index d624200cfc17..b90527db4eca 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -311,7 +311,7 @@ struct nbcon_write_context {
>   * @name:		The name of the console driver
>   * @write:		Legacy write callback to output messages (Optional)
>   * @read:		Read callback for console input (Optional)
> - * @device:		The underlying TTY device driver (Optional)
> + * @device:		The underlying TTY device driver (Optional) [1]
>   * @unblank:		Callback to unblank the console (Optional)
>   * @setup:		Callback for initializing the console (Optional)
>   * @exit:		Callback for teardown of the console (Optional)
> @@ -334,6 +334,9 @@ struct nbcon_write_context {
>   * @kthread:		Printer kthread for this console
>   * @rcuwait:		RCU-safe wait object for @kthread waking
>   * @irq_work:		Defer @kthread waking to IRQ work context
> + *
> + * [1] The @device callback must be called under either console_list_lock()
> + *     or console_srcu_read_lock().
>   */
>  struct console {
>  	char			name[16];
> @@ -473,8 +476,13 @@ struct console {
>  };
>  
>  #ifdef CONFIG_LOCKDEP
> +extern bool console_list_lock_is_held(void);
>  extern void lockdep_assert_console_list_lock_held(void);
>  #else
> +static inline bool console_list_lock_is_held(void)
> +{
> +	return 1;
> +}
>  static inline void lockdep_assert_console_list_lock_held(void)
>  {
>  }
> @@ -555,6 +563,16 @@ static inline bool console_is_registered_locked(const struct console *con)
>  	return !hlist_unhashed(&con->node);
>  }
>  
> +/*
> + * Variant of console_is_registered() when either the console_srcu_read_lock
> + * or console_list_lock is held.
> +*/
> +static inline bool console_is_registered_srcu_read_locked(const struct console *con)
> +{
> +	lockdep_assert(console_srcu_read_lock_is_held() || console_list_lock_is_held());
> +	return !hlist_unhashed(&con->node);
> +}
> +
>  /*
>   * console_is_registered - Check if the console is registered
>   * @con:	struct console pointer of console to check
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2fe9a963c823..9b632b91f096 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -109,6 +109,12 @@ static struct lockdep_map console_lock_dep_map = {
>  	.name = "console_lock"
>  };
>  
> +bool console_list_lock_is_held(void)
> +{
> +	return lockdep_is_held(&console_mutex);
> +}
> +EXPORT_SYMBOL(console_list_lock_is_held);
> +
>  void lockdep_assert_console_list_lock_held(void)
>  {
>  	lockdep_assert_held(&console_mutex);
>
>
> Alternative solution would be to require the srcu locking.
> IMHO, it should be perfectly fine to use the srcu_read_lock in
> both show_console_dev() and show_cons_active().
>
> What do you think, please?
> John?

I do not think any of that is necessary. I think it is enough to allow
the ->device() callback to assume it is registered. I see no reason why
the _callback_ should ever need to take the console_list_lock or the
console_srcu_read_lock.

John
