From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v2 3/3] printk: fix double printing with earlycon
Date: Thu,  2 Mar 2017 16:11:34 +0300
Message-ID: <20170302131153.22733-4-aleksey.makarov@linaro.org>
References: <20170302131153.22733-1-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302131153.22733-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
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

To fix that, match the console against the `console_cmdline` entry
pointed by `preferred_console` instead of the first match.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 kernel/printk/printk.c | 49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ed2a9b31f214..ad35011f8374 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2380,6 +2380,24 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static int match_console(struct console *newcon, struct console_cmdline *c)
+{
+	if (!newcon->match ||
+	    newcon->match(newcon, c->name, c->index, c->options) != 0) {
+		/* default matching */
+		BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
+		if (strcmp(c->name, newcon->name) != 0)
+			return -ENODEV;
+		if (newcon->index >= 0 &&
+		    newcon->index != c->index)
+			return -ENODEV;
+		if (newcon->index < 0)
+			newcon->index = c->index;
+	}
+
+	return 0;
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2460,17 +2478,9 @@ void register_console(struct console *newcon)
 	for (i = 0, c = console_cmdline;
 	     i < MAX_CMDLINECONSOLES && c->name[0];
 	     i++, c++) {
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
+		if (match_console(newcon, c)) {
+			continue;
+		} else {
 
 			if (_braille_register_console(newcon, c))
 				return;
@@ -2481,10 +2491,6 @@ void register_console(struct console *newcon)
 		}
 
 		newcon->flags |= CON_ENABLED;
-		if (i == preferred_console) {
-			newcon->flags |= CON_CONSDEV;
-			has_preferred = true;
-		}
 		break;
 	}
 
@@ -2492,6 +2498,19 @@ void register_console(struct console *newcon)
 		return;
 
 	/*
+	 * Check if this console was set as preferred by command line parameters
+	 * or by call to add_preferred_console().
+	 * There may be several entries in the console_cmdline array referring
+	 * to the same console so we can not just use the first match.  Instead
+	 * check the entry pointed by preferred_console explicitly.
+	 */
+	if (preferred_console >= 0 &&
+	    match_console(newcon, console_cmdline + preferred_console) == 0) {
+		newcon->flags |= CON_CONSDEV;
+		has_preferred = true;
+	}
+
+	/*
 	 * If we have a bootconsole, and are switching to a real console,
 	 * don't print everything out again, since when the boot console, and
 	 * the real console are the same physical device, it's annoying to
-- 
2.11.1
