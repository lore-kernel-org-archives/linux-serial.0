From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: [PATCH v6] drivers/tty: amba: defer DMA probe until the DMA channel
 is required.
Date: Fri,  6 Mar 2015 13:05:40 -0500
Message-ID: <1425665140-1827-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, robh@kernel.org
List-Id: linux-serial@vger.kernel.org

Fix a race condition that happens when device_initcall(pl011_dma_initicall)
is executed before all the devices have been probed - this issue was observed on
a hisi_6220 SoC (HiKey board from Linaro).

The deferred driver probing framework relies on late_initcall to trigger
deferred probes so it is just possible that, even with a valid DMA driver ready
to be loaded, we fail to synchronize with it.

The proposed implementation delays probing the DMA until dma_startup.

As this is invoked on port startup and port resume - but DMA probing is only
required once - we avoid calling multiple times using a new field in
uart_amba_port to track this scenario.

This commit allows for subsequent attempts to associate an external DMA if the
DMA driver itself is not available (but present in the deferred probe pending
list).

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/amba-pl011.c | 71 ++++++++++-------------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8d94c19..f34f85c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -164,6 +164,7 @@ struct uart_amba_port {
 	bool			using_rx_dma;
 	struct pl011_dmarx_data dmarx;
 	struct pl011_dmatx_data	dmatx;
+	bool			dma_probed;
 #endif
 };
 
@@ -261,10 +262,11 @@ static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
 	}
 }
 
-static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *uap)
+static void pl011_dma_probe(struct uart_amba_port *uap)
 {
 	/* DMA is the sole user of the platform data right now */
 	struct amba_pl011_data *plat = dev_get_platdata(uap->port.dev);
+	struct device *dev = uap->port.dev;
 	struct dma_slave_config tx_conf = {
 		.dst_addr = uap->port.mapbase + UART01x_DR,
 		.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
@@ -275,9 +277,15 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 	struct dma_chan *chan;
 	dma_cap_mask_t mask;
 
-	chan = dma_request_slave_channel(dev, "tx");
+	uap->dma_probed = true;
+	chan = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(chan)) {
+		if (PTR_ERR(chan) == -EPROBE_DEFER) {
+			dev_info(uap->port.dev, "DMA driver not ready\n");
+			uap->dma_probed = false;
+			return;
+		}
 
-	if (!chan) {
 		/* We need platform data */
 		if (!plat || !plat->dma_filter) {
 			dev_info(uap->port.dev, "no DMA platform data\n");
@@ -385,55 +393,8 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 	}
 }
 
-#ifndef MODULE
-/*
- * Stack up the UARTs and let the above initcall be done at device
- * initcall time, because the serial driver is called as an arch
- * initcall, and at this time the DMA subsystem is not yet registered.
- * At this point the driver will switch over to using DMA where desired.
- */
-struct dma_uap {
-	struct list_head node;
-	struct uart_amba_port *uap;
-	struct device *dev;
-};
-
-static LIST_HEAD(pl011_dma_uarts);
-
-static int __init pl011_dma_initcall(void)
-{
-	struct list_head *node, *tmp;
-
-	list_for_each_safe(node, tmp, &pl011_dma_uarts) {
-		struct dma_uap *dmau = list_entry(node, struct dma_uap, node);
-		pl011_dma_probe_initcall(dmau->dev, dmau->uap);
-		list_del(node);
-		kfree(dmau);
-	}
-	return 0;
-}
-
-device_initcall(pl011_dma_initcall);
-
-static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
-{
-	struct dma_uap *dmau = kzalloc(sizeof(struct dma_uap), GFP_KERNEL);
-	if (dmau) {
-		dmau->uap = uap;
-		dmau->dev = dev;
-		list_add_tail(&dmau->node, &pl011_dma_uarts);
-	}
-}
-#else
-static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
-{
-	pl011_dma_probe_initcall(dev, uap);
-}
-#endif
-
 static void pl011_dma_remove(struct uart_amba_port *uap)
 {
-	/* TODO: remove the initcall if it has not yet executed */
 	if (uap->dmatx.chan)
 		dma_release_channel(uap->dmatx.chan);
 	if (uap->dmarx.chan)
@@ -1021,6 +982,9 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 {
 	int ret;
 
+	if (!uap->dma_probed)
+		pl011_dma_probe(uap);
+
 	if (!uap->dmatx.chan)
 		return;
 
@@ -1142,7 +1106,7 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
 
 #else
 /* Blank functions if the DMA engine is not available */
-static inline void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
+static inline void pl011_dma_probe(struct uart_amba_port *uap)
 {
 }
 
@@ -2218,7 +2182,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.ops = &amba_pl011_pops;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = i;
-	pl011_dma_probe(&dev->dev, uap);
 
 	/* Ensure interrupts from this UART are masked and cleared */
 	writew(0, uap->port.membase + UART011_IMSC);
@@ -2233,7 +2196,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	if (!amba_reg.state) {
 		ret = uart_register_driver(&amba_reg);
 		if (ret < 0) {
-			pr_err("Failed to register AMBA-PL011 driver\n");
+			dev_err(&dev->dev,
+				"Failed to register AMBA-PL011 driver\n");
 			return ret;
 		}
 	}
@@ -2242,7 +2206,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	if (ret) {
 		amba_ports[i] = NULL;
 		uart_unregister_driver(&amba_reg);
-		pl011_dma_remove(uap);
 	}
 
 	return ret;
-- 
1.9.1
