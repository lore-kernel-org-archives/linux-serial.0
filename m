Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C46C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjKJRx2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKJRwp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:45 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0BD3AE21
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-0006QY-Nm; Fri, 10 Nov 2023 16:30:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT5-0083L4-Kk; Fri, 10 Nov 2023 16:30:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT5-00GnxL-Bh; Fri, 10 Nov 2023 16:30:47 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Ogness <john.ogness@linutronix.de>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: [PATCH 38/52] serial: sh-sci: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:06 +0100
Message-ID: <20231110152927.70601-39-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1958; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=P4CxsfLuAYcUUJTW3Uww1c2csld4J0Z5EKJII3L8zME=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQ/nw75+Pr+qJTe+DYPN83Azf4+Eieud/18+U5tl39VN nusYm8nozELAyMXg6yYIot945pMqyq5yM61/y7DDGJlApnCwMUpABNhaeVgaPb4E2VtFXHrguLK krYrKS81BM60Mbz//2rp3seRX274KdZVrMss8rB4piIl9PztV9H0f1cuKOznW3hJofQyo4HA/92 6MtJqG15fL+ZfKvHwrXdgZo8DO5OA7vTXXCbHj33kSeDNW1O8LeGG8qrcnYnHOhmV63c1qKyeYS sa8tXPmYGl6uZT9VIzKUH+xBmP9B4vrl7N2LH86SuV3X9V3924G835RzFEr8U15Ou/4v9/xD2Kr iZeEDB88Hvfyxx1Q2Oz5cf4PhZ53py0SVwq28a40czmi2ar7seigrd5PjPlstaX5DdcySiTerr2 1rr9U4+/02ZiyOVfLNsz4VDMgeYHc+r4Sm0PSN9iDxEBAA==
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
 drivers/tty/serial/sh-sci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 84ab434c94ba..745023001510 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3190,7 +3190,7 @@ static struct uart_driver sci_uart_driver = {
 	.cons		= SCI_CONSOLE,
 };
 
-static int sci_remove(struct platform_device *dev)
+static void sci_remove(struct platform_device *dev)
 {
 	struct sci_port *port = platform_get_drvdata(dev);
 	unsigned int type = port->port.type;	/* uart_remove_... clears it */
@@ -3204,8 +3204,6 @@ static int sci_remove(struct platform_device *dev)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);
-
-	return 0;
 }
 
 
@@ -3470,7 +3468,7 @@ static SIMPLE_DEV_PM_OPS(sci_dev_pm_ops, sci_suspend, sci_resume);
 
 static struct platform_driver sci_driver = {
 	.probe		= sci_probe,
-	.remove		= sci_remove,
+	.remove_new	= sci_remove,
 	.driver		= {
 		.name	= "sh-sci",
 		.pm	= &sci_dev_pm_ops,
-- 
2.42.0

