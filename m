Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6E1D86DC;
	Fri, 26 Sep 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897457; cv=none; b=IQd9EOeV4YL15x+b08Imu7AQVcxE197udK8elvJt6Gi5rpzG3aoq4UoQ2ZowDwllWkFkyRtUfhFYWuxN7MGigPFo8iNYSE2h9kXjqNdJBARWXJCjnNfvEwuIXQKZ9awDcHxDgPG2YZ9uY577I3mUi9BmBFFgiIc1Cbm5Xy2akcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897457; c=relaxed/simple;
	bh=DUqLWtTLmbQA/0A26FSmGeMV3sKmBM/KCq7613sbiAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sfGSaDQfmE1Z3X3HLg95JZRpwWFt6/Swg4ZjWfeOyuFIgWtVpeGNtgKhvG+15AGufjcLUeYrZ3GhJi+vDSnsb1cTVvm7rP97IjuyQ0UnZSTGlZR7wVnVOCEjV0Wr0KXdSCbk2mXUfmgNJYY3ODR8zbJhOcpHpqy6BwOFX98HlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lMv25u/Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5CxlFsbX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lMv25u/Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5CxlFsbX"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758897453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNZ/O8qWqMZNmQ0bJmoC3D37V6ZldVDNa+YT8EZ2jEY=;
	b=lMv25u/QeiUxeExqGzdOSp2/9EO/7Iq/dcktc/K+UQ1yxyT7Pk0cCjdUaRB0WeCCdiUiMR
	TfpFXtJz8pP+pUkN5XOba12doRk75ezy2RI8ar5qgj1QMgZJYe7A3clS5EczAuGp5R538C
	pxmgkaCgSIzeIu5QQyYZKBk8TORhpg+xP45rZrt586r218pJ1qHjrfxgGzlYXKwEmpRQlD
	eE9+tPBaW5L+qRP1SE3GGXo4sbg/U0Egu3sSRWaYY4GyFuIMybvsQz9gYkGf32RC9aNIdI
	3fbqBKv/K/Kem5ellNb7d/KcICT1tYhDgyke6FFwTETudp7IVzMtA4892q4fXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758897453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNZ/O8qWqMZNmQ0bJmoC3D37V6ZldVDNa+YT8EZ2jEY=;
	b=5CxlFsbXAE/4WWJdl/X6+2epLQ7uLHzpiUfRolZhfTkwLdTIPVfy5eSjUAKgLAtxGt7yKr
	JWzBE8Qg7YCivLAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>, Andrew
 Murray <amurray@thegoodpenguin.co.uk>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/3] printk/nbcon: Block printk kthreads when any CPU is
 in an emergency context
In-Reply-To: <20250926124912.243464-2-pmladek@suse.com>
References: <20250926124912.243464-1-pmladek@suse.com>
 <20250926124912.243464-2-pmladek@suse.com>
Date: Fri, 26 Sep 2025 16:43:33 +0206
Message-ID: <841pnti8k2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-26, Petr Mladek <pmladek@suse.com> wrote:
> In emergency contexts, printk() tries to flush messages directly even
> on nbcon consoles. And it is allowed to takeover the console ownership
> and interrupt the printk kthread in the middle of a message.
>
> Only one takeover and one repeated message should be enough in most
> situations. The first emergency message flushes the backlog and printk
> kthreads get to sleep. Next emergency messages are flushed directly
> and printk() does not wake up the kthreads.
>
> However, the one takeover is not guaranteed. Any printk() in normal
> context on another CPU could wake up the kthreads. Or a new emergency
> message might be added before the kthreads get to sleep. Note that
> the interrupted .write_kthread() callbacks usually have to call

                  .write_thread()

> nbcon_reacquire_nobuf() and restore the original device setting
> before checking for pending messages.
>
> The risk of the repeated takeovers will be even bigger because
> __nbcon_atomic_flush_pending_con is going to release the console
> ownership after each emitted record. It will be needed to prevent
> hardlockup reports on other CPUs which are busy waiting for
> the context ownership, for example, by nbcon_reacquire_nobuf() or
> __uart_port_nbcon_acquire().
>
> The repeated takeovers break the output, for example:
>
>     [ 5042.650211][ T2220] Call Trace:
>     [ 5042.6511
>     ** replaying previous printk message **
>     [ 5042.651192][ T2220]  <TASK>
>     [ 5042.652160][ T2220]  kunit_run_
>     ** replaying previous printk message **
>     [ 5042.652160][ T2220]  kunit_run_tests+0x72/0x90
>     [ 5042.653340][ T22
>     ** replaying previous printk message **
>     [ 5042.653340][ T2220]  ? srso_alias_return_thunk+0x5/0xfbef5
>     [ 5042.654628][ T2220]  ? stack_trace_save+0x4d/0x70
>     [ 5042.6553
>     ** replaying previous printk message **
>     [ 5042.655394][ T2220]  ? srso_alias_return_thunk+0x5/0xfbef5
>     [ 5042.656713][ T2220]  ? save_trace+0x5b/0x180
>
> A more robust solution is to block the printk kthread entirely whenever
> *any* CPU enters an emergency context. This ensures that critical messages
> can be flushed without contention from the normal, non-atomic printing
> path.
>
> Link: https://lore.kernel.org/all/aNQO-zl3k1l4ENfy@pathway.suse.cz
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/nbcon.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index d5d8c8c657e0..08b196e898cd 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -117,6 +117,9 @@
>   * from scratch.
>   */
>  
> +/* Counter of active nbcon emergency contexts. */
> +atomic_t nbcon_cpu_emergency_cnt;

This can be static and should be initialized:

static atomic_t nbcon_cpu_emergency_cnt = ATOMIC_INIT(0);

> +
>  /**
>   * nbcon_state_set - Helper function to set the console state
>   * @con:	Console to update
> @@ -1168,6 +1171,16 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
>  	if (kthread_should_stop())
>  		return true;
>  
> +	/*
> +	 * Block the kthread when the system is in an emergency or panic mode.
> +	 * It increases the chance that these contexts would be able to show
> +	 * the messages directly. And it reduces the risk of interrupted writes
> +	 * where the context with a higher priority takes over the nbcon console
> +	 * ownership in the middle of a message.
> +	 */
> +	if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)))
> +		return false;
> +
>  	cookie = console_srcu_read_lock();
>  
>  	flags = console_srcu_read_flags(con);
> @@ -1219,6 +1232,13 @@ static int nbcon_kthread_func(void *__console)
>  		if (kthread_should_stop())
>  			return 0;
>  
> +		/*
> +		 * Block the kthread when the system is in an emergency or panic
> +		 * mode. See nbcon_kthread_should_wakeup() for more details.
> +		 */
> +		if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)))
> +			goto wait_for_event;
> +
>  		backlog = false;
>  
>  		/*
> @@ -1660,6 +1680,8 @@ void nbcon_cpu_emergency_enter(void)
>  
>  	preempt_disable();
>  
> +	atomic_inc(&nbcon_cpu_emergency_cnt);
> +
>  	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
>  	(*cpu_emergency_nesting)++;
>  }
> @@ -1674,10 +1696,18 @@ void nbcon_cpu_emergency_exit(void)
>  	unsigned int *cpu_emergency_nesting;
>  
>  	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> -
>  	if (!WARN_ON_ONCE(*cpu_emergency_nesting == 0))
>  		(*cpu_emergency_nesting)--;
>  
> +	/*
> +	 * Wake up kthreads because there might be some pending messages
> +	 * added by other CPUs with normal priority since the last flush
> +	 * in the emergency context.
> +	 */
> +	if (!WARN_ON_ONCE(atomic_read(&nbcon_cpu_emergency_cnt) == 0))
> +		if (atomic_dec_return(&nbcon_cpu_emergency_cnt) == 0)
> +			nbcon_kthreads_wake();

Although technically it doesn't hurt to blindly call
nbcon_kthreads_wake(), you may want to do it more formally. Maybe like
this:

	if (!WARN_ON_ONCE(atomic_read(&nbcon_cpu_emergency_cnt) == 0)) {
		if (atomic_dec_return(&nbcon_cpu_emergency_cnt) == 0) {
			struct console_flush_type ft;

			printk_get_console_flush_type(&ft);
			if (ft.nbcon_offload)
				nbcon_kthreads_wake();
		}
	}

I leave it up to you.

With the static+initializer change:

Reviewed-by: John Ogness <john.ogness@linutronix.de>
