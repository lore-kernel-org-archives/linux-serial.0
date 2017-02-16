From: Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH 3/4] serial: 8250-mtk: add uart DMA support
Date: Thu, 16 Feb 2017 19:07:30 +0800
Message-ID: <1487243251-964-4-git-send-email-long.cheng@mediatek.com>
References: <1487243251-964-1-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487243251-964-1-git-send-email-long.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Russell King <linux@armlinux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Long Cheng <long.cheng@mediatek.com>
List-Id: linux-serial@vger.kernel.org

Modify uart register to support DMA function.

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c |  194 +++++++++++++++++++++++++++++++++++-
 1 file changed, 193 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index ce0cc47..7d7a864 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -23,6 +23,10 @@
 #include <linux/pm_runtime.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
+#include <linux/console.h>
+#include <linux/dma-mapping.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 
 #include "8250.h"
 
@@ -30,13 +34,165 @@
 #define UART_MTK_SAMPLE_COUNT	0x0a	/* Sample count register */
 #define UART_MTK_SAMPLE_POINT	0x0b	/* Sample point register */
 #define MTK_UART_RATE_FIX	0x0d	/* UART Rate Fix Register */
-
+#define UART_MTK_DMA_EN		0x13
+#define TX_TRIGGER		1
+#define RX_TRIGGER		8192
+
+#ifdef CONFIG_SERIAL_8250_DMA
+enum dma_rx_status {
+	DMA_RX_START = 0,
+	DMA_RX_RUNNING = 1,
+	DMA_RX_SHUTDOWN = 2,
+};
+#endif
 struct mtk8250_data {
 	int			line;
+	int			rxpos;
 	struct clk		*uart_clk;
 	struct clk		*bus_clk;
+	struct uart_8250_dma	*dma;
+#ifdef CONFIG_SERIAL_8250_DMA
+	enum dma_rx_status	rxstatus;
+#endif
 };
 
+#ifdef CONFIG_SERIAL_8250_DMA
+static int mtk8250_rx_dma(struct uart_8250_port *up);
+
+static void __mtkdma_rx_complete(void *param)
+{
+	struct uart_8250_port *up = param;
+	struct uart_8250_dma *dma = up->dma;
+	struct mtk8250_data *data = up->port.private_data;
+	struct tty_port *tty_port = &up->port.state->port;
+	struct dma_tx_state state;
+	unsigned char *ptr;
+	int copied;
+
+	dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
+				dma->rx_size, DMA_FROM_DEVICE);
+
+	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	dmaengine_terminate_all(dma->rxchan);
+
+	if (data->rxstatus == DMA_RX_SHUTDOWN)
+		return;
+
+	if ((data->rxpos + state.residue) <= dma->rx_size) {
+		ptr = (unsigned char *)(data->rxpos + dma->rx_buf);
+		copied = tty_insert_flip_string(tty_port, ptr, state.residue);
+	} else {
+		ptr = (unsigned char *)(data->rxpos + dma->rx_buf);
+		copied = tty_insert_flip_string(tty_port, ptr,
+				(dma->rx_size - data->rxpos));
+		ptr = (unsigned char *)(dma->rx_buf);
+		copied += tty_insert_flip_string(tty_port, ptr,
+				(data->rxpos + state.residue - dma->rx_size));
+	}
+	up->port.icount.rx += copied;
+
+	tty_flip_buffer_push(tty_port);
+
+	mtk8250_rx_dma(up);
+}
+
+static int mtk8250_rx_dma(struct uart_8250_port *up)
+{
+	struct uart_8250_dma *dma = up->dma;
+	struct mtk8250_data *data = up->port.private_data;
+	struct dma_async_tx_descriptor	*desc;
+	struct dma_tx_state	 state;
+
+	desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
+					   dma->rx_size, DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		return -EBUSY;
+
+	desc->callback = __mtkdma_rx_complete;
+	desc->callback_param = up;
+
+	dma->rx_cookie = dmaengine_submit(desc);
+
+	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	data->rxpos = state.residue;
+
+	dma_sync_single_for_device(dma->rxchan->device->dev, dma->rx_addr,
+				   dma->rx_size, DMA_FROM_DEVICE);
+
+	dma_async_issue_pending(dma->rxchan);
+
+	return 0;
+}
+
+static void mtk_dma_enable(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	struct uart_8250_dma *dma = up->dma;
+	struct mtk8250_data *data = up->port.private_data;
+	int tmp = 0;
+
+	if (data->rxstatus != DMA_RX_START)
+		return;
+
+	dma->rxconf.direction		= DMA_DEV_TO_MEM;
+	dma->rxconf.src_addr_width	= dma->rx_size/1024;
+	dma->rxconf.src_addr		= dma->rx_addr;
+
+	dma->txconf.direction		= DMA_MEM_TO_DEV;
+	dma->txconf.dst_addr_width	= UART_XMIT_SIZE/1024;
+	dma->txconf.dst_addr		= dma->tx_addr;
+
+	serial_port_out(port, UART_FCR, ((1 << 0)|(1 << 1)|(1 << 2)));
+	serial_port_out(port, UART_MTK_DMA_EN,
+			(serial_port_in(port, UART_MTK_DMA_EN) |
+			((1 << 0) | (1 << 2))));
+	serial_port_out(port, UART_MTK_DMA_EN,
+			(serial_port_in(port, UART_MTK_DMA_EN) |
+			(1 << 1)));
+
+	tmp = serial_port_in(port, UART_LCR);
+	serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_port_out(port, UART_EFR, UART_EFR_ECB);
+	serial_port_out(port, UART_LCR, tmp);
+
+	dmaengine_slave_config(dma->rxchan, &dma->rxconf);
+	dmaengine_slave_config(dma->txchan, &dma->txconf);
+
+	data->rxstatus = DMA_RX_RUNNING;
+	data->rxpos = 0;
+	mtk8250_rx_dma(up);
+}
+#endif
+
+static int mtk8250_startup(struct uart_port *port)
+{
+#ifdef CONFIG_SERIAL_8250_DMA
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
+	struct mtk8250_data *data = port->private_data;
+
+	if (up->dma != NULL)
+		data->rxstatus = DMA_RX_START;
+#endif
+
+	return serial8250_do_startup(port);
+}
+
+static void mtk8250_shutdown(struct uart_port *port)
+{
+#ifdef CONFIG_SERIAL_8250_DMA
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
+	struct mtk8250_data *data = port->private_data;
+
+	if (up->dma != NULL)
+		data->rxstatus = DMA_RX_SHUTDOWN;
+#endif
+
+	return serial8250_do_shutdown(port);
+}
+
 static void
 mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 			struct ktermios *old)
@@ -44,6 +200,10 @@ struct mtk8250_data {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 	unsigned int baud, quot;
+#ifdef CONFIG_SERIAL_8250_DMA
+	if (up->dma != NULL)
+		mtk_dma_enable(up);
+#endif
 
 	serial8250_do_set_termios(port, termios, old);
 
@@ -152,9 +312,20 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 		pm_runtime_put_sync_suspend(port->dev);
 }
 
+#ifdef CONFIG_SERIAL_8250_DMA
+static bool the_no_dma_filter_fn(struct dma_chan *chan, void *param)
+{
+	return false;
+}
+#endif
+
 static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 			   struct mtk8250_data *data)
 {
+#ifdef CONFIG_SERIAL_8250_DMA
+	int dmacnt;
+#endif
+
 	data->uart_clk = devm_clk_get(&pdev->dev, "baud");
 	if (IS_ERR(data->uart_clk)) {
 		/*
@@ -174,6 +345,21 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 	if (IS_ERR(data->bus_clk))
 		return PTR_ERR(data->bus_clk);
 
+	data->dma = NULL;
+#ifdef CONFIG_SERIAL_8250_DMA
+	dmacnt = of_property_count_strings(pdev->dev.of_node, "dma-names");
+	if (dmacnt == 2) {
+		data->dma = devm_kzalloc(&pdev->dev,
+						sizeof(*(data->dma)),
+						GFP_KERNEL);
+		data->dma->fn = the_no_dma_filter_fn;
+		data->dma->rx_size = RX_TRIGGER;
+		data->dma->rxconf.src_maxburst = RX_TRIGGER;
+		data->dma->txconf.dst_maxburst = TX_TRIGGER;
+		data->dma->rx_dma = mtk8250_rx_dma;
+	}
+#endif
+
 	return 0;
 }
 
@@ -216,8 +402,14 @@ static int mtk8250_probe(struct platform_device *pdev)
 	uart.port.iotype = UPIO_MEM32;
 	uart.port.regshift = 2;
 	uart.port.private_data = data;
+	uart.port.shutdown = mtk8250_shutdown;
+	uart.port.startup = mtk8250_startup;
 	uart.port.set_termios = mtk8250_set_termios;
 	uart.port.uartclk = clk_get_rate(data->uart_clk);
+#ifdef CONFIG_SERIAL_8250_DMA
+	if (data->dma)
+		uart.dma = data->dma;
+#endif
 
 	/* Disable Rate Fix function */
 	writel(0x0, uart.port.membase +
-- 
1.7.9.5
