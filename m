Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A02EAD18
	for <linux-serial@vger.kernel.org>; Fri, 26 Sep 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891016; cv=none; b=rP8leScsc+hw3vmvlJ92+DA4F0RPH3ki4UX1uN6hWHEYYeWlM+glf5D8qnLoIhqdZCKhbElM/v+f9Xj1TKFZRU2UaT/KwapEuWmq81lGNG9K3hvsdK2C3od9mxumU57Yb60xpKmF6DPyMDzBPPon9MaFQCa0pHyfF87yn0tT9wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891016; c=relaxed/simple;
	bh=x3GAlWgKs0fsAyeT459u49KjKsIE1RObsl76qtK8lRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z536Meqq2SSOswNZ8X50qq5SB2GMfprJOgqXTjKRjOvzG82U29SGJVxaSAjsz2yKvh57F3+egj5PUFy5d0p/iYhYMy6OsJ8o/Wq+YbJKV3S6kRkQZ+lw7f2KC/7iVN+9ZDVk+48/WpGmnRbCZjhctp2enrquCivw5ncn029fPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ga56bOLh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mrmxcrsM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ga56bOLh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mrmxcrsM"
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id A6D8A4106;
	Fri, 26 Sep 2025 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758891013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Taai5mKkev2mbhv+qd/m2dXBSKagv/FeTKuZ2WmOyR0=;
	b=ga56bOLhkYrLc009oAW3+M7ImjG098bJzAbEcfKICJY3qGu3j3iaxe50cJ0BybLcNU4G0j
	fDDiisUmc97X9QjYIw1w2WGl6NP5B7hgOa1Y1mNC8S/YBW6I/YmEeYUYSgvmd8yXtFcBka
	V3oo2hGbLEyXAecOxv7mIxQpklHZ5jw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758891011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Taai5mKkev2mbhv+qd/m2dXBSKagv/FeTKuZ2WmOyR0=;
	b=mrmxcrsMsj7W/tzQk6YcgWF7GuZJFE9d0jYrzDQyLKk5a+FQEvyUYjm4P/HU9XC60vqHpC
	ta3nZ38ETp1fvaDcGLTueZdbptLAKQdT/73e0tYgTVDOLeWord9HOiiaELE3DiJekoDBKx
	RJEABA2maiJYD9sbaav+KuJD58By3bE=
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
Subject: [PATCH 2/3] printk/nbcon/panic: Allow printk kthread to sleep when the system is in panic
Date: Fri, 26 Sep 2025 14:49:11 +0200
Message-ID: <20250926124912.243464-3-pmladek@suse.com>
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

The printk kthread might be running when there is a panic in progress.
But it is not able to acquire the console ownership any longer.

Prevent the desperate attempts to acquire the ownership and allow sleeping
in panic. It would make it behave the same as when there is any CPU
in an emergency context.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 1 +
 kernel/printk/nbcon.c    | 6 ++++--
 kernel/printk/printk.c   | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ef282001f200..6e8578102fb3 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -332,6 +332,7 @@ struct printk_message {
 	unsigned long		dropped;
 };
 
+bool panic_in_progress(void);
 bool other_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 08b196e898cd..219ae0c8b5ed 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1178,7 +1178,8 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 	 * where the context with a higher priority takes over the nbcon console
 	 * ownership in the middle of a message.
 	 */
-	if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)))
+	if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)) ||
+	    unlikely(panic_in_progress()))
 		return false;
 
 	cookie = console_srcu_read_lock();
@@ -1236,7 +1237,8 @@ static int nbcon_kthread_func(void *__console)
 		 * Block the kthread when the system is in an emergency or panic
 		 * mode. See nbcon_kthread_should_wakeup() for more details.
 		 */
-		if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)))
+		if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)) ||
+		    unlikely(panic_in_progress()))
 			goto wait_for_event;
 
 		backlog = false;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ebf10352736f..174d42041594 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -345,7 +345,7 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
-static bool panic_in_progress(void)
+bool panic_in_progress(void)
 {
 	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
 }
-- 
2.51.0

