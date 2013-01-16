From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 1/4] serial: 8250_dma: Switch to using tty_port
Date: Wed, 16 Jan 2013 14:08:13 +0200
Message-ID: <1358338096-32081-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1358338096-32081-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60437 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614Ab3APMHQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 07:07:16 -0500
In-Reply-To: <1358338096-32081-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

The tty buffer functions are converted to using tty_port
structure instead of struct tty, so we must do the same.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 95516a1..02333fc 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -43,8 +43,9 @@ static void __dma_rx_complete(void *param)
 {
 	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
-	struct tty_struct	*tty = p->port.state->port.tty;
+	struct tty_port		*tty_port = &p->port.state->port;
 	struct dma_tx_state	state;
+	int			count;
 
 	dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
@@ -52,10 +53,12 @@ static void __dma_rx_complete(void *param)
 	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
 	dmaengine_terminate_all(dma->rxchan);
 
-	tty_insert_flip_string(tty, dma->rx_buf, dma->rx_size - state.residue);
-	p->port.icount.rx += dma->rx_size - state.residue;
+	count = dma->rx_size - state.residue;
 
-	tty_flip_buffer_push(tty);
+	tty_insert_flip_string(tty_port, dma->rx_buf, count);
+	p->port.icount.rx += count;
+
+	tty_flip_buffer_push(tty_port);
 }
 
 int serial8250_tx_dma(struct uart_8250_port *p)
-- 
1.7.10.4

