Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B471C2AD;
	Tue, 18 Jun 2024 04:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718686526; cv=none; b=VPEo9nFSmP/CC7BweHYGTBa0a2WsqbeBXtaULtRX7L/tJdwH9sDMTH6IbxLZEooXQIoasYqEbUYsiks+oaZyOFZ+DPVjVBeV2tbKIk1yhVjZn+RG9uYfX9EtJzs91RgI46FaFhF2amIM1zSsIKz5RaOpSVQkL7PLYfZbZqlY440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718686526; c=relaxed/simple;
	bh=ykmFHjLmQcgg09LU3W6SLx0qpasqzoUvmrp1nqXPat0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etTlItVCrMJPs1G6olwGnE56/EcpOFhA5bYBKLUQfRKT6qso0AeuLFVQHmW7tRHQgozQ+qXMXsNXB/X+0XiWUtsnNfTtNsEK5SZLdUHFWW4R6NEgCg8DVIYBHmFCBVPWZFXcugZr+pcUmpJe+edP+yDwEREAbgLurRg7BQ2rd/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdhhHxKL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdhhHxKL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718686525; x=1750222525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ykmFHjLmQcgg09LU3W6SLx0qpasqzoUvmrp1nqXPat0=;
  b=YdhhHxKLuyAF7RYYOHquYKNF+Mt5NCNvg9n8ujXUXy4IndrePqJykIn4
   hPAkw3zLmuq4fcylUfS6Od7fnXmW/5xSpgMPhTyoeFAWH8ny/tGfI6bRV
   AcxGtYHrBnmIMwBL/+ju62B3RICppmTNaftEcYogWUQwJKSGUb3uLtsCu
   l8cV6TXdu54yOzfw7H7KWSbzl0z/CTLJMB/TWDkVOooLrAQSvWGRKdx4S
   PWsVw09h/kLJLlH51uV4xwBxHotThdZ52nJbCYAdad8wuRmDJxoPKa6vY
   vNPbvELCI0NCyNSdjxqao7tP67/tnk9ZP6J17zg3YupgHmMEG6y3e2S+g
   A==;
X-CSE-ConnectionGUID: 9qPAqmuNQWSNtOenlWda8w==
X-CSE-MsgGUID: /PNr0kB7SgmHR3egC/VASg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="38062781"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="38062781"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 21:55:24 -0700
X-CSE-ConnectionGUID: sWPUTTZBTRCev3Sed8h1iw==
X-CSE-MsgGUID: RkTuYlIjR2WuU4oljXmmbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41507398"
Received: from unknown (HELO tlindgre-MOBL1.intel.com) ([10.245.247.4])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 21:55:19 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] printk: Revert add_preferred_console_match() related commits
Date: Tue, 18 Jun 2024 07:54:48 +0300
Message-ID: <20240618045458.14731-2-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
References: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
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
console device is not known at console_setup() time, I added a call to
__add_preferred_console() later on when the console is ready.

To fix the issue, let's revert the printk related commits:

f03e8c1060f8 ("printk: Save console options for add_preferred_console_match()")
b73c9cbe4f1f ("printk: Flag register_console() if console is set on command line")
8a831c584e6e ("printk: Don't try to parse DEVNAME:0.0 console options")

We need to also drop the call for add_preferred_console_match() from
serial_base_add_one_prefcon() added by commit 787a1cabac01 ("serial: core:
Add support for DEVNAME:0.0 style naming for kernel console").

Petr has suggested a better way to handle the deferred consoles that does
not rely on calling __add_preferred_console() again.

Reported-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/linux-serial/ZlC6_Um4P4b-_WQE@pathway.suse.cz/
Fixes: f03e8c1060f8 ("printk: Save console options for add_preferred_console_match()")
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 drivers/tty/serial/serial_base_bus.c |   8 +-
 include/linux/printk.h               |   3 -
 kernel/printk/Makefile               |   2 +-
 kernel/printk/conopt.c               | 146 ---------------------------
 kernel/printk/console_cmdline.h      |   6 --
 kernel/printk/printk.c               |  23 +----
 6 files changed, 6 insertions(+), 182 deletions(-)
 delete mode 100644 kernel/printk/conopt.c

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 73c6ee540c83..5ebacb982f9e 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -210,13 +210,7 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
 				       int port_id)
 {
-	int ret;
-
-	ret = add_preferred_console_match(match, dev_name, port_id);
-	if (ret == -ENOENT)
-		return 0;
-
-	return ret;
+	return 0;
 }
 
 #ifdef __sparc__
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 40afab23881a..65c5184470f1 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -60,9 +60,6 @@ static inline const char *printk_skip_headers(const char *buffer)
 #define CONSOLE_LOGLEVEL_DEFAULT CONFIG_CONSOLE_LOGLEVEL_DEFAULT
 #define CONSOLE_LOGLEVEL_QUIET	 CONFIG_CONSOLE_LOGLEVEL_QUIET
 
-int add_preferred_console_match(const char *match, const char *name,
-				const short idx);
-
 extern int console_printk[];
 
 #define console_loglevel (console_printk[0])
diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index 040fe7d1eda2..39a2b61c7232 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y	= printk.o conopt.o
+obj-y	= printk.o
 obj-$(CONFIG_PRINTK)	+= printk_safe.o nbcon.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
 obj-$(CONFIG_PRINTK_INDEX)	+= index.o
diff --git a/kernel/printk/conopt.c b/kernel/printk/conopt.c
deleted file mode 100644
index 9d507bac3657..000000000000
--- a/kernel/printk/conopt.c
+++ /dev/null
@@ -1,146 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Kernel command line console options for hardware based addressing
- *
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
- * Author: Tony Lindgren <tony@atomide.com>
- */
-
-#include <linux/console.h>
-#include <linux/init.h>
-#include <linux/string.h>
-#include <linux/types.h>
-
-#include <asm/errno.h>
-
-#include "console_cmdline.h"
-
-/*
- * Allow longer DEVNAME:0.0 style console naming such as abcd0000.serial:0.0
- * in addition to the legacy ttyS0 style naming.
- */
-#define CONSOLE_NAME_MAX	32
-
-#define CONSOLE_OPT_MAX		16
-#define CONSOLE_BRL_OPT_MAX	16
-
-struct console_option {
-	char name[CONSOLE_NAME_MAX];
-	char opt[CONSOLE_OPT_MAX];
-	char brl_opt[CONSOLE_BRL_OPT_MAX];
-	u8 has_brl_opt:1;
-};
-
-/* Updated only at console_setup() time, no locking needed */
-static struct console_option conopt[MAX_CMDLINECONSOLES];
-
-/**
- * console_opt_save - Saves kernel command line console option for driver use
- * @str: Kernel command line console name and option
- * @brl_opt: Braille console options
- *
- * Saves a kernel command line console option for driver subsystems to use for
- * adding a preferred console during init. Called from console_setup() only.
- *
- * Return: 0 on success, negative error code on failure.
- */
-int __init console_opt_save(const char *str, const char *brl_opt)
-{
-	struct console_option *con;
-	size_t namelen, optlen;
-	const char *opt;
-	int i;
-
-	namelen = strcspn(str, ",");
-	if (namelen == 0 || namelen >= CONSOLE_NAME_MAX)
-		return -EINVAL;
-
-	opt = str + namelen;
-	if (*opt == ',')
-		opt++;
-
-	optlen = strlen(opt);
-	if (optlen >= CONSOLE_OPT_MAX)
-		return -EINVAL;
-
-	for (i = 0; i < MAX_CMDLINECONSOLES; i++) {
-		con = &conopt[i];
-
-		if (con->name[0]) {
-			if (!strncmp(str, con->name, namelen))
-				return 0;
-			continue;
-		}
-
-		/*
-		 * The name isn't terminated, only opt is. Empty opt is fine,
-		 * but brl_opt can be either empty or NULL. For more info, see
-		 * _braille_console_setup().
-		 */
-		strscpy(con->name, str, namelen + 1);
-		strscpy(con->opt, opt, CONSOLE_OPT_MAX);
-		if (brl_opt) {
-			strscpy(con->brl_opt, brl_opt, CONSOLE_BRL_OPT_MAX);
-			con->has_brl_opt = 1;
-		}
-
-		return 0;
-	}
-
-	return -ENOMEM;
-}
-
-static struct console_option *console_opt_find(const char *name)
-{
-	struct console_option *con;
-	int i;
-
-	for (i = 0; i < MAX_CMDLINECONSOLES; i++) {
-		con = &conopt[i];
-		if (!strcmp(name, con->name))
-			return con;
-	}
-
-	return NULL;
-}
-
-/**
- * add_preferred_console_match - Adds a preferred console if a match is found
- * @match: Expected console on kernel command line, such as console=DEVNAME:0.0
- * @name: Name of the console character device to add such as ttyS
- * @idx: Index for the console
- *
- * Allows driver subsystems to add a console after translating the command
- * line name to the character device name used for the console. Options are
- * added automatically based on the kernel command line. Duplicate preferred
- * consoles are ignored by __add_preferred_console().
- *
- * Return: 0 on success, negative error code on failure.
- */
-int add_preferred_console_match(const char *match, const char *name,
-				const short idx)
-{
-	struct console_option *con;
-	char *brl_opt = NULL;
-
-	if (!match || !strlen(match) || !name || !strlen(name) ||
-	    idx < 0)
-		return -EINVAL;
-
-	con = console_opt_find(match);
-	if (!con)
-		return -ENOENT;
-
-	/*
-	 * See __add_preferred_console(). It checks for NULL brl_options to set
-	 * the preferred_console flag. Empty brl_opt instead of NULL leads into
-	 * the preferred_console flag not set, and CON_CONSDEV not being set,
-	 * and the boot console won't get disabled at the end of console_setup().
-	 */
-	if (con->has_brl_opt)
-		brl_opt = con->brl_opt;
-
-	console_opt_add_preferred_console(name, idx, con->opt, brl_opt);
-
-	return 0;
-}
diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
index a125e0235589..3ca74ad391d6 100644
--- a/kernel/printk/console_cmdline.h
+++ b/kernel/printk/console_cmdline.h
@@ -2,12 +2,6 @@
 #ifndef _CONSOLE_CMDLINE_H
 #define _CONSOLE_CMDLINE_H
 
-#define MAX_CMDLINECONSOLES 8
-
-int console_opt_save(const char *str, const char *brl_opt);
-int console_opt_add_preferred_console(const char *name, const short idx,
-				      char *options, char *brl_options);
-
 struct console_cmdline
 {
 	char	name[16];			/* Name of the driver	    */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 420fd310129d..dddb15f48d59 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -383,6 +383,9 @@ static int console_locked;
 /*
  *	Array of consoles built from command line options (console=)
  */
+
+#define MAX_CMDLINECONSOLES 8
+
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
 static int preferred_console = -1;
@@ -2500,17 +2503,6 @@ static int __init console_setup(char *str)
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
-	/* Save the console for driver subsystem use */
-	if (console_opt_save(str, brl_options))
-		return 1;
-
-	/* Flag register_console() to not call try_enable_default_console() */
-	console_set_on_cmdline = 1;
-
-	/* Don't attempt to parse a DEVNAME:0.0 style console */
-	if (strchr(str, ':'))
-		return 1;
-
 	/*
 	 * Decode str into name, index, options.
 	 */
@@ -2541,13 +2533,6 @@ static int __init console_setup(char *str)
 }
 __setup("console=", console_setup);
 
-/* Only called from add_preferred_console_match() */
-int console_opt_add_preferred_console(const char *name, const short idx,
-				      char *options, char *brl_options)
-{
-	return __add_preferred_console(name, idx, options, brl_options, true);
-}
-
 /**
  * add_preferred_console - add a device to the list of preferred consoles.
  * @name: device name
@@ -3522,7 +3507,7 @@ void register_console(struct console *newcon)
 	 * Note that a console with tty binding will have CON_CONSDEV
 	 * flag set and will be first in the list.
 	 */
-	if (preferred_console < 0 && !console_set_on_cmdline) {
+	if (preferred_console < 0) {
 		if (hlist_empty(&console_list) || !console_first()->device ||
 		    console_first()->flags & CON_BOOT) {
 			try_enable_default_console(newcon);
-- 
2.45.2

