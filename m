From: Christoph Fritz <chf.fritz-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH 2/2] serial: imx: make DSR irq handling conditional
Date: Tue, 22 Nov 2016 18:14:11 +0100
Message-ID: <1479834851-32442-3-git-send-email-chf.fritz@googlemail.com>
References: <1479834851-32442-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479834851-32442-1-git-send-email-chf.fritz-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This patch makes use of device-tree property disable-dsr. Disabling
DSR can be necessary on i.MX6SX to quirk buggy hardware, for more
info see commit 276b891e3879 ("ARM: dts: imx6sx: document SION
necessity of ENET1_REF_CLK1").

Signed-off-by: Christoph Fritz <chf.fritz-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/tty/serial/imx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0df2b1c..bd85a69a4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -207,6 +207,7 @@ struct imx_port {
 	unsigned int		dte_mode:1;
 	unsigned int		irda_inv_rx:1;
 	unsigned int		irda_inv_tx:1;
+	unsigned int		dsr:1;
 	unsigned short		trcv_delay; /* transceiver delay */
 	struct clk		*clk_ipg;
 	struct clk		*clk_per;
@@ -1219,7 +1220,8 @@ static int imx_startup(struct uart_port *port)
 	/*
 	 * Finally, clear and enable interrupts
 	 */
-	writel(USR1_RTSD | USR1_DTRD, sport->port.membase + USR1);
+	temp = USR1_RTSD | (sport->dsr ? USR1_DTRD : 0);
+	writel(temp, sport->port.membase + USR1);
 	writel(USR2_ORE, sport->port.membase + USR2);
 
 	if (sport->dma_is_inited && !sport->dma_is_enabled)
@@ -1259,7 +1261,7 @@ static int imx_startup(struct uart_port *port)
 		 * now, too.
 		 */
 		temp |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP |
-			UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
+			(sport->dsr ? UCR3_DTRDEN : 0) | UCR3_RI | UCR3_DCD;
 
 		if (sport->dte_mode)
 			temp &= ~(UCR3_RI | UCR3_DCD);
@@ -1987,6 +1989,9 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	if (of_get_property(np, "fsl,dte-mode", NULL))
 		sport->dte_mode = 1;
 
+	if (!of_property_read_bool(np, "disable-dsr"))
+		sport->dsr = 1;
+
 	return 0;
 }
 #else
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
