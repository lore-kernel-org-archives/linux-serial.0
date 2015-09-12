From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH 6/7] tty: serial: msm: Add RX DMA support
Date: Sat, 12 Sep 2015 16:02:13 +0300
Message-ID: <1442062934-13449-7-git-send-email-ivan.ivanov@linaro.org>
References: <1442062934-13449-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442062934-13449-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <agross@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Frank Rowand <frank.rowand@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add receive DMA support for UARTDM type of controllers.

Tested on APQ8064, which have UARTDM v1.3 and ADM DMA engine
and APQ8016, which have UARTDM v1.4 and BAM DMA engine.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 .../devicetree/bindings/serial/qcom,msm-uartdm.txt |   3 +
 drivers/tty/serial/msm_serial.c                    | 230 ++++++++++++++++++++-
 drivers/tty/serial/msm_serial.h                    |   4 +
 3 files changed, 234 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
index a600023d9ec1..182777fac9a2 100644
--- a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
+++ b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
@@ -29,6 +29,9 @@ Optional properties:
 - qcom,tx-crci: Identificator <u32> for Client Rate Control Interface to be
            used with TX DMA channel. Required when using DMA for transmission
            with UARTDM v1.3 and bellow.
+- qcom,rx-crci: Identificator <u32> for Client Rate Control Interface to be
+           used with RX DMA channel. Required when using DMA for reception
+           with UARTDM v1.3 and bellow.

 Note: Aliases may be defined to ensure the correct ordering of the UARTs.
 The alias serialN will result in the UART being assigned port N.  If any
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index e40611afad09..3f975392ebc0 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -33,6 +33,7 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
+#include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
@@ -44,6 +45,7 @@
 #define UARTDM_BURST_SIZE	16   /* in bytes */
 #define UARTDM_TX_AIGN(x)	((x) & ~0x3) /* valid for > 1p3 */
 #define UARTDM_TX_MAX		256   /* in bytes, valid for <= 1p3 */
+#define UARTDM_RX_SIZE		(UART_XMIT_SIZE / 4)

 enum {
 	UARTDM_1P1 = 1,
@@ -73,9 +75,11 @@ struct msm_port {
 	unsigned int		old_snap_state;
 	bool			break_detected;
 	struct msm_dma		tx_dma;
+	struct msm_dma		rx_dma;
 };

 static void msm_handle_tx(struct uart_port *port);
+static void msm_start_rx_dma(struct msm_port *msm_port);

 void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
 {
@@ -114,6 +118,15 @@ static void msm_release_dma(struct msm_port *msm_port)
 	}

 	memset(dma, 0, sizeof(*dma));
+
+	dma = &msm_port->rx_dma;
+	if (dma->chan) {
+		msm_stop_dma(&msm_port->uart, dma);
+		dma_release_channel(dma->chan);
+		kfree(dma->virt);
+	}
+
+	memset(dma, 0, sizeof(*dma));
 }

 static void msm_request_tx_dma(struct msm_port *msm_port, resource_size_t base)
@@ -159,6 +172,54 @@ no_tx:
 	memset(dma, 0, sizeof(*dma));
 }

+static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
+{
+	struct device *dev = msm_port->uart.dev;
+	struct dma_slave_config conf;
+	struct msm_dma *dma;
+	u32 crci = 0;
+	int ret;
+
+	dma = &msm_port->rx_dma;
+
+	/* allocate DMA resources, if available */
+	dma->chan = dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR(dma->chan))
+		goto no_rx;
+
+	of_property_read_u32(dev->of_node, "qcom,rx-crci", &crci);
+
+	dma->virt = kzalloc(UARTDM_RX_SIZE, GFP_KERNEL);
+	if (!dma->virt)
+		goto rel_rx;
+
+	memset(&conf, 0, sizeof(conf));
+	conf.direction = DMA_DEV_TO_MEM;
+	conf.device_fc = true;
+	conf.src_addr = base + UARTDM_RF;
+	conf.src_maxburst = UARTDM_BURST_SIZE;
+	conf.slave_id = crci;
+
+	ret = dmaengine_slave_config(dma->chan, &conf);
+	if (ret)
+		goto err;
+
+	dma->dir = DMA_FROM_DEVICE;
+
+	if (msm_port->is_uartdm < UARTDM_1P4)
+		dma->enable_bit = UARTDM_DMEN_RX_DM_ENABLE;
+	else
+		dma->enable_bit = UARTDM_DMEN_RX_BAM_ENABLE;
+
+	return;
+err:
+	kfree(dma->virt);
+rel_rx:
+	dma_release_channel(dma->chan);
+no_rx:
+	memset(dma, 0, sizeof(*dma));
+}
+
 static inline void msm_wait_for_xmitr(struct uart_port *port)
 {
 	while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
@@ -306,12 +367,149 @@ unmap:
 	dma_unmap_single(port->dev, dma->phys, count, dma->dir);
 	return ret;
 }
+
+static void msm_complete_rx_dma(void *args)
+{
+	struct msm_port *msm_port = args;
+	struct uart_port *port = &msm_port->uart;
+	struct tty_port *tport = &port->state->port;
+	struct msm_dma *dma = &msm_port->rx_dma;
+	int count = 0, i, sysrq;
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* Already stopped */
+	if (!dma->count)
+		goto done;
+
+	val = msm_read(port, UARTDM_DMEN);
+	val &= ~dma->enable_bit;
+	msm_write(port, val, UARTDM_DMEN);
+
+	/* Restore interrupts */
+	msm_port->imr |= UART_IMR_RXLEV | UART_IMR_RXSTALE;
+	msm_write(port, msm_port->imr, UART_IMR);
+
+	if (msm_read(port, UART_SR) & UART_SR_OVERRUN) {
+		port->icount.overrun++;
+		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
+		msm_write(port, UART_CR_CMD_RESET_ERR, UART_CR);
+	}
+
+	count = msm_read(port, UARTDM_RX_TOTAL_SNAP);
+
+	port->icount.rx += count;
+
+	dma->count = 0;
+
+	dma_unmap_single(port->dev, dma->phys, UARTDM_RX_SIZE, dma->dir);
+
+	for (i = 0; i < count; i++) {
+		char flag = TTY_NORMAL;
+
+		if (msm_port->break_detected && dma->virt[i] == 0) {
+			port->icount.brk++;
+			flag = TTY_BREAK;
+			msm_port->break_detected = false;
+			if (uart_handle_break(port))
+				continue;
+		}
+
+		if (!(port->read_status_mask & UART_SR_RX_BREAK))
+			flag = TTY_NORMAL;
+
+		sysrq = uart_handle_sysrq_char(port, dma->virt[i]);
+		if (!sysrq)
+			tty_insert_flip_char(tport, dma->virt[i], flag);
+	}
+
+	msm_start_rx_dma(msm_port);
+done:
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (count)
+		tty_flip_buffer_push(tport);
+}
+
+static void msm_start_rx_dma(struct msm_port *msm_port)
+{
+	struct msm_dma *dma = &msm_port->rx_dma;
+	struct uart_port *uart = &msm_port->uart;
+	u32 val;
+	int ret;
+
+	if (!dma->chan)
+		return;
+
+	dma->phys = dma_map_single(uart->dev, dma->virt,
+				   UARTDM_RX_SIZE, dma->dir);
+	ret = dma_mapping_error(uart->dev, dma->phys);
+	if (ret)
+		return;
+
+	dma->desc = dmaengine_prep_slave_single(dma->chan, dma->phys,
+						UARTDM_RX_SIZE, DMA_DEV_TO_MEM,
+						DMA_PREP_INTERRUPT);
+	if (!dma->desc)
+		goto unmap;
+
+	dma->desc->callback = msm_complete_rx_dma;
+	dma->desc->callback_param = msm_port;
+
+	dma->cookie = dmaengine_submit(dma->desc);
+	ret = dma_submit_error(dma->cookie);
+	if (ret)
+		goto unmap;
+	/*
+	 * Using DMA for FIFO off-load, no need for "Rx FIFO over
+	 * watermark" or "stale" interrupts, disable them
+	 */
+	msm_port->imr &= ~(UART_IMR_RXLEV | UART_IMR_RXSTALE);
+
+	/*
+	 * Well, when DMA is ADM3 engine(implied by <= UARTDM v1.3),
+	 * we need RXSTALE to flush input DMA fifo to memory
+	 */
+	if (msm_port->is_uartdm < UARTDM_1P4)
+		msm_port->imr |= UART_IMR_RXSTALE;
+
+	msm_write(uart, msm_port->imr, UART_IMR);
+
+	dma->count = UARTDM_RX_SIZE;
+
+	dma_async_issue_pending(dma->chan);
+
+	msm_write(uart, UART_CR_CMD_RESET_STALE_INT, UART_CR);
+	msm_write(uart, UART_CR_CMD_STALE_EVENT_ENABLE, UART_CR);
+
+	val = msm_read(uart, UARTDM_DMEN);
+	val |= dma->enable_bit;
+
+	if (msm_port->is_uartdm < UARTDM_1P4)
+		msm_write(uart, val, UARTDM_DMEN);
+
+	msm_write(uart, UARTDM_RX_SIZE, UARTDM_DMRX);
+
+	if (msm_port->is_uartdm > UARTDM_1P3)
+		msm_write(uart, val, UARTDM_DMEN);
+
+	return;
+unmap:
+	dma_unmap_single(uart->dev, dma->phys, UARTDM_RX_SIZE, dma->dir);
+}
+
 static void msm_stop_rx(struct uart_port *port)
 {
 	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_dma *dma = &msm_port->rx_dma;

 	msm_port->imr &= ~(UART_IMR_RXLEV | UART_IMR_RXSTALE);
 	msm_write(port, msm_port->imr, UART_IMR);
+
+	if (dma->chan)
+		msm_stop_dma(port, dma);
 }

 static void msm_enable_ms(struct uart_port *port)
@@ -392,6 +590,9 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 		msm_write(port, UART_CR_CMD_RESET_STALE_INT, UART_CR);
 	msm_write(port, 0xFFFFFF, UARTDM_DMRX);
 	msm_write(port, UART_CR_CMD_STALE_EVENT_ENABLE, UART_CR);
+
+	/* Try to use DMA */
+	msm_start_rx_dma(msm_port);
 }

 static void msm_handle_rx(struct uart_port *port)
@@ -558,8 +759,10 @@ static irqreturn_t msm_irq(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_dma *dma = &msm_port->rx_dma;
 	unsigned long flags;
 	unsigned int misr;
+	u32 val;

 	spin_lock_irqsave(&port->lock, flags);
 	misr = msm_read(port, UART_MISR);
@@ -571,10 +774,21 @@ static irqreturn_t msm_irq(int irq, void *dev_id)
 	}

 	if (misr & (UART_IMR_RXLEV | UART_IMR_RXSTALE)) {
-		if (msm_port->is_uartdm)
+		if (dma->count) {
+			val = UART_CR_CMD_STALE_EVENT_DISABLE;
+			msm_write(port, val, UART_CR);
+			val = UART_CR_CMD_RESET_STALE_INT;
+			msm_write(port, val, UART_CR);
+			/*
+			 * Flush DMA input fifo to memory, this will also
+			 * trigger DMA RX completion
+			 */
+			dmaengine_terminate_all(dma->chan);
+		} else if (msm_port->is_uartdm) {
 			msm_handle_rx_dm(port, misr);
-		else
+		} else {
 			msm_handle_rx(port);
+		}
 	}
 	if (misr & UART_IMR_TXLEV)
 		msm_handle_tx(port);
@@ -773,8 +987,10 @@ static int msm_startup(struct uart_port *port)
 	data |= UART_MR1_AUTO_RFR_LEVEL0 & rfr_level;
 	msm_write(port, data, UART_MR1);

-	if (msm_port->is_uartdm)
+	if (msm_port->is_uartdm) {
 		msm_request_tx_dma(msm_port, msm_port->uart.mapbase);
+		msm_request_rx_dma(msm_port, msm_port->uart.mapbase);
+	}

 	return 0;
 }
@@ -797,11 +1013,16 @@ static void msm_shutdown(struct uart_port *port)
 static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
+	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_dma *dma = &msm_port->rx_dma;
 	unsigned long flags;
 	unsigned int baud, mr;

 	spin_lock_irqsave(&port->lock, flags);

+	if (dma->chan) /* Terminate if any */
+		msm_stop_dma(port, dma);
+
 	/* calculate and set baud rate */
 	baud = uart_get_baud_rate(port, termios, old, 300, 115200);
 	baud = msm_set_baud_rate(port, baud);
@@ -866,6 +1087,9 @@ static void msm_set_termios(struct uart_port *port, struct ktermios *termios,

 	uart_update_timeout(port, termios->c_cflag, baud);

+	/* Try to use DMA */
+	msm_start_rx_dma(msm_port);
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }

diff --git a/drivers/tty/serial/msm_serial.h b/drivers/tty/serial/msm_serial.h
index 8a5ca6a01de4..bc1d7b39eba8 100644
--- a/drivers/tty/serial/msm_serial.h
+++ b/drivers/tty/serial/msm_serial.h
@@ -59,6 +59,7 @@
 #define UART_CR_CMD_SET_RFR		(13 << 4)
 #define UART_CR_CMD_RESET_RFR		(14 << 4)
 #define UART_CR_CMD_PROTECTION_EN	(16 << 4)
+#define UART_CR_CMD_STALE_EVENT_DISABLE	(6 << 8)
 #define UART_CR_CMD_STALE_EVENT_ENABLE	(5 << 8)
 #define UART_CR_CMD_FORCE_STALE		(4 << 8)
 #define UART_CR_CMD_RESET_TX_READY	(3 << 8)
@@ -124,6 +125,9 @@
 #define UARTDM_DMEN_TX_BAM_ENABLE BIT(2)	/* UARTDM_1P4 */
 #define UARTDM_DMEN_TX_DM_ENABLE  BIT(0)	/* < UARTDM_1P4 */

+#define UARTDM_DMEN_RX_BAM_ENABLE BIT(3)	/* UARTDM_1P4 */
+#define UARTDM_DMEN_RX_DM_ENABLE  BIT(1)	/* < UARTDM_1P4 */
+
 #define UARTDM_DMRX		0x34
 #define UARTDM_NCF_TX		0x40
 #define UARTDM_RX_TOTAL_SNAP	0x38
--
1.9.1
