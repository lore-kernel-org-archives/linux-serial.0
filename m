Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2A2C3242;
	Fri,  6 Jun 2025 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206110; cv=none; b=M/XokEQwUKVmVlC2Ytr1Zw9xYMvlvfKnB2c0zTwBUpQ1qB0aFbf1WMX0mNRIEC9icnZH5SKP0aCBAWbwvBAoIE1pWBSl//ZyfMvl/izoA4XHqzJ2qjPSDf448hm17zfRS55UqZ9mX8ypL6Vi5cL6p5CO1QHURj4XIb8FiJyjMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206110; c=relaxed/simple;
	bh=FVNLm1VrL8jaqyqM/ByJ16XfYaxZyZvq2f7/obGxSPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lonP6t8nrTWxsWWoLHS+von23d81yl7IasjrcKEFS1mVGV7LPaRL8/IakLuEAGDFxjE7PMM4bv6l119n7Jx6WBxpjRNV3N9TCDREZMibUsYtz92y4mZHEra2MU57AdtbzlQvAmXgb4VLh+oKF1AabWCPggWNirCHFr9FKNB/Nhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tY4fxOkz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nRJZ20Ac; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tY4fxOkz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nRJZ20Ac"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749206106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNlEqQbY+fa98gHMzcIrLM+qc3h/stf4tBXFHk8HQmQ=;
	b=tY4fxOkzUOGEzSfuyTD1Xd7XXCr0wIg9z+OmDJ1uHXs/0D6FrBM/ARQL+JKenmmx/SpN1Z
	JAaEnnksFD2pAgpGepixdsCDbPwxD74kL6ismmFvB9cLDuRgf8ibnKAFi5/2b5701+mDCg
	5VpEE4EglAvv54Fl8fO/P2s7xX4L3DtAiHURV80AJrT7N47nWHbrRREZFuqYmx38diQKZs
	BKUf+HgD+rtvBpRhYWfMzpNZuqVoW4oPOpDSwEJeV5WekTNskz0yvoEUH1kCnq2ICR1vVE
	YbvnoKZtWzTI3AC6z4Ds2rIK1sD6dpBSviLaFZzF+GvfnCIm4DZojFmf8kxmVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749206106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNlEqQbY+fa98gHMzcIrLM+qc3h/stf4tBXFHk8HQmQ=;
	b=nRJZ20AcwHFYUmZVwaWsjyLVYVVIrcXFd2uY86bpZxAlNp2w/pQPxHQZvAEKp0MqcL8Y+l
	KcVTJEOFTSVwaWBg==
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
In-Reply-To: <84frgdcgug.fsf@jogness.linutronix.de>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
 <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEApOPTqbVOR35F_@pathway.suse.cz> <84o6v3ohdh.fsf@jogness.linutronix.de>
 <aEBNLMYVUOGzusuR@pathway.suse.cz>
 <TY4PR01MB13777CC92C858572B9C19394FD76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEGeARVcCwqcoHb8@pathway.suse.cz> <84frgdcgug.fsf@jogness.linutronix.de>
Date: Fri, 06 Jun 2025 12:41:06 +0206
Message-ID: <84cybhcg4l.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-06, John Ogness <john.ogness@linutronix.de> wrote:
> On 2025-06-05, Petr Mladek <pmladek@suse.com> wrote:
>> The question is if it is worth it. Is the clean up really important?
>
> I must admit that I am not happy about encouraging the proposed solution
> so far (i.e. expecting driver authors to create special unsafe code in
> the panic situation). It leads down the "hope and pray" path that nbcon
> was designed to fix.
>
> What if during non-panic-CPU shutdown, we allow reacquires to succeed
> only for _direct_ acquires? The below diff shows how this could be
> implemented. Since it only supports direct acquires, it does not violate
> any state rules. And also, since it only involves the reacquire, there
> is no ugly battling for console printing between the panic and non-panic
> CPUs.

Thinking about it some more, since it does not involve printing, why not
just always allow reacquiring directly in panic?

This simplifies the diff significantly.

John

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d60596777d278..26c229b7f56ea 100644
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
 
@@ -913,7 +914,7 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 
-	while (!nbcon_context_try_acquire(ctxt))
+	while (!nbcon_context_try_acquire(ctxt, true))
 		cpu_relax();
 
 	nbcon_write_context_set_buf(wctxt, NULL, 0);
@@ -1101,7 +1102,7 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 		cant_migrate();
 	}
 
-	if (!nbcon_context_try_acquire(ctxt))
+	if (!nbcon_context_try_acquire(ctxt, false))
 		goto out;
 
 	/*
@@ -1486,7 +1487,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	ctxt->prio			= nbcon_get_default_prio();
 	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
-	if (!nbcon_context_try_acquire(ctxt))
+	if (!nbcon_context_try_acquire(ctxt, false))
 		return -EPERM;
 
 	while (nbcon_seq_read(con) < stop_seq) {
@@ -1784,7 +1785,7 @@ bool nbcon_device_try_acquire(struct console *con)
 	ctxt->console	= con;
 	ctxt->prio	= NBCON_PRIO_NORMAL;
 
-	if (!nbcon_context_try_acquire(ctxt))
+	if (!nbcon_context_try_acquire(ctxt, false))
 		return false;
 
 	if (!nbcon_context_enter_unsafe(ctxt))
