Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9737C41535
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 20:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbjKJU03 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 15:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjKJU01 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 15:26:27 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B9D3A8A9
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT2-0006B4-67; Fri, 10 Nov 2023 16:30:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT1-0083Je-39; Fri, 10 Nov 2023 16:30:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-00Gnvq-QL; Fri, 10 Nov 2023 16:30:42 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Sherry Sun <sherry.sun@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 16/52] serial: fsl_lpuart: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:44 +0100
Message-ID: <20231110152927.70601-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cBrZsJaLt+Kv2NP3bg9HZqCIEBEZkMRd+Ohrt9BAuVM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxqtNdBS1+l0HwWnYUFqOtYENLT80p9xY7GD gBl0RcNA1+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MagAKCRCPgPtYfRL+ Tg96CACgpeZ9hZtHp87jWhDF5a3n4E/8Kyl7vkvLV2HqUO5N3B71ss1jWQAAblFANA/bzA8xTkf OGA37HM8Orh7OayL/Fbqtsza4LiI8qiBt3GsdH+MaPZnEpYPQ/rbvVeVxSt4jcwUct/Lelwx3uB sC7W9gl7sIy7KgUpmd7pk/sNqtRqAx5/9v7pRQVWsDrz4CJpOpOBKVIUDJ5NfL/db4TDVaW0bf7 7GmiTOBh+LObn/TL8WQ/KXBMq32YI/dE7CuBJ5j7aYxnF4VVplHxBi8NTbKTw8qbCc/NzimgXdX h6uSivz254YnwR1PdXww1LViiuO/x6DOESVhq5mpBujCkZDS
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
 drivers/tty/serial/fsl_lpuart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6d0cfb2e86b4..5ddf110aedbe 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2959,7 +2959,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int lpuart_remove(struct platform_device *pdev)
+static void lpuart_remove(struct platform_device *pdev)
 {
 	struct lpuart_port *sport = platform_get_drvdata(pdev);
 
@@ -2976,7 +2976,6 @@ static int lpuart_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	return 0;
 }
 
 static int lpuart_runtime_suspend(struct device *dev)
@@ -3210,7 +3209,7 @@ static const struct dev_pm_ops lpuart_pm_ops = {
 
 static struct platform_driver lpuart_driver = {
 	.probe		= lpuart_probe,
-	.remove		= lpuart_remove,
+	.remove_new	= lpuart_remove,
 	.driver		= {
 		.name	= "fsl-lpuart",
 		.of_match_table = lpuart_dt_ids,
-- 
2.42.0

