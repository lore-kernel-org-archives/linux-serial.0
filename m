From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 08/14] serial: tegra: check for FIFO mode enabled status
Date: Mon, 12 Aug 2019 16:58:17 +0530
Message-ID: <1565609303-27000-9-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Krishna Yarlagadda <kyarlagadda@nvidia.com>, Shardar Shariff Md <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org

Chips prior to Tegra186 needed delay of 3 UART clock cycles to avoid
data loss. This issue is fixed in Tegra186 and a new flag is added to
check if fifo mode is enabled. chip data updated to check if this flag
is available for a chip. Tegra186 has new compatible to enable this
flag.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 52 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 7ab81bb..e0379d9 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -72,6 +72,8 @@
 #define TEGRA_TX_PIO				1
 #define TEGRA_TX_DMA				2
 
+#define TEGRA_UART_FCR_IIR_FIFO_EN		0x40
+
 /**
  * tegra_uart_chip_data: SOC specific data.
  *
@@ -84,6 +86,7 @@ struct tegra_uart_chip_data {
 	bool	tx_fifo_full_status;
 	bool	allow_txfifo_reset_fifo_mode;
 	bool	support_clk_src_div;
+	bool	fifo_mode_enable_status;
 };
 
 struct tegra_uart_port {
@@ -263,6 +266,22 @@ static void tegra_uart_wait_sym_time(struct tegra_uart_port *tup,
 			tup->current_baud));
 }
 
+static int tegra_uart_is_fifo_mode_enabled(struct tegra_uart_port *tup)
+{
+	unsigned long iir;
+	unsigned int tmout = 100;
+
+	do {
+		iir = tegra_uart_read(tup, UART_IIR);
+		if (iir & TEGRA_UART_FCR_IIR_FIFO_EN)
+			return 0;
+		udelay(1);
+	} while (--tmout);
+	dev_err(tup->uport.dev, "FIFO mode not enabled\n");
+
+	return -EIO;
+}
+
 static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 {
 	unsigned long fcr = tup->fcr_shadow;
@@ -282,6 +301,8 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 		tegra_uart_write(tup, fcr, UART_FCR);
 		fcr |= UART_FCR_ENABLE_FIFO;
 		tegra_uart_write(tup, fcr, UART_FCR);
+		if (tup->cdata->fifo_mode_enable_status)
+			tegra_uart_is_fifo_mode_enabled(tup);
 	}
 
 	/* Dummy read to ensure the write is posted */
@@ -918,12 +939,19 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	/* Dummy read to ensure the write is posted */
 	tegra_uart_read(tup, UART_SCR);
 
-	/*
-	 * For all tegra devices (up to t210), there is a hardware issue that
-	 * requires software to wait for 3 UART clock periods after enabling
-	 * the TX fifo, otherwise data could be lost.
-	 */
-	tegra_uart_wait_cycle_time(tup, 3);
+	if (tup->cdata->fifo_mode_enable_status) {
+		ret = tegra_uart_is_fifo_mode_enabled(tup);
+		if (ret < 0)
+			return ret;
+	} else {
+		/*
+		 * For all tegra devices (up to t210), there is a hardware
+		 * issue that requires software to wait for 3 UART clock
+		 * periods after enabling the TX fifo, otherwise data could
+		 * be lost.
+		 */
+		tegra_uart_wait_cycle_time(tup, 3);
+	}
 
 	/*
 	 * Initialize the UART with default configuration
@@ -1294,12 +1322,21 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.tx_fifo_full_status		= false,
 	.allow_txfifo_reset_fifo_mode	= true,
 	.support_clk_src_div		= false,
+	.fifo_mode_enable_status	= false,
 };
 
 static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.tx_fifo_full_status		= true,
 	.allow_txfifo_reset_fifo_mode	= false,
 	.support_clk_src_div		= true,
+	.fifo_mode_enable_status	= false,
+};
+
+static struct tegra_uart_chip_data tegra186_uart_chip_data = {
+	.tx_fifo_full_status		= true,
+	.allow_txfifo_reset_fifo_mode	= false,
+	.support_clk_src_div		= true,
+	.fifo_mode_enable_status	= true,
 };
 
 static const struct of_device_id tegra_uart_of_match[] = {
@@ -1310,6 +1347,9 @@ static const struct of_device_id tegra_uart_of_match[] = {
 		.compatible	= "nvidia,tegra20-hsuart",
 		.data		= &tegra20_uart_chip_data,
 	}, {
+		.compatible     = "nvidia,tegra186-hsuart",
+		.data		= &tegra186_uart_chip_data,
+	}, {
 	},
 };
 MODULE_DEVICE_TABLE(of, tegra_uart_of_match);
-- 
2.7.4
