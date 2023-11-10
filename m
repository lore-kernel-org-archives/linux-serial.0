Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3055FC04A95
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjKJR4l (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjKJRzx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:53 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263243AE18
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-0006Ow-FS; Fri, 10 Nov 2023 16:30:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-0083Ko-Pw; Fri, 10 Nov 2023 16:30:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-00Gnx4-Gy; Fri, 10 Nov 2023 16:30:46 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 34/52] serial: samsung: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:02 +0100
Message-ID: <20231110152927.70601-35-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kaeCw/XWGh/rhDctG7bOvweVgq32oP1oEknoetRz908=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyE0v2ifLXtpzyGQdhUDaOdpTbnDbApuz6j2 DwCA6OZbfaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MhAAKCRCPgPtYfRL+ TsviB/92l+BrGxD7LXpisKNsmU30AFLHo+S43n4iodbe7lthheC7MZSZLHD0dEDOdCp56RgtQsp CEQiRtNt5t22s3lx4u2rq/o8TgjmdbJ4GhoGB1Ye+szDBoXfpbrvwTwy6Pe41xnLvR+bxiuioCR 9gK1zkLFt1xieOdMNjib/u+FAFyn3sP+/ip9WtWCeJnRb7Gssqf4WQEg9c85RV6ZQxubLWKp0j5 fqaUO6NE6u5k+K8gnD15eOJMMOO/gV9qDl5gZxgwb1p/rFexxL8MCWiDhxYlJJBjNQNsGcaAzDB pjbgKNRerSRBjSyFZrxMn8KeMBetjW0NgvofQ2wh9vWRMc95
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
 drivers/tty/serial/samsung_tty.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 3bd552841cd2..1b0c2b467a30 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2054,7 +2054,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int s3c24xx_serial_remove(struct platform_device *dev)
+static void s3c24xx_serial_remove(struct platform_device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
 
@@ -2063,8 +2063,6 @@ static int s3c24xx_serial_remove(struct platform_device *dev)
 	}
 
 	uart_unregister_driver(&s3c24xx_uart_drv);
-
-	return 0;
 }
 
 /* UART power management code */
@@ -2611,7 +2609,7 @@ MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
 
 static struct platform_driver samsung_serial_driver = {
 	.probe		= s3c24xx_serial_probe,
-	.remove		= s3c24xx_serial_remove,
+	.remove_new	= s3c24xx_serial_remove,
 	.id_table	= s3c24xx_serial_driver_ids,
 	.driver		= {
 		.name	= "samsung-uart",
-- 
2.42.0

