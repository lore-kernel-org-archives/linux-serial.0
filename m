Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214232580F3
	for <linux-serial@vger.kernel.org>; Sat,  7 Jun 2025 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749264854; cv=none; b=Q8TAnvRZKwJBTtExscA0AURIfteP0dndyjK0pXocPW38ebNn0hTi8ku8mAxiPCPzdUbBVLVIiU5j1P9GUnPlzBaASPRD9lkvXcd3Ex+vqXKe1fq0nsoh1ONosxtupi3j9ntceUpBKQFwLJKdUi0zBxHPK2vO5BwNTrBWicp69ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749264854; c=relaxed/simple;
	bh=1gk8U8A9Tp8dYd1sZPBSwCndj58kUaiYwQ9Z81qrFXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LPA2oHQQJ3UM6EK1UofANycrkzgSTv9xhQ/rJa5lOiIQAhZ4N20BLRkM+otv9GVBVg+wyzza8/ZxAvCTzRSMJ5NO9uvlIiwT/tUacNmwFf3jB+9nExW7FWxiELSeMBIUpWyp+zcIyEN7VfWVcxhkyrhPGpKFdX7WsQ+4VXIiXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HrzHXgEU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HrzHXgEU"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so1570519f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 06 Jun 2025 19:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264850; x=1749869650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mX7Kpvr3d8Igbqg1Pi5Y0v9vR933SOfz9K97ZuvSH2o=;
        b=HrzHXgEU2yt4Pv3F4UD8ayJcVuMQmC4tISl5Fv8etbHyHuB/5ItjQMERxBhn/6CY7j
         8WZN4g/L33MuU9C+KS9djt5EZaL01P5uPA7ASPMi8NiTiR5uzbytWF8/YK16XmwUnEV2
         vNdJM4H9BLTNtXpZ4kIRHv2Th1eFTFP48VhzBjv0ySEozKeRDkoyvGK05Ct63iaaZ5NQ
         xkKBRm7DogdLmYnsAN2cd0E4zsdgwK3T+H1kTx/hg70DZc7sVyptPH/gMINzMkjsJsNX
         35Dktci8FIt797QmIJDixyclxvHyAHXXc+eNaWfgLGw5tHfE56OJF+kw7HIt+aZWfCzc
         1Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264850; x=1749869650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX7Kpvr3d8Igbqg1Pi5Y0v9vR933SOfz9K97ZuvSH2o=;
        b=wF1ExKDg4ltegF4fKiU7gOBP74MKZgNisxm8FXbqi0axYDyv6smFg2Oem5v2d7VUei
         fhvvWS9PMRaw9TCfouVZzY9xryNRgpRFrKxoeknU3s7raTv+SZuyr75714Hz/CleWCm0
         5HMlkk58WJ4+lNrUVncHhAGznD4g2H9Ybqz3LJufQU1NQOiQJmb+WPmpYmKVfFdIc6ZB
         rZqsDt6O0pi02A3o6IFU1FxI08fa9k+2aLddrl694P17MEzQtFU6aJCekCLNDGMGPFiP
         70znPSLFmhJjNhvgN2p11Ns/QyfGD2KvHiccvy6p2sWAsNYUJAJmsCy9dFNMMADB7ltT
         aG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8K20NrLQTDjytCvHxibPyvyUtqdTjA38ADIcgSgOKcb/YOvMZW2kBZtr51YN5moDTg2oUiSoHIbMLUiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3BT0ZS8cWkeJ0zFX71b18T6lMRk7HRDVDWwYj71hq75+0iMX
	sEeH/Z7sYSqCZecX943XuD2SB2Bc9mW2zHsjH2iVNXQYK2kEHHTWwJ0cLILKAGI9A0w=
X-Gm-Gg: ASbGncvu6+xhIsbqlSmvnuCV6oykHjkHtriZDrEecKKw7F7KTJIlE8YUoOVbPX4x3aH
	vdXENmT0GpikENrPcTaO0waDbpIOghnRGSvXCeWtJZfUnzP539ZMfHrZ+wDLZ1RbGm1C3eSVSGH
	jYJEds0pkVxsl4yAPUBXnPMSdZvvtqpyG7UVS7S/T9ixvENQA0i1GfrNGvEKFJBBwHTvYorNPLV
	yu/mRpZyMi0WqxltGcI9xU5Rmwfjt8VN2D6mKeItRoosLtqtEvbCz7Dpr5bRRgVs0jCxZCNwufA
	d7hlDoM+pVBRUivJg5F+XoguvxFNiVVr+JtybEQuYmX1AhPaavlt+nMYToNhAlgvTzDPDA==
X-Google-Smtp-Source: AGHT+IHTkyMEV1xuLGonC7LtgR95ygfYX+hJ/eUxGPUUwzB9N83jBsaILJv4Qv7aHZROQ6yhMrIkHQ==
X-Received: by 2002:a05:6000:188f:b0:3a4:f7dc:8a62 with SMTP id ffacd0b85a97d-3a531453ce7mr4234829f8f.0.1749264850369;
        Fri, 06 Jun 2025 19:54:10 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:09 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:44 -0300
Subject: [PATCH 2/7] printk: Use consoles_suspended flag when
 suspending/resuming all consoles
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
In-Reply-To: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=6242;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=1gk8U8A9Tp8dYd1sZPBSwCndj58kUaiYwQ9Z81qrFXo=;
 b=wvHq6UkjGv8LUZFpyT85kU4YEf7UvDpnRljGGj2r3IAnPOf6zps3o5cncvffNGYqnHhCIQTlN
 5oFz1z/ahtlC5MWr0tDhAmLDLFHk/lTOiZuZ/P7/OtnsVSS6Dx7AMqH
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

Instead of update a per-console CON_SUSPENDED flag, use the console_list
locks to protect this flag. This is also applied to console_is_usable
functions, which now also checks if consoles_suspend is set.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/printk/internal.h |  7 ++++++-
 kernel/printk/nbcon.c    |  8 ++++----
 kernel/printk/printk.c   | 23 ++++++++++-------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 48a24e7b309db20fdd7419f7aeda68ea7c79fd80..752101904f44b13059b6a922519d88e24c9f32c0 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -118,8 +118,12 @@ void nbcon_kthreads_wake(void);
  * which can also play a role in deciding if @con can be used to print
  * records.
  */
-static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
+static inline bool console_is_usable(struct console *con, short flags,
+				     bool use_atomic, bool consoles_suspended)
 {
+	if (consoles_suspended)
+		return false;
+
 	if (!(flags & CON_ENABLED))
 		return false;
 
@@ -212,6 +216,7 @@ extern bool have_boot_console;
 extern bool have_nbcon_console;
 extern bool have_legacy_console;
 extern bool legacy_allow_panic_sync;
+extern bool consoles_suspended;
 
 /**
  * struct console_flush_type - Define available console flush methods
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fd12efcc4aeda8883773d9807bc215f6e5cdf71a..72de12396e6f1bc5234acfdf6dcc393acf88d216 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1147,7 +1147,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 	cookie = console_srcu_read_lock();
 
 	flags = console_srcu_read_flags(con);
-	if (console_is_usable(con, flags, false)) {
+	if (console_is_usable(con, flags, false, consoles_suspended)) {
 		/* Bring the sequence in @ctxt up to date */
 		ctxt->seq = nbcon_seq_read(con);
 
@@ -1206,7 +1206,7 @@ static int nbcon_kthread_func(void *__console)
 
 		con_flags = console_srcu_read_flags(con);
 
-		if (console_is_usable(con, con_flags, false))
+		if (console_is_usable(con, con_flags, false, consoles_suspended))
 			backlog = nbcon_emit_one(&wctxt, false);
 
 		console_srcu_read_unlock(cookie);
@@ -1584,7 +1584,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
 		if (!(flags & CON_NBCON))
 			continue;
 
-		if (!console_is_usable(con, flags, true))
+		if (!console_is_usable(con, flags, true, consoles_suspended))
 			continue;
 
 		if (nbcon_seq_read(con) >= stop_seq)
@@ -1795,7 +1795,7 @@ void nbcon_device_release(struct console *con)
 	 */
 	cookie = console_srcu_read_lock();
 	printk_get_console_flush_type(&ft);
-	if (console_is_usable(con, console_srcu_read_flags(con), true) &&
+	if (console_is_usable(con, console_srcu_read_flags(con), true, consoles_suspended) &&
 	    !ft.nbcon_offload &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		/*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6d3cf488f4261a3dfd8809a5ab7164b218238c13..658acf92aa3d2a3d1e294b7e17e5ee96d8169afe 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -241,7 +241,7 @@ int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 /**
  * console_list_lock - Lock the console list
  *
- * For console list or console->flags updates
+ * For console list, console->flags and consoles_suspended updates
  */
 void console_list_lock(void)
 {
@@ -383,6 +383,8 @@ bool other_cpu_in_panic(void)
  */
 static int console_locked;
 
+bool consoles_suspended;
+
 /*
  *	Array of consoles built from command line options (console=)
  */
@@ -2755,16 +2757,13 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to hig
  */
 void console_suspend_all(void)
 {
-	struct console *con;
-
 	if (!console_suspend_enabled)
 		return;
 	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
 	pr_flush(1000, true);
 
 	console_list_lock();
-	for_each_console(con)
-		console_srcu_write_flags(con, con->flags | CON_SUSPENDED);
+	consoles_suspended = true;
 	console_list_unlock();
 
 	/*
@@ -2779,14 +2778,12 @@ void console_suspend_all(void)
 void console_resume_all(void)
 {
 	struct console_flush_type ft;
-	struct console *con;
 
 	if (!console_suspend_enabled)
 		return;
 
 	console_list_lock();
-	for_each_console(con)
-		console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
+	consoles_suspended = false;
 	console_list_unlock();
 
 	/*
@@ -3214,7 +3211,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
 				continue;
 
-			if (!console_is_usable(con, flags, !do_cond_resched))
+			if (!console_is_usable(con, flags, !do_cond_resched, consoles_suspended))
 				continue;
 			any_usable = true;
 
@@ -3604,7 +3601,7 @@ static bool legacy_kthread_should_wakeup(void)
 		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
-		if (!console_is_usable(con, flags, false))
+		if (!console_is_usable(con, flags, false, consoles_suspended))
 			continue;
 
 		if (flags & CON_NBCON) {
@@ -4165,7 +4162,7 @@ static int unregister_console_locked(struct console *console)
 
 	if (!console_is_registered_locked(console))
 		res = -ENODEV;
-	else if (console_is_usable(console, console->flags, true))
+	else if (console_is_usable(console, console->flags, true, consoles_suspended))
 		__pr_flush(console, 1000, true);
 
 	/* Disable it unconditionally */
@@ -4445,8 +4442,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c, flags, true) &&
-			    !console_is_usable(c, flags, false)) {
+			if (!console_is_usable(c, flags, true, consoles_suspended) &&
+			    !console_is_usable(c, flags, false, consoles_suspended)) {
 				continue;
 			}
 

-- 
2.49.0

