Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6895B26ACC
	for <linux-serial@vger.kernel.org>; Wed,  4 Jun 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046866; cv=none; b=ehaSqA3uk25+0dGXapmOaMVAGHvL6KVhLoHoiuXdgM353M+9l+El3pZTloiASqbIc7Zn+0+C9QOHcOoDPiewLc9lFmevZQ5iK9zvcaP1IIqWMlZVrURFjd9hJRGHtbv+ax2BtU6VT/115XmnzrMYSbJ+SIalUNF6mcUOlfkb87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046866; c=relaxed/simple;
	bh=T4x64PN7OhuJ+VVZnlwfgOCHUQ1ENCLEJmnYuXzxbNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGt5FLg/YpCkknuabgQBxKzWNkNV/VrUpmnt1FMYwRdZDCrGbmpZQ4dMophhmxjymO5uW4K2KDMiViqfGst5UqoF8O5BPPRnd+lGEt8IK1BZVadzJ+TQb18vTLklk4M7v7+Gy/Q4Buj9GjtxIcIzLO+p8BZ39d3j79xfHtU5RMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jImr0aJ5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jImr0aJ5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jImr0aJ5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jImr0aJ5"
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6B3431FE0F;
	Wed,  4 Jun 2025 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749046860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dn8ycOFPKuW7F8mba8U0a3Fdcnope2szBHssTbLgnV8=;
	b=jImr0aJ5eqn77qP29wl1Ni+2dWAxxG+rQggMFERr0vX7DuAjc1rKsu2fZ2sZBia5IC7PCW
	bYkjnovyeGvPwKslyUPX0aFIOdh+ErExW4vl7beHZH++n08/nC6wc3fbfutF3fW29LJ7/1
	CeqXaOXGMcD31fR3l+hvAEEIRzJRT9E=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749046860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dn8ycOFPKuW7F8mba8U0a3Fdcnope2szBHssTbLgnV8=;
	b=jImr0aJ5eqn77qP29wl1Ni+2dWAxxG+rQggMFERr0vX7DuAjc1rKsu2fZ2sZBia5IC7PCW
	bYkjnovyeGvPwKslyUPX0aFIOdh+ErExW4vl7beHZH++n08/nC6wc3fbfutF3fW29LJ7/1
	CeqXaOXGMcD31fR3l+hvAEEIRzJRT9E=
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Michael Cobb <mcobb@thegoodpenguin.co.uk>,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] printk: Allow to use the printk kthread immediately even for 1st nbcon
Date: Wed,  4 Jun 2025 16:20:45 +0200
Message-ID: <20250604142045.253301-1-pmladek@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The kthreads for nbcon consoles are created by nbcon_alloc() at
the beginning of the console registration. But it currently works
only for the 2nd or later nbcon console because the code checks
@printk_kthreads_running.

The kthread for the 1st registered nbcon console is created at the very
end of register_console() by printk_kthreads_check_locked(). As a result,
the entire log is replayed synchronously when the "enabled" message
gets printed. It might block the boot for a long time with a slow serial
console.

Prevent the synchronous flush by creating the kthread even for the 1st
nbcon console when it is safe (kthreads ready and no boot consoles).

Also inform printk() to use the kthread by setting
@printk_kthreads_running. Note that the kthreads already must be
running when it is safe and this is not the 1st nbcon console.

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
Hi,

I am sending this patch for a proper review.

I have just updated comments according to the review. Otherwise,
there is no function change against the already tested patch,
see https://lore.kernel.org/all/aD8JOlDVP4ufgv44@pathway.suse.cz/

Best Regards,
Petr

 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 26 ++++++++++++++++++++++++--
 kernel/printk/printk.c   | 20 +++++++++++---------
 3 files changed, 37 insertions(+), 11 deletions(-)

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
index fd12efcc4aed..d60596777d27 100644
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
 
@@ -1716,14 +1722,30 @@ bool nbcon_alloc(struct console *con)
 /**
  * nbcon_free - Free and cleanup the nbcon console specific data
  * @con:	Console to free/cleanup nbcon data
+ *
+ * Important: @have_nbcon_console must be updated before calling
+ *	this function. In particular, it can be set only when there
+ *	is still another nbcon console registered.
  */
 void nbcon_free(struct console *con)
 {
 	struct nbcon_state state = { };
 
-	if (printk_kthreads_running)
+	/* Synchronize the kthread stop. */
+	lockdep_assert_console_list_lock_held();
+
+	if (printk_kthreads_running) {
 		nbcon_kthread_stop(con);
 
+		/* Might be the last nbcon console.
+		 *
+		 * Do not rely on printk_kthreads_check_locked(). It is not
+		 * called in some code paths, see nbcon_free() callers.
+		 */
+		if (!have_nbcon_console)
+			printk_kthreads_running = false;
+	}
+
 	nbcon_state_set(con, &state);
 
 	/* Boot consoles share global printk buffers. */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1eea80d0648e..0efbcdda9aab 100644
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
@@ -4232,6 +4225,15 @@ static int unregister_console_locked(struct console *console)
 	if (!found_nbcon_con)
 		have_nbcon_console = found_nbcon_con;
 
+	/* @have_nbcon_console must be updated before calling nbcon_free(). */
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

