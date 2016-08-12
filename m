From: Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH] serial: 8250_mtk: support big baud rate.
Date: Fri, 12 Aug 2016 10:41:11 +0800
Message-ID: <1470969671-17235-1-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Eddie Huang <eddie.huang@mediatek.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Long Cheng <long.cheng@mediatek.com>
List-Id: linux-serial@vger.kernel.org

From: Eddie Huang <eddie.huang@mediatek.com>

mediatek can support baud rate up to 4M.
the 'uart_get_baud_rate' function will limit the max baud rate.
Modify max baud to remove the limit.

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c  |    6 +-----
 drivers/tty/serial/8250/8250_port.c |    4 +---
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 3611ec9..ce0cc47 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -62,7 +62,7 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	baud = uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / 0xffff,
-				  port->uartclk / 16);
+				  port->uartclk);
 
 	if (baud <= 115200) {
 		serial_port_out(port, UART_MTK_HIGHS, 0x0);
@@ -76,10 +76,6 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		quot = DIV_ROUND_UP(port->uartclk, 4 * baud);
 	} else {
 		serial_port_out(port, UART_MTK_HIGHS, 0x3);
-
-		/* Set to highest baudrate supported */
-		if (baud >= 1152000)
-			baud = 921600;
 		quot = DIV_ROUND_UP(port->uartclk, 256 * baud);
 	}
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7481b95..c45c1e3 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2504,8 +2504,6 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 					     struct ktermios *termios,
 					     struct ktermios *old)
 {
-	unsigned int tolerance = port->uartclk / 100;
-
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 * Allow 1% tolerance at the upper limit so uart clks marginally
@@ -2514,7 +2512,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 	 */
 	return uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / 0xffff,
-				  (port->uartclk + tolerance) / 16);
+				  port->uartclk);
 }
 
 void
-- 
1.7.9.5
