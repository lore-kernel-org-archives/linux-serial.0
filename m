From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2] tty: ar933x_uart: add device tree support and binding documentation
Date: Thu, 29 Aug 2013 11:48:15 +0200
Message-ID: <1377769695-27397-1-git-send-email-juhosg@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:38168 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754114Ab3H2JsU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Aug 2013 05:48:20 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org

Modify the probe routine to get the port line number
from device tree if the 'of_node' is populated in the
platform device. The driver can be built as module,
thus add an OF specific module device table as well
to support module auto loading.

This makes it possible to use the driver for AR9330
UART devices specified in device tree.

Cc: devicetree@vger.kernel.org
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Changes since v1:
  - move the doc from bindings/tty/serial to bindings/serial

The patch is agains the 'tty-next' branch of the
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tree
---
 .../devicetree/bindings/serial/qca,ar9330-uart.txt |   34 ++++++++++++++++++++
 drivers/tty/serial/ar933x_uart.c                   |   28 ++++++++++++++--
 2 files changed, 59 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/qca,ar9330-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/qca,ar9330-uart.txt b/Documentation/devicetree/bindings/serial/qca,ar9330-uart.txt
new file mode 100644
index 0000000..c5e032c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/qca,ar9330-uart.txt
@@ -0,0 +1,34 @@
+* Qualcomm Atheros AR9330 High-Speed UART
+
+Required properties:
+
+- compatible: Must be "qca,ar9330-uart"
+
+- reg: Specifies the physical base address of the controller and
+  the length of the memory mapped region.
+
+- interrupt-parent: The phandle for the interrupt controller that
+  services interrupts for this device.
+
+- interrupts: Specifies the interrupt source of the parent interrupt
+  controller. The format of the interrupt specifier depends on the
+  parent interrupt controller.
+
+Additional requirements:
+
+  Each UART port must have an alias correctly numbered in "aliases"
+  node.
+
+Example:
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	uart0: uart@18020000 {
+		compatible = "qca,ar9330-uart";
+		reg = <0x18020000 0x14>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <3>;
+	};
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 0437a9e..acd03af 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -17,6 +17,8 @@
 #include <linux/sysrq.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
@@ -623,13 +625,24 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	struct uart_port *port;
 	struct resource *mem_res;
 	struct resource *irq_res;
+	struct device_node *np;
 	unsigned int baud;
 	int id;
 	int ret;
 
-	id = pdev->id;
-	if (id == -1)
-		id = 0;
+	np = pdev->dev.of_node;
+	if (config_enabled(CONFIG_OF) && np) {
+		id = of_alias_get_id(np, "serial");
+		if (id < 0) {
+			dev_err(&pdev->dev, "unable to get alias id, err=%d\n",
+				id);
+			return id;
+		}
+	} else {
+		id = pdev->id;
+		if (id == -1)
+			id = 0;
+	}
 
 	if (id > CONFIG_SERIAL_AR933X_NR_UARTS)
 		return -EINVAL;
@@ -713,12 +726,21 @@ static int ar933x_uart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id ar933x_uart_of_ids[] = {
+	{ .compatible = "qca,ar9330-uart" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ar933x_uart_of_ids);
+#endif
+
 static struct platform_driver ar933x_uart_platform_driver = {
 	.probe		= ar933x_uart_probe,
 	.remove		= ar933x_uart_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.owner		= THIS_MODULE,
+		.of_match_table = of_match_ptr(ar933x_uart_of_ids),
 	},
 };
 
-- 
1.7.10
