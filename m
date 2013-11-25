From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2] serial: tegra: convert to standard DMA DT bindings
Date: Mon, 25 Nov 2013 14:51:10 -0700
Message-ID: <1385416270-3421-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45129 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab3KYVve (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Nov 2013 16:51:34 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stephen Warren <swarren@nvidia.com>, treding@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

From: Stephen Warren <swarren@nvidia.com>

By using dma_request_slave_channel_or_err(), the DMA slave ID can be
looked up from standard DT properties, and squirrelled away during
channel allocation. Hence, there's no need to use a custom DT property
to store the slave ID.

Cc: treding@nvidia.com
Cc: linux-tegra@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2:
* Don't allocate DMA channels inside probe(); the DMA channel setup
  relies on some buffers that don't get allocated until startup().

This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.

Greg, you'd previously ack'd this, but I had to change the patch to fix
some bugs, which was a fair textual change, so I dropped your ack.
---
 drivers/tty/serial/serial-tegra.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 4455481a3517..d5c2a287b7e7 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -120,7 +120,6 @@ struct tegra_uart_port {
 	bool					rx_timeout;
 	int					rx_in_progress;
 	int					symb_bit;
-	int					dma_req_sel;
 
 	struct dma_chan				*rx_dma_chan;
 	struct dma_chan				*tx_dma_chan;
@@ -910,15 +909,14 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 	dma_addr_t dma_phys;
 	int ret;
 	struct dma_slave_config dma_sconfig;
-	dma_cap_mask_t mask;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	dma_chan = dma_request_channel(mask, NULL, NULL);
-	if (!dma_chan) {
+	dma_chan = dma_request_slave_channel_reason(tup->uport.dev,
+						dma_to_memory ? "rx" : "tx");
+	if (IS_ERR(dma_chan)) {
+		ret = PTR_ERR(dma_chan);
 		dev_err(tup->uport.dev,
-			"Dma channel is not available, will try later\n");
-		return -EPROBE_DEFER;
+			"DMA channel alloc failed: %d\n", ret);
+		return ret;
 	}
 
 	if (dma_to_memory) {
@@ -938,7 +936,6 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 		dma_buf = tup->uport.state->xmit.buf;
 	}
 
-	dma_sconfig.slave_id = tup->dma_req_sel;
 	if (dma_to_memory) {
 		dma_sconfig.src_addr = tup->uport.mapbase;
 		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
@@ -1222,17 +1219,8 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
 	struct tegra_uart_port *tup)
 {
 	struct device_node *np = pdev->dev.of_node;
-	u32 of_dma[2];
 	int port;
 
-	if (of_property_read_u32_array(np, "nvidia,dma-request-selector",
-				of_dma, 2) >= 0) {
-		tup->dma_req_sel = of_dma[1];
-	} else {
-		dev_err(&pdev->dev, "missing dma requestor in device tree\n");
-		return -EINVAL;
-	}
-
 	port = of_alias_get_id(np, "serial");
 	if (port < 0) {
 		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", port);
-- 
1.8.1.5

