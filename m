Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49871C4167B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjKJRqA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjKJRo6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:44:58 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2FD3A8B4
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-0006RQ-Nb; Fri, 10 Nov 2023 16:30:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-0083LF-7n; Fri, 10 Nov 2023 16:30:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT5-00GnxX-Us; Fri, 10 Nov 2023 16:30:47 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 41/52] serial: st-asc: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:09 +0100
Message-ID: <20231110152927.70601-42-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=gZAuzkYCGY0dF9/FS9pnOeoUofxsKi3Iu2S8ruq8iME=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyMPWumyxIsIlwiGvagUxMnaptSsbwMux23e 5d5mfo9v2aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MjAAKCRCPgPtYfRL+ ToZgCACKw3RLWpSoo/7rdWWIY4lxOB81Wg6GnHCOLfGnoi/Es1OdVJl2N+FxUO21GX0BDcF2TZC T1OEHHTz4Ey66K2iaQyA4lXjoD+xhhu7eJHWuv3CEdQE4lzsl8n0Dhu9q+UITVoI/t2zLGUvFnL e51FM++X8DqqbIC4WPoLFDIqtNv8TjQxvw9s7LJ6CF8nRfc41XbMzxDkidzyTD4PjRhssd27nFk 5M9P1GXde6KC11mc+jWecG8jX6GXVoY1eKfmG6lRhottrUEAzD8y1Y6BoshxP9V/LP85Xp/c/yJ oCVVmCnr1gPe3t9xhlbDtdHBCI1QsrwdJ+R9PGv2YrvN3QrS
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
 drivers/tty/serial/st-asc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index a821f5d76a26..bbb5595d7e24 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -793,13 +793,11 @@ static int asc_serial_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int asc_serial_remove(struct platform_device *pdev)
+static void asc_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&asc_uart_driver, port);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -932,7 +930,7 @@ static const struct dev_pm_ops asc_serial_pm_ops = {
 
 static struct platform_driver asc_serial_driver = {
 	.probe		= asc_serial_probe,
-	.remove		= asc_serial_remove,
+	.remove_new	= asc_serial_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.pm	= &asc_serial_pm_ops,
-- 
2.42.0

