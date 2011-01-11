From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] serial: bfin_5xx: split uart RX lock from uart port lock to avoid deadlock
Date: Tue, 11 Jan 2011 00:16:43 -0500
Message-ID: <1294723003-8496-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:38830 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab1AKFJD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Jan 2011 00:09:03 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

The RX lock is used to protect the RX buffer from concurrent access in DMA
mode between the timer and RX interrupt routines.  It is independent from
the uart lock which is used to protect the TX buffer.  It is possible for
a uart TX transfer to be started up from the RX interrupt handler if low
latency is enabled.  So we need to split the locks to avoid deadlocking in
this situation.

In PIO mode, the RX lock is not necessary because the handle_simple_irq
and handle_level_irq functions ensure driver interrupt handlers are called
once on one core.

And now that the RX path has its own lock, the TX interrupt has nothing to
do with the RX path, so disabling it at the same time.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 arch/blackfin/include/asm/bfin_serial.h |    2 ++
 drivers/serial/bfin_5xx.c               |   15 ++++++---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/blackfin/include/asm/bfin_serial.h b/arch/blackfin/include/asm/bfin_serial.h
index 1ff9f14..7dbc664 100644
--- a/arch/blackfin/include/asm/bfin_serial.h
+++ b/arch/blackfin/include/asm/bfin_serial.h
@@ -10,6 +10,7 @@
 #define __BFIN_ASM_SERIAL_H__
 
 #include <linux/serial_core.h>
+#include <linux/spinlock.h>
 #include <mach/anomaly.h>
 #include <mach/bfin_serial.h>
 
@@ -41,6 +42,7 @@ struct bfin_serial_port {
 	struct circ_buf rx_dma_buf;
 	struct timer_list rx_dma_timer;
 	int rx_dma_nrows;
+	spinlock_t rx_lock;
 	unsigned int tx_dma_channel;
 	unsigned int rx_dma_channel;
 	struct work_struct tx_dma_workqueue;
diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index e381b89..9b1ff2b 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -370,10 +370,8 @@ static irqreturn_t bfin_serial_rx_int(int irq, void *dev_id)
 {
 	struct bfin_serial_port *uart = dev_id;
 
-	spin_lock(&uart->port.lock);
 	while (UART_GET_LSR(uart) & DR)
 		bfin_serial_rx_chars(uart);
-	spin_unlock(&uart->port.lock);
 
 	return IRQ_HANDLED;
 }
@@ -490,9 +488,8 @@ void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
 {
 	int x_pos, pos;
 
-	dma_disable_irq(uart->tx_dma_channel);
-	dma_disable_irq(uart->rx_dma_channel);
-	spin_lock_bh(&uart->port.lock);
+	dma_disable_irq_nosync(uart->rx_dma_channel);
+	spin_lock_bh(&uart->rx_lock);
 
 	/* 2D DMA RX buffer ring is used. Because curr_y_count and
 	 * curr_x_count can't be read as an atomic operation,
@@ -523,8 +520,7 @@ void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
 		uart->rx_dma_buf.tail = uart->rx_dma_buf.head;
 	}
 
-	spin_unlock_bh(&uart->port.lock);
-	dma_enable_irq(uart->tx_dma_channel);
+	spin_unlock_bh(&uart->rx_lock);
 	dma_enable_irq(uart->rx_dma_channel);
 
 	mod_timer(&(uart->rx_dma_timer), jiffies + DMA_RX_FLUSH_JIFFIES);
@@ -571,7 +567,7 @@ static irqreturn_t bfin_serial_dma_rx_int(int irq, void *dev_id)
 	unsigned short irqstat;
 	int x_pos, pos;
 
-	spin_lock(&uart->port.lock);
+	spin_lock(&uart->rx_lock);
 	irqstat = get_dma_curr_irqstat(uart->rx_dma_channel);
 	clear_dma_irqstat(uart->rx_dma_channel);
 
@@ -589,7 +585,7 @@ static irqreturn_t bfin_serial_dma_rx_int(int irq, void *dev_id)
 		uart->rx_dma_buf.tail = uart->rx_dma_buf.head;
 	}
 
-	spin_unlock(&uart->port.lock);
+	spin_unlock(&uart->rx_lock);
 
 	return IRQ_HANDLED;
 }
@@ -1332,6 +1328,7 @@ static int bfin_serial_probe(struct platform_device *pdev)
 		}
 
 #ifdef CONFIG_SERIAL_BFIN_DMA
+		spin_lock_init(&uart->rx_lock);
 		uart->tx_done	    = 1;
 		uart->tx_count	    = 0;
 
-- 
1.7.4.rc1

