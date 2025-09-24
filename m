Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B021ABB9
	for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706510; cv=none; b=RdYndIsnE7+JFkYc3q7Q4daXXbocO1hrTCSJc6BDXrgUH6AA9604+HML+3PYiI1xoDQThobM42b4kZvQHENMfjuVqgqH+zzNgjQgPd20HYR7UE9d1SA1wnrSijLv6kFjoenZXCy0aBFTKU8VcMIA4aGcqNpSblZMsa3YIjoEnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706510; c=relaxed/simple;
	bh=dtv6qQSyv8wNo01XrYxi1x44Q05Hfd0zs/RAWWaxCRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTN6DPqzgWVN8M0dvFuj7rtFK0SRJV9usdQ++ukQEyfwLO9SZ7L8UhGU+s9YU1NY9gmsWsysoEIfYgFo3dj7/alyGcE84dOw0Z6Rgn1tmCuAzwEXr1Bwc2/UajnQ5hAnmWsvD81Wt1Ifycrpa3SOUllASqAsYjxHx+YzbZZm6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H1wJB2Qd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H1wJB2Qd"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b2ee3c13aa4so377812966b.3
        for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2025 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758706501; x=1759311301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+ihV7jV/UICW3GYPXjrr7V6munvA5WIXtGqiGQ9m6w=;
        b=H1wJB2QdJ4HGB2jfyua6uAjg3GIt6plIPqechsrUiUENO5ea3WKs6LBnjkurf4Eh9A
         ZcieqBMJUVyS3TwHmZvdsHK8rB39jX28glHy+nJzSoA152f+QZNuIzd6yWi33LIDCDQK
         y1UMlXbHe+EtwJO/zsIbJTv2t1MOvAUfH+OLJeHOv68w+TXJHfk+PFnR4g//o8RoIiEK
         vC4mcsGgFytnNLq93srqF5qE6V4+lYUoIiSWVb7ggWBDDJ9Iof9hN2XVlsY3OZXRsChJ
         jckyJl+KO1nVdoZjJpXAboqOjrq/Se5HP8MRdVorfm55M+4BVjjIPyWdxHs5jDccgi1c
         X4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758706501; x=1759311301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+ihV7jV/UICW3GYPXjrr7V6munvA5WIXtGqiGQ9m6w=;
        b=JCXdkluLKHXrGKwIa8YRF4AadbyUNpUjGvUz2643CEuiDTAYv9J/+LLKa2ZyVCUciO
         xW+dymWEoABnO2Onw0bUl+co65EsLHmvrrhqTsCGvIkd396xfB64jL9JCpNytRZ9MT1s
         NUHV5OqB1ZoNJic6dxo072uCe6Is/QDatXhSLxPCYgFmN7rkNsEL89cs6o86TxVW8cx9
         jPZZmyLSk7yBDokC4KKPO72pNfXPxxe+sJXpjABaIth1nsqnGKiSrfgtnwdAKeSln+/J
         c1Z44dBZ42XlYbdqlWu6dhAKknsFJAHvByv3Nj0jvaTxp1ASUYC+DpeIHNMghAq9snVN
         KLJg==
X-Forwarded-Encrypted: i=1; AJvYcCXd9dRhHhaeddYLSXjFM7hko9t0qMTrgmMe8u03/vwFbenlAGlinpwjMyXfxDurffBBi18HTgky5wnJDkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMIRL1di+nFIyJv+EFjXX2dBRind9X8AuWI+j4WPVAk3Or5c28
	+PrlEyR84mRG/IEAlgYOpaDjLo+une4VnqpEfkrJ1lyL35xM/U63EiqiktJAJb2Bc9zlExXKeNQ
	HtWUrPxo=
X-Gm-Gg: ASbGnctOi+/SVNojjF7G03SbUCTl2Z95yI1lUQgbQOimz6AY1BjnKKvOR7+0lVUuFqx
	oEFDqQzWXtX+Ex88pHTfbAs6FUWRDbG6x6AwmTPIPW9h6VCexGUZsvvYp8LmvIplrTFnie7s4Gg
	AH38IwQB4Pe3FVbqFsF2TF4VteN6uRbpkfvVzO3TlqHiOhLoJ1qPwlvo1GoR0SqzaGAQs6g2tRC
	NRWS4wkyFsWrP3b3LdEwZKn7h37QzQCcX0AuHMGWyCGLJJExwTleEfQAvPbKO0OFLgNCPLhNo3e
	HKsk/Dl8uYX48m1ehG2dh2m5eZIH1aY9v+28Nop+z50ywS3A/AVGBXBABepMF9GAHcaROfwKPHw
	Ox6hrSG8bMJl4JuEu9QgMmnDT1w==
X-Google-Smtp-Source: AGHT+IFOqkCP6uCn+xuTQwfoECo9gdpCJo1Fnr9mCXr8jQsSVZtd2TBLjEJ0j31UiSIYq1cXct6rFA==
X-Received: by 2002:a17:907:3e04:b0:b04:31c6:a41f with SMTP id a640c23a62f3a-b302af26175mr616109566b.41.1758706501354;
        Wed, 24 Sep 2025 02:35:01 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b26847b9f37sm1153007366b.18.2025.09.24.02.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 02:35:00 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:34:58 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [RFC 0/1] serial: 8250: nbcon_atomic_flush_pending() might
 trigger watchdog warnigns
Message-ID: <aNO7Qjv_iSUSifTv@pathway.suse.cz>
References: <20250822142502.69917-1-pmladek@suse.com>
 <84qzwzbr90.fsf@jogness.linutronix.de>
 <aNFR45fL2L4PavNc@pathway.suse.cz>
 <84348eju8a.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84348eju8a.fsf@jogness.linutronix.de>

On Mon 2025-09-22 19:08:45, John Ogness wrote:
> On 2025-09-22, Petr Mladek <pmladek@suse.com> wrote:
> > On Mon 2025-08-25 13:06:27, John Ogness wrote:
> >> On 2025-08-22, Petr Mladek <pmladek@suse.com> wrote:
> >> > There are clearly visible two points where nbcon_atomic_flush_pending()
> >> > took over the ownership from a lover priority context. I believe that:
> >> >
> >> >   + 1st occurrence is triggered by the "WARNING: CPU: 2 PID: 1 at
> >> >     arch/x86/..." line printed with NBCON_PRIO_EMERGENCY.
> >> >
> >> >   + 2nd occurrence is triggered by the "Kernel panic - not syncing:
> >> >     Hard LOCKUP" line printed with NBCON_PRIO_PANIC.
> >> >
> >> > There were flushed more than 2500lines, about 240kB of characters,
> >> > in the NBCON_PRIO_EMERGENCY before the hardlockup detector
> >> > triggered panic.
> >> >
> >> > If I count it correctly, a serial console with the speed 115200 baud/sec
> >> > would be able to emit about 11.5kB/sec. And it would take about 20sec
> >> > to emit the 240kB of messages.
> >> >
> >> > => softlockup is quite realistic
> >> >
> > Well, the original problem happened on bare metal. And the problem
> > was reporoducible even with the extra touch_nmi_watchog() in
> > univ8250_console_write_atomic().
> >
> > By other words, touch_nmi_watchog() delays hardlockup report
> > only on the given CPU.
> >
> > An solution is to touch the watchdog also in nbcon_reacquire_nobuf()
> > because it might get blocked from known reasons. Something like:
> >
> > Alternative solution would be to release the console ownership in
> > __nbcon_atomic_flush_pending_con() between each record. It might
> > give the kthread a chance to restore the IRQ setting an continue.
> >
> > It might be better. But we would need to make sure that the kthread
> > would stay blocked until the emergency context flushes all messages.
> > Otherwise, the kthread would repeatedly lose the console ownership
> > in the middle of the message when __nbcon_atomic_flush_pending_con()
> > would acquire the context with NBCON_EMERGENCY_PRIO for the next
> > pending message.
> >
> > We might need similar handshake also between panic and emergency
> > context.
> >
> > I am not sure if this is worth the complexity.
> >
> > What do you think?
> 
> Originally I had implemented the atomic flushing to release between
> records. The problem is, as you mentioned, that the threaded printers
> keep jumping back in. So you end up with lots of "replaying previous
> printk message" from the atomic printer taking over all the time. This
> is visible from a simple WARN() and it is ugly as hell.
> 
> Trying to make the output clean is quite tricky. Mainly because the
> lower-prio context (which may or may not be the kthread printer) and the
> higher-prio context need to understand each other's intentions and
> somehow coordinate. My code started to look like I was implementing a
> second layer of ownership (indended ownership) and/or some type of
> bizarre scheduling with "printing-prio boosting" and/or "proxy console
> ownership". It was a lot of code to make emergency blocks look sane.

I tried to implement some naive solution, see below. I think that
it can be described as the 2nd layer of ownership.

It does not look that complicated. It might be because I used it only
in two paths which do the writing. And it is possible that it does
not work properly.

Then I got another idea. It might even easier.

> In the end I decided to keep things simple and let the kthread printer
> busy-wait,

I think that it might actually be enough to block the kthread when
any CPU is in emergency context, for example, by using a global
atomit counter.

There should not be problem with panic because
nbcon_context_try_acquire() fails on non-panic CPUs anyway.

I am going to try this approach.

> possibly with interrupts disabled. Your suggestion of adding
> touch_nmi_watchdog() to nbcon_reacquire_nobuf() would also follow that
> line of simplicity. The simplicity comes at the cost of possibly having
> two CPUs dedicated to atomically flushing a single console (one that is
> actually printing and one that is the busy-waiting normal-prio printer).

Yup.

> Note that for PREEMPT_RT the hardware interrupts are not actually
> disabled. That is not an excuse to keep things this way, just a
> reminder. Non-RT may also want to use that 2nd CPU for something useful,
> in which case we would need the higher-prio printer to somehow
> temporarily yield ownership to the lower-prio printer. And quite
> frankly, that is not something the nbcon console ownership model was
> designed to support.

Good to know.

> If we can come up with an elegant way to handle the temporary transfer
> while preserving clean output, I am all for it. I will take another look
> and see if I can come up with a _proper_ (no duct tape) solution.

I am not sure if you already started working on it. I rather share
my naive ideas early so that I do not duplicate the effort.
It is possible that you have been there.

Anyway, here is POC of an API which blocks writing/flushing
in a context with a lower priority:

From 5d8f9c61c8f67096feca5972c5e7f751c8371b9f Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Wed, 24 Sep 2025 10:42:26 +0200
Subject: [POC] printk/nbcon: Allow to release console context after each
 record in atomic_flush

It gives nbcon_reacquire_nobuf() to acquire the ownership to clean up
the console after the interrupted write_thread() call and allow
to preempt the printk kthread.

Add an API to block writing/flushing messages in a context with
lower priority. Otherwise, it would start flushing a pending
message and get interrupted again by the higher priority context.

The API is used in both code paths which try to acquire the nbcon
console ownership and try to write a message using
nbcon_emit_next_record().

The priority field is set in nbcon unsafe context which
prevents takeovers. The context must not clear it after
loosing the console ownership.

Failure to reserve the flush priority is handled the same way
as a failure to get the context ownership. So, it might somehow
work.

Warning: This is just a POC. The code is not tested.

FIXME: The clearing of the flush priority is racy. It might
       clear a value set by another context when it was
       cleared by a higher priority context in the mean
       time.

       There are ways to fix it.

       But wait! It might be enough to synchronize normal vs. emergency
       context. Non-panic context won't be able to get
       the ownership anyway.

Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h |  2 +
 kernel/printk/nbcon.c   | 86 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 8f10d0a85bb4..51750f92673f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -326,6 +326,7 @@ struct nbcon_write_context {
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @nbcon_device_ctxt:	Context available for non-printing operations
  * @nbcon_prev_seq:	Seq num the previous nbcon owner was assigned to print
+ * @nbcon_flush_prio:   Priority of a context flushing the console
  * @pbufs:		Pointer to nbcon private buffer
  * @kthread:		Printer kthread for this console
  * @rcuwait:		RCU-safe wait object for @kthread waking
@@ -461,6 +462,7 @@ struct console {
 	atomic_long_t		__private nbcon_seq;
 	struct nbcon_context	__private nbcon_device_ctxt;
 	atomic_long_t           __private nbcon_prev_seq;
+	enum nbcon_prio		__private nbcon_flush_prio;
 
 	struct printk_buffers	*pbufs;
 	struct task_struct	*kthread;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 646801813415..575b2628e0b2 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -911,6 +911,78 @@ bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
 
+/**
+ * nbcon_context_get_flush_prio - Reserve writing by the given context priority
+ * @wctxt:	The write context which wants to write messages
+ *
+ * The function allows to reserve rights for emitting/flushing messages with
+ * the priority of the given context.
+ *
+ * It signalizes an intention to flush pending messages.
+ *
+ * The motivation is to allow releasing the nbcon console ownership after
+ * each emitted message and still block any context with a lower priority
+ * from flushing the pending messages. It prevents repeated interrupts
+ * of the lower priority context in the middle of the message.
+ *
+ * Return:	True when the write context might try to flush messages.
+ *		False when a context with a higher priority is flushing
+ *		messages.
+ *
+ * FIXME: Maybe, only the NORMAL vs. EMERGENCY context is interesting.
+ *	  Both these context will get blocked when there is a panic
+ *	  in progress,
+ *
+ * It might be enough to synchronize kthread vs. emergency_enter/exit API.
+ * Well, there is also the legacy kthread.
+ */
+int nbcon_context_get_flush_prio(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	ret = true;
+
+	if (!nbcon_context_try_acquire(ctxt, false))
+		return false;
+
+	if (!nbcon_context_enter_unsafe(ctxt))
+		return false;
+
+	if (con->nbcon_flush_prio <= ctxt->prio)
+		con->nbcon_flush_prio = ctxt->prio;
+	else
+		ret = false;
+
+	if (!nbcon_context_exit_unsafe(ctxt))
+		ret = false;
+
+	nbcon_context_release(ctxt);
+
+	return ret;
+}
+
+void nbcon_context_put_flush_prio(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	ret = 0;
+
+	if (!nbcon_context_try_acquire(ctxt, false))
+		return -EPERM;
+
+	if (!nbcon_context_enter_unsafe(ctxt))
+		return -EAGAIN;
+
+	con->nbcon_flush_prio = NBCON_PRIO_NONE;
+
+	if (!nbcon_context_exit_unsafe(ctxt))
+		ret = -EAGAIN;
+
+	nbcon_context_release(ctxt);
+
+	return ret;
+}
+
 /**
  * nbcon_reacquire_nobuf - Reacquire a console after losing ownership
  *				while printing
@@ -1120,6 +1192,8 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 		cant_migrate();
 	}
 
+	if (!nbcon_context_get_flush_prio(wctxt))
+		goto out;
 	if (!nbcon_context_try_acquire(ctxt, false))
 		goto out;
 
@@ -1135,6 +1209,7 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 		goto out;
 
 	nbcon_context_release(ctxt);
+	nbcon_context_put_flush_prio(wctxt);
 
 	ret = ctxt->backlog;
 out:
@@ -1505,10 +1580,13 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	ctxt->prio			= nbcon_get_default_prio();
 	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
-	if (!nbcon_context_try_acquire(ctxt, false))
+	if (!nbcon_context_get_flush_prio(&wctxt);
 		return -EPERM;
 
 	while (nbcon_seq_read(con) < stop_seq) {
+		if (!nbcon_context_try_acquire(ctxt, false))
+			return -EPERM;
+
 		/*
 		 * nbcon_emit_next_record() returns false when the console was
 		 * handed over or taken over. In both cases the context is no
@@ -1523,10 +1601,14 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 				err = -ENOENT;
 			break;
 		}
+
+		nbcon_context_release(ctxt);
 	}
 
-	nbcon_context_release(ctxt);
+	nbcon_context_put_flush_prio(&wctxt);
+
 	return err;
+
 }
 
 /**
-- 
2.51.0

I am going to try an easier approach which would just block the
kthread when any CPU is in emergency context.

Best Regards,
Petr
