From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/4] serial: imx: Remove unneeded goto label
Date: Mon, 27 Oct 2014 14:49:38 -0200
Message-ID: <1414428580-29534-2-git-send-email-fabio.estevam@freescale.com>
References: <1414428580-29534-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1bon0110.outbound.protection.outlook.com ([157.56.111.110]:14336
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751081AbaJ0REw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Oct 2014 13:04:52 -0400
In-Reply-To: <1414428580-29534-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, fugang.duan@freescale.com, festevam@gmail.com, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Instead of jumping to 'error_out1' label we can simplify the code and return the
error code directly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e4a2846..e7dc210 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1076,11 +1076,11 @@ static int imx_startup(struct uart_port *port)
 
 	retval = clk_prepare_enable(sport->clk_per);
 	if (retval)
-		goto error_out1;
+		return retval;
 	retval = clk_prepare_enable(sport->clk_ipg);
 	if (retval) {
 		clk_disable_unprepare(sport->clk_per);
-		goto error_out1;
+		return retval;
 	}
 
 	imx_setup_ufcr(sport, 0);
@@ -1170,9 +1170,6 @@ static int imx_startup(struct uart_port *port)
 	}
 
 	return 0;
-
-error_out1:
-	return retval;
 }
 
 static void imx_shutdown(struct uart_port *port)
-- 
1.9.1

