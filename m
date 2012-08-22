From: Matthew Leach <matthew.leach@arm.com>
Subject: [PATCH v3] serial: pl011: honour serial aliases in device tree
Date: Wed, 22 Aug 2012 17:25:22 +0100
Message-ID: <1345652722-22668-1-git-send-email-matthew.leach@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38306 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933057Ab2HVQZe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Aug 2012 12:25:34 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org, will.deacon@arm.com, gregkh@linuxfoundation.org, devicetree-discuss@lists.ozlabs.org, robherring2@gmail.com, Matthew Leach <matthew.leach@arm.com>

If the order of UART nodes is changed in the device tree, then tty dev
devices are attached to different serial ports causing the console to
be directed to a different physical serial port. The "serial" aliases
in the device tree should prevent this.

This patch ensures that the UART driver creates tty devices that
honour these aliases if a device tree is present.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
v3: minor consistency correction
v2: use IS_ENABLED instead of ifdefs
 drivers/tty/serial/amba-pl011.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d3553b5..dc05dd1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -52,6 +52,8 @@
 #include <linux/scatterlist.h>
 #include <linux/delay.h>
 #include <linux/types.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/sizes.h>
 
@@ -1869,6 +1871,38 @@ static struct uart_driver amba_reg = {
 	.cons			= AMBA_CONSOLE,
 };
 
+static int pl011_probe_dt_alias(int index, struct device *dev)
+{
+	struct device_node *np;
+	static bool seen_dev_with_alias = false;
+	static bool seen_dev_without_alias = false;
+	int ret = index;
+
+	if (!IS_ENABLED(CONFIG_OF))
+		return ret;
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
+
 static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
@@ -1891,6 +1925,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		goto out;
 	}
 
+	i = pl011_probe_dt_alias(i, &dev->dev);
+
 	base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!base) {
 		ret = -ENOMEM;
-- 
1.7.0.4

