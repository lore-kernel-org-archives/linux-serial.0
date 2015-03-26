From: Hao Liang <hliang1025@gmail.com>
Subject: [PATCH] bfin uart: it will hang when read current y count if not disable dma irq
Date: Thu, 26 Mar 2015 17:13:24 +0800
Message-ID: <1427361205-31801-1-git-send-email-hliang1025@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sonic.zhang@analog.com, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: adi-buildroot-devel@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, hliang1025@gmail.com
List-Id: linux-serial@vger.kernel.org

Add irq disable and enable in bfin_serial_rx_dma_timeout in case of
system hang.

This reverts part of commit 9642dbe73c8a ("serial: bfin-uart: avoid
dead lock in rx irq handler in smp kernel").

Signed-off-by: Hao Liang <hliang1025@gmail.com>
---
 drivers/tty/serial/bfin_uart.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 43b3e2c..155781e 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -464,6 +464,7 @@ void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
 	int x_pos, pos;
 	unsigned long flags;
 
+	dma_disable_irq_nosync(uart->rx_dma_channel);
 	spin_lock_irqsave(&uart->rx_lock, flags);
 
 	/* 2D DMA RX buffer ring is used. Because curr_y_count and
@@ -496,6 +497,7 @@ void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
 	}
 
 	spin_unlock_irqrestore(&uart->rx_lock, flags);
+	dma_enable_irq(uart->rx_dma_channel);
 
 	mod_timer(&(uart->rx_dma_timer), jiffies + DMA_RX_FLUSH_JIFFIES);
 }
-- 
1.7.9.5
