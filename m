From: Matthew Leach <matthew.leach@arm.com>
Subject: [PATCH] serial: pl011: honour serial aliases in device tree
Date: Tue, 21 Aug 2012 11:18:22 +0100
Message-ID: <1345544302-12406-1-git-send-email-matthew.leach@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41760 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755989Ab2HUKS7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Aug 2012 06:18:59 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, robherring2@gmail.com, Matthew Leach <matthew.leach@arm.com>

If the order of UART nodes is changed in the device tree, then tty dev
devices are attached to different serial ports causing the console to
be directed to a different physical serial port. The "serial" aliases
in the device tree should prevent this.

This patch ensures that the UART driver creates tty devices that
honour these aliases if a device tree is present.

Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c17923e..5919599 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -52,6 +52,7 @@
 #include <linux/scatterlist.h>
 #include <linux/delay.h>
 #include <linux/types.h>
+#include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 
 #include <asm/io.h>
@@ -1869,6 +1870,42 @@ static struct uart_driver amba_reg = {
 	.cons			= AMBA_CONSOLE,
 };
 
+#ifdef CONFIG_OF
+static int pl011_probe_dt_alias(int index, struct device *dev)
+{
+	struct device_node *np;
+	static bool seen_dev_with_alias = false;
+	static bool seen_dev_without_alias = false;
+	int ret = index;
+
+	np = dev->of_node;
+	if (!np)
+		return ret;
+
+	ret = of_alias_get_id(np, "serial");
+	if (IS_ERR_VALUE(ret)) {
+		seen_dev_without_alias = true;
+		ret = index;
+	} else {
+		seen_dev_with_alias = true;
+		if (ret >= ARRAY_SIZE(amba_ports) || amba_ports[ret] != NULL) {
+			dev_warn(dev, "requested serial port %d  not available.\n", ret);
+			ret = index;
+		}
+	}
+
+	if (seen_dev_with_alias && seen_dev_without_alias)
+		dev_warn(dev, "aliased and non-aliased serial devices found in device tree. Serial port enumeration may be unpredictable.\n");
+
+	return ret;
+}
+#else
+static int pl011_probe_dt_alias(int index, struct device *dev)
+{
+	return index;
+}
+#endif
+
 static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
@@ -1891,6 +1928,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		goto out;
 	}
 
+	i = pl011_probe_dt_alias(i, &dev->dev);
+
 	base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!base) {
 		ret = -ENOMEM;
-- 
1.7.0.4

