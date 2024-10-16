Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E04212634;
	Wed, 16 Oct 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098213; cv=none; b=GYnOAy/n/w77Y9XxVt6KCuD0NYFKPFBdc4R3ZUiFevyjUUpTpVkAQRyVsIe04w5gQ3l/PEtx2Ex0UAzPDavRqcBVmGusHUolsWXe0d1eQa0qOW+zzAtCrnGE3iIkSjfuJatiAdBsNQbf2+6qUMi6RJ14ulFMzGJVdhhVjmixRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098213; c=relaxed/simple;
	bh=F/aU2sHXwjZHWO3m/bFKodRBVQZGao3dZspIyBubxII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AjPl9BbUisRY3xrP0LI0RCtV6m7nIItJwRAhTcllSJqJTwnCFnejj49Ad7dpSH8L/bqp6tZfKzEvWEtBHb+tIdMQ66XO/vZ9NtamrazwfH3om2iWfCYkZREuJYGJqehZxz846eSBXWy5P4XSVmwqNiBKQl/RD81bRQuJ6q1Px/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B979421EE1;
	Wed, 16 Oct 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FC9513433;
	Wed, 16 Oct 2024 17:03:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9e6QAeHxD2dyTQAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 16 Oct 2024 17:03:29 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 16 Oct 2024 14:03:02 -0300
Subject: [PATCH 2/2] tty: sysrq: Use printk_loud_console context on
 __handle_sysrq
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-printk-loud-con-v1-2-065e4dad6632@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729098195; l=2232;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=F/aU2sHXwjZHWO3m/bFKodRBVQZGao3dZspIyBubxII=;
 b=IuIKzjlkdpQ6PhHDrZvZO+AXN3E0QXYqHX1yuTLlWDk5Q7q65QT4o6CK+uA8/zhhJgfRIAGP7
 Va1Wk5NWACXDk/8lnj3DtYp6a2xX55sZeK3uogVc0ptegCZR25EJAWf
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B979421EE1
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

By using the printk_loud_console the loglevel workaround can be removed.
The workaround existed to always send the sysrq header message to all
consoles not matter what was the current loglevel.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/sysrq.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 930b04e3d148..1ff11cf6275a 100644
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
+	 * Enter in the console_loud context so that sysrq header is shown to
+	 * provide the user with positive feedback.  We do not simply emit this
+	 * at KERN_EMERG as that would change message routing in the consumers
+	 * of /proc/kmsg.
 	 */
-	orig_log_level = console_loglevel;
-	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
+	printk_loud_console_enter();
 
 	op_p = __sysrq_get_key_op(key);
 	if (op_p) {
@@ -609,11 +607,11 @@ void __handle_sysrq(u8 key, bool check_mask)
 		 */
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
 			pr_info("%s\n", op_p->action_msg);
-			console_loglevel = orig_log_level;
+			printk_loud_console_exit();
 			op_p->handler(key);
 		} else {
 			pr_info("This sysrq operation is disabled.\n");
-			console_loglevel = orig_log_level;
+			printk_loud_console_exit();
 		}
 	} else {
 		pr_info("HELP : ");
@@ -631,7 +629,7 @@ void __handle_sysrq(u8 key, bool check_mask)
 			}
 		}
 		pr_cont("\n");
-		console_loglevel = orig_log_level;
+		printk_loud_console_exit();
 	}
 	rcu_read_unlock();
 	rcu_sysrq_end();

-- 
2.46.1

