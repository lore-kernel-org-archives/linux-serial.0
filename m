From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH v3 4/6] tty: serial: msm: Add TX DMA support
Date: Wed, 30 Sep 2015 15:27:01 +0300
Message-ID: <1443616023-28625-5-git-send-email-ivan.ivanov@linaro.org>
References: <1443616023-28625-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443616023-28625-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <agross@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Frank Rowand <frank.rowand@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add transmit DMA support for UARTDM type of controllers.

Tested on APQ8064, which have UARTDM v1.3 and ADM DMA engine
and APQ8016, which have UARTDM v1.4 and BAM DMA engine.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 .../devicetree/bindings/serial/qcom,msm-uartdm.txt |   3 +
 drivers/tty/serial/msm_serial.c                    | 312 +++++++++++++++++++--
 drivers/tty/serial/msm_serial.h                    |   3 +
 3 files changed, 294 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
index a2114c217376..a600023d9ec1 100644
--- a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
+++ b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
@@ -26,6 +26,9 @@ Required properties:
 Optional properties:
 - dmas: Should contain dma specifiers for transmit and receive channels
 - dma-names: Should contain "tx" for transmit and "rx" for receive channels
+- qcom,tx-crci: Identificator <u32> for Client Rate Control Interface to be
+           used with TX DMA channel. Required when using DMA for transmission
+           with UARTDM v1.3 and bellow.

 Note: Aliases may be defined to ensure the correct ordering of the UARTs.
 The alias serialN will result in the UART being assigned port N.  If any
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 2315a614ff45..7006d979d9d2 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -20,6 +20,8 @@
 #endif

 #include <linux/atomic.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/hrtimer.h>
 #include <linux/module.h>
 #include <linux/io.h>
@@ -39,6 +41,10 @@

 #include "msm_serial.h"

+#define UARTDM_BURST_SIZE	16   /* in bytes */
+#define UARTDM_TX_AIGN(x)	((x) & ~0x3) /* valid for > 1p3 */
+#define UARTDM_TX_MAX		256   /* in bytes, valid for <= 1p3 */
+
 enum {
 	UARTDM_1P1 = 1,
 	UARTDM_1P2,
@@ -46,6 +52,17 @@ enum {
 	UARTDM_1P4,
 };

+struct msm_dma {
+	struct dma_chan		*chan;
+	enum dma_data_direction dir;
+	dma_addr_t		phys;
+	unsigned char		*virt;
+	dma_cookie_t		cookie;
+	u32			enable_bit;
+	unsigned int		count;
+	struct dma_async_tx_descriptor	*desc;
+};
+
 struct msm_port {
 	struct uart_port	uart;
 	char			name[16];
@@ -55,8 +72,93 @@ struct msm_port {
 	int			is_uartdm;
 	unsigned int		old_snap_state;
 	bool			break_detected;
+	struct msm_dma		tx_dma;
 };

+static void msm_handle_tx(struct uart_port *port);
+
+void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
+{
+	struct device *dev = port->dev;
+	unsigned int mapped;
+	u32 val;
+
+	mapped = dma->count;
+	dma->count = 0;
+
+	dmaengine_terminate_all(dma->chan);
+
+	/*
+	 * DMA Stall happens if enqueue and flush command happens concurrently.
+	 * For example before changing the baud rate/protocol configuration and
+	 * sending flush command to ADM, disable the channel of UARTDM.
+	 * Note: should not reset the receiver here immediately as it is not
+	 * suggested to do disable/reset or reset/disable at the same time.
+	 */
+	val = msm_read(port, UARTDM_DMEN);
+	val &= ~dma->enable_bit;
+	msm_write(port, val, UARTDM_DMEN);
+
+	if (mapped)
+		dma_unmap_single(dev, dma->phys, mapped, dma->dir);
+}
+
+static void msm_release_dma(struct msm_port *msm_port)
+{
+	struct msm_dma *dma;
+
+	dma = &msm_port->tx_dma;
+	if (dma->chan) {
+		msm_stop_dma(&msm_port->uart, dma);
+		dma_release_channel(dma->chan);
+	}
+
+	memset(dma, 0, sizeof(*dma));
+}
+
+static void msm_request_tx_dma(struct msm_port *msm_port, resource_size_t base)
+{
+	struct device *dev = msm_port->uart.dev;
+	struct dma_slave_config conf;
+	struct msm_dma *dma;
+	u32 crci = 0;
+	int ret;
+
+	dma = &msm_port->tx_dma;
+
+	/* allocate DMA resources, if available */
+	dma->chan = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(dma->chan))
+		goto no_tx;
+
+	of_property_read_u32(dev->of_node, "qcom,tx-crci", &crci);
+
+	memset(&conf, 0, sizeof(conf));
+	conf.direction = DMA_MEM_TO_DEV;
+	conf.device_fc = true;
+	conf.dst_addr = base + UARTDM_TF;
+	conf.dst_maxburst = UARTDM_BURST_SIZE;
+	conf.slave_id = crci;
+
+	ret = dmaengine_slave_config(dma->chan, &conf);
+	if (ret)
+		goto rel_tx;
+
+	dma->dir = DMA_TO_DEVICE;
+
+	if (msm_port->is_uartdm < UARTDM_1P4)
+		dma->enable_bit = UARTDM_DMEN_TX_DM_ENABLE;
+	else
+		dma->enable_bit = UARTDM_DMEN_TX_BAM_ENABLE;
+
+	return;
+
+rel_tx:
+	dma_release_channel(dma->chan);
+no_tx:
+	memset(dma, 0, sizeof(*dma));
+}
+
 static inline void msm_wait_for_xmitr(struct uart_port *port)
 {
 	while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
@@ -78,11 +180,132 @@ static void msm_stop_tx(struct uart_port *port)
 static void msm_start_tx(struct uart_port *port)
 {
 	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_dma *dma = &msm_port->tx_dma;
+
+	/* Already started in DMA mode */
+	if (dma->count)
+		return;
+
+	msm_port->imr |= UART_IMR_TXLEV;
+	msm_write(port, msm_port->imr, UART_IMR);
+}
+
+static void msm_reset_dm_count(struct uart_port *port, int count)
+{
+	msm_wait_for_xmitr(port);
+	msm_write(port, count, UARTDM_NCF_TX);
+	msm_read(port, UARTDM_NCF_TX);
+}
+
+static void msm_complete_tx_dma(void *args)
+{
+	struct msm_port *msm_port = args;
+	struct uart_port *port = &msm_port->uart;
+	struct circ_buf *xmit = &port->state->xmit;
+	struct msm_dma *dma = &msm_port->tx_dma;
+	struct dma_tx_state state;
+	enum dma_status status;
+	unsigned long flags;
+	unsigned int count;
+	u32 val;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* Already stopped */
+	if (!dma->count)
+		goto done;
+
+	status = dmaengine_tx_status(dma->chan, dma->cookie, &state);

+	dma_unmap_single(port->dev, dma->phys, dma->count, dma->dir);
+
+	val = msm_read(port, UARTDM_DMEN);
+	val &= ~dma->enable_bit;
+	msm_write(port, val, UARTDM_DMEN);
+
+	if (msm_port->is_uartdm > UARTDM_1P3) {
+		msm_write(port, UART_CR_CMD_RESET_TX, UART_CR);
+		msm_write(port, UART_CR_TX_ENABLE, UART_CR);
+	}
+
+	count = dma->count - state.residue;
+	port->icount.tx += count;
+	dma->count = 0;
+
+	xmit->tail += count;
+	xmit->tail &= UART_XMIT_SIZE - 1;
+
+	/* Restore "Tx FIFO below watermark" interrupt */
 	msm_port->imr |= UART_IMR_TXLEV;
 	msm_write(port, msm_port->imr, UART_IMR);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	msm_handle_tx(port);
+done:
+	spin_unlock_irqrestore(&port->lock, flags);
 }

+static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
+{
+	struct circ_buf *xmit = &msm_port->uart.state->xmit;
+	struct uart_port *port = &msm_port->uart;
+	struct msm_dma *dma = &msm_port->tx_dma;
+	void *cpu_addr;
+	int ret;
+	u32 val;
+
+	cpu_addr = &xmit->buf[xmit->tail];
+
+	dma->phys = dma_map_single(port->dev, cpu_addr, count, dma->dir);
+	ret = dma_mapping_error(port->dev, dma->phys);
+	if (ret)
+		return ret;
+
+	dma->desc = dmaengine_prep_slave_single(dma->chan, dma->phys,
+						count, DMA_MEM_TO_DEV,
+						DMA_PREP_INTERRUPT |
+						DMA_PREP_FENCE);
+	if (!dma->desc) {
+		ret = -EIO;
+		goto unmap;
+	}
+
+	dma->desc->callback = msm_complete_tx_dma;
+	dma->desc->callback_param = msm_port;
+
+	dma->cookie = dmaengine_submit(dma->desc);
+	ret = dma_submit_error(dma->cookie);
+	if (ret)
+		goto unmap;
+
+	/*
+	 * Using DMA complete for Tx FIFO reload, no need for
+	 * "Tx FIFO below watermark" one, disable it
+	 */
+	msm_port->imr &= ~UART_IMR_TXLEV;
+	msm_write(port, msm_port->imr, UART_IMR);
+
+	dma->count = count;
+
+	val = msm_read(port, UARTDM_DMEN);
+	val |= dma->enable_bit;
+
+	if (msm_port->is_uartdm < UARTDM_1P4)
+		msm_write(port, val, UARTDM_DMEN);
+
+	msm_reset_dm_count(port, count);
+
+	if (msm_port->is_uartdm > UARTDM_1P3)
+		msm_write(port, val, UARTDM_DMEN);
+
+	dma_async_issue_pending(dma->chan);
+	return 0;
+unmap:
+	dma_unmap_single(port->dev, dma->phys, count, dma->dir);
+	return ret;
+}
 static void msm_stop_rx(struct uart_port *port)
 {
 	struct msm_port *msm_port = UART_TO_MSM(port);
@@ -224,18 +447,11 @@ static void msm_handle_rx(struct uart_port *port)
 	spin_lock(&port->lock);
 }

-static void msm_reset_dm_count(struct uart_port *port, int count)
-{
-	msm_wait_for_xmitr(port);
-	msm_write(port, count, UARTDM_NCF_TX);
-	msm_read(port, UARTDM_NCF_TX);
-}
-
-static void msm_handle_tx(struct uart_port *port)
+static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
 {
 	struct circ_buf *xmit = &port->state->xmit;
 	struct msm_port *msm_port = UART_TO_MSM(port);
-	unsigned int tx_count, num_chars;
+	unsigned int num_chars;
 	unsigned int tf_pointer = 0;
 	void __iomem *tf;

@@ -244,20 +460,8 @@ static void msm_handle_tx(struct uart_port *port)
 	else
 		tf = port->membase + UART_TF;

-	tx_count = uart_circ_chars_pending(xmit);
-	tx_count = min3(tx_count, (unsigned int)UART_XMIT_SIZE - xmit->tail,
-			port->fifosize);
-
-	if (port->x_char) {
-		if (msm_port->is_uartdm)
-			msm_reset_dm_count(port, tx_count + 1);
-
-		iowrite8_rep(tf, &port->x_char, 1);
-		port->icount.tx++;
-		port->x_char = 0;
-	} else if (tx_count && msm_port->is_uartdm) {
+	if (tx_count && msm_port->is_uartdm)
 		msm_reset_dm_count(port, tx_count);
-	}

 	while (tf_pointer < tx_count) {
 		int i;
@@ -290,6 +494,59 @@ static void msm_handle_tx(struct uart_port *port)
 		uart_write_wakeup(port);
 }

+static void msm_handle_tx(struct uart_port *port)
+{
+	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct circ_buf *xmit = &msm_port->uart.state->xmit;
+	struct msm_dma *dma = &msm_port->tx_dma;
+	unsigned int pio_count, dma_count, dma_min;
+	void __iomem *tf;
+	int err = 0;
+
+	if (port->x_char) {
+		if (msm_port->is_uartdm)
+			tf = port->membase + UARTDM_TF;
+		else
+			tf = port->membase + UART_TF;
+
+		if (msm_port->is_uartdm)
+			msm_reset_dm_count(port, 1);
+
+		iowrite8_rep(tf, &port->x_char, 1);
+		port->icount.tx++;
+		port->x_char = 0;
+		return;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		msm_stop_tx(port);
+		return;
+	}
+
+	pio_count = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
+	dma_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
+
+	dma_min = 1;	/* Always DMA */
+	if (msm_port->is_uartdm > UARTDM_1P3) {
+		dma_count = UARTDM_TX_AIGN(dma_count);
+		dma_min = UARTDM_BURST_SIZE;
+	} else {
+		if (dma_count > UARTDM_TX_MAX)
+			dma_count = UARTDM_TX_MAX;
+	}
+
+	if (pio_count > port->fifosize)
+		pio_count = port->fifosize;
+
+	if (!dma->chan || dma_count < dma_min)
+		msm_handle_tx_pio(port, pio_count);
+	else
+		err = msm_handle_tx_dma(msm_port, dma_count);
+
+	if (err)	/* fall back to PIO mode */
+		msm_handle_tx_pio(port, pio_count);
+}
+
 static void msm_handle_delta_cts(struct uart_port *port)
 {
 	msm_write(port, UART_CR_CMD_RESET_CTS, UART_CR);
@@ -301,9 +558,10 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 	struct msm_port *msm_port = UART_TO_MSM(port);
+	unsigned long flags;
 	unsigned int misr;

-	spin_lock(&port->lock);
+	spin_lock_irqsave(&port->lock, flags);
 	misr = msm_read(port, UART_MISR);
 	msm_write(port, 0, UART_IMR); /* disable interrupt */

@@ -324,7 +582,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 		msm_handle_delta_cts(port);

 	msm_write(port, msm_port->imr, UART_IMR); /* restore interrupt */
-	spin_unlock(&port->lock);
+	spin_unlock_irqrestore(&port->lock, flags);

 	return IRQ_HANDLED;
 }
@@ -515,6 +773,9 @@ static int msm_startup(struct uart_port *port)
 	data |= UART_MR1_AUTO_RFR_LEVEL0 & rfr_level;
 	msm_write(port, data, UART_MR1);

+	if (msm_port->is_uartdm)
+		msm_request_tx_dma(msm_port, msm_port->uart.mapbase);
+
 	return 0;
 }

@@ -525,6 +786,9 @@ static void msm_shutdown(struct uart_port *port)
 	msm_port->imr = 0;
 	msm_write(port, 0, UART_IMR); /* disable interrupts */

+	if (msm_port->is_uartdm)
+		msm_release_dma(msm_port);
+
 	clk_disable_unprepare(msm_port->clk);

 	free_irq(port->irq, port);
diff --git a/drivers/tty/serial/msm_serial.h b/drivers/tty/serial/msm_serial.h
index 60917d30c6b5..103ae61b9d06 100644
--- a/drivers/tty/serial/msm_serial.h
+++ b/drivers/tty/serial/msm_serial.h
@@ -121,6 +121,9 @@
 #define UARTDM_DMEN_RX_SC_ENABLE BIT(5)
 #define UARTDM_DMEN_TX_SC_ENABLE BIT(4)

+#define UARTDM_DMEN_TX_BAM_ENABLE BIT(2)	/* UARTDM_1P4 */
+#define UARTDM_DMEN_TX_DM_ENABLE  BIT(0)	/* < UARTDM_1P4 */
+
 #define UARTDM_DMRX		0x34
 #define UARTDM_NCF_TX		0x40
 #define UARTDM_RX_TOTAL_SNAP	0x38
--
1.9.1
