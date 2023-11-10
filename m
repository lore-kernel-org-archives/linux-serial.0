Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927C7C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjKJRxp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjKJRwt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:49 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DFA3A8A8
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT1-00067r-6Y; Fri, 10 Nov 2023 16:30:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-0083JK-8Z; Fri, 10 Nov 2023 16:30:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSz-00Gnva-Vf; Fri, 10 Nov 2023 16:30:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Thierry Reding <treding@nvidia.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/52] serial: digicolor: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:40 +0100
Message-ID: <20231110152927.70601-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=m1r+QnP/V3kim5WaF5/ossgE+daOyiM+Oba/zRsf6PU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxldbtdlasu2fgCBkvHIU0UHpc1TpfPHHQ4i C+4HuAlVYqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MZQAKCRCPgPtYfRL+ TjSTCACuWfN+bQoO9xganPfDGRi2FGjr5tmYUWYpcGC9fB+4bGv+CfhkRiG58Q/z7V8418yuo7h JAY7M7ASFODk5DgfEwW9E8QUVDFXA1IeyZZebxiOniXQCxfTQfN+QgnPxAaNz1Fsp22Yv0/9fd0 ynVktuIei55uYWy/R3GsUcp/qkmImrcLe/fFU407NdHkRmdna7tGy6MiVF1Y/kokZvC+QSfXZH9 7sfseQB9ua4mBl1IHcv96YPMCqCQ06DYRKV/0PpnMx/ytsKLUQ67MIzspZcQW7ezFCxlrMrLZ7q dEJVe8Dqut7Y/YaP21S4Tt94fHXtp8+WAIlHpTVdhO8/WNfW
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
 drivers/tty/serial/digicolor-usart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 5004125f3045..e419c4bde8b7 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -503,13 +503,11 @@ static int digicolor_uart_probe(struct platform_device *pdev)
 	return uart_add_one_port(&digicolor_uart, &dp->port);
 }
 
-static int digicolor_uart_remove(struct platform_device *pdev)
+static void digicolor_uart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&digicolor_uart, port);
-
-	return 0;
 }
 
 static const struct of_device_id digicolor_uart_dt_ids[] = {
@@ -524,7 +522,7 @@ static struct platform_driver digicolor_uart_platform = {
 		.of_match_table	= of_match_ptr(digicolor_uart_dt_ids),
 	},
 	.probe	= digicolor_uart_probe,
-	.remove	= digicolor_uart_remove,
+	.remove_new = digicolor_uart_remove,
 };
 
 static int __init digicolor_uart_init(void)
-- 
2.42.0

