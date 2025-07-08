Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EB38385;
	Tue,  8 Jul 2025 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961429; cv=none; b=SNaFKJUq69Vz7mhO5m2JkuK6OsW1jY/J9t93bJ56WFiz/gkNG6JnjVcd/4h4tlVsJholNtGBMJQTLrQpNaVhFv8op2Yo+879FK29El0gDN1Gn9dO5yAtfuWTStaMeyYob8UNHCsgbIHTBygl2Ek9rSsW5DBEmseBXLpw22IC04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961429; c=relaxed/simple;
	bh=8sXEIOHXfp/nTSLz/U9NcRfjN1jWLKVhUh0J40iDc04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V89Q6AXYno4TuyX3xiHggc/zb6fSx3o8MNAq+lz3YlzaLXhXC5yjhv860SgBp7RB/MAeUInxl097i1S9gSgjQmgJ1dH3iMWkuTHQxbOD9XF2txHZmCtwho5Uku3JeIrqKocO7N2AleBGWcVWPphM2T1bXJVaek6co0km8eenZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcyDu80X; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcyDu80X"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a52878d37aso521702f8f.2;
        Tue, 08 Jul 2025 00:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751961425; x=1752566225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=osbcHSqXKEogRbBXBNixGDu9ctqy+6YbT6eV0sEJp4g=;
        b=EcyDu80Xbr5FTmDAqew4PcXrIzJ9hfwMkwbj0RzUvrwbsy6KN8n0o6xsQjvsYlmPXl
         hIgEZOL0w6C64mGw6GRkTcMNtobreZeqqjrFYArlfMIrlMHmBUM0G/rbp++ZoHBwKH3g
         0d3j3gtCpcdsdR31jiSqutDshSM8ps9bE6aJDffid4oagkafOdiWARaF156oL+PV8TEp
         grwoG8rhZJ3AWIN2leGaqVJ+jSu7Iguax1FNOIlXyydG6vXQjYdUer4SiArznCH0zXCc
         DTH0EikItpNJ4FNVcwVYwXTykuCblEWg0JqdJ6n0lStxzsuSlQJbGsVhWtiW3zdUTUf5
         R8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751961425; x=1752566225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osbcHSqXKEogRbBXBNixGDu9ctqy+6YbT6eV0sEJp4g=;
        b=m3DjTTgx5rlbTiFWKstS6wxIw9atpAM/MIOrSuJodfQolaXDyC2seFY82KL9v2Func
         7QotM6W5O9YwVIusSC49U65JVOr/frnmHqpNNuJ83fwRO7juSRqi+mM9nWZQeWRV/gte
         CLZ4sHy7va9srtorobCDuGkjCa0AVLycTvkbSU40+DmP2gj4mrdzeR630PlBh9WdWlHN
         Qk3sUpyDfNKipr+vaq8Sfgwn+IGJvGLlWjUGkjcy96bNYJcsVkrmjQOybClD+hmKHzJN
         4RoayymMshkfQeYFPCW9idIwfrBi1TS1fjhUm7VsjI5IRcZYYOzWFOpQsMjCj5LoMspB
         PUZg==
X-Forwarded-Encrypted: i=1; AJvYcCU4SFOzGQekpQEO61E4itBaB95rCOdzqW8vfg8BTl2YZtnZqCdNdqUqUGHmG//3jNU24w/HuvqB6fyBlS66@vger.kernel.org, AJvYcCVWdwF2YCoJ9GEc9c8vNo4DtP5pScjjS7vIzqtEJdKnJs4acTDuXgzLiaJby6V8NHPTVzTSWMDzmpa4eV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31wCMSFh0sf6pSecsJFttLil0qc6WIVeMLug5GcIPoRihhuCe
	88fz3yk6a9kWaISXf6ocyjBGHGQ2z6eLnBgBeWxO6kbCIMsbjAifQkYJD2ZGFR0g
X-Gm-Gg: ASbGncvVEIeHcOAT4eCWtNC+tjIVEcFJ0Vi2K2f94D+QyJUe8v8zY8fyma5so3PoSjM
	cgYymgBhhakaaZ+KcdOk9d8pN2Od70aBl/hK52zr2XAjpNZmhv0zRRx5VY918XaUhjE67rciM3s
	8/pmQRLq2O4FVplSzbuZ23ckcBwI3HYyRiPNGbQWxHSfl+qJfyjhRcM3/6v2DiD27Odip4R5k3E
	/3wluaW3O02BGyjZoegS6R7DkpvSh4DzJvyX0YAwNvyfXqcuoIQ68AIQb/IQIwtrChyy+q7Fk4t
	r1mWlwCDMo01tDYh/DNhqeXa/UlC1QkNHL1hNulvHIOv0LKUhp/wo92LXSs+KyFU1Cscz188OVN
	GHNxkqn0=
X-Google-Smtp-Source: AGHT+IHxgxJS35i+PLDmIDRAq2unSxrOYtCTvCxRmXyuFrInXJWZz0VWtgGicfL1f/f+fSvMKzrVnw==
X-Received: by 2002:a05:6000:2912:b0:3a4:d0dc:184b with SMTP id ffacd0b85a97d-3b4964f8ab6mr4748206f8f.6.1751961424843;
        Tue, 08 Jul 2025 00:57:04 -0700 (PDT)
Received: from DESKTOP-LCRLR8G.localdomain ([196.130.55.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030b9desm12399979f8f.19.2025.07.08.00.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 00:57:04 -0700 (PDT)
From: Marwan Seliem <marwanmhks@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2] tty: sysrq: Introduce compile-time crash-only mode
Date: Tue,  8 Jul 2025 10:57:01 +0300
Message-Id: <20250708075701.22988-1-marwanmhks@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Magic SysRq facility, while a powerful tool for debugging, presents a
significant attack surface. A user with console access or sufficient
privileges can use SysRq commands to reboot the system ('b'), terminate
all processes ('i'), or perform other disruptive actions. These actions
can lead to denial-of-service or be used to hide traces of an intrusion.

While SysRq can be disabled via a sysctl, a privileged user can often
re-enable it at runtime. For hardened systems where the only required
SysRq functionality is generating a kdump for post-mortem analysis, a
stronger, permanent restriction is necessary.

This commit introduces the Kconfig option `CONFIG_MAGIC_SYSRQ_CRASH_ONLY`
to provide a compile-time guarantee that only the 'c' (crash) command
is available. This allows system administrators to build a kernel that
supports critical crash dump generation while completely removing the
attack surface presented by all other SysRq commands.

When `CONFIG_MAGIC_SYSRQ_CRASH_ONLY` is enabled, the kernel is hardened
in the following ways:

1.  Restricted Commands: Only the 'c' (trigger a system crash/dump)
    SysRq command is operational. All other built-in SysRq commands are
    disabled at compile time.

2.  Runtime Registration Disabled: The kernel rejects any attempt to
    register new SysRq key operations at runtime via `register_sysrq_key()`,
    returning -EPERM.

3.  Crash Command Unregistration Prevented: The 'c' (crash) command
    cannot be unregistered.

4.  Sysctl Hardening: The `/proc/sys/kernel/sysrq` interface is neutered.
    Any write to this interface is rejected with -EPERM, preventing
    runtime attempts to alter the SysRq mask. The kernel will only
    permit the crash operation, regardless of the `sysrq_always_enabled`
    kernel command line parameter.

5.  Trigger Hardening: Writing any character other than 'c' to
    `/proc/sysrq-trigger` is rejected with -EPERM.

6.  Restricted Help Output: The help message, triggered by an invalid
    SysRq key, will only list the 'c' (crash) command.

This feature provides a robust, compile-time mechanism to lock down
SysRq functionality, ensuring that even a privileged user cannot bypass
the intended security policy.

---
v2:
- Adjust #ifdef style to align with existing patterns in sysrq.c.
- Block writes to the /proc/sys/kernel/sysrq sysctl with -EPERM when
  in crash-only mode, with a rate-limited warning.
- Return -EPERM from the /proc/sysrq-trigger write handler if the
  requested command is not 'c'.
- Rate-limit warning messages generated from userspace-triggered events
  to prevent log-flooding.

Affected files:
- lib/Kconfig.debug: Added `CONFIG_MAGIC_SYSRQ_CRASH_ONLY`.
- drivers/tty/sysrq.c: Implemented the conditional logic for
  restricted mode.
- kernel/sysctl.c: Use the sysrq_toggle_support return to deny illegal toggle

Signed-off-by: Marwan Seliem <marwanmhks@gmail.com>
---
 drivers/tty/sysrq.c | 87 +++++++++++++++++++++++++++++++++++++++++++--
 kernel/sysctl.c     |  4 +--
 lib/Kconfig.debug   | 27 ++++++++++++++
 3 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6853c4660e7c..cccfdb0ed6d4 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -59,11 +59,25 @@
 static int __read_mostly sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
 static bool __read_mostly sysrq_always_enabled;
 
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+	/*
+	* In CRASH_ONLY mode, sysrq is considered "on" only for the purpose
+	* of allowing the crash command. The actual check for individual
+	* commands happens in sysrq_on_mask().
+	* For general "is sysrq on?" queries (like for input handler reg),
+	* it should reflect that at least something (crash) is possible.
+	*/
+static bool sysrq_on(void)
+{
+	return true;
+}
+#else
 static bool sysrq_on(void)
 {
 	return sysrq_enabled || sysrq_always_enabled;
 }
 
+#endif
 /**
  * sysrq_mask - Getter for sysrq_enabled mask.
  *
@@ -80,12 +94,25 @@ EXPORT_SYMBOL_GPL(sysrq_mask);
 /*
  * A value of 1 means 'all', other nonzero values are an op mask:
  */
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+	/*
+	* If CRASH_ONLY is set, only allow operations that have the
+	* SYSRQ_ENABLE_DUMP mask (which sysrq_crash_op uses).
+	* This makes sysrq_enabled and sysrq_always_enabled irrelevant
+	* for other operations.
+	*/
+static bool sysrq_on_mask(int mask)
+{
+	return mask == SYSRQ_ENABLE_DUMP;
+}
+#else
 static bool sysrq_on_mask(int mask)
 {
 	return sysrq_always_enabled ||
 	       sysrq_enabled == 1 ||
 	       (sysrq_enabled & mask);
 }
+#endif
 
 static int __init sysrq_always_enabled_setup(char *str)
 {
@@ -462,7 +489,9 @@ static struct sysrq_key_op sysrq_replay_logs_op = {
 };
 
 /* Key Operations table and lock */
+#ifndef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
 static DEFINE_SPINLOCK(sysrq_key_table_lock);
+#endif
 
 static const struct sysrq_key_op *sysrq_key_table[62] = {
 	&sysrq_loglevel_op,		/* 0 */
@@ -542,6 +571,28 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 	NULL,				/* Z */
 };
 
+
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+/* key2index calculation, -1 on anything except 'c' */
+static int sysrq_key_table_key2index(u8 key)
+{
+	if (key == 'c')
+		return key - 'a' + 10;
+	return -1;
+}
+/*
+ * Initialize the sysrq_key_table at boot time if CRASH_ONLY is set.
+ * This ensures only the crash handler is active.
+ */
+static void __init sysrq_init_crash_only_table(void)
+{
+	int i;
+	const struct sysrq_key_op *crash_op = &sysrq_crash_op;
+	for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++)
+		sysrq_key_table[i] = NULL;
+	sysrq_key_table[sysrq_key_table_key2index('c')] = crash_op;
+}
+#else
 /* key2index calculation, -1 on invalid index */
 static int sysrq_key_table_key2index(u8 key)
 {
@@ -556,6 +607,10 @@ static int sysrq_key_table_key2index(u8 key)
 		return -1;
 	}
 }
+static void __init sysrq_init_crash_only_table(void)
+{
+}
+#endif
 
 /*
  * get and put functions for the table, exposed to modules.
@@ -572,6 +627,7 @@ static const struct sysrq_key_op *__sysrq_get_key_op(u8 key)
 	return op_p;
 }
 
+#ifndef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
 static void __sysrq_put_key_op(u8 key, const struct sysrq_key_op *op_p)
 {
 	int i = sysrq_key_table_key2index(key);
@@ -579,6 +635,7 @@ static void __sysrq_put_key_op(u8 key, const struct sysrq_key_op *op_p)
 	if (i != -1)
 		sysrq_key_table[i] = op_p;
 }
+#endif
 
 void __handle_sysrq(u8 key, bool check_mask)
 {
@@ -1102,6 +1159,24 @@ static inline void sysrq_unregister_handler(void)
 
 #endif /* CONFIG_INPUT */
 
+#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
+int sysrq_toggle_support(int enable_mask)
+{
+	pr_warn_ratelimited("SysRq: CONFIG_MAGIC_SYSRQ_CRASH_ONLY is set. Runtime toggle is not allowed.\n");
+	return -EPERM;
+}
+
+int register_sysrq_key(u8 key, const struct sysrq_key_op *op_p)
+{
+	pr_warn_ratelimited("SysRq: CONFIG_MAGIC_SYSRQ_CRASH_ONLY is set. Cannot register new SysRq key '%c'.\n", key);
+	return -EPERM;
+}
+int unregister_sysrq_key(u8 key, const struct sysrq_key_op *op_p)
+{
+	pr_warn_ratelimited("SysRq: CONFIG_MAGIC_SYSRQ_CRASH_ONLY is set. Cannot unregister the crash SysRq key '%c'.\n", key);
+	return -EPERM;
+}
+#else
 int sysrq_toggle_support(int enable_mask)
 {
 	bool was_enabled = sysrq_on();
@@ -1117,7 +1192,6 @@ int sysrq_toggle_support(int enable_mask)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(sysrq_toggle_support);
 
 static int __sysrq_swap_key_ops(u8 key, const struct sysrq_key_op *insert_op_p,
 				const struct sysrq_key_op *remove_op_p)
@@ -1147,12 +1221,14 @@ int register_sysrq_key(u8 key, const struct sysrq_key_op *op_p)
 {
 	return __sysrq_swap_key_ops(key, op_p, NULL);
 }
-EXPORT_SYMBOL(register_sysrq_key);
 
 int unregister_sysrq_key(u8 key, const struct sysrq_key_op *op_p)
 {
 	return __sysrq_swap_key_ops(key, NULL, op_p);
 }
+#endif
+EXPORT_SYMBOL_GPL(sysrq_toggle_support);
+EXPORT_SYMBOL(register_sysrq_key);
 EXPORT_SYMBOL(unregister_sysrq_key);
 
 #ifdef CONFIG_PROC_FS
@@ -1174,6 +1250,9 @@ static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
 		if (get_user(c, buf + i))
 			return -EFAULT;
 
+		if (c != 'c')
+			return -EPERM;
+
 		if (c == '_')
 			bulk = true;
 		else
@@ -1210,8 +1289,10 @@ static int __init sysrq_init(void)
 {
 	sysrq_init_procfs();
 
-	if (sysrq_on())
+	if (sysrq_on()) {
 		sysrq_register_handler();
+		sysrq_init_crash_only_table();
+	}
 
 	return 0;
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9b4f0cff76ea..097a19948926 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -982,9 +982,9 @@ static int sysrq_sysctl_handler(const struct ctl_table *table, int write,
 		return ret;
 
 	if (write)
-		sysrq_toggle_support(tmp);
+		ret = sysrq_toggle_support(tmp);
 
-	return 0;
+	return ret;
 }
 #endif
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6..02bc19241711 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -640,6 +640,33 @@ config MAGIC_SYSRQ_DEFAULT_ENABLE
 	  This may be set to 1 or 0 to enable or disable them all, or
 	  to a bitmask as described in Documentation/admin-guide/sysrq.rst.
 
+config MAGIC_SYSRQ_CRASH_ONLY
+	bool "Only allow the crash command for Magic SysRq"
+	depends on MAGIC_SYSRQ
+	default n
+	help
+	  This option provides a significant security hardening for the Magic
+	  SysRq facility by restricting its functionality at compile time to
+	  only the 'c' (crash) command.
+
+	  If you say Y here, the kernel will be built with the following
+	  restrictions:
+	  - Only the 'c' command to trigger a system crash/kdump will be
+	    operational. All other built-in commands (reboot, sync, SAK,
+	    show-memory, etc.) are completely disabled.
+	  - Registration of new SysRq commands at runtime will be blocked.
+	  - The /proc/sys/kernel/sysrq interface will be hardened,
+	    preventing any runtime changes to the SysRq mask.
+	  - Writing any character other than 'c' to /proc/sysrq-trigger
+	    will be rejected.
+
+	  This is useful for production or hardened systems where generating
+	  a kernel crash dump for post-mortem analysis is essential, but
+	  the other SysRq commands (which can cause denial-of-service or
+	  hide intrusion) are considered an unacceptable security risk.
+
+	  If you need the full suite of SysRq commands for debugging, say N.
+
 config MAGIC_SYSRQ_SERIAL
 	bool "Enable magic SysRq key over serial"
 	depends on MAGIC_SYSRQ
-- 
2.33.0.windows.2

