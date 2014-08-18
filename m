From: Barry Song <Barry.Song@csr.com>
Subject: [PATCH] serial: sirf: fix line over 80 characters style issue
Date: Mon, 18 Aug 2014 17:32:52 +0800
Message-ID: <1408354372-18601-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:55397 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbaHRJdP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2014 05:33:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

According to key customer's requirement, fix "line over 80
characters".

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 4102192..89f1e59 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -525,7 +525,8 @@ static void sirfsoc_rx_tmo_process_tl(unsigned long param)
 
 	spin_lock_irqsave(&port->lock, flags);
 	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
-		sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state)) {
+		sirfport->rx_dma_items[sirfport->rx_completed].cookie,
+		&tx_state)) {
 		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
 					SIRFSOC_RX_DMA_BUF_SIZE);
 		sirfport->rx_completed++;
@@ -707,7 +708,8 @@ static void sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
 	struct dma_tx_state tx_state;
 	spin_lock_irqsave(&port->lock, flags);
 	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
-			sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state)) {
+		sirfport->rx_dma_items[sirfport->rx_completed].cookie,
+		&tx_state)) {
 		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
 					SIRFSOC_RX_DMA_BUF_SIZE);
 		if (rd_regl(port, ureg->sirfsoc_int_en_reg) &
@@ -1303,7 +1305,8 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 		"sirf,uart-has-rtscts");
 	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart"))
 		sirfport->uart_reg->uart_type = SIRF_REAL_UART;
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-usp-uart")) {
+	if (of_device_is_compatible(pdev->dev.of_node,
+		"sirf,prima2-usp-uart")) {
 		sirfport->uart_reg->uart_type =	SIRF_USP_UART;
 		if (!sirfport->hw_flow_ctrl)
 			goto usp_no_flow_control;
@@ -1360,11 +1363,12 @@ usp_no_flow_control:
 		goto err;
 	}
 	tasklet_init(&sirfport->rx_dma_complete_tasklet,
-			sirfsoc_uart_rx_dma_complete_tl, (unsigned long)sirfport);
+		sirfsoc_uart_rx_dma_complete_tl, (unsigned long)sirfport);
 	tasklet_init(&sirfport->rx_tmo_process_tasklet,
 			sirfsoc_rx_tmo_process_tl, (unsigned long)sirfport);
 	port->mapbase = res->start;
-	port->membase = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	port->membase = devm_ioremap(&pdev->dev,
+			res->start, resource_size(res));
 	if (!port->membase) {
 		dev_err(&pdev->dev, "Cannot remap resource.\n");
 		ret = -ENOMEM;
-- 
2.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
