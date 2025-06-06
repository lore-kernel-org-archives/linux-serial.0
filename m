Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BA3234;
	Fri,  6 Jun 2025 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749205180; cv=none; b=GuYsTFokhTmsq8HuDsDZ52+Nep0Patpd87uQDoJhHEPEAMblGj2KfvArvAb5w/YqL9euJNk0sgmHHJyYYaG78T1Oj7zeVS61wKeQbiWwgF3nsDYTj7Xceu1KkjPYBzP+ZK7DYWfil1dLjk1+mN3HfXB0BQu3BaBq47tLOifAQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749205180; c=relaxed/simple;
	bh=U9oRcqk8pQONKNF0tSAsSNHiaoMlLKsDK3FIcKhEGQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pXiuQqEkfHvJWzN9bwtv/C9pRb1O+7ih7Jk9AEkGlHZONn1b7hgcwhA6a2Grd4FxjsqizfA8u1Up0c5scBB5/EzVGd/Vaas5k6ZNIBM4K0M5ExGuyRDfFdXDG0kD6P21SE9GhI5fVn8t8Vi9p56Beuq0at6EXlGN84yjZuDELyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NAcC5HuI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oU5sfJAx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NAcC5HuI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oU5sfJAx"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749205176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Wj8ecJw8sQMELv22VyqXO77n+w+BEzjGz6ZQfwvvzw=;
	b=NAcC5HuIuZMqVi0R070oigm72+7GL9UEurnIlPXXJZ3LfgUaFtk0M2Za0cGz/tUqCN+vr/
	b5YdrvdC2jhJwxrsQD45HLC6oAWzXVejuT3MuPcYfyZ3zmDUJNvN++edpV0XbMn7cPVMrg
	mF0NqAMkjNudN/f0dMo8nOS2CDMbILTm2jD0jTeO/m2N/9RYDMqta++hz3YEYHEC+JcZF4
	P8g+YCmJqQ+hUdUH30LbU9toOmsYkpjwDooAi6MPzvXt9u0ncTB/f5bv2lf8kFYr9EJ3yo
	Qi2ZlQzJ9K6Yc/K1RIemL0Bh5eTXnXB8OMMgviFVyMA7Vzg8NBQQHLx5HYVmXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749205176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Wj8ecJw8sQMELv22VyqXO77n+w+BEzjGz6ZQfwvvzw=;
	b=oU5sfJAxPYPEf4Mjq9ihtQjWLaP3Dg/H2+yCANCmxnuvywVX0+sZLQKU+aAWpT5RSmH39E
	6+95i4B+bR+O5eAA==
To: Petr Mladek <pmladek@suse.com>, "Toshiyuki Sato (Fujitsu)"
 <fj6611ie@fujitsu.com>
Cc: 'Michael Kelley' <mhklinux@outlook.com>, 'Ryo Takakura'
 <ryotkkr98@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: Problem with nbcon console and amba-pl011 serial port
In-Reply-To: <aEGeARVcCwqcoHb8@pathway.suse.cz>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
 <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEApOPTqbVOR35F_@pathway.suse.cz> <84o6v3ohdh.fsf@jogness.linutronix.de>
 <aEBNLMYVUOGzusuR@pathway.suse.cz>
 <TY4PR01MB13777CC92C858572B9C19394FD76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEGeARVcCwqcoHb8@pathway.suse.cz>
Date: Fri, 06 Jun 2025 12:25:35 +0206
Message-ID: <84frgdcgug.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-05, Petr Mladek <pmladek@suse.com> wrote:
> The question is if it is worth it. Is the clean up really important?

I must admit that I am not happy about encouraging the proposed solution
so far (i.e. expecting driver authors to create special unsafe code in
the panic situation). It leads down the "hope and pray" path that nbcon
was designed to fix.

What if during non-panic-CPU shutdown, we allow reacquires to succeed
only for _direct_ acquires? The below diff shows how this could be
implemented. Since it only supports direct acquires, it does not violate
any state rules. And also, since it only involves the reacquire, there
is no ugly battling for console printing between the panic and non-panic
CPUs.

Thoughts?

John Ogness

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 5b462029d03c1..d58ebdc8170b3 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -208,6 +208,7 @@ extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
 bool pr_flush(int timeout_ms, bool reset_on_progress);
+void nbcon_panic_allow_reacquire_set(bool value);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -321,6 +322,10 @@ static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 	return true;
 }
 
+static inline void nbcon_panic_allow_reacquire_set(bool value)
+{
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index b0b9a8bf4560d..8f572630c9f7e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -292,6 +292,12 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		panic_triggering_all_cpu_backtrace = false;
 	}
 
+	/*
+	 * Temporarily allow non-panic CPUs to finish any nbcon cleanup
+	 * in case they were interrupted due to the panic.
+	 */
+	nbcon_panic_allow_reacquire_set(true);
+
 	/*
 	 * Note that smp_send_stop() is the usual SMP shutdown function,
 	 * which unfortunately may not be hardened to work in a panic
@@ -304,6 +310,8 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		smp_send_stop();
 	else
 		crash_smp_send_stop();
+
+	nbcon_panic_allow_reacquire_set(false);
 }
 
 /**
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d60596777d278..d960cb8a05558 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -235,7 +235,8 @@ static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
  *			the handover acquire method.
  */
 static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
-					    struct nbcon_state *cur)
+					    struct nbcon_state *cur,
+					    bool ignore_other_cpu_in_panic)
 {
 	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;
@@ -249,7 +250,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 		 * nbcon_waiter_matches(). In particular, the assumption that
 		 * lower priorities are ignored during panic.
 		 */
-		if (other_cpu_in_panic())
+		if (other_cpu_in_panic() && !ignore_other_cpu_in_panic)
 			return -EPERM;
 
 		if (ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio)
@@ -568,7 +569,7 @@ static struct printk_buffers panic_nbcon_pbufs;
  * in an unsafe state. Otherwise, on success the caller may assume
  * the console is not in an unsafe state.
  */
-static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
+static bool nbcon_context_try_acquire(struct nbcon_context *ctxt, bool ignore_other_cpu_in_panic)
 {
 	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;
@@ -577,7 +578,7 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 
 	nbcon_state_read(con, &cur);
 try_again:
-	err = nbcon_context_try_acquire_direct(ctxt, &cur);
+	err = nbcon_context_try_acquire_direct(ctxt, &cur, ignore_other_cpu_in_panic);
 	if (err != -EBUSY)
 		goto out;
 
@@ -892,6 +893,12 @@ bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
 
+static bool nbcon_panic_allow_reacquire;
+void nbcon_panic_allow_reacquire_set(bool value)
+{
+	nbcon_panic_allow_reacquire = value;
+}
+
 /**
  * nbcon_reacquire_nobuf - Reacquire a console after losing ownership
  *				while printing
@@ -913,7 +920,7 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 
-	while (!nbcon_context_try_acquire(ctxt))
+	while (!nbcon_context_try_acquire(ctxt, READ_ONCE(nbcon_panic_allow_reacquire)))
 		cpu_relax();
 
 	nbcon_write_context_set_buf(wctxt, NULL, 0);
@@ -1101,7 +1108,7 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 		cant_migrate();
 	}
 
-	if (!nbcon_context_try_acquire(ctxt))
+	if (!nbcon_context_try_acquire(ctxt, false))
 		goto out;
 
 	/*
@@ -1486,7 +1493,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	ctxt->prio			= nbcon_get_default_prio();
 	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
-	if (!nbcon_context_try_acquire(ctxt))
+	if (!nbcon_context_try_acquire(ctxt, false))
 		return -EPERM;
 
 	while (nbcon_seq_read(con) < stop_seq) {
@@ -1784,7 +1791,7 @@ bool nbcon_device_try_acquire(struct console *con)
 	ctxt->console	= con;
 	ctxt->prio	= NBCON_PRIO_NORMAL;
 
-	if (!nbcon_context_try_acquire(ctxt))
+	if (!nbcon_context_try_acquire(ctxt, false))
 		return false;
 
 	if (!nbcon_context_enter_unsafe(ctxt))
