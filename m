Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62033C433EF
	for <linux-serial@archiver.kernel.org>; Thu,  5 May 2022 12:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbiEEMIn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 May 2022 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356228AbiEEMIm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 May 2022 08:08:42 -0400
X-Greylist: delayed 991 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 05:04:59 PDT
Received: from smarthost1.greenhost.nl (smarthost1.greenhost.nl [195.190.28.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACFE54F9A
        for <linux-serial@vger.kernel.org>; Thu,  5 May 2022 05:04:59 -0700 (PDT)
From:   Indan Zupancic <Indan.Zupancic@mep-info.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     sherry.sun@nxp.com, linux-imx@nxp.com,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        Indan Zupancic <Indan.Zupancic@mep-info.com>
Subject: [PATCH] fsl_lpuart: Don't enable interrupts too early
Date:   Thu,  5 May 2022 13:47:50 +0200
Message-Id: <20220505114750.45423-1-Indan.Zupancic@mep-info.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-As-Hash: ffa5b08e093a8a3dd7ef4f7d7b64ba463f993468
X-Virus-Scanned: by clamav at smarthost1.greenhost.nl
X-Scan-Signature: d58e29c6f4e42f76447094ef3ccb23d2
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If an irq is pending when devm_request_irq() is called, the irq
handler will cause a NULL pointer access because initialisation
is not done yet.

Fixes: 9d7ee0e28da59 ("tty: serial: lpuart: avoid report NULL interrupt")
Signed-off-by: Indan Zupancic <Indan.Zupancic@mep-info.com>
---
 drivers/tty/serial/fsl_lpuart.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 75b3c36c13bc..7b46b97a6ddd 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2629,6 +2629,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct lpuart_port *sport;
 	struct resource *res;
+	irq_handler_t handler;
 	int ret;
 
 	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
@@ -2701,17 +2702,11 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	if (lpuart_is_32(sport)) {
 		lpuart_reg.cons = LPUART32_CONSOLE;
-		ret = devm_request_irq(&pdev->dev, sport->port.irq, lpuart32_int, 0,
-					DRIVER_NAME, sport);
+		handler = lpuart32_int;
 	} else {
 		lpuart_reg.cons = LPUART_CONSOLE;
-		ret = devm_request_irq(&pdev->dev, sport->port.irq, lpuart_int, 0,
-					DRIVER_NAME, sport);
+		handler = lpuart_int;
 	}
-
-	if (ret)
-		goto failed_irq_request;
-
 	ret = uart_add_one_port(&lpuart_reg, &sport->port);
 	if (ret)
 		goto failed_attach_port;
@@ -2733,13 +2728,18 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	sport->port.rs485_config(&sport->port, &sport->port.rs485);
 
+	ret = devm_request_irq(&pdev->dev, sport->port.irq, handler, 0,
+				DRIVER_NAME, sport);
+	if (ret)
+		goto failed_irq_request;
+
 	return 0;
 
+failed_irq_request:
 failed_get_rs485:
 failed_reset:
 	uart_remove_one_port(&lpuart_reg, &sport->port);
 failed_attach_port:
-failed_irq_request:
 	lpuart_disable_clks(sport);
 	return ret;
 }
-- 
2.30.2

