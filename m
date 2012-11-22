From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] serial: samsung: fix potential soft lockup during uart write
Date: Thu, 22 Nov 2012 18:06:28 +0530
Message-ID: <1353587788-21538-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:11557 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab2KVUSy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Nov 2012 15:18:54 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, kyungmin.park@samsung.com, hk619.kim@samsung.com

Certain tty line discipline implementations such slip and bluetooth hci invoke
the serial core uart_write() api in their write_wakeup callback. This leads to
a soft lockup with samsung serial driver since the uart port lock is taken in
the driver's interrupt handler and uart_write() attempts to take the same lock
again.

Fix this issue by releasing the uart port lock before the call to
uart_write_wakeup() in the tx handler. Also move the spin-lock/unlock sequence
from s3c64xx_serial_handle_irq() function into the tx and rx irq handlers so
that this change is applicable to s3c24xx platforms as well.

Reported-by: Kyungmin Park <kyungmin.park@samsung.com>
Reported-by: Hyeonkook Kim <hk619.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/tty/serial/samsung.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 7f04717..97bac4c 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -223,8 +223,11 @@ s3c24xx_serial_rx_chars(int irq, void *dev_id)
 	struct uart_port *port = &ourport->port;
 	struct tty_struct *tty = port->state->port.tty;
 	unsigned int ufcon, ch, flag, ufstat, uerstat;
+	unsigned long flags;
 	int max_count = 64;
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	while (max_count-- > 0) {
 		ufcon = rd_regl(port, S3C2410_UFCON);
 		ufstat = rd_regl(port, S3C2410_UFSTAT);
@@ -299,6 +302,7 @@ s3c24xx_serial_rx_chars(int irq, void *dev_id)
 	tty_flip_buffer_push(tty);
 
  out:
+	spin_unlock_irqrestore(&port->lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -307,8 +311,11 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
 	struct circ_buf *xmit = &port->state->xmit;
+	unsigned long flags;
 	int count = 256;
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	if (port->x_char) {
 		wr_regb(port, S3C2410_UTXH, port->x_char);
 		port->icount.tx++;
@@ -336,13 +343,17 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 		port->icount.tx++;
 	}
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
+		spin_unlock(&port->lock);
 		uart_write_wakeup(port);
+		spin_lock(&port->lock);
+	}
 
 	if (uart_circ_empty(xmit))
 		s3c24xx_serial_stop_tx(port);
 
  out:
+	spin_unlock_irqrestore(&port->lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -352,10 +363,8 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
 	unsigned int pend = rd_regl(port, S3C64XX_UINTP);
-	unsigned long flags;
 	irqreturn_t ret = IRQ_HANDLED;
 
-	spin_lock_irqsave(&port->lock, flags);
 	if (pend & S3C64XX_UINTM_RXD_MSK) {
 		ret = s3c24xx_serial_rx_chars(irq, id);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_RXD_MSK);
@@ -364,7 +373,6 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 		ret = s3c24xx_serial_tx_chars(irq, id);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
 	}
-	spin_unlock_irqrestore(&port->lock, flags);
 	return ret;
 }
 
-- 
1.6.6.rc2

