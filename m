From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v8 3/3] printk: fix double printing with earlycon
Date: Mon, 20 Mar 2017 13:03:00 +0300
Message-ID: <20170320100302.8656-1-aleksey.makarov@linaro.org>
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
array.  Then traverse it in reverse order to be sure that if
the console is preferred then it will be the first matching entry.

Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---

v7 -> v8:
- add an explanation to the comment how console_cmdline can contain entries
  referring to the same console
- move the body of the function introduced in the previous version to cycle
- don't panic() (Sergey Senozhatsky).  Don't check this condition because
  the loop condition guarantees that it holds.
- use swap() (Sergey Senozhatsky)

v6 -> v7:
- return back to v5 
- leave the check for already registered entries and add a function that
  maintains the invariant.

v5 -> v6:
- drop v5 and continue to work on v4:
- introduce _braille_is_braille_console(). It helps to split original loop
  into three parts: 1) search for braille console, 2) check for
  preferred_console, 3) match other entries so that these three parts do not
  intersect.
- introduce for_each_console_cmdline() macros to traverse console_cmdline
  (Petr Mladek)

 kernel/printk/printk.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd752f0c8ef1..462036e7a767 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1909,8 +1909,28 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	     i < MAX_CMDLINECONSOLES && c->name[0];
 	     i++, c++) {
 		if (strcmp(c->name, name) == 0 && c->index == idx) {
-			if (!brl_options)
-				preferred_console = i;
+			int last;
+
+			if (brl_options)
+				return 0;
+
+			/*
+			 * Maintain an invariant that will help to find if
+			 * the matching console is preferred, see
+			 * register_console():
+			 *
+			 * The last non-braille console is always
+			 * the preferred one.
+			 */
+			for (last = MAX_CMDLINECONSOLES - 1;
+			     last >= 0 && !console_cmdline[last].name[0];
+			     last--)
+				;
+
+			if (i != last)
+				swap(console_cmdline[i], console_cmdline[last]);
+
+			preferred_console = last;
 			return 0;
 		}
 	}
@@ -2457,12 +2477,27 @@ void register_console(struct console *newcon)
 	}
 
 	/*
-	 *	See if this console matches one we selected on
-	 *	the command line.
+	 * See if this console matches one we selected on the command line.
+	 *
+	 * There may be several entries in the console_cmdline array matching
+	 * with the same console, one with newcon->match(), another by
+	 * name/index:
+	 *
+	 *	pl011,mmio,0x87e024000000,115200 -- added from SPCR
+	 *	ttyAMA0 -- added from command line
+	 *
+	 * Traverse the console_cmdline array in reverse order to be
+	 * sure that if this console is preferred then it will be the first
+	 * matching entry.  We use the invariant that is maintained in
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
