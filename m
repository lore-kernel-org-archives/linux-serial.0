From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH 2/2] serial: fsl_lpuart: add eDMA support
Date: Thu, 9 Jan 2014 11:04:41 +0800
Message-ID: <1389236681-30372-3-git-send-email-yao.yuan@freescale.com>
References: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:45651
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751585AbaAIEBK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Jan 2014 23:01:10 -0500
In-Reply-To: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org
Cc: linux@arm.linux.org.uk, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 .../devicetree/bindings/serial/fsl-lpuart.txt      |  17 +-
 drivers/tty/serial/fsl_lpuart.c                    | 434 +++++++++++++++++----
 2 files changed, 365 insertions(+), 86 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index 6fd1dd1..311598d 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -4,11 +4,20 @@ Required properties:
 - compatible : Should be "fsl,<soc>-lpuart"
 - reg : Address and length of the register set for the device
 - interrupts : Should contain uart interrupt
+- clocks : clocks: from common clock binding: handle to uart clock
+- clock-names : from common clock binding: Shall be "jpg"
+- dma-names: Should contain "lpuart-tx" for transmit and "lpuart-rx" for receive channels
+- dmas: Should contain dma specifiers for transmit and receive channels
 
 Example:
 
 uart0: serial@40027000 {
-	       compatible = "fsl,vf610-lpuart";
-	       reg = <0x40027000 0x1000>;
-	       interrupts = <0 61 0x00>;
-       };
+		compatible = "fsl,vf610-lpuart";
+		reg = <0x40027000 0x1000>;
+		interrupts = <0 61 0x00>;
+		clocks = <&clks VF610_CLK_UART0>;
+		clock-names = "ipg";
+		dma-names = "lpuart-tx","lpuart-rx";
+		dmas = <&edma0 0 VF610_EDMA_MUXID0_UART0_TX>,
+			<&edma0 0 VF610_EDMA_MUXID0_UART0_RX>;
+	};
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 67b8946..265ad67 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -13,14 +13,19 @@
 #define SUPPORT_SYSRQ
 #endif
 
-#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/clk.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/console.h>
+#include <linux/of_dma.h>
 #include <linux/serial_core.h>
+#include <linux/slab.h>
 #include <linux/tty_flip.h>
 
 /* All registers are 8-bit width */
@@ -112,6 +117,10 @@
 #define UARTSFIFO_TXOF		0x02
 #define UARTSFIFO_RXUF		0x01
 
+#define DMA_TX_MAXBURST		16
+#define DMA_TX_MAXBURST_MASK	(DMA_TX_MAXBURST - 1)
+#define DMA_RX_BUFFER_SIZE	64
+
 #define DRIVER_NAME	"fsl-lpuart"
 #define DEV_NAME	"ttyLP"
 #define UART_NR		6
@@ -121,6 +130,24 @@ struct lpuart_port {
 	struct clk		*clk;
 	unsigned int		txfifo_size;
 	unsigned int		rxfifo_size;
+
+	struct dma_chan		*dma_tx_chan;
+	struct dma_chan		*dma_rx_chan;
+	struct dma_async_tx_descriptor  *dma_tx_desc;
+	struct dma_async_tx_descriptor  *dma_rx_desc;
+	dma_addr_t		dma_tx_buf_bus;
+	dma_addr_t		dma_rx_buf_bus;
+	dma_cookie_t		dma_tx_cookie;
+	dma_cookie_t		dma_rx_cookie;
+	unsigned char		*dma_tx_buf_virt;
+	unsigned char		*dma_rx_buf_virt;
+	unsigned int		dma_tx_bytes;
+	unsigned int		dma_rx_bytes;
+	int			dma_tx_in_progress;
+	int			dma_rx_in_progress;
+	unsigned int		dma_rx_timeout;
+
+	struct timer_list	lpuart_timer;
 };
 
 static struct of_device_id lpuart_dt_ids[] = {
@@ -131,6 +158,10 @@ static struct of_device_id lpuart_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
 
+static int lpuart_dma_tx(struct lpuart_port *sport, unsigned long count);
+static int lpuart_dma_rx(struct lpuart_port *sport);
+static void lpuart_prepare_tx(struct lpuart_port *sport);
+
 static void lpuart_stop_tx(struct uart_port *port)
 {
 	unsigned char temp;
@@ -152,124 +183,222 @@ static void lpuart_enable_ms(struct uart_port *port)
 {
 }
 
-static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
+static void lpuart_dma_tx_complete(void *arg)
 {
+	struct lpuart_port *sport = arg;
 	struct circ_buf *xmit = &sport->port.state->xmit;
+	unsigned long flags;
 
-	while (!uart_circ_empty(xmit) &&
-		(readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size)) {
-		writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		sport->port.icount.tx++;
-	}
+	async_tx_ack(sport->dma_tx_desc);
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+
+	xmit->tail = (xmit->tail + sport->dma_tx_bytes) & (UART_XMIT_SIZE - 1);
+	sport->dma_tx_in_progress = 0;
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&sport->port);
 
-	if (uart_circ_empty(xmit))
-		lpuart_stop_tx(&sport->port);
+	lpuart_prepare_tx(sport);
+
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
-static void lpuart_start_tx(struct uart_port *port)
+static void lpuart_copy_rx_to_tty(struct lpuart_port *sport,
+		struct tty_port *tty, int count)
 {
-	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned char temp;
+	int copied;
 
-	temp = readb(port->membase + UARTCR2);
-	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
+	sport->port.icount.rx += count;
+
+	if (!tty) {
+		dev_err(sport->port.dev, "No tty port\n");
+		return;
+	}
+
+	dma_sync_single_for_cpu(sport->port.dev, sport->dma_rx_buf_bus,
+			DMA_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
+	copied = tty_insert_flip_string(tty,
+			((unsigned char *)(sport->dma_rx_buf_virt)), count);
 
-	if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
-		lpuart_transmit_buffer(sport);
+	if (copied != count) {
+		WARN_ON(1);
+		dev_err(sport->port.dev, "RxData copy to tty layer failed\n");
+	}
+
+	dma_sync_single_for_device(sport->port.dev, sport->dma_rx_buf_bus,
+			DMA_RX_BUFFER_SIZE, DMA_TO_DEVICE);
 }
 
-static irqreturn_t lpuart_txint(int irq, void *dev_id)
+static void lpuart_dma_rx_complete(void *arg)
+{
+	struct lpuart_port *sport = arg;
+	struct tty_port *port = &sport->port.state->port;
+	unsigned long flags;
+
+	async_tx_ack(sport->dma_rx_desc);
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+
+	sport->dma_rx_in_progress = 0;
+	lpuart_copy_rx_to_tty(sport, port, DMA_RX_BUFFER_SIZE);
+	tty_flip_buffer_push(port);
+	lpuart_dma_rx(sport);
+
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+}
+
+static void lpuart_pio_tx(struct lpuart_port *sport)
 {
-	struct lpuart_port *sport = dev_id;
 	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sport->port.lock, flags);
-	if (sport->port.x_char) {
-		writeb(sport->port.x_char, sport->port.membase + UARTDR);
-		goto out;
-	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
-		lpuart_stop_tx(&sport->port);
-		goto out;
+	while (!uart_circ_empty(xmit) &&
+		readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size) {
+		writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		sport->port.icount.tx++;
 	}
 
-	lpuart_transmit_buffer(sport);
-
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&sport->port);
 
-out:
+	if (uart_circ_empty(xmit))
+		writeb(readb(sport->port.membase + UARTCR5) | UARTCR5_TDMAS,
+			sport->port.membase + UARTCR5);
+
 	spin_unlock_irqrestore(&sport->port.lock, flags);
-	return IRQ_HANDLED;
 }
 
-static irqreturn_t lpuart_rxint(int irq, void *dev_id)
+static int lpuart_dma_tx(struct lpuart_port *sport, unsigned long count)
 {
-	struct lpuart_port *sport = dev_id;
-	unsigned int flg, ignored = 0;
-	struct tty_port *port = &sport->port.state->port;
-	unsigned long flags;
-	unsigned char rx, sr;
+	struct circ_buf *xmit = &sport->port.state->xmit;
+	dma_addr_t tx_bus_addr;
+
+	dma_sync_single_for_device(sport->port.dev, sport->dma_tx_buf_bus,
+				UART_XMIT_SIZE, DMA_TO_DEVICE);
+	sport->dma_tx_bytes = count & ~(DMA_TX_MAXBURST_MASK);
+	tx_bus_addr = sport->dma_tx_buf_bus + xmit->tail;
+	sport->dma_tx_desc = dmaengine_prep_slave_single(sport->dma_tx_chan,
+					tx_bus_addr, sport->dma_tx_bytes,
+					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
+
+	if (!sport->dma_tx_desc) {
+		dev_err(sport->port.dev, "Not able to get desc for Tx\n");
+		return -EIO;
+	}
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	sport->dma_tx_desc->callback = lpuart_dma_tx_complete;
+	sport->dma_tx_desc->callback_param = sport;
+	sport->dma_tx_in_progress = 1;
+	sport->dma_tx_cookie = dmaengine_submit(sport->dma_tx_desc);
+	dma_async_issue_pending(sport->dma_tx_chan);
 
-	while (!(readb(sport->port.membase + UARTSFIFO) & UARTSFIFO_RXEMPT)) {
-		flg = TTY_NORMAL;
-		sport->port.icount.rx++;
-		/*
-		 * to clear the FE, OR, NF, FE, PE flags,
-		 * read SR1 then read DR
-		 */
-		sr = readb(sport->port.membase + UARTSR1);
-		rx = readb(sport->port.membase + UARTDR);
+	return 0;
+}
 
-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
-			continue;
+static int lpuart_dma_rx(struct lpuart_port *sport)
+{
+	dma_sync_single_for_device(sport->port.dev, sport->dma_rx_buf_bus,
+			DMA_RX_BUFFER_SIZE, DMA_TO_DEVICE);
+	sport->dma_rx_desc = dmaengine_prep_slave_single(sport->dma_rx_chan,
+			sport->dma_rx_buf_bus, DMA_RX_BUFFER_SIZE,
+			DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+
+	if (!sport->dma_rx_desc) {
+		dev_err(sport->port.dev, "Not able to get desc for Rx\n");
+		return -EIO;
+	}
 
-		if (sr & (UARTSR1_PE | UARTSR1_OR | UARTSR1_FE)) {
-			if (sr & UARTSR1_PE)
-				sport->port.icount.parity++;
-			else if (sr & UARTSR1_FE)
-				sport->port.icount.frame++;
+	sport->dma_rx_desc->callback = lpuart_dma_rx_complete;
+	sport->dma_rx_desc->callback_param = sport;
+	sport->dma_rx_in_progress = 1;
+	sport->dma_rx_cookie = dmaengine_submit(sport->dma_rx_desc);
+	dma_async_issue_pending(sport->dma_rx_chan);
 
-			if (sr & UARTSR1_OR)
-				sport->port.icount.overrun++;
+	return 0;
+}
 
-			if (sr & sport->port.ignore_status_mask) {
-				if (++ignored > 100)
-					goto out;
-				continue;
-			}
+static void lpuart_prepare_tx(struct lpuart_port *sport)
+{
+	struct circ_buf *xmit = &sport->port.state->xmit;
+	unsigned long count =  CIRC_CNT_TO_END(xmit->head,
+					xmit->tail, UART_XMIT_SIZE);
 
-			sr &= sport->port.read_status_mask;
+	if (!count)
+		return;
 
-			if (sr & UARTSR1_PE)
-				flg = TTY_PARITY;
-			else if (sr & UARTSR1_FE)
-				flg = TTY_FRAME;
+	if (count < DMA_TX_MAXBURST)
+		writeb(readb(sport->port.membase + UARTCR5) & ~UARTCR5_TDMAS,
+				sport->port.membase + UARTCR5);
+	else {
+		writeb(readb(sport->port.membase + UARTCR5) | UARTCR5_TDMAS,
+				sport->port.membase + UARTCR5);
+		lpuart_dma_tx(sport, count);
+	}
+}
 
-			if (sr & UARTSR1_OR)
-				flg = TTY_OVERRUN;
+static void lpuart_timer_func(unsigned long data)
+{
+	struct lpuart_port *sport = (struct lpuart_port *)data;
+	struct tty_port *port = &sport->port.state->port;
+	struct dma_tx_state state;
+	unsigned long flags;
+	unsigned char temp;
+	int count;
 
-#ifdef SUPPORT_SYSRQ
-			sport->port.sysrq = 0;
-#endif
-		}
+	del_timer(&sport->lpuart_timer);
+	dmaengine_pause(sport->dma_rx_chan);
+	dmaengine_tx_status(sport->dma_rx_chan, sport->dma_rx_cookie, &state);
+	dmaengine_terminate_all(sport->dma_rx_chan);
+	count = DMA_RX_BUFFER_SIZE - state.residue;
+	async_tx_ack(sport->dma_rx_desc);
 
-		tty_insert_flip_char(port, rx, flg);
-	}
+	spin_lock_irqsave(&sport->port.lock, flags);
+
+	sport->dma_rx_in_progress = 0;
+	lpuart_copy_rx_to_tty(sport, port, count);
+	tty_flip_buffer_push(port);
+	temp = readb(sport->port.membase + UARTCR5);
+	writeb(temp & ~UARTCR5_RDMAS, sport->port.membase + UARTCR5);
 
-out:
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+}
 
-	tty_flip_buffer_push(port);
-	return IRQ_HANDLED;
+static inline void lpuart_prepare_rx(struct lpuart_port *sport)
+{
+	unsigned long flags;
+	unsigned char temp;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+
+	init_timer(&sport->lpuart_timer);
+	sport->lpuart_timer.function = lpuart_timer_func;
+	sport->lpuart_timer.data = (unsigned long)sport;
+	sport->lpuart_timer.expires = jiffies + sport->dma_rx_timeout;
+	add_timer(&sport->lpuart_timer);
+
+	lpuart_dma_rx(sport);
+	temp = readb(sport->port.membase + UARTCR5);
+	writeb(temp | UARTCR5_RDMAS, sport->port.membase + UARTCR5);
+
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+}
+
+static void lpuart_start_tx(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port,
+			struct lpuart_port, port);
+	struct circ_buf *xmit = &sport->port.state->xmit;
+	unsigned char temp;
+
+	temp = readb(port->membase + UARTCR2);
+	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
+
+	if (!uart_circ_empty(xmit) && !sport->dma_tx_in_progress)
+		lpuart_prepare_tx(sport);
 }
 
 static irqreturn_t lpuart_int(int irq, void *dev_id)
@@ -280,11 +409,12 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
 	sts = readb(sport->port.membase + UARTSR1);
 
 	if (sts & UARTSR1_RDRF)
-		lpuart_rxint(irq, dev_id);
+		lpuart_prepare_rx(sport);
 
 	if (sts & UARTSR1_TDRE &&
-		!(readb(sport->port.membase + UARTCR5) & UARTCR5_TDMAS))
-		lpuart_txint(irq, dev_id);
+		!(readb(sport->port.membase + UARTCR5) & UARTCR5_TDMAS)) {
+		lpuart_pio_tx(sport);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -366,19 +498,155 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 	writeb(UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH,
 			sport->port.membase + UARTCFIFO);
 
-	writeb(2, sport->port.membase + UARTTWFIFO);
+	writeb(0, sport->port.membase + UARTTWFIFO);
 	writeb(1, sport->port.membase + UARTRWFIFO);
 
 	/* Restore cr2 */
 	writeb(cr2_saved, sport->port.membase + UARTCR2);
 }
 
+static int lpuart_dma_tx_request(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port,
+					struct lpuart_port, port);
+	struct dma_chan *tx_chan;
+	struct dma_slave_config dma_tx_sconfig;
+	dma_addr_t dma_bus;
+	unsigned char *dma_buf;
+	int ret;
+
+	tx_chan  = dma_request_slave_channel(sport->port.dev, "lpuart-tx");
+
+	if (!tx_chan) {
+		dev_err(sport->port.dev, "Dma TX channel request failed!\n");
+		return -ENODEV;
+	}
+
+	dma_bus = dma_map_single(tx_chan->device->dev,
+				sport->port.state->xmit.buf,
+				UART_XMIT_SIZE, DMA_TO_DEVICE);
+
+	if (dma_mapping_error(tx_chan->device->dev, dma_bus)) {
+		dev_err(sport->port.dev, "dma_map_single TX failed\n");
+		return -ENOMEM;
+	}
+
+	dma_buf = sport->port.state->xmit.buf;
+	dma_tx_sconfig.dst_addr = sport->port.mapbase + UARTDR;
+	dma_tx_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_tx_sconfig.dst_maxburst = DMA_TX_MAXBURST;
+	dma_tx_sconfig.direction = DMA_MEM_TO_DEV;
+	ret = dmaengine_slave_config(tx_chan, &dma_tx_sconfig);
+
+	if (ret < 0) {
+		dev_err(sport->port.dev,
+				"Dma slave config failed, err = %d\n", ret);
+		dma_release_channel(tx_chan);
+		return ret;
+	}
+
+	sport->dma_tx_chan = tx_chan;
+	sport->dma_tx_buf_virt = dma_buf;
+	sport->dma_tx_buf_bus = dma_bus;
+	sport->dma_tx_in_progress = 0;
+
+	return 0;
+}
+
+static int lpuart_dma_rx_request(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port,
+					struct lpuart_port, port);
+	struct dma_chan *rx_chan;
+	struct dma_slave_config dma_rx_sconfig;
+	dma_addr_t dma_bus;
+	unsigned char *dma_buf;
+	int ret;
+
+	rx_chan  = dma_request_slave_channel(sport->port.dev, "lpuart-rx");
+
+	if (!rx_chan) {
+		dev_err(sport->port.dev, "Dma RX channel request failed!\n");
+		return -ENODEV;
+	}
+
+	dma_buf = dma_alloc_coherent(rx_chan->device->dev,
+			DMA_RX_BUFFER_SIZE, &dma_bus, GFP_KERNEL);
+
+	if (!dma_bus) {
+		dev_err(sport->port.dev, "Dma_bus alloc failed\n");
+		return -ENOMEM;
+	}
+
+	dma_rx_sconfig.src_addr = sport->port.mapbase + UARTDR;
+	dma_rx_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_rx_sconfig.src_maxburst = 1;
+	dma_rx_sconfig.direction = DMA_DEV_TO_MEM;
+	ret = dmaengine_slave_config(rx_chan, &dma_rx_sconfig);
+
+	if (ret < 0) {
+		dev_err(sport->port.dev,
+				"Dma slave config failed, err = %d\n", ret);
+		dma_release_channel(rx_chan);
+		return ret;
+	}
+
+	sport->dma_rx_chan = rx_chan;
+	sport->dma_rx_buf_virt = dma_buf;
+	sport->dma_rx_buf_bus = dma_bus;
+	sport->dma_rx_in_progress = 0;
+
+	sport->dma_rx_timeout = (sport->port.timeout - HZ / 50) *
+				DMA_RX_BUFFER_SIZE * 3 /
+				sport->rxfifo_size / 2;
+
+	if (sport->dma_rx_timeout < msecs_to_jiffies(20))
+		sport->dma_rx_timeout = msecs_to_jiffies(20);
+
+	return 0;
+}
+
+static void lpuart_dma_tx_free(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port,
+					struct lpuart_port, port);
+	struct dma_chan *dma_chan;
+
+	dma_unmap_single(sport->port.dev, sport->dma_tx_buf_bus,
+			UART_XMIT_SIZE, DMA_TO_DEVICE);
+	dma_chan = sport->dma_tx_chan;
+	sport->dma_tx_chan = NULL;
+	sport->dma_tx_buf_bus = 0;
+	sport->dma_tx_buf_virt = NULL;
+	dma_release_channel(dma_chan);
+}
+
+static void lpuart_dma_rx_free(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port,
+					struct lpuart_port, port);
+	struct dma_chan *dma_chan;
+
+	dma_free_coherent(sport->port.dev, DMA_RX_BUFFER_SIZE,
+			sport->dma_rx_buf_virt, sport->dma_rx_buf_bus);
+
+	dma_chan = sport->dma_rx_chan;
+	sport->dma_rx_chan = NULL;
+	sport->dma_rx_buf_bus = 0;
+	sport->dma_rx_buf_virt = NULL;
+	dma_release_channel(dma_chan);
+}
+
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	int ret;
 	unsigned long flags;
 	unsigned char temp;
+
+	lpuart_dma_tx_request(port);
+	lpuart_dma_rx_request(port);
+
 	ret = devm_request_irq(port->dev, port->irq, lpuart_int, 0,
 				DRIVER_NAME, sport);
 	if (ret)
@@ -392,6 +658,9 @@ static int lpuart_startup(struct uart_port *port)
 	temp |= (UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE);
 	writeb(temp, sport->port.membase + UARTCR2);
 
+	temp = readb(port->membase + UARTCR5);
+	writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
+
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 	return 0;
 }
@@ -413,6 +682,9 @@ static void lpuart_shutdown(struct uart_port *port)
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	devm_free_irq(port->dev, port->irq, sport);
+
+	lpuart_dma_tx_free(port);
+	lpuart_dma_rx_free(port);
 }
 
 static void
-- 
1.8.4


