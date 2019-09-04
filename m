From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH V2 03/12] serial: tegra: flush the RX fifo on frame error
Date: Wed, 4 Sep 2019 10:12:58 +0530
Message-ID: <1567572187-29820-4-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Shardar Shariff Md <smohammed@nvidia.com>, Krishna Yarlagadda <kyarlagadda@nvidia.com>
List-Id: linux-serial@vger.kernel.org

From: Shardar Shariff Md <smohammed@nvidia.com>

FIFO reset/flush code implemented now does not follow programming
guidelines. RTS line has to be turned off while flushing FIFOs to
avoid new transfers. Also check LSR bits UART_LSR_TEMT and UART_LSR_DR
to confirm FIFOs are flushed.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 29bf7b7..4cd6d5f 100644
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
@@ -289,6 +293,16 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 	 * to propagate, otherwise data could be lost.
 	 */
 	tegra_uart_wait_cycle_time(tup, 32);
+
+	do {
+		lsr = tegra_uart_read(tup, UART_LSR);
+		if ((lsr | UART_LSR_TEMT) && !(lsr & UART_LSR_DR))
+			break;
+		udelay(1);
+	} while (--tmout);
+
+	if (tup->rts_active)
+		set_rts(tup, true);
 }
 
 static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
-- 
2.7.4
