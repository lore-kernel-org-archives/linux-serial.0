Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E7C4167B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjKJSEK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjKJSC5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:02:57 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461193AE1E
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-00069U-AV; Fri, 10 Nov 2023 16:30:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-0083Ja-T5; Fri, 10 Nov 2023 16:30:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-00Gnvm-Jy; Fri, 10 Nov 2023 16:30:42 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 15/52] serial: fsl_linflexuart: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:43 +0100
Message-ID: <20231110152927.70601-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2G3ltYjAqyXMcjfNA8QYefySVZO5NNm3Kbucgc2FEdc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxopc+mRTBnSI0MBOJgHFO86sOFlrAijLI3v UauFar4V+2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MaAAKCRCPgPtYfRL+ Tg9uB/9W3dqXtF3j7nQMTCgRXnl/k/VrrdsBMGdpqXt8/3J20jDSMhZ7vq3luHMNSFJLsKIFr2v +sgOh94bDMPFravWG0ER7EXVjGeA+Pb4fkx87LugVB5SCC6b3o6QVDxfhMysJqV8mWFMmpupNrm 3+n//6m6kaWI+v61Slt3V8VViKvLjiubzd9oqvsyvXSuyPMYaSE5+La4LgnPZ6yiLgYK9uF9ZYI QDOj4MPP1a2O0lhUnd8nVSVoDZ81iSfERXn3fzcI+XolxZsMV2kJh7i7nerwuU7hzuvg9IZBqlw b1MswCnHzrnYSf6AnICTssU3gSTzEAw/ViW4RNwWY64P0jcH
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
 drivers/tty/serial/fsl_linflexuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 3bdaf1ddc309..52c87876a88d 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -851,13 +851,11 @@ static int linflex_probe(struct platform_device *pdev)
 	return uart_add_one_port(&linflex_reg, sport);
 }
 
-static int linflex_remove(struct platform_device *pdev)
+static void linflex_remove(struct platform_device *pdev)
 {
 	struct uart_port *sport = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&linflex_reg, sport);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -884,7 +882,7 @@ static SIMPLE_DEV_PM_OPS(linflex_pm_ops, linflex_suspend, linflex_resume);
 
 static struct platform_driver linflex_driver = {
 	.probe		= linflex_probe,
-	.remove		= linflex_remove,
+	.remove_new	= linflex_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table	= linflex_dt_ids,
-- 
2.42.0

