From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 4/4] serial: imx: Remove unneeded registration message
Date: Mon, 27 Oct 2014 14:49:40 -0200
Message-ID: <1414428580-29534-4-git-send-email-fabio.estevam@freescale.com>
References: <1414428580-29534-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1bon0142.outbound.protection.outlook.com ([157.56.111.142]:44160
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750873AbaJ0RXZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Oct 2014 13:23:25 -0400
In-Reply-To: <1414428580-29534-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, fugang.duan@freescale.com, festevam@gmail.com, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

There is no real value in displaying "Serial: IMX driver" in every boot.

The uart_register_driver() can fail and even so the "Serial: IMX driver" will
be displayed, which is not really helpful.

This is particularly annoying when booting multi_v7_defconfig kernel on a SoC
that is not a i.MX and even though this message gets displayed.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 9e8685e..d2e6cf5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1937,11 +1937,8 @@ static struct platform_driver serial_imx_driver = {
 
 static int __init imx_serial_init(void)
 {
-	int ret;
-
-	pr_info("Serial: IMX driver\n");
+	int ret = uart_register_driver(&imx_reg);
 
-	ret = uart_register_driver(&imx_reg);
 	if (ret)
 		return ret;
 
-- 
1.9.1

