Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4FC43F4AD;
	Fri,  9 Oct 2026 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550754; cv=none; b=MZPxA+2MwEcTLkeyi9f9Lj5OzP/IiZE+SY7xq2/9wYmlrCXGT+Nh//cLTkKzlEaIU3/lnmmyJzF7V1i8+bg81HpR5rtQVCw1gv1xyAR+DvA7hfrvshSKrtg5FdZImw63/Ok0Qt3WJkU5OuKFMt9k8/nk2IZXR4CavV39gHPLMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550754; c=relaxed/simple;
	bh=O3HPNiC/H6q/R/UqjxAM9mOq/yQeP0MwgcnJdZbOPAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDQ28bKEPE2nHS8tBkQLVNBYn6WtIwG8eCut24dPPGn4fHxnSGwN3PmxfhRG1uO7LFOdhTAo5MkR3Qoff9n3UrR5NpJ5DjNYQmXFkg5D0va+xU7tIhj8jWGrqa8RRjy7afyruoO/v7nef9025ktODGYrHM/v+XDaRV+TK/sekL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oSNwUpTQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hcfEm8Bl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oSNwUpTQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hcfEm8Bl"
Date: Fri, 9 Oct 2026 14:59:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791550749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YA/AaboNi3kj/HKsO3IF65GjFnmZrdFwxRX2y8NDDDE=;
	b=oSNwUpTQCVH7lrBBlsXlbo6wu8uh5vxiFD0ugQxgpbcjgI4MHMFcg0nfz5D3WfwnXSfl8U
	iFRwZRUqBa+zo3Xgr8frX7CwmM/r+/8BXC/Ly254lRkGTDgkAXGReAclormUmKKc0bmm+B
	s0M3Uh4RWxtSCH/fKUBCc2uyMxWqdQXcjYroWvpOr8K520KICkbMfoUlw3IMYKvQdDPbrY
	pYuKyzrn6Wits7gKs+XyI7LlVWGReOIEpYVN/bqL/zz1x8oVcKaTx41WJonaWOCnZxY/qe
	iL0i8DO9qiU9EFZ/+i8dx9LEN9RqX3VW3ZSuS48tfQaYsI5HJ+FibTugxoZIIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791550749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YA/AaboNi3kj/HKsO3IF65GjFnmZrdFwxRX2y8NDDDE=;
	b=hcfEm8Bl+gLQPrLfwcEeghv7JRQ93mE/jxF6KBkPb1T7jwOfc66S3dNdIV1f9gz1VySvkq
	9oEiFCCQczkVaEDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-serial@vger.kernel.org, oliver.sang@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbcon/reboot: Flush nbcon consoles synchronously on
 reboot
Message-ID: <20261009125907.SvaRdfv6@linutronix.de>
References: <20261008150852.8286-1-pmladek@suse.com>
 <20261009065152.udyfFRHx@linutronix.de>
 <asiu8orjDvRJMKuX@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asiu8orjDvRJMKuX@pathway.suse.cz>

On 2026-10-09 11:08:02 [+0200], Petr Mladek wrote:
> On Fri 2026-10-09 08:51:52, Sebastian Andrzej Siewior wrote:
> > On 2026-10-08 17:08:52 [+0200], Petr Mladek wrote:
> > > NBCON consoles emit messages in a dedicated kthreads when the system
> > > is working properly. printk() tries to flush them synchronously in
> > > explicitly marked emergency context and in panic().
> > > 
> > > Another situation where printk() could not rely on kthreads are the various
> > > reboot and halt code paths. They can be detected by the `system_state`
> > > variable.
> > > 
> > > Let's default to NBCON_PRIO_EMERGENCY for the post-running states.
> > > printk() will automatically try flushing the consoles synchronously.
> > > Also do not rely on printk() and explicitly flush the consoles
> > > after these states are set.
> > 
> > while this seems okay, didn't we have pr_flush() to flush the output on
> > shutdown/ reboot?
> 
> Good point! We should clean this up.
> 
> Anyway, IMHO, we should switch to NBCON_PRIO_EMERGENCY for the post-running
> states and flush the pending messages immediately. It is more
> reliable. It is easy to find the locations when system_state() is set.
> And all follow-up printk() calls will try the direct flush so that
> they won't rely on an explicit flush.
> 
> An ideal solution would be to add an wrapper, e.g.
> 
> 	void set_syste_state(enum system_states state)
> 	{
> 		system_state = state;
> 
> 		if (system_state > SYSTEM_RUNNING)
> 			pr_flush(0, true);
> 	}
> 
> 
> Another thing is that printk_trigger_flush() is an overkill.
> It tries to wake kthreads even via irq_work but we are
> interested only in the direct flush.
> 
> I am not sure why neither me nor John used pr_flush().
> It might be because it originally did not flush atomic consoles
> directly. At least I had an outdated mental map.

The nbcon should be awake because there is outstanding printing to be
done as far as I understand. It is just not running or behind. So you
would need just wait until the thread is done before you continue.

This pops up now because the 8250 does it via the thread now. If you
don't have an atomic console implementation but use the thread anyway
(say the PREEMPT_RT case) then you would end up with the same problem,
right?

Recently I did play with CPU shutdown and noticed that PREEMPT_RT misses
an irq_work sync which explained missing printk output. You probably
recall the printk part of this :)

Now that I look more into it, the above with pr_flush() does not work
because by the time SYSTEM_SUSPEND is assigned it expects interrupts to
be disabled (or disables them a few lines earlier).

emergency_restart() looks like a bad candidate for a flush.
kernel_restart_prepare() on the other hand would be good. And there is a
flush in kernel_power_off().

In general I would expect sysrq-b to reboot immediately without the
flush but an ordinary reboot should flush.

> Also the timeout should not be needed because all consoles should
> be flushed directly. But it can be solved by using zero timeout.
> 
> In fact, we should block the kthreads to prevent seeing more
> incomplete/interrupted messages, see the commit c41c0ebfa1e0eb
> ("printk/nbcon: Block printk kthreads when any CPU is in an emergency
> context"). Something like:

But if we have more than one console and more than one CPU we could let
them flush in parallel and just wait for them do be done?

> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index d8f8ec836eea..1c21c1e65b00 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1187,13 +1187,14 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
>  		return true;
>  
>  	/*
> -	 * Block the kthread when the system is in an emergency or panic mode.
> -	 * It increases the chance that these contexts would be able to show
> -	 * the messages directly. And it reduces the risk of interrupted writes
> -	 * where the context with a higher priority takes over the nbcon console
> -	 * ownership in the middle of a message.
> +	 * Block the kthread when the system is in an emergency, going down,
> +	 * or panic mode. It increases the chance that these contexts would
> +	 * be able to show the messages directly. And it reduces the risk of
> +	 * interrupted writes where the context with a higher priority takes
> +	 * over the nbcon console ownership in the middle of a message.
>  	 */
>  	if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)) ||
> +	    unlikely(system_state > SYSTEM_RUNNING) ||
>  	    unlikely(panic_in_progress()))
>  		return false;
>  
> @@ -1249,10 +1250,12 @@ static int nbcon_kthread_func(void *__console)
>  			return 0;
>  
>  		/*
> -		 * Block the kthread when the system is in an emergency or panic
> -		 * mode. See nbcon_kthread_should_wakeup() for more details.
> +		 * Block the kthread when the system is in an emergency, going
> +		 * down, or panic mode. See nbcon_kthread_should_wakeup() for
> +		 * more details.
>  		 */
>  		if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)) ||
> +		    unlikely(system_state > SYSTEM_RUNNING) ||
>  		    unlikely(panic_in_progress()))
>  			goto wait_for_event;
>  
> 
> But wait, this might cause regression on netconsole which sets
> CON_NBCON_ATOMIC_UNSAFE and is not able to flush the messages
> directly a safe way.

same as PREEMPT_RT.

> A possibility would be to use con->write_thread() when pr_flush()
> is called in task context. It should be safe in most shutdown
> code paths except for the emergency_restart().
> 
> And we need an explicit pr_flush() even later in the halt
> and maybe even some unsafe flush later in emergency_restart()
> code path.
> 
> Sigh, this is getting complicated.

So maybe just identify the few spots in the reboot case.

> Best Regards,
> Petr

Sebastian
