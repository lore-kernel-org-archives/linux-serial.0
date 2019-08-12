From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 10/14] serial: tegra: add support to use 8 bytes trigger
Date: Mon, 12 Aug 2019 16:58:19 +0530
Message-ID: <1565609303-27000-11-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Shardar Shariff Md <smohammed@nvidia.com>, Krishna Yarlagadda <kyarlagadda@nvidia.com>
List-Id: linux-serial@vger.kernel.org

From: Shardar Shariff Md <smohammed@nvidia.com>

Add support to use 8 bytes trigger for Tegra186 SOC.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 329923c..03d1d20 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -88,6 +88,7 @@ struct tegra_uart_chip_data {
 	bool	support_clk_src_div;
 	bool	fifo_mode_enable_status;
 	int	uart_max_port;
+	int	dma_burst_bytes;
 };
 
 struct tegra_uart_port {
@@ -933,7 +934,12 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 * programmed in the DMA registers.
 	 */
 	tup->fcr_shadow = UART_FCR_ENABLE_FIFO;
-	tup->fcr_shadow |= UART_FCR_R_TRIG_01;
+
+	if (tup->cdata->dma_burst_bytes == 8)
+		tup->fcr_shadow |= UART_FCR_R_TRIG_10;
+	else
+		tup->fcr_shadow |= UART_FCR_R_TRIG_01;
+
 	tup->fcr_shadow |= TEGRA_UART_TX_TRIG_16B;
 	tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
 
@@ -1046,7 +1052,7 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 		}
 		dma_sconfig.src_addr = tup->uport.mapbase;
 		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		dma_sconfig.src_maxburst = 4;
+		dma_sconfig.src_maxburst = tup->cdata->dma_burst_bytes;
 		tup->rx_dma_chan = dma_chan;
 		tup->rx_dma_buf_virt = dma_buf;
 		tup->rx_dma_buf_phys = dma_phys;
@@ -1325,6 +1331,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.support_clk_src_div		= false,
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
+	.dma_burst_bytes		= 4,
 };
 
 static struct tegra_uart_chip_data tegra30_uart_chip_data = {
@@ -1333,6 +1340,7 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.support_clk_src_div		= true,
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
+	.dma_burst_bytes		= 4,
 };
 
 static struct tegra_uart_chip_data tegra186_uart_chip_data = {
@@ -1341,6 +1349,7 @@ static struct tegra_uart_chip_data tegra186_uart_chip_data = {
 	.support_clk_src_div		= true,
 	.fifo_mode_enable_status	= true,
 	.uart_max_port			= 5,
+	.dma_burst_bytes		= 8,
 };
 
 static const struct of_device_id tegra_uart_of_match[] = {
-- 
2.7.4
