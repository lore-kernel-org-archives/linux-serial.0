From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] serial: imx: remove duplicate handling of CTS change
Date: Wed, 26 Jun 2019 12:15:56 +0200
Message-ID: <20190626101557.26299-2-s.hauer@pengutronix.de>
References: <20190626101557.26299-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190626101557.26299-1-s.hauer@pengutronix.de>
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
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Sergey Organov <sorganov@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

We have an interrupt for the CTS input (RTS in FSL speech). Its handler
calls uart_handle_cts_change(), so we shouldn't do this in
imx_uart_mctrl_check() again.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a5e80a028e83..0419a084c0ed 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -805,12 +805,8 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport);
 static unsigned int imx_uart_get_hwmctrl(struct imx_port *sport)
 {
 	unsigned int tmp = TIOCM_DSR;
-	unsigned usr1 = imx_uart_readl(sport, USR1);
 	unsigned usr2 = imx_uart_readl(sport, USR2);
 
-	if (usr1 & USR1_RTSS)
-		tmp |= TIOCM_CTS;
-
 	/* in DCE mode DCDIN is always 0 */
 	if (!(usr2 & USR2_DCDIN))
 		tmp |= TIOCM_CAR;
@@ -843,8 +839,6 @@ static void imx_uart_mctrl_check(struct imx_port *sport)
 		sport->port.icount.dsr++;
 	if (changed & TIOCM_CAR)
 		uart_handle_dcd_change(&sport->port, status & TIOCM_CAR);
-	if (changed & TIOCM_CTS)
-		uart_handle_cts_change(&sport->port, status & TIOCM_CTS);
 
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 }
-- 
2.20.1
