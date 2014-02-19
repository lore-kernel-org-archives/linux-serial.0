From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/4] tty: serial: bcm63xx_uart: define UART_REG_SIZE constant
Date: Wed, 19 Feb 2014 15:22:45 -0800
Message-ID: <1392852167-26243-3-git-send-email-f.fainelli@gmail.com>
References: <1392852167-26243-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:51901 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbaBSXXY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Feb 2014 18:23:24 -0500
In-Reply-To: <1392852167-26243-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, gregkh@linuxfoundation.org, Florian Fainelli <f.fainelli@gmail.com>

The bcm63xx_uart driver uses RSET_UART_SIZE which is a constant defined
for MIPS-based BCM63xx platforms, pull this constant value from the
MIPS-specific header and put it in include/linux/serial_bcm63xx.h to
make the driver platform agnostic.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 4 ++--
 include/linux/serial_bcm63xx.h    | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index d71143e..37e7e33 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -589,7 +589,7 @@ static int bcm_uart_request_port(struct uart_port *port)
 {
 	unsigned int size;
 
-	size = RSET_UART_SIZE;
+	size = UART_REG_SIZE;
 	if (!request_mem_region(port->mapbase, size, "bcm63xx")) {
 		dev_err(port->dev, "Memory region busy\n");
 		return -EBUSY;
@@ -609,7 +609,7 @@ static int bcm_uart_request_port(struct uart_port *port)
  */
 static void bcm_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, RSET_UART_SIZE);
+	release_mem_region(port->mapbase, UART_REG_SIZE);
 	iounmap(port->membase);
 }
 
diff --git a/include/linux/serial_bcm63xx.h b/include/linux/serial_bcm63xx.h
index 570e964..a80aa1a 100644
--- a/include/linux/serial_bcm63xx.h
+++ b/include/linux/serial_bcm63xx.h
@@ -116,4 +116,6 @@
 					UART_FIFO_PARERR_MASK |		\
 					UART_FIFO_BRKDET_MASK)
 
+#define UART_REG_SIZE			24
+
 #endif /* _LINUX_SERIAL_BCM63XX_H */
-- 
1.8.3.2

