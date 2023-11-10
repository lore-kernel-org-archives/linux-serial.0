Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939EBC41535
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjKJRyB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjKJRxI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:08 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2CD3A8BF
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-0006HD-3v; Fri, 10 Nov 2023 16:30:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT2-0083Jy-4a; Fri, 10 Nov 2023 16:30:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT1-00GnwA-Rs; Fri, 10 Nov 2023 16:30:43 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 21/52] serial: ma35d1: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:49 +0100
Message-ID: <20231110152927.70601-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=xXk+TVE7dE8/euVq49S9TnrT4fp6HD189gy9coOLDAU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxvV4M5qli06ha2LCk9EY5gP5zg1ymI/Jof5 zVzLbhXKVaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MbwAKCRCPgPtYfRL+ Tk+MB/92s4O2rZ7LqxXCPdj0KWYRaU+i/vrlX8MsPI6wgZKj0BcMP3cSfYX6LyBmXUHc9fZjsfB PBouFrEdejJyp57PvG/Vpvkoemj3u6m9ECIj0sPnLiAQgmF8XA+oXVlSAarTNE2T7i1HSVbEgoY 5KZeua+ptjI5jp+FFkOZqNrGmYpDwFdgVDRRpTe6CElYPIMAojnXEZzwVdS5PUvMrbGgTlQBTKz uW+YuEMhwZTiCt52Ih08D+2V5nXwRp2nHZWo/97JgDybcuzeStVa5PirRGoe65L8iu79YYd/pjw 4NGDzZi5ooeQFPTwlHvqneQLVZUak7fr2H6+bhDQPexGhTQU
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
 drivers/tty/serial/ma35d1_serial.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index a6a7c405892e..f9c6c75d9776 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -746,14 +746,13 @@ static int ma35d1serial_probe(struct platform_device *pdev)
 /*
  * Remove serial ports registered against a platform device.
  */
-static int ma35d1serial_remove(struct platform_device *dev)
+static void ma35d1serial_remove(struct platform_device *dev)
 {
 	struct uart_port *port = platform_get_drvdata(dev);
 	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
 
 	uart_remove_one_port(&ma35d1serial_reg, port);
 	clk_disable_unprepare(up->clk);
-	return 0;
 }
 
 static int ma35d1serial_suspend(struct platform_device *dev, pm_message_t state)
@@ -786,7 +785,7 @@ static int ma35d1serial_resume(struct platform_device *dev)
 
 static struct platform_driver ma35d1serial_driver = {
 	.probe      = ma35d1serial_probe,
-	.remove     = ma35d1serial_remove,
+	.remove_new = ma35d1serial_remove,
 	.suspend    = ma35d1serial_suspend,
 	.resume     = ma35d1serial_resume,
 	.driver     = {
-- 
2.42.0

