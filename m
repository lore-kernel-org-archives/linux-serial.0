From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH V2] serial: imx: enable the clocks only when the uart is used
Date: Tue, 4 Jun 2013 09:59:33 +0800
Message-ID: <1370311173-15019-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:49064
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752412Ab3FDCTk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jun 2013 22:19:40 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>

Current code opens the clocks when the uart driver is probed.
This will wastes some power if several uarts are enabled, but not really
used.

So close these clocks for uart, and enable the clocks only when
the uart is used.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
v1 --> v2:
	check the return value of clk_prepare_enable().
---
 drivers/tty/serial/imx.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 72bc1db..7cc4810 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -699,6 +699,14 @@ static int imx_startup(struct uart_port *port)
 	int retval;
 	unsigned long flags, temp;
 
+	retval = clk_prepare_enable(sport->clk_per);
+	if (retval)
+		goto error_out1;
+
+	retval = clk_prepare_enable(sport->clk_ipg);
+	if (retval)
+		goto error_out1;
+
 	imx_setup_ufcr(sport, 0);
 
 	/* disable the DREN bit (Data Ready interrupt enable) before
@@ -884,6 +892,9 @@ static void imx_shutdown(struct uart_port *port)
 
 	writel(temp, sport->port.membase + UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
 }
 
 static void
@@ -1557,6 +1568,9 @@ static int serial_imx_probe(struct platform_device *pdev)
 		goto deinit;
 	platform_set_drvdata(pdev, sport);
 
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
+
 	return 0;
 deinit:
 	if (pdata && pdata->exit)
@@ -1578,9 +1592,6 @@ static int serial_imx_remove(struct platform_device *pdev)
 
 	uart_remove_one_port(&imx_reg, &sport->port);
 
-	clk_disable_unprepare(sport->clk_per);
-	clk_disable_unprepare(sport->clk_ipg);
-
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 
-- 
1.7.1


