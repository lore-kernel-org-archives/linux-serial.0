Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F78C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 20:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjKJUbb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 15:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKJUb2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 15:31:28 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA1F3AE1F
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT3-0006Du-Ap; Fri, 10 Nov 2023 16:30:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT1-0083Jo-Hd; Fri, 10 Nov 2023 16:30:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT1-00Gnvy-8Z; Fri, 10 Nov 2023 16:30:43 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: [PATCH 18/52] serial: lantiq: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:46 +0100
Message-ID: <20231110152927.70601-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CF5Oa6PoqYLuMNSgkYDnCcWEdAJvUfAPNJOaH562USI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxsmHEt0nsNYR/NXFtaRRPgyHMpd1VtI2+Kd WnNlMR9taKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MbAAKCRCPgPtYfRL+ TgzIB/4ij4Bi4GeqVk0OYID6+hdxxvjVe/rS1MlXxz3dTo07Uz8rsbQeeBicTdalRynxBJiv/Fi SqTsmd4SbMewiLmCP6OYT/OPL43f9r163QLUaugwtUaTylE1XqooLdY3zuFVkDmJpbL4dxGV7Zs nA1Ok8hunWyKN7FcSQ19nnPxqeItWKEkcCZLvojiaGI/s3hLw2usB+HIrDtOqulJipI45fyM4t5 ylLr2AzmQbxtHLWo9er53GbLnxtsdgBORmTz+NLVwlMZFEoAKH6NzqsWrYCTza56ef6MCJ2xK/r 6HsSKzsPosPB0QLQw3zc95MtUsRFlwpLnSsqJPcf8vcJc/gO
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
 drivers/tty/serial/lantiq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 3adb60c683f7..a0731773ce75 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -887,13 +887,11 @@ static int lqasc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int lqasc_remove(struct platform_device *pdev)
+static void lqasc_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&lqasc_reg, port);
-
-	return 0;
 }
 
 static const struct ltq_soc_data soc_data_lantiq = {
@@ -917,7 +915,7 @@ MODULE_DEVICE_TABLE(of, ltq_asc_match);
 
 static struct platform_driver lqasc_driver = {
 	.probe		= lqasc_probe,
-	.remove		= lqasc_remove,
+	.remove_new	= lqasc_remove,
 	.driver		= {
 		.name	= DRVNAME,
 		.of_match_table = ltq_asc_match,
-- 
2.42.0

