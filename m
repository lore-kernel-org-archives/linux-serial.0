Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42174C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjKJRyA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjKJRwu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:50 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1712B3A8A7
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-000678-Iu; Fri, 10 Nov 2023 16:30:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSz-0083JB-RP; Fri, 10 Nov 2023 16:30:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSz-00GnvR-IF; Fri, 10 Nov 2023 16:30:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Alexander Shiyan <shc_work@mail.ru>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Yangtao Li <frank.li@vivo.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/52] serial: clps711x: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:38 +0100
Message-ID: <20231110152927.70601-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1802; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zGO14akMC49w4hWUT2FVP0Zn7JKdFIeplvEQPynooZY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxjnfc+m4POnHiYSF/BMoC+3SURS9VfYyQql AwsdGbvL9+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MYwAKCRCPgPtYfRL+ TjvGB/94QeQhTPLSU4/YEu6O18DGMPuEgHh6J514QoQdI4zA0dqcmIA5IKwVhRZFaIrrjWHwC25 w06aHlc05uZT7xXlyBZ3lwW1cBs6X2N9Rf+0OMJifzXyemsvXgKOm44jWK2ifWjQyGpqG0CJoCw GkNxe7IBOWBdv60CvC+U+i+gsvNB5fnB31fAt0Qp1aCDndITHlbERp/Bp/Uuyw/xAsfiY1H/GVR K0t0jNrePc7zb2mLtXaoLmy0use1ck5q5hDXWulMYCW3A2A9WuaZtcXU6zBcBg8kx9FyH4do6XA +opPckvU+uAfOTNxVZsMAoUdQzRbiWPH0B9NnyIyqPLVgRQt
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
 drivers/tty/serial/clps711x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 55d19937efbd..7927725b8957 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -510,13 +510,11 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int uart_clps711x_remove(struct platform_device *pdev)
+static void uart_clps711x_remove(struct platform_device *pdev)
 {
 	struct clps711x_port *s = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&clps711x_uart, &s->port);
-
-	return 0;
 }
 
 static const struct of_device_id __maybe_unused clps711x_uart_dt_ids[] = {
@@ -531,7 +529,7 @@ static struct platform_driver clps711x_uart_platform = {
 		.of_match_table	= of_match_ptr(clps711x_uart_dt_ids),
 	},
 	.probe	= uart_clps711x_probe,
-	.remove	= uart_clps711x_remove,
+	.remove_new = uart_clps711x_remove,
 };
 
 static int __init uart_clps711x_init(void)
-- 
2.42.0

