Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7427456
	for <linux-serial@vger.kernel.org>; Sat, 31 May 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748677761; cv=none; b=Cump5WywgiAwzn7Da48zfLt9pKgSOIcHw78/aYAuIr2r5nK7yDWa/ZGWW9ekZ3Rg3v5SPTwnMJA5+kBteI0afpkK+xNHtN+Tk9sweUajfLAKs7stTia+Wk13yuC1McyW/p2+y1yxpAj7N22DLUOi2VHSpAcB+vC54JtJH6s3NBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748677761; c=relaxed/simple;
	bh=CyNSMyiMWd3SzqA7ufkwY2qUvOzg7NpoWk6iBdctArw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lRrVv/pZ0HLP2hR+gDWfDY4E7M6wMIr8JATY3G53e8HmGc/bPLcW410DiAimg2zmXcYTUQ+unTHf6gEFUFpPvCNCGuqnyFkQdPc3dJcSMHJzTdH7wa1VDk5vl7UhdtC/EUwnc2wRh24YA/LukG4NzdW2kwt7RzXJCrylqprEhEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=no6Ha8nA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6rBk6hIB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="no6Ha8nA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6rBk6hIB"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748677757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4ioo6gIdu0kA2jB1wmvqYu015ydGbJWJxI/Jkf9moE=;
	b=no6Ha8nAGkk38vz3fBW/5qzkg6Zto2MRaVsnEWpOHoEn7FcgaTA8Qt+06DgkSzQClNUEYS
	QtCWwkZSr846y3vkavkDDE0DNmTWUdsAsevEXgqM8vJ/qzMWxadLSgKaa1gjg8qVuhK+gJ
	WnkZLWuocjzy730EJLSrJqGQt6TKJIbY6wzH1YTt0ammZhDfi4bCJxk7HBxUg3rxl/nYXN
	WYDKGt1s/sbbKKOpAiLpVXZ3IlN6D8eITdSXZRJOsLz7Q+xWMBKUMsMpKxnjF5LYChg9r/
	OThlze84YO/hS0phrCuo6wqIbHkI+Q/yOlT3pKunWyKHRd6uH12fGcNUQzTrWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748677757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4ioo6gIdu0kA2jB1wmvqYu015ydGbJWJxI/Jkf9moE=;
	b=6rBk6hIB1IHn8nhN5dkdLbpFKCX1R+yjhyxZRG+P8myK5+b3gF48nA+aJqSeXqPSoCiv1e
	EcShzwlbIhV7jvBA==
To: Michael Cobb <mcobb@thegoodpenguin.co.uk>
Cc: pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] printk: Don't flush messages using write_atomic
 during console registration if kthreads have not been started yet.
In-Reply-To: <CAC251sUpHHU26wDgBuOGdxNGvE=2M22+b5E4Y+Lc9Ow63fOidw@mail.gmail.com>
References: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
 <84jz6gdh5r.fsf@jogness.linutronix.de>
 <CAC251sUpHHU26wDgBuOGdxNGvE=2M22+b5E4Y+Lc9Ow63fOidw@mail.gmail.com>
Date: Sat, 31 May 2025 09:55:16 +0206
Message-ID: <847c1xrzib.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-05-30, Michael Cobb <mcobb@thegoodpenguin.co.uk> wrote:
> On Fri, 16 May 2025 at 10:44, John Ogness <john.ogness@linutronix.de> wrote:
>> What if we create the kthread _before_ printing the message. Something
>> like the below (untested) changes. Does this also address the issue?
>
> Yes, that works and avoids the atomic flush, however we then lose the
> "console [ttyS0] enabled" message on any boot consoles that we are
> about to unregister.

Right. I was going about it wrong. Really we should start the threads as
soon as the console is fully registered. Waiting until after the boot
consoles are unregistered is wrong. So how about this change instead?

Note that printk_kthreads_check_locked() is only needed for the newly
added console. If any boot console is unregistered,
printk_kthreads_check_locked() is called again in
unregister_console_locked().

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1eea80d0648ed..b142d69330de2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4115,6 +4115,9 @@ void register_console(struct console *newcon)
 
 	console_sysfs_notify();
 
+	/* Changed console list, may require printer threads to start/stop. */
+	printk_kthreads_check_locked();
+
 	/*
 	 * By unregistering the bootconsoles after we enable the real console
 	 * we get the "console xxx enabled" message on all the consoles -
@@ -4133,9 +4136,6 @@ void register_console(struct console *newcon)
 				unregister_console_locked(con);
 		}
 	}
-
-	/* Changed console list, may require printer threads to start/stop. */
-	printk_kthreads_check_locked();
 unlock:
 	console_list_unlock();
 }


> I am worried that by avoiding calling printk() to not trigger a flush,
> this might not be robust enough?

The problem is that we cannot trust that the kthreads will start.

I think my above change is correct because it starts the kthreads before
unregistering the boot console, so if there are any problems, the boot
consoles are still around to report them.

In your case you have no boot consoles, so you really just want to avoid
all atomic printing until the kthread has had a chance. Something like
this change might be more appropriate:

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
index 1eea80d0648ed..9c0378dc88c4c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4072,6 +4072,14 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_BOOT)
 		have_boot_console = true;
 
+	/*
+	 * If this is the first console, avoid flushing the backlog
+	 * until the printing kthread has had a chance to start via
+	 * printk_kthreads_check_locked() below.
+	 */
+	if (hlist_empty(&console_list) && (newcon->flags & CON_NBCON))
+		printk_kthread_pending_start = true;
+
 	/*
 	 * If another context is actively using the hardware of this new
 	 * console, it will not be aware of the nbcon synchronization. This
@@ -4115,6 +4123,10 @@ void register_console(struct console *newcon)
 
 	console_sysfs_notify();
 
+	/* Changed console list, may require printer threads to start/stop. */
+	printk_kthreads_check_locked();
+	printk_kthread_pending_start = false;
+
 	/*
 	 * By unregistering the bootconsoles after we enable the real console
 	 * we get the "console xxx enabled" message on all the consoles -
@@ -4133,9 +4145,6 @@ void register_console(struct console *newcon)
 				unregister_console_locked(con);
 		}
 	}
-
-	/* Changed console list, may require printer threads to start/stop. */
-	printk_kthreads_check_locked();
 unlock:
 	console_list_unlock();
 }

Notice that I kept the control of the new flag inside the register
function.

I do not really like this because printk_get_console_flush_type() is now
checking an extra flag every time for something that is a special case
and only at boot. Although, theoretically, it can happen anytime that
all consoles are removed during runtime and then later added.

Thoughts?

John
