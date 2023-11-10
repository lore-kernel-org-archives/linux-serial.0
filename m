Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF75C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjKJSDv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbjKJSCv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:02:51 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72B3AE19
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-0006Vs-CC; Fri, 10 Nov 2023 16:30:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-0083Li-Ky; Fri, 10 Nov 2023 16:30:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-00Gnxz-Bw; Fri, 10 Nov 2023 16:30:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 48/52] serial: tegra-tcu: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:16 +0100
Message-ID: <20231110152927.70601-49-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=swhoAVWkrMA1knLpinhSt78hBhGNQA0uOcknMNn7oHE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyUQtzMD5FVl3PDgSX036X6YAVoStTH23z85 lRajOE6YUyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MlAAKCRCPgPtYfRL+ TrJLCACTXSSwXRfVKE8mNLNndtxd/K2yp4IbhNEu6zhTuS/S+8w+maZ7jBYj27IihUFrYwr5FkB Eyv3Q+LNFc2WV5kH2hQ8TKafa/6npOp533lnKpOPOyOtA3Kgp5jKNvvsgfnT3zkoO6XWpeGpUOT dkwpAzKfpmL8O1EOH9mSAKVUr+zLLMZHRfzFbL5AUBpYyriBZBWfUw0P1a5iIUEi/ztoDvS1Svn 2yd9WqczWY1U4AGXDgkxaba/xQKX9zOG9Q3hcOQ0lAf2SC8GPL+802+xVhb/h3imgxKojCyG3S3 RCyMIoJWMY+XUidK1d1DXTwJkZ/wprpGRSn0TXAWPxzHo02v
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
 drivers/tty/serial/tegra-tcu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
index 65069daf36ec..d9c78320eb02 100644
--- a/drivers/tty/serial/tegra-tcu.c
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -266,7 +266,7 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tegra_tcu_remove(struct platform_device *pdev)
+static void tegra_tcu_remove(struct platform_device *pdev)
 {
 	struct tegra_tcu *tcu = platform_get_drvdata(pdev);
 
@@ -277,8 +277,6 @@ static int tegra_tcu_remove(struct platform_device *pdev)
 	uart_remove_one_port(&tcu->driver, &tcu->port);
 	uart_unregister_driver(&tcu->driver);
 	mbox_free_channel(tcu->tx);
-
-	return 0;
 }
 
 static const struct of_device_id tegra_tcu_match[] = {
@@ -293,7 +291,7 @@ static struct platform_driver tegra_tcu_driver = {
 		.of_match_table = tegra_tcu_match,
 	},
 	.probe = tegra_tcu_probe,
-	.remove = tegra_tcu_remove,
+	.remove_new = tegra_tcu_remove,
 };
 module_platform_driver(tegra_tcu_driver);
 
-- 
2.42.0

