From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] serial: earlycon: stop abusing console::index
Date: Fri,  3 Jun 2016 16:19:33 +0100
Message-ID: <1464967173-27744-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Leif Lindholm <leif.lindholm@arm.com>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Commit cda64e6824026575 ("serial: earlycon: Fixup earlycon console name
and index") added code to decompose an earlycon driver name into a
string prefix and numeric suffix, and place this into console::name and
console::index, such that we'd get a pretty name out of the core console
code, which requires a name and index. This is simply to give a
pretty/useful earlycon driver name in the log messages, and other than
logging the name and index hold no significance.

However, this is broken for drivers such as "pl011", where the "011"
suffix gets stripped off, then subsequently restored, printed as a
decimal, erroneously giving "pl11" in log messages. Additionally, for
earlycon drivers without a numeric suffix, "0" is added regardless. Thus
the code is broken in some cases, and generally inconsistent.

Instead, this patch changes the earlycon code to consistently register
"earlycon0", but ensures that the earlycon driver name is logged at
earlycon_init time. This is obvious, consistent, and sufficient to
provide the required information to the user.

With this in place, amongst the first messages from the kernel, the user
will see something like:

[    0.000000] earlycon: earlycon0 (pl011) at MMIO 0x000000007ff80000 (options '')
[    0.000000] bootconsole [earlycon0] enabled

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Leif Lindholm <leif.lindholm@arm.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/earlycon.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 067783f..2b6622a 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -29,7 +29,7 @@
 #include <asm/serial.h>
 
 static struct console early_con = {
-	.name =		"uart",		/* fixed up at earlycon registration */
+	.name =		"earlycon",
 	.flags =	CON_PRINTBUFFER | CON_BOOT,
 	.index =	0,
 };
@@ -60,24 +60,13 @@ static void __init earlycon_init(struct earlycon_device *device,
 {
 	struct console *earlycon = device->con;
 	struct uart_port *port = &device->port;
-	const char *s;
-	size_t len;
-
-	/* scan backwards from end of string for first non-numeral */
-	for (s = name + strlen(name);
-	     s > name && s[-1] >= '0' && s[-1] <= '9';
-	     s--)
-		;
-	if (*s)
-		earlycon->index = simple_strtoul(s, NULL, 10);
-	len = s - name;
-	strlcpy(earlycon->name, name, min(len + 1, sizeof(earlycon->name)));
+
 	earlycon->data = &early_console_dev;
 
 	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
 	    port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
-		pr_info("%s%d at MMIO%s %pa (options '%s')\n",
-			earlycon->name, earlycon->index,
+		pr_info("%s%d (%s) at MMIO%s %pa (options '%s')\n",
+			earlycon->name, earlycon->index, name,
 			(port->iotype == UPIO_MEM) ? "" :
 			(port->iotype == UPIO_MEM16) ? "16" :
 			(port->iotype == UPIO_MEM32) ? "32" : "32be",
-- 
1.9.1
