Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4149CC4167B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 19:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjKJTqM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 14:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbjKJTpy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 14:45:54 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E528D3A8A4
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-000674-Kf; Fri, 10 Nov 2023 16:30:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSz-0083J8-M3; Fri, 10 Nov 2023 16:30:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSz-00GnvO-D0; Fri, 10 Nov 2023 16:30:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        John Ogness <john.ogness@linutronix.de>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Yangtao Li <frank.li@vivo.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 09/52] serial: bcm63xx: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:37 +0100
Message-ID: <20231110152927.70601-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cO15aM//X7ULU3bdbFLv2UCPcCGjR1XLDbWHcubCt18=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQ/n6Q9RxvreAXa3+QGFx3f5ufXnh+j6y1+WPfmLs55b 3odLq/uZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAilUns/4MY2TXfi2kZG0zM 2mp1mGffkjTLvXoqsWLHUv6baMkbbNWJ15vp/OyPr43OUck/O+7N1t9aNMuhbmqO7b68Ck5/y6m 3BWZsqSho0eC51FLJrmexSLjtX9ODtxZLZbj+lXfqpNhPaK4U9Ou7a6JTaffC2S3+YyZHfcGk5J Va5akn29Ws1jusf30mvKmmulvdaIbipqWxQq/Tfu/iuZSRt7Ra80XMlEUWH08LKgS+nzRdK/hVd NlXdQaH9QJmC77ZC7yfpbW/dOnRv4KfBHn9tjx8/74+R+WjZvUp5dkTxd0vrrb//Mduw/vWA1sD LbZs+KaefVxPxf7iQ56E9b6pO1tWhfNuZtDo+T8/8ukXAA==
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
 drivers/tty/serial/bcm63xx_uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 4a08fd5ee61b..a3cefa153456 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -868,7 +868,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int bcm_uart_remove(struct platform_device *pdev)
+static void bcm_uart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port;
 
@@ -876,7 +876,6 @@ static int bcm_uart_remove(struct platform_device *pdev)
 	uart_remove_one_port(&bcm_uart_driver, port);
 	/* mark port as free */
 	ports[pdev->id].membase = NULL;
-	return 0;
 }
 
 static const struct of_device_id bcm63xx_of_match[] = {
@@ -890,7 +889,7 @@ MODULE_DEVICE_TABLE(of, bcm63xx_of_match);
  */
 static struct platform_driver bcm_uart_platform_driver = {
 	.probe	= bcm_uart_probe,
-	.remove	= bcm_uart_remove,
+	.remove_new = bcm_uart_remove,
 	.driver	= {
 		.name  = "bcm63xx_uart",
 		.of_match_table = bcm63xx_of_match,
-- 
2.42.0

