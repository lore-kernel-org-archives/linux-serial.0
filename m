Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58CEC4167B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbjKJS3a (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345469AbjKJS13 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:27:29 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4853AE2C
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-0006aB-Ui; Fri, 10 Nov 2023 16:30:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-0083M1-Df; Fri, 10 Nov 2023 16:30:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-00GnyF-4Q; Fri, 10 Nov 2023 16:30:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Julien Malik <julien.malik@unseenlabs.fr>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 52/52] serial: xilinx_uartps: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:20 +0100
Message-ID: <20231110152927.70601-53-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oDO1V0mfGEnMGCQITHferGZjE/RW7aj4K1QhMWCqHCI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyYcKVoA2rfh/sNGXuFSpPqKNvbjEd6pDvDn jkNwDSLPJqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MmAAKCRCPgPtYfRL+ TlPiB/40emV+cbNrIKsaUbFCYN7kPO7XFtI+Ui73Q/WeOxR39fIAeTSL5Ldpt2W1KU5e7MTDmk+ IhjQV+9A0a5Afo1Itxvr4CBB2oerjnp5PxhW4ytKxdL0zQHcz8dJFNNWXorYxGaRm0XJgNU0Xjg nplx5qJXu6AkMjDp3F5x9K54yYcndKeFVoJXXrUYTonF3AC83O7XlLGs8HPdKW4koObJjn6dwdc Cw2QRzH8EPyg3GS83WRr9B/r7kFOA9PwcSwt+VQT7UC6qoEhjgGXd1pZAfgKJalwKmNwn2FhIms dpA+8BHCV5OB61vp7GzOVGgu1GX6boMWT2PJCFnxCl0Wb74L
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
 drivers/tty/serial/xilinx_uartps.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 66a45a634158..6decf2b13340 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1666,7 +1666,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
  *
  * Return: 0 on success, negative errno otherwise
  */
-static int cdns_uart_remove(struct platform_device *pdev)
+static void cdns_uart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct cdns_uart *cdns_uart_data = port->private_data;
@@ -1692,12 +1692,11 @@ static int cdns_uart_remove(struct platform_device *pdev)
 
 	if (!--instances)
 		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
-	return 0;
 }
 
 static struct platform_driver cdns_uart_platform_driver = {
 	.probe   = cdns_uart_probe,
-	.remove  = cdns_uart_remove,
+	.remove_new = cdns_uart_remove,
 	.driver  = {
 		.name = CDNS_UART_NAME,
 		.of_match_table = cdns_uart_of_match,
-- 
2.42.0

