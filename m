From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 2/4] serial: s5pv210: Add device tree support
Date: Wed,  3 Aug 2011 00:08:27 +0100
Message-ID: <1312326509-2723-3-git-send-email-thomas.abraham@linaro.org>
References: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60016 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab1HBXIu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Aug 2011 19:08:50 -0400
In-Reply-To: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, Ben Dooks <ben-linux@fluff.org>

For device tree based probe, the dependecy on pdev->id to attach a
corresponding default port info to the driver's private data is
removed. The fifosize parameter is obtained from the device tree
node and the next available instance of port info is updated
with the fifosize value and attached to the driver's private data.
The default platform data is selected based on the compatible property.

CC: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../devicetree/bindings/serial/samsung_uart.txt    |   16 +++++++
 drivers/tty/serial/s5pv210.c                       |   43 +++++++++++++++++++-
 drivers/tty/serial/samsung.c                       |    5 ++-
 3 files changed, 62 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.txt b/Documentation/devicetree/bindings/serial/samsung_uart.txt
new file mode 100644
index 0000000..9174499
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.txt
@@ -0,0 +1,16 @@
+* Samsung's UART Controller
+
+The Samsung's UART controller is used for serial communications on all of
+Samsung's s3c24xx, s3c64xx and s5p series application processors.
+
+Required properties:
+- compatible: should be specific to the application processor
+    - "samsung,s5pv310-uart" , for Exynos4 processors.
+
+- reg: base physical address of the controller and length of memory mapped
+  region.
+
+- interrupts : Three interrupt numbers should be specified in the following
+  order - Rx interrupt, Tx interrupt, Error Interrupt.
+
+- samsung,uart-fifosize: Size of the tx/rx fifo used in the controller.
diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
index fb0806c..a44b599 100644
--- a/drivers/tty/serial/s5pv210.c
+++ b/drivers/tty/serial/s5pv210.c
@@ -19,6 +19,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
@@ -132,10 +133,49 @@ static struct s3c24xx_uart_info *s5p_uart_inf[] = {
 	[3] = &s5p_port_fifo16,
 };
 
+#ifdef CONFIG_OF
+static struct s3c2410_uartcfg s5pv310_uart_defcfg = {
+	.ucon	= 0x3c5,
+	.ufcon	= 0x111,
+	.flags	= NO_NEED_CHECK_CLKSRC,
+	.has_fracval = 1,
+};
+
+static const struct of_device_id s5pv210_uart_dt_match[] = {
+	{ .compatible = "samsung,s5pv310-uart", .data = &s5pv310_uart_defcfg },
+	{},
+};
+MODULE_DEVICE_TABLE(of, s5pv210_uart_match);
+#else
+#define s5pv210_uart_match NULL
+#endif
+
 /* device management */
 static int s5p_serial_probe(struct platform_device *pdev)
 {
-	return s3c24xx_serial_probe(pdev, s5p_uart_inf[pdev->id]);
+	static unsigned int probe_index;
+	unsigned int port = pdev->id;
+	const struct of_device_id *match;
+	struct s3c2410_uartcfg *cfg;
+
+	if (pdev->dev.of_node) {
+		if (of_property_read_u32(pdev->dev.of_node,
+				"samsung,uart-fifosize",
+				&s5p_uart_inf[probe_index]->fifosize))
+			return -EINVAL;
+
+		cfg = devm_kzalloc(&pdev->dev, sizeof(*cfg), GFP_KERNEL);
+		if (!cfg)
+			return -ENOMEM;
+
+		match = of_match_node(s5pv210_uart_dt_match, pdev->dev.of_node);
+		*cfg = *((struct s3c2410_uartcfg *)match->data);
+		s5p_uart_inf[probe_index]->cfg = cfg;
+		cfg->hwport = probe_index;
+		port = probe_index++;
+	}
+
+	return s3c24xx_serial_probe(pdev, s5p_uart_inf[port]);
 }
 
 static struct platform_driver s5p_serial_driver = {
@@ -144,6 +184,7 @@ static struct platform_driver s5p_serial_driver = {
 	.driver		= {
 		.name	= "s5pv210-uart",
 		.owner	= THIS_MODULE,
+		.of_match_table	= s5pv210_uart_dt_match,
 	},
 };
 
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 47fee73..49ba4a5a 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1070,10 +1070,13 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	/*
 	 * If platform data is supplied, keep a copy of the location of
-	 * platform data in the driver's private data.
+	 * platform data in the driver's private data. In case of device tree
+	 * based probe, the location of platform data is already set.
 	 */
 	if (cfg)
 		info->cfg = cfg;
+	else
+		cfg = info->cfg;
 
 	if (cfg->hwport > CONFIG_SERIAL_SAMSUNG_UARTS) {
 		printk(KERN_ERR "%s: port %d bigger than %d\n", __func__,
-- 
1.7.4.1

