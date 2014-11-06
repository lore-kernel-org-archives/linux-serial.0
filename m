From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] serial: 8250_dma: call serial8250_tx_dma unconditionally
Date: Thu,  6 Nov 2014 13:28:16 +0200
Message-ID: <1415273297-23323-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1415273297-23323-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59945 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbaKFL2S (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 06:28:18 -0500
In-Reply-To: <1415273297-23323-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since we have the same check inside the function we may drop it away in
__dma_tx_complete().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 258430b..b16f9b1 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -21,6 +21,7 @@ static void __dma_tx_complete(void *param)
 	struct uart_8250_dma	*dma = p->dma;
 	struct circ_buf		*xmit = &p->port.state->xmit;
 	unsigned long	flags;
+	int		ret;
 
 	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
@@ -36,15 +37,11 @@ static void __dma_tx_complete(void *param)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&p->port);
 
-	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&p->port)) {
-		int ret;
-
-		ret = serial8250_tx_dma(p);
-		if (ret) {
-			dma->tx_err = 1;
-			p->ier |= UART_IER_THRI;
-			serial_port_out(&p->port, UART_IER, p->ier);
-		}
+	ret = serial8250_tx_dma(p);
+	if (ret) {
+		dma->tx_err = 1;
+		p->ier |= UART_IER_THRI;
+		serial_port_out(&p->port, UART_IER, p->ier);
 	}
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
-- 
2.1.1

