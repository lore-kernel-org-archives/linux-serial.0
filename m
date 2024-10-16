Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B52101B7;
	Wed, 16 Oct 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098211; cv=none; b=ITYsu4d2AoUTQyDTdje/svCUSd4fIenF2labeR+ODk3A7GZdrUJaBIPAXOO2H4FNO95Im4l6xGE1mtPHSLQwu8sAyhfzXIaJnSNnpfCTgH8dDCu1c/nVIXRqnVLoc+HyVrpkSJjTKNe4DJE9HjFHG0YPoy1dt6SlRDVJCLA9RwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098211; c=relaxed/simple;
	bh=FdXPrW1TypyQ/5h3ZLuD+3Lt7hB/A/9rTUFSTmspdNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfB+MjgRV2MhbLZyxwSNHUi8Mu7/Id4vRwwPOGhUtFBVx8G3p1H8nVxB7wsUZu/6X/UhzXXbsdJmxw9Z+/GTCA9OSETa2Tglf6+TyQZPH5f+zY4Wkjb7RULFrPznWp76LuGbZNG+LYfMuMhhFEcMwtxcVR/JZcp8/eY8Rlf94/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lop1Yec4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lop1Yec4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lop1Yec4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lop1Yec4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7424721EDF;
	Wed, 16 Oct 2024 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729098206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gN3DeF5YovtHcQYiAs8wtgOqg70fsU6VYpw6NFoOI28=;
	b=lop1Yec4uGb5RgsXLDvFL99JIcXJW64hya58GQ3vU+HFQ+oUyrPNlgM3uk4o9NocwWuy6T
	v/8MsVXkh47odMkn2zzVEkWDFet1WFlZSsuQj7EmZcli6uvVFtuo75qW+K4t/5Maz1q2uv
	TQp3Xg0CceKDsjSI1buR8CVCBc3YVwE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729098206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gN3DeF5YovtHcQYiAs8wtgOqg70fsU6VYpw6NFoOI28=;
	b=lop1Yec4uGb5RgsXLDvFL99JIcXJW64hya58GQ3vU+HFQ+oUyrPNlgM3uk4o9NocwWuy6T
	v/8MsVXkh47odMkn2zzVEkWDFet1WFlZSsuQj7EmZcli6uvVFtuo75qW+K4t/5Maz1q2uv
	TQp3Xg0CceKDsjSI1buR8CVCBc3YVwE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFA5813433;
	Wed, 16 Oct 2024 17:03:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 75SzLN3xD2dsTQAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 16 Oct 2024 17:03:25 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 16 Oct 2024 14:03:01 -0300
Subject: [PATCH 1/2] printk: Introduce LOUD_CON flag
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
References: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
In-Reply-To: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729098195; l=5104;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=FdXPrW1TypyQ/5h3ZLuD+3Lt7hB/A/9rTUFSTmspdNs=;
 b=yXF+4fylnN+KNRedDqClvv7HS4D7E97Wnngkq7JJZr4HkjxAU0MEjj4WIwp2h7Zm3/dnea3FO
 uxCFz02oFrFA8zMyEuROhlIJKAXrhEAMsvL61GwcpZliFCWC7kSGnwe
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Score: -8.30
X-Spam-Flag: NO

Introduce LOUD_CON flag to printk. The new flag will make it possible to
create a context where printk messages will never be suppressed. This
new context information will be stored in the already existing
printk_context per-CPU variable. This variable was changed from 'int' to
'unsigned int' to avoid issues with automatic casting.

This mechanism will be used in the next patch to create a loud_console
context on sysrq handling, removing an existing workaround on the
loglevel global variable. The workaround existed to make sure that sysrq
header messages were sent to all consoles.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/printk.h      |  3 +++
 kernel/printk/internal.h    |  3 +++
 kernel/printk/printk.c      |  8 +++++++-
 kernel/printk/printk_safe.c | 27 +++++++++++++++++++++++++--
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index eca9bb2ee637..0ac9879d94ac 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -166,6 +166,9 @@ __printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
 extern void __printk_deferred_enter(void);
 extern void __printk_deferred_exit(void);
 
+extern void printk_loud_console_enter(void);
+extern void printk_loud_console_exit(void);
+
 /*
  * The printk_deferred_enter/exit macros are available only as a hack for
  * some code paths that need to defer all printk console printing. Interrupts
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 3fcb48502adb..2649e8a66cef 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -53,6 +53,8 @@ int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 
 /* Flags for a single printk record. */
 enum printk_info_flags {
+	/* always show on console, ignore console_loglevel */
+	LOG_LOUD_CON	= 1,
 	LOG_NEWLINE	= 2,	/* text ended with a newline */
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
@@ -90,6 +92,7 @@ bool printk_percpu_data_ready(void);
 
 void defer_console_output(void);
 bool is_printk_legacy_deferred(void);
+bool is_printk_console_loud(void);
 
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index beb808f4c367..b893825fe21d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1321,6 +1321,7 @@ static void boot_delay_msec(int level)
 	unsigned long timeout;
 
 	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
+		|| is_printk_console_loud()
 		|| suppress_message_printing(level)) {
 		return;
 	}
@@ -2273,6 +2274,9 @@ int vprintk_store(int facility, int level,
 	if (dev_info)
 		flags |= LOG_NEWLINE;
 
+	if (is_printk_console_loud())
+		flags |= LOG_LOUD_CON;
+
 	if (flags & LOG_CONT) {
 		prb_rec_init_wr(&r, reserve_size);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id, PRINTKRB_RECORD_MAX)) {
@@ -2947,6 +2951,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	struct printk_info info;
 	struct printk_record r;
 	size_t len = 0;
+	bool loud_con;
 
 	/*
 	 * Formatting extended messages requires a separate buffer, so use the
@@ -2965,9 +2970,10 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
+	loud_con = r.info->flags & LOG_LOUD_CON;
 
 	/* Skip record that has level above the console loglevel. */
-	if (may_suppress && suppress_message_printing(r.info->level))
+	if (!loud_con && may_suppress && suppress_message_printing(r.info->level))
 		goto out;
 
 	if (is_extended) {
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 2b35a9d3919d..4618988baeea 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -12,7 +12,30 @@
 
 #include "internal.h"
 
-static DEFINE_PER_CPU(int, printk_context);
+static DEFINE_PER_CPU(unsigned int, printk_context);
+
+#define PRINTK_SAFE_CONTEXT_MASK		0x0000ffffU
+#define PRINTK_LOUD_CONSOLE_CONTEXT_MASK	0xffff0000U
+#define PRINTK_LOUD_CONSOLE_CONTEXT_OFFSET	0x00010000U
+
+void noinstr printk_loud_console_enter(void)
+{
+	cant_migrate();
+	this_cpu_add(printk_context, PRINTK_LOUD_CONSOLE_CONTEXT_OFFSET);
+}
+
+void noinstr printk_loud_console_exit(void)
+{
+	cant_migrate();
+	this_cpu_sub(printk_context, PRINTK_LOUD_CONSOLE_CONTEXT_OFFSET);
+}
+
+/* Safe in any context. CPU migration is always disabled when set. */
+bool is_printk_console_loud(void)
+{
+	return !!(this_cpu_read(printk_context) &
+			PRINTK_LOUD_CONSOLE_CONTEXT_MASK);
+}
 
 /* Can be preempted by NMI. */
 void __printk_safe_enter(void)
@@ -45,7 +68,7 @@ bool is_printk_legacy_deferred(void)
 	 * context. CPU migration is always disabled when set.
 	 */
 	return (force_legacy_kthread() ||
-		this_cpu_read(printk_context) ||
+		!!(this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) ||
 		in_nmi());
 }
 

-- 
2.46.1

