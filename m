From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 05/14] serial: tegra: flush the RX fifo on frame error
Date: Mon, 12 Aug 2019 16:58:14 +0530
Message-ID: <1565609303-27000-6-git-send-email-kyarlagadda@nvidia.com>
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

FIFO reset/flush code implemented now does not follow programming
guidelines. RTS line has to be turned off while flushing fifos to
avoid new transfers. Also check LSR bits UART_LSR_TEMT and UART_LSR_DR
to confirm fifos are flushed.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index ae7225c..f6a3f4e 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -266,6 +266,10 @@ static void tegra_uart_wait_sym_time(struct tegra_uart_port *tup,
 static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 {
 	unsigned long fcr = tup->fcr_shadow;
+	unsigned int lsr, tmout = 10000;
+
+	if (tup->rts_active)
+		set_rts(tup, false);
 
 	if (tup->cdata->allow_txfifo_reset_fifo_mode) {
 		fcr |= fcr_bits & (UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
@@ -289,6 +293,17 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 	 * to propagate, otherwise data could be lost.
 	 */
 	tegra_uart_wait_cycle_time(tup, 32);
+
+	do {
+		lsr = tegra_uart_read(tup, UART_LSR);
+		if (lsr | UART_LSR_TEMT)
+			if (!(lsr & UART_LSR_DR))
+				break;
+		udelay(1);
+	} while (--tmout);
+
+	if (tup->rts_active)
+		set_rts(tup, true);
 }
 
 static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
-- 
2.7.4
