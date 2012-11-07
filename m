From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] serial: bfin-uart: avoid dead lock in rx irq handler in smp kernel
Date: Wed, 7 Nov 2012 13:27:56 +0800
Message-ID: <1352266076-31683-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:23129 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750747Ab2KGF26 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Nov 2012 00:28:58 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Steven Miao <realmz6@gmail.com>, Sonic Zhang <sonic.zhang@analog.com>

From: Steven Miao <realmz6@gmail.com>

Disabing dma irq and lock bottom half in smp kernel doesn't ensure exclusive
uart access. Call spin_lock_irqsave() instead.

Signed-off-by: Steven Miao <realmz6@gmail.com>
Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_uart.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 71c0c09..870a744 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -477,9 +477,9 @@ static void bfin_serial_dma_rx_chars(struct bfin_serial_port *uart)
 void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
 {
 	int x_pos, pos;
+	unsigned long flags;
 
-	dma_disable_irq_nosync(uart->rx_dma_channel);
-	spin_lock_bh(&uart->rx_lock);
+	spin_lock_irqsave(&uart->rx_lock, flags);
 
 	/* 2D DMA RX buffer ring is used. Because curr_y_count and
 	 * curr_x_count can't be read as an atomic operation,
@@ -510,8 +510,7 @@ void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
 		uart->rx_dma_buf.tail = uart->rx_dma_buf.head;
 	}
 
-	spin_unlock_bh(&uart->rx_lock);
-	dma_enable_irq(uart->rx_dma_channel);
+	spin_unlock_irqrestore(&uart->rx_lock, flags);
 
 	mod_timer(&(uart->rx_dma_timer), jiffies + DMA_RX_FLUSH_JIFFIES);
 }
-- 
1.7.0.4


