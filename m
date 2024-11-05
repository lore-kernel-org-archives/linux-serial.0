Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0D2139C6;
	Tue,  5 Nov 2024 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835935; cv=none; b=XhXqI0Yp0ZVEL8x8eYC+ZYAWjhZLv2CZ05Ln9sa9AD32oQFesL/NgWqfMFk9xwiY1FbSliq4XJpDYx33npJ9s/cbksjYuaB8IwBzZJC4yIiNatpQeKheZgQfmDJSQSJyDUyfVcR5CzidfVlz4jIrlG4Gpu5cBGZD+2sIkfMECU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835935; c=relaxed/simple;
	bh=0kvyEY3nEuZnN+PoAH3AIJtBuFfrTiwNq+0w6Mq33w8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQSr7asyg0gnK46M2B2UIZVdPiiLFxW+E0tAe6ClTj5ys+clIoO0V7Fzj4ZN7fXRATku1naitAqWzmoGWwO9qpAEcEzgJbMj8/0W+6/bQ3P3K0t+dkXbwVKB2dwS2AGonb35Oh+CsaWeIBasromK5DPZk6RAmIZqxkxljMzHWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oyYNI7Ig; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oyYNI7Ig; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oyYNI7Ig";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oyYNI7Ig"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79EB71FEEE;
	Tue,  5 Nov 2024 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730835931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaTkffWngPwzxlqQc7OJbRE/O6/uT+c7yWAmXfiIZI4=;
	b=oyYNI7Igop0LOnE2rkZqWFs986gWu/qwuvdIw3V6st7XG+C62Cl+nMZTlIXKPy6ElKq+G7
	gEiHxBTuMhXYqcnwnYcTv9ZinTPKVJ4+SjSNMtY9q0dHA2sUUjNPplumvm6xyr055k4uz0
	dB9pH5wFH7bS9NkXuMYfMA3HH9tFgB4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730835931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaTkffWngPwzxlqQc7OJbRE/O6/uT+c7yWAmXfiIZI4=;
	b=oyYNI7Igop0LOnE2rkZqWFs986gWu/qwuvdIw3V6st7XG+C62Cl+nMZTlIXKPy6ElKq+G7
	gEiHxBTuMhXYqcnwnYcTv9ZinTPKVJ4+SjSNMtY9q0dHA2sUUjNPplumvm6xyr055k4uz0
	dB9pH5wFH7bS9NkXuMYfMA3HH9tFgB4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05E8213964;
	Tue,  5 Nov 2024 19:45:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A6KWL9p1KmduAQAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Tue, 05 Nov 2024 19:45:30 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 05 Nov 2024 16:45:09 -0300
Subject: [PATCH v2 2/2] tty: sysrq: Use printk_force_console context on
 __handle_sysrq
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-printk-loud-con-v2-2-bd3ecdf7b0e4@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730835918; l=2428;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=0kvyEY3nEuZnN+PoAH3AIJtBuFfrTiwNq+0w6Mq33w8=;
 b=s+/pxg/DhWOwq9wj7DxTh1HD+9EUwvRE0wD+aYyxJY5GesFqa6JXbnsVDYwt11evRumYYsx80
 lwHXzL6n8SGAa7iONto6JvS+ybCd4fJOKCJNV60iaXqr4B0ML1/iA7a
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Score: -4.30
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
X-Spam-Flag: NO
X-Spam-Level: 

By using the printk_force_console the loglevel workaround can be removed.
The workaround existed to always send the sysrq header message to all
consoles not matter what was the current loglevel, but it won't work for
deferred messages, since the loglevel can be restore before the message
is printed, suppressing the message that wasn't supposed to be
suppressed by the workaround.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/sysrq.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 930b04e3d148..f85ce02e4725 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -583,7 +583,6 @@ static void __sysrq_put_key_op(u8 key, const struct sysrq_key_op *op_p)
 void __handle_sysrq(u8 key, bool check_mask)
 {
 	const struct sysrq_key_op *op_p;
-	int orig_log_level;
 	int orig_suppress_printk;
 	int i;
 
@@ -593,13 +592,12 @@ void __handle_sysrq(u8 key, bool check_mask)
 	rcu_sysrq_start();
 	rcu_read_lock();
 	/*
-	 * Raise the apparent loglevel to maximum so that the sysrq header
-	 * is shown to provide the user with positive feedback.  We do not
-	 * simply emit this at KERN_EMERG as that would change message
-	 * routing in the consumers of /proc/kmsg.
+	 * Enter in the force_console context so that sysrq header is shown to
+	 * provide the user with positive feedback.  We do not simply emit this
+	 * at KERN_EMERG as that would change message routing in the consumers
+	 * of /proc/kmsg.
 	 */
-	orig_log_level = console_loglevel;
-	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
+	printk_force_console_enter();
 
 	op_p = __sysrq_get_key_op(key);
 	if (op_p) {
@@ -609,11 +607,11 @@ void __handle_sysrq(u8 key, bool check_mask)
 		 */
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
 			pr_info("%s\n", op_p->action_msg);
-			console_loglevel = orig_log_level;
+			printk_force_console_exit();
 			op_p->handler(key);
 		} else {
 			pr_info("This sysrq operation is disabled.\n");
-			console_loglevel = orig_log_level;
+			printk_force_console_exit();
 		}
 	} else {
 		pr_info("HELP : ");
@@ -631,7 +629,7 @@ void __handle_sysrq(u8 key, bool check_mask)
 			}
 		}
 		pr_cont("\n");
-		console_loglevel = orig_log_level;
+		printk_force_console_exit();
 	}
 	rcu_read_unlock();
 	rcu_sysrq_end();

-- 
2.47.0

