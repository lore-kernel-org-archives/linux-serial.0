Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6E212EF9;
	Tue,  5 Nov 2024 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835932; cv=none; b=un96CeyT/QYGyzpwIsqLH411cpYbtSxaG7br6kMTe6S3qUE9ejJQ4n6h/v0Z4ZqA947gH1nVfgs2fcyfqtHkvTglTnqDOpu756CqOkgmusi69A330aWJ8/QZ7EDDf6LEF+TM4B7Mamm9sJXXYccN4ONIb2hPkGVVKTSiHopBm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835932; c=relaxed/simple;
	bh=Ys6Cvvlb0Pcb4EQF8t3wjO/hZu09C+3sm+GbOJXJgmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LoOauzPX8CkVOq10vB843cjgK/65qGEEinkwI+827CvN6CsQpOHEMbrUch+iG5XYi97i11ZqxRnIXIQV0gTUfr6Nh2ooZakZHy2k45m9BOI4caFUhuvMptXjQnmjY6TI+zjeaEI+n7lcowHaaknlMYY8anCwkgTAujoDJFJy6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tsBon+9p; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tsBon+9p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tsBon+9p";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tsBon+9p"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5186021E69;
	Tue,  5 Nov 2024 19:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730835924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WA9WgYzXkhvGh7Q38/NOTSc0PGe0/C72wL7VgDsiacY=;
	b=tsBon+9ppXus0FQSQgD8/uRXiT25xxNv5MnBr5Tmr6D6TzjnD0Ff5KNnfXM8tI8nSzOEho
	valLV/hi9TAPS8+boVBsiI+5R5EwkSKFLqFbVzGn6x50I7ZbnoWgYpvbMMlesso1mrlBv2
	S74TXuqnool6iJ/lMBkRB7znwiQyVOU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730835924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WA9WgYzXkhvGh7Q38/NOTSc0PGe0/C72wL7VgDsiacY=;
	b=tsBon+9ppXus0FQSQgD8/uRXiT25xxNv5MnBr5Tmr6D6TzjnD0Ff5KNnfXM8tI8nSzOEho
	valLV/hi9TAPS8+boVBsiI+5R5EwkSKFLqFbVzGn6x50I7ZbnoWgYpvbMMlesso1mrlBv2
	S74TXuqnool6iJ/lMBkRB7znwiQyVOU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0A5313964;
	Tue,  5 Nov 2024 19:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k3SGJdN1KmdmAQAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Tue, 05 Nov 2024 19:45:23 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 05 Nov 2024 16:45:08 -0300
Subject: [PATCH v2 1/2] printk: Introduce FORCE_CON flag
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-printk-loud-con-v2-1-bd3ecdf7b0e4@suse.com>
References: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
In-Reply-To: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730835918; l=5026;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=Ys6Cvvlb0Pcb4EQF8t3wjO/hZu09C+3sm+GbOJXJgmY=;
 b=Y6wjd5V3b1UAcO8t77h0czbeWg7yZ7zFQb5K2G4jxJfp4xcPIUm6x+C0mmE4uYZ61HQCXi1SN
 cEsiHYaZPrVBYltmkuTfruQT+qDInZiUvIoMfdxEBGJXQpcEAkvNUgD
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Introduce FORCE_CON flag to printk. The new flag will make it possible to
create a context where printk messages will never be suppressed.

This mechanism will be used in the next patch to create a force_con
context on sysrq handling, removing an existing workaround on the
loglevel global variable. The workaround existed to make sure that sysrq
header messages were sent to all consoles, but this doesn't work with
deferred messages because the loglevel might be restored to its original
value before a console flushes the messages.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/printk.h      |  3 +++
 kernel/printk/internal.h    |  3 +++
 kernel/printk/printk.c      | 21 ++++++++++++++++-----
 kernel/printk/printk_safe.c | 18 ++++++++++++++++++
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index eca9bb2ee637..232e5fd06701 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -166,6 +166,9 @@ __printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
 extern void __printk_deferred_enter(void);
 extern void __printk_deferred_exit(void);
 
+extern void printk_force_console_enter(void);
+extern void printk_force_console_exit(void);
+
 /*
  * The printk_deferred_enter/exit macros are available only as a hack for
  * some code paths that need to defer all printk console printing. Interrupts
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 3fcb48502adb..c6bb47666aef 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -53,6 +53,8 @@ int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 
 /* Flags for a single printk record. */
 enum printk_info_flags {
+	/* always show on console, ignore console_loglevel */
+	LOG_FORCE_CON	= 1,
 	LOG_NEWLINE	= 2,	/* text ended with a newline */
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
@@ -90,6 +92,7 @@ bool printk_percpu_data_ready(void);
 
 void defer_console_output(void);
 bool is_printk_legacy_deferred(void);
+bool is_printk_force_console(void);
 
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index beb808f4c367..911f2a32f1cb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1319,11 +1319,11 @@ static void boot_delay_msec(int level)
 {
 	unsigned long long k;
 	unsigned long timeout;
+	bool suppress = !is_printk_force_console() &&
+			suppress_message_printing(level);
 
-	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
-		|| suppress_message_printing(level)) {
+	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING) || suppress)
 		return;
-	}
 
 	k = (unsigned long long)loops_per_msec * boot_delay;
 
@@ -2273,6 +2273,9 @@ int vprintk_store(int facility, int level,
 	if (dev_info)
 		flags |= LOG_NEWLINE;
 
+	if (is_printk_force_console())
+		flags |= LOG_FORCE_CON;
+
 	if (flags & LOG_CONT) {
 		prb_rec_init_wr(&r, reserve_size);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id, PRINTKRB_RECORD_MAX)) {
@@ -2280,6 +2283,9 @@ int vprintk_store(int facility, int level,
 						 facility, &flags, fmt, args);
 			r.info->text_len += text_len;
 
+			if (flags & LOG_FORCE_CON)
+				r.info->flags |= LOG_FORCE_CON;
+
 			if (flags & LOG_NEWLINE) {
 				r.info->flags |= LOG_NEWLINE;
 				prb_final_commit(&e);
@@ -2947,6 +2953,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	struct printk_info info;
 	struct printk_record r;
 	size_t len = 0;
+	bool force_con;
 
 	/*
 	 * Formatting extended messages requires a separate buffer, so use the
@@ -2965,9 +2972,13 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
+	force_con = r.info->flags & LOG_FORCE_CON;
 
-	/* Skip record that has level above the console loglevel. */
-	if (may_suppress && suppress_message_printing(r.info->level))
+	/*
+	 * Skip records that are not forced to be printed on consoles and that
+	 * has level above the console loglevel.
+	 */
+	if (!force_con && may_suppress && suppress_message_printing(r.info->level))
 		goto out;
 
 	if (is_extended) {
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 2b35a9d3919d..6f94418d53ff 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -12,6 +12,24 @@
 
 #include "internal.h"
 
+/* Context where printk messages are never suppressed */
+static atomic_t force_con;
+
+void printk_force_console_enter(void)
+{
+	atomic_inc(&force_con);
+}
+
+void printk_force_console_exit(void)
+{
+	atomic_dec(&force_con);
+}
+
+bool is_printk_force_console(void)
+{
+	return atomic_read(&force_con);
+}
+
 static DEFINE_PER_CPU(int, printk_context);
 
 /* Can be preempted by NMI. */

-- 
2.47.0

