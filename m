From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v3 3/3] printk: fix double printing with earlycon
Date: Fri,  3 Mar 2017 18:49:41 +0300
Message-ID: <20170303154946.15399-1-aleksey.makarov@linaro.org>
References: <20170302131153.22733-4-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302131153.22733-4-aleksey.makarov@linaro.org>
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

To fix that, match the console against the `console_cmdline` entry
pointed by `preferred_console` and if that fails, match against other
entries.  The problem is that newcon->match() is not just a match
function, it calls setup() so it has side effects.

Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---

v2 -> v3:

v2 still changes the logic of the code and calls newcon->match()
several times.  V3 fixes that.  It initially matches  the console
against the preferred_console entry, and then if that fails, against
other entries.

 kernel/printk/printk.c | 82 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 23 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ed2a9b31f214..99bea4ae8f4a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2380,6 +2380,32 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static enum { CONSOLE_MATCH, CONSOLE_MATCH_RETURN, CONSOLE_MATCH_NEXT }
+match_console(struct console *newcon, struct console_cmdline *c)
+{
+	if (!newcon->match ||
+	    newcon->match(newcon, c->name, c->index, c->options) != 0) {
+		/* default matching */
+		BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
+		if (strcmp(c->name, newcon->name) != 0)
+			return CONSOLE_MATCH_NEXT;
+		if (newcon->index >= 0 && newcon->index != c->index)
+			return CONSOLE_MATCH_NEXT;
+		if (newcon->index < 0)
+			newcon->index = c->index;
+
+		if (_braille_register_console(newcon, c))
+			return CONSOLE_MATCH_RETURN;
+
+		if (newcon->setup &&
+		    newcon->setup(newcon, c->options) != 0)
+			return CONSOLE_MATCH;
+	}
+
+	newcon->flags |= CON_ENABLED;
+	return CONSOLE_MATCH;
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2454,40 +2480,50 @@ void register_console(struct console *newcon)
 	}
 
 	/*
+	 * Check if this console was set as preferred by command line parameters
+	 * or by call to add_preferred_console().  There may be several entries
+	 * in the console_cmdline array matching with the same console so we
+	 * can not just use the first match.  Instead check the entry pointed
+	 * by preferred_console and then all other entries.
+	 */
+	if (preferred_console >= 0) {
+		switch (match_console(newcon,
+				      console_cmdline + preferred_console)) {
+		case CONSOLE_MATCH:
+			if (newcon->flags | CON_ENABLED) {
+				newcon->flags |= CON_CONSDEV;
+				has_preferred = true;
+			}
+			goto match;
+		case CONSOLE_MATCH_RETURN:
+			return;
+		default:
+			break;
+		}
+	}
+
+	/*
 	 *	See if this console matches one we selected on
 	 *	the command line.
 	 */
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
-
-			if (_braille_register_console(newcon, c))
-				return;
 
-			if (newcon->setup &&
-			    newcon->setup(newcon, c->options) != 0)
-				break;
-		}
+		if (preferred_console == i)
+			continue;
 
-		newcon->flags |= CON_ENABLED;
-		if (i == preferred_console) {
-			newcon->flags |= CON_CONSDEV;
-			has_preferred = true;
+		switch (match_console(newcon, c)) {
+		case CONSOLE_MATCH:
+			goto match;
+		case CONSOLE_MATCH_RETURN:
+			return;
+		default:
+			break;
 		}
-		break;
 	}
 
+match:
 	if (!(newcon->flags & CON_ENABLED))
 		return;
 
-- 
2.11.1
