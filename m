Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD0EC6FA8E
	for <linux-serial@archiver.kernel.org>; Thu,  2 Mar 2023 11:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCBLsb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Mar 2023 06:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBLsa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Mar 2023 06:48:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434A47ED1
        for <linux-serial@vger.kernel.org>; Thu,  2 Mar 2023 03:48:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXhQ0-0006B8-BX; Thu, 02 Mar 2023 12:48:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXhPz-001JkQ-7S; Thu, 02 Mar 2023 12:48:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXhPy-001Xhl-4n; Thu, 02 Mar 2023 12:48:14 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: imx: Simplify imx_uart_type
Date:   Thu,  2 Mar 2023 12:48:10 +0100
Message-Id: <20230302114810.1859500-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qnYVdNecTjL9Ir+/QCH0AF6NN4dqFcO1sYt7UzFAxqo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAIz3Vq+ATK1RJnPwEaT2Dh4wiapsq/1UaECj2 3fhrkUDLfqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZACM9wAKCRDB/BR4rcrs CZ+oB/49bi+xqyCuVY1mHkZUz4U6aKXcdEHnzUXprfXoEopLeMr1WEJAa7KW+vK1kZk4uZvbeja JHNi+y+Ifb/bFRQBLe7opuRwvlC0i74ktR1VoMouoZxaXlZbhQaX5mjdpq5UxtKk+2ee4dFxx5J qN5Rf2prj5U90CMA4Ux0W4mi+qP4fi0fd1vrRJdnip7fKsjo5YagdC9o12t4sj/wbqtvXBb7vcO yMRQ+WhNT3Y3R5I3ccKu7vD4gAjIMwW5gW3QZHy2Vbr9orXJGtAC665MazTJKDpeytrDYtoxHXT d3i1GdkDn75ToUm08LjeHH70VXSs1tfKUSPI9bfCb6+Add/+
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
 drivers/tty/serial/imx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 523f296d5747..8d5933e83248 100644
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
-- 
2.39.1

