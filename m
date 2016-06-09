From: Nandor Han <nandor.han@ge.com>
Subject: [PATCH RFC 3/4] serial: imx-serial - update UART IMX driver to use cyclic DMA
Date: Thu,  9 Jun 2016 15:16:32 +0300
Message-ID: <110846490870c26c39bbd05245494793f92e23f1.1465456640.git.nandor.han@ge.com>
References: <cover.1465456639.git.nandor.han@ge.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1465456639.git.nandor.han@ge.com>
In-Reply-To: <cover.1465456639.git.nandor.han@ge.com>
References: <cover.1465456639.git.nandor.han@ge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Nandor Han <nandor.han@ge.com>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The IMX UART has a 32 bytes HW buffer which can be filled up in
2777us at 115200 baud or 80us at 4Mbaud (supported by IMX53).
Taking this in consideration there is a good probability to lose
data because of the DMA startup latency.
Our tests (explained below) indicates a latency up to 4400us when
creating interrupt load and ~70us without. When creating interrupt
load I was able to see continuous overrun errors by checking serial
driver statistics using the command:
`cat /proc/tty/driver/IMX-uart`.

Replace manual restart of DMA with cyclic DMA to eliminate data loss
due to DMA engine startup latency (similar approch to atmel_serial.c
driver). As result the DMA engine will start on the first serial data
transfer and stops only when serial port is closed.

Tests environment:
 Using the m53evk board I have used a GPIO for profiling the IMX
 serial driver.
  - The RX line and GPIO were connected to oscilloscope.
  - Run a small test program on the m53evk board that will only open
    and read data from ttymxc2 port.
  - Connect the ttymxc2 port to my laptop using a USB serial converter
    where another test program is running, able to send configurable
    packet lengths and intervals.
  - Serial ports configured at 115200 8N1.
  - Interrupts load created by disconnecting/connecting (3s interval)
    a USB hub, using a digital switch, with 4 USB devices (USB-Serial
    converter, USB SD card, etc) connected.
    (around 160 interrupts/second generated)
  - The GPIO was toggled HI in the `imx_int` when USR1_RRDY or USR1_AGTIM
    events are received and toggled back, once the DMA configuration
    is finalized, at the end of `imx_dma_rxint`.

Measurements:
The measurements were done from the end of the last byte (RX line) until
the GPIO was toggled back LOW.

Note: The GPIO toggling was done using `gpiod_set_value` method.

Tests performed:
   1. Sending 9 bytes packets at 8ms interval. Having the 9 bytes packets
      will activate the RRDY threshold event and IMX serial interrupt
      called.
      Results:
        - DMA start latency (interrupt start latency +
           DMA configuration) consistently 70us when system not loaded.
        - DMA start latency up to 4400us when system loaded.
   2. Sending 40 bytes packet at 8mS interval.
      Results with load:
        - Able to observe overruns by running:
           `watch -n1 cat /proc/tty/driver/IMX-uart`

Signed-off-by: Nandor Han <nandor.han@ge.com>
---
 drivers/tty/serial/imx.c | 141 ++++++++++++++++++++++++++---------------------
 1 file changed, 78 insertions(+), 63 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0df2b1c..1912136 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -222,6 +222,9 @@ struct imx_port {
 	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
 	struct scatterlist	rx_sgl, tx_sgl[2];
 	void			*rx_buf;
+	struct circ_buf		rx_ring;
+	unsigned int		rx_periods;
+	dma_cookie_t		rx_cookie;
 	unsigned int		tx_bytes;
 	unsigned int		dma_tx_nents;
 	wait_queue_head_t	dma_wait;
@@ -932,30 +935,6 @@ static void imx_timeout(unsigned long data)
 }
 
 #define RX_BUF_SIZE	(PAGE_SIZE)
-static void imx_rx_dma_done(struct imx_port *sport)
-{
-	unsigned long temp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sport->port.lock, flags);
-
-	/* re-enable interrupts to get notified when new symbols are incoming */
-	temp = readl(sport->port.membase + UCR1);
-	temp |= UCR1_RRDYEN;
-	writel(temp, sport->port.membase + UCR1);
-
-	temp = readl(sport->port.membase + UCR2);
-	temp |= UCR2_ATEN;
-	writel(temp, sport->port.membase + UCR2);
-
-	sport->dma_is_rxing = 0;
-
-	/* Is the shutdown waiting for us? */
-	if (waitqueue_active(&sport->dma_wait))
-		wake_up(&sport->dma_wait);
-
-	spin_unlock_irqrestore(&sport->port.lock, flags);
-}
 
 /*
  * There are two kinds of RX DMA interrupts(such as in the MX6Q):
@@ -972,43 +951,75 @@ static void dma_rx_callback(void *data)
 	struct scatterlist *sgl = &sport->rx_sgl;
 	struct tty_port *port = &sport->port.state->port;
 	struct dma_tx_state state;
+	struct circ_buf *rx_ring = &sport->rx_ring;
 	enum dma_status status;
-	unsigned int count;
-
-	/* unmap it first */
-	dma_unmap_sg(sport->port.dev, sgl, 1, DMA_FROM_DEVICE);
+	unsigned int w_bytes = 0;
+	unsigned int r_bytes;
+	unsigned int bd_size;
 
 	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
-	count = RX_BUF_SIZE - state.residue;
 
-	dev_dbg(sport->port.dev, "We get %d bytes.\n", count);
+	if (status == DMA_ERROR) {
+		dev_err(sport->port.dev, "DMA transaction error.\n");
+		return;
+	}
+
+	if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ)) {
+
+		/*
+		 * The state-residue variable represents the empty space
+		 * relative to the entire buffer. Taking this in consideration
+		 * the head is always calculated base on the buffer total
+		 * length - DMA transaction residue. The UART script from the
+		 * SDMA firmware will jump to the next buffer descriptor,
+		 * once a DMA transaction if finalized (IMX53 RM - A.4.1.2.4).
+		 * Taking this in consideration the tail is always at the
+		 * beginning of the buffer descriptor that contains the head.
+		 */
+
+		/* Calculate the head */
+		rx_ring->head = sg_dma_len(sgl) - state.residue;
+
+		/* Calculate the tail. */
+		bd_size = sg_dma_len(sgl) / sport->rx_periods;
+		rx_ring->tail = ((rx_ring->head-1) / bd_size) * bd_size;
+
+		if (rx_ring->head <= sg_dma_len(sgl) &&
+		    rx_ring->head > rx_ring->tail) {
+
+			/* Move data from tail to head */
+			r_bytes = rx_ring->head - rx_ring->tail;
+
+			/* CPU claims ownership of RX DMA buffer */
+			dma_sync_sg_for_cpu(sport->port.dev, sgl, 1,
+				DMA_FROM_DEVICE);
 
-	if (count) {
-		if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ)) {
-			int bytes = tty_insert_flip_string(port, sport->rx_buf,
-					count);
+			w_bytes = tty_insert_flip_string(port,
+				sport->rx_buf + rx_ring->tail, r_bytes);
 
-			if (bytes != count)
+			/* UART retrieves ownership of RX DMA buffer */
+			dma_sync_sg_for_device(sport->port.dev, sgl, 1,
+				DMA_FROM_DEVICE);
+
+			if (w_bytes != r_bytes)
 				sport->port.icount.buf_overrun++;
+
+			sport->port.icount.rx += w_bytes;
+		} else	{
+			WARN_ON(rx_ring->head > sg_dma_len(sgl));
+			WARN_ON(rx_ring->head <= rx_ring->tail);
 		}
-		tty_flip_buffer_push(port);
-		sport->port.icount.rx += count;
 	}
 
-	/*
-	 * Restart RX DMA directly if more data is available in order to skip
-	 * the roundtrip through the IRQ handler. If there is some data already
-	 * in the FIFO, DMA needs to be restarted soon anyways.
-	 *
-	 * Otherwise stop the DMA and reactivate FIFO IRQs to restart DMA once
-	 * data starts to arrive again.
-	 */
-	if (readl(sport->port.membase + USR2) & USR2_RDR)
-		start_rx_dma(sport);
-	else
-		imx_rx_dma_done(sport);
+	if (w_bytes) {
+		tty_flip_buffer_push(port);
+		dev_dbg(sport->port.dev, "We get %d bytes.\n", w_bytes);
+	}
 }
 
+/* RX DMA buffer periods */
+#define RX_DMA_PERIODS 4
+
 static int start_rx_dma(struct imx_port *sport)
 {
 	struct scatterlist *sgl = &sport->rx_sgl;
@@ -1017,14 +1028,21 @@ static int start_rx_dma(struct imx_port *sport)
 	struct dma_async_tx_descriptor *desc;
 	int ret;
 
+	sport->rx_ring.head = 0;
+	sport->rx_ring.tail = 0;
+	sport->rx_periods = RX_DMA_PERIODS;
+
 	sg_init_one(sgl, sport->rx_buf, RX_BUF_SIZE);
 	ret = dma_map_sg(dev, sgl, 1, DMA_FROM_DEVICE);
 	if (ret == 0) {
 		dev_err(dev, "DMA mapping error for RX.\n");
 		return -EINVAL;
 	}
-	desc = dmaengine_prep_slave_sg(chan, sgl, 1, DMA_DEV_TO_MEM,
-					DMA_PREP_INTERRUPT);
+
+	desc = dmaengine_prep_dma_cyclic(chan, sg_dma_address(sgl),
+		sg_dma_len(sgl), sg_dma_len(sgl) / sport->rx_periods,
+		DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+
 	if (!desc) {
 		dma_unmap_sg(dev, sgl, 1, DMA_FROM_DEVICE);
 		dev_err(dev, "We cannot prepare for the RX slave dma!\n");
@@ -1034,7 +1052,7 @@ static int start_rx_dma(struct imx_port *sport)
 	desc->callback_param = sport;
 
 	dev_dbg(dev, "RX: prepare for the DMA.\n");
-	dmaengine_submit(desc);
+	sport->rx_cookie = dmaengine_submit(desc);
 	dma_async_issue_pending(chan);
 	return 0;
 }
@@ -1058,14 +1076,16 @@ static void imx_setup_ufcr(struct imx_port *sport,
 static void imx_uart_dma_exit(struct imx_port *sport)
 {
 	if (sport->dma_chan_rx) {
+		dmaengine_terminate_all(sport->dma_chan_rx);
 		dma_release_channel(sport->dma_chan_rx);
 		sport->dma_chan_rx = NULL;
-
+		sport->rx_cookie = -EINVAL;
 		kfree(sport->rx_buf);
 		sport->rx_buf = NULL;
 	}
 
 	if (sport->dma_chan_tx) {
+		dmaengine_terminate_all(sport->dma_chan_tx);
 		dma_release_channel(sport->dma_chan_tx);
 		sport->dma_chan_tx = NULL;
 	}
@@ -1103,6 +1123,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
 		ret = -ENOMEM;
 		goto err;
 	}
+	sport->rx_ring.buf = sport->rx_buf;
 
 	/* Prepare for TX : */
 	sport->dma_chan_tx = dma_request_slave_channel(dev, "tx");
@@ -1283,17 +1304,11 @@ static void imx_shutdown(struct uart_port *port)
 	unsigned long flags;
 
 	if (sport->dma_is_enabled) {
-		int ret;
+		sport->dma_is_rxing = 0;
+		sport->dma_is_txing = 0;
+		dmaengine_terminate_all(sport->dma_chan_tx);
+		dmaengine_terminate_all(sport->dma_chan_rx);
 
-		/* We have to wait for the DMA to finish. */
-		ret = wait_event_interruptible(sport->dma_wait,
-			!sport->dma_is_rxing && !sport->dma_is_txing);
-		if (ret != 0) {
-			sport->dma_is_rxing = 0;
-			sport->dma_is_txing = 0;
-			dmaengine_terminate_all(sport->dma_chan_tx);
-			dmaengine_terminate_all(sport->dma_chan_rx);
-		}
 		spin_lock_irqsave(&sport->port.lock, flags);
 		imx_stop_tx(port);
 		imx_stop_rx(port);
-- 
2.8.3
