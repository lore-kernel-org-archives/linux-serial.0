From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 4/4] serial: samsung: Fix UART status handling in DMA mode
Date: Thu, 10 Sep 2015 15:41:16 +0200
Message-ID: <1441892476-14273-5-git-send-email-r.baldyga@samsung.com>
References: <1441892476-14273-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1441892476-14273-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, k.kozlowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

This patch fixes UART status handling in DMA mode. For this purpose we
use s3c24xx_serial_rx_drain_fifo() instead of uart_rx_drain_fifo(), which
does the same thing plus checks for special conditions (such as 'break').

Thanks to this we have, for example, Magic SysRq handling, which was
missing in DMA mode so far. Since we can use UART in DMA mode as serial
console, this is a quite important improvement.

This change additionally simplifies RX handling code, as we no longer
need uart_rx_drain_fifo() function, so we can remove it.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/tty/serial/samsung.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 1d7dd86..d72cd73 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -385,32 +385,6 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
 	}
 }
 
-static int s3c24xx_serial_rx_fifocnt(struct s3c24xx_uart_port *ourport,
-				     unsigned long ufstat);
-
-static void uart_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
-{
-	struct uart_port *port = &ourport->port;
-	struct tty_port *tty = &port->state->port;
-	unsigned int ch, ufstat;
-	unsigned int count;
-
-	ufstat = rd_regl(port, S3C2410_UFSTAT);
-	count = s3c24xx_serial_rx_fifocnt(ourport, ufstat);
-
-	if (!count)
-		return;
-
-	while (count-- > 0) {
-		ch = rd_regb(port, S3C2410_URXH);
-
-		ourport->port.icount.rx++;
-		tty_insert_flip_char(tty, ch, TTY_NORMAL);
-	}
-
-	tty_flip_buffer_push(tty);
-}
-
 static void s3c24xx_serial_stop_rx(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
@@ -573,6 +547,8 @@ static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
 	ourport->rx_mode = S3C24XX_RX_PIO;
 }
 
+static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport);
+
 static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 {
 	unsigned int utrstat, ufstat, received;
@@ -606,7 +582,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 		enable_rx_pio(ourport);
 	}
 
-	uart_rx_drain_fifo(ourport);
+	s3c24xx_serial_rx_drain_fifo(ourport);
 
 	if (tty) {
 		tty_flip_buffer_push(t);
-- 
1.9.1
