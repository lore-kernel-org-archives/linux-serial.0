From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 1/2] serial: atmel: trivial: clean the IP version decoding code
Date: Mon, 25 Jan 2016 18:38:01 +0100
Message-ID: <198abfa682d5a39758599d34d1c5b9fd2858cedc.1453743308.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, davidm@egauge.net, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-serial@vger.kernel.org

No functional change is associated with this patch.

A driver property depends on the Atmel serial IP revision. This property
is the way the rx timeout is handled: by an hardware or software timer.
So, change this property name and setup code so that it's easier to understand
and more future proof as the distinction of USART vs. UART is blurrier on newer
SoCs.
Variable names and debug comments are also adapted to make this code more obvious.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a809119dff45..de5d32c31179 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -159,8 +159,8 @@ struct atmel_uart_port {
 	u32			rts_high;
 	u32			rts_low;
 	bool			ms_irq_enabled;
-	bool			is_usart;	/* usart or uart */
-	struct timer_list	uart_timer;	/* uart timer */
+	bool			has_hw_timer;
+	struct timer_list	uart_timer;
 
 	bool			suspended;
 	unsigned int		pending;
@@ -1710,19 +1710,19 @@ static void atmel_get_ip_name(struct uart_port *port)
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	int name = atmel_uart_readl(port, ATMEL_US_NAME);
 	u32 version;
-	int usart, uart;
-	/* usart and uart ascii */
-	usart = 0x55534152;
-	uart = 0x44424755;
+	u32 usart, dbgu_uart;
+	/* ASCII decoding for IP version */
+	usart = 0x55534152;	/* USAR(T) */
+	dbgu_uart = 0x44424755;	/* DBGU */
 
-	atmel_port->is_usart = false;
+	atmel_port->has_hw_timer = false;
 
 	if (name == usart) {
-		dev_dbg(port->dev, "This is usart\n");
-		atmel_port->is_usart = true;
-	} else if (name == uart) {
-		dev_dbg(port->dev, "This is uart\n");
-		atmel_port->is_usart = false;
+		dev_dbg(port->dev, "Usart with hw timer\n");
+		atmel_port->has_hw_timer = true;
+	} else if (name == dbgu_uart) {
+		dev_dbg(port->dev, "Dbgu or uart without hw timer\n");
+		atmel_port->has_hw_timer = false;
 	} else {
 		/* fallback for older SoCs: use version field */
 		version = atmel_uart_readl(port, ATMEL_US_VERSION);
@@ -1730,12 +1730,12 @@ static void atmel_get_ip_name(struct uart_port *port)
 		case 0x302:
 		case 0x10213:
 			dev_dbg(port->dev, "This version is usart\n");
-			atmel_port->is_usart = true;
+			atmel_port->has_hw_timer = true;
 			break;
 		case 0x203:
 		case 0x10202:
 			dev_dbg(port->dev, "This version is uart\n");
-			atmel_port->is_usart = false;
+			atmel_port->has_hw_timer = false;
 			break;
 		default:
 			dev_err(port->dev, "Not supported ip name nor version, set to uart\n");
@@ -1835,7 +1835,7 @@ static int atmel_startup(struct uart_port *port)
 
 	if (atmel_use_pdc_rx(port)) {
 		/* set UART timeout */
-		if (!atmel_port->is_usart) {
+		if (!atmel_port->has_hw_timer) {
 			mod_timer(&atmel_port->uart_timer,
 					jiffies + uart_poll_timeout(port));
 		/* set USART timeout */
@@ -1850,7 +1850,7 @@ static int atmel_startup(struct uart_port *port)
 		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_RXTEN);
 	} else if (atmel_use_dma_rx(port)) {
 		/* set UART timeout */
-		if (!atmel_port->is_usart) {
+		if (!atmel_port->has_hw_timer) {
 			mod_timer(&atmel_port->uart_timer,
 					jiffies + uart_poll_timeout(port));
 		/* set USART timeout */
-- 
2.1.3
