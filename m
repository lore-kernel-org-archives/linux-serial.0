From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 13/13] serial: 8250_early: Remove setup_early_serial8250_console()
Date: Sun,  1 Mar 2015 11:05:58 -0500
Message-ID: <1425225958-17908-14-git-send-email-peter@hurleysoftware.com>
References: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

setup_earlycon() will now match and register the desired earlycon
from the param string (as if 'earlycon=...' had been set on the
command line). Use setup_earlycon() from existing arch call sites
which start an earlycon directly.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 arch/mips/mti-malta/malta-init.c     | 4 ++--
 drivers/firmware/pcdp.c              | 4 ++--
 drivers/tty/serial/8250/8250_early.c | 5 -----
 include/linux/serial_8250.h          | 1 -
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 6849f53..cec3e18 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
 
 #include <asm/cacheflush.h>
 #include <asm/smp-ops.h>
@@ -75,7 +75,7 @@ static void __init console_config(void)
 	if ((strstr(fw_getcmdline(), "earlycon=")) == NULL) {
 		sprintf(console_string, "uart8250,io,0x3f8,%d%c%c", baud,
 			parity, bits);
-		setup_early_serial8250_console(console_string);
+		setup_earlycon(console_string);
 	}
 
 	if ((strstr(fw_getcmdline(), "console=")) == NULL) {
diff --git a/drivers/firmware/pcdp.c b/drivers/firmware/pcdp.c
index a330492..75273a25 100644
--- a/drivers/firmware/pcdp.c
+++ b/drivers/firmware/pcdp.c
@@ -15,7 +15,7 @@
 #include <linux/console.h>
 #include <linux/efi.h>
 #include <linux/serial.h>
-#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
 #include <asm/vga.h>
 #include "pcdp.h"
 
@@ -43,7 +43,7 @@ setup_serial_console(struct pcdp_uart *uart)
 	}
 
 	add_preferred_console("uart", 8250, &options[9]);
-	return setup_early_serial8250_console(options);
+	return setup_earlycon(options);
 #else
 	return -ENODEV;
 #endif
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index d272139..a2b4e58 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -167,8 +167,3 @@ static int __init early_serial8250_setup(struct earlycon_device *device,
 }
 EARLYCON_DECLARE(uart8250, early_serial8250_setup);
 EARLYCON_DECLARE(uart, early_serial8250_setup);
-
-int __init setup_early_serial8250_console(char *cmdline)
-{
-	return setup_earlycon(cmdline);
-}
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index f26ae7f..ca9f87b 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -120,7 +120,6 @@ extern int early_serial_setup(struct uart_port *port);
 
 extern unsigned int serial8250_early_in(struct uart_port *port, int offset);
 extern void serial8250_early_out(struct uart_port *port, int offset, int value);
-extern int setup_early_serial8250_console(char *cmdline);
 extern void serial8250_do_set_termios(struct uart_port *port,
 		struct ktermios *termios, struct ktermios *old);
 extern int serial8250_do_startup(struct uart_port *port);
-- 
2.3.0
