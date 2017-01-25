From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] 8250: of: remove remnants of generic of_serial driver
Date: Wed, 25 Jan 2017 23:19:01 +0100
Message-ID: <20170125221919.1153682-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>, Thierry Reding <treding@nvidia.com>, David Lechner <david@lechnology.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

During build testing, I ran into a warning in a driver that I
had written myself at some point:

drivers/tty/serial/8250/8250_of.c: In function 'of_platform_serial_probe':
drivers/tty/serial/8250/8250_of.c:233:1: error: the frame size of 1200 bytes is larger than 1152 bytes [-Werror=frame-larger-than=]

This is harmless by itself, but it shows two other problems in
the driver:

- It still tries to be generic enough to handle all kinds of serial
  ports, where in reality the driver has been 8250-only for a while,
  and every other uart has its own DT support

- As a result of that generalization, we keep two copies of
  'struct uart_port' on the stack during probe(). This is completely
  unnessary.

Removing the last code dealing with unsupported port_type values
solves both problems nicely, and reduces the stack size.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_of.c | 93 ++++++++++-----------------------------
 1 file changed, 24 insertions(+), 69 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 7ff72a978f39..c792e65d92b8 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -168,7 +168,8 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 {
 	const struct of_device_id *match;
 	struct of_serial_info *info;
-	struct uart_port port;
+	struct uart_8250_port port8250;
+	u32 tx_threshold;
 	int port_type;
 	int ret;
 
@@ -184,41 +185,24 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 		return -ENOMEM;
 
 	port_type = (unsigned long)match->data;
-	ret = of_platform_serial_setup(ofdev, port_type, &port, info);
+	memset(&port8250, 0, sizeof(port8250));
+	ret = of_platform_serial_setup(ofdev, port_type, &port8250.port, info);
 	if (ret)
 		goto out;
 
-	switch (port_type) {
-	case PORT_8250 ... PORT_MAX_8250:
-	{
-		u32 tx_threshold;
-		struct uart_8250_port port8250;
-		memset(&port8250, 0, sizeof(port8250));
-		port8250.port = port;
+	if (port8250.port.fifosize)
+		port8250.capabilities = UART_CAP_FIFO;
 
-		if (port.fifosize)
-			port8250.capabilities = UART_CAP_FIFO;
+	/* Check for TX FIFO threshold & set tx_loadsz */
+	if ((of_property_read_u32(ofdev->dev.of_node, "tx-threshold",
+				  &tx_threshold) == 0) &&
+	    (tx_threshold < port8250.port.fifosize))
+		port8250.tx_loadsz = port8250.port.fifosize - tx_threshold;
 
-		/* Check for TX FIFO threshold & set tx_loadsz */
-		if ((of_property_read_u32(ofdev->dev.of_node, "tx-threshold",
-					  &tx_threshold) == 0) &&
-		    (tx_threshold < port.fifosize))
-			port8250.tx_loadsz = port.fifosize - tx_threshold;
+	if (of_property_read_bool(ofdev->dev.of_node, "auto-flow-control"))
+		port8250.capabilities |= UART_CAP_AFE;
 
-		if (of_property_read_bool(ofdev->dev.of_node,
-					  "auto-flow-control"))
-			port8250.capabilities |= UART_CAP_AFE;
-
-		ret = serial8250_register_8250_port(&port8250);
-		break;
-	}
-	default:
-		/* need to add code for these */
-	case PORT_UNKNOWN:
-		dev_info(&ofdev->dev, "Unknown serial port found, ignored\n");
-		ret = -ENODEV;
-		break;
-	}
+	ret = serial8250_register_8250_port(&port8250);
 	if (ret < 0)
 		goto out;
 
@@ -228,7 +212,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	return 0;
 out:
 	kfree(info);
-	irq_dispose_mapping(port.irq);
+	irq_dispose_mapping(port8250.port.irq);
 	return ret;
 }
 
@@ -238,14 +222,8 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 static int of_platform_serial_remove(struct platform_device *ofdev)
 {
 	struct of_serial_info *info = platform_get_drvdata(ofdev);
-	switch (info->type) {
-	case PORT_8250 ... PORT_MAX_8250:
-		serial8250_unregister_port(info->line);
-		break;
-	default:
-		/* need to add code for these */
-		break;
-	}
+
+	serial8250_unregister_port(info->line);
 
 	if (info->clk)
 		clk_disable_unprepare(info->clk);
@@ -254,18 +232,23 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static void of_serial_suspend_8250(struct of_serial_info *info)
+static int of_serial_suspend(struct device *dev)
 {
+	struct of_serial_info *info = dev_get_drvdata(dev);
 	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
 	struct uart_port *port = &port8250->port;
 
 	serial8250_suspend_port(info->line);
+
 	if (info->clk && (!uart_console(port) || console_suspend_enabled))
 		clk_disable_unprepare(info->clk);
+
+	return 0;
 }
 
-static void of_serial_resume_8250(struct of_serial_info *info)
+static int of_serial_resume(struct device *dev)
 {
+	struct of_serial_info *info = dev_get_drvdata(dev);
 	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
 	struct uart_port *port = &port8250->port;
 
@@ -273,34 +256,6 @@ static void of_serial_resume_8250(struct of_serial_info *info)
 		clk_prepare_enable(info->clk);
 
 	serial8250_resume_port(info->line);
-}
-
-static int of_serial_suspend(struct device *dev)
-{
-	struct of_serial_info *info = dev_get_drvdata(dev);
-
-	switch (info->type) {
-	case PORT_8250 ... PORT_MAX_8250:
-		of_serial_suspend_8250(info);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-static int of_serial_resume(struct device *dev)
-{
-	struct of_serial_info *info = dev_get_drvdata(dev);
-
-	switch (info->type) {
-	case PORT_8250 ... PORT_MAX_8250:
-		of_serial_resume_8250(info);
-		break;
-	default:
-		break;
-	}
 
 	return 0;
 }
-- 
2.9.0
