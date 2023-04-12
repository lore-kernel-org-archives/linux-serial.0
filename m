Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FF0C7619A
	for <linux-serial@archiver.kernel.org>; Wed, 12 Apr 2023 16:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjDLQwG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Apr 2023 12:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjDLQv5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Apr 2023 12:51:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A099EF2
        for <linux-serial@vger.kernel.org>; Wed, 12 Apr 2023 09:51:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmdfs-0006cJ-A3; Wed, 12 Apr 2023 18:50:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmdfq-00AmSi-SS; Wed, 12 Apr 2023 18:50:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmdfp-00CesE-V4; Wed, 12 Apr 2023 18:50:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2] serial: imx: Drop a few unneeded casts
Date:   Wed, 12 Apr 2023 18:50:15 +0200
Message-Id: <20230412165015.3560730-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2292; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=1O5B2LZdekdFLQoAEl+DMclsrQFCSM13U7J4kktAGiE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkNuFGXKqtqiJN7fUwpioLeh6qIBwvLqDSr+kA4 HkQ0uCFxkKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZDbhRgAKCRCPgPtYfRL+ Tn7VB/9GJFV5CxIO6rpgPQnezem3L8Gb4HcCCGi2Pe1/RHuOL2BWCbGzxcu9csrBVjmuzlOdwXf t1vbrls8+AJBLfXupVTQ1+W70b3KOXl19VFV+q+w4yX0Yih1eJJ8deRlrQhrsyHbciRvR2rapdZ vNLJQI0aQijNW3WMCKQr5zHekGFDwt0Eb7KevoGwg+Q7FWmc1P88jFghB87RIEHbmR9J0aiNumT M8if/hSuW/eHfCK6EaBn/sd4QCUhvfCMeyfLZhLZdHFXv4F099fNi9pXhuVYzJmbdzCP6Rzbspl hFCqwmXQ/oBfeHedVQhb4Tz05EW010ikvupI8RG6OZa6cvBN
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no point in casting a struct uart_port to a struct imx_port
just to access the first member of the latter (a struct uart_port).

This introduces no code changes.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1:

 - Add Ilpo's Ack
 - Add a "no" to the commit log (Thanks to Ilpo for pointing that out).

 drivers/tty/serial/imx.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 523f296d5747..84bc0e768726 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1808,9 +1808,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 static const char *imx_uart_type(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
-
-	return sport->port.type == PORT_IMX ? "IMX" : NULL;
+	return port->type == PORT_IMX ? "IMX" : NULL;
 }
 
 /*
@@ -1818,10 +1816,8 @@ static const char *imx_uart_type(struct uart_port *port)
  */
 static void imx_uart_config_port(struct uart_port *port, int flags)
 {
-	struct imx_port *sport = (struct imx_port *)port;
-
 	if (flags & UART_CONFIG_TYPE)
-		sport->port.type = PORT_IMX;
+		port->type = PORT_IMX;
 }
 
 /*
@@ -1832,20 +1828,19 @@ static void imx_uart_config_port(struct uart_port *port, int flags)
 static int
 imx_uart_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	struct imx_port *sport = (struct imx_port *)port;
 	int ret = 0;
 
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_IMX)
 		ret = -EINVAL;
-	if (sport->port.irq != ser->irq)
+	if (port->irq != ser->irq)
 		ret = -EINVAL;
 	if (ser->io_type != UPIO_MEM)
 		ret = -EINVAL;
-	if (sport->port.uartclk / 16 != ser->baud_base)
+	if (port->uartclk / 16 != ser->baud_base)
 		ret = -EINVAL;
-	if (sport->port.mapbase != (unsigned long)ser->iomem_base)
+	if (port->mapbase != (unsigned long)ser->iomem_base)
 		ret = -EINVAL;
-	if (sport->port.iobase != ser->port)
+	if (port->iobase != ser->port)
 		ret = -EINVAL;
 	if (ser->hub6 != 0)
 		ret = -EINVAL;

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

