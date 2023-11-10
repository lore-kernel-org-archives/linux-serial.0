Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560E6C04A95
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbjKJS1N (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346062AbjKJS0C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:26:02 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68253A8B6
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT5-0006Oc-Nz; Fri, 10 Nov 2023 16:30:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-0083Kk-JJ; Fri, 10 Nov 2023 16:30:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-00Gnx1-AD; Fri, 10 Nov 2023 16:30:46 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Tobias Klauser <tklauser@distanz.ch>,
        Thierry Reding <treding@nvidia.com>,
        Richard GENOUD <richard.genoud@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 33/52] serial: sa1100: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:01 +0100
Message-ID: <20231110152927.70601-34-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Mo/F4raIm00r9Gtqz/sCTdkTkKnLqJ4mLJHfyZv8GXo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyDtV3B5ImykGvoVY7cvZzL+s+GndE9oZgr/ Js/fzGmFFeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MgwAKCRCPgPtYfRL+ TvdnB/998WVQDuWPPH6mpkIUajOKdlqC+yiJBXh6OZcHYWs34vWyefe29DUNXVSFoWuCms+Fx2X 0P0peHiUTzG4h72lWDcyiI24u8Dj+s8tgvjh1zTUplAaTXPk6HJyqTpID0RK3dtvp/Vs8sRV6iD Q9PRcslqjX6onixpt3WBP655COiBfoReq0B7+1eriXXE8bRO1dx7rTVMP/ZtGvBXNvM+J4m/tJJ kjOnoF8GkvLSyp4ZyRwwPt3kjb7RLlLaFYyNd5mnTbVS8GES6lj5TbPz2LannX895ehpoXv/COJ jlIIITKrdv19fW7sV+0ZULu7NiH3Q3ZWVO20mBTqYk0gBryd
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
 drivers/tty/serial/sa1100.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index be7bcd75d9f4..79c794fa6545 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -870,19 +870,17 @@ static int sa1100_serial_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int sa1100_serial_remove(struct platform_device *pdev)
+static void sa1100_serial_remove(struct platform_device *pdev)
 {
 	struct sa1100_port *sport = platform_get_drvdata(pdev);
 
 	if (sport)
 		uart_remove_one_port(&sa1100_reg, &sport->port);
-
-	return 0;
 }
 
 static struct platform_driver sa11x0_serial_driver = {
 	.probe		= sa1100_serial_probe,
-	.remove		= sa1100_serial_remove,
+	.remove_new	= sa1100_serial_remove,
 	.suspend	= sa1100_serial_suspend,
 	.resume		= sa1100_serial_resume,
 	.driver		= {
-- 
2.42.0

