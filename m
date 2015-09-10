From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 3/4] serial: samsung: introduce
 s3c24xx_serial_rx_drain_fifo() function
Date: Thu, 10 Sep 2015 15:41:15 +0200
Message-ID: <1441892476-14273-4-git-send-email-r.baldyga@samsung.com>
References: <1441892476-14273-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1441892476-14273-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, k.kozlowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

This patch introduces s3c24xx_serial_rx_drain_fifo() which reads data
from RX FIFO and writes it to tty buffer. It also checks for special
conditions (such as 'break') and handles it. This function has been
separated from s3c24xx_serial_rx_chars_pio() as it contains code which
can be used also in DMA mode.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/tty/serial/samsung.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index dc4be54..1d7dd86 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -621,16 +621,12 @@ finish:
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
+static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 {
-	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
 	unsigned int ufcon, ch, flag, ufstat, uerstat;
-	unsigned long flags;
 	int max_count = port->fifosize;
 
-	spin_lock_irqsave(&port->lock, flags);
-
 	while (max_count-- > 0) {
 		ufcon = rd_regl(port, S3C2410_UFCON);
 		ufstat = rd_regl(port, S3C2410_UFSTAT);
@@ -654,9 +650,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 					ufcon |= S3C2410_UFCON_RESETRX;
 					wr_regl(port, S3C2410_UFCON, ufcon);
 					rx_enabled(port) = 1;
-					spin_unlock_irqrestore(&port->lock,
-							flags);
-					goto out;
+					return;
 				}
 				continue;
 			}
@@ -702,10 +696,19 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 				 ch, flag);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
 	tty_flip_buffer_push(&port->state->port);
+}
+
+static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
+{
+	struct s3c24xx_uart_port *ourport = dev_id;
+	struct uart_port *port = &ourport->port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	s3c24xx_serial_rx_drain_fifo(ourport);
+	spin_unlock_irqrestore(&port->lock, flags);
 
-out:
 	return IRQ_HANDLED;
 }
 
-- 
1.9.1
