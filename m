Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B51953A3;
	Thu,  6 Jun 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674155; cv=none; b=JPTQxdbzbnAJvLeNERsqNz2VpcGbbRwhU3M6zMzlEr6HuuxzsIND3v29RM1bVQ0F+tCvRDgkIB1Dt0QZ9E/mkohCkufkc0Is4qEoAzxwF9Uom7rGeYvr7wpXbhrvq+YJA3zF8DJMuezsqkzf+bd6TbqekuuRkUQBZSImMQ6DBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674155; c=relaxed/simple;
	bh=RAGJkpD68Hqusq6qO4OhmRMmWyl3gF2xM/kl6DZbdQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJ/GkluTIP1ev6TGBx4IUU4ZMzTOg6ik9wu+xlV3pIV1HLrlw0gH9pEBAF3m6NXUW4A55qv4YDO3hxY5grfA5OSBtrG6A9/a3wbIQ1VdP9RiUCgRwWdF6M7TYpliTJOHVKaZ8zGuR3kKvAnf46bppw20NMbcD7wzMzywJ+TIBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMfN4Mj5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMfN4Mj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717674154; x=1749210154;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RAGJkpD68Hqusq6qO4OhmRMmWyl3gF2xM/kl6DZbdQE=;
  b=nMfN4Mj5lkpyVCaap0VgraNj/KVwUNDLbNEJ+IxEjTrKo9ZjX/6GkQ4U
   Ylmm5F/gRZ05XH9010Nsn7yOiWVJHid0Rc+eP+MPSpDtbXMSmDn83Qp7o
   q9re8S6/lMuw0lB3hch28N5idqMF8AClcojvx2P2sq94/5p51YKiNFb5T
   8tKFnPLsLppD0R3VXa1iv24TDW891Z2yJMKK451VNCu2J+fGomDWB/Ah2
   Kqw3tUD68YsrjDPaKoTcW+8PWb7QI1ECVievjLNLjaSpK9yWmmPh2tFIW
   x4fx4LlYhkYrkKpxVB9xso9LHNCFwquvfMCu1yJEA2J02u5DRMn0cw6oM
   Q==;
X-CSE-ConnectionGUID: vdE5y/k0SzGQDNzSTEWmUg==
X-CSE-MsgGUID: l1bm8Z16Rm6pYWHmBIuvCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14517445"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14517445"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 04:42:33 -0700
X-CSE-ConnectionGUID: 0n3L5t4YRTa/+zCnGy+seQ==
X-CSE-MsgGUID: f+l+sHIVQ7aDRjtPdZq6GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42514901"
Received: from unknown (HELO tlindgre-MOBL1.intel.com) ([10.245.247.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 04:42:29 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] printk: Track command line console positions to fix console order
Date: Thu,  6 Jun 2024 14:41:46 +0300
Message-ID: <20240606114149.118633-1-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent changes to allow using DEVNAME:0.0 style console names caused a
regression to the kernel command line handling for the console options.

The last preferred console added gets used for init. This is documented
in the comments for add_preferred_console(). Now the kernel command line
options for console=ttyS0,115200 console=tty0 are wrongly handled and
cause the /dev/console to be associated with ttyS0 instead of tty0.

This happens because we are calling __add_preferred_console() later on
from serial8250_isa_init_ports() after console_setup() and the console
gets treated as the last added preferred console. As the DEVNAME:0.0 style
console device is not known at console_setup() time, and we need to call
__add_preferred_console() later.

Let's fix the issue by reserving a position in console_cmdline for a
deferred console, and then populate the reserved entry before calling
__add_preferred_console().

Note that we now need to check for valid preferred console too in
__add_preferred_console().

Reported-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/linux-serial/ZlC6_Um4P4b-_WQE@pathway.suse.cz/
Fixes: f03e8c1060f8 ("printk: Save console options for add_preferred_console_match()")
Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 kernel/printk/conopt.c          |  2 +-
 kernel/printk/console_cmdline.h |  6 ++-
 kernel/printk/printk.c          | 68 ++++++++++++++++++++++++++++++---
 3 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/conopt.c b/kernel/printk/conopt.c
index 9d507bac3657..08dded8fbb3b 100644
--- a/kernel/printk/conopt.c
+++ b/kernel/printk/conopt.c
@@ -140,7 +140,7 @@ int add_preferred_console_match(const char *match, const char *name,
 	if (con->has_brl_opt)
 		brl_opt = con->brl_opt;
 
-	console_opt_add_preferred_console(name, idx, con->opt, brl_opt);
+	console_opt_add_preferred_console(match, name, idx, con->opt, brl_opt);
 
 	return 0;
 }
diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
index a125e0235589..e22021e3e28b 100644
--- a/kernel/printk/console_cmdline.h
+++ b/kernel/printk/console_cmdline.h
@@ -5,13 +5,15 @@
 #define MAX_CMDLINECONSOLES 8
 
 int console_opt_save(const char *str, const char *brl_opt);
-int console_opt_add_preferred_console(const char *name, const short idx,
-				      char *options, char *brl_options);
+int console_opt_add_preferred_console(const char *devname, const char *name,
+				      const short idx, char *options,
+				      char *brl_options);
 
 struct console_cmdline
 {
 	char	name[16];			/* Name of the driver	    */
 	int	index;				/* Minor dev. to use	    */
+	char	devname[32];			/* DEVNAME:0.0 style device name */
 	bool	user_specified;			/* Specified by command line vs. platform */
 	char	*options;			/* Options for the driver   */
 #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 420fd310129d..52bdd7dcdb6f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2426,6 +2426,24 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
 	console_set_on_cmdline = 1;
 }
 
+/* Checks if a console is the last user specified preferred console */
+static bool is_last_user_prefcon(int position)
+{
+	struct console_cmdline *c = console_cmdline;
+	int last_user_specified = -1;
+	int i;
+
+	for (i = 0; i < MAX_CMDLINECONSOLES; i++, c++) {
+		if (!c->name[0] && !c->devname[0])
+			break;
+
+		if (c->user_specified || c->devname[0])
+			last_user_specified = i;
+	}
+
+	return position == last_user_specified;
+}
+
 static int __add_preferred_console(const char *name, const short idx, char *options,
 				   char *brl_options, bool user_specified)
 {
@@ -2445,10 +2463,10 @@ static int __add_preferred_console(const char *name, const short idx, char *opti
 	 *	if we have a slot free.
 	 */
 	for (i = 0, c = console_cmdline;
-	     i < MAX_CMDLINECONSOLES && c->name[0];
+	     i < MAX_CMDLINECONSOLES && (c->name[0] || c->devname[0]);
 	     i++, c++) {
 		if (strcmp(c->name, name) == 0 && c->index == idx) {
-			if (!brl_options)
+			if (!brl_options && (!user_specified || is_last_user_prefcon(i)))
 				preferred_console = i;
 			set_user_specified(c, user_specified);
 			return 0;
@@ -2467,6 +2485,25 @@ static int __add_preferred_console(const char *name, const short idx, char *opti
 	return 0;
 }
 
+/* Reserves a console_cmdline position for a deferred devname console */
+static void reserve_deferred_console(const char *str)
+{
+	struct console_cmdline *c = console_cmdline;
+	size_t namelen;
+	int i;
+
+	namelen = strcspn(str, ",");
+	if (namelen == 0 || namelen >= sizeof(c->devname))
+		return;
+
+	for (i = 0; i < MAX_CMDLINECONSOLES; i++, c++) {
+		if (c->name[0] || c->devname[0])
+			continue;
+		strscpy(c->devname, str, namelen + 1);
+		return;
+	}
+}
+
 static int __init console_msg_format_setup(char *str)
 {
 	if (!strcmp(str, "syslog"))
@@ -2508,8 +2545,10 @@ static int __init console_setup(char *str)
 	console_set_on_cmdline = 1;
 
 	/* Don't attempt to parse a DEVNAME:0.0 style console */
-	if (strchr(str, ':'))
+	if (strchr(str, ':')) {
+		reserve_deferred_console(str);
 		return 1;
+	}
 
 	/*
 	 * Decode str into name, index, options.
@@ -2542,9 +2581,26 @@ static int __init console_setup(char *str)
 __setup("console=", console_setup);
 
 /* Only called from add_preferred_console_match() */
-int console_opt_add_preferred_console(const char *name, const short idx,
-				      char *options, char *brl_options)
+int console_opt_add_preferred_console(const char *devname, const char *name,
+				      const short idx, char *options,
+				      char *brl_options)
 {
+	struct console_cmdline *c = console_cmdline;
+	int i;
+
+	/* Populate a reserved console based on devname */
+	for (i = 0; i < MAX_CMDLINECONSOLES; i++, c++) {
+		if (!c->name[0] && !strcmp(c->devname, devname)) {
+			strscpy(c->name, name);
+			c->index = idx;
+			c->options = options;
+#ifdef CONFIG_A11Y_BRAILLE_CONSOLE
+			c->brl_options = brl_options;
+#endif
+			break;
+		}
+	}
+
 	return __add_preferred_console(name, idx, options, brl_options, true);
 }
 
@@ -3333,7 +3389,7 @@ static int try_enable_preferred_console(struct console *newcon,
 	int i, err;
 
 	for (i = 0, c = console_cmdline;
-	     i < MAX_CMDLINECONSOLES && c->name[0];
+	     i < MAX_CMDLINECONSOLES && (c->name[0] || c->devname[0]);
 	     i++, c++) {
 		if (c->user_specified != user_specified)
 			continue;
-- 
2.45.2

