From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] tty: xuartps: Fix tx_emtpy() callback
Date: Fri,  5 Sep 2014 09:45:17 +0200
Message-ID: <1409903117-22021-1-git-send-email-lars@metafoo.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out-219.synserver.de ([212.40.185.219]:1047 "EHLO
	smtp-out-219.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbaIEHvH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Sep 2014 03:51:07 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

The tx_empty() callback currently checks the TXEMPTY bit in the interrupt
status register to decided whether the FIFO should be reported as empty or
not. The bit in this register gets set when the FIFO state transitions from
non-empty to empty but is cleared again in the interrupt handler. This means
it is not suitable to be used to decided whether the FIFO is currently empty
or not. Instead use the TXEMPTY bit from the status register which will be
set as long as the FIFO is empty.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 01951d2..806e4bc 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -581,7 +581,7 @@ static unsigned int cdns_uart_tx_empty(struct uart_port *port)
 {
 	unsigned int status;
 
-	status = cdns_uart_readl(CDNS_UART_ISR_OFFSET) & CDNS_UART_IXR_TXEMPTY;
+	status = cdns_uart_readl(CDNS_UART_SR_OFFSET) & CDNS_UART_SR_TXEMPTY;
 	return status ? TIOCSER_TEMT : 0;
 }
 
-- 
1.8.0

