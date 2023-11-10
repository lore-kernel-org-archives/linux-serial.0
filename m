Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E97AC4167D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 19:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjKJTjw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 14:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbjKJTjk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 14:39:40 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4DE3A8B8
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-0006Pf-5V; Fri, 10 Nov 2023 16:30:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT5-0083Kx-5R; Fri, 10 Nov 2023 16:30:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-00GnxC-SS; Fri, 10 Nov 2023 16:30:46 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 36/52] serial: tegra: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:04 +0100
Message-ID: <20231110152927.70601-37-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=G2ztO6ZS0L1mppkoBSatHWYdrZ3lJhBHyoZqK/ZNRzY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyGLb33QkkT/HgQ0F6Yevq7L3StcfbfsEz9s /Xpqyt2m3aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MhgAKCRCPgPtYfRL+ Tlo2B/9tenq0eFH5I1CfvTlJAFSpeRaUXBJbga528JieDnIuiWIXvuf4pzDH5SEs6/IWm3atRnX XlxnNp01iHQDdQSKhBBGdHvGVZSkB/+hYPTR0uJ/mbS7mwPB4gzhT2ehCEJw85N8wReiZKLFQRJ Hsf4rLCwRrcU3JmZo5euHCevWpV32VhjQf8AKrjh8Q6UF1Ah4tPQXyBfcwQX8fG21Y09ydk/ZgW DHlb3IN4oqtOLiMcXZo3YfWuhvxSIsgRg4fHJYAhVtCUvcsBu+aZmfm9j3g3gqOpbXD2PRJKgG8 f5Ub9hDZ7nlk/bnD51yCLVkmHL9VIIagOuw+KOBuzt0p/261
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
 drivers/tty/serial/serial-tegra.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 6d4006b41975..525f3a2f7bd4 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1611,13 +1611,12 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tegra_uart_remove(struct platform_device *pdev)
+static void tegra_uart_remove(struct platform_device *pdev)
 {
 	struct tegra_uart_port *tup = platform_get_drvdata(pdev);
 	struct uart_port *u = &tup->uport;
 
 	uart_remove_one_port(&tegra_uart_driver, u);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1644,7 +1643,7 @@ static const struct dev_pm_ops tegra_uart_pm_ops = {
 
 static struct platform_driver tegra_uart_platform_driver = {
 	.probe		= tegra_uart_probe,
-	.remove		= tegra_uart_remove,
+	.remove_new	= tegra_uart_remove,
 	.driver		= {
 		.name	= "serial-tegra",
 		.of_match_table = tegra_uart_of_match,
-- 
2.42.0

