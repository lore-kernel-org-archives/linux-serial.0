From: Tony Prisk <linux@prisktech.co.nz>
Subject: [PATCHv4 3/9] serial: vt8500: Add devicetree support for vt8500-serial
Date: Wed, 22 Aug 2012 18:37:36 +1200
Message-ID: <1345617456-10930-1-git-send-email-linux@prisktech.co.nz>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta05.xtra.co.nz ([210.54.141.250]:62871 "EHLO mta02.xtra.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751662Ab2HVGhv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Aug 2012 02:37:51 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Prisk <linux@prisktech.co.nz>

Increase vt8500_max_ports to 6 as the WM8505 has 6 available uarts.
Added max_ports range checking to prevent addressing overflow.
Use devicetree port id as primary addressing for ports but allow
auto-allocation if id not specified.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/tty/serial/vt8500_serial.c |   44 ++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 2be006f..c10e21a 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 /*
  * UART Register offsets
@@ -76,6 +77,8 @@
 #define RX_FIFO_INTS	(RXFAF | RXFF | RXOVER | PER | FER | RXTOUT)
 #define TX_FIFO_INTS	(TXFAE | TXFE | TXUDR)
 
+#define VT8500_MAX_PORTS	6
+
 struct vt8500_port {
 	struct uart_port	uart;
 	char			name[16];
@@ -83,6 +86,13 @@ struct vt8500_port {
 	unsigned int		ier;
 };
 
+/*
+ * we use this variable to keep track of which ports
+ * have been allocated as we can't use pdev->id in
+ * devicetree
+ */
+static unsigned long vt8500_ports_in_use;
+
 static inline void vt8500_write(struct uart_port *port, unsigned int val,
 			     unsigned int off)
 {
@@ -431,7 +441,7 @@ static int vt8500_verify_port(struct uart_port *port,
 	return 0;
 }
 
-static struct vt8500_port *vt8500_uart_ports[4];
+static struct vt8500_port *vt8500_uart_ports[VT8500_MAX_PORTS];
 static struct uart_driver vt8500_uart_driver;
 
 #ifdef CONFIG_SERIAL_VT8500_CONSOLE
@@ -548,7 +558,9 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 {
 	struct vt8500_port *vt8500_port;
 	struct resource *mmres, *irqres;
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
+	int port;
 
 	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irqres = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
@@ -559,13 +571,31 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 	if (!vt8500_port)
 		return -ENOMEM;
 
+	if (np)
+		port = of_alias_get_id(np, "serial");
+
+	if (port < 0) {
+		/* calculate the port id */
+		port = find_first_zero_bit(&vt8500_ports_in_use,
+					sizeof(vt8500_ports_in_use));
+	}
+
+	if (port > VT8500_MAX_PORTS)
+		return -ENODEV;
+
+	/* reserve the port id */
+	if (test_and_set_bit(port, &vt8500_ports_in_use)) {
+		/* port already in use - shouldn't really happen */
+		return -EBUSY;
+	}
+
 	vt8500_port->uart.type = PORT_VT8500;
 	vt8500_port->uart.iotype = UPIO_MEM;
 	vt8500_port->uart.mapbase = mmres->start;
 	vt8500_port->uart.irq = irqres->start;
 	vt8500_port->uart.fifosize = 16;
 	vt8500_port->uart.ops = &vt8500_uart_pops;
-	vt8500_port->uart.line = pdev->id;
+	vt8500_port->uart.line = port;
 	vt8500_port->uart.dev = &pdev->dev;
 	vt8500_port->uart.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 	vt8500_port->uart.uartclk = 24000000;
@@ -579,7 +609,7 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	vt8500_uart_ports[pdev->id] = vt8500_port;
+	vt8500_uart_ports[port] = vt8500_port;
 
 	uart_add_one_port(&vt8500_uart_driver, &vt8500_port->uart);
 
@@ -603,12 +633,18 @@ static int __devexit vt8500_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id wmt_dt_ids[] = {
+	{ .compatible = "via,vt8500-uart", },
+	{}
+};
+
 static struct platform_driver vt8500_platform_driver = {
 	.probe  = vt8500_serial_probe,
 	.remove = __devexit_p(vt8500_serial_remove),
 	.driver = {
 		.name = "vt8500_serial",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(wmt_dt_ids),
 	},
 };
 
@@ -642,4 +678,4 @@ module_exit(vt8500_serial_exit);
 
 MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
 MODULE_DESCRIPTION("Driver for vt8500 serial device");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

