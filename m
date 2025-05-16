Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A2230BE9
	for <linux-serial@vger.kernel.org>; Fri, 16 May 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388644; cv=none; b=igw1iFJZ9A8v5BJSMNzZ0JxCBkv6cCJoEcFZTs9phKbcKEJk761eqnZXdCRWIV9mvLirymKvwrqLMCN4i/YvC7bZghtEM/PgqfbbRsMUGK8xo1WZpzOp6aFKh8ikpIHweLSyWjZ/vXQ3yZoLi8wyUxE02mDZ5EK+fJc91iA8Qy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388644; c=relaxed/simple;
	bh=F+iWm4gh0xmhPqsj7z8aDIut+eHgKGb4Z7XQRwUYRH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m7CFFRRup7jsZ+EQHTfrWpo6AIRnCe6cXxUMuLAOq5dbp4pvJOfaN+ZGAYCWQc/E/+7JVeHqNdAstN2zp2qG/02khdmHdLPAm40+JrLMl5XaMcKx3ObQHj61o+sSwAoENPiyTZf0zjfPfg59A9lzRCdWrIMk6hODDc4YSQxJdo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gvY8YQKk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Js1+4yYA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gvY8YQKk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Js1+4yYA"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747388640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QoidoMi24XMr0gV7ZT6tKiaE7KQX9Ucg+1Rm8DPUzbo=;
	b=gvY8YQKkoBGAfqtmlpBj2W/aCJ7hUmXnU2J2aGIJgubdPIGijIJhJ2LedK4Cb4Xbg/zeSO
	Rt+sn90FKszzJFICWAuRAT7/b9h+qTFxDJ+VPlZq09NbIeFveG1lfsk7rm93wRCVoljN2B
	F3e4o9G+8vrFNI9x0NndGUT0nhFaHcLvH+YkJ1KIPmaecCXOwq1RN3/9BwQONALPLzAhi1
	JeFdYs2l7ow6oi7B24+5uCrtgKTqOMS9gPeSht8T6KhiKDg09aw6pH4nw15hkey3AbND1Q
	IA+2/MCw9Mprlx7HUgb2dGhFWclfq0ppNqXDCFoZMIyeaGqGe3mL7AKxHkl5vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747388640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QoidoMi24XMr0gV7ZT6tKiaE7KQX9Ucg+1Rm8DPUzbo=;
	b=Js1+4yYAmrjeVtE80AxipZ+7BY7r1vXsTri90RnzspjEZR0/Qfcljo2P2YUdjl2cS5Cplj
	2XfQOlnVCDcjqiCg==
To: Michael Cobb <mcobb@thegoodpenguin.co.uk>, pmladek@suse.com,
 rostedt@goodmis.org, senozhatsky@chromium.org
Cc: linux-serial@vger.kernel.org, Michael Cobb <mcobb@thegoodpenguin.co.uk>
Subject: Re: [PATCH RFC 0/3] printk: Don't flush messages using write_atomic
 during console registration if kthreads have not been started yet.
In-Reply-To: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
References: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
Date: Fri, 16 May 2025 11:50:00 +0206
Message-ID: <84jz6gdh5r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Michael,

On 2025-05-14, Michael Cobb <mcobb@thegoodpenguin.co.uk> wrote:
> Hello all,
>
> When using a legacy console, there is a large amount of time during boot
> that is spent printing boot messages to the serial port. I have spent time
> looking at nbcon and the potential effects the new interface should have on
> boot times. We should expect a significant reduction in boot times as this
> work is now offloaded to a dedicated kthread.
>
> With some slight tweaks to the behaviour of nbcon during console
> registration, it is possible to reduce boot times significantly.
>
> During initial console registration, we mainly rely on two flags,
> `have_nbcon_console` and `printk_kthreads_running`, to handle the glboal
> state of nbcon and to determine the appropriate method to handle flushing
> messages.
>
> In the case of nbcon, when calling `printk()`, messages are either flushed
> by the caller using `write_atomic`, or this work is offloaded to the
> console's printk kthread. As can be seen in
> `printk_get_console_flush_type()`, under normal (i.e. non-emergency or
> panic) priority, we check the value of `printk_kthreads_running` to
> determine if nbcon consoles should be flushed via `write_atomic` or not.
>
> When `register_console()` is called to register the first nbcon console
> during boot, we know that `printk_kthreads_running` will be false as:
> - before the `printk_set_kthreads_ready` initcall, no kthreads have been
>   started since `printk_kthreads_ready` will be false.
> - after the `printk_set_kthreads_ready` initcall, `printk_kthreads_running`
>   will be false since we have not yet registered any nbcon consoles. As we
>   are registering an nbcon console, `register_console()` will set
>   `have_nbcon_console = true`. At this point, we are now in an intermediate
>   state - we have registered an nbcon console but a kthread for it has not
>   yet been started.
>
> In effect, this means that any calls made to `printk()` after
> `have_nbcon_console` has been set but before
> `printk_kthreads_check_locked()` has set `printk_kthreads_running` will use
> `write_atomic` on nbcon consoles. As `vprintk_emit()` calls
> `nbcon_atomic_flush_pending()` in this situation, we see that the newly
> registered console has all boot messages flushed in this manner.
>
> This RFC patch introduces a new flag, `printk_kthreads_pending_start`, to
> handle this intermediate state. This flag is set when an nbcon console is
> registered and cleared once `printk_kthreads_running` is set to true. We
> then check this flag under `printk_get_console_flush_type()`, so that
> printk's are deferred in this state, relying on the fact that a kthread is
> about to be started. This does not affect behaviour under panic and
> emergency priorities which are flushed via `write_atomic`.
>
> With this change applied, the flushing of printk messages on a newly
> registered nbcon console is now fully handled by the console's kthread. On
> my test hardware (Raspberry Pi 3B+), I have seen a reduction in the time
> taken to boot into userspace when using nbcon consoles from ~9s to ~1s:

If I understand the problem correctly, it is really due to the "console
enabled" message that is printed upon registration. For the first
console, it would perform a full atomic flush, even though it is about
to create the kthread printer.

What if we create the kthread _before_ printing the message. Something
like the below (untested) changes. Does this also address the issue?

John Ogness

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1eea80d0648ed..ecc0f393cacf0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4122,7 +4122,6 @@ void register_console(struct console *newcon)
 	 * users know there might be something in the kernel's log buffer that
 	 * went to the bootconsole (that they do not see on the real console)
 	 */
-	con_printk(KERN_INFO, newcon, "enabled\n");
 	if (bootcon_registered &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
 	    !keep_bootcon) {
@@ -4136,6 +4135,7 @@ void register_console(struct console *newcon)
 
 	/* Changed console list, may require printer threads to start/stop. */
 	printk_kthreads_check_locked();
+	con_printk(KERN_INFO, newcon, "enabled\n");
 unlock:
 	console_list_unlock();
 }
