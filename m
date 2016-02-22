From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] tty/serial: at91: fix bad offset for UART timeout register
Date: Mon, 22 Feb 2016 15:18:55 +0100
Message-ID: <1456150735-11635-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

With SAMA5D2, the UART has hw timeout but the offset of the register to
define this value is not the same as the one for USART.
When using the new UART, the value of this register was 0 so we never
get timeout irqs. It involves that when using DMA, we were stuck until
the execution of the dma callback which happens when a buffer is full
(so after receiving 2048 bytes).

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 19 +++++++++++++------
 include/linux/atmel_serial.h      |  3 ++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index b30c93f..4b6f04a 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -159,6 +159,7 @@ struct atmel_uart_port {
 	u32			rts_high;
 	u32			rts_low;
 	bool			ms_irq_enabled;
+	u32			rtor;	/* address of receiver timeout register if it exists */
 	bool			has_hw_timer;
 	struct timer_list	uart_timer;
 
@@ -1718,12 +1719,16 @@ static void atmel_get_ip_name(struct uart_port *port)
 
 	atmel_port->has_hw_timer = false;
 
-	if (name == usart || name == new_uart) {
-		dev_dbg(port->dev, "Usart or uart with hw timer\n");
+	if (name == new_uart) {
+		dev_dbg(port->dev, "Uart with hw timer");
 		atmel_port->has_hw_timer = true;
+		atmel_port->rtor = ATMEL_UA_RTOR;
+	} else if (name == usart) {
+		dev_dbg(port->dev, "Usart\n");
+		atmel_port->has_hw_timer = true;
+		atmel_port->rtor = ATMEL_US_RTOR;
 	} else if (name == dbgu_uart) {
 		dev_dbg(port->dev, "Dbgu or uart without hw timer\n");
-		atmel_port->has_hw_timer = false;
 	} else {
 		/* fallback for older SoCs: use version field */
 		version = atmel_uart_readl(port, ATMEL_US_VERSION);
@@ -1732,11 +1737,11 @@ static void atmel_get_ip_name(struct uart_port *port)
 		case 0x10213:
 			dev_dbg(port->dev, "This version is usart\n");
 			atmel_port->has_hw_timer = true;
+			atmel_port->rtor = ATMEL_US_RTOR;
 			break;
 		case 0x203:
 		case 0x10202:
 			dev_dbg(port->dev, "This version is uart\n");
-			atmel_port->has_hw_timer = false;
 			break;
 		default:
 			dev_err(port->dev, "Not supported ip name nor version, set to uart\n");
@@ -1841,7 +1846,8 @@ static int atmel_startup(struct uart_port *port)
 					jiffies + uart_poll_timeout(port));
 		/* set USART timeout */
 		} else {
-			atmel_uart_writel(port, ATMEL_US_RTOR, PDC_RX_TIMEOUT);
+			atmel_uart_writel(port, atmel_port->rtor,
+					  PDC_RX_TIMEOUT);
 			atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_STTTO);
 
 			atmel_uart_writel(port, ATMEL_US_IER,
@@ -1856,7 +1862,8 @@ static int atmel_startup(struct uart_port *port)
 					jiffies + uart_poll_timeout(port));
 		/* set USART timeout */
 		} else {
-			atmel_uart_writel(port, ATMEL_US_RTOR, PDC_RX_TIMEOUT);
+			atmel_uart_writel(port, atmel_port->rtor,
+					  PDC_RX_TIMEOUT);
 			atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_STTTO);
 
 			atmel_uart_writel(port, ATMEL_US_IER,
diff --git a/include/linux/atmel_serial.h b/include/linux/atmel_serial.h
index ee696d7..5a4d664 100644
--- a/include/linux/atmel_serial.h
+++ b/include/linux/atmel_serial.h
@@ -119,7 +119,8 @@
 #define ATMEL_US_BRGR		0x20	/* Baud Rate Generator Register */
 #define	ATMEL_US_CD		GENMASK(15, 0)	/* Clock Divider */
 
-#define ATMEL_US_RTOR		0x24	/* Receiver Time-out Register */
+#define ATMEL_US_RTOR		0x24	/* Receiver Time-out Register for USART */
+#define ATMEL_UA_RTOR		0x28	/* Receiver Time-out Register for UART */
 #define	ATMEL_US_TO		GENMASK(15, 0)	/* Time-out Value */
 
 #define ATMEL_US_TTGR		0x28	/* Transmitter Timeguard Register */
-- 
2.5.0
