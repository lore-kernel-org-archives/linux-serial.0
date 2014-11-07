From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] serial: fsl_lpuart: Remove unneeded registration message
Date: Fri,  7 Nov 2014 00:23:14 -0200
Message-ID: <1415326994-11666-2-git-send-email-festevam@gmail.com>
References: <1415326994-11666-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:50869 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaKGCXf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 21:23:35 -0500
Received: by mail-qc0-f182.google.com with SMTP id m20so1918376qcx.13
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2014 18:23:34 -0800 (PST)
In-Reply-To: <1415326994-11666-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: b35083@freescale.com, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no real value in displaying "serial: Freescale lpuart driver" in every
boot.

The uart_register_driver() can fail and even so the "serial: Freescale lpuart
driver" will be displayed, which is not really helpful.

This is particularly annoying when booting multi_v7_defconfig kernel on a SoC
that is not a Vybrid/Layerscape and even though this message gets displayed.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/fsl_lpuart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 567d0ad..08c8651 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1882,11 +1882,8 @@ static struct platform_driver lpuart_driver = {
 
 static int __init lpuart_serial_init(void)
 {
-	int ret;
-
-	pr_info("serial: Freescale lpuart driver\n");
+	int ret = uart_register_driver(&lpuart_reg);
 
-	ret = uart_register_driver(&lpuart_reg);
 	if (ret)
 		return ret;
 
-- 
1.9.1

