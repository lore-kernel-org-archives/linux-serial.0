Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F48C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbjKJRpH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345958AbjKJRoJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:44:09 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383E3AE24
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-0006Mi-WB; Fri, 10 Nov 2023 16:30:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT4-0083KW-1K; Fri, 10 Nov 2023 16:30:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT3-00Gnwk-OS; Fri, 10 Nov 2023 16:30:45 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Yuan Can <yuancan@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 30/52] serial: pic32: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:58 +0100
Message-ID: <20231110152927.70601-31-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zFqZ5X+Z76QaJzf3Ir3amkDiGbBIytw+hnlT6s8H4A8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkx81C2g44KNsx8WEFVyJU3GUqTYJrm0QpzTc 7laBkVtXraJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MfAAKCRCPgPtYfRL+ TpF2B/9ivAsvDuCPmwkIvFR7RZ4xHELrszKs0hh7y2iiqoaEcla97Gvi1HhO5uTQ3FY9uPQYpbA 3HcnGRbNKpuEEeph6i7z3I86PqFZ8lp23MwLd6c3GncobKxHRxCndkbZqajMr/po9cZ3f9s7Ybp 7x7cpc9kd7rBYDAQUlSgS1fOcKpUnyKaZlAiW7Gb0oSfo2A1NpnKT4AyEP3wgnuUwai611cMSjW Mi+fHBC1qBn/PW0qakAB/zcH1ZrRbSth4R19o9/SqmmBbMyO6lW+znfnNbausDOJv/OcLASRshY hsbCPwl8pkAMu4XQu6R/gk7OhGrUt9kaFzjrQInmQ98yPxxq
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
 drivers/tty/serial/pic32_uart.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 3a95bf5d55d3..bbb46e6e98a2 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -938,7 +938,7 @@ static int pic32_uart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pic32_uart_remove(struct platform_device *pdev)
+static void pic32_uart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct pic32_sport *sport = to_pic32_sport(port);
@@ -947,9 +947,6 @@ static int pic32_uart_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sport->clk);
 	platform_set_drvdata(pdev, NULL);
 	pic32_sports[sport->idx] = NULL;
-
-	/* automatic unroll of sport and gpios */
-	return 0;
 }
 
 static const struct of_device_id pic32_serial_dt_ids[] = {
@@ -960,7 +957,7 @@ MODULE_DEVICE_TABLE(of, pic32_serial_dt_ids);
 
 static struct platform_driver pic32_uart_platform_driver = {
 	.probe		= pic32_uart_probe,
-	.remove		= pic32_uart_remove,
+	.remove_new	= pic32_uart_remove,
 	.driver		= {
 		.name	= PIC32_DEV_NAME,
 		.of_match_table	= of_match_ptr(pic32_serial_dt_ids),
-- 
2.42.0

