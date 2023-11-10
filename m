Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BC7C4167D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 20:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbjKJUhA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 15:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346075AbjKJUgo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 15:36:44 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6B63AE0C
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-0006L8-SU; Fri, 10 Nov 2023 16:30:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT3-0083KP-K8; Fri, 10 Nov 2023 16:30:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT3-00Gnwc-B5; Fri, 10 Nov 2023 16:30:45 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <frank.li@vivo.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 28/52] serial: omap: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:56 +0100
Message-ID: <20231110152927.70601-29-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=S7IayNuDy+Bdm9n+oVx2ki9SDTzHf1WNibFrPz3lNOo=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQ/n4r4W6em/AkIYZeJfVmwWulNAMP/tGpV3aCsG+KFD 8tkll7qZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiAUIcDIvfH3Oub5S6zpVh E6/0je2oJuc+08S1H7+zBVrOM5vmY7CVS+zicfnnrnYLijYedF+2sG7jZ5cf95fKqDpEvS+f/TN CMYxzw/u5tbyZzj9nJMjrX9u4bDZ7q6uOrNbmxMwnx2YUGD6baL9e5/niU707fjhP3rwvx5gltY /D8LPsurebLMyC+iuFJoT4CU73nBFQOW39vM6P/eu8Xhm4mBjLzLlfyt+70XqFwprKFQzTTZWYw i54hKwubNeJmR/ww4n9VWOxdpTgroYDN1mm3IjU4OOU0RVXKp+vxrfyeBifyVKzWJmLb6ZGO0qo 7D81J0til9WT56U7HjC+y8nanbIk3uO6ufK2tlaOJesNAQ==
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
 drivers/tty/serial/omap-serial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ad4c1c5d0a7f..730755621879 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1658,7 +1658,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int serial_omap_remove(struct platform_device *dev)
+static void serial_omap_remove(struct platform_device *dev)
 {
 	struct uart_omap_port *up = platform_get_drvdata(dev);
 
@@ -1670,8 +1670,6 @@ static int serial_omap_remove(struct platform_device *dev)
 	pm_runtime_disable(up->dev);
 	cpu_latency_qos_remove_request(&up->pm_qos_request);
 	device_init_wakeup(&dev->dev, false);
-
-	return 0;
 }
 
 /*
@@ -1808,7 +1806,7 @@ MODULE_DEVICE_TABLE(of, omap_serial_of_match);
 
 static struct platform_driver serial_omap_driver = {
 	.probe          = serial_omap_probe,
-	.remove         = serial_omap_remove,
+	.remove_new     = serial_omap_remove,
 	.driver		= {
 		.name	= OMAP_SERIAL_DRIVER_NAME,
 		.pm	= &serial_omap_dev_pm_ops,
-- 
2.42.0

