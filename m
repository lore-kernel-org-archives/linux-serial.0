Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71971C433E1
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 11:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D3620866
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 11:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHMLGk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgHMLGj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 07:06:39 -0400
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Aug 2020 04:06:38 PDT
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15D8C061757
        for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2020 04:06:38 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 6573B101903AE;
        Thu, 13 Aug 2020 12:59:54 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 2037E603DA32;
        Thu, 13 Aug 2020 12:59:54 +0200 (CEST)
X-Mailbox-Line: From 138f8c15afb2f184d8102583f8301575566064a6 Mon Sep 17 00:00:00 2001
Message-Id: <138f8c15afb2f184d8102583f8301575566064a6.1597316167.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 13 Aug 2020 12:59:54 +0200
Subject: [PATCH] serial: pl011: Don't leak amba_ports entry on driver register
 error
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org,
        Tushar Behera <tushar.behera@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

pl011_probe() calls pl011_setup_port() to reserve an amba_ports[] entry,
then calls pl011_register_port() to register the uart driver with the
tty layer.

If registration of the uart driver fails, the amba_ports[] entry is not
released.  If this happens 14 times (value of UART_NR macro), then all
amba_ports[] entries will have been leaked and driver probing is no
longer possible.  (To be fair, that can only happen if the DeviceTree
doesn't contain alias IDs since they cause the same entry to be used for
a given port.)   Fix it.

Fixes: ef2889f7ffee ("serial: pl011: Move uart_register_driver call to device")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.15+
Cc: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cd1ba8d8b0e6..67498594d7d7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2614,7 +2614,7 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 
 static int pl011_register_port(struct uart_amba_port *uap)
 {
-	int ret;
+	int ret, i;
 
 	/* Ensure interrupts from this UART are masked and cleared */
 	pl011_write(0, uap, REG_IMSC);
@@ -2625,6 +2625,9 @@ static int pl011_register_port(struct uart_amba_port *uap)
 		if (ret < 0) {
 			dev_err(uap->port.dev,
 				"Failed to register AMBA-PL011 driver\n");
+			for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
+				if (amba_ports[i] == uap)
+					amba_ports[i] = NULL;
 			return ret;
 		}
 	}
-- 
2.27.0

