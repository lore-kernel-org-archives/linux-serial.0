Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C67149C41
	for <linux-serial@vger.kernel.org>; Mon,  2 Jun 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878861; cv=none; b=J/DEICspUXYiA1CCE0xU8gaQ6G5OnIPvq3k6tB41hH+SArp1JIzA0cClVobVy9hzGcDGqT3OW07LPLwaVms7FMGDgOh9VEiyqprCaVVp+9dnFw/XmZicr6umbOFlOxPuV67/dh9HH8IH8uMyjTy9lffa7T6rGo5t4a3xSqwqwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878861; c=relaxed/simple;
	bh=DZlnG+RVISZeUa0iKsR/dNDeFJnLeZtbmaikCXbqK38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bDuAbsLy9YpLZ43XRk3QTWKjUeS5eAGAC5Xs7P1fa6t5OLd5+AS1YMZLX1yOdZ8h2h2J+LU1NiedktCn393b44+vxtnLQSnE5Tg1TuJb9ljOmNqVY9hrO87PHP+qXRWDpNgtLHBvqL/e4WP9YLWlKpjh3JFbUCuqBD9KQ3f1SPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ln2HwSr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tPTK0pB/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ln2HwSr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tPTK0pB/"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748878858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxmEM9E+xuYO1OTsZMp/hqjLaQ4N+UHlN9MDiw5wMbI=;
	b=0ln2HwSrN3UFWpsr4ukbGNgVCiNgVjocFRzmo/ebIrB2hWfVnc1tITh/UjFcaeZFjjhMHb
	ZwjhbA8m/qQowBeTCWew4Ov0KOyMFXn9ewKCTq5AU6pdMq5FCqGdFbfYaGpUzl3XCBu/Dn
	OUarsGUZTq/npYMI59hX1+/TBH79RhHU1COWb1iegDjTHudNldHlz0FTQK2WQ8Dp86NhDa
	2Hk7q4Evtx7oNfVbU0fXUpYE6NUFTSn0eiJ/3YePLz8zaVQNFDW+w9cgG5Mm54q5yA80cA
	fdS7wDbb39vk5h5/qzj0FGOvn5P/+VM5eJ2I6rGkiHuXfnMZQl9FHvREhZpZsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748878858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxmEM9E+xuYO1OTsZMp/hqjLaQ4N+UHlN9MDiw5wMbI=;
	b=tPTK0pB/qFGWUAy4P/QjAdUUvvCNlt0jiRE7QFmUBqV8aZf3RwGv/XBeDGanq+juv+jleQ
	uokbuJ4meQF4loCg==
To: Michael Cobb <mcobb@thegoodpenguin.co.uk>
Cc: pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] printk: Don't flush messages using write_atomic
 during console registration if kthreads have not been started yet.
In-Reply-To: <847c1xrzib.fsf@jogness.linutronix.de>
References: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
 <84jz6gdh5r.fsf@jogness.linutronix.de>
 <CAC251sUpHHU26wDgBuOGdxNGvE=2M22+b5E4Y+Lc9Ow63fOidw@mail.gmail.com>
 <847c1xrzib.fsf@jogness.linutronix.de>
Date: Mon, 02 Jun 2025 17:46:57 +0206
Message-ID: <84iklerw1i.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-05-31, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 48a24e7b309db..7462a6d179850 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -240,7 +240,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
>  	switch (nbcon_get_default_prio()) {
>  	case NBCON_PRIO_NORMAL:
>  		if (have_nbcon_console && !have_boot_console) {
> -			if (printk_kthreads_running)
> +			if (printk_kthreads_running || printk_kthreads_pending_start)
>  				ft->nbcon_offload = true;
>  			else
>  				ft->nbcon_atomic = true;
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1eea80d0648ed..9c0378dc88c4c 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -4072,6 +4072,14 @@ void register_console(struct console *newcon)
>  	if (newcon->flags & CON_BOOT)
>  		have_boot_console = true;
>  
> +	/*
> +	 * If this is the first console, avoid flushing the backlog
> +	 * until the printing kthread has had a chance to start via
> +	 * printk_kthreads_check_locked() below.
> +	 */
> +	if (hlist_empty(&console_list) && (newcon->flags & CON_NBCON))
> +		printk_kthread_pending_start = true;
> +
>  	/*
>  	 * If another context is actively using the hardware of this new
>  	 * console, it will not be aware of the nbcon synchronization. This
> @@ -4115,6 +4123,10 @@ void register_console(struct console *newcon)
>  
>  	console_sysfs_notify();
>  
> +	/* Changed console list, may require printer threads to start/stop. */
> +	printk_kthreads_check_locked();
> +	printk_kthread_pending_start = false;
> +
>  	/*
>  	 * By unregistering the bootconsoles after we enable the real console
>  	 * we get the "console xxx enabled" message on all the consoles -
> @@ -4133,9 +4145,6 @@ void register_console(struct console *newcon)
>  				unregister_console_locked(con);
>  		}
>  	}
> -
> -	/* Changed console list, may require printer threads to start/stop. */
> -	printk_kthreads_check_locked();

This won't work. printk_kthreads_check_locked() must come after the
boot-console unregister-loop. The kthreads do not start if boot consoles
are registered.

I spent some time thinking about how to get a clean implementation of
this optimization. It is tricky because:

- If the console is registered before printk_kthreads_ready=true, then
  the optimization cannot be used (i.e. the console must do the atomic
  flushing).

- If the console fails to start its kthread, then it must do the atomic
  flush when unregistering.

Perhaps something like this:

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 48a24e7b309db..7462a6d179850 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -240,7 +240,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
 	switch (nbcon_get_default_prio()) {
 	case NBCON_PRIO_NORMAL:
 		if (have_nbcon_console && !have_boot_console) {
-			if (printk_kthreads_running)
+			if (printk_kthreads_running || printk_kthreads_pending_start)
 				ft->nbcon_offload = true;
 			else
 				ft->nbcon_atomic = true;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1eea80d0648ed..d47e8076152e7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3754,8 +3754,18 @@ static void printk_kthreads_check_locked(void)
 		if (!(con->flags & CON_NBCON))
 			continue;
 
-		if (!nbcon_kthread_create(con))
+		if (!nbcon_kthread_create(con)) {
+			/*
+			 * The kthread failed to start so it is no longer
+			 * allowed to use the boot optimization and expect
+			 * offloading to take over. The backlog will be
+			 * flushed using atomic printing during unregister.
+			 */
+			if (printk_kthread_pending_start)
+				printk_kthread_pending_start = false;
+
 			unregister_console_locked(con);
+		}
 	}
 
 	printk_kthreads_running = true;
@@ -4072,6 +4082,18 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_BOOT)
 		have_boot_console = true;
 
+	/*
+	 * Begin boot optimization.
+	 * If this is the first console and kthreads are available, avoid
+	 * flushing the backlog until the printing kthread has had a chance
+	 * to start via printk_kthreads_check_locked() below.
+	 */
+	if (hlist_empty(&console_list) &&
+	    (newcon->flags & CON_NBCON) &&
+	    printk_kthreads_ready) {
+		printk_kthread_pending_start = true;
+	}
+
 	/*
 	 * If another context is actively using the hardware of this new
 	 * console, it will not be aware of the nbcon synchronization. This
@@ -4136,6 +4158,13 @@ void register_console(struct console *newcon)
 
 	/* Changed console list, may require printer threads to start/stop. */
 	printk_kthreads_check_locked();
+
+	/*
+	 * End boot optimization.
+	 * The printing kthread had a chance to start.
+	 */
+	if (printk_kthread_pending_start)
+		printk_kthread_pending_start = false;
 unlock:
 	console_list_unlock();
 }

John
