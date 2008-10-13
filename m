From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 5/6] Blackfin Serial Driver: Fix bug - BF527-EZKIT unable to receive large files over UART in DMA mode
Date: Mon, 13 Oct 2008 17:46:24 +0800
Message-ID: <1223891185-13924-6-git-send-email-cooloney@kernel.org>
References: <1223891185-13924-1-git-send-email-cooloney@kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:33171 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763278AbYJMJpw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Oct 2008 05:45:52 -0400
In-Reply-To: <1223891185-13924-1-git-send-email-cooloney@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Bryan Wu <cooloney@kernel.org>

From: Sonic Zhang <sonic.zhang@analog.com>

Add spin_lock_irqsave() when receive and transfer data.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/serial/bfin_5xx.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 44a0855..82854d7 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -82,7 +82,9 @@ static void bfin_serial_reset_irda(struct uart_port *port);
 static void bfin_serial_stop_tx(struct uart_port *port)
 {
 	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+#ifdef CONFIG_SERIAL_BFIN_DMA
 	struct circ_buf *xmit = &uart->port.info->xmit;
+#endif
 
 	while (!(UART_GET_LSR(uart) & TEMT))
 		cpu_relax();
@@ -413,7 +415,9 @@ static void bfin_serial_dma_rx_chars(struct bfin_serial_port *uart)
 
 void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
 {
-	int x_pos, pos;
+	int x_pos, pos, flags;
+
+	spin_lock_irqsave(&uart->port.lock, flags);
 
 	uart->rx_dma_nrows = get_dma_curr_ycount(uart->rx_dma_channel);
 	x_pos = get_dma_curr_xcount(uart->rx_dma_channel);
@@ -431,6 +435,8 @@ void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
 		uart->rx_dma_buf.tail = uart->rx_dma_buf.head;
 	}
 
+	spin_unlock_irqrestore(&uart->port.lock, flags);
+
 	mod_timer(&(uart->rx_dma_timer), jiffies + DMA_RX_FLUSH_JIFFIES);
 }
 
@@ -465,10 +471,9 @@ static irqreturn_t bfin_serial_dma_rx_int(int irq, void *dev_id)
 	spin_lock(&uart->port.lock);
 	irqstat = get_dma_curr_irqstat(uart->rx_dma_channel);
 	clear_dma_irqstat(uart->rx_dma_channel);
+	bfin_serial_dma_rx_chars(uart);
 	spin_unlock(&uart->port.lock);
 
-	mod_timer(&(uart->rx_dma_timer), jiffies);
-
 	return IRQ_HANDLED;
 }
 #endif
-- 
1.5.6
