From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 1/2] serial: imx: remove the uart_console() check
Date: Wed, 26 Jun 2013 17:35:58 +0800
Message-ID: <1372239359-4054-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:27963
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751506Ab3FZKA7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Jun 2013 06:00:59 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com, Huang Shijie <b32955@freescale.com>

The uart_console() check makes the clocks(clk_per and clk_ipg) opened
even when we close the console uart.

This patch enable/disable the clocks in imx_console_write(),
so we can keep the clocks closed when the console uart is closed.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |   63 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 415cec6..bfdf764 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -702,15 +702,13 @@ static int imx_startup(struct uart_port *port)
 	int retval;
 	unsigned long flags, temp;
 
-	if (!uart_console(port)) {
-		retval = clk_prepare_enable(sport->clk_per);
-		if (retval)
-			goto error_out1;
-		retval = clk_prepare_enable(sport->clk_ipg);
-		if (retval) {
-			clk_disable_unprepare(sport->clk_per);
-			goto error_out1;
-		}
+	retval = clk_prepare_enable(sport->clk_per);
+	if (retval)
+		goto error_out1;
+	retval = clk_prepare_enable(sport->clk_ipg);
+	if (retval) {
+		clk_disable_unprepare(sport->clk_per);
+		goto error_out1;
 	}
 
 	imx_setup_ufcr(sport, 0);
@@ -901,10 +899,8 @@ static void imx_shutdown(struct uart_port *port)
 	writel(temp, sport->port.membase + UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	if (!uart_console(&sport->port)) {
-		clk_disable_unprepare(sport->clk_per);
-		clk_disable_unprepare(sport->clk_ipg);
-	}
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
 }
 
 static void
@@ -1251,6 +1247,16 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned int ucr1;
 	unsigned long flags = 0;
 	int locked = 1;
+	int retval;
+
+	retval = clk_enable(sport->clk_per);
+	if (retval)
+		return;
+	retval = clk_enable(sport->clk_ipg);
+	if (retval) {
+		clk_disable(sport->clk_per);
+		return;
+	}
 
 	if (sport->port.sysrq)
 		locked = 0;
@@ -1286,6 +1292,9 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 
 	if (locked)
 		spin_unlock_irqrestore(&sport->port.lock, flags);
+
+	clk_disable(sport->clk_ipg);
+	clk_disable(sport->clk_per);
 }
 
 /*
@@ -1359,6 +1368,7 @@ imx_console_setup(struct console *co, char *options)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	int retval;
 
 	/*
 	 * Check whether an invalid uart number has been specified, and
@@ -1371,6 +1381,15 @@ imx_console_setup(struct console *co, char *options)
 	if (sport == NULL)
 		return -ENODEV;
 
+	retval = clk_prepare_enable(sport->clk_per);
+	if (retval)
+		goto error_console;
+	retval = clk_prepare_enable(sport->clk_ipg);
+	if (retval) {
+		clk_disable_unprepare(sport->clk_per);
+		goto error_console;
+	}
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
@@ -1378,7 +1397,17 @@ imx_console_setup(struct console *co, char *options)
 
 	imx_setup_ufcr(sport, 0);
 
-	return uart_set_options(&sport->port, co, baud, parity, bits, flow);
+	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
+
+	clk_disable(sport->clk_per);
+	clk_disable(sport->clk_ipg);
+	if (retval) {
+		clk_unprepare(sport->clk_per);
+		clk_unprepare(sport->clk_ipg);
+	}
+
+error_console:
+	return retval;
 }
 
 static struct uart_driver imx_reg;
@@ -1583,10 +1612,8 @@ static int serial_imx_probe(struct platform_device *pdev)
 		goto deinit;
 	platform_set_drvdata(pdev, sport);
 
-	if (!uart_console(&sport->port)) {
-		clk_disable_unprepare(sport->clk_per);
-		clk_disable_unprepare(sport->clk_ipg);
-	}
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
 
 	return 0;
 deinit:
-- 
1.7.1


