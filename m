From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 08/12] serial: mxs-auart: move to use generic DMA helper
Date: Tue, 5 Mar 2013 20:24:00 +0800
Message-ID: <1362486244-24593-9-git-send-email-shawn.guo@linaro.org>
References: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [216.32.181.183] ([216.32.181.183]:12276 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752544Ab3CEM0p (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Mar 2013 07:26:45 -0500
In-Reply-To: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marek.vasut@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Huang Shijie <b32955@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

With the generic DMA device tree helper supported by mxs-dma driver,
client devices only need to call dma_request_slave_channel() for
requesting a DMA channel from dmaengine.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
---
 .../bindings/tty/serial/fsl-mxs-auart.txt          |   16 +++---
 drivers/tty/serial/mxs-auart.c                     |   52 ++------------------
 2 files changed, 11 insertions(+), 57 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
index 273a8d5..2c00ec6 100644
--- a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
@@ -5,20 +5,18 @@ Required properties:
   imx23 and imx28.
 - reg : Address and length of the register set for the device
 - interrupts : Should contain the auart interrupt numbers
-
-Optional properties:
-- fsl,auart-dma-channel : The DMA channels, the first is for RX, the other
-		is for TX. If you add this property, it also means that you
-		will enable the DMA support for the auart.
-		Note: due to the hardware bug in imx23(see errata : 2836),
-		only the imx28 can enable the DMA support for the auart.
+- dmas: DMA specifier, consisting of a phandle to DMA controller node
+  and AUART DMA channel ID.
+  Refer to dma.txt and fsl-mxs-dma.txt for details.
+- dma-names: "rx" for RX channel, "tx" for TX channel.
 
 Example:
 auart0: serial@8006a000 {
 	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 	reg = <0x8006a000 0x2000>;
-	interrupts = <112 70 71>;
-	fsl,auart-dma-channel = <8 9>;
+	interrupts = <112>;
+	dmas = <&dma_apbx 8>, <&dma_apbx 9>;
+	dma-names = "rx", "tx";
 };
 
 Note: Each auart port should have an alias correctly numbered in "aliases"
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index d549fe1..269a27c 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -35,7 +35,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/of_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/fsl/mxs-dma.h>
+#include <linux/dmaengine.h>
 
 #include <asm/cacheflush.h>
 
@@ -148,11 +148,6 @@ struct mxs_auart_port {
 	struct device *dev;
 
 	/* for DMA */
-	struct mxs_dma_data dma_data;
-	int dma_channel_rx, dma_channel_tx;
-	int dma_irq_rx, dma_irq_tx;
-	int dma_channel;
-
 	struct scatterlist tx_sgl;
 	struct dma_chan	*tx_dma_chan;
 	void *tx_dma_buf;
@@ -440,20 +435,6 @@ static u32 mxs_auart_get_mctrl(struct uart_port *u)
 	return mctrl;
 }
 
-static bool mxs_auart_dma_filter(struct dma_chan *chan, void *param)
-{
-	struct mxs_auart_port *s = param;
-
-	if (!mxs_dma_is_apbx(chan))
-		return false;
-
-	if (s->dma_channel == chan->chan_id) {
-		chan->private = &s->dma_data;
-		return true;
-	}
-	return false;
-}
-
 static int mxs_auart_dma_prep_rx(struct mxs_auart_port *s);
 static void dma_rx_callback(void *arg)
 {
@@ -545,21 +526,11 @@ static void mxs_auart_dma_exit(struct mxs_auart_port *s)
 
 static int mxs_auart_dma_init(struct mxs_auart_port *s)
 {
-	dma_cap_mask_t mask;
-
 	if (auart_dma_enabled(s))
 		return 0;
 
-	/* We do not get the right DMA channels. */
-	if (s->dma_channel_rx == -1 || s->dma_channel_tx == -1)
-		return -EINVAL;
-
 	/* init for RX */
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	s->dma_channel = s->dma_channel_rx;
-	s->dma_data.chan_irq = s->dma_irq_rx;
-	s->rx_dma_chan = dma_request_channel(mask, mxs_auart_dma_filter, s);
+	s->rx_dma_chan = dma_request_slave_channel(s->dev, "rx");
 	if (!s->rx_dma_chan)
 		goto err_out;
 	s->rx_dma_buf = kzalloc(UART_XMIT_SIZE, GFP_KERNEL | GFP_DMA);
@@ -567,9 +538,7 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
 		goto err_out;
 
 	/* init for TX */
-	s->dma_channel = s->dma_channel_tx;
-	s->dma_data.chan_irq = s->dma_irq_tx;
-	s->tx_dma_chan = dma_request_channel(mask, mxs_auart_dma_filter, s);
+	s->tx_dma_chan = dma_request_slave_channel(s->dev, "tx");
 	if (!s->tx_dma_chan)
 		goto err_out;
 	s->tx_dma_buf = kzalloc(UART_XMIT_SIZE, GFP_KERNEL | GFP_DMA);
@@ -1020,7 +989,6 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 		struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	u32 dma_channel[2];
 	int ret;
 
 	if (!np)
@@ -1034,20 +1002,8 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 	}
 	s->port.line = ret;
 
-	s->dma_irq_rx = platform_get_irq(pdev, 1);
-	s->dma_irq_tx = platform_get_irq(pdev, 2);
+	s->flags |= MXS_AUART_DMA_CONFIG;
 
-	ret = of_property_read_u32_array(np, "fsl,auart-dma-channel",
-					dma_channel, 2);
-	if (ret == 0) {
-		s->dma_channel_rx = dma_channel[0];
-		s->dma_channel_tx = dma_channel[1];
-
-		s->flags |= MXS_AUART_DMA_CONFIG;
-	} else {
-		s->dma_channel_rx = -1;
-		s->dma_channel_tx = -1;
-	}
 	return 0;
 }
 
-- 
1.7.9.5


