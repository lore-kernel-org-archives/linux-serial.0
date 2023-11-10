Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC15C41535
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbjKJScY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346538AbjKJSbO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:31:14 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6613A8A6
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-00067Y-Ly; Fri, 10 Nov 2023 16:30:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-0083JE-1w; Fri, 10 Nov 2023 16:30:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSz-00GnvV-Ov; Fri, 10 Nov 2023 16:30:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: [PATCH 11/52] serial: cpm: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:39 +0100
Message-ID: <20231110152927.70601-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6gTKDXjIw8VyKf7Q/BpV0YGyPcG6F3bWdg5f5wTC7zo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxkbPcoovD83JGhMsSEbG+1RV74Dah20KnGB ASdb8GK6hGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MZAAKCRCPgPtYfRL+ TtlwB/98ztw6CuDD9VV3Ljq+zfLp9g+ouqMED2EwnSCy7a38GqMjRw2L3IXCKUi7cL84Mv8wwmE u7CMGzVGijlZJQL6ZIawRmQoko+ew9XxgDZjUGmZwwmGI4w4AaJ7Pcdb7t9YNlVe5l1PmnBMWYP qG1+FeShw1Ya+gU0AT3rBlxKRbi2eF3hIPE3i8f+p5SXiu/JfdBygJwP0GGQqTZfXk37FHRqL5c mO2HDCrd7Ymi4LUINl5ntnL3eBQAf2D866pgCgCSyC7A64NMDNQSi1rZKgOcTUIqX6wbMOhjIn3 H6SV/Po2RH8spfRv14wVTyt0uz3feuqBz7P6yWWFk+yCSZEJ
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
 drivers/tty/serial/cpm_uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.c
index be4af6eda4c2..df56c6c5afd0 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -1549,13 +1549,11 @@ static int cpm_uart_probe(struct platform_device *ofdev)
 	return ret;
 }
 
-static int cpm_uart_remove(struct platform_device *ofdev)
+static void cpm_uart_remove(struct platform_device *ofdev)
 {
 	struct uart_cpm_port *pinfo = platform_get_drvdata(ofdev);
 
 	uart_remove_one_port(&cpm_reg, &pinfo->port);
-
-	return 0;
 }
 
 static const struct of_device_id cpm_uart_match[] = {
@@ -1581,7 +1579,7 @@ static struct platform_driver cpm_uart_driver = {
 		.of_match_table = cpm_uart_match,
 	},
 	.probe = cpm_uart_probe,
-	.remove = cpm_uart_remove,
+	.remove_new = cpm_uart_remove,
  };
 
 static int __init cpm_uart_init(void)
-- 
2.42.0

