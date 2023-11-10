Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F742C04A95
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbjKJSdv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345518AbjKJSc4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:32:56 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3113AE15
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-0006Q5-DD; Fri, 10 Nov 2023 16:30:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT5-0083L0-E7; Fri, 10 Nov 2023 16:30:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT5-00GnxH-4w; Fri, 10 Nov 2023 16:30:47 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard GENOUD <richard.genoud@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 37/52] serial: txx9: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:05 +0100
Message-ID: <20231110152927.70601-38-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=79i3JRQQkLyJUMUcsqiIaRJXAT6ziqOMjwh1zWRC1Bw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyH/z9AUSsLRwGXvLcQdyKx3SkQoo8Q9sDmS ARHmJcyb9KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MhwAKCRCPgPtYfRL+ TjJiB/9a9S8q/hNJCkKE3MxOJ9xnu6SXuRaie4H312fqlnVTOiVU7VYq1o/5SpEAb8CwBYX0CcJ EeDIb1zHlYz7QDDHpIb6GehtI4FzpgraiGlt+TjxKMP/OJ+79W8+GLEWmQjZCfNwZt83aLahpgi KSQKZzEjGUVaMOlbYPAuZ9HyH0OK1uKzmL28oWVLrzQ3G5ZXYNZMJNvOv9Y6LkdxajhG+gmtNM8 ZpV6dgDX0DDJftPbFCGnuyTyQLbfrRN1pkP1+WcDD84+SlxuQLH+1v6EU85kZl+8lNJ4siLUDHE wmsTk56miai5shB4d5cYIK/EWm+9nvYhgJ4WNS8Ywc8BbEib
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
 drivers/tty/serial/serial_txx9.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index eaa980722455..e1897894a4ef 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1052,7 +1052,7 @@ static int serial_txx9_probe(struct platform_device *dev)
 /*
  * Remove serial ports registered against a platform device.
  */
-static int serial_txx9_remove(struct platform_device *dev)
+static void serial_txx9_remove(struct platform_device *dev)
 {
 	int i;
 
@@ -1062,7 +1062,6 @@ static int serial_txx9_remove(struct platform_device *dev)
 		if (up->dev == &dev->dev)
 			serial_txx9_unregister_port(i);
 	}
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1097,7 +1096,7 @@ static int serial_txx9_resume(struct platform_device *dev)
 
 static struct platform_driver serial_txx9_plat_driver = {
 	.probe		= serial_txx9_probe,
-	.remove		= serial_txx9_remove,
+	.remove_new	= serial_txx9_remove,
 #ifdef CONFIG_PM
 	.suspend	= serial_txx9_suspend,
 	.resume		= serial_txx9_resume,
-- 
2.42.0

