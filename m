From: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Subject: [PATCH v2] serial: 8250_of: Add reset support
Date: Fri, 26 May 2017 11:55:19 +1000
Message-ID: <20170526015519.11865-1-joel@jms.id.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This adds the hooks for an optional reset controller in the 8250 device
tree node.

Signed-off-by: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>

---
v2:
 Address Philipp's comments. Thanks for the review!
 - use _shared variant
 - remove unnecessary error handling

 Documentation/devicetree/bindings/serial/8250.txt |  1 +
 drivers/tty/serial/8250/8250_of.c                 | 10 ++++++++++
 2 files changed, 11 insertions(+)

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
index 1cbadafc6889..e95cc9698c32 100644
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
@@ -132,6 +134,13 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		}
 	}
 
+	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
+	if (IS_ERR(info->rst))
+		goto out;
+	ret = reset_control_deassert(info->rst);
+	if (ret)
+		goto out;
+
 	port->type = type;
 	port->uartclk = clk;
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
@@ -231,6 +240,7 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 
 	if (info->clk)
 		clk_disable_unprepare(info->clk);
+	reset_control_assert(info->rst);
 	kfree(info);
 	return 0;
 }
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
