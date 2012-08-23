From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: [PATCHv4 3/9] serial: vt8500: Add devicetree support for vt8500-serial
Date: Thu, 23 Aug 2012 19:35:39 +1200
Message-ID: <1345707346-9035-4-git-send-email-linux@prisktech.co.nz>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1345707346-9035-1-git-send-email-linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Increase vt8500_max_ports to 6 as the WM8505 as 6 available uarts.
Use devicetree port id as primary addressing for ports but allow
auto-allocation if id not specified.

Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
---
 drivers/tty/serial/vt8500_serial.c |   58 ++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 2be006f..205d4cf 100644
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
@@ -559,16 +571,46 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 	if (!vt8500_port)
 		return -ENOMEM;
 
+	if (np)
+		port = of_alias_get_id(np, "serial");
+		if (port > VT8500_MAX_PORTS)
+			port = -1;
+	else
+		port = -1;
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
-	vt8500_port->uart.uartclk = 24000000;
+
+	vt8500_port->clk = of_clk_get(pdev->dev.of_node, 0);
+	if (vt8500_port->clk) {
+		vt8500_port->uart.uartclk = clk_get_rate(vt8500_port->clk);
+	} else {
+		/* use the default of 24Mhz if not specified and warn */
+		pr_warn("%s: serial clock source not specified\n", __func__);
+		vt8500_port->uart.uartclk = 24000000;
+	}
 
 	snprintf(vt8500_port->name, sizeof(vt8500_port->name),
 		 "VT8500 UART%d", pdev->id);
@@ -579,7 +621,7 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	vt8500_uart_ports[pdev->id] = vt8500_port;
+	vt8500_uart_ports[port] = vt8500_port;
 
 	uart_add_one_port(&vt8500_uart_driver, &vt8500_port->uart);
 
@@ -603,12 +645,18 @@ static int __devexit vt8500_serial_remove(struct platform_device *pdev)
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
 
@@ -642,4 +690,4 @@ module_exit(vt8500_serial_exit);
 
 MODULE_AUTHOR("Alexey Charkov <alchark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
 MODULE_DESCRIPTION("Driver for vt8500 serial device");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
