Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B813E3F9;
	Thu, 13 Jun 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283134; cv=none; b=pj8afGp/dXlXuNhkMBu91Xt/mVNXQLxUSSSD/RVr/Ys4J32NPlK7XhKWTmEzr3ZZtHE/AbNA1qS/Yu10FVDY4zmyKUTMxFxLXkGfKZEpnBrs/hLH40/EmCKQdKPF5xPALhHvdVcejy40LcnN2oMJOdaTAEilw/DMphHQrSdIDko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283134; c=relaxed/simple;
	bh=Gitiy4jTy+Ji4p/AD8BHLreS0EPk0aagGgIQISBE594=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGeR0MwqjRxH6OdIvYJOzMlnNetjz7teeDjwLcE4rYUrt/0d3+Dq1yZGRklItDRpKFoTJicK/U96CZLZ+pRqN6b2kT16+6vIiaz4r2Hk0iBQ/bZJSRIkAu6lKNutJBAQF1IcxD00HEmIS8vH5j2YdmQF87t6GxlW4Zp9eq6fMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewoiRZSN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewoiRZSN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718283132; x=1749819132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gitiy4jTy+Ji4p/AD8BHLreS0EPk0aagGgIQISBE594=;
  b=ewoiRZSNB9Vc1pigc5/hBINodlJd2FAygqv1xtN17AG4M7PfGAVuZryL
   jz7drTOobSBVc7IgAA0c2+Fms8jWmP4MeBQj58Y6RVh7L0c2HLmC3Lljx
   Gs36424nwaqG2e5kG9OZshngwkkhjdpSm78Sstfe4Lyv96sLu3/SeBus6
   6lSrYg0hpwEthwz8GdAsk9Q3WnJ7oB4/7vwTet7wu6cMhvG7dyVvhYfTZ
   vacKp0bqTcPndaaQKrbuaBDcxdEXsw+A9iayV+Y8VgGT/G9E3T8BdZG0h
   ZgwmlbbD7BwFi2fayeFfRArpC3vX87hin2G4nUpHo/o9D3qPc7va8F0sr
   w==;
X-CSE-ConnectionGUID: Z16YeGlaT4CV/Mp0CzPJRg==
X-CSE-MsgGUID: 32f+YVxlT6uQoNUDUwPYDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18025257"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="18025257"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 05:52:11 -0700
X-CSE-ConnectionGUID: AeOb1njeSemVEI9wbQkMfw==
X-CSE-MsgGUID: Hr+lrdwjTlumCh448BDEbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="44574648"
Received: from unknown (HELO tlindgre-MOBL1.intel.com) ([10.245.247.210])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 05:52:07 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] printk: Add update_preferred_console()
Date: Thu, 13 Jun 2024 15:51:08 +0300
Message-ID: <20240613125113.219700-3-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613125113.219700-1-tony.lindgren@linux.intel.com>
References: <20240613125113.219700-1-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's add update_preferred_console() for driver subsystems to call during
init when the console is ready, and it's character device name is known.
For now, we use it only for the serial layer to allow console=DEVNAME:0.0
style hardware based addressing for consoles.

The earlier attempt on doing this caused a regression with the kernel
command line console order as it added calling __add_preferred_console()
again later on during init. A better approach was suggested by Petr where
we add the deferred console to the console_cmdline[] and update it later
on when the console is ready.

Suggested-by: Petr Mladek <pmladek@suse.com>
Co-developed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 drivers/tty/serial/serial_base_bus.c |  8 ++-
 include/linux/printk.h               |  2 +
 kernel/printk/console_cmdline.h      |  1 +
 kernel/printk/printk.c               | 77 +++++++++++++++++++++++-----
 4 files changed, 73 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 5ebacb982f9e..a34f55ef6f37 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -210,7 +210,13 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
 				       int port_id)
 {
-	return 0;
+	int ret;
+
+	ret = update_preferred_console(match, dev_name, port_id);
+	if (ret == -ENOENT)
+		return 0;
+
+	return ret;
 }
 
 #ifdef __sparc__
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 65c5184470f1..fda935280e33 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -60,6 +60,8 @@ static inline const char *printk_skip_headers(const char *buffer)
 #define CONSOLE_LOGLEVEL_DEFAULT CONFIG_CONSOLE_LOGLEVEL_DEFAULT
 #define CONSOLE_LOGLEVEL_QUIET	 CONFIG_CONSOLE_LOGLEVEL_QUIET
 
+int update_preferred_console(const char *match, const char *name, const short idx);
+
 extern int console_printk[];
 
 #define console_loglevel (console_printk[0])
diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
index 3ca74ad391d6..0ab573b6d4dc 100644
--- a/kernel/printk/console_cmdline.h
+++ b/kernel/printk/console_cmdline.h
@@ -6,6 +6,7 @@ struct console_cmdline
 {
 	char	name[16];			/* Name of the driver	    */
 	int	index;				/* Minor dev. to use	    */
+	char	devname[32];			/* DEVNAME:0.0 style device name */
 	bool	user_specified;			/* Specified by command line vs. platform */
 	char	*options;			/* Options for the driver   */
 #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dddb15f48d59..0e2e442593bd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2429,18 +2429,23 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
 	console_set_on_cmdline = 1;
 }
 
-static int __add_preferred_console(const char *name, const short idx, char *options,
+static int __add_preferred_console(const char *name, const short idx,
+				   const char *devname, char *options,
 				   char *brl_options, bool user_specified)
 {
 	struct console_cmdline *c;
 	int i;
 
+	if (!name && !devname)
+		return -EINVAL;
+
 	/*
 	 * We use a signed short index for struct console for device drivers to
 	 * indicate a not yet assigned index or port. However, a negative index
-	 * value is not valid for preferred console.
+	 * value is not valid when the console name and index are defined on
+	 * the command line.
 	 */
-	if (idx < 0)
+	if (name && idx < 0)
 		return -EINVAL;
 
 	/*
@@ -2448,9 +2453,10 @@ static int __add_preferred_console(const char *name, const short idx, char *opti
 	 *	if we have a slot free.
 	 */
 	for (i = 0, c = console_cmdline;
-	     i < MAX_CMDLINECONSOLES && c->name[0];
+	     i < MAX_CMDLINECONSOLES && (c->name[0] || c->devname[0]);
 	     i++, c++) {
-		if (strcmp(c->name, name) == 0 && c->index == idx) {
+		if ((name && strcmp(c->name, name) == 0 && c->index == idx) ||
+		    (devname && strcmp(c->devname, devname) == 0)) {
 			if (!brl_options)
 				preferred_console = i;
 			set_user_specified(c, user_specified);
@@ -2461,7 +2467,10 @@ static int __add_preferred_console(const char *name, const short idx, char *opti
 		return -E2BIG;
 	if (!brl_options)
 		preferred_console = i;
-	strscpy(c->name, name, sizeof(c->name));
+	if (name)
+		strscpy(c->name, name);
+	if (devname)
+		strscpy(c->devname, devname);
 	c->options = options;
 	set_user_specified(c, user_specified);
 	braille_set_options(c, brl_options);
@@ -2486,8 +2495,8 @@ __setup("console_msg_format=", console_msg_format_setup);
  */
 static int __init console_setup(char *str)
 {
-	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
-	char *s, *options, *brl_options = NULL;
+	char buf[sizeof(console_cmdline[0].devname)]; /* name with "ttyS" prefix or devname */
+	char *s, *options, *brl_options = NULL, *chardev = NULL, *devname = NULL;
 	int idx;
 
 	/*
@@ -2496,17 +2505,23 @@ static int __init console_setup(char *str)
 	 * for exactly this purpose.
 	 */
 	if (str[0] == 0 || strcmp(str, "null") == 0) {
-		__add_preferred_console("ttynull", 0, NULL, NULL, true);
+		__add_preferred_console("ttynull", 0, NULL, NULL, NULL, true);
 		return 1;
 	}
 
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
+	/* For a DEVNAME:0.0 style console the character device is unknown early */
+	if (strchr(str, ':'))
+		devname = buf;
+	else
+		chardev = buf;
+
 	/*
 	 * Decode str into name, index, options.
 	 */
-	if (isdigit(str[0]))
+	if (chardev && isdigit(str[0]))
 		scnprintf(buf, sizeof(buf), "ttyS%s", str);
 	else
 		strscpy(buf, str);
@@ -2523,12 +2538,12 @@ static int __init console_setup(char *str)
 #endif
 
 	for (s = buf; *s; s++)
-		if (isdigit(*s) || *s == ',')
+		if ((chardev && isdigit(*s)) || *s == ',')
 			break;
 	idx = simple_strtoul(s, NULL, 10);
 	*s = 0;
 
-	__add_preferred_console(buf, idx, options, brl_options, true);
+	__add_preferred_console(chardev, idx, devname, options, brl_options, true);
 	return 1;
 }
 __setup("console=", console_setup);
@@ -2548,7 +2563,38 @@ __setup("console=", console_setup);
  */
 int add_preferred_console(const char *name, const short idx, char *options)
 {
-	return __add_preferred_console(name, idx, options, NULL, false);
+	return __add_preferred_console(name, idx, NULL, options, NULL, false);
+}
+
+/**
+ * update_preferred_console - Updates a preferred console if a match is found
+ * @devname: Expected console on kernel command line, such as console=DEVNAME:0.0
+ * @name: Name of the console character device to add such as ttyS
+ * @idx: Index for the console
+ *
+ * Allows driver subsystems to update a console after translating the command
+ * line name to the character device name used for the console.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int update_preferred_console(const char *devname, const char *name, const short idx)
+{
+	struct console_cmdline *c = console_cmdline;
+	int i;
+
+	if (!devname || !strlen(devname) || !name || !strlen(name) || idx < 0)
+		return -EINVAL;
+
+	for (i = 0; i < MAX_CMDLINECONSOLES && (c->name[0] || c->devname[0]);
+	     i++, c++) {
+		if (!strcmp(devname, c->devname)) {
+			strscpy(c->name, name);
+			c->index = idx;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
 }
 
 bool console_suspend_enabled = true;
@@ -3318,8 +3364,11 @@ static int try_enable_preferred_console(struct console *newcon,
 	int i, err;
 
 	for (i = 0, c = console_cmdline;
-	     i < MAX_CMDLINECONSOLES && c->name[0];
+	     i < MAX_CMDLINECONSOLES && (c->name[0] || c->devname[0]);
 	     i++, c++) {
+		/* Console not yet initialized? */
+		if (!c->name[0])
+			continue;
 		if (c->user_specified != user_specified)
 			continue;
 		if (!newcon->match ||
-- 
2.45.2

