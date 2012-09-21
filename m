From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 2/3] ARM: move udc_pxa2xx.h to linux/platform_data
Date: Fri, 21 Sep 2012 10:36:27 +0100
Message-ID: <E1TEzet-00077v-VD@rmk-PC.arm.linux.org.uk>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37288 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757111Ab2IUJge (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 05:36:34 -0400
In-Reply-To: <20120921093530.GB31374@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khc@pm.waw.pl>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Move the PXA2xx/IXP4xx UDC header file into linux/platform_data as it
only contains a driver platform data structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/udc_pxa2xx.h   |   26 --------------------------
 arch/arm/mach-ixp4xx/include/mach/udc.h  |    2 +-
 arch/arm/mach-pxa/include/mach/udc.h     |    2 +-
 drivers/usb/gadget/pxa25x_udc.c          |    4 +---
 include/linux/platform_data/pxa2xx_udc.h |   27 +++++++++++++++++++++++++++
 5 files changed, 30 insertions(+), 31 deletions(-)
 delete mode 100644 arch/arm/include/asm/mach/udc_pxa2xx.h
 create mode 100644 include/linux/platform_data/pxa2xx_udc.h

diff --git a/arch/arm/include/asm/mach/udc_pxa2xx.h b/arch/arm/include/asm/mach/udc_pxa2xx.h
deleted file mode 100644
index ea297ac..0000000
--- a/arch/arm/include/asm/mach/udc_pxa2xx.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * arch/arm/include/asm/mach/udc_pxa2xx.h
- *
- * This supports machine-specific differences in how the PXA2xx
- * USB Device Controller (UDC) is wired.
- *
- * It is set in linux/arch/arm/mach-pxa/<machine>.c or in
- * linux/arch/mach-ixp4xx/<machine>.c and used in
- * the probe routine of linux/drivers/usb/gadget/pxa2xx_udc.c
- */
-
-struct pxa2xx_udc_mach_info {
-        int  (*udc_is_connected)(void);		/* do we see host? */
-        void (*udc_command)(int cmd);
-#define	PXA2XX_UDC_CMD_CONNECT		0	/* let host see us */
-#define	PXA2XX_UDC_CMD_DISCONNECT	1	/* so host won't see us */
-
-	/* Boards following the design guidelines in the developer's manual,
-	 * with on-chip GPIOs not Lubbock's weird hardware, can have a sane
-	 * VBUS IRQ and omit the methods above.  Store the GPIO number
-	 * here.  Note that sometimes the signals go through inverters...
-	 */
-	bool	gpio_pullup_inverted;
-	int	gpio_pullup;			/* high == pullup activated */
-};
-
diff --git a/arch/arm/mach-ixp4xx/include/mach/udc.h b/arch/arm/mach-ixp4xx/include/mach/udc.h
index 80d6da2..b47cc0d 100644
--- a/arch/arm/mach-ixp4xx/include/mach/udc.h
+++ b/arch/arm/mach-ixp4xx/include/mach/udc.h
@@ -2,7 +2,7 @@
  * arch/arm/mach-ixp4xx/include/mach/udc.h
  *
  */
-#include <asm/mach/udc_pxa2xx.h>
+#include <linux/platform_data_pxa2xx_udc.h>
 
 extern void ixp4xx_set_udc_info(struct pxa2xx_udc_mach_info *info);
 
diff --git a/arch/arm/mach-pxa/include/mach/udc.h b/arch/arm/mach-pxa/include/mach/udc.h
index 2f82332..9a827e3 100644
--- a/arch/arm/mach-pxa/include/mach/udc.h
+++ b/arch/arm/mach-pxa/include/mach/udc.h
@@ -2,7 +2,7 @@
  * arch/arm/mach-pxa/include/mach/udc.h
  *
  */
-#include <asm/mach/udc_pxa2xx.h>
+#include <linux/platform_data/pxa2xx_udc.h>
 
 extern void pxa_set_udc_info(struct pxa2xx_udc_mach_info *info);
 
diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index 907ad3e..06e498d 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -29,6 +29,7 @@
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
+#include <linux/platform_data/pxa2xx_udc.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/irq.h>
@@ -60,9 +61,6 @@
 #include <mach/lubbock.h>
 #endif
 
-#include <asm/mach/udc_pxa2xx.h>
-
-
 /*
  * This driver handles the USB Device Controller (UDC) in Intel's PXA 25x
  * series processors.  The UDC for the IXP 4xx series is very similar.
diff --git a/include/linux/platform_data/pxa2xx_udc.h b/include/linux/platform_data/pxa2xx_udc.h
new file mode 100644
index 0000000..c6c5e98
--- /dev/null
+++ b/include/linux/platform_data/pxa2xx_udc.h
@@ -0,0 +1,27 @@
+/*
+ * This supports machine-specific differences in how the PXA2xx
+ * USB Device Controller (UDC) is wired.
+ *
+ * It is set in linux/arch/arm/mach-pxa/<machine>.c or in
+ * linux/arch/mach-ixp4xx/<machine>.c and used in
+ * the probe routine of linux/drivers/usb/gadget/pxa2xx_udc.c
+ */
+#ifndef PXA2XX_UDC_H
+#define PXA2XX_UDC_H
+
+struct pxa2xx_udc_mach_info {
+        int  (*udc_is_connected)(void);		/* do we see host? */
+        void (*udc_command)(int cmd);
+#define	PXA2XX_UDC_CMD_CONNECT		0	/* let host see us */
+#define	PXA2XX_UDC_CMD_DISCONNECT	1	/* so host won't see us */
+
+	/* Boards following the design guidelines in the developer's manual,
+	 * with on-chip GPIOs not Lubbock's weird hardware, can have a sane
+	 * VBUS IRQ and omit the methods above.  Store the GPIO number
+	 * here.  Note that sometimes the signals go through inverters...
+	 */
+	bool	gpio_pullup_inverted;
+	int	gpio_pullup;			/* high == pullup activated */
+};
+
+#endif
-- 
1.7.4.4

