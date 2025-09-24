Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016F2264DB;
	Wed, 24 Sep 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717738; cv=none; b=h8KTz6nhgJRfpy79B9KRdyduGy38+iLbaYLz+RCYbG/9F7LWOycOQNoa+fRzPKbMCzuPUxDgLUZgsXrl+RIek0ey0YbpFrADQ8kyrWf+ojjPDw/u36AvtXE1yIBpQtLIrglAXAcCeGxBNS8Hw64X4gZq7A48Ss6re5AlBg7KERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717738; c=relaxed/simple;
	bh=oaHbMoaSPr9HTbcItgMbrRvyXc13gg09CsrhW7KFaCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VGIkMQZPK5mU18FsZL7n39svloqSGZpk1O4jBUy9H/7HM6pvIEwdaXIsqKfhNQWBjNPjUKqy/lNr2KLRz2PicRwmEwUssx+FGnTQJHsB6Y2C6lgf4f7kpENPciXee639L5LQ2LC18mM2JWob3nc99kXAz9UCKH2ZHZmrUApMm1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SCiEJbyt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JITaLJKu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SCiEJbyt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JITaLJKu"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758717733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=onVcQ+okw6vCqSFiba0985cgTYFFho3jxFgbYYVMkqM=;
	b=SCiEJbyt8doV02RBjEjOIqldxGEeOzDUIgO+mkZMy0VdJxUhFAJt7Z+WiaF9dYc9tPTAtb
	kTWuVlmbZIsGePvdEWpTHU366dWWRXoZIuOqdWy/N/+s9wvKmluP8/KYqGQ+VcEfVgHodp
	9cbpwpJdgmAp/td9VMQJMuNHY86VSNXcumoDW/ZMEDnLKBVBaUorJKc72dYO2YUlpaRZCw
	hie/VijFhjpD8nwhIHDw4bLydwg2tqR1hIp5WFPWLD9oWj8IOkxqiy1o9x7GD0/pZzrpWU
	hwZxGBU5UOPAJroj1FV6knfLp/Sj5VKAe0Xr6YC2uVRI7hPvITK095enZIf6aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758717733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=onVcQ+okw6vCqSFiba0985cgTYFFho3jxFgbYYVMkqM=;
	b=JITaLJKue6vOs6t+lmvKug3uj7LMnimT8APzlAIBEdPCc8cPcPezx+U3RloV6T7ib/pf6X
	eFULMuMezdZToEDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [RFC 0/1] serial: 8250: nbcon_atomic_flush_pending() might
 trigger watchdog warnigns
In-Reply-To: <aNO7Qjv_iSUSifTv@pathway.suse.cz>
References: <20250822142502.69917-1-pmladek@suse.com>
 <84qzwzbr90.fsf@jogness.linutronix.de> <aNFR45fL2L4PavNc@pathway.suse.cz>
 <84348eju8a.fsf@jogness.linutronix.de> <aNO7Qjv_iSUSifTv@pathway.suse.cz>
Date: Wed, 24 Sep 2025 14:48:12 +0206
Message-ID: <84348crpi3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-24, Petr Mladek <pmladek@suse.com> wrote:
> I tried to implement some naive solution, see below. I think that
> it can be described as the 2nd layer of ownership.
>
> It does not look that complicated. It might be because I used it only
> in two paths which do the writing. And it is possible that it does
> not work properly.

It is an interesting approach and is one that I tend to prefer.

> Then I got another idea. It might even easier.
>
> I think that it might actually be enough to block the kthread when
> any CPU is in emergency context, for example, by using a global
> atomit counter.

This is the quick idea that usually comes first. Basically introducing
an emergency_in_progress() to keep the kthreads out. My problem with
this is that it causes _all_ consoles to synchronize with each other,
which we worked hard to get away from. Yes, I realize Linus rejected the
"store the backtrace, then print it" implementation, which limits the
effectiveness of parallel printing. Nevertheless, I would prefer to work
towards returning to parallelization, rather than reducing it further.

> I am not sure if you already started working on it. I rather share
> my naive ideas early so that I do not duplicate the effort.
> It is possible that you have been there.

Thanks. Yes, I tried various ideas like this. But your version does go
about it differently. Although I am seeing the same problems. My
comments below.

> Anyway, here is POC of an API which blocks writing/flushing
> in a context with a lower priority:
>
> From 5d8f9c61c8f67096feca5972c5e7f751c8371b9f Mon Sep 17 00:00:00 2001
> From: Petr Mladek <pmladek@suse.com>
> Date: Wed, 24 Sep 2025 10:42:26 +0200
> Subject: [POC] printk/nbcon: Allow to release console context after each
>  record in atomic_flush
>
> It gives nbcon_reacquire_nobuf() to acquire the ownership to clean up
> the console after the interrupted write_thread() call and allow
> to preempt the printk kthread.
>
> Add an API to block writing/flushing messages in a context with
> lower priority. Otherwise, it would start flushing a pending
> message and get interrupted again by the higher priority context.
>
> The API is used in both code paths which try to acquire the nbcon
> console ownership and try to write a message using
> nbcon_emit_next_record().
>
> The priority field is set in nbcon unsafe context which
> prevents takeovers. The context must not clear it after
> loosing the console ownership.
>
> Failure to reserve the flush priority is handled the same way
> as a failure to get the context ownership. So, it might somehow
> work.
>
> Warning: This is just a POC. The code is not tested.
>
> FIXME: The clearing of the flush priority is racy. It might
>        clear a value set by another context when it was
>        cleared by a higher priority context in the mean
>        time.
>
>        There are ways to fix it.
>
>        But wait! It might be enough to synchronize normal vs. emergency
>        context. Non-panic context won't be able to get
>        the ownership anyway.
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/console.h |  2 +
>  kernel/printk/nbcon.c   | 86 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 8f10d0a85bb4..51750f92673f 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -326,6 +326,7 @@ struct nbcon_write_context {
>   * @nbcon_seq:		Sequence number of the next record for nbcon to print
>   * @nbcon_device_ctxt:	Context available for non-printing operations
>   * @nbcon_prev_seq:	Seq num the previous nbcon owner was assigned to print
> + * @nbcon_flush_prio:   Priority of a context flushing the console
>   * @pbufs:		Pointer to nbcon private buffer
>   * @kthread:		Printer kthread for this console
>   * @rcuwait:		RCU-safe wait object for @kthread waking
> @@ -461,6 +462,7 @@ struct console {
>  	atomic_long_t		__private nbcon_seq;
>  	struct nbcon_context	__private nbcon_device_ctxt;
>  	atomic_long_t           __private nbcon_prev_seq;
> +	enum nbcon_prio		__private nbcon_flush_prio;
>  
>  	struct printk_buffers	*pbufs;
>  	struct task_struct	*kthread;
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 646801813415..575b2628e0b2 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -911,6 +911,78 @@ bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
>  }
>  EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
>  
> +/**
> + * nbcon_context_get_flush_prio - Reserve writing by the given context priority
> + * @wctxt:	The write context which wants to write messages
> + *
> + * The function allows to reserve rights for emitting/flushing messages with
> + * the priority of the given context.
> + *
> + * It signalizes an intention to flush pending messages.
> + *
> + * The motivation is to allow releasing the nbcon console ownership after
> + * each emitted message and still block any context with a lower priority
> + * from flushing the pending messages. It prevents repeated interrupts
> + * of the lower priority context in the middle of the message.
> + *
> + * Return:	True when the write context might try to flush messages.
> + *		False when a context with a higher priority is flushing
> + *		messages.
> + *
> + * FIXME: Maybe, only the NORMAL vs. EMERGENCY context is interesting.
> + *	  Both these context will get blocked when there is a panic
> + *	  in progress,
> + *
> + * It might be enough to synchronize kthread vs. emergency_enter/exit API.
> + * Well, there is also the legacy kthread.
> + */
> +int nbcon_context_get_flush_prio(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +	ret = true;
> +
> +	if (!nbcon_context_try_acquire(ctxt, false))
> +		return false;
> +
> +	if (!nbcon_context_enter_unsafe(ctxt))
> +		return false;

Since a printer will want to do a console acquire right after setting
the flush_prio, it seems to me it would be better to require the caller
has already performed the console acquire. Then it does not need to give
it up in between. This enter_unsafe is enough to guarantee that this
context is still the owner.

> +
> +	if (con->nbcon_flush_prio <= ctxt->prio)
> +		con->nbcon_flush_prio = ctxt->prio;
> +	else
> +		ret = false;
> +
> +	if (!nbcon_context_exit_unsafe(ctxt))
> +		ret = false;
> +
> +	nbcon_context_release(ctxt);
> +
> +	return ret;
> +}
> +
> +void nbcon_context_put_flush_prio(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +	ret = 0;
> +
> +	if (!nbcon_context_try_acquire(ctxt, false))
> +		return -EPERM;

This is my main concern. If a context has set the flush_prio to
something higher, it _MUST_ set it back down later. This cannot be best
effort. A failed acquire does not mean that a context with the same
priority is the owner (for example, it could be a NORMAL context that is
in an unsafe section). Remember that there are owners that are not
printers.

So now we have a similar situation as nbcon_reacquire_nobuf(): we need
to regain ownership so that we can undo something we setup. And that is
the problem we are trying to solve in the first place. Maybe since this
moves the problem from NORMAL to EMERGENCY, the busy-waiting is
acceptable.

> +	if (!nbcon_context_enter_unsafe(ctxt))
> +		return -EAGAIN;
> +
> +	con->nbcon_flush_prio = NBCON_PRIO_NONE;
> +
> +	if (!nbcon_context_exit_unsafe(ctxt))
> +		ret = -EAGAIN;
> +
> +	nbcon_context_release(ctxt);
> +
> +	return ret;
> +}
> +
>  /**
>   * nbcon_reacquire_nobuf - Reacquire a console after losing ownership
>   *				while printing
> @@ -1120,6 +1192,8 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
>  		cant_migrate();
>  	}
>  
> +	if (!nbcon_context_get_flush_prio(wctxt))
> +		goto out;
>  	if (!nbcon_context_try_acquire(ctxt, false))
>  		goto out;

All "out paths" must restore the flush prio.

>  
> @@ -1135,6 +1209,7 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
>  		goto out;
>  
>  	nbcon_context_release(ctxt);
> +	nbcon_context_put_flush_prio(wctxt);
>  
>  	ret = ctxt->backlog;
>  out:
> @@ -1505,10 +1580,13 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
>  	ctxt->prio			= nbcon_get_default_prio();
>  	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
>  
> -	if (!nbcon_context_try_acquire(ctxt, false))
> +	if (!nbcon_context_get_flush_prio(&wctxt);
>  		return -EPERM;
>  
>  	while (nbcon_seq_read(con) < stop_seq) {
> +		if (!nbcon_context_try_acquire(ctxt, false))
> +			return -EPERM;
> +
>  		/*
>  		 * nbcon_emit_next_record() returns false when the console was
>  		 * handed over or taken over. In both cases the context is no
> @@ -1523,10 +1601,14 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
>  				err = -ENOENT;
>  			break;
>  		}
> +
> +		nbcon_context_release(ctxt);
>  	}
>  
> -	nbcon_context_release(ctxt);
> +	nbcon_context_put_flush_prio(&wctxt);
> +
>  	return err;
> +
>  }
>  
>  /**
> -- 
> 2.51.0

As you mentioned, there is the problem that the flushing context could
change hands multiple times before the flush_prio is restored. And there
is also the recursive case where a WARN could happen within a WARN, or a
WARN could happen and then in an NMI another WARN. All these cases
probably mean that it needs to be a per-prio counter rather than simply
a single prio so that each context can increment/decrement their prio.

John
