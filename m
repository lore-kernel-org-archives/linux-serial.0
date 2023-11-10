Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE8AC4167D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344799AbjKJSVX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345837AbjKJSTb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:19:31 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01D73A8AC
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT3-0006Et-19; Fri, 10 Nov 2023 16:30:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT1-0083Jr-Nn; Fri, 10 Nov 2023 16:30:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT1-00Gnw1-Ed; Fri, 10 Nov 2023 16:30:43 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 19/52] serial: liteuart: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:47 +0100
Message-ID: <20231110152927.70601-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=AyGTON2PjykVAQ+BDKhAuTl+omyaBwfxB7p/IcyQquI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxt7sAR1+q+Nx2S/KOviEpP0/7fj7hqVl2v0 cO6FLQJvYOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MbQAKCRCPgPtYfRL+ TuKLB/0djNE3RTenvgev8Y8LRSxgUs5jBB5X9tIxthXO4jK4hDVDz3H26OANQmyZ4eAuTwgSm5b oOzHt3wvASWLsHjF1p+IC9bbRLwsHSFIUkmt+8tuNFrk3FvzEJ9MybDvkBritG2tkDX0nYe7Tqf hVONMyhoV51+L9JUxXosgcU2COzmdMUKVzzdphe9WOy081CyKY4rw8y6iVqLrClu/L9+z8bBU1h cOvVJtV456PU5mqnHSm6Li0hwIA2YFi1TRbJdhJFNmnnxL9n6MQRj5N1wcdBxOuszkTtllH13R9 VyxzErkH5JlXVm7NgHfwnHsSXDIuCniHKF47tUeNagYAQrzK
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
 drivers/tty/serial/liteuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index a25ab1efe38f..3ce369f76349 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -336,15 +336,13 @@ static int liteuart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int liteuart_remove(struct platform_device *pdev)
+static void liteuart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	unsigned int line = port->line;
 
 	uart_remove_one_port(&liteuart_driver, port);
 	xa_erase(&liteuart_array, line);
-
-	return 0;
 }
 
 static const struct of_device_id liteuart_of_match[] = {
@@ -355,7 +353,7 @@ MODULE_DEVICE_TABLE(of, liteuart_of_match);
 
 static struct platform_driver liteuart_platform_driver = {
 	.probe = liteuart_probe,
-	.remove = liteuart_remove,
+	.remove_new = liteuart_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = liteuart_of_match,
-- 
2.42.0

