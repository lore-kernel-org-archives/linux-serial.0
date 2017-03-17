From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v6 3/3] printk: fix double printing with earlycon
Date: Fri, 17 Mar 2017 14:43:44 +0300
Message-ID: <20170317114348.30215-1-aleksey.makarov@linaro.org>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170315102854.1763-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>
List-Id: linux-serial@vger.kernel.org

If a console was specified by ACPI SPCR table _and_ command line
parameters like "console=ttyAMA0" _and_ "earlycon" were specified,
then log messages appear twice.

The root cause is that the code traverses the list of specified
consoles (the `console_cmdline` array) and stops at the first match.
But it may happen that the same console is referred by the elements
of this array twice:

	pl011,mmio,0x87e024000000,115200 -- from SPCR
	ttyAMA0 -- from command line

but in this case `preferred_console` points to the second entry and
the flag CON_CONSDEV is not set, so bootconsole is not deregistered.

To fix that, split the loop where we search for matching entry of
console_cmdline into three parts that do not intersect:
1) search for braille console
2) check for preferred_console
3) match other entries so that these three parts do not

To to that introduce predicate _braille_is_braille_console() that checks if
its argument is an entry describing a braille console.

Also introduce a macro for_each_console_cmdline() to traverse
the console_cmdline array.

Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---

v5 -> v6:
- drop v5 and continue to work on v4:
- introduce _braille_is_braille_console(). It helps to split original loop
  into three parts: 1) search for braille console, 2) check for
  preferred_console, 3) match other entries so that these three parts do not
  intersect.
- introduce for_each_console_cmdline() macros to traverse console_cmdline
  (Petr Mladek)

 kernel/printk/braille.h |  12 ++++++
 kernel/printk/printk.c  | 104 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 86 insertions(+), 30 deletions(-)

diff --git a/kernel/printk/braille.h b/kernel/printk/braille.h
index 769d771145c8..183aebf6e1dc 100644
--- a/kernel/printk/braille.h
+++ b/kernel/printk/braille.h
@@ -18,6 +18,12 @@ _braille_register_console(struct console *console, struct console_cmdline *c);
 int
 _braille_unregister_console(struct console *console);
 
+static inline int
+_braille_is_braille_console(struct console_cmdline *c)
+{
+	return !!c->brl_options;
+}
+
 #else
 
 static inline void
@@ -43,6 +49,12 @@ _braille_unregister_console(struct console *console)
 	return 0;
 }
 
+static inline int
+_braille_is_braille_console(struct console_cmdline *c)
+{
+	return 0;
+}
+
 #endif
 
 #endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd752f0c8ef1..ab2433681ca5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -270,6 +270,11 @@ static struct console *exclusive_console;
 
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
+#define for_each_console_cmdline(i, c)			\
+	for (i = 0, c = console_cmdline;		\
+	     i < MAX_CMDLINECONSOLES && c->name[0];	\
+	     i++, c++)
+
 static int preferred_console = -1;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
@@ -1905,9 +1910,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	 *	See if this tty is not yet registered, and
 	 *	if we have a slot free.
 	 */
-	for (i = 0, c = console_cmdline;
-	     i < MAX_CMDLINECONSOLES && c->name[0];
-	     i++, c++) {
+	for_each_console_cmdline(i, c) {
 		if (strcmp(c->name, name) == 0 && c->index == idx) {
 			if (!brl_options)
 				preferred_console = i;
@@ -2383,6 +2386,37 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static bool match_console_name(struct console *newcon,
+			       struct console_cmdline *c)
+{
+	BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
+	if (strcmp(c->name, newcon->name) != 0)
+		return false;
+	if (newcon->index >= 0 && newcon->index != c->index)
+		return false;
+	if (newcon->index < 0)
+		newcon->index = c->index;
+	return true;
+}
+
+static bool match_console(struct console *newcon, struct console_cmdline *c)
+{
+	if (newcon->match &&
+	    newcon->match(newcon, c->name, c->index, c->options) == 0) {
+		newcon->flags |= CON_ENABLED;
+		return true;
+	}
+
+	if (match_console_name(newcon, c)) {
+		if (!newcon->setup || newcon->setup(newcon, c->options) == 0)
+			newcon->flags |= CON_ENABLED;
+
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2457,40 +2491,50 @@ void register_console(struct console *newcon)
 	}
 
 	/*
-	 *	See if this console matches one we selected on
-	 *	the command line.
+	 * See if this console matches one we selected on the command line.
+	 * Do it in three steps:
+	 *
+	 * 1) check if it is a braille console..
 	 */
-	for (i = 0, c = console_cmdline;
-	     i < MAX_CMDLINECONSOLES && c->name[0];
-	     i++, c++) {
-		if (!newcon->match ||
-		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
-			/* default matching */
-			BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
-			if (strcmp(c->name, newcon->name) != 0)
-				continue;
-			if (newcon->index >= 0 &&
-			    newcon->index != c->index)
-				continue;
-			if (newcon->index < 0)
-				newcon->index = c->index;
-
-			if (_braille_register_console(newcon, c))
-				return;
-
-			if (newcon->setup &&
-			    newcon->setup(newcon, c->options) != 0)
-				break;
-		}
+	for_each_console_cmdline(i, c)
+		if (_braille_is_braille_console(c) &&
+		    match_console_name(newcon, c) &&
+		    _braille_register_console(newcon, c))
+			return;
 
-		newcon->flags |= CON_ENABLED;
-		if (i == preferred_console) {
+	/*
+	 * 2) check if this console was set as preferred by command line
+	 * parameters or by call to add_preferred_console().  There may be
+	 * several entries in the console_cmdline array matching with the same
+	 * console, one with newcon->match(), another by name/index:
+	 *
+	 *	pl011,mmio,0x87e024000000,115200 -- added from SPCR
+	 *	ttyAMA0 -- added from command line
+	 *
+	 * so we can not use the first match.  Instead check the
+	 * entry pointed by preferred_console and then all other entries.
+	 */
+	if (preferred_console >= 0 &&
+	    match_console(newcon, console_cmdline + preferred_console)) {
+		if (newcon->flags & CON_ENABLED) {
 			newcon->flags |= CON_CONSDEV;
 			has_preferred = true;
 		}
-		break;
+		goto match;
+	}
+
+	/*
+	 * 3) check other entries
+	 */
+	for_each_console_cmdline(i, c) {
+		if (preferred_console == i || _braille_is_braille_console(c))
+			continue;
+
+		if (match_console(newcon, c))
+			goto match;
 	}
 
+match:
 	if (!(newcon->flags & CON_ENABLED))
 		return;
 
-- 
2.12.0
