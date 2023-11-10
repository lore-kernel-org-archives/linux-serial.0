Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E94C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbjKJSS1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKJSRR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:17 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDBF3A8A0
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-00066p-1W; Fri, 10 Nov 2023 16:30:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSz-0083J5-GY; Fri, 10 Nov 2023 16:30:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSz-00GnvK-7O; Fri, 10 Nov 2023 16:30:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/52] serial: atmel: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:36 +0100
Message-ID: <20231110152927.70601-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=u0ZhdeTOBj+D3C418vMkM9Jw94t5Dl9Hy+aVn0jANZs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxgMjgxStUfcgGlCx9LW1adPB6LE7z3p53BV C4k6JzJVoaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MYAAKCRCPgPtYfRL+ TsL9CACKYZ6USkyN1ixlUND/aJPmfvUMsU+CsCrLSGOp0on5sxXA11KtgWH/gbrFyf5+QlpDFV5 OgppDTcAUAx8ykx80pBkxUvSOmg7lhST7qXLYbd1Tb95g7tAUTO4nCyw8tYTj60+moHYFk30/VN kPWeBWhQTxs52Dhij5Z4H4of7LHii4hPhx67Z/iGUSOeKNbdn5Wn9zcIbMl0E9Wq6pv4AZpQZbx Q6XAGqNS/XFsVljF33q2id+Q4cV8lSl7Are2OmtSoWjRg7xblWbLkG6jKvlvnYPDrt6cHEGZPZj Ev52sD1I4aOa9B5ReW32ZCTawae6KmO+47HhwOFFr/k72nl4
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
 drivers/tty/serial/atmel_serial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 1946fafc3f3e..6792680690bd 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -3001,7 +3001,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
  * protocol that needs bitbanging on IO lines, but use the regular serial
  * port in the normal case.
  */
-static int atmel_serial_remove(struct platform_device *pdev)
+static void atmel_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
@@ -3020,8 +3020,6 @@ static int atmel_serial_remove(struct platform_device *pdev)
 	clear_bit(port->line, atmel_ports_in_use);
 
 	pdev->dev.of_node = NULL;
-
-	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
@@ -3029,7 +3027,7 @@ static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
 
 static struct platform_driver atmel_serial_driver = {
 	.probe		= atmel_serial_probe,
-	.remove		= atmel_serial_remove,
+	.remove_new	= atmel_serial_remove,
 	.driver		= {
 		.name			= "atmel_usart_serial",
 		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
-- 
2.42.0

