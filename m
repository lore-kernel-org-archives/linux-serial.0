From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 56/76] pch_uart : Reduce memcpy
Date: Wed, 16 Mar 2011 14:12:26 -0700
Message-ID: <1300309966-5745-56-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32974 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754939Ab1CPVOz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:55 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Reduce memcpy for performance improvement.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/pch_uart.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 9e1b865..0e171b8 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -390,7 +390,7 @@ static u8 pch_uart_hal_get_modem(struct eg20t_port *priv)
 	return get_msr(priv, priv->membase);
 }
 
-static int pch_uart_hal_write(struct eg20t_port *priv,
+static void pch_uart_hal_write(struct eg20t_port *priv,
 			      const unsigned char *buf, int tx_size)
 {
 	int i;
@@ -400,7 +400,6 @@ static int pch_uart_hal_write(struct eg20t_port *priv,
 		thr = buf[i++];
 		iowrite8(thr, priv->membase + PCH_UART_THR);
 	}
-	return i;
 }
 
 static int pch_uart_hal_read(struct eg20t_port *priv, unsigned char *buf,
@@ -634,7 +633,7 @@ static void pch_dma_tx_complete(void *arg)
 		pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_TX_INT);
 }
 
-static int pop_tx(struct eg20t_port *priv, unsigned char *buf, int size)
+static int pop_tx(struct eg20t_port *priv, int size)
 {
 	int count = 0;
 	struct uart_port *port = &priv->port;
@@ -647,7 +646,7 @@ static int pop_tx(struct eg20t_port *priv, unsigned char *buf, int size)
 		int cnt_to_end =
 		    CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 		int sz = min(size - count, cnt_to_end);
-		memcpy(&buf[count], &xmit->buf[xmit->tail], sz);
+		pch_uart_hal_write(priv, &xmit->buf[xmit->tail], sz);
 		xmit->tail = (xmit->tail + sz) & (UART_XMIT_SIZE - 1);
 		count += sz;
 	} while (!uart_circ_empty(xmit) && count < size);
@@ -723,7 +722,6 @@ static unsigned int handle_tx(struct eg20t_port *priv)
 {
 	struct uart_port *port = &priv->port;
 	struct circ_buf *xmit = &port->state->xmit;
-	int ret;
 	int fifo_size;
 	int tx_size;
 	int size;
@@ -748,10 +746,9 @@ static unsigned int handle_tx(struct eg20t_port *priv)
 	if (size < 0)
 		size = fifo_size;
 
-	tx_size = pop_tx(priv, xmit->buf, size);
+	tx_size = pop_tx(priv, size);
 	if (tx_size > 0) {
-		ret = pch_uart_hal_write(priv, xmit->buf, tx_size);
-		port->icount.tx += ret;
+		port->icount.tx += tx_size;
 		tx_empty = 0;
 	}
 
-- 
1.7.4.1

