Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83172C04A95
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjKJSHP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjKJSFf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:35 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F773A8AF
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT3-0006Jp-Um; Fri, 10 Nov 2023 16:30:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT3-0083KC-0N; Fri, 10 Nov 2023 16:30:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT2-00GnwQ-NL; Fri, 10 Nov 2023 16:30:44 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>,
        John Ogness <john.ogness@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 25/52] serial: mpc52xx: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:53 +0100
Message-ID: <20231110152927.70601-26-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JFWHOoq/ho0+LQeUYKglharLAspxyHElpTvGDhUr+bI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkx0wDwxIF+DVTLJF7o/NhB0JsfkN5KRVbEF8 YabjMg1rQOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MdAAKCRCPgPtYfRL+ TpIdB/452MxS+j2Q4drYd36EWOSPh4MiKv6BNW3dbDQI4bne/spDTQfYtQpnZ//wQ4yS8o/PuqI vzKPz/VhuWWg2V+83oZbJakBuBKKKP1N3L6hO7HzHg7Nj9cPRoOHfvOdNT5SyeElb7G/6ASurBk w/opMQgUYebkx0IkARWSdxszsimCvpDhVjSQ6iFKkf/MlFHHgbwRYFJnB4bRhY3cfsHoCNe/0s8 7hQS7wxmzObxKpgpQMtfOL+gHfFu71zIYotdL9/Occkp7m4w29W4Q/9OxL13olZxwivgtqczU4R EdVS323yWQjJG09mtvk8qn70Boih6shDxbxl89R7GCzxFX+o
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
 drivers/tty/serial/mpc52xx_uart.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index a252465e745f..95dae5e27b28 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1765,15 +1765,12 @@ static int mpc52xx_uart_of_probe(struct platform_device *op)
 	return 0;
 }
 
-static int
-mpc52xx_uart_of_remove(struct platform_device *op)
+static void mpc52xx_uart_of_remove(struct platform_device *op)
 {
 	struct uart_port *port = platform_get_drvdata(op);
 
 	if (port)
 		uart_remove_one_port(&mpc52xx_uart_driver, port);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1846,7 +1843,7 @@ MODULE_DEVICE_TABLE(of, mpc52xx_uart_of_match);
 
 static struct platform_driver mpc52xx_uart_of_driver = {
 	.probe		= mpc52xx_uart_of_probe,
-	.remove		= mpc52xx_uart_of_remove,
+	.remove_new	= mpc52xx_uart_of_remove,
 #ifdef CONFIG_PM
 	.suspend	= mpc52xx_uart_of_suspend,
 	.resume		= mpc52xx_uart_of_resume,
-- 
2.42.0

