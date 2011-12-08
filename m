From: Mayank Rana <mrana@codeaurora.org>
Subject: [PATCH 1/2] msm_serial_hs: Fix type inconsistency for tx and rx command_ptr_ptr
Date: Thu,  8 Dec 2011 09:06:08 +0530
Message-ID: <1323315369-19260-1-git-send-email-mrana@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: gregkh@suse.de
Cc: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, imirkin@alum.mit.edu, npelly@google.com, Mayank Rana <mrana@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Both tx and rx command_ptr_ptr are of type u32*. While allocating
memory for it, sizeof(u32 *) is used as part of kmalloc API instead
of sizeof(u32). ADM Hardare requires size of command_ptr_ptr as 1 Word.
Both sizeof(u32 *) and sizeof(u32) are same on 32-bit architecture
whereas sizeof(u32 *) would be different in size compare to sizeof(u32)
on anyother architecture.

Hence correct usage of sizeof(command_ptr_ptr) for Tx and Rx with
kmalloc and dma_(map/unmap)_single APIs.

Signed-off-by: Mayank Rana <mrana@codeaurora.org>
Reported-by: Ilia Mirkin <imirkin@alum.mit.edu>
---
 drivers/tty/serial/msm_serial_hs.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/msm_serial_hs.c b/drivers/tty/serial/msm_serial_hs.c
index 624701f..f1d5695 100644
--- a/drivers/tty/serial/msm_serial_hs.c
+++ b/drivers/tty/serial/msm_serial_hs.c
@@ -420,9 +420,9 @@ static int __devexit msm_hs_remove(struct platform_device *pdev)
 		      msm_uport->rx.rbuffer);
 	dma_pool_destroy(msm_uport->rx.pool);
 
-	dma_unmap_single(dev, msm_uport->rx.cmdptr_dmaaddr, sizeof(u32 *),
+	dma_unmap_single(dev, msm_uport->rx.cmdptr_dmaaddr, sizeof(u32),
 			 DMA_TO_DEVICE);
-	dma_unmap_single(dev, msm_uport->tx.mapped_cmd_ptr_ptr, sizeof(u32 *),
+	dma_unmap_single(dev, msm_uport->tx.mapped_cmd_ptr_ptr, sizeof(u32),
 			 DMA_TO_DEVICE);
 	dma_unmap_single(dev, msm_uport->tx.mapped_cmd_ptr, sizeof(dmov_box),
 			 DMA_TO_DEVICE);
@@ -810,7 +810,7 @@ static void msm_hs_submit_tx_locked(struct uart_port *uport)
 	*tx->command_ptr_ptr = CMD_PTR_LP | DMOV_CMD_ADDR(tx->mapped_cmd_ptr);
 
 	dma_sync_single_for_device(uport->dev, tx->mapped_cmd_ptr_ptr,
-				   sizeof(u32 *), DMA_TO_DEVICE);
+				   sizeof(u32), DMA_TO_DEVICE);
 
 	/* Save tx_count to use in Callback */
 	tx->tx_count = tx_count;
@@ -1535,7 +1535,7 @@ static int __devinit uartdm_init_port(struct uart_port *uport)
 	if (!tx->command_ptr)
 		return -ENOMEM;
 
-	tx->command_ptr_ptr = kmalloc(sizeof(u32 *), GFP_KERNEL | __GFP_DMA);
+	tx->command_ptr_ptr = kmalloc(sizeof(u32), GFP_KERNEL | __GFP_DMA);
 	if (!tx->command_ptr_ptr) {
 		ret = -ENOMEM;
 		goto err_tx_command_ptr_ptr;
@@ -1545,7 +1545,7 @@ static int __devinit uartdm_init_port(struct uart_port *uport)
 					    sizeof(dmov_box), DMA_TO_DEVICE);
 	tx->mapped_cmd_ptr_ptr = dma_map_single(uport->dev,
 						tx->command_ptr_ptr,
-						sizeof(u32 *), DMA_TO_DEVICE);
+						sizeof(u32), DMA_TO_DEVICE);
 	tx->xfer.cmdptr = DMOV_CMD_ADDR(tx->mapped_cmd_ptr_ptr);
 
 	init_waitqueue_head(&rx->wait);
@@ -1573,7 +1573,7 @@ static int __devinit uartdm_init_port(struct uart_port *uport)
 		goto err_rx_command_ptr;
 	}
 
-	rx->command_ptr_ptr = kmalloc(sizeof(u32 *), GFP_KERNEL | __GFP_DMA);
+	rx->command_ptr_ptr = kmalloc(sizeof(u32), GFP_KERNEL | __GFP_DMA);
 	if (!rx->command_ptr_ptr) {
 		pr_err("%s(): cannot allocate rx->command_ptr_ptr", __func__);
 		ret = -ENOMEM;
@@ -1591,7 +1591,7 @@ static int __devinit uartdm_init_port(struct uart_port *uport)
 	*rx->command_ptr_ptr = CMD_PTR_LP | DMOV_CMD_ADDR(rx->mapped_cmd_ptr);
 
 	rx->cmdptr_dmaaddr = dma_map_single(uport->dev, rx->command_ptr_ptr,
-					    sizeof(u32 *), DMA_TO_DEVICE);
+					    sizeof(u32), DMA_TO_DEVICE);
 	rx->xfer.cmdptr = DMOV_CMD_ADDR(rx->cmdptr_dmaaddr);
 
 	INIT_WORK(&rx->tty_work, msm_hs_tty_flip_buffer_work);
@@ -1607,7 +1607,7 @@ err_dma_pool_alloc:
 	dma_pool_destroy(msm_uport->rx.pool);
 err_dma_pool_create:
 	dma_unmap_single(uport->dev, msm_uport->tx.mapped_cmd_ptr_ptr,
-				sizeof(u32 *), DMA_TO_DEVICE);
+				sizeof(u32), DMA_TO_DEVICE);
 	dma_unmap_single(uport->dev, msm_uport->tx.mapped_cmd_ptr,
 				sizeof(dmov_box), DMA_TO_DEVICE);
 	kfree(msm_uport->tx.command_ptr_ptr);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
