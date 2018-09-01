From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] tty: serial: Add Tx DMA support for UART in Actions Semi Owl SoCs
Date: Sat,  1 Sep 2018 22:12:15 +0530
Message-ID: <20180901164215.3683-4-manivannan.sadhasivam@linaro.org>
References: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de, robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, liuwei@actions-semi.com, 96boards@ucrobotics.com, devicetree@vger.kernel.org, daniel.thompson@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com, thomas.liau@actions-semi.com, jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-serial@vger.kernel.org

Add Tx DMA support for Actions Semi Owl SoCs. If there is no DMA
property specified in DT, it will fallback to default interrupt mode.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/tty/serial/owl-uart.c | 172 +++++++++++++++++++++++++++++++++-
 1 file changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 29a6dc6a8d23..1b3016db7ae2 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -11,6 +11,8 @@
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -48,6 +50,8 @@
 #define OWL_UART_CTL_RXIE		BIT(18)
 #define OWL_UART_CTL_TXIE		BIT(19)
 #define OWL_UART_CTL_LBEN		BIT(20)
+#define OWL_UART_CTL_DRCR		BIT(21)
+#define OWL_UART_CTL_DTCR		BIT(22)
 
 #define OWL_UART_STAT_RIP		BIT(0)
 #define OWL_UART_STAT_TIP		BIT(1)
@@ -71,12 +75,21 @@ struct owl_uart_info {
 struct owl_uart_port {
 	struct uart_port port;
 	struct clk *clk;
+
+	struct dma_chan *tx_ch;
+	dma_addr_t tx_dma_buf;
+	dma_cookie_t dma_tx_cookie;
+	u32 tx_size;
+	bool tx_dma;
+	bool dma_tx_running;
 };
 
 #define to_owl_uart_port(prt) container_of(prt, struct owl_uart_port, prt)
 
 static struct owl_uart_port *owl_uart_ports[OWL_UART_PORT_NUM];
 
+static void owl_uart_dma_start_tx(struct owl_uart_port *owl_port);
+
 static inline void owl_uart_write(struct uart_port *port, u32 val, unsigned int off)
 {
 	writel(val, port->membase + off);
@@ -115,6 +128,83 @@ static unsigned int owl_uart_get_mctrl(struct uart_port *port)
 	return mctrl;
 }
 
+static void owl_uart_dma_tx_callback(void *data)
+{
+	struct owl_uart_port *owl_port = data;
+	struct uart_port *port = &owl_port->port;
+	struct circ_buf	*xmit = &port->state->xmit;
+	unsigned long flags;
+	u32 val;
+
+	dma_sync_single_for_cpu(port->dev, owl_port->tx_dma_buf,
+				UART_XMIT_SIZE, DMA_TO_DEVICE);
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	owl_port->dma_tx_running = 0;
+
+	xmit->tail += owl_port->tx_size;
+	xmit->tail &= UART_XMIT_SIZE - 1;
+	port->icount.tx += owl_port->tx_size;
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	/* Disable Tx DRQ */
+	val = owl_uart_read(port, OWL_UART_CTL);
+	val &= ~OWL_UART_CTL_TXDE;
+	owl_uart_write(port, val, OWL_UART_CTL);
+
+	/* Clear pending Tx IRQ */
+	val = owl_uart_read(port, OWL_UART_STAT);
+	val |= OWL_UART_STAT_TIP;
+	owl_uart_write(port, val, OWL_UART_STAT);
+
+	if (!uart_circ_empty(xmit) && !uart_tx_stopped(port))
+		owl_uart_dma_start_tx(owl_port);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void owl_uart_dma_start_tx(struct owl_uart_port *owl_port)
+{
+	struct uart_port *port = &owl_port->port;
+	struct circ_buf *xmit = &port->state->xmit;
+	struct dma_async_tx_descriptor *desc;
+	u32 val;
+
+	if (uart_tx_stopped(port) || uart_circ_empty(xmit) ||
+	    owl_port->dma_tx_running)
+		return;
+
+	dma_sync_single_for_device(port->dev, owl_port->tx_dma_buf,
+				   UART_XMIT_SIZE, DMA_TO_DEVICE);
+
+	owl_port->tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail,
+					    UART_XMIT_SIZE);
+
+	desc = dmaengine_prep_slave_single(owl_port->tx_ch,
+					   owl_port->tx_dma_buf + xmit->tail,
+					   owl_port->tx_size, DMA_MEM_TO_DEV,
+					   DMA_PREP_INTERRUPT);
+	if (!desc)
+		return;
+
+	desc->callback = owl_uart_dma_tx_callback;
+	desc->callback_param = owl_port;
+
+	/* Enable Tx DRQ */
+	val = owl_uart_read(port, OWL_UART_CTL);
+	val &= ~OWL_UART_CTL_TXIE;
+	val |= OWL_UART_CTL_TXDE | OWL_UART_CTL_DTCR;
+	owl_uart_write(port, val, OWL_UART_CTL);
+
+	/* Start Tx DMA transfer */
+	owl_port->dma_tx_running = true;
+	owl_port->dma_tx_cookie = dmaengine_submit(desc);
+	dma_async_issue_pending(owl_port->tx_ch);
+}
+
 static unsigned int owl_uart_tx_empty(struct uart_port *port)
 {
 	unsigned long flags;
@@ -159,6 +249,7 @@ static void owl_uart_stop_tx(struct uart_port *port)
 
 static void owl_uart_start_tx(struct uart_port *port)
 {
+	struct owl_uart_port *owl_port = to_owl_uart_port(port);
 	u32 val;
 
 	if (uart_tx_stopped(port)) {
@@ -166,6 +257,11 @@ static void owl_uart_start_tx(struct uart_port *port)
 		return;
 	}
 
+	if (owl_port->tx_dma) {
+		owl_uart_dma_start_tx(owl_port);
+		return;
+	}
+
 	val = owl_uart_read(port, OWL_UART_STAT);
 	val |= OWL_UART_STAT_TIP;
 	owl_uart_write(port, val, OWL_UART_STAT);
@@ -273,13 +369,27 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void owl_dma_channel_free(struct owl_uart_port *owl_port)
+{
+	dmaengine_terminate_all(owl_port->tx_ch);
+	dma_release_channel(owl_port->tx_ch);
+	dma_unmap_single(owl_port->port.dev, owl_port->tx_dma_buf,
+			 UART_XMIT_SIZE, DMA_TO_DEVICE);
+	owl_port->dma_tx_running = false;
+	owl_port->tx_ch = NULL;
+}
+
 static void owl_uart_shutdown(struct uart_port *port)
 {
-	u32 val;
+	struct owl_uart_port *owl_port = to_owl_uart_port(port);
 	unsigned long flags;
+	u32 val;
 
 	spin_lock_irqsave(&port->lock, flags);
 
+	if (owl_port->tx_dma)
+		owl_dma_channel_free(owl_port);
+
 	val = owl_uart_read(port, OWL_UART_CTL);
 	val &= ~(OWL_UART_CTL_TXIE | OWL_UART_CTL_RXIE
 		| OWL_UART_CTL_TXDE | OWL_UART_CTL_RXDE | OWL_UART_CTL_EN);
@@ -290,6 +400,62 @@ static void owl_uart_shutdown(struct uart_port *port)
 	free_irq(port->irq, port);
 }
 
+static int owl_uart_dma_tx_init(struct uart_port *port)
+{
+	struct owl_uart_port *owl_port = to_owl_uart_port(port);
+	struct device *dev = port->dev;
+	struct dma_slave_config slave_config;
+	int ret;
+
+	owl_port->tx_dma = false;
+
+	/* Request DMA TX channel */
+	owl_port->tx_ch = dma_request_slave_channel(dev, "tx");
+	if (!owl_port->tx_ch) {
+		dev_info(dev, "tx dma alloc failed\n");
+		return -ENODEV;
+	}
+
+	owl_port->tx_dma_buf = dma_map_single(dev,
+					      owl_port->port.state->xmit.buf,
+					      UART_XMIT_SIZE, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, owl_port->tx_dma_buf)) {
+		ret = -ENOMEM;
+		goto alloc_err;
+	}
+
+	/* Configure DMA channel */
+	memset(&slave_config, 0, sizeof(slave_config));
+	slave_config.direction = DMA_MEM_TO_DEV;
+	slave_config.dst_addr = port->mapbase + OWL_UART_TXDAT;
+	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
+	ret = dmaengine_slave_config(owl_port->tx_ch, &slave_config);
+	if (ret < 0) {
+		dev_err(dev, "tx dma channel config failed\n");
+		ret = -ENODEV;
+		goto map_err;
+	}
+
+	/* Use DMA buffer size as the FIFO size */
+	port->fifosize = UART_XMIT_SIZE;
+
+	/* Set DMA flag */
+	owl_port->tx_dma = true;
+	owl_port->dma_tx_running = false;
+
+	return 0;
+
+map_err:
+	dma_unmap_single(dev, owl_port->tx_dma_buf, UART_XMIT_SIZE,
+			 DMA_TO_DEVICE);
+alloc_err:
+	dma_release_channel(owl_port->tx_ch);
+	owl_port->tx_ch = NULL;
+
+	return ret;
+}
+
 static int owl_uart_startup(struct uart_port *port)
 {
 	u32 val;
@@ -301,6 +467,10 @@ static int owl_uart_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
+	ret = owl_uart_dma_tx_init(port);
+	if (!ret)
+		dev_info(port->dev, "using DMA for tx\n");
+
 	spin_lock_irqsave(&port->lock, flags);
 
 	val = owl_uart_read(port, OWL_UART_STAT);
-- 
2.17.1
