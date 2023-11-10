Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE19C4167B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbjKJShf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjKJSfM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:35:12 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC73AE06
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-0006Rr-QF; Fri, 10 Nov 2023 16:30:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-0083LK-Eb; Fri, 10 Nov 2023 16:30:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-00Gnxb-5M; Fri, 10 Nov 2023 16:30:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 42/52] serial: stm32: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:10 +0100
Message-ID: <20231110152927.70601-43-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5htvZTKQYsaQF/DhEIeCVy7UN5DiM9l2sCrWpRoYQfo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyNMkrnreXIYPFUpcK6dCTty/YRFuIxEyLYi KKt+9Qo0t2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MjQAKCRCPgPtYfRL+ TpaDB/9ajzFZLbevKXFXkJVl2aBAi7ma/J5M61N6kPTnnjds1EZOFM0osLkMkktGOGh0nYacCP1 HP44UUb+CuK1ZHgLS3tyy4f8MSzrPaNpVSuxpAMibuTkz4ZPKmNS9gJtN0KyBsIw/ktBmFHF/W+ emSub0jHwpXehVdX2jWMyPvrYywaiOYHgc8HcB/dFGyWCBc13FZytIQKhTH9AYrjdhBKaLNgWtZ IJ1OM3902k4t9wvCJ9b+1O9qrpasOui/fuxcPhg6yoDylMiYtvLUWJ4XzovFLGqHcTZxtI2gQRr tvSxL2WiHZsVLuBV3H0B+lLsT8xfFdoGqPMyNF2kC9CbqxiT
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
 drivers/tty/serial/stm32-usart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 3048620315d6..9781c143def2 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1822,7 +1822,7 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_usart_serial_remove(struct platform_device *pdev)
+static void stm32_usart_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -1861,8 +1861,6 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 	}
 
 	stm32_usart_deinit_port(stm32_port);
-
-	return 0;
 }
 
 static void __maybe_unused stm32_usart_console_putchar(struct uart_port *port, unsigned char ch)
@@ -2146,7 +2144,7 @@ static const struct dev_pm_ops stm32_serial_pm_ops = {
 
 static struct platform_driver stm32_serial_driver = {
 	.probe		= stm32_usart_serial_probe,
-	.remove		= stm32_usart_serial_remove,
+	.remove_new	= stm32_usart_serial_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.pm	= &stm32_serial_pm_ops,
-- 
2.42.0

