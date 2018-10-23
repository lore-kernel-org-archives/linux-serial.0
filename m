From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] pch_uart: remove set but not used variable 'tx_empty'
Date: Tue, 23 Oct 2018 21:21:34 +0800
Message-ID: <1540300894-27202-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

tx_empty is not used after setting its value. It is safe to remove
the unused variable.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/tty/serial/pch_uart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index cb85002..9ed121f 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -933,7 +933,6 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 	struct scatterlist *sg;
 	int nent;
 	int fifo_size;
-	int tx_empty;
 	struct dma_async_tx_descriptor *desc;
 	int num;
 	int i;
@@ -958,11 +957,9 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 	}
 
 	fifo_size = max(priv->fifo_size, 1);
-	tx_empty = 1;
 	if (pop_tx_x(priv, xmit->buf)) {
 		pch_uart_hal_write(priv, xmit->buf, 1);
 		port->icount.tx++;
-		tx_empty = 0;
 		fifo_size--;
 	}
 
-- 
1.7.12.4
