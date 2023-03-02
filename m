Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F416FC6FA8E
	for <linux-serial@archiver.kernel.org>; Thu,  2 Mar 2023 11:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCBL4D (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Mar 2023 06:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCBL4C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Mar 2023 06:56:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C256F32501
        for <linux-serial@vger.kernel.org>; Thu,  2 Mar 2023 03:56:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXhXP-0007ms-0U; Thu, 02 Mar 2023 12:55:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXhXO-001Jkz-Aj; Thu, 02 Mar 2023 12:55:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXhXN-001Xki-BD; Thu, 02 Mar 2023 12:55:53 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: imx: Drop a few unneeded casts
Date:   Thu,  2 Mar 2023 12:54:17 +0100
Message-Id: <20230302115417.1860210-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2045; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sxjzZGEcQoxBqKIHeS4o+02NY0JeWVk+ygLIqzyqKeE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAI5jnEjCH5EmmfoKPECD7JWdWshpYo/GI+IMt WLmoaKtivaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZACOYwAKCRDB/BR4rcrs CdKsB/9s5HFO6IoAnysmunYqNIKHYHJOIzltcHY7jyn8PMKR722KIi1EUkVryKOECX6m7lCqAFo jSCRBq0Cvl2eqT3kkZWQLaFHF6qPseyVVZ7Wfc3m43ZxkeV+JIl+fLa2+pei0gRK2fLN8m2oEfG KxNfkvt//4z4fD0Ny58nbi551f5eyKFHMFLrs22K9X42Bk+4L1PLI3iuE7XoxEOko9NwXN4/EXB qWAuZHx61kwm/quSmTi+O3beRVawQnOI/JqKl5MD8C8tPzlawFLjKZ1KHdBHHz2tMF2WkNzOfIL /OzOu45Fjk/eNvXwsQsi0KFJDekrIoL6SpDvJkDR+sdEt+sN
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

This introduces code changes.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
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
-- 
2.39.1

