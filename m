Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C909C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjKJRpe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjKJRoS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:44:18 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0468A3AE07
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-0006JJ-2d; Fri, 10 Nov 2023 16:30:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT2-0083K8-QJ; Fri, 10 Nov 2023 16:30:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT2-00GnwM-H4; Fri, 10 Nov 2023 16:30:44 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Richard GENOUD <richard.genoud@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 24/52] serial: milbeaut_usio: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:52 +0100
Message-ID: <20231110152927.70601-25-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5dC5hOaR8p4hb5FBmDiwUfMqSdt2Nmyae1ha7PL3HZ8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxz3saYgYOdjKhX1V0wjsSoFmcAQrVigs94R zBY5o/uShOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5McwAKCRCPgPtYfRL+ TpDTCACGTxFSNZ2e9TXT6EcfCrHq6FsAZuBpwQoTSrVVvOyAIEPCXFctxClWK4nBgUsglGyjIA7 YPULC4NJ7I99Cxs+R+Os5K1mZ4jGNjiEWO1YeyeUcYAQKMoawfexq3jZp5k4drIzl5+9ErLLysG zlW58b0tLgs6LLBDmGs/NBdlXkvtAcuEZrZpIIDvtSyy8uZ1n3cM/EZofEjC8/qCkLZ4oi50gi/ O+wyL6bAE2STD0LRxmQ82Kqzq4OwBDytTgJLdFADXlcZ2vvZNHZ21mebXbFfs3GX/LT6wfUF4gC CzaSKzJDEsdxubZ93IC00DHYxZfLTaydaMiGZt6HRd9bsZLI
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
 drivers/tty/serial/milbeaut_usio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index db3b81f2aa57..da4c6f7e2a30 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -552,15 +552,13 @@ static int mlb_usio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mlb_usio_remove(struct platform_device *pdev)
+static void mlb_usio_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = &mlb_usio_ports[pdev->id];
 	struct clk *clk = port->private_data;
 
 	uart_remove_one_port(&mlb_usio_uart_driver, port);
 	clk_disable_unprepare(clk);
-
-	return 0;
 }
 
 static const struct of_device_id mlb_usio_dt_ids[] = {
@@ -571,7 +569,7 @@ MODULE_DEVICE_TABLE(of, mlb_usio_dt_ids);
 
 static struct platform_driver mlb_usio_driver = {
 	.probe          = mlb_usio_probe,
-	.remove         = mlb_usio_remove,
+	.remove_new     = mlb_usio_remove,
 	.driver         = {
 		.name   = USIO_NAME,
 		.of_match_table = mlb_usio_dt_ids,
-- 
2.42.0

