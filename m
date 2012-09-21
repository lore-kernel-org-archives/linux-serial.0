From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 1/3] ARM: move serial_sa1100.h header file to
 linux/platform_data
Date: Fri, 21 Sep 2012 10:36:07 +0100
Message-ID: <E1TEzeZ-00077r-L1@rmk-PC.arm.linux.org.uk>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37280 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932761Ab2IUJgP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 05:36:15 -0400
In-Reply-To: <20120921093530.GB31374@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This is really driver platform data, so move it to the appropriate
directory.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/serial_sa1100.h   |   31 -------------------------
 arch/arm/mach-sa1100/assabet.c              |    2 +-
 arch/arm/mach-sa1100/badge4.c               |    2 +-
 arch/arm/mach-sa1100/cerf.c                 |    2 +-
 arch/arm/mach-sa1100/collie.c               |    2 +-
 arch/arm/mach-sa1100/h3xxx.c                |    2 +-
 arch/arm/mach-sa1100/hackkit.c              |    2 +-
 arch/arm/mach-sa1100/jornada720.c           |    2 +-
 arch/arm/mach-sa1100/lart.c                 |    2 +-
 arch/arm/mach-sa1100/nanoengine.c           |    2 +-
 arch/arm/mach-sa1100/neponset.c             |    2 +-
 arch/arm/mach-sa1100/pleb.c                 |    2 +-
 arch/arm/mach-sa1100/shannon.c              |    2 +-
 arch/arm/mach-sa1100/simpad.c               |    2 +-
 drivers/tty/serial/sa1100.c                 |    2 +-
 include/linux/platform_data/sa11x0-serial.h |   33 +++++++++++++++++++++++++++
 16 files changed, 47 insertions(+), 45 deletions(-)
 delete mode 100644 arch/arm/include/asm/mach/serial_sa1100.h
 create mode 100644 include/linux/platform_data/sa11x0-serial.h

diff --git a/arch/arm/include/asm/mach/serial_sa1100.h b/arch/arm/include/asm/mach/serial_sa1100.h
deleted file mode 100644
index d09064b..0000000
--- a/arch/arm/include/asm/mach/serial_sa1100.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- *  arch/arm/include/asm/mach/serial_sa1100.h
- *
- *  Author: Nicolas Pitre
- *
- * Moved and changed lots, Russell King
- *
- * Low level machine dependent UART functions.
- */
-
-struct uart_port;
-struct uart_info;
-
-/*
- * This is a temporary structure for registering these
- * functions; it is intended to be discarded after boot.
- */
-struct sa1100_port_fns {
-	void	(*set_mctrl)(struct uart_port *, u_int);
-	u_int	(*get_mctrl)(struct uart_port *);
-	void	(*pm)(struct uart_port *, u_int, u_int);
-	int	(*set_wake)(struct uart_port *, u_int);
-};
-
-#ifdef CONFIG_SERIAL_SA1100
-void sa1100_register_uart_fns(struct sa1100_port_fns *fns);
-void sa1100_register_uart(int idx, int port);
-#else
-#define sa1100_register_uart_fns(fns) do { } while (0)
-#define sa1100_register_uart(idx,port) do { } while (0)
-#endif
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index d673211..4a0e6b8 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/serial_core.h>
 #include <linux/mfd/ucb1x00.h>
 #include <linux/mtd/mtd.h>
@@ -35,7 +36,6 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/irda.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 #include <mach/assabet.h>
 #include <mach/mcp.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index b30fb99..1d60b7e 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/tty.h>
@@ -32,7 +33,6 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/hardware/sa1111.h>
-#include <asm/mach/serial_sa1100.h>
 
 #include <mach/badge4.h>
 
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 09d7f4b..1e03937 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/tty.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/mtd/mtd.h>
@@ -25,7 +26,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 
 #include <mach/cerf.h>
 #include <mach/mcp.h>
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index ea5cff3..5d1e10c 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/delay.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/ucb1x00.h>
 #include <linux/mtd/mtd.h>
@@ -40,7 +41,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 
 #include <asm/hardware/scoop.h>
 #include <asm/mach/sharpsl_param.h>
diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index 63150e1..f17e738 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -17,12 +17,12 @@
 #include <linux/mfd/htc-egpio.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 
 #include <mach/h3xxx.h>
 
diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 7f86bd9..2da6d08 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/cpufreq.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -31,7 +32,6 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
-#include <asm/mach/serial_sa1100.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index e3084f4..35cfc42 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/delay.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/ioport.h>
 #include <linux/mtd/mtd.h>
@@ -30,7 +31,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index b775a0a..39aed9b 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -4,6 +4,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/tty.h>
 
 #include <video/sa1100fb.h>
@@ -15,7 +16,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 #include <mach/mcp.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index 41f69d9..102e08f 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -13,6 +13,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/root_dev.h>
@@ -24,7 +25,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 
 #include <mach/hardware.h>
 #include <mach/nanoengine.h>
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 266db87..88be047 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -7,6 +7,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/serial_core.h>
@@ -14,7 +15,6 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 #include <asm/hardware/sa1111.h>
 #include <asm/sizes.h>
 
diff --git a/arch/arm/mach-sa1100/pleb.c b/arch/arm/mach-sa1100/pleb.c
index 37fe0a0..c51bb63 100644
--- a/arch/arm/mach-sa1100/pleb.c
+++ b/arch/arm/mach-sa1100/pleb.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/ioport.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/io.h>
@@ -18,7 +19,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
-#include <asm/mach/serial_sa1100.h>
 #include <mach/irqs.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 5d33fc3..3dd4416 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/tty.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -18,7 +19,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 #include <mach/mcp.h>
 #include <mach/shannon.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index fbd5359..c76038e 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -9,6 +9,7 @@
 #include <linux/proc_fs.h>
 #include <linux/string.h>
 #include <linux/pm.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/ucb1x00.h>
 #include <linux/mtd/mtd.h>
@@ -23,7 +24,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 #include <mach/mcp.h>
 #include <mach/simpad.h>
 #include <mach/irqs.h>
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index 2ca5959..ecc1e16 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
+#include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -39,7 +40,6 @@
 #include <asm/irq.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <asm/mach/serial_sa1100.h>
 
 /* We've been assigned a range on the "Low-density serial ports" major */
 #define SERIAL_SA1100_MAJOR	204
diff --git a/include/linux/platform_data/sa11x0-serial.h b/include/linux/platform_data/sa11x0-serial.h
new file mode 100644
index 0000000..4504d5d
--- /dev/null
+++ b/include/linux/platform_data/sa11x0-serial.h
@@ -0,0 +1,33 @@
+/*
+ *  Author: Nicolas Pitre
+ *
+ * Moved and changed lots, Russell King
+ *
+ * Low level machine dependent UART functions.
+ */
+#ifndef SA11X0_SERIAL_H
+#define SA11X0_SERIAL_H
+
+struct uart_port;
+struct uart_info;
+
+/*
+ * This is a temporary structure for registering these
+ * functions; it is intended to be discarded after boot.
+ */
+struct sa1100_port_fns {
+	void	(*set_mctrl)(struct uart_port *, u_int);
+	u_int	(*get_mctrl)(struct uart_port *);
+	void	(*pm)(struct uart_port *, u_int, u_int);
+	int	(*set_wake)(struct uart_port *, u_int);
+};
+
+#ifdef CONFIG_SERIAL_SA1100
+void sa1100_register_uart_fns(struct sa1100_port_fns *fns);
+void sa1100_register_uart(int idx, int port);
+#else
+#define sa1100_register_uart_fns(fns) do { } while (0)
+#define sa1100_register_uart(idx,port) do { } while (0)
+#endif
+
+#endif
-- 
1.7.4.4

