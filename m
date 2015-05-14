From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 3/6] serial: sirf: fix endless loop bug in uart receive tasklet
Date: Thu, 14 May 2015 06:45:23 +0000
Message-ID: <1431585926-10746-3-git-send-email-21cnbao@gmail.com>
References: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: Qipan Li <Qipan.Li@csr.com>, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: linux-serial@vger.kernel.org

From: Qipan Li <Qipan.Li@csr.com>

In special condition, when cpu schedule into rx_tmo_process_tl or
rx_dma_complete_tl and all the receive dma tasks have done, it will
go into endless loop because no dma task cookie status be changed.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 48cceaf..ffeb766 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -488,6 +488,7 @@ static void sirfsoc_rx_tmo_process_tl(unsigned long param)
 	unsigned int count;
 	struct dma_tx_state tx_state;
 	unsigned long flags;
+	int i = 0;
 
 	spin_lock_irqsave(&port->lock, flags);
 	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
@@ -497,6 +498,9 @@ static void sirfsoc_rx_tmo_process_tl(unsigned long param)
 					SIRFSOC_RX_DMA_BUF_SIZE);
 		sirfport->rx_completed++;
 		sirfport->rx_completed %= SIRFSOC_RX_LOOP_BUF_CNT;
+		i++;
+		if (i > SIRFSOC_RX_LOOP_BUF_CNT)
+			break;
 	}
 	count = CIRC_CNT(sirfport->rx_dma_items[sirfport->rx_issued].xmit.head,
 		sirfport->rx_dma_items[sirfport->rx_issued].xmit.tail,
@@ -713,6 +717,8 @@ static void sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	struct dma_tx_state tx_state;
 	unsigned long flags;
+	int i = 0;
+
 	spin_lock_irqsave(&port->lock, flags);
 	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
 		sirfport->rx_dma_items[sirfport->rx_completed].cookie,
@@ -726,6 +732,9 @@ static void sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
 		else
 			sirfport->rx_completed++;
 		sirfport->rx_completed %= SIRFSOC_RX_LOOP_BUF_CNT;
+		i++;
+		if (i > SIRFSOC_RX_LOOP_BUF_CNT)
+			break;
 	}
 	spin_unlock_irqrestore(&port->lock, flags);
 	tty_flip_buffer_push(&port->state->port);
-- 
2.3.5
