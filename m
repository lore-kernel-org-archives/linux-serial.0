Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE10C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjKJR4K (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjKJRzo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:44 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4123AE01
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-0006PL-4l; Fri, 10 Nov 2023 16:30:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-0083Kr-Vd; Fri, 10 Nov 2023 16:30:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-00Gnx9-Ma; Fri, 10 Nov 2023 16:30:46 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Yangtao Li <frank.li@vivo.com>,
        Thierry Reding <treding@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: [PATCH 35/52] serial: sccnxp: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:03 +0100
Message-ID: <20231110152927.70601-36-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Zwo0fde9Fmjq3fBI9vN+ath/c0eptfnAqi+hn+91mVM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyFwJHa22wtQ/8r4RMPqYLDBh/rPmqOoZI2E kCtVYN9WdyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MhQAKCRCPgPtYfRL+ TsVPCACYy06KBoKyw0Q+Kf7AJkQ0cpewSUG13gkMZ9HSV5Sl/eS5uMK7qJFMF0vyUDGqMd3W2Ui rFlQ4Ym0eHE3o7ESZj9D7NOZGhdbcuh5Zvs3otgSI9D5btqtsd48it0p2pPGN8GOToa6BpxTVno A6lRevWe404bE187wYejp6LYppHg8DpX7eN6csS4RVC7DH16UbzC4D/jVmyRcGUcZt/JvWWM3pJ hnxWY8C/JGNk76pYmTL7IMGOiDyH85JguLkpaLqNUmZgoNJiQda11DGS6J6GZglujNMAfebMZky Pf6MKakeGx4bvt2OWb2Vkpkr7vCecZv39+QORgo9Rdvx5dXq
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
 drivers/tty/serial/sccnxp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 8269b0fb3083..f24217a560d7 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -1021,7 +1021,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sccnxp_remove(struct platform_device *pdev)
+static void sccnxp_remove(struct platform_device *pdev)
 {
 	int i;
 	struct sccnxp_port *s = platform_get_drvdata(pdev);
@@ -1041,8 +1041,6 @@ static int sccnxp_remove(struct platform_device *pdev)
 		if (ret)
 			dev_err(&pdev->dev, "Failed to disable regulator\n");
 	}
-
-	return 0;
 }
 
 static struct platform_driver sccnxp_uart_driver = {
@@ -1050,7 +1048,7 @@ static struct platform_driver sccnxp_uart_driver = {
 		.name	= SCCNXP_NAME,
 	},
 	.probe		= sccnxp_probe,
-	.remove		= sccnxp_remove,
+	.remove_new	= sccnxp_remove,
 	.id_table	= sccnxp_id_table,
 };
 module_platform_driver(sccnxp_uart_driver);
-- 
2.42.0

