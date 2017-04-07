From: Peter Senna Tschudin <peter.senna@collabora.com>
Subject: [PATCH] imx-serial: Reduce RX DMA startup latency when opening for reading
Date: Fri,  7 Apr 2017 11:45:24 +0200
Message-ID: <20170407094524.26390-1-peter.senna@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Peter Senna Tschudin <peter.senna@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Reduce RX DMA start latency for the first reception when port is opened
for reading. Instead of waiting for an interrupt signaling data on RX
FIFO or data too old on RX FIFO, start RX DMA immediately when the
serial port is opened for reading.

Before this patch, the average RX DMA latency for the first reception
was 42489 microseconds with a standard deviation of 25721 microseconds
in 36 samples.

After the patch the average RX DMA latency for the first reception, when
the serial port is opened for reading, is 653 microseconds with a
standard deviation of 294 microseconds in 36 samples.

Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---

RX DMA latency for the first reception was calculated as the time
difference between the call to imx_startup() and the completion of
start_rx_dma(). I used this patch for the measurement:
	--- a/drivers/tty/serial/imx.c
	+++ b/drivers/tty/serial/imx.c
	@@ -238,6 +238,7 @@ struct imx_port {
		wait_queue_head_t	dma_wait;
		unsigned int            saved_reg[10];
		bool			context_saved;
	+	struct timespec 	ts;
	 };

	 struct imx_port_ucrs {
	@@ -1059,6 +1060,7 @@ static int start_rx_dma(struct imx_port *sport)
		struct dma_chan	*chan = sport->dma_chan_rx;
		struct device *dev = sport->port.dev;
		struct dma_async_tx_descriptor *desc;
	+	struct timespec te;
		int ret;

		sport->rx_ring.head = 0;
	@@ -1087,6 +1089,10 @@ static int start_rx_dma(struct imx_port *sport)
		sport->dma_is_rxing = 1;
		sport->rx_cookie = dmaengine_submit(desc);
		dma_async_issue_pending(chan);
	+
	+	getnstimeofday(&te);
	+	dev_err(sport->port.dev, "DMA delay(microseconds): %lu\n", (te.tv_nsec - sport->ts.tv_nsec)/1000);
	+
		return 0;
	 }

	@@ -1286,6 +1292,8 @@ static int imx_startup(struct uart_port *port)
		int retval, i, readcnt = 0;
		unsigned long flags, temp;

	+	getnstimeofday(&sport->ts);
	+
		retval = clk_prepare_enable(sport->clk_per);
		if (retval)
			return retval;

 drivers/tty/serial/imx.c | 63 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e3e152c..b4340b5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -719,6 +719,27 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void imx_disable_rx_int(struct imx_port *sport)
+{
+	unsigned long temp;
+
+	sport->dma_is_rxing = 1;
+
+	/* disable the receiver ready and aging timer interrupts */
+	temp = readl(sport->port.membase + UCR1);
+	temp &= ~(UCR1_RRDYEN);
+	writel(temp, sport->port.membase + UCR1);
+
+	temp = readl(sport->port.membase + UCR2);
+	temp &= ~(UCR2_ATEN);
+	writel(temp, sport->port.membase + UCR2);
+
+	/* disable the rx errors interrupts */
+	temp = readl(sport->port.membase + UCR4);
+	temp &= ~UCR4_OREN;
+	writel(temp, sport->port.membase + UCR4);
+}
+
 static void clear_rx_errors(struct imx_port *sport);
 static int start_rx_dma(struct imx_port *sport);
 /*
@@ -734,21 +755,8 @@ static void imx_dma_rxint(struct imx_port *sport)
 
 	temp = readl(sport->port.membase + USR2);
 	if ((temp & USR2_RDR) && !sport->dma_is_rxing) {
-		sport->dma_is_rxing = 1;
 
-		/* disable the receiver ready and aging timer interrupts */
-		temp = readl(sport->port.membase + UCR1);
-		temp &= ~(UCR1_RRDYEN);
-		writel(temp, sport->port.membase + UCR1);
-
-		temp = readl(sport->port.membase + UCR2);
-		temp &= ~(UCR2_ATEN);
-		writel(temp, sport->port.membase + UCR2);
-
-		/* disable the rx errors interrupts */
-		temp = readl(sport->port.membase + UCR4);
-		temp &= ~UCR4_OREN;
-		writel(temp, sport->port.membase + UCR4);
+		imx_disable_rx_int(sport);
 
 		/* tell the DMA to receive the data. */
 		start_rx_dma(sport);
@@ -1339,6 +1347,33 @@ static int imx_startup(struct uart_port *port)
 	 * Enable modem status interrupts
 	 */
 	imx_enable_ms(&sport->port);
+
+	/*
+	 * If the serial port is opened for reading start RX DMA immediately
+	 * instead of waiting for RX FIFO interrupts. In our iMX53 the average
+	 * delay for the first reception dropped from approximately 35000
+	 * microseconds to 1000 microseconds.
+	 */
+	if (sport->dma_is_enabled) {
+		struct tty_struct *tty = sport->port.state->port.tty;
+		struct tty_file_private *file_priv;
+		int readcnt = 0;
+
+		spin_lock(&tty->files_lock);
+
+		if (!list_empty(&tty->tty_files))
+			list_for_each_entry(file_priv, &tty->tty_files, list)
+				if (!(file_priv->file->f_flags & O_WRONLY))
+					readcnt++;
+
+		spin_unlock(&tty->files_lock);
+
+		if (readcnt > 0) {
+			imx_disable_rx_int(sport);
+			start_rx_dma(sport);
+		}
+	}
+
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	return 0;
-- 
2.9.3
