From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 2/4] serial: bfin_uart: narrow the reboot condition in DMA tx interrupt
Date: Wed, 16 May 2012 14:22:24 +0800
Message-ID: <1337149346-5277-2-git-send-email-sonic.adi@gmail.com>
References: <1337149346-5277-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:7723 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755584Ab2EPGdY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 May 2012 02:33:24 -0400
In-Reply-To: <1337149346-5277-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Check if xmit buffer pointers are set to zero.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 9acab11..56b95b0 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -532,7 +532,7 @@ static irqreturn_t bfin_serial_dma_tx_int(int irq, void *dev_id)
 		 */
 		UART_CLEAR_IER(uart, ETBEI);
 		uart->port.icount.tx += uart->tx_count;
-		if (!uart_circ_empty(xmit)) {
+		if (!(xmit->tail == 0 && xmit->head == 0)) {
 			xmit->tail = (xmit->tail + uart->tx_count) & (UART_XMIT_SIZE - 1);
 
 			if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-- 
1.7.0.4


