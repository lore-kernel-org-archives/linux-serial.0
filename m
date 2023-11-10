Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D8FC4167B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjKJR4M (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbjKJRzt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:49 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F06D3A8AE
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-0006Sn-GN; Fri, 10 Nov 2023 16:30:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-0083LS-QS; Fri, 10 Nov 2023 16:30:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-00Gnxi-HN; Fri, 10 Nov 2023 16:30:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Hammer Hsieh <hammerh0314@gmail.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 44/52] serial: sunplus: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:12 +0100
Message-ID: <20231110152927.70601-45-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=V4gEMT6Up/+x/qjHaGbrUAdomXMcVjjjuODHMxiGMi8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyPl2eAOFum8wjRGTDSEhRAcjz8cNS5o2t+Z UKNETp7/rmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MjwAKCRCPgPtYfRL+ TpdmCACMYGQRnl667oRNutq9gsa//xi7PWWbq9mLOwHtcFwotgr8RprXdSEFj6kMAskQyRLaWmw QLPlg7ekGnn3A4BSKM3w57Bz9nDpkVf9uiDoHIF7KeqFeqqy3RADl+CtH2fTVfZ/X82TDz086y7 w9WIxO4znEd6UJL0e58qNVcnXmX+rrRnGjDcvwZVbw1z9x08zC+yZaHoBb0Sf2hdoX3LQ/xCJWR GllzJw4PveGj5PBBIlgZs1EkM8WgYaoOYrCJ1U4RVQMcWRRbbWjM6eqrgUJmPtTiAxJ/hYEznCh t35RFAxO/V+lXfUkuUut13qEhSSSzzdbDeCjEsDZEGcN2VqX
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
 drivers/tty/serial/sunplus-uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
index 4251f4e1ba99..99f5285819d4 100644
--- a/drivers/tty/serial/sunplus-uart.c
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -662,13 +662,11 @@ static int sunplus_uart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sunplus_uart_remove(struct platform_device *pdev)
+static void sunplus_uart_remove(struct platform_device *pdev)
 {
 	struct sunplus_uart_port *sup = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&sunplus_uart_driver, &sup->port);
-
-	return 0;
 }
 
 static int __maybe_unused sunplus_uart_suspend(struct device *dev)
@@ -703,7 +701,7 @@ MODULE_DEVICE_TABLE(of, sp_uart_of_match);
 
 static struct platform_driver sunplus_uart_platform_driver = {
 	.probe		= sunplus_uart_probe,
-	.remove		= sunplus_uart_remove,
+	.remove_new	= sunplus_uart_remove,
 	.driver = {
 		.name	= "sunplus_uart",
 		.of_match_table = sp_uart_of_match,
-- 
2.42.0

