From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v2] serial: imx: enable the clocks for console
Date: Sun, 9 Jun 2013 10:01:19 +0800
Message-ID: <1370743279-15941-1-git-send-email-b32955@freescale.com>
References: <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:57626
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751704Ab3FICXL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Jun 2013 22:23:11 -0400
In-Reply-To: <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, shawn.guo@linaro.org, festevam@gmail.com, shc_work@mail.ru, Huang Shijie <b32955@freescale.com>

The console's clocks are disabled after the uart driver is probed.
It makes that we can see less log from the console now
(though we still can get all the log by the `dmesg`).

So enable the clocks for console, and we can see all the log again.

This patch also disables the sport->clk_per when we fail to enable
the sport->clk_ipg;

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
v1 --> v2:
	disable the sport->clk_per when we fail to enable
	the sport->clk_ipg;
---
 drivers/tty/serial/imx.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7a761f7..78f8097 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -702,13 +702,16 @@ static int imx_startup(struct uart_port *port)
 	int retval;
 	unsigned long flags, temp;
 
-	retval = clk_prepare_enable(sport->clk_per);
-	if (retval)
-		goto error_out1;
-
-	retval = clk_prepare_enable(sport->clk_ipg);
-	if (retval)
-		goto error_out1;
+	if (!uart_console(port)) {
+		retval = clk_prepare_enable(sport->clk_per);
+		if (retval)
+			goto error_out1;
+		retval = clk_prepare_enable(sport->clk_ipg);
+		if (retval) {
+			clk_disable_unprepare(sport->clk_per);
+			goto error_out1;
+		}
+	}
 
 	imx_setup_ufcr(sport, 0);
 
@@ -1578,8 +1581,10 @@ static int serial_imx_probe(struct platform_device *pdev)
 		goto deinit;
 	platform_set_drvdata(pdev, sport);
 
-	clk_disable_unprepare(sport->clk_per);
-	clk_disable_unprepare(sport->clk_ipg);
+	if (!uart_console(&sport->port)) {
+		clk_disable_unprepare(sport->clk_per);
+		clk_disable_unprepare(sport->clk_ipg);
+	}
 
 	return 0;
 deinit:
-- 
1.7.1


