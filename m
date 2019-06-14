From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] serial: imx: fix RTS/CTS setting
Date: Fri, 14 Jun 2019 09:28:01 +0200
Message-ID: <20190614072801.3187-1-s.hauer@pengutronix.de>
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
To: linux-serial@vger.kernel.org
Cc: kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The correct setting of the RTS pin depends on the CRTSCTS termios setting:

- When CRTSCTS is disabled then RTS shall be controlled by the TIOCM_RTS
  flag.
- When CRTSCTS is enabled the expected behaviour of the RTS pin is:
  - When TIOCM_RTS is set then let the receiver control RTS.
  - When the TIOCM_RTS flag is cleared then RTS shall be deasserted (to let
    the upper layers throttle the transfer even when the FIFO in the UART has
    enough space).

This patch fixes this behaviour. Previously the RTS pin has always been
controlled by the receiver once the TIOCM_RTS flag was set and the CRTSCTS
setting hasn't been taken into account.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b752e895053..0eddca6455ad 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -216,6 +216,7 @@ struct imx_port {
 	unsigned int		dma_is_enabled:1;
 	unsigned int		dma_is_rxing:1;
 	unsigned int		dma_is_txing:1;
+	unsigned int		crtscts:1;
 	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
 	struct scatterlist	rx_sgl, tx_sgl[2];
 	void			*rx_buf;
@@ -967,9 +968,18 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		u32 ucr2;
 
 		ucr2 = imx_uart_readl(sport, UCR2);
+
 		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
-		if (mctrl & TIOCM_RTS)
-			ucr2 |= UCR2_CTS | UCR2_CTSC;
+
+		if (mctrl & TIOCM_RTS) {
+			if (sport->crtscts)
+				/* let the receiver control RTS */
+				ucr2 |= UCR2_CTSC;
+			else
+				/* Force RTS active */
+				ucr2 |= UCR2_CTS;
+		}
+
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
@@ -1554,6 +1564,11 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		ucr2 = UCR2_SRST | UCR2_IRTS;
 
+	if (termios->c_cflag & CRTSCTS)
+		sport->crtscts = true;
+	else
+		sport->crtscts = false;
+
 	if (termios->c_cflag & CRTSCTS) {
 		if (sport->have_rtscts) {
 			ucr2 &= ~UCR2_IRTS;
-- 
2.20.1
