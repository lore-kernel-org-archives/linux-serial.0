Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF640BA3D;
	Sat,  7 Jun 2025 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749309603; cv=none; b=sms6bEzsdGl4Fj0NKRPO8fId0VVtt8zy/6P5/hOh/MPuDiesFguiZomSuHp+wnO8fqvPyOwJbZIuTsY6j8zwLwK/zHxn3pQslyfhbNBJ/nap4A5VqJsJ/m/nWjyMpA2oudlQ2frxn9dUwbwTaGdgdiKUul0t3+lQpoZEbRsKvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749309603; c=relaxed/simple;
	bh=gyv5Tk+tnwyEu/aa8wWZlHhDsRTZQe8K5KsQgTs0fjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eqrf6SMWf3nCywgGjPt2YMvXEBQILhkq9LKEv1CmrpLMPocZ7XvQnWBaifNKLs6sY+/qMfCsP8g+r5iVwFfWTpMPepN3iELkraL76hbT7k85G4TaVZlyHVGfWB+1WfXn+KlFh2DR1VyRE+vxn+1qUA/Qj1yxNqgq81XsK6xku8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaxg2JHc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaxg2JHc"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45306976410so75225e9.3;
        Sat, 07 Jun 2025 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749309600; x=1749914400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTE00gsJLtw8U+ySTfNPcbjkilpcwpMIOJciN+h/WRI=;
        b=aaxg2JHcvOcs8sUfxnSqwx8Kl1mxXMly9BhDeNunYY263a37Ie3SMSdv/I2/EtsMBQ
         Pz1/4HY/kTH3854hYpRaD/Y9lXA2WtjpSSSOzh7uVaXkalV30XW+qEGmZbVaffBqMRPT
         +4CKi6vpvBnngqdOfa9l4aLAFBTzPfRQWtIH/p7njtsLKR85dYWZR+LDhe3kSbZd9VEp
         Js1YdEIEveuBRec7nQRbzp3kEgp+ZRlB+kdCrHSVUQ8ZJIPfQh6IrzrgU3iCR9g4dSWM
         QdH/KVwRGyB3yoR0M6rF3r/Yp8SdFJB0PBEeoyu1wt7HmOu4KNRil7msKQxfjXGFqc7f
         xYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749309600; x=1749914400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTE00gsJLtw8U+ySTfNPcbjkilpcwpMIOJciN+h/WRI=;
        b=qzcoPcOa05Goc6vForHOC//1dPqVr55hd1jDBQhmU8nWixrTKrC3k6IGS+AUZQwRX/
         s3tOD/0BZB8ponC9Rnsfs+GbFlXaThStUXGe05F0OlfyGv9q0Vgo97V/R3mR08zsL+Ig
         I0LetnO9jKDQ89mGqIlBv3HBun+PizlHNR8M+bXzykzigE3ZmarepMSr6TtPbIEC32Nz
         LKZHDYWi5xfSVO73pjXWF0sAlL2zo2B/w2AJJthjI9opa7JQJu0QOdTa9jKe0VWfta0z
         8YjY3WoHySoIOKHeWl1ikdAXORe474z7rsa2fPmv8g+GuCCKhpO++CT6YYYH8elec0bg
         wq8g==
X-Forwarded-Encrypted: i=1; AJvYcCX5WOkQj5kCb17IjPCF1ZrN1IdrS2+NKCipiKpsUedbQdeHbyqm+d2xuH7on+klQ7oGMZAQCmZI9d4p/baj@vger.kernel.org, AJvYcCXxKbAQ5sXu3uUUTw5YgaYSg+kFL0tbyQ+SF1F1OzZm/E9b8tkXG2x8DSA+9dGLoSvmDvIepjULXCS6+yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GLpgRhYkHBoQsa/xRNIEYlKrupwhqkVKDlF3na+/Cakrax0d
	kkAJtRTJiTlGurx7A984aZj5D2kpVApjvfZ3SibQmla6BnRgBqRXdbcu
X-Gm-Gg: ASbGnct/jHSPNgsWHCIerTmFZKgRTat2iol3jy0HdugGpS9jj0bxNdFDB4istn08DxZ
	aLfd7ypv8oGKjzFgLalh2cDh4Jz6FnC1rX2zfCKYvLNrfCKJ5m+wX47PUq8+EcguGx2ar1dQIvo
	YhRKJH17zN0Pcl1AnyzRRWGihM6sYbE70WlSdSKjh5YM8/0Y84qKL4K7jvO5kNNIaWj3ZNrXs1V
	2kin0coFJg3bcwBFAsQqB4yN9xWe4wOsbY76ZVUPhiU9hCjjlc75kPBDjr0myB1MpwzyOgmR9Kp
	jmwrQrrMOvL9g9fKFY5uqBYU9mY7qlzTlouuBeeA5xgQCJ1zLMHr8oSG6bclm3ETsMtwVGAI
X-Google-Smtp-Source: AGHT+IHCEZGb491KovOOY+BQpZK06iZcfii3iy5lfUPJJz5I0DSAfXyba4H1aPXo2HYlXJ6VXqcL8Q==
X-Received: by 2002:a05:600c:c04b:20b0:441:c5ee:cdb4 with SMTP id 5b1f17b1804b1-452a470122cmr14114515e9.4.1749309599651;
        Sat, 07 Jun 2025 08:19:59 -0700 (PDT)
Received: from DESKTOP-LCRLR8G.localdomain ([102.186.42.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45308fb16a6sm3783875e9.1.2025.06.07.08.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 08:19:59 -0700 (PDT)
From: Marwan Seliem <marwanmhks@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: sysrq: Introduce compile-time crash-only mode
Date: Sat,  7 Jun 2025 18:19:57 +0300
Message-Id: <20250607151957.222347-1-marwanmhks@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces a new Kconfig option, CONFIG_MAGIC_SYSRQ_CRASH_ONLY,
which allows for a significant hardening of the system by restricting
the Magic SysRq functionality at compile time.

Security Impact:
- Reduces attack surface by disabling non-essential SysRq commands
- Maintains critical crash-dump capability required for debugging
- Eliminates runtime configuration vulnerabilities

When CONFIG_MAGIC_SYSRQ_CRASH_ONLY is enabled:

1.  Restricted Commands: Only the 'c' (trigger a system crash/dump)
    SysRq command remains operational. All other built-in SysRq commands
    (e.g., reboot, sync, show-memory, SAK) are disabled.

2.  Runtime Registration Disabled: The kernel will no longer allow
    the registration of new SysRq key operations at runtime via
    register_sysrq_key(). Attempts to do so will return -EPERM and
    a warning will be logged.

3.  Crash Command Unregistration Prevented: The 'c' (crash) command
    cannot be unregistered at runtime if this Kconfig option is active.

4.  Proc Interface Hardening: The /proc/sys/kernel/sysrq interface,
    which normally allows runtime enabling/disabling of SysRq features,
    is effectively neutered for non-crash commands.
    - Writing to /proc/sys/kernel/sysrq to enable features other than
      the crash dump will be blocked (returns -EPERM with a warning).
    - The sysrq_on_mask() function, which checks if a specific SysRq
      operation is permitted, will only return true for the crash dump
      operation, regardless of the /proc/sys/kernel/sysrq bitmask or
      the sysrq_always_enabled kernel command line parameter.

5.  Restricted Help Output: When an invalid SysRq key is pressed, the
    help message printed to the console will only list the 'c' (crash)
    command, reflecting the restricted functionality.

6.  Compile-Time Table Modification: The sysrq_key_table is
    initialized at boot time by sysrq_init_crash_only_table() to
    contain only the sysrq_crash_op for the 'c' key. All other
    entries are set to NULL.

This feature provides a strong compile-time mechanism to reduce the
attack surface associated with the Magic SysRq key, limiting its use
to critical crash dump generation for debugging purposes, which is often
essential even in highly secure environments.

The sysrq_on() function is modified to always return true when
CONFIG_MAGIC_SYSRQ_CRASH_ONLY is set. This ensures that the SysRq

input handler is registered, allowing the Alt+SysRq+C key combination
to be processed, while the actual command filtering occurs deeper
within the SysRq logic.

Usage Recommendation:
For systems requiring:
1. Guaranteed crash-dump capability
2. Elimination of debug backdoors
3. Compliance with strict security requirements

Affected files:
lib/Kconfig.debug: Added CONFIG_MAGIC_SYSRQ_CRASH_ONLY.
drivers/tty/sysrq.c: Implemented the conditional logic
for restricted mode.

Signed-off-by: Marwan Seliem <marwanmhks@gmail.com>
---
 drivers/tty/sysrq.c | 79 ++++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug   | 13 ++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6853c4660e7c..2e574380bec4 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -61,7 +61,18 @@ static bool __read_mostly sysrq_always_enabled;
 
 static bool sysrq_on(void)
 {
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+	/*
+	 * In CRASH_ONLY mode, sysrq is considered "on" only for the purpose
+	 * of allowing the crash command. The actual check for individual
+	 * commands happens in sysrq_on_mask().
+	 * For general "is sysrq on?" queries (like for input handler reg),
+	 * it should reflect that at least something (crash) is possible.
+	 */
+	return true;
+#else
 	return sysrq_enabled || sysrq_always_enabled;
+#endif
 }
 
 /**
@@ -82,9 +93,19 @@ EXPORT_SYMBOL_GPL(sysrq_mask);
  */
 static bool sysrq_on_mask(int mask)
 {
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+	/*
+	 * If CRASH_ONLY is set, only allow operations that have the
+	 * SYSRQ_ENABLE_DUMP mask (which sysrq_crash_op uses).
+	 * This makes sysrq_enabled and sysrq_always_enabled irrelevant
+	 * for other operations.
+	 */
+	return mask == SYSRQ_ENABLE_DUMP;
+#else
 	return sysrq_always_enabled ||
 	       sysrq_enabled == 1 ||
 	       (sysrq_enabled & mask);
+#endif
 }
 
 static int __init sysrq_always_enabled_setup(char *str)
@@ -557,6 +578,21 @@ static int sysrq_key_table_key2index(u8 key)
 	}
 }
 
+/*
+ * Initialize the sysrq_key_table at boot time if CRASH_ONLY is set.
+ * This ensures only the crash handler is active.
+ */
+static void __init sysrq_init_crash_only_table(void)
+{
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+	int i;
+	const struct sysrq_key_op *crash_op = &sysrq_crash_op;
+	for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++)
+		sysrq_key_table[i] = NULL;
+	sysrq_key_table[sysrq_key_table_key2index('c')] = crash_op;
+#endif
+};
+
 /*
  * get and put functions for the table, exposed to modules.
  */
@@ -584,7 +620,6 @@ void __handle_sysrq(u8 key, bool check_mask)
 {
 	const struct sysrq_key_op *op_p;
 	int orig_suppress_printk;
-	int i;
 
 	orig_suppress_printk = suppress_printk;
 	suppress_printk = 0;
@@ -599,7 +634,15 @@ void __handle_sysrq(u8 key, bool check_mask)
 	 */
 	printk_force_console_enter();
 
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+	if (key != 'c') { /* In CRASH_ONLY mode, only 'c' is considered */
+		op_p = NULL;
+	} else {
+		op_p = __sysrq_get_key_op(key);
+	}
+#else
 	op_p = __sysrq_get_key_op(key);
+#endif
 	if (op_p) {
 		/*
 		 * Should we check for enabled operations (/proc/sysrq-trigger
@@ -615,6 +658,15 @@ void __handle_sysrq(u8 key, bool check_mask)
 		}
 	} else {
 		pr_info("HELP : ");
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+		/* Check if the crash op is actually in the table and is the crash_op. */
+		if (sysrq_key_table_key2index('c') != -1 &&
+		    sysrq_key_table[sysrq_key_table_key2index('c')] == &sysrq_crash_op)
+			pr_cont("%s ", sysrq_crash_op.help_msg);
+		else /* Should not happen if table is defined correctly */
+			pr_cont("[Crash command not available] ");
+#else
+		int i;
 		/* Only print the help msg once per handler */
 		for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
 			if (sysrq_key_table[i]) {
@@ -628,6 +680,7 @@ void __handle_sysrq(u8 key, bool check_mask)
 				pr_cont("%s ", sysrq_key_table[i]->help_msg);
 			}
 		}
+#endif
 		pr_cont("\n");
 		printk_force_console_exit();
 	}
@@ -1104,6 +1157,10 @@ static inline void sysrq_unregister_handler(void)
 
 int sysrq_toggle_support(int enable_mask)
 {
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+	pr_warn("SysRq: CONFIG_MAGIC_SYSRQ_CRASH_ONLY is set. Runtime toggle is not allowed.\n");
+	return -EPERM;
+#else
 	bool was_enabled = sysrq_on();
 
 	sysrq_enabled = enable_mask;
@@ -1116,6 +1173,7 @@ int sysrq_toggle_support(int enable_mask)
 	}
 
 	return 0;
+#endif
 }
 EXPORT_SYMBOL_GPL(sysrq_toggle_support);
 
@@ -1145,12 +1203,30 @@ static int __sysrq_swap_key_ops(u8 key, const struct sysrq_key_op *insert_op_p,
 
 int register_sysrq_key(u8 key, const struct sysrq_key_op *op_p)
 {
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+	/*
+	 * In CRASH_ONLY mode, do not allow registering new SysRq ops.
+	 */
+	pr_warn("SysRq: CONFIG_MAGIC_SYSRQ_CRASH_ONLY is set. Cannot register new SysRq key '%c'.\n", key);
+	return -EPERM;
+#endif
 	return __sysrq_swap_key_ops(key, op_p, NULL);
 }
 EXPORT_SYMBOL(register_sysrq_key);
 
 int unregister_sysrq_key(u8 key, const struct sysrq_key_op *op_p)
 {
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+	/*
+	 * In CRASH_ONLY mode, do not allow unregistering the crash op.
+	 * Other ops should be NULL anyway due to sysrq_init_crash_only_table.
+	 */
+	if (op_p == &sysrq_crash_op) {
+		pr_warn("SysRq: CONFIG_MAGIC_SYSRQ_CRASH_ONLY is set. Cannot unregister the crash SysRq key '%c'.\n", key);
+		return -EPERM;
+	}
+	return -EPERM; /* Attempt to unregister anything else is also an error */
+#endif
 	return __sysrq_swap_key_ops(key, NULL, op_p);
 }
 EXPORT_SYMBOL(unregister_sysrq_key);
@@ -1209,6 +1285,7 @@ static inline void sysrq_init_procfs(void)
 static int __init sysrq_init(void)
 {
 	sysrq_init_procfs();
+	sysrq_init_crash_only_table();
 
 	if (sysrq_on())
 		sysrq_register_handler();
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6..c05b80cfb8aa 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -640,6 +640,19 @@ config MAGIC_SYSRQ_DEFAULT_ENABLE
 	  This may be set to 1 or 0 to enable or disable them all, or
 	  to a bitmask as described in Documentation/admin-guide/sysrq.rst.
 
+config MAGIC_SYSRQ_CRASH_ONLY
+	bool "Restrict Magic SysRq to crash command only"
+	depends on MAGIC_SYSRQ
+	default n
+	help
+	  If you say Y here, the Magic SysRq key functionality will be
+	  severely restricted at compile time. Only the 'c' command (trigger
+	  a system crash) will be available. All other SysRq commands will be
+	  disabled, and no new SysRq commands can be registered at runtime.
+	  The /proc/sys/kernel/sysrq setting will be ineffective for
+	  non-crash commands, and attempts to change it may be blocked.
+	  This is a security hardening option.
+
 config MAGIC_SYSRQ_SERIAL
 	bool "Enable magic SysRq key over serial"
 	depends on MAGIC_SYSRQ
-- 
2.33.0.windows.2

