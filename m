Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978D3C4167D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjKJSJL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346024AbjKJSHH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:07:07 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678383A8B3
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-0006X2-Hg; Fri, 10 Nov 2023 16:30:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-0083Ll-Qx; Fri, 10 Nov 2023 16:30:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-00Gny3-Hw; Fri, 10 Nov 2023 16:30:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 49/52] serial: timbuart: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:17 +0100
Message-ID: <20231110152927.70601-50-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jFSJXO2Xbl9fIXmf1iTPsGnVD2SUK+/zNSwUIlvg1Kk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyVAVwwXKtxkjvIJhA0LtH/LAMwqyz8/VnCK zivQpq51MSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MlQAKCRCPgPtYfRL+ TscnB/9jeu/c+jtZVSRDbAqYBvCHpv7MmCM4TwA7nW1SbJBGh9Bm9/7aodbINOYyCE0E0vb4DXi d3jvp8R4DjPk+tl5tDQ2McL/qbylUkpk9NtkilZ4KXnkUVv/e3j+OUs4jKWxuNUMamG37jAKiP+ w0lXCKiRXxvTdWrDt3zL5wTCZSzYeJpiMGHpS6b9iSAF7d3U2z620KkUqdeiX8RguW+W1R8uuiq uefZMA9t6XQqbQQ6+IM3d4xMRTQel6+roU1FcuO1nUEI0mwAVlNvNLNgi1bnwJlQ648iS7CM02N RLDFSSNZFFLryjrpHZ1hFcM0KLOExEuGycL2h0pHtGTDRPkB
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
 drivers/tty/serial/timbuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 0cc6524f5e8b..4bc89a9b380a 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -473,7 +473,7 @@ static int timbuart_probe(struct platform_device *dev)
 	return err;
 }
 
-static int timbuart_remove(struct platform_device *dev)
+static void timbuart_remove(struct platform_device *dev)
 {
 	struct timbuart_port *uart = platform_get_drvdata(dev);
 
@@ -481,8 +481,6 @@ static int timbuart_remove(struct platform_device *dev)
 	uart_remove_one_port(&timbuart_driver, &uart->port);
 	uart_unregister_driver(&timbuart_driver);
 	kfree(uart);
-
-	return 0;
 }
 
 static struct platform_driver timbuart_platform_driver = {
@@ -490,7 +488,7 @@ static struct platform_driver timbuart_platform_driver = {
 		.name	= "timb-uart",
 	},
 	.probe		= timbuart_probe,
-	.remove		= timbuart_remove,
+	.remove_new	= timbuart_remove,
 };
 
 module_platform_driver(timbuart_platform_driver);
-- 
2.42.0

