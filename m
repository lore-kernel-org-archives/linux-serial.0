From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 04/75] Blackfin Serial Driver: Fix bug - BF527-EZKIT unable to
	receive large files over UART in DMA mode
Date: Fri, 02 Jan 2009 13:40:38 +0000
Message-ID: <20090102134036.13472.27828.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60274 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751895AbZABNkX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:40:23 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

Add spin_lock_irqsave() when receive and transfer data.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/bfin_5xx.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)


diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 88449d3..1c85039 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -81,7 +81,9 @@ static void bfin_serial_reset_irda(struct uart_port *port);
 static void bfin_serial_stop_tx(struct uart_port *port)
 {
 	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+#ifdef CONFIG_SERIAL_BFIN_DMA
 	struct circ_buf *xmit = &uart->port.info->xmit;
+#endif
 
 	while (!(UART_GET_LSR(uart) & TEMT))
 		cpu_relax();
@@ -412,7 +414,9 @@ static void bfin_serial_dma_rx_chars(struct bfin_serial_port *uart)
 
 void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
 {
-	int x_pos, pos;
+	int x_pos, pos, flags;
+
+	spin_lock_irqsave(&uart->port.lock, flags);
 
 	uart->rx_dma_nrows = get_dma_curr_ycount(uart->rx_dma_channel);
 	x_pos = get_dma_curr_xcount(uart->rx_dma_channel);
@@ -430,6 +434,8 @@ void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
 		uart->rx_dma_buf.tail = uart->rx_dma_buf.head;
 	}
 
+	spin_unlock_irqrestore(&uart->port.lock, flags);
+
 	mod_timer(&(uart->rx_dma_timer), jiffies + DMA_RX_FLUSH_JIFFIES);
 }
 
@@ -464,10 +470,9 @@ static irqreturn_t bfin_serial_dma_rx_int(int irq, void *dev_id)
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

