From: Chanho Min <chanho.min@lge.com>
Subject: [PATCH] tty: amba-pl011: use sg_table instead of scatterlist
Date: Tue, 8 Mar 2016 11:43:36 +0900
Message-ID: <1457405016-23562-1-git-send-email-chanho.min@lge.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jongsung Kim <neidhard.kim@lge.com>, Gunho Lee <gunho.lee@lge.com>, Chanho Min <chanho.min@lge.com>
List-Id: linux-serial@vger.kernel.org

The use of phys_to_page is wrong in commit cb06ff102e2d ("ARM: PL011:
Add support for Rx DMA buffer polling."), beacase DMA address is not
physical address. Also, phys_to_page is not declared in some architecture.
The use of virt_to_page is wrong as well because dma_alloc_coherent
implementaion are allowed to returned remapped memory. So I use sg_table
instead of scatterlist and change to dma_get_sgtable() implementaion.

Reported-by: Wang, Annie <Annie.Wang@amd.com>
Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 drivers/tty/serial/amba-pl011.c |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c0da0cc..ce8840f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -197,7 +197,7 @@ static struct vendor_data vendor_zte = {
 /* Deals with DMA transactions */
 
 struct pl011_sgbuf {
-	struct scatterlist sg;
+	struct sg_table sgt;
 	char *buf;
 };
 
@@ -344,17 +344,23 @@ static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
 	enum dma_data_direction dir)
 {
 	dma_addr_t dma_addr;
+	int ret;
 
 	sg->buf = dma_alloc_coherent(chan->device->dev,
 		PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
 	if (!sg->buf)
 		return -ENOMEM;
 
-	sg_init_table(&sg->sg, 1);
-	sg_set_page(&sg->sg, phys_to_page(dma_addr),
-		PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
-	sg_dma_address(&sg->sg) = dma_addr;
-	sg_dma_len(&sg->sg) = PL011_DMA_BUFFER_SIZE;
+	ret = dma_get_sgtable(chan->device->dev, &sg->sgt, sg->buf, dma_addr,
+		PL011_DMA_BUFFER_SIZE);
+
+	if (ret < 0) {
+		dma_free_coherent(chan->device->dev,
+			PL011_DMA_BUFFER_SIZE, sg->buf, dma_addr);
+		return -ENOMEM;
+	}
+	sg_dma_address(sg->sgt.sgl) = dma_addr;
+	sg_dma_len(sg->sgt.sgl) = PL011_DMA_BUFFER_SIZE;
 
 	return 0;
 }
@@ -365,7 +371,8 @@ static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
 	if (sg->buf) {
 		dma_free_coherent(chan->device->dev,
 			PL011_DMA_BUFFER_SIZE, sg->buf,
-			sg_dma_address(&sg->sg));
+			sg_dma_address(sg->sgt.sgl));
+		sg_free_table(&sg->sgt);
 	}
 }
 
@@ -813,7 +820,7 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
 	/* Start the RX DMA job */
 	sgbuf = uap->dmarx.use_buf_b ?
 		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
-	desc = dmaengine_prep_slave_sg(rxchan, &sgbuf->sg, 1,
+	desc = dmaengine_prep_slave_sg(rxchan, sgbuf->sgt.sgl, 1,
 					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	/*
@@ -863,7 +870,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	if (uap->dmarx.poll_rate) {
 		/* The data can be taken by polling */
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = sgbuf->sgt.sgl->length - dmarx->last_residue;
 		/* Recalculate the pending size */
 		if (pending >= dmataken)
 			pending -= dmataken;
@@ -888,7 +895,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	/* Reset the last_residue for Rx DMA poll */
 	if (uap->dmarx.poll_rate)
-		dmarx->last_residue = sgbuf->sg.length;
+		dmarx->last_residue = sgbuf->sgt.sgl->length;
 
 	/*
 	 * Only continue with trying to read the FIFO if all DMA chars have
@@ -948,7 +955,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 	pl011_write(uap->dmacr, uap, REG_DMACR);
 	uap->dmarx.running = false;
 
-	pending = sgbuf->sg.length - state.residue;
+	pending = sgbuf->sgt.sgl->length - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -994,7 +1001,7 @@ static void pl011_dma_rx_callback(void *data)
 	 * the DMA irq handler. So we check the residue here.
 	 */
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
-	pending = sgbuf->sg.length - state.residue;
+	pending = sgbuf->sgt.sgl->length - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1050,7 +1057,7 @@ static void pl011_dma_rx_poll(unsigned long args)
 	sgbuf = dmarx->use_buf_b ? &uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
 	if (likely(state.residue < dmarx->last_residue)) {
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = sgbuf->sgt.sgl->length - dmarx->last_residue;
 		size = dmarx->last_residue - state.residue;
 		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
 				size);
-- 
1.7.9.5
