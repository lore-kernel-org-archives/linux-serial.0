From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 1/5] serial/8250_fintek: Use private data structure
Date: Mon, 15 Jun 2015 16:18:42 +0200
Message-ID: <1434377926-31958-2-git-send-email-ricardo.ribalda@gmail.com>
References: <1434377926-31958-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434377926-31958-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Huewe <PeterHuewe@gmx.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
List-Id: linux-serial@vger.kernel.org

Save the port index and the line id in a private structure.

Reported-by: Peter Hong <peter_hong@fintek.com.tw>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 48 ++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 5815e81b5fc6..c7f1485e6a54 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -39,6 +39,11 @@
 
 #define DRIVER_NAME "8250_fintek"
 
+struct fintek_8250 {
+	u8 index;
+	long line;
+};
+
 static int fintek_8250_enter_key(void){
 
 	if (!request_muxed_region(ADDR_PORT, 2, DRIVER_NAME))
@@ -93,9 +98,9 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 			      struct serial_rs485 *rs485)
 {
 	uint8_t config = 0;
-	int index = fintek_8250_get_index(port->iobase);
+	struct fintek_8250 *pdata = port->private_data;
 
-	if (index < 0)
+	if (!pdata)
 		return -EINVAL;
 
 	if (rs485->flags & SER_RS485_ENABLED)
@@ -129,7 +134,7 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 		return -EBUSY;
 
 	outb(LDN, ADDR_PORT);
-	outb(index, DATA_PORT);
+	outb(pdata->index, DATA_PORT);
 	outb(RS485, ADDR_PORT);
 	outb(config, DATA_PORT);
 	fintek_8250_exit_key();
@@ -142,14 +147,16 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 static int
 fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
-	int line;
 	struct uart_8250_port uart;
+	struct fintek_8250 *pdata;
 	int ret;
+	int index;
 
 	if (!pnp_port_valid(dev, 0))
 		return -ENODEV;
 
-	if (fintek_8250_get_index(pnp_port_start(dev, 0)) < 0)
+	index = fintek_8250_get_index(pnp_port_start(dev, 0));
+	if (index < 0)
 		return -ENODEV;
 
 	/* Enable configuration registers*/
@@ -162,6 +169,12 @@ fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	if (ret)
 		return ret;
 
+	pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	uart.port.private_data = pdata;
+
 	memset(&uart, 0, sizeof(uart));
 	if (!pnp_irq_valid(dev, 0))
 		return -ENODEV;
@@ -176,40 +189,41 @@ fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	uart.port.uartclk = 1843200;
 	uart.port.dev = &dev->dev;
 
-	line = serial8250_register_8250_port(&uart);
-	if (line < 0)
+	pdata->index = index;
+	pdata->line = serial8250_register_8250_port(&uart);
+	if (pdata->line < 0)
 		return -ENODEV;
 
-	pnp_set_drvdata(dev, (void *)((long)line + 1));
+	pnp_set_drvdata(dev, pdata);
 	return 0;
 }
 
 static void fintek_8250_remove(struct pnp_dev *dev)
 {
-	long line = (long)pnp_get_drvdata(dev);
+	struct fintek_8250 *pdata = pnp_get_drvdata(dev);
 
-	if (line)
-		serial8250_unregister_port(line - 1);
+	if (pdata)
+		serial8250_unregister_port(pdata->line);
 }
 
 #ifdef CONFIG_PM
 static int fintek_8250_suspend(struct pnp_dev *dev, pm_message_t state)
 {
-	long line = (long)pnp_get_drvdata(dev);
+	struct fintek_8250 *pdata = pnp_get_drvdata(dev);
 
-	if (!line)
+	if (!pdata)
 		return -ENODEV;
-	serial8250_suspend_port(line - 1);
+	serial8250_suspend_port(pdata->line);
 	return 0;
 }
 
 static int fintek_8250_resume(struct pnp_dev *dev)
 {
-	long line = (long)pnp_get_drvdata(dev);
+	struct fintek_8250 *pdata = pnp_get_drvdata(dev);
 
-	if (!line)
+	if (!pdata)
 		return -ENODEV;
-	serial8250_resume_port(line - 1);
+	serial8250_resume_port(pdata->line);
 	return 0;
 }
 #else
-- 
2.1.4
