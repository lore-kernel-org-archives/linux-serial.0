From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: xilinx: Use platform_get_irq to get irq description structure
Date: Mon, 13 Apr 2015 16:34:21 +0200
Message-ID: <aded4ecb0160a068860b00bbed71e0b00f7742e8.1428935656.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Jiri Slaby <jslaby@suse.cz>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

For systems with CONFIG_SERIAL_OF_PLATFORM=y and device_type =
"serial"; property in DT of_serial.c driver maps and unmaps IRQ (because
driver probe fails). Then a driver is called but irq mapping is not
created that's why driver is failing again in again on request_irq().
Based on this use platform_get_irq() instead of platform_get_resource()
which is doing irq_desc allocation and driver itself can request IRQ.

Fix both xilinx serial drivers in the tree.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
CC: <stable@vger.kernel.org>
---

 drivers/tty/serial/uartlite.c      | 11 ++++++-----
 drivers/tty/serial/xilinx_uartps.c | 12 ++++++------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 189f52e3111f..a0099a7f60d4 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -632,7 +632,8 @@ MODULE_DEVICE_TABLE(of, ulite_of_match);
 
 static int ulite_probe(struct platform_device *pdev)
 {
-	struct resource *res, *res2;
+	struct resource *res;
+	int irq;
 	int id = pdev->id;
 #ifdef CONFIG_OF
 	const __be32 *prop;
@@ -646,11 +647,11 @@ static int ulite_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENODEV;
 
-	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res2)
-		return -ENODEV;
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -ENXIO;
 
-	return ulite_assign(&pdev->dev, id, res->start, res2->start);
+	return ulite_assign(&pdev->dev, id, res->start, irq);
 }
 
 static int ulite_remove(struct platform_device *pdev)
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index cff531a51a78..54853a02ce9e 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1325,9 +1325,9 @@ static SIMPLE_DEV_PM_OPS(cdns_uart_dev_pm_ops, cdns_uart_suspend,
  */
 static int cdns_uart_probe(struct platform_device *pdev)
 {
-	int rc, id;
+	int rc, id, irq;
 	struct uart_port *port;
-	struct resource *res, *res2;
+	struct resource *res;
 	struct cdns_uart *cdns_uart_data;
 
 	cdns_uart_data = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_data),
@@ -1374,9 +1374,9 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		goto err_out_clk_disable;
 	}
 
-	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res2) {
-		rc = -ENODEV;
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		rc = -ENXIO;
 		goto err_out_clk_disable;
 	}
 
@@ -1405,7 +1405,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		 * and triggers invocation of the config_port() entry point.
 		 */
 		port->mapbase = res->start;
-		port->irq = res2->start;
+		port->irq = irq;
 		port->dev = &pdev->dev;
 		port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
 		port->private_data = cdns_uart_data;
-- 
2.3.5
