From: Joel Stanley <joel@jms.id.au>
Subject: [PATCH] serial: 8250_of: Add reset support
Date: Wed, 24 May 2017 14:53:19 +1000
Message-ID: <20170524045319.29926-1-joel@jms.id.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

This adds the hooks for an optional reset controller in the 8250 device
tree node.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/serial/8250.txt |  1 +
 drivers/tty/serial/8250/8250_of.c                 | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 10276a46ecef..63e32393f82b 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -45,6 +45,7 @@ Optional properties:
   property.
 - tx-threshold: Specify the TX FIFO low water indication for parts with
   programmable TX FIFO thresholds.
+- resets : phandle + reset specifier pairs
 
 Note:
 * fsl,ns16550:
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 1cbadafc6889..f34dd23376f4 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -19,11 +19,13 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 
 #include "8250.h"
 
 struct of_serial_info {
 	struct clk *clk;
+	struct reset_control *rst;
 	int type;
 	int line;
 };
@@ -132,6 +134,18 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		}
 	}
 
+	info->rst = devm_reset_control_get_optional(&ofdev->dev, NULL);
+	if (IS_ERR(info->rst)) {
+		ret = PTR_ERR(info->rst);
+		if (ret == -EPROBE_DEFER)
+			goto out;
+		info->rst = NULL;
+	} else {
+		ret = reset_control_deassert(info->rst);
+		if (ret)
+			goto out;
+	}
+
 	port->type = type;
 	port->uartclk = clk;
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
@@ -231,6 +245,8 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 
 	if (info->clk)
 		clk_disable_unprepare(info->clk);
+	if (info->rst)
+		reset_control_assert(info->rst);
 	kfree(info);
 	return 0;
 }
-- 
2.11.0
