Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40D7ECAAA1
	for <linux-serial@archiver.kernel.org>; Sun, 11 Sep 2022 08:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiIKI42 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 11 Sep 2022 04:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIKI41 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 11 Sep 2022 04:56:27 -0400
X-Greylist: delayed 418 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Sep 2022 01:56:25 PDT
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944972CCB9
        for <linux-serial@vger.kernel.org>; Sun, 11 Sep 2022 01:56:25 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 4910E101E6B69
        for <linux-serial@vger.kernel.org>; Sun, 11 Sep 2022 10:49:11 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E6364603E021
        for <linux-serial@vger.kernel.org>; Sun, 11 Sep 2022 10:49:10 +0200 (CEST)
X-Mailbox-Line: From 72fb646c1b0b11c989850c55f52f9ff343d1b2fa Mon Sep 17 00:00:00 2001
Message-Id: <72fb646c1b0b11c989850c55f52f9ff343d1b2fa.1662884345.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 11 Sep 2022 10:22:01 +0200
Subject: [PATCH] serial: fsl_lpuart: Reset prior to registration
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset
for imx7ulp and imx8qxp"), certain i.MX UARTs are reset after they've
already been registered.  Register state may thus be clobbered after
user space has begun to open and access the UART.

Avoid by performing the reset prior to registration.

Fixes: bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset for imx7ulp and imx8qxp")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.15+
Cc: Fugang Duan <fugang.duan@nxp.com>
Cc: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f21915015d67..e9d5b481bb31 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2719,14 +2719,15 @@ static int lpuart_probe(struct platform_device *pdev)
 		lpuart_reg.cons = LPUART_CONSOLE;
 		handler = lpuart_int;
 	}
-	ret = uart_add_one_port(&lpuart_reg, &sport->port);
-	if (ret)
-		goto failed_attach_port;
 
 	ret = lpuart_global_reset(sport);
 	if (ret)
 		goto failed_reset;
 
+	ret = uart_add_one_port(&lpuart_reg, &sport->port);
+	if (ret)
+		goto failed_attach_port;
+
 	ret = uart_get_rs485_mode(&sport->port);
 	if (ret)
 		goto failed_get_rs485;
@@ -2742,9 +2743,9 @@ static int lpuart_probe(struct platform_device *pdev)
 
 failed_irq_request:
 failed_get_rs485:
-failed_reset:
 	uart_remove_one_port(&lpuart_reg, &sport->port);
 failed_attach_port:
+failed_reset:
 	lpuart_disable_clks(sport);
 	return ret;
 }
-- 
2.36.1

