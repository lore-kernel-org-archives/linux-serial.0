From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH] serail: imx: add support for DTE mode
Date: Thu, 30 May 2013 14:07:12 +0800
Message-ID: <1369894032-7811-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:59598
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966921Ab3E3G0R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 May 2013 02:26:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>

The uart works in the DCE mode by default, but sometime we need it
works at the DTE mode.

This patch adds the support for the DTE mode.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../bindings/tty/serial/fsl-imx-uart.txt           |    3 +++
 drivers/tty/serial/imx.c                           |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
index b462d0c..c662eb3 100644
--- a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
@@ -8,6 +8,8 @@ Required properties:
 Optional properties:
 - fsl,uart-has-rtscts : Indicate the uart has rts and cts
 - fsl,irda-mode : Indicate the uart supports irda mode
+- fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
+                  is DCE mode by default.
 
 Example:
 
@@ -16,4 +18,5 @@ serial@73fbc000 {
 	reg = <0x73fbc000 0x4000>;
 	interrupts = <31>;
 	fsl,uart-has-rtscts;
+	fsl,dte-mode;
 };
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 72bc1db..381a2d7 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -201,6 +201,7 @@ struct imx_port {
 	unsigned int		old_status;
 	int			txirq, rxirq, rtsirq;
 	unsigned int		have_rtscts:1;
+	unsigned int		dte_mode:1;
 	unsigned int		use_irda:1;
 	unsigned int		irda_inv_rx:1;
 	unsigned int		irda_inv_tx:1;
@@ -1020,6 +1021,8 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	ufcr = readl(sport->port.membase + UFCR);
 	ufcr = (ufcr & (~UFCR_RFDIV)) | UFCR_RFDIV_REG(div);
+	if (sport->dte_mode)
+		ufcr |= UFCR_DCEDTE;
 	writel(ufcr, sport->port.membase + UFCR);
 
 	writel(num, sport->port.membase + UBIR);
@@ -1444,6 +1447,9 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	if (of_get_property(np, "fsl,irda-mode", NULL))
 		sport->use_irda = 1;
 
+	if (of_get_property(np, "fsl,dte-mode", NULL))
+		sport->dte_mode = 1;
+
 	sport->devdata = of_id->data;
 
 	return 0;
-- 
1.7.1


