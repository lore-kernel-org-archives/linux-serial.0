From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Tue, 6 Jun 2017 18:03:39 +0200
Message-ID: <20170606160339.GC7604@pathway.suse.cz>
References: <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170509082915.GA13236@bistromath.localdomain>
 <20170511082433.GA421@jagdpanzerIV.localdomain>
 <20170511084158.GB421@jagdpanzerIV.localdomain>
 <20170512125729.GO3452@pathway.suse.cz>
 <7d312633-d040-240d-ec06-ed296b5251ae@linaro.org>
 <20170518154918.GE8621@pathway.suse.cz>
 <4e679bec-4804-9791-fc2b-0e96ad67d511@linaro.org>
 <20170601120325.GA25497@pathway.suse.cz>
 <20170606143149.GB7604@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170606143149.GB7604@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2017-06-06 16:31:49, Petr Mladek wrote:
> On Thu 2017-06-01 14:03:25, Petr Mladek wrote:
> Now, systemd seems to handle the console= parameters as well.
> According to http://0pointer.de/blog/projects/serial-console.html,
> systemd instantiates one serial-getty@.service on the preferred
> (last mentioned) console.
> 
> This might be a reason to define both console=ttyS0 console=ttyS1
> on the command line. People might actually want to get the logs
> and the login prompt on different console.

I have consulted this with a colleague. I am sorry to say but we
believe that this fits into the category of breaking userspace
(systemd, qemu). I would like to revert the patch ASAP,
before rc5. Here is a proposal of the commit message:


>From 142d75792d0df874e80493654311f69f6a1ca798 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Tue, 6 Jun 2017 17:20:38 +0200
Subject: [PATCH] Revert "printk: fix double printing with earlycon"

The commit cf39bf58afdaabc ("printk: fix double printing with earlycon")
caused regression to users that define both console=ttyS1 and console=ttyS0
on the command line, see
https://lkml.kernel.org/r/20170509082915.GA13236@bistromath.localdomain

The kernel log messages always appeared only on one serial port. It is
even documented in Documentation/admin-guide/serial-console.rst:

"Note that you can only define one console per device type (serial,
video)."

The above mentioned commit changed the order in which the command line
parameters are searched. As a result, the kernel log messages go to
the last mentioned ttyS* instead of the first one.

We long thought that using two console=ttyS* on the command line
did not make sense. But then we realized that console= parameters
were handled also by systemd, see
http://0pointer.de/blog/projects/serial-console.html

"By default systemd will instantiate one serial-getty@.service on
the main kernel console, if it is not a virtual terminal."

where

"[4] If multiple kernel consoles are used simultaneously, the main
console is the one listed first in /sys/class/tty/console/active,
which is the last one listed on the kernel command line."

This puts the original report into another light. The system is running
in qemu. The first serial port is used to store the messages into a file.
The second one is used to login to the system via a socket. It depends
on systemd and the historic kernel behavior.

By other words, systemd causes that it makes sense to define both
console=ttyS1 console=ttyS0 on the command line. The kernel fix
caused regression related to userspace (systemd) and need to be
reverted.

In addition, it went out that the fix helped only partially.
The messages still were duplicated when the boot console was
removed early by late_initcall(printk_late_init). Then the entire
log was replayed when the same console was registered as a normal one.

This reverts commit cf39bf58afdaabc0b86f141630fb3fd18190294e.
---
 kernel/printk/printk.c | 46 ++++++++++------------------------------------
 1 file changed, 10 insertions(+), 36 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a1aecf44ab07..a1db38abac5b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -269,7 +269,6 @@ static void __up_console_sem(unsigned long ip)
 #define MAX_CMDLINECONSOLES 8
 
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
-static int console_cmdline_cnt;
 
 static int preferred_console = -1;
 int console_set_on_cmdline;
@@ -1906,25 +1905,12 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	 *	See if this tty is not yet registered, and
 	 *	if we have a slot free.
 	 */
-	for (i = 0, c = console_cmdline; i < console_cmdline_cnt; i++, c++) {
+	for (i = 0, c = console_cmdline;
+	     i < MAX_CMDLINECONSOLES && c->name[0];
+	     i++, c++) {
 		if (strcmp(c->name, name) == 0 && c->index == idx) {
-			if (brl_options)
-				return 0;
-
-			/*
-			 * Maintain an invariant that will help to find if
-			 * the matching console is preferred, see
-			 * register_console():
-			 *
-			 * The last non-braille console is always
-			 * the preferred one.
-			 */
-			if (i != console_cmdline_cnt - 1)
-				swap(console_cmdline[i],
-				     console_cmdline[console_cmdline_cnt - 1]);
-
-			preferred_console = console_cmdline_cnt - 1;
-
+			if (!brl_options)
+				preferred_console = i;
 			return 0;
 		}
 	}
@@ -1937,7 +1923,6 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	braille_set_options(c, brl_options);
 
 	c->index = idx;
-	console_cmdline_cnt++;
 	return 0;
 }
 /*
@@ -2477,23 +2462,12 @@ void register_console(struct console *newcon)
 	}
 
 	/*
-	 * See if this console matches one we selected on the command line.
-	 *
-	 * There may be several entries in the console_cmdline array matching
-	 * with the same console, one with newcon->match(), another by
-	 * name/index:
-	 *
-	 *	pl011,mmio,0x87e024000000,115200 -- added from SPCR
-	 *	ttyAMA0 -- added from command line
-	 *
-	 * Traverse the console_cmdline array in reverse order to be
-	 * sure that if this console is preferred then it will be the first
-	 * matching entry.  We use the invariant that is maintained in
-	 * __add_preferred_console().
+	 *	See if this console matches one we selected on
+	 *	the command line.
 	 */
-	for (i = console_cmdline_cnt - 1; i >= 0; i--) {
-		c = console_cmdline + i;
-
+	for (i = 0, c = console_cmdline;
+	     i < MAX_CMDLINECONSOLES && c->name[0];
+	     i++, c++) {
 		if (!newcon->match ||
 		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
 			/* default matching */
-- 
1.8.5.6
