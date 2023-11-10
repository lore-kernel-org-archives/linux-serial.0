Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8B5C05021
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjKJSRT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346164AbjKJSQo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:44 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927CD3AE14
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT5-0006O6-Jn; Fri, 10 Nov 2023 16:30:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-0083Kf-DF; Fri, 10 Nov 2023 16:30:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-00Gnws-4N; Fri, 10 Nov 2023 16:30:46 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 32/52] serial: rda: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:00 +0100
Message-ID: <20231110152927.70601-33-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=flPFXpMm9JS4xDTmMEuF+Ivri+U9FPWz7G99KM0If4c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyBu+R47zw4bBpxNQZ6TuWw60LvlNF/x6AWe /7FT19Yv7+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MgQAKCRCPgPtYfRL+ Tk/0B/9OO/ppzJl1iCig1amhre/TqiGlU4v5ONOM+L9j30oz0nj67lyO+fJ/WGl0hqYoyHBsduP T2SDhT4okmSqQ3y3dP8fwL2Ze81SCv96HB9Hc1K/lhnSCKjJZOcjosGq+X3hcf/SbKhdOK69YzB n+tjEGo2hyaPUNKvl8yJqCTtBpCgzeSjzyf3d6Hz/kQkeQjpIktiIKjnO0Sutcjotz+m7Bq17cW nISOSfKV24ky7xVTNc92ssGNHRV04Qoc4DCa/RuJ/7FoCbrCIvHcb6ybfJ9jYyqOtvy5l/ru3Ys ZnifTTdXjNyvywTjx0/eAmkrUBvCY2goXm5+gfh59x+Lawiq
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
 drivers/tty/serial/rda-uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index d824c8318f33..13deb355cf1b 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -780,19 +780,17 @@ static int rda_uart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rda_uart_remove(struct platform_device *pdev)
+static void rda_uart_remove(struct platform_device *pdev)
 {
 	struct rda_uart_port *rda_port = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&rda_uart_driver, &rda_port->port);
 	rda_uart_ports[pdev->id] = NULL;
-
-	return 0;
 }
 
 static struct platform_driver rda_uart_platform_driver = {
 	.probe = rda_uart_probe,
-	.remove = rda_uart_remove,
+	.remove_new = rda_uart_remove,
 	.driver = {
 		.name = "rda-uart",
 		.of_match_table = rda_uart_dt_matches,
-- 
2.42.0

