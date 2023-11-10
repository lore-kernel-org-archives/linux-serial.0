Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E71C04A95
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjKJRxa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjKJRws (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:48 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FE23AE16
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-0006Ki-Jl; Fri, 10 Nov 2023 16:30:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT3-0083KK-Dn; Fri, 10 Nov 2023 16:30:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT3-00GnwY-4V; Fri, 10 Nov 2023 16:30:45 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 27/52] serial: mxs-auart: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:55 +0100
Message-ID: <20231110152927.70601-28-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=VfpMm7cTlHQjFHazZwl+9YZCmrz3p1Oofs9F/ccNpLc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkx26upryIfvTOAF2rKNwS7uWdwE3LIjoYvzq eGVN81ndzmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MdgAKCRCPgPtYfRL+ TmTkB/9z5mWAlz2uvDmYnpMb2J3eVVtr2bfF1dSnua99obNSNKec2mpLl/zbc3IjHXegGNE9HH6 QhrDxbYJVW+per+b43cXGsT8gSmHs1qzMkrLtShcA97liA5l76de4UrO2OZ+CCQR75IFnEBmhoo 7bxWqWfN+tTlUvz1+qeECXsNTLpcvqsuOTHBAnD/UKyUNBcP8vt6YiExH/KHWQFrDsO0EJVjWsJ Na3iAi8MwYAT1thlsvifcASm6yqgoO183GOWywpjpZ8LM2jfuXzeeYeCoiO5njab7BLLw+V8jT9 OI5bgzCa07yugmYwN5Pl4fqfhukut0yswdW5IUKs4BHI2cmO
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
 drivers/tty/serial/mxs-auart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 8eeecf8ad359..2be9546e0e15 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1686,7 +1686,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mxs_auart_remove(struct platform_device *pdev)
+static void mxs_auart_remove(struct platform_device *pdev)
 {
 	struct mxs_auart_port *s = platform_get_drvdata(pdev);
 
@@ -1698,13 +1698,11 @@ static int mxs_auart_remove(struct platform_device *pdev)
 		clk_disable_unprepare(s->clk);
 		clk_disable_unprepare(s->clk_ahb);
 	}
-
-	return 0;
 }
 
 static struct platform_driver mxs_auart_driver = {
 	.probe = mxs_auart_probe,
-	.remove = mxs_auart_remove,
+	.remove_new = mxs_auart_remove,
 	.driver = {
 		.name = "mxs-auart",
 		.of_match_table = mxs_auart_dt_ids,
-- 
2.42.0

