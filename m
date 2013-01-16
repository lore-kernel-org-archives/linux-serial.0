From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/4] serial: 8250_dma: TX optimisation
Date: Wed, 16 Jan 2013 14:08:14 +0200
Message-ID: <1358338096-32081-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1358338096-32081-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39700 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803Ab3APMHS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 07:07:18 -0500
In-Reply-To: <1358338096-32081-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Remove one useless wakeup, and do not use DMA with zero byte
transfers.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 02333fc..b9f7fd2 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -67,12 +67,12 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	struct circ_buf			*xmit = &p->port.state->xmit;
 	struct dma_async_tx_descriptor	*desc;
 
-	if (dma->tx_running) {
-		uart_write_wakeup(&p->port);
+	if (dma->tx_running)
 		return -EBUSY;
-	}
 
 	dma->tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
+	if (!dma->tx_size)
+		return -EINVAL;
 
 	desc = dmaengine_prep_slave_single(dma->txchan,
 					   dma->tx_addr + xmit->tail,
-- 
1.7.10.4

