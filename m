Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930D9C05021
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjKJSHP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjKJSFi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:38 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555213AE25
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-0006Qj-6M; Fri, 10 Nov 2023 16:30:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT5-0083L8-R0; Fri, 10 Nov 2023 16:30:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT5-00GnxP-Hd; Fri, 10 Nov 2023 16:30:47 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Nick Hu <nick.hu@sifive.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Samuel Holland <samuel.holland@sifive.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <frank.li@vivo.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 39/52] serial: sifive: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:07 +0100
Message-ID: <20231110152927.70601-40-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LLOyW1hbM0/SN58Bgrwns/zlLR/bVWIngKf4jnPWkd0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyJRJnUsGPDONa/lKdc3LcXHVgixiKyNcrZf Ql98Gr9N66JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MiQAKCRCPgPtYfRL+ TtI5B/4jgW6OlsjFTMzan1QKVqk5oRoSVSC44upo/WbaxMGlfGN/boqM1VGFtDAFLsjZ3tXPa+E L0CvM1rrNsgOkjPdS/dtjtVLS5ZHDXfXn4kOlADqDTWrSkP3kT5Xgph78LFVtnAq6dl/LKkFefY sRsdi2Zh5llDfiODVzPLWwiqEPrK8GhmBwlJO08eRFNzMCWkwjHfKXRxpnL8csaB+8G3ub0bLUn +O+H8o6AZBu5dhvTgfmE0Rjd3IHHahBIOsizkso7yTGTEwFZSoTIFWmMRzB/JwOoN9WacIXb2lo 4NvBq/PRAnuzI/fENiGvcyYJEj84GuL1WFkffkO3X1Zvhvdf
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
 drivers/tty/serial/sifive.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index b296e57a9dee..3541235a3ab6 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -1007,7 +1007,7 @@ static int sifive_serial_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int sifive_serial_remove(struct platform_device *dev)
+static void sifive_serial_remove(struct platform_device *dev)
 {
 	struct sifive_serial_port *ssp = platform_get_drvdata(dev);
 
@@ -1015,8 +1015,6 @@ static int sifive_serial_remove(struct platform_device *dev)
 	uart_remove_one_port(&sifive_serial_uart_driver, &ssp->port);
 	free_irq(ssp->port.irq, ssp);
 	clk_notifier_unregister(ssp->clk, &ssp->clk_notifier);
-
-	return 0;
 }
 
 static int sifive_serial_suspend(struct device *dev)
@@ -1045,7 +1043,7 @@ MODULE_DEVICE_TABLE(of, sifive_serial_of_match);
 
 static struct platform_driver sifive_serial_platform_driver = {
 	.probe		= sifive_serial_probe,
-	.remove		= sifive_serial_remove,
+	.remove_new	= sifive_serial_remove,
 	.driver		= {
 		.name	= SIFIVE_SERIAL_NAME,
 		.pm = pm_sleep_ptr(&sifive_uart_pm_ops),
-- 
2.42.0

