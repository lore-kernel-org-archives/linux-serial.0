From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] tty/serial: atmel: fix fractional baud rate computation
Date: Wed, 21 Sep 2016 12:44:14 +0200
Message-ID: <20160921104414.16241-1-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: aystarik@gmail.com, Ludovic Desroches <ludovic.desroches@atmel.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, richard.genoud@gmail.com, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-serial@vger.kernel.org

From: Alexey Starikovskiy <aystarik@gmail.com>

The problem with previous code was it rounded values in wrong
place and produced wrong baud rate in some cases.

Signed-off-by: Alexey Starikovskiy <aystarik@gmail.com>
[nicolas.ferre@atmel.com: port to newer kernel and add commit log]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 10 ++++++----
 include/linux/atmel_serial.h      |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5f550d9feed9..fd8aa1f4ba78 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2170,13 +2170,15 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * accurately. This feature is enabled only when using normal mode.
 	 * baudrate = selected clock / (8 * (2 - OVER) * (CD + FP / 8))
 	 * Currently, OVER is always set to 0 so we get
-	 * baudrate = selected clock (16 * (CD + FP / 8))
+	 * baudrate = selected clock / (16 * (CD + FP / 8))
+	 * then
+	 * 8 CD + FP = selected clock / (2 * baudrate)
 	 */
 	if (atmel_port->has_frac_baudrate &&
 	    (mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_NORMAL) {
-		div = DIV_ROUND_CLOSEST(port->uartclk, baud);
-		cd = div / 16;
-		fp = DIV_ROUND_CLOSEST(div % 16, 2);
+		div = DIV_ROUND_CLOSEST(port->uartclk, baud * 2);
+		cd = div >> 3;
+		fp = div & ATMEL_US_FP_MASK;
 	} else {
 		cd = uart_get_divisor(port, baud);
 	}
diff --git a/include/linux/atmel_serial.h b/include/linux/atmel_serial.h
index f8e452aa48d7..bd2560502f3c 100644
--- a/include/linux/atmel_serial.h
+++ b/include/linux/atmel_serial.h
@@ -119,6 +119,7 @@
 #define ATMEL_US_BRGR		0x20	/* Baud Rate Generator Register */
 #define	ATMEL_US_CD		GENMASK(15, 0)	/* Clock Divider */
 #define ATMEL_US_FP_OFFSET	16	/* Fractional Part */
+#define ATMEL_US_FP_MASK	0x7
 
 #define ATMEL_US_RTOR		0x24	/* Receiver Time-out Register for USART */
 #define ATMEL_UA_RTOR		0x28	/* Receiver Time-out Register for UART */
-- 
2.9.0
