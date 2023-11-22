Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BxhD410S"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4072B2
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 23:47:05 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40F652000B;
	Wed, 22 Nov 2023 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700639224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bw9eQHXICnZa9WS4MUK/n25wTrPCu4UW2be93dq6pP8=;
	b=BxhD410SGcmQIQiDeuS5nCLQBSd0qlor582NffObG6r8cB761IybqhvnZYGP3XMexcEbHo
	Zb6Pm0v6QDhvcYRQ0OajGxNC2OxhF8YumeW2fOgCmH+LoYuvP4ubWtSNv6+fjJFQtF6DQP
	1u96W1ZRHdrOiTi8wTgT2zGBM+EUwrrZRMqy/fKO2pRaURgRlaenxfqcV/LUg51K+4VCHO
	mLwmIzrlppG2NWNXWsZ3uROq8PDzhZZglLOwvyAJCZJ5+S1uQlMI9UavheAN5nyX7iJi3O
	jpmD7mPNCI3QCKAF3jKgE1NoM4Ea1imUlyl2lqp9Ilx0gt8Sd3TVhQ52Aenz5Q==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-serial@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] ARM: PL011: Fix DMA support
Date: Wed, 22 Nov 2023 08:45:35 +0100
Message-ID: <20231122074535.184384-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

From: Arnd Bergmann <arnd@arndb.de>

Since there is no guarantee that the memory returned by
dma_alloc_coherent() is associated with a 'struct page', using the
architecture specific phys_to_page() is wrong, but using
virt_to_page() would be as well.

Stop using sg lists altogether and just use the *_single() functions
instead. This also simplifies the code a bit since the scatterlists in
this driver always have only one entry anyway.

gcl: Add a commit log from the initial thread:
https://lore.kernel.org/lkml/86db0fe5-930d-4cbb-bd7d-03367da38951@app.fastmail.com/

Fixes: cb06ff102e2d7 ("ARM: PL011: Add support for Rx DMA buffer polling.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 62 +++++++++++++++------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 61cc24cd90e4b..73a1c40148c25 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -219,8 +219,9 @@ static struct vendor_data vendor_st = {
 /* Deals with DMA transactions */
 
 struct pl011_sgbuf {
-	struct scatterlist sg;
-	char *buf;
+	dma_addr_t		dma;
+	size_t			len;
+	char			*buf;
 };
 
 struct pl011_dmarx_data {
@@ -241,7 +242,8 @@ struct pl011_dmarx_data {
 
 struct pl011_dmatx_data {
 	struct dma_chan		*chan;
-	struct scatterlist	sg;
+	dma_addr_t		dma;
+	size_t			len;
 	char			*buf;
 	bool			queued;
 };
@@ -369,18 +371,11 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
 	enum dma_data_direction dir)
 {
-	dma_addr_t dma_addr;
-
-	sg->buf = dma_alloc_coherent(chan->device->dev,
-		PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
+	sg->buf = dma_alloc_coherent(chan->device->dev, PL011_DMA_BUFFER_SIZE,
+				     &sg->dma, GFP_KERNEL);
 	if (!sg->buf)
 		return -ENOMEM;
-
-	sg_init_table(&sg->sg, 1);
-	sg_set_page(&sg->sg, phys_to_page(dma_addr),
-		PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
-	sg_dma_address(&sg->sg) = dma_addr;
-	sg_dma_len(&sg->sg) = PL011_DMA_BUFFER_SIZE;
+	sg->len = PL011_DMA_BUFFER_SIZE;
 
 	return 0;
 }
@@ -390,8 +385,7 @@ static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
 {
 	if (sg->buf) {
 		dma_free_coherent(chan->device->dev,
-			PL011_DMA_BUFFER_SIZE, sg->buf,
-			sg_dma_address(&sg->sg));
+				  PL011_DMA_BUFFER_SIZE, sg->buf, sg->dma);
 	}
 }
 
@@ -552,8 +546,8 @@ static void pl011_dma_tx_callback(void *data)
 
 	uart_port_lock_irqsave(&uap->port, &flags);
 	if (uap->dmatx.queued)
-		dma_unmap_sg(dmatx->chan->device->dev, &dmatx->sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
+				dmatx->len, DMA_TO_DEVICE);
 
 	dmacr = uap->dmacr;
 	uap->dmacr = dmacr & ~UART011_TXDMAE;
@@ -639,18 +633,19 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 			memcpy(&dmatx->buf[first], &xmit->buf[0], second);
 	}
 
-	dmatx->sg.length = count;
-
-	if (dma_map_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE) != 1) {
+	dmatx->len = count;
+	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
+				    DMA_TO_DEVICE);
+	if (dmatx->dma == DMA_MAPPING_ERROR) {
 		uap->dmatx.queued = false;
 		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
 		return -EBUSY;
 	}
 
-	desc = dmaengine_prep_slave_sg(chan, &dmatx->sg, 1, DMA_MEM_TO_DEV,
+	desc = dmaengine_prep_slave_single(chan, dmatx->dma, dmatx->len, DMA_MEM_TO_DEV,
 					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
-		dma_unmap_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE);
+		dma_unmap_single(dma_dev->dev, dmatx->dma, dmatx->len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		/*
 		 * If DMA cannot be used right now, we complete this
@@ -813,8 +808,8 @@ __acquires(&uap->port.lock)
 	dmaengine_terminate_async(uap->dmatx.chan);
 
 	if (uap->dmatx.queued) {
-		dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(uap->dmatx.chan->device->dev, uap->dmatx.dma,
+				 uap->dmatx.len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
 		pl011_write(uap->dmacr, uap, REG_DMACR);
@@ -836,7 +831,7 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
 	/* Start the RX DMA job */
 	sgbuf = uap->dmarx.use_buf_b ?
 		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
-	desc = dmaengine_prep_slave_sg(rxchan, &sgbuf->sg, 1,
+	desc = dmaengine_prep_slave_single(rxchan, sgbuf->dma, sgbuf->len,
 					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	/*
@@ -886,7 +881,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	if (uap->dmarx.poll_rate) {
 		/* The data can be taken by polling */
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = sgbuf->len - dmarx->last_residue;
 		/* Recalculate the pending size */
 		if (pending >= dmataken)
 			pending -= dmataken;
@@ -911,7 +906,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	/* Reset the last_residue for Rx DMA poll */
 	if (uap->dmarx.poll_rate)
-		dmarx->last_residue = sgbuf->sg.length;
+		dmarx->last_residue = sgbuf->len;
 
 	/*
 	 * Only continue with trying to read the FIFO if all DMA chars have
@@ -969,7 +964,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 	pl011_write(uap->dmacr, uap, REG_DMACR);
 	uap->dmarx.running = false;
 
-	pending = sgbuf->sg.length - state.residue;
+	pending = sgbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1015,7 +1010,7 @@ static void pl011_dma_rx_callback(void *data)
 	 * the DMA irq handler. So we check the residue here.
 	 */
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
-	pending = sgbuf->sg.length - state.residue;
+	pending = sgbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1074,7 +1069,7 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	sgbuf = dmarx->use_buf_b ? &uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
 	if (likely(state.residue < dmarx->last_residue)) {
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = sgbuf->len - dmarx->last_residue;
 		size = dmarx->last_residue - state.residue;
 		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
 				size);
@@ -1123,7 +1118,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		return;
 	}
 
-	sg_init_one(&uap->dmatx.sg, uap->dmatx.buf, PL011_DMA_BUFFER_SIZE);
+	uap->dmatx.len = PL011_DMA_BUFFER_SIZE;
 
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
@@ -1200,8 +1195,9 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
 		dmaengine_terminate_all(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
-			dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-				     DMA_TO_DEVICE);
+			dma_unmap_single(uap->dmatx.chan->device->dev,
+					 uap->dmatx.dma, uap->dmatx.len,
+					 DMA_TO_DEVICE);
 			uap->dmatx.queued = false;
 		}
 
-- 
2.42.0

