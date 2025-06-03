Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F223C4F2
	for <linux-serial@vger.kernel.org>; Tue,  3 Jun 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966992; cv=none; b=IfWaQSsarMgFkXYSL3dA464btDAdJVenDaNN6k+W6sqZdeh7LYdl7S5ygZ0MuJP5rWu0nT8U9MzJokchC2iUjP4hCTXGl78IVKIh3ngWefbrPbrDqRl2hnxPCZk8w3Nm9Qexj/Sij9HdnC90apgrU7cuVxjOlWtO4jxDFeBYZUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966992; c=relaxed/simple;
	bh=SHEGR8KPZJvfsOip2MnweQXdIk+BMjx+EkfXIlEeH38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T2E9HaH/NhERbRfojKf7JKhGb7eNJ0UMbl9iBPrZkoiJKpP7RSjz108zkC14S57qpaSxXwydzkrdPUemEFjsfVw8JQTDcg/ir/VFJZ1IgdXqqu2hl9RhtPS8EpM3vRCe464vlNPbFpZz6Kk754HXwALvSu2yfYqYHwNnDRyVl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XhrNoXKR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tDS21zIL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XhrNoXKR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tDS21zIL"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748966989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vc8xam8+6cGwz36v0F+JsmYtuOKohU38lEgYCT2Z/Ec=;
	b=XhrNoXKRlCMwAnTYDU8thWUwv7bKnDJe9SmJeKHG4hXqF5SoPYxFF5Uf9wjs+VSmPyeHnY
	FtVHTKPjRAh7emYnb7ZaeNYJMSfWxxU9dfWmE3SqiCf4KJyLIc4KOSBKW8Q6sY/amqiJmv
	gh+wWYX07UDGaa7flVLCrvuAMwplsiMa2GxO6A0AHwGsYdrR2ZbCxXu5ZnHYMA85M+tD2L
	4j2JjkTmIRDrsKkddVV+URzvfVguPNocTVMxFgBcIkuNyCyRdXXCQcQSHwdRrm1flI4HOi
	NTLQp+8WMDF7xcb3yJ3F5uoij7ayMFjWEgPzBMLGuEM+IymhpIVApuVhmSnYTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748966989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vc8xam8+6cGwz36v0F+JsmYtuOKohU38lEgYCT2Z/Ec=;
	b=tDS21zILd0kNn4AxinxWbtz+HNo3eV77eutbasckzY68mA75P36jgzVGZkdHLHlSCTDzQt
	bmZTef10vrL4XWBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Michael Cobb <mcobb@thegoodpenguin.co.uk>, rostedt@goodmis.org,
 senozhatsky@chromium.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] printk: Don't flush messages using write_atomic
 during console registration if kthreads have not been started yet.
In-Reply-To: <aD8JOlDVP4ufgv44@pathway.suse.cz>
References: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
 <84jz6gdh5r.fsf@jogness.linutronix.de>
 <CAC251sUpHHU26wDgBuOGdxNGvE=2M22+b5E4Y+Lc9Ow63fOidw@mail.gmail.com>
 <847c1xrzib.fsf@jogness.linutronix.de>
 <84iklerw1i.fsf@jogness.linutronix.de> <aD8JOlDVP4ufgv44@pathway.suse.cz>
Date: Tue, 03 Jun 2025 18:15:48 +0206
Message-ID: <84msao6c37.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-03, Petr Mladek <pmladek@suse.com> wrote:
> I thought whether we could avoid introducing yet another variable
> and still keep the code sane. And I came with the following.
> The commit messages describes the idea.
>
> I hope that I have covered all the cases. Note that I haven't tested
> it with nbcon console though.
>
> What do you think, please?
>
> From 5768ff7e9d944bb904344341a2a447d2f101e6ba Mon Sep 17 00:00:00 2001
> From: Petr Mladek <pmladek@suse.com>
> Date: Tue, 3 Jun 2025 14:19:00 +0200
> Subject: [PATCH] printk: Allow to use the printk kthread immediately even for
>  1st nbcon
>
> The kthreads for nbcon consoles are created by nbcon_alloc() at the beginning
> of the console registration. But it currently works only for the 2nd or
> later nbcon console because the code checks @printk_kthreads_running.
>
> The kthread for the 1st registered nbcon console is created at the very
> end of register_console() by printk_kthreads_check_locked(). As a result,
> the entire log is replayed synchronously when the "enabled" message
> gets printed. It might block the boot for a long time with a slow serial
> console.
>
> Prevent the synchronous flush by creating the kthread even for the 1st
> nbcon console when it is safe (kthreads ready and no boot consoles).
>
> Also inform printk() to use the kthread by setting @printk_kthreads_running.
> Note that the kthreads already must be running when it is safe and this
> is not the 1st nbcon console.
>
> Symmetrically, clear @printk_kthreads_running when the last nbcon
> console was unregistered by nbcon_free(). This requires updating
> @have_nbcon_console before nbcon_free() gets called.
>
> Note that there is _no_ problem when the 1st nbcon console replaces boot
> consoles. In this case, the kthread will be started at the end
> of registration after the boot consoles are removed. But the console
> does not reply the entire log buffer in this case. Note that
> the flag CON_PRINTBUFFER is always cleared when the boot consoles are
> removed and vice versa.
>
> Closes: https://lore.kernel.org/r/20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/internal.h |  2 ++
>  kernel/printk/nbcon.c    | 17 +++++++++++++++--
>  kernel/printk/printk.c   | 19 ++++++++++---------
>  3 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 48a24e7b309d..567c9e100d47 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -64,6 +64,7 @@ struct dev_printk_info;
>  
>  extern struct printk_ringbuffer *prb;
>  extern bool printk_kthreads_running;
> +extern bool printk_kthreads_ready;
>  extern bool debug_non_panic_cpus;
>  
>  __printf(4, 0)
> @@ -180,6 +181,7 @@ static inline void nbcon_kthread_wake(struct console *con)
>  #define PRINTKRB_RECORD_MAX	0
>  
>  #define printk_kthreads_running (false)
> +#define printk_kthreads_ready (false)
>  
>  /*
>   * In !PRINTK builds we still export console_sem
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index fd12efcc4aed..7519d09c20e7 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1671,6 +1671,9 @@ bool nbcon_alloc(struct console *con)
>  {
>  	struct nbcon_state state = { };
>  
> +	/* Synchronize the kthread start. */
> +	lockdep_assert_console_list_lock_held();
> +
>  	/* The write_thread() callback is mandatory. */
>  	if (WARN_ON(!con->write_thread))
>  		return false;
> @@ -1701,12 +1704,15 @@ bool nbcon_alloc(struct console *con)
>  			return false;
>  		}
>  
> -		if (printk_kthreads_running) {
> +		if (printk_kthreads_ready && !have_boot_console) {
>  			if (!nbcon_kthread_create(con)) {
>  				kfree(con->pbufs);
>  				con->pbufs = NULL;
>  				return false;
>  			}
> +
> +			/* Might be the first kthread. */
> +			printk_kthreads_running = true;
>  		}
>  	}
>  
> @@ -1721,8 +1727,15 @@ void nbcon_free(struct console *con)
>  {
>  	struct nbcon_state state = { };
>  
> -	if (printk_kthreads_running)
> +	/* Synchronize the kthread stop. */
> +	lockdep_assert_console_list_lock_held();
> +
> +	if (printk_kthreads_running) {
>  		nbcon_kthread_stop(con);
> +		/* Might be the last nbcon console */

Super small nit... add a period at the end of the comment to be
consistent with the one one-liners.

> +		if (!have_nbcon_console)
> +			printk_kthreads_running = false;
> +	}

This is pretty tricky. We should have a comment here (and possibly in
the function description of nbcon_free()) mentioning that nbcon_free()
must be called _after_ @have_nbcon_console has been updated for the
removal of this console. Generally it would not matter because
printk_kthreads_check_locked() is called at the end of
unregister. However, if in register CON_BRL is set, then nbcon_free() is
called without ever calling printk_kthreads_check_locked(). So this new
code in nbcon_free() is necessary to correctly reset
@printk_kthreads_running in that case.

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1eea80d0648e..af6e4f0e8e22 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3574,7 +3574,7 @@ EXPORT_SYMBOL(console_resume);
>  static int unregister_console_locked(struct console *console);
>  
>  /* True when system boot is far enough to create printer threads. */
> -static bool printk_kthreads_ready __ro_after_init;
> +bool printk_kthreads_ready __ro_after_init;
>  
>  static struct task_struct *printk_legacy_kthread;
>  
> @@ -3713,6 +3713,7 @@ static void printk_kthreads_check_locked(void)
>  	if (!printk_kthreads_ready)
>  		return;
>  
> +	/* Start or stop the legacy kthread when needed. */
>  	if (have_legacy_console || have_boot_console) {
>  		if (!printk_legacy_kthread &&
>  		    force_legacy_kthread() &&
> @@ -4204,14 +4205,6 @@ static int unregister_console_locked(struct console *console)
>  	 */
>  	synchronize_srcu(&console_srcu);
>  
> -	if (console->flags & CON_NBCON)
> -		nbcon_free(console);
> -
> -	console_sysfs_notify();
> -
> -	if (console->exit)
> -		res = console->exit(console);
> -
>  	/*
>  	 * With this console gone, the global flags tracking registered
>  	 * console types may have changed. Update them.
> @@ -4232,6 +4225,14 @@ static int unregister_console_locked(struct console *console)
>  	if (!found_nbcon_con)
>  		have_nbcon_console = found_nbcon_con;
>

Maybe also a small comment here that it can be freed because
@have_nbcon_console has been updated. Just to leave a little hint for
future developers that its location is important.

> +	if (console->flags & CON_NBCON)
> +		nbcon_free(console);
> +
> +	console_sysfs_notify();
> +
> +	if (console->exit)
> +		res = console->exit(console);
> +
>  	/* Changed console list, may require printer threads to start/stop. */
>  	printk_kthreads_check_locked();

Aside from documenting these new subtle relationships, I think this is
a good solution.

Note that LKML is not CC. I can offer my reviewed-by when the patch is
posted on LKML.

John Ogness
