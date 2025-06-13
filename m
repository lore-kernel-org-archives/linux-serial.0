Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304161E871
	for <linux-serial@vger.kernel.org>; Fri, 13 Jun 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828029; cv=none; b=Q2oqeKEN0g7MqYkG+GMQRKyzYTA36m2KMtDkT/C51/PPR/+87931H8fXatNnIr8bX82balrdK0OIdlEKYK7MQQlcS+GSUIVqtjlUWktKAN+E3MxX0PZAAYJAkdElqtPuiIwTltdGToAlmAZtGgbObze7HPt3lh2NO+NCJi4RKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828029; c=relaxed/simple;
	bh=bHZCmRyoCFqPaolfBcOdZMuw2qzfLKgx2uxtsbOw/I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZUnmfkDiLJ4mFDIb8DzlWpxh8JxVXyO0U53axMj4HmEJKTctZ8Fg7CWMqiRbsL7F1jelq5H6VCBOKfGlOwITsdcCa+EW3Al6D9Hl6XIQ59U7KBnnW4tPvW98x734QC8PWmucFQd6KD7ZQZWeh4NxzUxaDB0WuLyozRDL11mFLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FlqJBSah; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FlqJBSah"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-441ab63a415so25353205e9.3
        for <linux-serial@vger.kernel.org>; Fri, 13 Jun 2025 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749828025; x=1750432825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKghZF40bURJv6c1/M9CEvL/tJPBCTMeZ3wBhbe2yAU=;
        b=FlqJBSahzSpbI9dAsRkte9fmFMq2L/gH9rgzJMmosPJirhF2cKzwgHV1Wcvujf/2DR
         VbsO0P/E1nWuoQUR9MqsCmicsNQm+NQuGGxJiZN6uywnlSSrdQQ7Jv//xuBKK1kN8VjO
         V7Az0WYoLLg6URg98f3PgUZpINs/uGHJbqka2Cu+VL1a3ZxbvcO5hsV8OLxyV/Y2Entn
         BuwtjTcicUVE9YCaC5eDMEWvEaSlDsibafMdbPpI6OkUJ1O2Hd2pVtr1k2+XzFxiYASN
         vtNbrAVwWAAFxAQpnZGC0xrG42VNEHpKcrdTxPXV51m9EyfMs/ln4StS9kEOePWPYyZu
         46DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749828025; x=1750432825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKghZF40bURJv6c1/M9CEvL/tJPBCTMeZ3wBhbe2yAU=;
        b=L0S6zlO2XY73Xac2WRwGLw8eT3r+8jwvuWSwfTukbKDtSRBece2af7blLKF36IhYLz
         QV7QHJLcuk5JNMKByx40w2DUwnehMFbrP5HQoT+13tHgI9BFX8urKdjXCqPGA/6pZ6rV
         3nnckiV203XAXMMhjHL7HIUf7WZQmPus95hUPEfSHe/C27l6qDElP1mv8fyxXuEqZwCx
         tUmDSJA7yVRa37bwyLz9lqwKCruluqMBZR4xkQDSUs10dRnTBlHj7sQsETyiGkIuXyvb
         m9agBUWJgT3Q4iE3uY9oXbx15m4KI+cM4QiFNe7flNTnqQBJ7xqaCBhp0UNg0HCxFJ6V
         W3cg==
X-Forwarded-Encrypted: i=1; AJvYcCUPrgh6LdHWHchc+UM628k9xAJSEl4J+e1qytyrNXVYHV+KCxb0USYIWxZuoj1g2aqiOVK3fyH6ZjKPcwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYG51RLeSXWEpHJR2CEL94+9ytLZPQ0g85kPe44DXHvUIVRIS
	O6sbiHgET6Ltrb2AOde5G+nCCt21WYRd7CJTz+e/21IOcebqzB9D2YZf2288DJ2KCvo=
X-Gm-Gg: ASbGncsE8Pkdbpq/kwlpftmorh3KmAPweLw8oXKXhBXeQQcx7SEcjJKnVhUhOPW3ouv
	rDw3mWjY+5EcbZP08Nyv8jjc/SlCF8nVux92g73nwHHrUt+17Vrh6JOTOmQo3C2eUxB0f9aMhlN
	J2MtPLsq79bQ25mjB1oohcMt0zJcbtm3K/z+zHAe4YpIAnlnVZVaOiBkaG+Ukt4mfwYpyllTyFU
	4Qx4x1eUNK7fxGT8JzPEQnfgcPzNV4V9p1dlyr23xg8SzfBrQ3xtEGpP4EY1M0JdEzLohiF2pcj
	NnN4WI0kRQKtoMxmiWyQy9lWn5OFu60KC9bspAHI1StsiHvBxJptVUInOAB/u2dt
X-Google-Smtp-Source: AGHT+IG0wPBdTWS6wVof0adSsVA4MK43CPoXzZFMCGpr9V6ukNZIjbxKLrOISAjwEQzvtDU5jyZr4A==
X-Received: by 2002:a05:6000:25eb:b0:3a3:65b5:51d7 with SMTP id ffacd0b85a97d-3a572e2df7bmr142313f8f.26.1749828025451;
        Fri, 13 Jun 2025 08:20:25 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1691d7fsm1835856a12.69.2025.06.13.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:20:24 -0700 (PDT)
Date: Fri, 13 Jun 2025 17:20:03 +0200
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
Subject: Re: [PATCH 2/7] printk: Use consoles_suspended flag when
 suspending/resuming all consoles
Message-ID: <aExBo-8cVOy6GegR@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>

On Fri 2025-06-06 23:53:44, Marcos Paulo de Souza wrote:
> Instead of update a per-console CON_SUSPENDED flag, use the console_list
> locks to protect this flag. This is also applied to console_is_usable
> functions, which now also checks if consoles_suspend is set.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  kernel/printk/internal.h |  7 ++++++-
>  kernel/printk/nbcon.c    |  8 ++++----
>  kernel/printk/printk.c   | 23 ++++++++++-------------
>  3 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 48a24e7b309db20fdd7419f7aeda68ea7c79fd80..752101904f44b13059b6a922519d88e24c9f32c0 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -118,8 +118,12 @@ void nbcon_kthreads_wake(void);
>   * which can also play a role in deciding if @con can be used to print
>   * records.
>   */
> -static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
> +static inline bool console_is_usable(struct console *con, short flags,
> +				     bool use_atomic, bool consoles_suspended)
>  {
> +	if (consoles_suspended)
> +		return false;
> +
>  	if (!(flags & CON_ENABLED))
>  		return false;
>  
> @@ -212,6 +216,7 @@ extern bool have_boot_console;
>  extern bool have_nbcon_console;
>  extern bool have_legacy_console;
>  extern bool legacy_allow_panic_sync;
> +extern bool consoles_suspended;
>  
>  /**
>   * struct console_flush_type - Define available console flush methods
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index fd12efcc4aeda8883773d9807bc215f6e5cdf71a..72de12396e6f1bc5234acfdf6dcc393acf88d216 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1147,7 +1147,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
>  	cookie = console_srcu_read_lock();
>  
>  	flags = console_srcu_read_flags(con);
> -	if (console_is_usable(con, flags, false)) {
> +	if (console_is_usable(con, flags, false, consoles_suspended)) {

The new global console_suspended value has the be synchronized the
same way as the current CON_SUSPENDED per-console flag.
It means that the value must be:

  + updated only under console_list_lock together with
    synchronize_rcu().

  + read using READ_ONCE() under console_srcu_read_lock()


I am going to propose more solutions because no one is obviously
the best one.

Variant A:
=========

Create a helper functions, similar to
console_srcu_read_flags() and console_srcu_write_flags():

Something like:

static inline bool console_srcu_read_consoles_suspended()
{
	WARN_ON_ONCE(!console_srcu_read_lock_is_held());

	/*
	 * The READ_ONCE() matches the WRITE_ONCE() when the value
	 * is modified console_srcu_write_consoles_suspended().
	 */
	return data_race(READ_ONCE(consoles_suspended));
}

static inline void console_srcu_write_consoles_suspended(bool suspended)
{
	lockdep_assert_console_list_lock_held();

	/* This matches the READ_ONCE() in console_srcu_read_consoles_suspended(). */
	WRITE_ONCE(consoles_suspended, suspended);
}

This has the drawback that most console_is_usable() callers would need
to get and pass both variables, for example:

--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1137,6 +1137,7 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
  */
 static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_context *ctxt)
 {
+	bool cons_suspended;
 	bool ret = false;
 	short flags;
 	int cookie;
@@ -1147,7 +1148,8 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 	cookie = console_srcu_read_lock();
 
 	flags = console_srcu_read_flags(con);
-	if (console_is_usable(con, flags, false)) {
+	cons_suspended = console_srcu_read_consoles_suspended();
+	if (console_is_usable(con, flags, false, cons_suspended)) {
 		/* Bring the sequence in @ctxt up to date */
 		ctxt->seq = nbcon_seq_read(con);

Pros:

   + always correct

Cons:

   + not user friendly



Variant B:
==========

Do not pass @consoles_suspended as a parameter. Instead, read it
in console_us_usable() directly.

I do not like this because it is not consistent with the con->flags
handling and it is not clear why.


Variant C:
==========

Remove even @flags parameter from console_is_usable() and read both
values there directly.

Many callers read @flags only because they call console_is_usable().
The change would simplify the code.

But there are few exceptions:

  1. __nbcon_atomic_flush_pending(), console_flush_all(),
     and legacy_kthread_should_wakeup() pass @flags to
     console_is_usable() and also check CON_NBCON flag.

     But CON_NBCON flag is special. It is statically initialized
     and never set/cleared at runtime. It can be checked without
     READ_ONCE(). Well, we still might want to be sure that
     the struct console can't disappear.

     IMHO, this can be solved by a helper function:

	/**
	 * console_srcu_is_nbcon - Locklessly check whether the console is nbcon
	 * @con:	struct console pointer of console to check
	 *
	 * Requires console_srcu_read_lock to be held, which implies that @con might
	 * be a registered console. The purpose of holding console_srcu_read_lock is
	 * to guarantee that no exit/cleanup routines will run if the console
	 * is currently undergoing unregistration.
	 *
	 * If the caller is holding the console_list_lock or it is _certain_ that
	 * @con is not and will not become registered, the caller may read
	 * @con->flags directly instead.
	 *
	 * Context: Any context.
	 * Return: True when CON_NBCON flag is set.
	 */
	static inline bool console_is_nbcon(const struct console *con)
	{
		WARN_ON_ONCE(!console_srcu_read_lock_is_held());

		/*
		 * The CON_NBCON flag is statically initialized and is never
		 * set or cleared at runtime.
		return data_race(con->flags & CON_NBCON);
	}


   2. Another exception is __pr_flush() where console_is_usable() is
      called twice with @use_atomic set "true" and "false".

      We would want to read "con->flags" only once here. A solution
      would be to add a parameter to check both con->write_atomic
      and con->write_thread in a single call.

      But it might actually be enough to check is with the "false"
      value because "con->write_thread()" is mandatory for nbcon
      consoles. And legacy consoles do not distinguish atomic mode.


Variant D:
==========

We need to distinguish the global and per-console "suspended" flag
because they might be nested. But we could use a separate flag
for the global setting.

I mean that:

    + console_suspend() would set CON_SUSPENDED flag
    + console_suspend_all() would set CON_SUSPENDED_ALL flag

They both will be in con->flags.

Pros:

    + It is easy to implement.

Cons:

    + It feels a bit ugly.


My opinion:
===========

I personally prefer the variant C because:

  + Removes one parameter from console_is_usable().

  + The lockless synchronization of both global and per-console
    flags is hidden in console_is_usable().

  + The global console_suspended flag will be stored in global
    variable (in compare with variant D).

What do you think, please?

Best Regards,
Petr


PS: The commit message and the cover letter should better explain
    the background of this change.

    It would be great if the cover letter described the bigger
    picture, especially the history of the console_suspended,
    CON_SUSPENDED, and CON_ENABLED flags. It might use info
    from
    https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/
    and maybe even this link.

    Also this commit message should mention that it partly reverts
    the commit 9e70a5e109a4a233678 ("printk: Add per-console
    suspended state"). But it is not simple revert because
    we need to preserve the synchronization using
    the console_list_lock for writing and SRCU for reading.
