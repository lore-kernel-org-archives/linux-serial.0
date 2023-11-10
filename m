Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018EEC05032
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344978AbjKJSRW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345083AbjKJSP2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:28 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6ED3A8A3
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-00066c-1o; Fri, 10 Nov 2023 16:30:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSy-0083Is-NE; Fri, 10 Nov 2023 16:30:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSy-00Gnuz-E7; Fri, 10 Nov 2023 16:30:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 04/52] serial: altera_jtaguart: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:32 +0100
Message-ID: <20231110152927.70601-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=VJZPg4mx2iepXKT++BWY1RbdwAvgGhomdjPozeajAtU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxcNk0G2oTKY4Mg5SgBwW/IubsoJmKTs1Op+ GuJnBW4J1+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MXAAKCRCPgPtYfRL+ ThPGB/wOzNYecm5LB2B4Li4HgeysGKRWyadCYYT7Z2iUNViw55OTWEDv/SEGQzuWo0unpks2lIY TZn3U8pTkkdBH5hldObgbVI0Tc+Ip7zQkhfknUnJgcLdecMs/Ct1e1zknBdP7ptkznPy1hHd+kY SiA+NudaYPAmj1MTgMyFbmGrt1d5HImqKvtQ143oDKC7p5htm+gbUagZDPYtBsrw+ghSuI14JSB MPhtaPxSLlADEfbkPgoaCu4NyrZotKd0vi+Ab+yj4CwN2dGFhW1GS3svA9eA3Z0yn/V2lUKcAXW Rzlz1tMJfn87pjJkOXXqTD71QzH+SU0YYMHAXIr5XO3MWeaY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/altera_jtaguart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 7090b251dd4d..effcba71ea77 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -425,7 +425,7 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int altera_jtaguart_remove(struct platform_device *pdev)
+static void altera_jtaguart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port;
 	int i = pdev->id;
@@ -436,8 +436,6 @@ static int altera_jtaguart_remove(struct platform_device *pdev)
 	port = &altera_jtaguart_ports[i];
 	uart_remove_one_port(&altera_jtaguart_driver, port);
 	iounmap(port->membase);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -451,7 +449,7 @@ MODULE_DEVICE_TABLE(of, altera_jtaguart_match);
 
 static struct platform_driver altera_jtaguart_platform_driver = {
 	.probe	= altera_jtaguart_probe,
-	.remove	= altera_jtaguart_remove,
+	.remove_new = altera_jtaguart_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.of_match_table	= of_match_ptr(altera_jtaguart_match),
-- 
2.42.0

