From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v2 2/2] tty: serial: imx: don't reinit clock in imx_setup_ufcr()
Date: Fri, 31 Aug 2012 10:02:47 +0200
Message-ID: <1346400167-24669-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2-v.fe.bosch.de ([139.15.237.6]:56587 "EHLO
	smtp2-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab2HaIDF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 31 Aug 2012 04:03:05 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, Dirk Behme <dirk.behme@de.bosch.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Troy Kisky <troy.kisky@boundarydevices.com>, Xinyu Chen <xinyu.chen@freescale.com>, stable@vger.kernel.org

Remove the clock configuration from imx_setup_ufcr(). This
isn't needed here and will cause garbage output if done.

To be be sure that we only touch the bits we want (TXTL and RXTL)
we have to mask out all other bits of the UFCR register. Add
one non-existing bit macro for this, too (bit 6, DCEDTE on i.MX6).

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
CC: Shawn Guo <shawn.guo@linaro.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Troy Kisky <troy.kisky@boundarydevices.com>
CC: Xinyu Chen <xinyu.chen@freescale.com>
CC: <stable@vger.kernel.org>
---
Changes in v2: Instead of disabling imx_setup_ufcr() with an
ifndef CONFIG_SERIAL_CORE_CONSOLE, remove the unneeded clock 
configuration from imx_setup_ufcr() itself as proposed by Troy Kisky.

Note: If this patch is accepted, it should go to the same stable
kernels as patch #1 of this series. So most probably 3.4 and 3.5.

 drivers/tty/serial/imx.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 908178f..e309e8b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -132,6 +132,7 @@
 #define  UCR4_OREN  	 (1<<1)  /* Receiver overrun interrupt enable */
 #define  UCR4_DREN  	 (1<<0)  /* Recv data ready interrupt enable */
 #define  UFCR_RXTL_SHF   0       /* Receiver trigger level shift */
+#define  UFCR_DCEDTE	 (1<<6)  /* DCE/DTE mode select */
 #define  UFCR_RFDIV      (7<<7)  /* Reference freq divider mask */
 #define  UFCR_RFDIV_REG(x)	(((x) < 7 ? 6 - (x) : 6) << 7)
 #define  UFCR_TXTL_SHF   10      /* Transmitter trigger level shift */
@@ -667,22 +668,11 @@ static void imx_break_ctl(struct uart_port *port, int break_state)
 static int imx_setup_ufcr(struct imx_port *sport, unsigned int mode)
 {
 	unsigned int val;
-	unsigned int ufcr_rfdiv;
-
-	/* set receiver / transmitter trigger level.
-	 * RFDIV is set such way to satisfy requested uartclk value
-	 */
-	val = TXTL << 10 | RXTL;
-	ufcr_rfdiv = (clk_get_rate(sport->clk_per) + sport->port.uartclk / 2)
-			/ sport->port.uartclk;
-
-	if(!ufcr_rfdiv)
-		ufcr_rfdiv = 1;
-
-	val |= UFCR_RFDIV_REG(ufcr_rfdiv);
 
+	/* set receiver / transmitter trigger level */
+	val = readl(sport->port.membase + UFCR) & (UFCR_RFDIV | UFCR_DCEDTE);
+	val |= TXTL << UFCR_TXTL_SHF | RXTL;
 	writel(val, sport->port.membase + UFCR);
-
 	return 0;
 }
 
-- 
1.7.0.4

