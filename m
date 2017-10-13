From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v2 04/16] serial: mvebu-uart: support probe of multiple ports
Date: Fri, 13 Oct 2017 11:01:48 +0200
Message-ID: <20171013090200.31034-5-miquel.raynal@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Wilson Ding <dingwei@marvell.com>, Allen Yan <yanwei@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

From: Allen Yan <yanwei@marvell.com>

Until now, the mvebu-uart driver only supported probing a single UART
port. However, some platforms have multiple instances of this UART
controller, and therefore the driver should support multiple ports.

In order to achieve this, we make sure to assign port->line properly,
instead of hardcoding it to zero.

Signed-off-by: Allen Yan <yanwei@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---

Changes since v1: using multiple UART ports with this driver is not a
problem anymore if not using a device tree.

 drivers/tty/serial/mvebu-uart.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 7e0a3e9fee15..f3c7271db32b 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -547,20 +547,36 @@ static struct uart_driver mvebu_uart_driver = {
 #endif
 };
 
+/* Counter to keep track of each UART port id when not using CONFIG_OF */
+static int uart_num_counter;
+
 static int mvebu_uart_probe(struct platform_device *pdev)
 {
 	struct resource *reg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	struct uart_port *port;
 	struct mvebu_uart_data *data;
-	int ret;
+	int ret, id;
 
 	if (!reg || !irq) {
 		dev_err(&pdev->dev, "no registers/irq defined\n");
 		return -EINVAL;
 	}
 
-	port = &mvebu_uart_ports[0];
+	/* Assume that all UART ports have a DT alias or none has */
+	id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (!pdev->dev.of_node || id < 0)
+		pdev->id = uart_num_counter++;
+	else
+		pdev->id = id;
+
+	if (pdev->id >= MVEBU_NR_UARTS) {
+		dev_err(&pdev->dev, "cannot have more than %d UART ports\n",
+			MVEBU_NR_UARTS);
+		return -EINVAL;
+	}
+
+	port = &mvebu_uart_ports[pdev->id];
 
 	spin_lock_init(&port->lock);
 
@@ -572,7 +588,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 	port->fifosize   = 32;
 	port->iotype     = UPIO_MEM32;
 	port->flags      = UPF_FIXED_PORT;
-	port->line       = 0; /* single port: force line number to  0 */
+	port->line       = pdev->id;
 
 	port->irq        = irq->start;
 	port->irqflags   = 0;
-- 
2.11.0

