From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v5 3/3] printk: fix double printing with earlycon
Date: Wed, 15 Mar 2017 13:28:52 +0300
Message-ID: <20170315102854.1763-4-aleksey.makarov@linaro.org>
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

To fix that, introduce an invariant "The last non-braille console
is always the preferred one" on the entries of the console_cmdline
array and don't try to check for double entries.  Then traverse it
in reverse order to be sure that if the console is preferred then
it will be the first matching entry.

Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 kernel/printk/printk.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd752f0c8ef1..7dc53b2831fb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1902,20 +1902,25 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	int i;
 
 	/*
-	 *	See if this tty is not yet registered, and
-	 *	if we have a slot free.
+	 * Don't check if the console has already been registered, because it is
+	 * pointless.  After all, we can not check if two entries refer to
+	 * the same console if one is matched with console->match(), and another
+	 * by name/index:
+	 *
+	 *	pl011,mmio,0x87e024000000,115200 -- added from SPCR
+	 *	ttyAMA0 -- added from command line
+	 *
+	 * Also this allows to maintain an invariant that will help to find if
+	 * the matching console is preferred, see register_console():
+	 *
+	 *	The last non-braille console is always the preferred one.
 	 */
-	for (i = 0, c = console_cmdline;
-	     i < MAX_CMDLINECONSOLES && c->name[0];
-	     i++, c++) {
-		if (strcmp(c->name, name) == 0 && c->index == idx) {
-			if (!brl_options)
-				preferred_console = i;
-			return 0;
-		}
-	}
+	for (i = 0; i < MAX_CMDLINECONSOLES; i++)
+		if (!console_cmdline[i].name[0])
+			break;
 	if (i == MAX_CMDLINECONSOLES)
 		return -E2BIG;
+	c = console_cmdline + i;
 	if (!brl_options)
 		preferred_console = i;
 	strlcpy(c->name, name, sizeof(c->name));
@@ -2457,12 +2462,20 @@ void register_console(struct console *newcon)
 	}
 
 	/*
-	 *	See if this console matches one we selected on
-	 *	the command line.
+	 * See if this console matches one we selected on the command line.
+	 *
+	 * The console_cmdline array is traversed in the reverse order because
+	 * we want to be sure that if this console is preferred then it will be
+	 * the first matching entry.  We use the invariant that is maintained in
+	 * __add_preferred_console().
 	 */
-	for (i = 0, c = console_cmdline;
-	     i < MAX_CMDLINECONSOLES && c->name[0];
-	     i++, c++) {
+	for (i = MAX_CMDLINECONSOLES - 1; i >= 0; i--) {
+
+		if (!console_cmdline[i].name[0])
+			continue;
+
+		c = console_cmdline + i;
+
 		if (!newcon->match ||
 		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
 			/* default matching */
-- 
2.12.0
