Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A3FC05031
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjKJR4O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbjKJRzp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:45 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F3C3AE17
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-0006R3-Sg; Fri, 10 Nov 2023 16:30:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-0083LC-1G; Fri, 10 Nov 2023 16:30:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT5-00GnxS-OV; Fri, 10 Nov 2023 16:30:47 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Richard GENOUD <richard.genoud@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <frank.li@vivo.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 40/52] serial: sprd: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:08 +0100
Message-ID: <20231110152927.70601-41-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JKeg3njv1DfC1+cz/7hRN2iur/eGLM4Vi8Ef2GKE6IQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyL0bfbABJKlEWBffhmS/GsrsCD7PWLSpoP+ 2/x6Hl4Bk6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MiwAKCRCPgPtYfRL+ Tk/kB/9MhWlQInRgSTy4mV780YSeLxjOwaXT4wbqNQ0Ywbhxtntf4hrimqydArdxckZ6BxgPqpk grK/YYZpieQSwWOQwKSz4h5wfOq5LpGZdXsBzW4n3HpTIt7ZGNG6v2UOI6BTknolmCUse6giyhQ 4Hjo30Esr/e7Y/LWEl/hlE5R/9Gfsq5o3fV4WFej23gA6V/MobJybiNB+4HfsIikUX/eLLljFvs MrpC9DLiQhOfUd8j+77B21ziD0cEEuPF+aDoIQgmagcCqpSS4LOsnB4Q3HoAgvKEQFVaXbma5Jv WPN4idGLygNc+bMYp9/cCRAQpNvbL9VaTLEPlXP2uG2yCbSn
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
 drivers/tty/serial/sprd_serial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index f257525f9299..15f14fa593da 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1076,7 +1076,7 @@ static struct uart_driver sprd_uart_driver = {
 	.cons = SPRD_CONSOLE,
 };
 
-static int sprd_remove(struct platform_device *dev)
+static void sprd_remove(struct platform_device *dev)
 {
 	struct sprd_uart_port *sup = platform_get_drvdata(dev);
 
@@ -1089,8 +1089,6 @@ static int sprd_remove(struct platform_device *dev)
 
 	if (!sprd_ports_num)
 		uart_unregister_driver(&sprd_uart_driver);
-
-	return 0;
 }
 
 static bool sprd_uart_is_console(struct uart_port *uport)
@@ -1257,7 +1255,7 @@ MODULE_DEVICE_TABLE(of, serial_ids);
 
 static struct platform_driver sprd_platform_driver = {
 	.probe		= sprd_probe,
-	.remove		= sprd_remove,
+	.remove_new	= sprd_remove,
 	.driver		= {
 		.name	= "sprd_serial",
 		.of_match_table = serial_ids,
-- 
2.42.0

