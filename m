From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH/RFC 7/8] serial: earlycon: Set uart_port->big_endian based on DT properties
Date: Wed, 12 Nov 2014 00:46:32 -0800
Message-ID: <1415781993-7755-8-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:53197 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbaKLIrR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 03:47:17 -0500
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

If an earlycon (stdout-path) node is being used, check for "big-endian"
and "native-endian" properties and pass that information to the driver.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/fdt.c              | 9 ++++++++-
 drivers/tty/serial/earlycon.c | 3 ++-
 include/linux/serial_core.h   | 3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 30e97bc..2668097 100644
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
+			of_setup_earlycon(addr, true, match->data);
+		} else {
+			of_setup_earlycon(addr, false, match->data);
+		}
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a514ee6..7556280 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -148,13 +148,14 @@ int __init setup_earlycon(char *buf, const char *match,
 	return 0;
 }
 
-int __init of_setup_earlycon(unsigned long addr,
+int __init of_setup_earlycon(unsigned long addr, bool big_endian,
 			     int (*setup)(struct earlycon_device *, const char *))
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
 
 	port->iotype = UPIO_MEM;
+	port->big_endian = big_endian;
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index ae372f4..1937fca 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -29,6 +29,7 @@
 #include <linux/tty.h>
 #include <linux/mutex.h>
 #include <linux/sysrq.h>
+#include <linux/types.h>
 #include <uapi/linux/serial_core.h>
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
@@ -309,7 +310,7 @@ struct earlycon_device {
 int setup_earlycon(char *buf, const char *match,
 		   int (*setup)(struct earlycon_device *, const char *));
 
-extern int of_setup_earlycon(unsigned long addr,
+extern int of_setup_earlycon(unsigned long addr, bool big_endian,
 			     int (*setup)(struct earlycon_device *, const char *));
 
 #define EARLYCON_DECLARE(name, func) \
-- 
2.1.1

