From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 6/9] tty: serial: bcm63xx: Eliminate unnecessary request/release functions
Date: Mon, 20 Oct 2014 13:54:05 -0700
Message-ID: <1413838448-29464-7-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:41856 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbaJTUzE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Oct 2014 16:55:04 -0400
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

We don't really need to perform the ioremap "on demand" so it's simpler
just to do it from the probe function.  This also lets us eliminate the
UART_REG_SIZE constant and rely on the resource information passed in
from the DT or platform code.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 30 ++++++++++--------------------
 include/linux/serial_bcm63xx.h    |  2 --
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 2015284..999bb6fa 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -588,20 +588,7 @@ static void bcm_uart_set_termios(struct uart_port *port,
  */
 static int bcm_uart_request_port(struct uart_port *port)
 {
-	unsigned int size;
-
-	size = UART_REG_SIZE;
-	if (!request_mem_region(port->mapbase, size, "bcm63xx")) {
-		dev_err(port->dev, "Memory region busy\n");
-		return -EBUSY;
-	}
-
-	port->membase = ioremap(port->mapbase, size);
-	if (!port->membase) {
-		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, size);
-		return -EBUSY;
-	}
+	/* UARTs always present */
 	return 0;
 }
 
@@ -610,8 +597,7 @@ static int bcm_uart_request_port(struct uart_port *port)
  */
 static void bcm_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, UART_REG_SIZE);
-	iounmap(port->membase);
+	/* Nothing to release ... */
 }
 
 /*
@@ -833,13 +819,20 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	if (pdev->id < 0 || pdev->id >= BCM63XX_NR_UARTS)
 		return -EINVAL;
 
-	if (ports[pdev->id].membase)
+	port = &ports[pdev->id];
+	if (port->membase)
 		return -EBUSY;
+	memset(port, 0, sizeof(*port));
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res_mem)
 		return -ENODEV;
 
+	port->mapbase = res_mem->start;
+	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
+
 	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res_irq)
 		return -ENODEV;
@@ -848,10 +841,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return -ENODEV;
 
-	port = &ports[pdev->id];
-	memset(port, 0, sizeof(*port));
 	port->iotype = UPIO_MEM;
-	port->mapbase = res_mem->start;
 	port->irq = res_irq->start;
 	port->ops = &bcm_uart_ops;
 	port->flags = UPF_BOOT_AUTOCONF;
diff --git a/include/linux/serial_bcm63xx.h b/include/linux/serial_bcm63xx.h
index a80aa1a..570e964 100644
--- a/include/linux/serial_bcm63xx.h
+++ b/include/linux/serial_bcm63xx.h
@@ -116,6 +116,4 @@
 					UART_FIFO_PARERR_MASK |		\
 					UART_FIFO_BRKDET_MASK)
 
-#define UART_REG_SIZE			24
-
 #endif /* _LINUX_SERIAL_BCM63XX_H */
-- 
2.1.1

