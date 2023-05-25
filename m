Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B5FC77B7E
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 21:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjEYVCg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 17:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEYVCf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 17:02:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B6BE7C
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 14:02:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2I5o-0000DH-Pg; Thu, 25 May 2023 23:01:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2I5o-002oFO-1K; Thu, 25 May 2023 23:01:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2I5n-007xfq-7h; Thu, 25 May 2023 23:01:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] serial: Switch i2c drivers back to use .probe()
Date:   Thu, 25 May 2023 23:01:47 +0200
Message-Id: <20230525210147.734737-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=787/XD4gNxYarU33pyqDAsFeyMdLutDqihW/mgmF7PA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkb8y3uz/GQwEXYwitRZMkb2uGTn+24scbpWXlB U1jzsQ3WCqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG/MtwAKCRCPgPtYfRL+ TpgLCACcLHd5R8QReT9ANMol0w0IJ1JGY8LlhmQrm4oO10QjJG0wkHYHiTGVCVIO842eSC9mhws fhefQtWvySKgln5HsxP5svK8YY3W/w/Khsk/DjaXU+XKtRn9NtWBRlp//mKsrs07TgvqjeMt18W ljpLXXn4nuqLawKAhqBB6ZeLJS3fwsUkKRgYPFVvGKV7rA4HYGlmZyh/jIPsR0rCzmLLSdWxQIi EMV5Yfzgtlqzmj0cUuCdxCV6m+GDfRAAirZ6Y+jRZ4YEwpHaAwG88RdusNEm4LJlUu1m2zfTslk +yQe0Dx2365O4TpgKQVZKHaA1LQ0LX2mz5kmhn+bqO8RDfxk
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
convert back to (the new) .probe() to be able to eventually drop
.probe_new() from struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/max310x.c   | 2 +-
 drivers/tty/serial/sc16is7xx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 9fee722058f4..997e39449766 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1636,7 +1636,7 @@ static struct i2c_driver max310x_i2c_driver = {
 		.of_match_table	= max310x_dt_ids,
 		.pm		= &max310x_pm_ops,
 	},
-	.probe_new	= max310x_i2c_probe,
+	.probe		= max310x_i2c_probe,
 	.remove		= max310x_i2c_remove,
 };
 #endif
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index abad091baeea..2e7e7c409cf2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1709,7 +1709,7 @@ static struct i2c_driver sc16is7xx_i2c_uart_driver = {
 		.name		= SC16IS7XX_NAME,
 		.of_match_table	= sc16is7xx_dt_ids,
 	},
-	.probe_new	= sc16is7xx_i2c_probe,
+	.probe		= sc16is7xx_i2c_probe,
 	.remove		= sc16is7xx_i2c_remove,
 	.id_table	= sc16is7xx_i2c_id_table,
 };

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

