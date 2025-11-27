Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640CD316904
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764236975; cv=none; b=SIL6xcpvA4gVjBQZ5eGbm+TAOu1sS/JA/SzGUThiUMRAbedh7ne/taUnoVb9t8fksElUgUsztorOZKyZP4YmClsuDWYn6AAv0SISy+pE+N4ebzBffWUj7YOW2TZ8fTfxWsLoYuFJ65w525VE4o9dTQLOU5fafscYqD/gfuPiLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764236975; c=relaxed/simple;
	bh=1w3icSO0TBdK1xD2/6Uy3zTHvCanKIgCdKJcedP9454=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU147FHlrt16iGnsX1FPucLZXJPBthQ9fwKv8ZVkKa1j4nBDlDLv9G0NtrH9Fn/xPwV2ptUFoKZ4ag+xkl4MAYjp6XqVKLi7XtDHA7+tYmirznH0AWX+wgjyWJDKUjkZeFEwDAZtgzi9K9z/ITfUEmEzzoW808L6Jq2M/dpnkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DF4ZA+Ht; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DF4ZA+Ht"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso1079300a12.3
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 01:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764236972; x=1764841772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M55NOPX6+5YD0B0HIxdp5eD8kEu/VA3rAyDyjjhFwp8=;
        b=DF4ZA+Htxfo9uVnJxve6l6AEqqleFXSFMJWap4j0Z3mT3FTjSNWiKbUIfcjrE5XndM
         4qFoE2hnBcLxeZA+DrurnQdjHdAy2P8rA5c/ekaUg6g8aIk+735UtcH0Ze8VpVRFRsbQ
         XwaamAJs8nS1++e3ON7jgwXDos0QTE0KX3gqKI6Wlz2SYAVuR41Jz/bxC+oLfX4+hE+3
         0EZeafP7QXQdOr7wQ8OHzLQDp9eT97TaLb2bODFH5hx8pfolmKm2QLDPNykNNQpEb8jb
         9jRRfTXstNzC4BZTBsg3RDwcf2sjQKd3OHhY7S3rJ6fiAaNA+zBlUAKiLvg6gI/hhQTO
         g1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764236972; x=1764841772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M55NOPX6+5YD0B0HIxdp5eD8kEu/VA3rAyDyjjhFwp8=;
        b=e+Nga83bLKrPg17irEHOtvEIfq4NOA4TCnLXOBPl8erYIOixqtj/11vtoEHlLA/bbS
         /arvdi2Aap5xoAlKHtyOImg9Wxss4WSseLyoh5QmgOdTQA7bTk+tb4r9f/45GX9KTv63
         ON0m0wu86OkQeomiahk78JXGAC8LLbKlIYilIIQ1ANtl9ZDjFxJYRUGjhXI2Gs+I6jiC
         eZX/yqsAta1cCo1jcOYV7kI6E/8qrWLFxmJ2bzlpvjTwCNjtvFr+bGSsEoNPpGh3mszA
         HubIzKoP6Ltp5Xct0Fzze33FmqIs4IkeUzrFdcYGrxSDWqk6QAzktnF+kHuz4wm/weFq
         2IAg==
X-Forwarded-Encrypted: i=1; AJvYcCUMS0YnZpjyk52Jp8B9Dqc9x4JKEZ9zem9bUVNUmCNfYifxxkDPyQU+1D5xbtFtKoHO4uSj6VTrRTLHOdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOUzE0wj/ypwiVSu3OtnaFtJkbWnR2g+8kfmmuiw3hqJ0vj7Ia
	2ufNV3coHOzHZzXoTkmOcRTp2objwTfupREYfEAUfMqVenhsUFQ9+ov9ANx1ixYhcOY=
X-Gm-Gg: ASbGncuyyXvbT1gtD2HVMZHtdPWgFuGAUVZg44ea2+0YV4/tNEb8NsyqC51IhZPt/yX
	R5HqosdUH/hcnR8NsSpVun6JNW1yTgVy9XVKs7NgTkkqUAwNcY2m4VOUBot5WdrhmvnjC2hLYo6
	iGfDD5bqFiW2FV+a8IkKgKM1h/KAvx6VL5luTDdWQR1mBnk7Y7Y3SuIDHGgdgVazEV9MJZ5GPzr
	i8rUYDhLLVsGcmTQnXP/7CaAt2ayBwjb2pe5nXrI1dgdDWdDanmqTg4MCE4AuWt3PmwRJBoLuBS
	TvWG2oBrMnWBF7VhHrO6x9Vm4wigC34UyflPrwHRARcB07ugQfB7RN8xXmEack9ElEPJdJtFdgK
	5IliYklyDEzTft+NxJrKzHVKnFYZ7Y0rd+4lhwaWj3i9Fflc49dldtXD9m8EZw2pDQx/02y7PO2
	YqXjOj7fzic9AxSA==
X-Google-Smtp-Source: AGHT+IFxlu0dGYyZ0OR2t4e3UxMOdqisZjIAo/bgT3egjX/1jqRrOdQbJ5C0zIWcx5YhoZUyiTy5Wg==
X-Received: by 2002:a17:906:2612:b0:b76:b632:1123 with SMTP id a640c23a62f3a-b76b63214demr1036789966b.42.1764236971612;
        Thu, 27 Nov 2025 01:49:31 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162093sm123547366b.2.2025.11.27.01.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:49:31 -0800 (PST)
Date: Thu, 27 Nov 2025 10:49:28 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 4/4] printk: Make console_{suspend,resume} handle
 CON_SUSPENDED
Message-ID: <aSgeqM3DWvR8-cMY@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <20251121-printk-cleanup-part2-v2-4-57b8b78647f4@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-printk-cleanup-part2-v2-4-57b8b78647f4@suse.com>

On Fri 2025-11-21 15:50:36, Marcos Paulo de Souza wrote:
> Since commit 9e70a5e109a4 ("printk: Add per-console suspended state")
> the CON_SUSPENDED flag was introced, and this flag was being checked
> on console_is_usable function, which returns false if the console is
> suspended.
> 
> To make the behavior consistent, change show_cons_active to look for
> consoles that are not suspended, instead of checking CON_ENABLED.
> 
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3554,7 +3554,7 @@ static ssize_t show_cons_active(struct device *dev,
>  			continue;
>  		if (!(c->flags & CON_NBCON) && !c->write)
>  			continue;
> -		if ((c->flags & CON_ENABLED) == 0)
> +		if (c->flags & CON_SUSPENDED)

I believe that we could and should replace

		if (!(c->flags & CON_NBCON) && !c->write)
			continue;
		if (c->flags & CON_SUSPENDED)
			continue;

with

		if (!console_is_usable(c, c->flags, true) &&
		    !console_is_usable(c, c->flags, false))
			continue;

It would make the value compatible with all other callers/users of
the console drivers.

The variant using two console_is_usable() calls with "true/false"
parameters is inspited by __pr_flush().

>  			continue;
>  		cs[i++] = c;
>  		if (i >= ARRAY_SIZE(cs))
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fed98a18e830..fe7c956f73bd 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3542,7 +3542,7 @@ void console_suspend(struct console *console)
>  {
>  	__pr_flush(console, 1000, true);
>  	console_list_lock();
> -	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
> +	console_srcu_write_flags(console, console->flags | CON_SUSPENDED);

This is the same flag which is set also by the console_suspend_all()
API. Now, as discussed at
https://lore.kernel.org/lkml/844j4lepak.fsf@jogness.linutronix.de/

   + console_suspend()/console_resume() API is used by few console
     drivers to suspend the console when the related HW device
     gets suspended.

   + console_suspend_all()/console_resume_all() is used by
     the power management subsystem to call down/up all consoles
     when the system is going down/up. It is a big hammer approach.

We need to distinguish the two APIs so that console drivers which were
suspended by both APIs stay suspended until they get resumed by both
APIs. I mean:

	// This should suspend all consoles unless it is not disabled
	// by "no_console_suspend" API.
	console_suspend_all();
	// This suspends @con even when "no_console_suspend" parameter
	// is used. It is needed because the HW is going to be suspended.
	// It has no effect when the consoles were already suspended
	// by the big hammer API.
	console_suspend(con);

	// This might resume the console when "no_console_suspend" option
	// is used. The driver should work because the HW was resumed.
	// But it should stay suspended when all consoles are supposed
	// to stay suspended because of the big hammer API.
	console_resume(con);
	// This should resume all consoles.
	console_resume_all();

Other behavior would be unexpected and untested. It might cause regression.

I see two solutions:

   + add another CON_SUSPENDED_ALL flag
   + add back "consoles_suspended" global variable

I prefer adding back the "consoles_suspended" global variable because
it is a global state...

The global state should be synchronized the same way as the current
per-console flag (write under console_list_lock, read under
console_srcu_read_lock()).

Also it should be checked by console_is_usable() API. Otherwise, we
would need to update all callers.

This brings a challenge how to make it safe and keep the API sane.
I propose to create:

  + __console_is_usable() where the "consoles_suspended" value will
    be passed as parameter. It might be used directly under
    console_list_lock().

  + console_is_usable() with the existing parameters. It will check
    the it was called under console_srcu_read_lock, read
    the global "consoles_suspend" and pass it to
    __console_is_usable().


>  	console_list_unlock();
>  
>  	/*

I played with the code to make sure that it looked sane
and I ended with the following changes on top of this patch.

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1b2ce0f36010..fda4683d12f1 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3552,9 +3552,8 @@ static ssize_t show_cons_active(struct device *dev,
 	for_each_console(c) {
 		if (!c->device)
 			continue;
-		if (!(c->flags & CON_NBCON) && !c->write)
-			continue;
-		if (c->flags & CON_SUSPENDED)
+		if (!__console_is_usable(c, c->flags, consoles_suspended, true) &&
+		    !__console_is_usable(c, c->flags, consoles_suspended, false))
 			continue;
 		cs[i++] = c;
 		if (i >= ARRAY_SIZE(cs))
diff --git a/include/linux/console.h b/include/linux/console.h
index 5f17321ed962..090490ef570f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -496,6 +496,7 @@ extern void console_list_lock(void) __acquires(console_mutex);
 extern void console_list_unlock(void) __releases(console_mutex);
 
 extern struct hlist_head console_list;
+extern bool consoles_suspended;
 
 /**
  * console_srcu_read_flags - Locklessly read flags of a possibly registered
@@ -548,6 +549,47 @@ static inline void console_srcu_write_flags(struct console *con, short flags)
 	WRITE_ONCE(con->flags, flags);
 }
 
+/**
+ * consoles_suspended_srcu_read - Locklessly read the global flag for
+ *				suspending all consoles.
+ *
+ * The global "consoles_suspended" flag is synchronized using console_list_lock
+ * and console_srcu_read_lock. It is the same approach as CON_SUSSPENDED flag.
+ * See console_srcu_read_flags() for more details.
+ *
+ * Context: Any context.
+ * Return: The current value of the global "consoles_suspended" flag.
+ */
+static inline short consoles_suspended_srcu_read(void)
+{
+	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
+
+	/*
+	 * The READ_ONCE() matches the WRITE_ONCE() when "consoles_suspended"
+	 * is modified with consoles_suspended_srcu_write().
+	 */
+	return data_race(READ_ONCE(consoles_suspended));
+}
+
+/**
+ * consoles_suspended_srcu_write - Write the global flag for suspending
+ *			all consoles.
+ * @suspend:	new value to write
+ *
+ * The write must be done under the console_list_lock. The caller is responsible
+ * for calling synchronize_srcu() to make sure that all callers checking the
+ * usablility of registered consoles see the new state.
+ *
+ * Context: Any context.
+ */
+static inline void consoles_suspended_srcu_write(bool suspend)
+{
+	lockdep_assert_console_list_lock_held();
+
+	/* This matches the READ_ONCE() in consoles_suspended_srcu_read(). */
+	WRITE_ONCE(consoles_suspended, suspend);
+}
+
 /* Variant of console_is_registered() when the console_list_lock is held. */
 static inline bool console_is_registered_locked(const struct console *con)
 {
@@ -617,13 +659,15 @@ extern bool nbcon_kdb_try_acquire(struct console *con,
 extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
 
 /*
- * Check if the given console is currently capable and allowed to print
- * records. Note that this function does not consider the current context,
- * which can also play a role in deciding if @con can be used to print
- * records.
+ * This variant might be called under console_list_lock where both
+ * @flags and @all_suspended flags can be read directly.
  */
-static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
+static inline bool __console_is_usable(struct console *con, short flags,
+				       bool all_suspended, bool use_atomic)
 {
+	if (all_suspended)
+		return false;
+
 	if (!(flags & CON_ENABLED))
 		return false;
 
@@ -666,6 +710,20 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 	return true;
 }
 
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
+ * records.
+ */
+static inline bool console_is_usable(struct console *con, short flags,
+				     bool use_atomic)
+{
+	bool all_suspended = consoles_suspended_srcu_read();
+
+	return __console_is_usable(con, flags, all_suspended, use_atomic);
+}
+
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
@@ -678,6 +736,8 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 static inline bool nbcon_kdb_try_acquire(struct console *con,
 					 struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
+static inline bool __console_is_usable(struct console *con, short flags,
+				       bool all_suspended, bool use_atomic) { return false; }
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
 #endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 23a14e8c7a49..12247df07420 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -104,6 +104,13 @@ DEFINE_STATIC_SRCU(console_srcu);
  */
 int __read_mostly suppress_printk;
 
+/*
+ * Global flag for calling down all consoles during suspend.
+ * There is also a per-console flag which is used when the related
+ * device HW gets disabled, see CON_SUSPEND.
+ */
+bool consoles_suspended;
+
 #ifdef CONFIG_LOCKDEP
 static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
@@ -2731,8 +2738,6 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to hig
  */
 void console_suspend_all(void)
 {
-	struct console *con;
-
 	if (console_suspend_enabled)
 		pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
 
@@ -2749,8 +2754,7 @@ void console_suspend_all(void)
 		return;
 
 	console_list_lock();
-	for_each_console(con)
-		console_srcu_write_flags(con, con->flags | CON_SUSPENDED);
+	consoles_suspended_srcu_write(true);
 	console_list_unlock();
 
 	/*
@@ -2765,7 +2769,6 @@ void console_suspend_all(void)
 void console_resume_all(void)
 {
 	struct console_flush_type ft;
-	struct console *con;
 
 	/*
 	 * Allow queueing irq_work. After restoring console state, deferred
@@ -2776,8 +2779,7 @@ void console_resume_all(void)
 
 	if (console_suspend_enabled) {
 		console_list_lock();
-		for_each_console(con)
-			console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
+		consoles_suspended_srcu_write(false);
 		console_list_unlock();
 
 		/*

Best Regards,
Petr
