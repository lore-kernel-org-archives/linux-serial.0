From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 3/5] serial: imx: do not disable individual irqs during
 termios change
Date: Wed, 28 Aug 2019 21:37:53 +0300
Message-ID: <1567017475-11919-4-git-send-email-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <1567017475-11919-1-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1567017475-11919-1-git-send-email-sorganov@gmail.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sergey Organov <sorganov@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

imx_set_termios(): disabling individual interrupt requests in UART for
duration of the routine is pointless. Get rid of it.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fa723a9a..cc3783c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1541,7 +1541,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long flags;
-	u32 ucr2, old_ucr1, old_ucr2, ufcr;
+	u32 ucr2, old_ucr2, ufcr;
 	unsigned int baud, quot;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 	unsigned long div;
@@ -1643,15 +1643,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	/*
-	 * disable interrupts
-	 */
-	old_ucr1 = imx_uart_readl(sport, UCR1);
-	imx_uart_writel(sport,
-			old_ucr1 & ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN),
-			UCR1);
-	imx_uart_writel(sport, old_ucr2 & ~UCR2_ATEN, UCR2);
-
 	/* custom-baudrate handling */
 	div = sport->port.uartclk / (baud * 16);
 	if (baud == 38400 && quot != div)
@@ -1686,8 +1677,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		imx_uart_writel(sport, sport->port.uartclk / div / 1000,
 				IMX21_ONEMS);
 
-	imx_uart_writel(sport, old_ucr1, UCR1);
-
 	imx_uart_writel(sport, ucr2, UCR2);
 
 	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
-- 
2.10.0.1.g57b01a3
