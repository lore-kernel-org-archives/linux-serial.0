Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661823535B
	for <linux-serial@vger.kernel.org>; Tue,  3 Jun 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961635; cv=none; b=UdRmTwttxa3D+VBzkLyHeOSELK8SFsbP+ZI7D8Kon7FHzkRePMEGoyKLhp2EO+6JZT9hgyalkGJ/n2jTj9afKE5PYPBLnqTksuV4KuLsf/5/NzW8jAJi1OOuHZxftSR6y6VBsYm5x9KngM22JzlG2nw0f8s4Ozpq0gIBx9zE04Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961635; c=relaxed/simple;
	bh=uDUGKhFeTTw3WoQAEg2fNl0UHJrdMDdufGZss9Fs5Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrU29oOZv+ialruui6A97eZLZzi4+gwgMBs+nm8HfNuLyQ1fgo2VKg00kVGCjM7v0euQfqHKbpuaqmeGbXKKv5oCkswK092vBoOV2VHe48klgCl9Rr4tOCigPLIYQpB2LQ8NU7Uz5tL+zSox9ZXT16y2u+UB7oiE73iH34o2smY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TTwgmQZW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TTwgmQZW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so30574405e9.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Jun 2025 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748961631; x=1749566431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDfI5toC+SkLb6258xB+FmqrjFGt2PQPnJF2CWsDcZs=;
        b=TTwgmQZWC4hNuZENXWzxMSeZclzqf7TzcscXZGvi6tBH8T/uv/X88+X2rOa9ElT/k1
         HAYmnyEHFXJAHShKC0zIIforod2ptx5LktIf9XNabev8swIS78wb/69vLzFWWnNTAgM2
         hKvoRuqcFttdhdVQxWtX6CZt2F2yxnWb9UT7zfXWVPm9+yzZEHN61p2duK0R/nGTMnx5
         BOjOwxD/JPzeO7/7Tc4BfF/wA7wqB+skxAcoXCrnh8N/znVFvQD6tUiu0nCQsJeFx+tq
         87qLJkAVruP8d2sFCBJ+ftInblKgxXFFEaJRSFimCtr2pCooo9A1niQsF8AbPQe3erGj
         lp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748961631; x=1749566431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDfI5toC+SkLb6258xB+FmqrjFGt2PQPnJF2CWsDcZs=;
        b=l2jX5vnkN/Gwa2Z6MCmJKfXUbY9rMs35zrJnj0fEfrE743yhCKISq1De5anUUlU8it
         sproGr+GzZzvoltwYqTbDtqtVLInwSSHzPd+DXUZi836VZgT5W2Gy+IyCgl8vPX1DeLP
         g3EbNxp48iM4Snvtfo8+uYNuyvwxx3nzxv6lh/Y0cZWR8CSMX2t3q1k6PN3iWg8Mjjk9
         FyYYLo9NnaJY9oi7do0Phnb3/4xrxd/IWndXoXzIvTN1NJ6jfVkx89Ap9qMApt50DVLd
         2PoW7UcID/i/9VfJGXbErTtvH5/0X3CynRurRx1VSQf1Wap7vkfId43fn71TDHtO4eVL
         PaHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6mjwH7ng081a4SowwGc/WdlAEiXxevAORaw40GY5gHcoRXbdD60DHJ9XTop7HJ61mn2uF8iWQ4Ce0/OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIucCAaKwFilIgKE1rx6xOnVaejGa4AwY63RULqxvg8c3SYlod
	Frw3dtbwo+ObeNEq1uRLhCBZ23kVbXPLzxA6tF6FCm+t9mqlFG74UYcs7wzbOO7if8I=
X-Gm-Gg: ASbGncsqVRGNP5S3mS3BAyVB5en7konwiOldTW+Ap46ndXMQNb3Yru4iuzd+WpMUm1B
	DuFaRZPe/bPe4vDBdo3LIudCbZpxxp40PnJef/fkghoCEhJQMnnQx07/Snl+fQ5wCB4GM8PH99K
	nEaGyaM+9LDrxlNS7rCOAJVnxsEPbjIcEuHu3KaD0goqYzIyjRwnvDf46Jy3PiPRqRJNQFTSNr5
	EHcJDAh2K02hkhLpUwfYn4NO0UZXAT0wfN+bZs115W8Qo94uzpXg16bh6VdsxBQtpPl5x4VXFcv
	AwGg2Uf+Wmn61JU9+WHsAG8C0sClVHX9Z2vVAYOdRRPhMhrmtiPzHzsYa5AqSRE00KoWmxnEaxA
	=
X-Google-Smtp-Source: AGHT+IFztSVo85r0TGArHGZmABpW5pmkxQBgpiU+shLPyvgUqqSTRsp23fPQ2mpbAxZjLNuGw2CrCA==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:e0f4:e455 with SMTP id ffacd0b85a97d-3a51417b3a7mr2667739f8f.11.1748961630721;
        Tue, 03 Jun 2025 07:40:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e332614sm7421197a91.49.2025.06.03.07.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 07:40:30 -0700 (PDT)
Date: Tue, 3 Jun 2025 16:40:16 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Michael Cobb <mcobb@thegoodpenguin.co.uk>, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] printk: Don't flush messages using write_atomic
 during console registration if kthreads have not been started yet.
Message-ID: <aD8JOlDVP4ufgv44@pathway.suse.cz>
References: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
 <84jz6gdh5r.fsf@jogness.linutronix.de>
 <CAC251sUpHHU26wDgBuOGdxNGvE=2M22+b5E4Y+Lc9Ow63fOidw@mail.gmail.com>
 <847c1xrzib.fsf@jogness.linutronix.de>
 <84iklerw1i.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84iklerw1i.fsf@jogness.linutronix.de>

Hi,

I am sorry for the late reply. I have hard times to catch up after
a conference...

On Mon 2025-06-02 17:46:57, John Ogness wrote:
> On 2025-05-31, John Ogness <john.ogness@linutronix.de> wrote:
> This won't work. printk_kthreads_check_locked() must come after the
> boot-console unregister-loop. The kthreads do not start if boot consoles
> are registered.
> 
> I spent some time thinking about how to get a clean implementation of
> this optimization. It is tricky because:
> 
> - If the console is registered before printk_kthreads_ready=true, then
>   the optimization cannot be used (i.e. the console must do the atomic
>   flushing).
> 
> - If the console fails to start its kthread, then it must do the atomic
>   flush when unregistering.
> 
> Perhaps something like this:
> 
> @@ -4072,6 +4082,18 @@ void register_console(struct console *newcon)
>  	if (newcon->flags & CON_BOOT)
>  		have_boot_console = true;
>  
> +	/*
> +	 * Begin boot optimization.
> +	 * If this is the first console and kthreads are available, avoid
> +	 * flushing the backlog until the printing kthread has had a chance
> +	 * to start via printk_kthreads_check_locked() below.
> +	 */
> +	if (hlist_empty(&console_list) &&

I am not sure if the check of empty_list is correct. There could be
legacy consoles...

> +	    (newcon->flags & CON_NBCON) &&
> +	    printk_kthreads_ready) {
> +		printk_kthread_pending_start = true;
> +	}
> +
>  	/*
>  	 * If another context is actively using the hardware of this new
>  	 * console, it will not be aware of the nbcon synchronization. This

Anyway, the console registration code is tricky like hell. There are
so many variables, twists, ...

I thought whether we could avoid introducing yet another variable
and still keep the code sane. And I came with the following.
The commit messages describes the idea.

I hope that I have covered all the cases. Note that I haven't tested
it with nbcon console though.

What do you think, please?

From 5768ff7e9d944bb904344341a2a447d2f101e6ba Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Tue, 3 Jun 2025 14:19:00 +0200
Subject: [PATCH] printk: Allow to use the printk kthread immediately even for
 1st nbcon

The kthreads for nbcon consoles are created by nbcon_alloc() at the beginning
of the console registration. But it currently works only for the 2nd or
later nbcon console because the code checks @printk_kthreads_running.

The kthread for the 1st registered nbcon console is created at the very
end of register_console() by printk_kthreads_check_locked(). As a result,
the entire log is replayed synchronously when the "enabled" message
gets printed. It might block the boot for a long time with a slow serial
console.

Prevent the synchronous flush by creating the kthread even for the 1st
nbcon console when it is safe (kthreads ready and no boot consoles).

Also inform printk() to use the kthread by setting @printk_kthreads_running.
Note that the kthreads already must be running when it is safe and this
is not the 1st nbcon console.

Symmetrically, clear @printk_kthreads_running when the last nbcon
console was unregistered by nbcon_free(). This requires updating
@have_nbcon_console before nbcon_free() gets called.

Note that there is _no_ problem when the 1st nbcon console replaces boot
consoles. In this case, the kthread will be started at the end
of registration after the boot consoles are removed. But the console
does not reply the entire log buffer in this case. Note that
the flag CON_PRINTBUFFER is always cleared when the boot consoles are
removed and vice versa.

Closes: https://lore.kernel.org/r/20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 17 +++++++++++++++--
 kernel/printk/printk.c   | 19 ++++++++++---------
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 48a24e7b309d..567c9e100d47 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -64,6 +64,7 @@ struct dev_printk_info;
 
 extern struct printk_ringbuffer *prb;
 extern bool printk_kthreads_running;
+extern bool printk_kthreads_ready;
 extern bool debug_non_panic_cpus;
 
 __printf(4, 0)
@@ -180,6 +181,7 @@ static inline void nbcon_kthread_wake(struct console *con)
 #define PRINTKRB_RECORD_MAX	0
 
 #define printk_kthreads_running (false)
+#define printk_kthreads_ready (false)
 
 /*
  * In !PRINTK builds we still export console_sem
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fd12efcc4aed..7519d09c20e7 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1671,6 +1671,9 @@ bool nbcon_alloc(struct console *con)
 {
 	struct nbcon_state state = { };
 
+	/* Synchronize the kthread start. */
+	lockdep_assert_console_list_lock_held();
+
 	/* The write_thread() callback is mandatory. */
 	if (WARN_ON(!con->write_thread))
 		return false;
@@ -1701,12 +1704,15 @@ bool nbcon_alloc(struct console *con)
 			return false;
 		}
 
-		if (printk_kthreads_running) {
+		if (printk_kthreads_ready && !have_boot_console) {
 			if (!nbcon_kthread_create(con)) {
 				kfree(con->pbufs);
 				con->pbufs = NULL;
 				return false;
 			}
+
+			/* Might be the first kthread. */
+			printk_kthreads_running = true;
 		}
 	}
 
@@ -1721,8 +1727,15 @@ void nbcon_free(struct console *con)
 {
 	struct nbcon_state state = { };
 
-	if (printk_kthreads_running)
+	/* Synchronize the kthread stop. */
+	lockdep_assert_console_list_lock_held();
+
+	if (printk_kthreads_running) {
 		nbcon_kthread_stop(con);
+		/* Might be the last nbcon console */
+		if (!have_nbcon_console)
+			printk_kthreads_running = false;
+	}
 
 	nbcon_state_set(con, &state);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1eea80d0648e..af6e4f0e8e22 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3574,7 +3574,7 @@ EXPORT_SYMBOL(console_resume);
 static int unregister_console_locked(struct console *console);
 
 /* True when system boot is far enough to create printer threads. */
-static bool printk_kthreads_ready __ro_after_init;
+bool printk_kthreads_ready __ro_after_init;
 
 static struct task_struct *printk_legacy_kthread;
 
@@ -3713,6 +3713,7 @@ static void printk_kthreads_check_locked(void)
 	if (!printk_kthreads_ready)
 		return;
 
+	/* Start or stop the legacy kthread when needed. */
 	if (have_legacy_console || have_boot_console) {
 		if (!printk_legacy_kthread &&
 		    force_legacy_kthread() &&
@@ -4204,14 +4205,6 @@ static int unregister_console_locked(struct console *console)
 	 */
 	synchronize_srcu(&console_srcu);
 
-	if (console->flags & CON_NBCON)
-		nbcon_free(console);
-
-	console_sysfs_notify();
-
-	if (console->exit)
-		res = console->exit(console);
-
 	/*
 	 * With this console gone, the global flags tracking registered
 	 * console types may have changed. Update them.
@@ -4232,6 +4225,14 @@ static int unregister_console_locked(struct console *console)
 	if (!found_nbcon_con)
 		have_nbcon_console = found_nbcon_con;
 
+	if (console->flags & CON_NBCON)
+		nbcon_free(console);
+
+	console_sysfs_notify();
+
+	if (console->exit)
+		res = console->exit(console);
+
 	/* Changed console list, may require printer threads to start/stop. */
 	printk_kthreads_check_locked();
 
-- 
2.49.0

