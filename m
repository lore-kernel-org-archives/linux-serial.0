From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 09/10] serial: earlycon: Set UPIO_MEM32BE based on DT properties
Date: Wed, 12 Nov 2014 12:54:06 -0800
Message-ID: <1415825647-6024-10-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33249 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbaKLUys (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 15:54:48 -0500
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

If an earlycon (stdout-path) node is being used, check for "big-endian"
or "native-endian" properties and pass the appropriate iotype to the
driver.

Note that LE sets UPIO_MEM (8-bit) but BE sets UPIO_MEM32BE (32-bit).  The
big-endian property only really makes sense in the context of 32-bit
registers, since 8-bit accesses never require data swapping.

At some point, the of_earlycon code may want to pass in the reg-io-width,
reg-offset, and reg-shift parameters too.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/fdt.c              | 9 ++++++++-
 drivers/tty/serial/earlycon.c | 4 ++--
 include/linux/serial_core.h   | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 30e97bc..15f80c9 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kconfig.h>
 #include <linux/initrd.h>
 #include <linux/memblock.h>
 #include <linux/of.h>
@@ -784,7 +785,13 @@ int __init early_init_dt_scan_chosen_serial(void)
 		if (!addr)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match->data);
+		if (fdt_getprop(fdt, offset, "big-endian", NULL) ||
+		    (fdt_getprop(fdt, offset, "native-endian", NULL) &&
+		     IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))) {
+			of_setup_earlycon(addr, UPIO_MEM32BE, match->data);
+		} else {
+			of_setup_earlycon(addr, UPIO_MEM, match->data);
+		}
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a514ee6..548f7d7 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -148,13 +148,13 @@ int __init setup_earlycon(char *buf, const char *match,
 	return 0;
 }
 
-int __init of_setup_earlycon(unsigned long addr,
+int __init of_setup_earlycon(unsigned long addr, unsigned char iotype,
 			     int (*setup)(struct earlycon_device *, const char *))
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
 
-	port->iotype = UPIO_MEM;
+	port->iotype = iotype;
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d2d5bf6..0d60c64 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -310,7 +310,7 @@ struct earlycon_device {
 int setup_earlycon(char *buf, const char *match,
 		   int (*setup)(struct earlycon_device *, const char *));
 
-extern int of_setup_earlycon(unsigned long addr,
+extern int of_setup_earlycon(unsigned long addr, unsigned char iotype,
 			     int (*setup)(struct earlycon_device *, const char *));
 
 #define EARLYCON_DECLARE(name, func) \
-- 
2.1.1

