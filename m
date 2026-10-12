Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3632ABCA;
	Mon, 12 Oct 2026 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811217; cv=none; b=gw9jdUZX880NmdXeskmV0SeDBIeQVs+QmDZkiaE7eqkAa9cCCa9GnEvpJlC+Kgy3QtJ4KZEKTq6TpPP8O+KjCfp0+IBOTBhT4uvEOa0EkZSQSexBMoE1YSfw5+y7Jciel2ZYS74bDsTZxqS6FxGs2lloi4YbLI2PGREfJes5uxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811217; c=relaxed/simple;
	bh=7JlRR66qOPVVm7VgafIlQCIAZmfPZERkFndjaRzUKzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MnTPMjE6VfJdovO8I69zTsDMWAhOgdzJXuL/gfxcv42/gbrcuD4ibvnqnUi5yfBD6BEyM7OHgHNVfmA9Bo+xI5K/EAY0tBMVlXFJCTeru1trdvieVVO3hPy8yMAXVrfywY5EKV6rm0Sz2s3xRdyRwtsJN3xELrYo8Ov8gfcz838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gB2CwnYI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mb8b/7ty; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gB2CwnYI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mb8b/7ty"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791811214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kftQaVM7csFRDLicm5ik98/++v6x8KVMGQYMIYUMJvs=;
	b=gB2CwnYI0yQoy37wODvbXiOjYZuVIuDlubacztW6SBDkTmj2MOV5rbuR113cmzghy9QT2R
	NwSIBaK/lSzbnJMA2wC1Yopsi2L9RSXvuVrO9YaihHaxq4crxxGzsTgiYKFoMigS5eBV9Y
	Q/HABAlHKdWvIxEoxuQtqNW4oE8KG4cAP4bd/v7BFgs8hzL43viMGNkLAkPQnaKfBsXUkv
	5XG9gZF1vqSt0zyEQKvsnv8mW2P5hiFLA/09ZAnpc3TDuVhFAtzvqr282+XcPi+AiVjRRu
	Ob3msmLDGbudzk59hvslWmBr78XOFO/1X1AOkj7hzV8iPzV5qIhAKeyHkGdwzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791811214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kftQaVM7csFRDLicm5ik98/++v6x8KVMGQYMIYUMJvs=;
	b=mb8b/7ty8WAHAwfcLxolO+1v4or+i8MJ0QzliVK7VoR7D+of/nEzUrqgP7Qutxe5l+354B
	mcFQWm6MdNzAoNAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Oleg
 Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-serial@vger.kernel.org, oliver.sang@intel.com,
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] nbcon/reboot: Flush nbcon consoles synchronously on reboot
In-Reply-To: <20261008150852.8286-1-pmladek@suse.com>
References: <20261008150852.8286-1-pmladek@suse.com>
Date: Mon, 12 Oct 2026 15:26:13 +0206
Message-ID: <87mrsjxdgy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-08, Petr Mladek <pmladek@suse.com> wrote:
> NBCON consoles emit messages in a dedicated kthreads when the system
> is working properly. printk() tries to flush them synchronously in
> explicitly marked emergency context and in panic().
>
> Another situation where printk() could not rely on kthreads are the various
> reboot and halt code paths. They can be detected by the `system_state`
> variable.

We are already using the syscore.ops.shutdown notifier for this.

> Let's default to NBCON_PRIO_EMERGENCY for the post-running states.
> printk() will automatically try flushing the consoles synchronously.

Switching to emergency state can cause ugly output and is best
effort. For emergencies it is acceptable, but I am against this in the
general case. A normal shutdown/reboot is not an emergency. I prefer we
mark the appropriate emergency situations.

> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index fb1b37741952..d8f8ec836eea 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1446,6 +1446,10 @@ enum nbcon_prio nbcon_get_default_prio(void)
>  	if (panic_on_this_cpu())
>  		return NBCON_PRIO_PANIC;
>  
> +	/* Do not rely on kthreads when the system is going down. */
> +	if (system_state > SYSTEM_RUNNING)
> +		return NBCON_PRIO_EMERGENCY;
> +

Too general. The vast majority of cases do not need this.

> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index d177d89fcc33..776784a82499 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -94,6 +95,7 @@ void emergency_restart(void)
>  {
>  	kmsg_dump(KMSG_DUMP_EMERG);
>  	system_state = SYSTEM_RESTART;
> +	printk_trigger_flush();

This is clearly an emergency. Similar to what we did for MIPS, I would
add:

	nbcon_cpu_emergency_enter();

before triggering the flush.

> @@ -102,6 +104,7 @@ void kernel_restart_prepare(char *cmd)
>  {
>  	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
>  	system_state = SYSTEM_RESTART;
> +	printk_trigger_flush();

This is not necessary. This is handled by the syscore notifier.

>  	usermodehelper_disable();
>  	device_shutdown();
>  }
> @@ -305,6 +308,7 @@ static void kernel_shutdown_prepare(enum system_states state)
>  	blocking_notifier_call_chain(&reboot_notifier_list,
>  		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
>  	system_state = state;
> +	printk_trigger_flush();

Ditto.

John
