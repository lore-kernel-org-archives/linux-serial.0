Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15145D5DB
	for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241443; cv=none; b=np0SnKxQypcn0EQSR1a+6R4hWp+sSZwSOH2aT1oPrFoHpVSxe4UoCcvZag/iOIn4UHVB9vKOLq+ZyNzhVF6jvEz3W74COSzAXa+Ls+nGq/10aMjqIUAD2vv+c7YPkIaMWBk79yizpZwZBtt9XqsBBEhwccsacJdXnFJSXCwfmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241443; c=relaxed/simple;
	bh=Omgeh++36r5FzNu0QTWKwx3ug1Da8sx0Wm/UFkVgBn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLYbJ0bQ6F7k7ah4VBsKNQ8C4/QNlF86+3MJke3S6KoetW8vFMla6iydst5sNjNmSQ2EkP++tN1MnnWp3OenQzYD8nPFWYulW12h7+PzLSOnoZIFsWY12BjOTmk+NdrFQGUokLuSylkVet6BLGRdEVBxzom6sbr+3azca5fvhzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TbVQh9UW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TbVQh9UW"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f6609c657so32705f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2026 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787241439; x=1787846239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bEGGRctuk3jxpffNjzwGMa/ipJqCPuiOj7uzHDEaJPc=;
        b=TbVQh9UWeox+YlG3dFTD6kSiUQbjWOlvOgoqZEiucTQx8e5uQpMQB2TdwhFMRaOTTZ
         zfwy99cKHAXtjl0kiIHd2Cf91gVzF1lqf3+0qFGdPXjt8sqfWa+F5uEShq0mxr5Av4qV
         h5tLX/O8+1VQ9s+ixFrSh45qyubLma0NgsKQ0w8DAFrfxjbdU8bHl3CrJkUOTckz6HTV
         9cg63c/h6ZMhyGbfotAsLdPd0YMWbNjq4GGeackFVPo7/75kYV8Lck+knT31Mj6ymkJb
         O9W/+fqdoUKAbmrgVgG2/8rZWBWorWcS8Uc1AIyTijZOr39jfvm3hwyZsmf3Cv2ACLLA
         Bt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241439; x=1787846239;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bEGGRctuk3jxpffNjzwGMa/ipJqCPuiOj7uzHDEaJPc=;
        b=EnKyfb4H7wohLnkJ43lKhw5d4kVOBne+9lXW4kyjxtESUcsLYcO6BqeW7vINlslXQV
         42AW7zEe44iLrsk7d1jb07vHchvxsBUayWK0QGGLAZ089iOlWvxLq54yvE1h1qVzKaMs
         yTtYpB2Sb/1ItBwZQmI7OenH0qKyzl41MIe/s2axibvSj8sBeU/3SFSO0UF5QFUo7L3n
         OkY8AQpRoeU30TiRTZ8uJevn4n/4ZHiSRV/gvEyRePZRUxO9QNnmXwEmSGHk2kQmhemR
         sdVeez3xb5urvyY9FjzZzu7f5XUxsBmNxQvF9YLwQMb41Z+/EOe72k5tyTrN/qtWJwFs
         iELg==
X-Forwarded-Encrypted: i=1; AHgh+RpTL8mr92+TGQxAa0C9B765az3wnLwPCoeT1jPxXS2kmtDRxI+e18HqNc1CzfYfR4Wbj1YSLSgZJa86n24=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMxMet0w0WgAxQ71prD3tTdRjsjMdtI7LfU6nbMV+xsf3z84J
	D6s91+QtujF+kRQ4XXBPpcUFmrkP3VzZsM3k6lJsuSx6IoSeJaaieAYW6cyFUdduG1I=
X-Gm-Gg: AR+sD11sQ7BBPTHAno/nHVbzRaPXbloWPbiMCOP2q7N22sNAgi118/7Llb+6ont1Bnk
	fFQC6vAmT032F9nJoJefQ6o2nEQmFEJ7Q2k4Ts+me4UbTpexekBfu258qnoTYe8MZ709nEnpBJn
	pGHYwtb9m3LPtSp9wuC3jRy0SlAb8JjV1xWlw8ZMfxjEaodynz/Z3MlCiBvy0mFFoWCVbD8fQLS
	bZWCFItTMfbW6n2bGaG52u8CSXe5SOj8r1nzbPYy7DabGL8F6mnDBnwRoEf40isiw/a4KHEFf4Z
	UR77X5n5zFSB73s7l592grGLTiN3cZmosa/yxtxvOZigQYW1URwCo7rVAL06em76tjZOZjqu+3l
	DuG4UGH3TFy+xY06DXVAWg4zRD9RP1TcgWlKlYCjqO1mDslwD0l9PrK193Ucl9z51ricVEvi/n8
	KjogtiVeAt2pdJkTqhtuODjz73hAsmpRIGnQCto7j5kpxoL/4RwTdBMA7j42LFrA==
X-Received: by 2002:a05:600c:8b62:b0:499:a6ae:20a1 with SMTP id 5b1f17b1804b1-499aa1dc5b6mr266379765e9.14.1787241438992;
        Thu, 20 Aug 2026 08:57:18 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b7193b23sm2569205e9.12.2026.08.20.08.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:57:18 -0700 (PDT)
Date: Thu, 20 Aug 2026 17:57:16 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andreas Schwab <schwab@linux-m68k.org>, linux-m68k@vger.kernel.org,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] m68k: nfcon: don't call console_is_registered in
 nfcon_device
Message-ID: <aocj3HO9uxmarq7A@pathway.suse.cz>
References: <87ecfzsv6h.fsf@igel.home>
 <CAMuHMdU4C+W6Tpsn3Vr_kqmuU2Vzg7ExXhspmB5qNWMZ3Wnfeg@mail.gmail.com>
 <aob5oO_7qxII_qTB@pathway.suse.cz>
 <874igoap45.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874igoap45.fsf@jogness.linutronix.de>

On Thu 2026-08-20 15:44:34, John Ogness wrote:
> On 2026-08-20, Petr Mladek <pmladek@suse.com> wrote:
> >> > --- a/arch/m68k/emu/nfcon.c
> >> > +++ b/arch/m68k/emu/nfcon.c
> >> > @@ -49,7 +49,7 @@ static void nfcon_write(struct console *con, const char *str,
> >> >  static struct tty_driver *nfcon_device(struct console *con, int *index)
> >> >  {
> >> >         *index = 0;
> >> > -       return console_is_registered(con) ? nfcon_tty_driver : NULL;
> >> 
> >> Interestingly, that call to console_is_registered() was added in
> >> commit de61a1a3a0830710 ("tty: nfcon: use console_is_registered()"),
> >> i.e. in the same series that added the extra locking...
> >
> > Sigh, we clearly did not check the callers of this function properly
> > at that time :/
> >
> >> > +       return nfcon_tty_driver;
> >
> > Honestly, I do not feel comfortable with removing the check
> > completely.
> >
> > The commit de61a1a3a083071 ("tty: nfcon: use console_is_registered()"
> > used console_is_registered() instead of (con->flags & CON_ENABLED).
> > And CON_ENABLED is historically cleared when the console is suspended,
> > see console_suspend().
> 
> Since the NatFeat console driver never implemented suspend/resume
> callbacks, I assume it was intended to identify if the console was
> registered.

Good point!

> > Is is OK to return a valid struct tty_driver for a non-registered
> > or suspended console for all con->device() callers?
> >
> > I have found only 4 callers:
> >
> >   $> git grep "\->device("
> >   drivers/tty/serial/kgdboc.c:            if (cons->device && cons->device(cons, &idx) == p &&
> >   drivers/tty/tty_io.c:           struct tty_driver *drv = cs[i]->device(cs[i], &index);
> >   fs/proc/consoles.c:             driver = con->device(con, &index);
> >   kernel/printk/printk.c:         driver = c->device(c, index);
> >
> > These are:
> >
> >   + configure_kgdboc() in drivers/tty/serial/kgdboc.c
> >   + show_cons_active() in drivers/tty/tty_io.c
> >   + show_console_dev() in fs/proc/consoles.c
> >   + console_device() in kernel/printk/printk.c
> >
> > , where
> >
> >   + configure_kgdboc() is used during the system initialization
> >     when the console should not be suspended
> >
> >   + show_cons_active() and show_console_dev() are questionable.
> >     Maybe, we should not advertise the device to the userspace
> >     when it is suspended.
> >
> >   + console_device() is used in tty_kopen() -> tty_lookup_driver().
> >     Also here we likely should not allow to open a suspended device.
> 
> All of these callbacks are done when the console is guaranteed to be
> registered (or not yet fully unregistered).

Ditto.

> > Let's take a step back:
> >
> > We should define the locking context for con->device() callback.
> > It seems that it is called under console_lock() and
> > console_srcu_read_lock() in:
> >
> >   + configure_kgdboc()
> >   + console_device()
> >
> > and under console_list_lock() and console_lock() in
> >
> >   + show_console_dev()
> >   + show_cons_active()
> >
> > I would put aside the console_lock(). We are trying to obsolete it.
> > So it is down to
> >
> >    console_srcu_read_lock() vs console_list_lock()
> >
> > Both of them look reasonable. So, I think about adding a variant
> > of console_is_registered_srcu_read_locked() which would work
> > with both locking. Something like:
> >
> > diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
> > index d41260672e24..d211b6c4da26 100644
> > --- a/arch/m68k/emu/nfcon.c
> > +++ b/arch/m68k/emu/nfcon.c
> > @@ -49,7 +49,7 @@ static void nfcon_write(struct console *con, const char *str,
> >  static struct tty_driver *nfcon_device(struct console *con, int *index)
> >  {
> >  	*index = 0;
> > -	return console_is_registered(con) ? nfcon_tty_driver : NULL;
> > +	return console_is_registered_srcu_read_locked(con) ? nfcon_tty_driver : NULL;
> >  }
> >  
> >  static struct console nf_console = {
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index d624200cfc17..b90527db4eca 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -311,7 +311,7 @@ struct nbcon_write_context {
> >   * @name:		The name of the console driver
> >   * @write:		Legacy write callback to output messages (Optional)
> >   * @read:		Read callback for console input (Optional)
> > - * @device:		The underlying TTY device driver (Optional)
> > + * @device:		The underlying TTY device driver (Optional) [1]
> >   * @unblank:		Callback to unblank the console (Optional)
> >   * @setup:		Callback for initializing the console (Optional)
> >   * @exit:		Callback for teardown of the console (Optional)
> > @@ -334,6 +334,9 @@ struct nbcon_write_context {
> >   * @kthread:		Printer kthread for this console
> >   * @rcuwait:		RCU-safe wait object for @kthread waking
> >   * @irq_work:		Defer @kthread waking to IRQ work context
> > + *
> > + * [1] The @device callback must be called under either console_list_lock()
> > + *     or console_srcu_read_lock().
> >   */
> >  struct console {
> >  	char			name[16];
> > @@ -473,8 +476,13 @@ struct console {
> >  };
> >  
> >  #ifdef CONFIG_LOCKDEP
> > +extern bool console_list_lock_is_held(void);
> >  extern void lockdep_assert_console_list_lock_held(void);
> >  #else
> > +static inline bool console_list_lock_is_held(void)
> > +{
> > +	return 1;
> > +}
> >  static inline void lockdep_assert_console_list_lock_held(void)
> >  {
> >  }
> > @@ -555,6 +563,16 @@ static inline bool console_is_registered_locked(const struct console *con)
> >  	return !hlist_unhashed(&con->node);
> >  }
> >  
> > +/*
> > + * Variant of console_is_registered() when either the console_srcu_read_lock
> > + * or console_list_lock is held.
> > +*/
> > +static inline bool console_is_registered_srcu_read_locked(const struct console *con)
> > +{
> > +	lockdep_assert(console_srcu_read_lock_is_held() || console_list_lock_is_held());
> > +	return !hlist_unhashed(&con->node);
> > +}
> > +
> >  /*
> >   * console_is_registered - Check if the console is registered
> >   * @con:	struct console pointer of console to check
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 2fe9a963c823..9b632b91f096 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -109,6 +109,12 @@ static struct lockdep_map console_lock_dep_map = {
> >  	.name = "console_lock"
> >  };
> >  
> > +bool console_list_lock_is_held(void)
> > +{
> > +	return lockdep_is_held(&console_mutex);
> > +}
> > +EXPORT_SYMBOL(console_list_lock_is_held);
> > +
> >  void lockdep_assert_console_list_lock_held(void)
> >  {
> >  	lockdep_assert_held(&console_mutex);
> >
> >
> > Alternative solution would be to require the srcu locking.
> > IMHO, it should be perfectly fine to use the srcu_read_lock in
> > both show_console_dev() and show_cons_active().
> >
> > What do you think, please?
> > John?
> 
> I do not think any of that is necessary. I think it is enough to allow
> the ->device() callback to assume it is registered. I see no reason why
> the _callback_ should ever need to take the console_list_lock or the
> console_srcu_read_lock.

Fair enough. I see that other con->device() callbacks just return
the pointer without checking anything.

So, the fix looks good after all.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
