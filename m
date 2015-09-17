From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [PATCH] modify pl011 driver to let it work as wakeup source
Date: Thu, 17 Sep 2015 16:31:56 +0800
Message-ID: <1442478716-7377-1-git-send-email-zhaoyang.huang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: amit.kucheria@linaro.org, sudeep.holla@arm.com, daniel.lezcano@linaro.org
List-Id: linux-serial@vger.kernel.org

the commit use the latest dev_pm_set_wake_irq API instead
of the enable_irq_wake and IRQF_NO_SUSPEND to configure the
ttyAMA device to work as the wakeup source

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   47 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index fd27e98..1923b94 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -59,6 +59,11 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/suspend.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/irq.h>
+
+static struct device *uart_dev;
 
 #define UART_NR			14
 
@@ -2353,11 +2358,29 @@ static int pl011_register_port(struct uart_amba_port *uap)
 	return ret;
 }
 
+struct uart_match {
+	struct uart_port *port;
+	struct uart_driver *driver;
+};
+
+static int match_uart_port(struct device *dev, void *data)
+{
+	struct uart_match *match = data;
+
+	dev_t devt = MKDEV(match->driver->major, match->driver->minor) +
+		match->port->line;
+
+	pr_info("the match data of ttyAMA0 is %d %d\n",
+			(int)devt, (int)dev->devt);
+
+	return dev->devt == devt; /* Actually, only one tty per port */
+}
 static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
 	struct vendor_data *vendor = id->data;
 	int portnr, ret;
+	struct uart_match match;
 
 	portnr = pl011_find_free_port();
 	if (portnr < 0)
@@ -2387,13 +2410,35 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 
 	amba_set_drvdata(dev, uap);
 
-	return pl011_register_port(uap);
+	ret = pl011_register_port(uap);
+
+	if (!of_find_property(dev->dev.of_node, "linux,wakeup", NULL)) {
+		uart_dev = NULL;
+		return ret;
+	}
+
+	match.port = &uap->port;
+	match.driver = &amba_reg;
+
+	uart_dev = device_find_child(&dev->dev, &match, match_uart_port);
+
+	if (uart_dev) {
+		device_init_wakeup(uart_dev, true);
+		dev_pm_set_wake_irq(uart_dev, uap->port.irq);
+	}
+
+	return ret;
 }
 
 static int pl011_remove(struct amba_device *dev)
 {
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
 
+	if (uart_dev) {
+		dev_pm_clear_wake_irq(uart_dev);
+		device_init_wakeup(uart_dev, false);
+	}
+
 	uart_remove_one_port(&amba_reg, &uap->port);
 	pl011_unregister_port(uap);
 	return 0;
-- 
1.7.9.5
