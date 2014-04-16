From: Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] 8250_core: Fix unwanted TX chars write
Date: Wed, 16 Apr 2014 18:48:51 +0200
Message-ID: <1397666931-13605-1-git-send-email-loic.poulain@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56377 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590AbaDPQxj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Apr 2014 12:53:39 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Loic Poulain <loic.poulain@intel.com>

On transmit-hold-register empty, serial8250_tx_chars
should be called only if we don't use DMA.
DMA has its own tx cycle.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
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

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

