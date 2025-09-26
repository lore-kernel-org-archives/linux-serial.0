Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4B2F60A5
	for <linux-serial@vger.kernel.org>; Fri, 26 Sep 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891004; cv=none; b=MUOWLu7xRJIGjG+0fmR/z7FEp2u7AdDYTtbEu5huj3LDjB3OBWHRemRWSHC5ApDlmSpIm6CCxO3AjD2+0is3BBShyiQU3dsTiy8ljDpQTcw3x5z2aAyimXqFzpAT7Nam4hlkKqrN8cqTgdgukKf4RB0rXf7szKiowm7uXT3N7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891004; c=relaxed/simple;
	bh=TYWTKovEAR/alWiiTH/VGFbGEWwEpfnP/SWlmIhsZLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6P4wjbXDy2tltrT6uogLdSaz97BQNdwB0hWoxsIHaR87IBASvaX8N7fn+K62ugunOMtQZKbbHJ127J2FuB3IvkEjBYMO1KMSQCgWqY46V7bnmYpWc5K3dNPAGrmCd9k7eyjltFvl4hnV9Sd0NIQLUH13jcBvBFUGQwcSKQjPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=laBWk+Q1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=magzUBs+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="laBWk+Q1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="magzUBs+"
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id CCA10241F1;
	Fri, 26 Sep 2025 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758891001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0H69nxEsRsFFac/uhvPZcy+qAFfR1+LLSKCCkgNAhic=;
	b=laBWk+Q1l9neyVbfjpsJ5APAJmW/K7W8XRxKcUluQDXlnekkQiCOAfDSKvZprFjygkin/d
	Au+2rEl9v83A3fcazIPv4mnjgxK+lwb1wYMujo8+q1jvRt0QxARcItexlZySFgLvRR9nzT
	slDBnkyFaqbuZMwq2/bTUAbj9RUFhdM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758891000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0H69nxEsRsFFac/uhvPZcy+qAFfR1+LLSKCCkgNAhic=;
	b=magzUBs+NSX/fqPsm/ahEjmQJWZLIv4KXj7k29rvqsIdO7Rjhu6g/0swW6mvYsTkzTS2qX
	z8UQHtzoO1xnRcYgpOEuH8YvGOSVGHLC2TjP4xOmt7ZfZDM7o/9flFp2pdt4Znrn3uciR/
	4dTYZYfzrzVb0qKfXYhVpWfJFuwb7g0=
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Lindgren <tony@atomide.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/3] printk/nbcon: Block printk kthreads when any CPU is in an emergency context
Date: Fri, 26 Sep 2025 14:49:10 +0200
Message-ID: <20250926124912.243464-2-pmladek@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926124912.243464-1-pmladek@suse.com>
References: <20250926124912.243464-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,chromium.org,goodmis.org,linutronix.de,geanix.com,vger.kernel.org,linux.intel.com,arndb.de,atomide.com,linux.ibm.com,gmail.com,thegoodpenguin.co.uk,suse.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pathway.suse.cz:helo,suse.com:email,suse.com:mid];
	R_RATELIMIT(0.00)[to_ip_from(RLreigq8okzrb3g3qsqhoz9iaq)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30

In emergency contexts, printk() tries to flush messages directly even
on nbcon consoles. And it is allowed to takeover the console ownership
and interrupt the printk kthread in the middle of a message.

Only one takeover and one repeated message should be enough in most
situations. The first emergency message flushes the backlog and printk
kthreads get to sleep. Next emergency messages are flushed directly
and printk() does not wake up the kthreads.

However, the one takeover is not guaranteed. Any printk() in normal
context on another CPU could wake up the kthreads. Or a new emergency
message might be added before the kthreads get to sleep. Note that
the interrupted .write_kthread() callbacks usually have to call
nbcon_reacquire_nobuf() and restore the original device setting
before checking for pending messages.

The risk of the repeated takeovers will be even bigger because
__nbcon_atomic_flush_pending_con is going to release the console
ownership after each emitted record. It will be needed to prevent
hardlockup reports on other CPUs which are busy waiting for
the context ownership, for example, by nbcon_reacquire_nobuf() or
__uart_port_nbcon_acquire().

The repeated takeovers break the output, for example:

    [ 5042.650211][ T2220] Call Trace:
    [ 5042.6511
    ** replaying previous printk message **
    [ 5042.651192][ T2220]  <TASK>
    [ 5042.652160][ T2220]  kunit_run_
    ** replaying previous printk message **
    [ 5042.652160][ T2220]  kunit_run_tests+0x72/0x90
    [ 5042.653340][ T22
    ** replaying previous printk message **
    [ 5042.653340][ T2220]  ? srso_alias_return_thunk+0x5/0xfbef5
    [ 5042.654628][ T2220]  ? stack_trace_save+0x4d/0x70
    [ 5042.6553
    ** replaying previous printk message **
    [ 5042.655394][ T2220]  ? srso_alias_return_thunk+0x5/0xfbef5
    [ 5042.656713][ T2220]  ? save_trace+0x5b/0x180

A more robust solution is to block the printk kthread entirely whenever
*any* CPU enters an emergency context. This ensures that critical messages
can be flushed without contention from the normal, non-atomic printing
path.

Link: https://lore.kernel.org/all/aNQO-zl3k1l4ENfy@pathway.suse.cz
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d5d8c8c657e0..08b196e898cd 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -117,6 +117,9 @@
  * from scratch.
  */
 
+/* Counter of active nbcon emergency contexts. */
+atomic_t nbcon_cpu_emergency_cnt;
+
 /**
  * nbcon_state_set - Helper function to set the console state
  * @con:	Console to update
@@ -1168,6 +1171,16 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 	if (kthread_should_stop())
 		return true;
 
+	/*
+	 * Block the kthread when the system is in an emergency or panic mode.
+	 * It increases the chance that these contexts would be able to show
+	 * the messages directly. And it reduces the risk of interrupted writes
+	 * where the context with a higher priority takes over the nbcon console
+	 * ownership in the middle of a message.
+	 */
+	if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)))
+		return false;
+
 	cookie = console_srcu_read_lock();
 
 	flags = console_srcu_read_flags(con);
@@ -1219,6 +1232,13 @@ static int nbcon_kthread_func(void *__console)
 		if (kthread_should_stop())
 			return 0;
 
+		/*
+		 * Block the kthread when the system is in an emergency or panic
+		 * mode. See nbcon_kthread_should_wakeup() for more details.
+		 */
+		if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)))
+			goto wait_for_event;
+
 		backlog = false;
 
 		/*
@@ -1660,6 +1680,8 @@ void nbcon_cpu_emergency_enter(void)
 
 	preempt_disable();
 
+	atomic_inc(&nbcon_cpu_emergency_cnt);
+
 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
 	(*cpu_emergency_nesting)++;
 }
@@ -1674,10 +1696,18 @@ void nbcon_cpu_emergency_exit(void)
 	unsigned int *cpu_emergency_nesting;
 
 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
-
 	if (!WARN_ON_ONCE(*cpu_emergency_nesting == 0))
 		(*cpu_emergency_nesting)--;
 
+	/*
+	 * Wake up kthreads because there might be some pending messages
+	 * added by other CPUs with normal priority since the last flush
+	 * in the emergency context.
+	 */
+	if (!WARN_ON_ONCE(atomic_read(&nbcon_cpu_emergency_cnt) == 0))
+		if (atomic_dec_return(&nbcon_cpu_emergency_cnt) == 0)
+			nbcon_kthreads_wake();
+
 	preempt_enable();
 }
 
-- 
2.51.0

