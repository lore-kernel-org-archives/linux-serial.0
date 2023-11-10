Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DD7C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbjKJSRU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345217AbjKJSPg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:36 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886553AE02
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-0006If-Uq; Fri, 10 Nov 2023 16:30:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT2-0083K5-Js; Fri, 10 Nov 2023 16:30:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT2-00GnwI-AJ; Fri, 10 Nov 2023 16:30:44 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Lucas Tanure <tanure@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Krasavin <pkrasavin@imaqliq.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 23/52] serial: meson: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:51 +0100
Message-ID: <20231110152927.70601-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FYolZrFOFgUo4prnGFbVvGWakGEu6coU7k3q8Li2/Fk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxyX0bjsRruDSjLNjkWf3vtgo37pge57d2zv axzBIKV9IWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5McgAKCRCPgPtYfRL+ TjrQB/986Mot5WK/tLMUZb9GRdNnimXXlpB72WYieVtWZUIsilKqDbr4K+RLiSJP+GW0Z6Fdegx RXbbIFvPg/qxvn16C3FN0duoGFMCto3p7kC+Sg7lO1jN+8lSP2xJez7hpCSlVsX3UppXbdQgif5 O9AoVDIIP5M5t9D5XJGohdqmtXraYauESWOpSZNxtcc0yJqCwfeJBLytLz//jkj/8oOlIVSOLSL trfENEbqIdQp2bJTw7uLZX69kM5UTMAZTDUh8Cm7IDBI4u1EwN+vapw3Rj0VMBrmVuahDjR4Vq6 tzIPLDeh5Wjx+X2xRh00eDKQdYenUPf4Ywk0A9xlNUKnSA/E
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
 drivers/tty/serial/meson_uart.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8dd84617e715..8395688f5ee9 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -795,7 +795,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int meson_uart_remove(struct platform_device *pdev)
+static void meson_uart_remove(struct platform_device *pdev)
 {
 	struct uart_driver *uart_driver;
 	struct uart_port *port;
@@ -807,12 +807,10 @@ static int meson_uart_remove(struct platform_device *pdev)
 
 	for (int id = 0; id < AML_UART_PORT_NUM; id++)
 		if (meson_ports[id])
-			return 0;
+			return;
 
 	/* No more available uart ports, unregister uart driver */
 	uart_unregister_driver(uart_driver);
-
-	return 0;
 }
 
 static struct meson_uart_data meson_g12a_uart_data = {
@@ -852,7 +850,7 @@ MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
 
 static  struct platform_driver meson_uart_platform_driver = {
 	.probe		= meson_uart_probe,
-	.remove		= meson_uart_remove,
+	.remove_new	= meson_uart_remove,
 	.driver		= {
 		.name		= "meson_uart",
 		.of_match_table	= meson_uart_dt_match,
-- 
2.42.0

