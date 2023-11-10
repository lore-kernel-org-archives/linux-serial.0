Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F64C4167B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjKJR4k (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjKJRzv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:51 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4103A8B2
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-0006Xi-Jp; Fri, 10 Nov 2023 16:30:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-0083Lr-05; Fri, 10 Nov 2023 16:30:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-00Gny6-ND; Fri, 10 Nov 2023 16:30:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Peter Korsgaard <jacmet@sunsite.dk>, linux-serial@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 50/52] serial: uartlite: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:18 +0100
Message-ID: <20231110152927.70601-51-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WRkoKVReHUGPni5x6b33mENImAr6GGmSF8CbrJG0FMI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyWi1FZJZQMcYTbC31p8gBAri+0MusiKkRFb KxGqO2/6ueJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MlgAKCRCPgPtYfRL+ TqiuCACWipRDx8QA3OlOOA+wRxraypYhChxrvYagM8AzjGgCCQf08UWKiZlGEOivCzFeW4udw8c c3AvpD01RcutjBoIN0XYyh5Nyf/sB+ll+NznfWganN+hKEULCxrw0EqqfbZJFDLhH6Mc0hxtpYh yBKRmd0F36z/cSIFcuKZsqoHRo5Yqxy9JyKEpQmczCVhQu0C9mV0C+DrvkEYuj+lnYEVBSQ/qi9 6WAOAovAONzREPrXJTp4rpZuw8hx18d5N6jo32W6Aid2VIbbpc+Zd+Fd/Kuc9bOGKQCBkU0J5/2 9ElIfK7Dc2CFJniXt5PrIoZ2nvf7keFc4oF9tA5EE5uyRRMG
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
 drivers/tty/serial/uartlite.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 404c14acafa5..48c9fca1566b 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -890,7 +890,7 @@ static int ulite_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ulite_remove(struct platform_device *pdev)
+static void ulite_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = dev_get_drvdata(&pdev->dev);
 	struct uartlite_data *pdata = port->private_data;
@@ -900,7 +900,6 @@ static int ulite_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	return 0;
 }
 
 /* work with hotplug and coldplug */
@@ -908,7 +907,7 @@ MODULE_ALIAS("platform:uartlite");
 
 static struct platform_driver ulite_platform_driver = {
 	.probe = ulite_probe,
-	.remove = ulite_remove,
+	.remove_new = ulite_remove,
 	.driver = {
 		.name  = "uartlite",
 		.of_match_table = of_match_ptr(ulite_of_match),
-- 
2.42.0

