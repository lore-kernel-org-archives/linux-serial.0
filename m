From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 1/2] serial/imx: add DMA support
Date: Thu, 26 Apr 2012 18:37:11 +0800
Message-ID: <1335436632-29499-2-git-send-email-b32955@freescale.com>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:50054
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755487Ab2DZKdf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2012 06:33:35 -0400
In-Reply-To: <1335436632-29499-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, B20223@freescale.com, r58066@freescale.com, B20596@freescale.com, s.hauer@pengutronix.de, Huang Shijie <b32955@freescale.com>

Add the DMA support for uart RX and TX.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../bindings/tty/serial/fsl-imx-uart.txt           |    7 +
 drivers/tty/serial/imx.c                           |  386 +++++++++++++++++++-
 2 files changed, 389 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
index a9c0406..f27489d 100644
--- a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
@@ -8,6 +8,10 @@ Required properties:
 Optional properties:
 - fsl,uart-has-rtscts : Indicate the uart has rts and cts
 - fsl,irda-mode : Indicate the uart supports irda mode
+- fsl,enable-dma : Indicate the uart supports DMA
+- fsl,uart-dma-events : contains the DMA events for RX and TX,
+	          The first is the RX event, while the other is TX.
+- fsl,enable-dte: Indicate the uart works in DTE mode
 
 Example:
 
@@ -16,4 +20,7 @@ uart@73fbc000 {
 	reg = <0x73fbc000 0x4000>;
 	interrupts = <31>;
 	fsl,uart-has-rtscts;
+	fsl,enable-dma;
+	fsl,uart-dma-events = <xx xx>;
+	fsl,enable-dte;
 };
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e7fecee..65ba24d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -47,9 +47,11 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <mach/dma.h>
 #include <mach/imx-uart.h>
 
 /* Register definitions */
@@ -82,6 +84,7 @@
 #define  UCR1_ADBR       (1<<14) /* Auto detect baud rate */
 #define  UCR1_TRDYEN     (1<<13) /* Transmitter ready interrupt enable */
 #define  UCR1_IDEN       (1<<12) /* Idle condition interrupt */
+#define  UCR1_ICD_REG(x) (((x) & 3) << 10) /* idle condition detect */
 #define  UCR1_RRDYEN     (1<<9)	 /* Recv ready interrupt enable */
 #define  UCR1_RDMAEN     (1<<8)	 /* Recv ready DMA enable */
 #define  UCR1_IREN       (1<<7)	 /* Infrared interface enable */
@@ -125,6 +128,7 @@
 #define  UCR4_ENIRI 	 (1<<8)  /* Serial infrared interrupt enable */
 #define  UCR4_WKEN  	 (1<<7)  /* Wake interrupt enable */
 #define  UCR4_REF16 	 (1<<6)  /* Ref freq 16 MHz */
+#define  UCR4_IDDMAEN    (1<<6)  /* DMA IDLE Condition Detected */
 #define  UCR4_IRSC  	 (1<<5)  /* IR special case */
 #define  UCR4_TCEN  	 (1<<3)  /* Transmit complete interrupt enable */
 #define  UCR4_BKEN  	 (1<<2)  /* Break condition interrupt enable */
@@ -134,6 +138,7 @@
 #define  UFCR_RFDIV      (7<<7)  /* Reference freq divider mask */
 #define  UFCR_RFDIV_REG(x)	(((x) < 7 ? 6 - (x) : 6) << 7)
 #define  UFCR_TXTL_SHF   10      /* Transmitter trigger level shift */
+#define  UFCR_DCEDTE	 (1<<6)
 #define  USR1_PARITYERR  (1<<15) /* Parity error interrupt flag */
 #define  USR1_RTSS  	 (1<<14) /* RTS pin status */
 #define  USR1_TRDY  	 (1<<13) /* Transmitter ready interrupt/dma flag */
@@ -200,12 +205,27 @@ struct imx_port {
 	unsigned int		old_status;
 	int			txirq,rxirq,rtsirq;
 	unsigned int		have_rtscts:1;
+	unsigned int		enable_dte:1;
+	unsigned int		enable_dma:1;
 	unsigned int		use_irda:1;
 	unsigned int		irda_inv_rx:1;
 	unsigned int		irda_inv_tx:1;
 	unsigned short		trcv_delay; /* transceiver delay */
 	struct clk		*clk;
 	struct imx_uart_data	*devdata;
+
+	/* DMA fields */
+	unsigned int		dma_req_rx;
+	unsigned int		dma_req_tx;
+	struct imx_dma_data	dma_data;
+	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
+	struct scatterlist	rx_sgl, tx_sgl[2];
+	void			*rx_buf;
+	unsigned int		rx_bytes, tx_bytes;
+	struct work_struct	tsk_dma_rx, tsk_dma_tx;
+	unsigned int		dma_tx_nents;
+	bool			dma_is_rxing;
+	wait_queue_head_t	dma_wait;
 };
 
 struct imx_port_ucrs {
@@ -394,6 +414,13 @@ static void imx_stop_rx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
+	/*
+	 * We are maybe in the SMP now, so if the DMA RX thread is running,
+	 * we have to wait for it to finish.
+	 */
+	if (sport->enable_dma && sport->dma_is_rxing)
+		return;
+
 	temp = readl(sport->port.membase + UCR2);
 	writel(temp &~ UCR2_RXEN, sport->port.membase + UCR2);
 }
@@ -429,6 +456,80 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
 		imx_stop_tx(&sport->port);
 }
 
+static void dma_tx_callback(void *data)
+{
+	struct imx_port *sport = data;
+	struct scatterlist *sgl = &sport->tx_sgl[0];
+	struct circ_buf *xmit = &sport->port.state->xmit;
+
+	dma_unmap_sg(sport->port.dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
+
+	/* update the stat */
+	spin_lock(&sport->port.lock);
+	xmit->tail = (xmit->tail + sport->tx_bytes) & (UART_XMIT_SIZE - 1);
+	sport->port.icount.tx += sport->tx_bytes;
+	spin_unlock(&sport->port.lock);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&sport->port);
+	schedule_work(&sport->tsk_dma_tx);
+}
+
+static void dma_tx_work(struct work_struct *w)
+{
+	struct imx_port *sport = container_of(w, struct imx_port, tsk_dma_tx);
+	struct circ_buf *xmit = &sport->port.state->xmit;
+	struct scatterlist *sgl = &sport->tx_sgl[0];
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan	*chan = sport->dma_chan_tx;
+	enum dma_status status;
+	unsigned long flags;
+	int ret;
+
+	status = chan->device->device_tx_status(chan, (dma_cookie_t)NULL, NULL);
+	if (DMA_IN_PROGRESS == status)
+		return;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+	sport->tx_bytes = uart_circ_chars_pending(xmit);
+	if (sport->tx_bytes > 0) {
+		if (xmit->tail > xmit->head) {
+			sport->dma_tx_nents = 2;
+			sg_init_table(sgl, 2);
+			sg_set_buf(sgl, xmit->buf + xmit->tail,
+					UART_XMIT_SIZE - xmit->tail);
+			sg_set_buf(&sgl[1], xmit->buf, xmit->head);
+		} else {
+			sport->dma_tx_nents = 1;
+			sg_init_one(sgl, xmit->buf + xmit->tail,
+					sport->tx_bytes);
+		}
+		spin_unlock_irqrestore(&sport->port.lock, flags);
+
+		ret = dma_map_sg(sport->port.dev, sgl,
+				sport->dma_tx_nents, DMA_TO_DEVICE);
+		if (ret == 0) {
+			pr_err("DMA mapping error for TX.\n");
+			return;
+		}
+		desc = dmaengine_prep_slave_sg(chan, sgl,
+				sport->dma_tx_nents, DMA_MEM_TO_DEV, 0);
+		if (!desc) {
+			pr_err("We cannot prepare for the TX slave dma!\n");
+			return;
+		}
+		desc->callback = dma_tx_callback;
+		desc->callback_param = sport;
+
+		/* fire it */
+		dmaengine_submit(desc);
+		dma_async_issue_pending(chan);
+		return;
+	}
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+	return;
+}
+
 /*
  * interrupts disabled on entry
  */
@@ -448,8 +549,10 @@ static void imx_start_tx(struct uart_port *port)
 		writel(temp, sport->port.membase + UCR1);
 	}
 
-	temp = readl(sport->port.membase + UCR1);
-	writel(temp | UCR1_TXMPTYEN, sport->port.membase + UCR1);
+	if (!sport->enable_dma) {
+		temp = readl(sport->port.membase + UCR1);
+		writel(temp | UCR1_TXMPTYEN, sport->port.membase + UCR1);
+	}
 
 	if (USE_IRDA(sport)) {
 		temp = readl(sport->port.membase + UCR1);
@@ -461,6 +564,11 @@ static void imx_start_tx(struct uart_port *port)
 		writel(temp, sport->port.membase + UCR4);
 	}
 
+	if (sport->enable_dma) {
+		schedule_work(&sport->tsk_dma_tx);
+		return;
+	}
+
 	if (readl(sport->port.membase + uts_reg(sport)) & UTS_TXEMPTY)
 		imx_transmit_buffer(sport);
 }
@@ -577,6 +685,28 @@ out:
 	return IRQ_HANDLED;
 }
 
+/*
+ * We wait for the RXFIFO is filled with some data, and then
+ * arise a DMA operation to receive the data.
+ */
+static void imx_dma_rxint(struct imx_port *sport)
+{
+	unsigned long temp;
+
+	temp = readl(sport->port.membase + USR2);
+	if ((temp & USR2_RDR) && !sport->dma_is_rxing) {
+		sport->dma_is_rxing = true;
+
+		/* disable the `Recerver Ready Interrrupt` */
+		temp = readl(sport->port.membase + UCR1);
+		temp &= ~(UCR1_RRDYEN);
+		writel(temp, sport->port.membase + UCR1);
+
+		/* tell the DMA to receive the data. */
+		schedule_work(&sport->tsk_dma_rx);
+	}
+}
+
 static irqreturn_t imx_int(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
@@ -584,8 +714,12 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 
 	sts = readl(sport->port.membase + USR1);
 
-	if (sts & USR1_RRDY)
-		imx_rxint(irq, dev_id);
+	if (sts & USR1_RRDY) {
+		if (sport->enable_dma)
+			imx_dma_rxint(sport);
+		else
+			imx_rxint(irq, dev_id);
+	}
 
 	if (sts & USR1_TRDY &&
 			readl(sport->port.membase + UCR1) & UCR1_TXMPTYEN)
@@ -685,6 +819,195 @@ static int imx_setup_ufcr(struct imx_port *sport, unsigned int mode)
 	return 0;
 }
 
+static bool imx_uart_filter(struct dma_chan *chan, void *param)
+{
+	struct imx_port *sport = param;
+
+	if (!imx_dma_is_general_purpose(chan))
+		return false;
+	chan->private = &sport->dma_data;
+	return true;
+}
+
+#define RX_BUF_SIZE	(PAGE_SIZE)
+static int start_rx_dma(struct imx_port *sport);
+static void dma_rx_work(struct work_struct *w)
+{
+	struct imx_port *sport = container_of(w, struct imx_port, tsk_dma_rx);
+	struct tty_struct *tty = sport->port.state->port.tty;
+
+	if (sport->rx_bytes) {
+		tty_insert_flip_string(tty, sport->rx_buf, sport->rx_bytes);
+		tty_flip_buffer_push(tty);
+		sport->rx_bytes = 0;
+	}
+
+	if (sport->dma_is_rxing)
+		start_rx_dma(sport);
+}
+
+static void imx_finish_dma(struct imx_port *sport)
+{
+	unsigned long temp;
+
+	/* Enable the interrupt when the RXFIFO is not empty. */
+	temp = readl(sport->port.membase + UCR1);
+	temp |= UCR1_RRDYEN;
+	writel(temp, sport->port.membase + UCR1);
+
+	sport->dma_is_rxing = false;
+	if (waitqueue_active(&sport->dma_wait))
+		wake_up(&sport->dma_wait);
+}
+
+/*
+ * There are three kinds of RX DMA interrupts in the MX6Q:
+ *   [1] the RX DMA buffer is full.
+ *   [2] the Aging timer expires(wait for 8 bytes long)
+ *   [3] the Idle Condition Detect(enabled the UCR4_IDDMAEN).
+ *
+ * The [2] and [3] are similar, but [3] is better.
+ * [3] can wait for 32 bytes long, so we do not use [2].
+ */
+static void dma_rx_callback(void *data)
+{
+	struct imx_port *sport = data;
+	struct dma_chan	*chan = sport->dma_chan_rx;
+	unsigned int count;
+	struct tty_struct *tty;
+	struct scatterlist *sgl;
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	tty = sport->port.state->port.tty;
+	sgl = &sport->rx_sgl;
+
+	/* unmap it first */
+	dma_unmap_sg(sport->port.dev, sgl, 1, DMA_FROM_DEVICE);
+
+	/* If we have finish the reading. we will not accept any more data. */
+	if (tty->closing) {
+		imx_finish_dma(sport);
+		return;
+	}
+
+	status = chan->device->device_tx_status(chan,
+					(dma_cookie_t)NULL, &state);
+	count = RX_BUF_SIZE - state.residue;
+	if (count) {
+		sport->rx_bytes = count;
+		schedule_work(&sport->tsk_dma_rx);
+	} else
+		imx_finish_dma(sport);
+}
+
+static int start_rx_dma(struct imx_port *sport)
+{
+	struct scatterlist *sgl = &sport->rx_sgl;
+	struct dma_chan	*chan = sport->dma_chan_rx;
+	struct dma_async_tx_descriptor *desc;
+	int ret;
+
+	sg_init_one(sgl, sport->rx_buf, RX_BUF_SIZE);
+	ret = dma_map_sg(sport->port.dev, sgl, 1, DMA_FROM_DEVICE);
+	if (ret == 0) {
+		pr_err("DMA mapping error for RX.\n");
+		return -EINVAL;
+	}
+	desc = dmaengine_prep_slave_sg(chan, sgl, 1, DMA_DEV_TO_MEM, 0);
+	if (!desc) {
+		pr_err("We cannot prepare for the RX slave dma!\n");
+		return -EINVAL;
+	}
+	desc->callback = dma_rx_callback;
+	desc->callback_param = sport;
+
+	dmaengine_submit(desc);
+	dma_async_issue_pending(chan);
+	return 0;
+}
+
+static void imx_uart_dma_exit(struct imx_port *sport)
+{
+	if (sport->dma_chan_rx) {
+		dma_release_channel(sport->dma_chan_rx);
+		sport->dma_chan_rx = NULL;
+
+		kfree(sport->rx_buf);
+		sport->rx_buf = NULL;
+	}
+
+	if (sport->dma_chan_tx) {
+		dma_release_channel(sport->dma_chan_tx);
+		sport->dma_chan_tx = NULL;
+	}
+}
+
+/* see the "i.MX61 SDMA Scripts User Manual.doc" for the parameters */
+static int imx_uart_dma_init(struct imx_port *sport)
+{
+	struct dma_slave_config slave_config;
+	dma_cap_mask_t mask;
+	int ret;
+
+	/* prepare for RX : */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	sport->dma_data.priority = DMA_PRIO_HIGH;
+	sport->dma_data.dma_request = sport->dma_req_rx;
+	sport->dma_data.peripheral_type = IMX_DMATYPE_UART;
+
+	sport->dma_chan_rx = dma_request_channel(mask, imx_uart_filter, sport);
+	if (!sport->dma_chan_rx) {
+		pr_err("cannot get the DMA channel.\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	slave_config.direction = DMA_DEV_TO_MEM;
+	slave_config.src_addr = sport->port.mapbase + URXD0;
+	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.src_maxburst = RXTL; /* fix me */
+	ret = dmaengine_slave_config(sport->dma_chan_rx, &slave_config);
+	if (ret) {
+		pr_err("error in RX dma configuration.\n");
+		goto err;
+	}
+
+	sport->rx_buf = kzalloc(PAGE_SIZE, GFP_DMA);
+	if (!sport->rx_buf) {
+		pr_err("cannot alloc DMA buffer.\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+	sport->rx_bytes = 0;
+
+	/* prepare for TX : */
+	sport->dma_data.dma_request = sport->dma_req_tx;
+	sport->dma_chan_tx = dma_request_channel(mask, imx_uart_filter, sport);
+	if (!sport->dma_chan_tx) {
+		pr_err("cannot get the TX DMA channel!\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	slave_config.direction = DMA_MEM_TO_DEV;
+	slave_config.dst_addr = sport->port.mapbase + URTX0;
+	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.dst_maxburst = TXTL; /* fix me */
+	ret = dmaengine_slave_config(sport->dma_chan_tx, &slave_config);
+	if (ret) {
+		pr_err("error in TX dma configuration.");
+		goto err;
+	}
+
+	return 0;
+err:
+	imx_uart_dma_exit(sport);
+	return ret;
+}
+
 /* half the RX buffer size */
 #define CTSTL 16
 
@@ -756,6 +1079,19 @@ static int imx_startup(struct uart_port *port)
 		}
 	}
 
+	/* Enable the SDMA for uart. */
+	if (sport->enable_dma) {
+		int ret;
+		ret = imx_uart_dma_init(sport);
+		if (ret)
+			goto error_out3;
+
+		sport->port.flags |= UPF_LOW_LATENCY;
+		INIT_WORK(&sport->tsk_dma_tx, dma_tx_work);
+		INIT_WORK(&sport->tsk_dma_rx, dma_rx_work);
+		init_waitqueue_head(&sport->dma_wait);
+	}
+
 	/*
 	 * Finally, clear and enable interrupts
 	 */
@@ -763,6 +1099,11 @@ static int imx_startup(struct uart_port *port)
 
 	temp = readl(sport->port.membase + UCR1);
 	temp |= UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN;
+	if (sport->enable_dma) {
+		temp |= UCR1_RDMAEN | UCR1_TDMAEN;
+		/* ICD, wait for more than 32 frames, but it still to short. */
+		temp |= UCR1_ICD_REG(3);
+	}
 
 	if (USE_IRDA(sport)) {
 		temp |= UCR1_IREN;
@@ -806,6 +1147,12 @@ static int imx_startup(struct uart_port *port)
 		writel(temp, sport->port.membase + UCR3);
 	}
 
+	if (sport->enable_dma) {
+		temp = readl(sport->port.membase + UCR4);
+		temp |= UCR4_IDDMAEN;
+		writel(temp, sport->port.membase + UCR4);
+	}
+
 	/*
 	 * Enable modem status interrupts
 	 */
@@ -840,6 +1187,13 @@ static void imx_shutdown(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
+	if (sport->enable_dma) {
+		/* We have to wait for the DMA to finish. */
+		wait_event(sport->dma_wait, !sport->dma_is_rxing);
+		imx_stop_rx(port);
+		imx_uart_dma_exit(sport);
+	}
+
 	temp = readl(sport->port.membase + UCR2);
 	temp &= ~(UCR2_TXEN);
 	writel(temp, sport->port.membase + UCR2);
@@ -875,8 +1229,16 @@ static void imx_shutdown(struct uart_port *port)
 	temp &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN);
 	if (USE_IRDA(sport))
 		temp &= ~(UCR1_IREN);
+	if (sport->enable_dma)
+		temp &= ~(UCR1_RDMAEN | UCR1_TDMAEN);
 
 	writel(temp, sport->port.membase + UCR1);
+
+	if (sport->enable_dma) {
+		temp = readl(sport->port.membase + UCR4);
+		temp &= ~UCR4_IDDMAEN;
+		writel(temp, sport->port.membase + UCR4);
+	}
 }
 
 static void
@@ -1013,6 +1375,9 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	ufcr = readl(sport->port.membase + UFCR);
 	ufcr = (ufcr & (~UFCR_RFDIV)) | UFCR_RFDIV_REG(div);
+	/* set the DTE mode */
+	if (sport->enable_dte)
+		ufcr |= UFCR_DCEDTE;
 	writel(ufcr, sport->port.membase + UFCR);
 
 	writel(num, sport->port.membase + UBIR);
@@ -1409,6 +1774,7 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	const struct of_device_id *of_id =
 			of_match_device(imx_uart_dt_ids, &pdev->dev);
 	int ret;
+	u32 dma_req[2];
 
 	if (!np)
 		/* no device tree device */
@@ -1427,6 +1793,18 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	if (of_get_property(np, "fsl,irda-mode", NULL))
 		sport->use_irda = 1;
 
+	if (of_get_property(np, "fsl,enable-dma", NULL))
+		sport->enable_dma = 1;
+
+	if (of_get_property(np, "fsl,enable-dte", NULL))
+		sport->enable_dte = 1;
+
+	if (of_property_read_u32_array(np, "fsl,uart-dma-events", dma_req,
+				ARRAY_SIZE(dma_req)) == 0) {
+		sport->dma_req_rx = dma_req[0];
+		sport->dma_req_tx = dma_req[1];
+	}
+
 	sport->devdata = of_id->data;
 
 	return 0;
-- 
1.7.0.4


