Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA47C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 20:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjKJU5e (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 15:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjKJU5V (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 15:57:21 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71FA3A897
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-00068M-Ta; Fri, 10 Nov 2023 16:30:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-0083JQ-GY; Fri, 10 Nov 2023 16:30:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-00Gnve-7W; Fri, 10 Nov 2023 16:30:42 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Max Filippov <jcmvbkbc@gmail.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 13/52] serial: esp32_acm: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:41 +0100
Message-ID: <20231110152927.70601-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0zkCG7vtEFfPJVH6axZyttIBTTJt/qfiQOul78Bc3qs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxmkAqoy9cFczX9NB5uWXgcGVK3diZ8fgMn7 pq4k6Wb4xKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MZgAKCRCPgPtYfRL+ TrdTCACrlGxcmZqWht6IypULLXqdsA2/Vx4CCaBQRPg7ExcDH40A23fip4SUHVj7UsubT/2QUXd SHSj2KwZJ0CDWefSmz8OIsqXovGFDkr3Lmo311NkBc8+93cexx+n9Rvc4qIizeiek3u9lx2xPgk f1NxaVAdFD3+oc5U1KXAM8Joa36/jtM/d+YtB13g3AF2ngG2l97QRxTnRsYT25VlnDAdOgdM0W1 WSce302ZpGmkHehAPbM8ZA3UtnveoL1Qdu2XKA9mWX4WvIviv8IrOx1Aijzh6XtkI0SU+LUvqGo Xm5yXnM38RDCVW6VqcCrdsdrQp63d8lPKoGsLqoZnQWzW1Dq
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
 drivers/tty/serial/esp32_acm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/esp32_acm.c b/drivers/tty/serial/esp32_acm.c
index cb28a87736aa..a4cbaedb5170 100644
--- a/drivers/tty/serial/esp32_acm.c
+++ b/drivers/tty/serial/esp32_acm.c
@@ -413,18 +413,17 @@ static int esp32s3_acm_probe(struct platform_device *pdev)
 	return uart_add_one_port(&esp32s3_acm_reg, port);
 }
 
-static int esp32s3_acm_remove(struct platform_device *pdev)
+static void esp32s3_acm_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&esp32s3_acm_reg, port);
-	return 0;
 }
 
 
 static struct platform_driver esp32s3_acm_driver = {
 	.probe		= esp32s3_acm_probe,
-	.remove		= esp32s3_acm_remove,
+	.remove_new	= esp32s3_acm_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table	= esp32s3_acm_dt_ids,
-- 
2.42.0

