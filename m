Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBBDC4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345531AbjKJSYj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345635AbjKJSXo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:23:44 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C683A89B
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-00066d-1o; Fri, 10 Nov 2023 16:30:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSy-0083Iv-SV; Fri, 10 Nov 2023 16:30:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSy-00Gnv2-JQ; Fri, 10 Nov 2023 16:30:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 05/52] serial: altera: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:33 +0100
Message-ID: <20231110152927.70601-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=lbJBlOeJmc63JD8i51kbMm4/zaPKAKG4zNfQIiRF5Ag=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxdfVjEVOSSfGkePfJPnFIhIyMnDwyYCy9vE lHhCuOwUL6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MXQAKCRCPgPtYfRL+ Tn5PCACL1ze7vndjsYAK87zvrzz/XLhQraAeCFRaqNp9AAf9n8fadNHYo8XdC4kosiWc3Z/1iiD stGd4zUVQhAbsn2zfTjTI0o1a4RH2gnuxgZMRGWONYBjrPn9ZJazOcF0hJqQ2qQTNuQ7stGQpVl Z9ZpylUf3x2UobpYtf+4LUUf6TJkLy4ZY8VbZqVQ3REkaHsEb/2YII1WMyQTWMI6G1Be6oYp6J6 JRorGBM+VA2aGGCtQ/Wsv5KpVx6qzckimy+LlN2djPHdxVKr0rGyNdoHCouv5j8z18rnKEakIur XcnjgwX2hmgs4TDr3PFixku99FHhUuuwtQm39iqDoExHY+BQ
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
 drivers/tty/serial/altera_uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 77835ac68df2..081bec31dbd8 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -595,7 +595,7 @@ static int altera_uart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int altera_uart_remove(struct platform_device *pdev)
+static void altera_uart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
@@ -604,8 +604,6 @@ static int altera_uart_remove(struct platform_device *pdev)
 		port->mapbase = 0;
 		iounmap(port->membase);
 	}
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -619,7 +617,7 @@ MODULE_DEVICE_TABLE(of, altera_uart_match);
 
 static struct platform_driver altera_uart_platform_driver = {
 	.probe	= altera_uart_probe,
-	.remove	= altera_uart_remove,
+	.remove_new = altera_uart_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.of_match_table	= of_match_ptr(altera_uart_match),
-- 
2.42.0

