Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E691C4167D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbjKJSNM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345851AbjKJSLa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:11:30 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D413A8A2
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-00066i-An; Fri, 10 Nov 2023 16:30:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSz-0083J1-8c; Fri, 10 Nov 2023 16:30:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSy-00GnvB-Vq; Fri, 10 Nov 2023 16:30:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 07/52] serial: ar933x: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:35 +0100
Message-ID: <20231110152927.70601-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=AS+2U08CvMoMeR1jTWo5UvWPRwWQXhe1jsvKSp6+81A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxf+V2Ya432yrWcjyAbILSO/zI6Mm0fl280A UdFahfzuseJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MXwAKCRCPgPtYfRL+ TuC4CACT6zVa3d7sN5CvWWH0cA9wD3oindmMOgvP+ccAz8nYHBMv2NSGZLP+HuGcUG3dtAscojm 7Efjaudn7OpasfiZW5to4rI95I3cSqmXD+m5tzaXY+79ociRtq2kjD1KMPpUbqEYIRtvLMwmc7Q UXgguY1JuNzvCn89BgTfqQp7T/wJe/8IPTJLsMTDAU5m5MEzdU6+I/BrO1oeudsYODz0TSXqwJJ Y6ECnsLoHhRLshCm9XeQxnrDWRYsEFE6Nw25SfVp/R0GGBFLCHRqwYxNbgusmpPkZGWc9bQcwgg Kpsak+d+Nl3y2HmystEy6BUZX0BvkkCavo5KxxBsB0Rz9vbf
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
 drivers/tty/serial/ar933x_uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index ffd234673177..8d09ace062e5 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -818,7 +818,7 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ar933x_uart_remove(struct platform_device *pdev)
+static void ar933x_uart_remove(struct platform_device *pdev)
 {
 	struct ar933x_uart_port *up;
 
@@ -828,8 +828,6 @@ static int ar933x_uart_remove(struct platform_device *pdev)
 		uart_remove_one_port(&ar933x_uart_driver, &up->port);
 		clk_disable_unprepare(up->clk);
 	}
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -842,7 +840,7 @@ MODULE_DEVICE_TABLE(of, ar933x_uart_of_ids);
 
 static struct platform_driver ar933x_uart_platform_driver = {
 	.probe		= ar933x_uart_probe,
-	.remove		= ar933x_uart_remove,
+	.remove_new	= ar933x_uart_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.of_match_table = of_match_ptr(ar933x_uart_of_ids),
-- 
2.42.0

