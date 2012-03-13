From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] serial: bfin-uart: Don't access tty circular buffer in TX DMA interrupt after it is reset.
Date: Tue, 13 Mar 2012 15:51:55 +0800
Message-ID: <1331625115-28850-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:6271 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758953Ab2CMH7R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Mar 2012 03:59:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

When kernel reboot, tty circular buffer is reset before last TX DMA interrupt is called,
while the buffer tail is updated in TX DMA interrupt handler. So, don't update the buffer
tail if it is reset.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_uart.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 5856407..a92626a 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -537,11 +537,13 @@ static irqreturn_t bfin_serial_dma_tx_int(int irq, void *dev_id)
 		 *		when start a new tx.
 		 */
 		UART_CLEAR_IER(uart, ETBEI);
-		xmit->tail = (xmit->tail + uart->tx_count) & (UART_XMIT_SIZE - 1);
 		uart->port.icount.tx += uart->tx_count;
+		if (!uart_circ_empty(xmit)) {
+			xmit->tail = (xmit->tail + uart->tx_count) & (UART_XMIT_SIZE - 1);
 
-		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-			uart_write_wakeup(&uart->port);
+			if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+				uart_write_wakeup(&uart->port);
+		}
 
 		bfin_serial_dma_tx_chars(uart);
 	}
-- 
1.7.0.4


