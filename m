Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF07C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345618AbjKJRpX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345963AbjKJRoJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:44:09 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3463AE26
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-00066e-J9; Fri, 10 Nov 2023 16:30:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSz-0083Iy-1k; Fri, 10 Nov 2023 16:30:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSy-00Gnv6-Oq; Fri, 10 Nov 2023 16:30:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jiamei Xie <jiamei.xie@arm.com>,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        delisun <delisun@pateo.com.cn>, Fabio Estevam <festevam@denx.de>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: [PATCH 06/52] serial: amba-pl011: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:34 +0100
Message-ID: <20231110152927.70601-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qIzmcIen7yGDlsOI2P9BNrRmie9HvCljuto2gnKfaaQ=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQ/n7gjr+bx8c1tDdvDuVuzY3LXkafJG22n7uq4c+HBz b7FAh/6OhmNWRgYuRhkxRRZ7BvXZFpVyUV2rv13GWYQKxPIFAYuTgGYyMR09r+STOelzio4z50X q5Ix93jKmSuhgeaezYGiUqrna1tnXjCOrlrI+LV/58OZmxz6SlUVlJebL1Zp2+rvl5qfL7l8k1I 4W4T2ycM6H+L5A4x+JQXIzexXvWp2ed76Cib3m0963H5bxa9xdnusLpGg/On/3jV5UqUFsp8L3N n5Yyt+dE/y+fLhZ6Z1k53sP8tOj/Oc//IcX67Vfi+7hk2c/WueD0tGg2EfqwavgpTS0nnsMiaPo hsKvRf/+cn5qahtS0aCrd3bcLfbqmbr4vd2br5RvTTVUvJFbdLK79mPK9XbVO38zjx5cMG8lFXY ffahrScX/nhw1pFF8MnSDZZ875ZHrtIQfC14bP6XkrRQAA==
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
 drivers/tty/serial/amba-pl011.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 61cc24cd90e4..374b4254e39b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2939,13 +2939,12 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	return pl011_register_port(uap);
 }
 
-static int sbsa_uart_remove(struct platform_device *pdev)
+static void sbsa_uart_remove(struct platform_device *pdev)
 {
 	struct uart_amba_port *uap = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&amba_reg, &uap->port);
 	pl011_unregister_port(uap);
-	return 0;
 }
 
 static const struct of_device_id sbsa_uart_of_match[] = {
@@ -2963,7 +2962,7 @@ MODULE_DEVICE_TABLE(acpi, sbsa_uart_acpi_match);
 
 static struct platform_driver arm_sbsa_uart_platform_driver = {
 	.probe		= sbsa_uart_probe,
-	.remove		= sbsa_uart_remove,
+	.remove_new	= sbsa_uart_remove,
 	.driver	= {
 		.name	= "sbsa-uart",
 		.pm	= &pl011_dev_pm_ops,
-- 
2.42.0

