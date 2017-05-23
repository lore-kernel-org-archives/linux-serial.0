From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V1] serial: imx: revert setup DCEDTE early and ensure DCD and
 RI irqs to be off
Date: Tue, 23 May 2017 13:17:26 +0100
Message-ID: <20170523123145.E268B3FAD4@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-SERIAL <linux-serial@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Cc: Support Opensource <support.opensource@diasemi.com>
List-Id: linux-serial@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Revert the commit e61c38d85b7392e ("serial: imx: setup DCEDTE early and
ensure DCD and RI irqs to be off")

The patch submitted to setup DCEDTE early and ensure DCD and RI irqs to
be off, causes a serial console display problem the i.MX6Q SABRESD board.
The console becomes unreadable and unwritable.

Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.12-rc2

Hi,

I have been seeing a problem with the serial output console on the i.MX6Q
SABRESD, but not the i.MX6DL SABRESD. Everything was fine up to
linux-mainline/v4.11 but changed after linux-next/next-20170501.

Some bisection has pointed at the commit
e61c38d85b7392e033ee03bca46f1d6006156175 which, once removed from my
linux-next/v4.12-rc2 build allows the i.MX6Q board to display the console
correctly again.

This patch removes the original commit e61c38d85b7392e ("serial: imx:
setup DCEDTE early and ensure DCD and RI irqs to be off") from  linux-next
v4.12-rc2 and fixes the serial problem seen in the i.MX6Q SABRESD board.

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 drivers/tty/serial/imx.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 33509b4..b4340b5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1325,10 +1325,19 @@ static int imx_startup(struct uart_port *port)
 	if (!is_imx1_uart(sport)) {
 		temp = readl(sport->port.membase + UCR3);
 
-		temp |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
+		/*
+		 * The effect of RI and DCD differs depending on the UFCR_DCEDTE
+		 * bit. In DCE mode they control the outputs, in DTE mode they
+		 * enable the respective irqs. At least the DCD irq cannot be
+		 * cleared on i.MX25 at least, so it's not usable and must be
+		 * disabled. I don't have test hardware to check if RI has the
+		 * same problem but I consider this likely so it's disabled for
+		 * now, too.
+		 */
+		temp |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP |
+			UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
 
 		if (sport->dte_mode)
-			/* disable broken interrupts */
 			temp &= ~(UCR3_RI | UCR3_DCD);
 
 		writel(temp, sport->port.membase + UCR3);
@@ -1610,6 +1619,8 @@ static void imx_flush_buffer(struct uart_port *port)
 
 	ufcr = readl(sport->port.membase + UFCR);
 	ufcr = (ufcr & (~UFCR_RFDIV)) | UFCR_RFDIV_REG(div);
+	if (sport->dte_mode)
+		ufcr |= UFCR_DCEDTE;
 	writel(ufcr, sport->port.membase + UFCR);
 
 	writel(num, sport->port.membase + UBIR);
@@ -2177,27 +2188,6 @@ static int serial_imx_probe(struct platform_device *pdev)
 		 UCR1_TXMPTYEN | UCR1_RTSDEN);
 	writel_relaxed(reg, sport->port.membase + UCR1);
 
-	if (!is_imx1_uart(sport) && sport->dte_mode) {
-		/*
-		 * The DCEDTE bit changes the direction of DSR, DCD, DTR and RI
-		 * and influences if UCR3_RI and UCR3_DCD changes the level of RI
-		 * and DCD (when they are outputs) or enables the respective
-		 * irqs. So set this bit early, i.e. before requesting irqs.
-		 */
-		writel(UFCR_DCEDTE, sport->port.membase + UFCR);
-
-		/*
-		 * Disable UCR3_RI and UCR3_DCD irqs. They are also not
-		 * enabled later because they cannot be cleared
-		 * (confirmed on i.MX25) which makes them unusable.
-		 */
-		writel(IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP | UCR3_DSR,
-		       sport->port.membase + UCR3);
-
-	} else {
-		writel(0, sport->port.membase + UFCR);
-	}
-
 	clk_disable_unprepare(sport->clk_ipg);
 
 	/*
-- 
end-of-patch for PATCH V1
