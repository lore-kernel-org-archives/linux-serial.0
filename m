Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3001C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 12 Dec 2022 21:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiLLVVE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiLLVVE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Dec 2022 16:21:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807771177
        for <linux-serial@vger.kernel.org>; Mon, 12 Dec 2022 13:21:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qEK-0006Ab-3e; Mon, 12 Dec 2022 22:20:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qEH-0046Xn-Nu; Mon, 12 Dec 2022 22:20:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qEH-004bDz-Lh; Mon, 12 Dec 2022 22:20:53 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vineet Gupta <vgupta@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-serial@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] serial: arc_uart: Drop empty platform remove function
Date:   Mon, 12 Dec 2022 22:20:37 +0100
Message-Id: <20221212212037.3773636-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=1ZFqVjickndN0gqkcb1KHAfmGOf0XDUNbl2udK5Prrg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjl5siEDIfLwerQaKD6mTdBeccjjnlYBgq8kNA2nmO +iufywSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY5ebIgAKCRDB/BR4rcrsCemXB/ 0Sm0090b+aitBLel1JUaVMR8XyTYJa+igBBPJQI/gNOfpFwHjP9Mrv3bT4jLYqPxqVGgvYYzcWFNUP E95ci8fy8jYEZalzn15/eBxzubYvJ9RqCRfKdHPaqAHEkLBsLXArlTsYoNLNmOhi9kr6/h2vLwTwPy VdAwIL4sVZjhupbRWZwzo5N0RS78OJBELeANvHI2eZUyXIrHFb1ejBNuFjPk0MgydjYP3H1CPaT7qQ eHr5/sL4SckeIvK2Y6BhQmQUaAm+B0itAzp1nlGWix8ptAH3VmWaLQw+/z07UljD3ju8HyiXaDkluR Qa5VTKFCYk9VjT2LdDeilrNZWnHYh+
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A remove callback just returning 0 is equivalent to no remove callback
at all. So drop the useless function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/arc_uart.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 2a65ea2660e1..f1b6034addda 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -632,12 +632,6 @@ static int arc_serial_probe(struct platform_device *pdev)
 	return uart_add_one_port(&arc_uart_driver, &arc_uart_ports[dev_id].port);
 }
 
-static int arc_serial_remove(struct platform_device *pdev)
-{
-	/* This will never be called */
-	return 0;
-}
-
 static const struct of_device_id arc_uart_dt_ids[] = {
 	{ .compatible = "snps,arc-uart" },
 	{ /* Sentinel */ }
@@ -646,7 +640,6 @@ MODULE_DEVICE_TABLE(of, arc_uart_dt_ids);
 
 static struct platform_driver arc_platform_driver = {
 	.probe = arc_serial_probe,
-	.remove = arc_serial_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table  = arc_uart_dt_ids,
-- 
2.38.1

