From: Calvin Owens <calvinowens@fb.com>
Subject: [PATCH 2/4] printk: Add ability to set loglevel via "console=" cmdline
Date: Fri, 1 Mar 2019 16:48:18 -0800
Message-ID: <e1311e98d6803f678cdcaa2be1cfb58d667fe3fd.1551486732.git.calvinowens@fb.com>
References: <cover.1551486732.git.calvinowens@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551486732.git.calvinowens@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Calvin Owens <calvinowens@fb.com>
List-Id: linux-serial@vger.kernel.org

This extends the "console=" interface to allow setting the per-console
loglevel by adding "/N" to the string, where N is the desired loglevel
expressed as a base 10 integer. Invalid values are silently ignored.

Signed-off-by: Calvin Owens <calvinowens@fb.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++--
 kernel/printk/console_cmdline.h               |  1 +
 kernel/printk/printk.c                        | 30 +++++++++++++++----
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 858b6c0b9a15..afada61dcbce 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -612,10 +612,10 @@
 		ttyS<n>[,options]
 		ttyUSB0[,options]
 			Use the specified serial port.  The options are of
-			the form "bbbbpnf", where "bbbb" is the baud rate,
+			the form "bbbbpnf/l", where "bbbb" is the baud rate,
 			"p" is parity ("n", "o", or "e"), "n" is number of
-			bits, and "f" is flow control ("r" for RTS or
-			omit it).  Default is "9600n8".
+			bits, "f" is flow control ("r" for RTS or omit it),
+			and "l" is the loglevel on [0,7]. Default is "9600n8".
 
 			See Documentation/admin-guide/serial-console.rst for more
 			information.  See
diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
index 11f19c466af5..fbf9b539366e 100644
--- a/kernel/printk/console_cmdline.h
+++ b/kernel/printk/console_cmdline.h
@@ -6,6 +6,7 @@ struct console_cmdline
 {
 	char	name[16];			/* Name of the driver	    */
 	int	index;				/* Minor dev. to use	    */
+	int	loglevel;			/* Loglevel to use */
 	char	*options;			/* Options for the driver   */
 #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
 	char	*brl_options;			/* Options for braille driver */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6ead14f8c2bc..2e0eb89f046c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2057,7 +2057,7 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
 #endif
 
 static int __add_preferred_console(char *name, int idx, char *options,
-				   char *brl_options)
+				   int loglevel, char *brl_options)
 {
 	struct console_cmdline *c;
 	int i;
@@ -2083,6 +2083,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	c->options = options;
 	braille_set_options(c, brl_options);
 
+	c->loglevel = loglevel;
 	c->index = idx;
 	return 0;
 }
@@ -2104,8 +2105,8 @@ __setup("console_msg_format=", console_msg_format_setup);
 static int __init console_setup(char *str)
 {
 	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
-	char *s, *options, *brl_options = NULL;
-	int idx;
+	char *s, *options, *llevel, *brl_options = NULL;
+	int idx, loglevel = LOGLEVEL_EMERG;
 
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
@@ -2123,6 +2124,14 @@ static int __init console_setup(char *str)
 	options = strchr(str, ',');
 	if (options)
 		*(options++) = 0;
+
+	llevel = strchr(str, '/');
+	if (llevel) {
+		*(llevel++) = 0;
+		if (kstrtoint(llevel, 10, &loglevel))
+			loglevel = LOGLEVEL_EMERG;
+	}
+
 #ifdef __sparc__
 	if (!strcmp(str, "ttya"))
 		strcpy(buf, "ttyS0");
@@ -2135,7 +2144,7 @@ static int __init console_setup(char *str)
 	idx = simple_strtoul(s, NULL, 10);
 	*s = 0;
 
-	__add_preferred_console(buf, idx, options, brl_options);
+	__add_preferred_console(buf, idx, options, loglevel, brl_options);
 	console_set_on_cmdline = 1;
 	return 1;
 }
@@ -2156,7 +2165,8 @@ __setup("console=", console_setup);
  */
 int add_preferred_console(char *name, int idx, char *options)
 {
-	return __add_preferred_console(name, idx, options, NULL);
+	return __add_preferred_console(name, idx, options, LOGLEVEL_EMERG,
+				       NULL);
 }
 
 bool console_suspend_enabled = true;
@@ -2574,6 +2584,7 @@ void register_console(struct console *newcon)
 	struct console *bcon = NULL;
 	struct console_cmdline *c;
 	static bool has_preferred;
+	bool cmdline_exists = false;
 
 	if (console_drivers)
 		for_each_console(bcon)
@@ -2640,6 +2651,12 @@ void register_console(struct console *newcon)
 			if (newcon->index < 0)
 				newcon->index = c->index;
 
+			/*
+			 * Carry over the loglevel from the cmdline
+			 */
+			newcon->level = c->loglevel;
+			cmdline_exists = true;
+
 			if (_braille_register_console(newcon, c))
 				return;
 
@@ -2671,7 +2688,8 @@ void register_console(struct console *newcon)
 	/*
 	 * By default, the per-console minimum forces no messages through.
 	 */
-	newcon->level = LOGLEVEL_EMERG;
+	if (!cmdline_exists)
+		newcon->level = LOGLEVEL_EMERG;
 
 	/*
 	 *	Put this console in the list - keep the
-- 
2.17.1
