From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250_dma: terminate transfer explicitly when timeout
Date: Fri, 28 Nov 2014 16:17:11 +0200
Message-ID: <1417184231-20557-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23411 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbaK1OVO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Nov 2014 09:21:14 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Loic Poulain <loic.poulain@intel.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to terminate transfer in the __dma_rx_complete() since it's
called at the end of transfer. Special case when serial timeout occurs is
handled separately where we have to terminate transfer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index fcd7ac6..e508939 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -59,7 +59,6 @@ static void __dma_rx_complete(void *param)
 
 	dma->rx_running = 0;
 	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
-	dmaengine_terminate_all(dma->rxchan);
 
 	count = dma->rx_size - state.residue;
 
@@ -131,6 +130,7 @@ int serial8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 		if (dma->rx_running) {
 			dmaengine_pause(dma->rxchan);
 			__dma_rx_complete(p);
+			dmaengine_terminate_all(dma->rxchan);
 		}
 		return -ETIMEDOUT;
 	default:
-- 
2.1.3

