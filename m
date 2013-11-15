From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 25/31] serial: tegra: convert to standard DMA DT bindings
Date: Fri, 15 Nov 2013 13:54:20 -0700
Message-ID: <1384548866-13141-26-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51616 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab3KOUzu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Nov 2013 15:55:50 -0500
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: swarren@wwwdotorg.org
Cc: Stephen Warren <swarren@nvidia.com>, treding@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

From: Stephen Warren <swarren@nvidia.com>

By using dma_request_slave_channel_or_err(), the DMA slave ID can be
looked up from standard DT properties, and squirrelled away during
channel allocation. Hence, there's no need to use a custom DT property
to store the slave ID.

DMA channel allocation is moved to probe() so that deferred probe works.

Cc: treding@nvidia.com
Cc: linux-tegra@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 drivers/tty/serial/serial-tegra.c | 72 ++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 4455481a3517..e07c8bfe7459 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -120,7 +120,6 @@ struct tegra_uart_port {
 	bool					rx_timeout;
 	int					rx_in_progress;
 	int					symb_bit;
-	int					dma_req_sel;
 
 	struct dma_chan				*rx_dma_chan;
 	struct dma_chan				*tx_dma_chan;
@@ -910,15 +909,15 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 	dma_addr_t dma_phys;
 	int ret;
 	struct dma_slave_config dma_sconfig;
-	dma_cap_mask_t mask;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	dma_chan = dma_request_channel(mask, NULL, NULL);
-	if (!dma_chan) {
-		dev_err(tup->uport.dev,
-			"Dma channel is not available, will try later\n");
-		return -EPROBE_DEFER;
+	dma_chan = dma_request_slave_channel_or_err(tup->uport.dev,
+						dma_to_memory ? "rx" : "tx");
+	if (IS_ERR(dma_chan)) {
+		ret = PTR_ERR(dma_chan);
+		if (ret != -EPROBE_DEFER)
+			dev_err(tup->uport.dev,
+				"DMA channel alloc failed: %d\n", ret);
+		return ret;
 	}
 
 	if (dma_to_memory) {
@@ -938,7 +937,6 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 		dma_buf = tup->uport.state->xmit.buf;
 	}
 
-	dma_sconfig.slave_id = tup->dma_req_sel;
 	if (dma_to_memory) {
 		dma_sconfig.src_addr = tup->uport.mapbase;
 		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
@@ -1000,37 +998,20 @@ static int tegra_uart_startup(struct uart_port *u)
 	struct tegra_uart_port *tup = to_tegra_uport(u);
 	int ret;
 
-	ret = tegra_uart_dma_channel_allocate(tup, false);
-	if (ret < 0) {
-		dev_err(u->dev, "Tx Dma allocation failed, err = %d\n", ret);
-		return ret;
-	}
-
-	ret = tegra_uart_dma_channel_allocate(tup, true);
-	if (ret < 0) {
-		dev_err(u->dev, "Rx Dma allocation failed, err = %d\n", ret);
-		goto fail_rx_dma;
-	}
-
 	ret = tegra_uart_hw_init(tup);
 	if (ret < 0) {
 		dev_err(u->dev, "Uart HW init failed, err = %d\n", ret);
-		goto fail_hw_init;
+		return ret;
 	}
 
 	ret = request_irq(u->irq, tegra_uart_isr, 0,
 				dev_name(u->dev), tup);
 	if (ret < 0) {
 		dev_err(u->dev, "Failed to register ISR for IRQ %d\n", u->irq);
-		goto fail_hw_init;
+		return ret;
 	}
-	return 0;
 
-fail_hw_init:
-	tegra_uart_dma_channel_free(tup, true);
-fail_rx_dma:
-	tegra_uart_dma_channel_free(tup, false);
-	return ret;
+	return 0;
 }
 
 static void tegra_uart_shutdown(struct uart_port *u)
@@ -1042,8 +1023,6 @@ static void tegra_uart_shutdown(struct uart_port *u)
 	tup->rx_in_progress = 0;
 	tup->tx_in_progress = 0;
 
-	tegra_uart_dma_channel_free(tup, true);
-	tegra_uart_dma_channel_free(tup, false);
 	free_irq(u->irq, tup);
 }
 
@@ -1222,17 +1201,8 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
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
@@ -1326,14 +1296,29 @@ static int tegra_uart_probe(struct platform_device *pdev)
 		return PTR_ERR(tup->rst);
 	}
 
+	ret = tegra_uart_dma_channel_allocate(tup, false);
+	if (ret < 0)
+		return ret;
+
+	ret = tegra_uart_dma_channel_allocate(tup, true);
+	if (ret < 0)
+		goto err_free_dma_tx;
+
 	u->iotype = UPIO_MEM32;
 	u->irq = platform_get_irq(pdev, 0);
 	u->regshift = 2;
 	ret = uart_add_one_port(&tegra_uart_driver, u);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to add uart port, err %d\n", ret);
-		return ret;
+		goto err_free_dma_rx;
 	}
+
+	return 0;
+
+err_free_dma_tx:
+	tegra_uart_dma_channel_free(tup, false);
+err_free_dma_rx:
+	tegra_uart_dma_channel_free(tup, true);
 	return ret;
 }
 
@@ -1343,6 +1328,9 @@ static int tegra_uart_remove(struct platform_device *pdev)
 	struct uart_port *u = &tup->uport;
 
 	uart_remove_one_port(&tegra_uart_driver, u);
+	tegra_uart_dma_channel_free(tup, true);
+	tegra_uart_dma_channel_free(tup, false);
+
 	return 0;
 }
 
-- 
1.8.1.5

