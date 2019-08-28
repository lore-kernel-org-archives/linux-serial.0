From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 4/5] serial: imx: fix data breakage on termios change
Date: Wed, 28 Aug 2019 21:37:54 +0300
Message-ID: <1567017475-11919-5-git-send-email-sorganov@gmail.com>
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

imx_set_termios(): avoid writing baud rate divider registers when the
values to be written are the same as current. Any writing seems to
restart transmission/receiving logic in the hardware, that leads to
data breakage even when rate doesn't in fact change. E.g., user
switches RTS/CTS handshake and suddenly gets broken bytes.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index cc3783c..e89045a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1545,7 +1545,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int baud, quot;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 	unsigned long div;
-	unsigned long num, denom;
+	unsigned long num, denom, old_ubir, old_ubmr;
 	uint64_t tdiv64;
 
 	/*
@@ -1670,8 +1670,21 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	ufcr = (ufcr & (~UFCR_RFDIV)) | UFCR_RFDIV_REG(div);
 	imx_uart_writel(sport, ufcr, UFCR);
 
-	imx_uart_writel(sport, num, UBIR);
-	imx_uart_writel(sport, denom, UBMR);
+	/*
+	 *  Two registers below should always be written both and in this
+	 *  particular order. One consequence is that we need to check if any of
+	 *  them changes and then update both. We do need the check for change
+	 *  as even writing the same values seem to "restart"
+	 *  transmission/receiving logic in the hardware, that leads to data
+	 *  breakage even when rate doesn't in fact change. E.g., user switches
+	 *  RTS/CTS handshake and suddenly gets broken bytes.
+	 */
+	old_ubir = imx_uart_readl(sport, UBIR);
+	old_ubmr = imx_uart_readl(sport, UBMR);
+	if (old_ubir != num || old_ubmr != denom) {
+		imx_uart_writel(sport, num, UBIR);
+		imx_uart_writel(sport, denom, UBMR);
+	}
 
 	if (!imx_uart_is_imx1(sport))
 		imx_uart_writel(sport, sport->port.uartclk / div / 1000,
-- 
2.10.0.1.g57b01a3
