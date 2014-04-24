From: Loic Poulain <loic.poulain@intel.com>
Subject: [RESEND PATCH] 8250_core: Fix unwanted TX chars write
Date: Thu, 24 Apr 2014 11:38:56 +0200
Message-ID: <1398332336-5053-1-git-send-email-loic.poulain@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45569 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173AbaDXJjW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Apr 2014 05:39:22 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc: linux-serial@vger.kernel.org, Loic Poulain <loic.poulain@intel.com>

On transmit-hold-register empty, serial8250_tx_chars
should be called only if we don't use DMA.
DMA has its own tx cycle.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 resend: just remove email footer disclaimer.

 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 81f909c..0e1bf88 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1520,7 +1520,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 			status = serial8250_rx_chars(up, status);
 	}
 	serial8250_modem_status(up);
-	if (status & UART_LSR_THRE)
+	if (!up->dma && (status & UART_LSR_THRE))
 		serial8250_tx_chars(up);
 
 	spin_unlock_irqrestore(&port->lock, flags);
-- 
1.8.3.2

