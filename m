From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 4/6] serial: samsung: add dma reqest/release functions
Date: Wed, 10 Dec 2014 12:49:25 +0100
Message-ID: <1418212167-28992-5-git-send-email-r.baldyga@samsung.com>
References: <1418212167-28992-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1418212167-28992-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, akpm@linux-foundation.org, kgene.kim@samsung.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, l.czerwinski@samsung.com, s.nawrocki@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

Add functions requesting and releasing RX and TX DMA channels. This
function are called only when "dmas" property in serial device-tree
node is defined.

Based on previous work of Sylwester Nawrocki and Lukasz Czerwinski.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/tty/serial/samsung.c | 101 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 7196a3e..825c819 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -28,6 +28,9 @@
 #define SUPPORT_SYSRQ
 #endif
 
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
@@ -453,6 +456,93 @@ static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
+{
+	struct s3c24xx_uart_dma	*dma = p->dma;
+	dma_cap_mask_t mask;
+	unsigned long flags;
+
+	/* Default slave configuration parameters */
+	dma->rx_conf.direction		= DMA_DEV_TO_MEM;
+	dma->rx_conf.src_addr_width	= DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma->rx_conf.src_addr		= p->port.mapbase + S3C2410_URXH;
+	dma->rx_conf.src_maxburst	= 16;
+
+	dma->tx_conf.direction		= DMA_MEM_TO_DEV;
+	dma->tx_conf.dst_addr_width	= DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma->tx_conf.dst_addr		= p->port.mapbase + S3C2410_UTXH;
+	if (dma_get_cache_alignment() >= 16)
+		dma->tx_conf.dst_maxburst = 16;
+	else
+		dma->tx_conf.dst_maxburst = 1;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	dma->rx_chan = dma_request_slave_channel_compat(mask, dma->fn,
+					dma->rx_param, p->port.dev, "rx");
+	if (!dma->rx_chan)
+		return -ENODEV;
+
+	dmaengine_slave_config(dma->rx_chan, &dma->rx_conf);
+
+	dma->tx_chan = dma_request_slave_channel_compat(mask, dma->fn,
+					dma->tx_param, p->port.dev, "tx");
+	if (!dma->tx_chan) {
+		dma_release_channel(dma->rx_chan);
+		return -ENODEV;
+	}
+
+	dmaengine_slave_config(dma->tx_chan, &dma->tx_conf);
+
+	/* RX buffer */
+	dma->rx_size = PAGE_SIZE;
+
+	dma->rx_buf = kmalloc(dma->rx_size, GFP_KERNEL);
+
+	if (!dma->rx_buf) {
+		dma_release_channel(dma->rx_chan);
+		dma_release_channel(dma->tx_chan);
+		return -ENOMEM;
+	}
+
+	dma->rx_addr = dma_map_single(dma->rx_chan->device->dev, dma->rx_buf,
+				dma->rx_size, DMA_FROM_DEVICE);
+
+	spin_lock_irqsave(&p->port.lock, flags);
+
+	/* TX buffer */
+	dma->tx_addr = dma_map_single(dma->tx_chan->device->dev,
+				p->port.state->xmit.buf,
+				UART_XMIT_SIZE, DMA_TO_DEVICE);
+
+	spin_unlock_irqrestore(&p->port.lock, flags);
+
+	return 0;
+}
+
+static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
+{
+	struct s3c24xx_uart_dma	*dma = p->dma;
+
+	if (dma->rx_chan) {
+		dmaengine_terminate_all(dma->rx_chan);
+		dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
+				dma->rx_size, DMA_FROM_DEVICE);
+		kfree(dma->rx_buf);
+		dma_release_channel(dma->rx_chan);
+		dma->rx_chan = NULL;
+	}
+
+	if (dma->tx_chan) {
+		dmaengine_terminate_all(dma->tx_chan);
+		dma_unmap_single(dma->tx_chan->device->dev, dma->tx_addr,
+				UART_XMIT_SIZE, DMA_TO_DEVICE);
+		dma_release_channel(dma->tx_chan);
+		dma->tx_chan = NULL;
+	}
+}
+
 static void s3c24xx_serial_shutdown(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
@@ -478,6 +568,10 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
 		wr_regl(port, S3C64XX_UINTP, 0xf);
 		wr_regl(port, S3C64XX_UINTM, 0xf);
 	}
+
+	if (ourport->dma)
+		s3c24xx_serial_release_dma(ourport);
+
 }
 
 static int s3c24xx_serial_startup(struct uart_port *port)
@@ -535,6 +629,13 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	    port, (unsigned long long)port->mapbase, port->membase);
 
 	wr_regl(port, S3C64XX_UINTM, 0xf);
+	if (ourport->dma) {
+		ret = s3c24xx_serial_request_dma(ourport);
+		if (ret < 0) {
+			dev_warn(port->dev, "DMA request failed\n");
+			return ret;
+		}
+	}
 
 	ret = request_irq(port->irq, s3c64xx_serial_handle_irq, IRQF_SHARED,
 			  s3c24xx_serial_portname(port), ourport);
-- 
1.9.1
