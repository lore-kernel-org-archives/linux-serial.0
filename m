Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9933BC77B7F
	for <linux-serial@archiver.kernel.org>; Fri, 12 May 2023 17:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbjELRi2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 May 2023 13:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbjELRi1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 May 2023 13:38:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7D01718
        for <linux-serial@vger.kernel.org>; Fri, 12 May 2023 10:38:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxWii-0004jy-SJ; Fri, 12 May 2023 19:38:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxWig-0031HH-Oq; Fri, 12 May 2023 19:38:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxWig-003nrx-2D; Fri, 12 May 2023 19:38:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 1/2] serial: stm32: Ignore return value of uart_remove_one_port() in .remove()
Date:   Fri, 12 May 2023 19:38:09 +0200
Message-Id: <20230512173810.131447-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512173810.131447-1-u.kleine-koenig@pengutronix.de>
References: <20230512173810.131447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1631; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2vlMXGGCVahNI3ka92R9UEaW26yVnbxKviGYxwDHwHI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkXnl8XOlqYTrlntQBtWRe0BgeL6TRM0AdNYGMU lOxq8sMDLaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZF55fAAKCRCPgPtYfRL+ TndZB/9l6fw/rsarQumOA/889xFG4Wnn4OSbNFhyCe0HTdP5eIsEBjCjAZev0Zm7DmRGFSLS3ZT hVL2eJUuplPzlzGLQW7FxVVK4m/cmURX3ciNYpfZLwUt5r2yiTvrdeLPRMDHvYTPEiXA5EFOa2G 19HdfD1FrYWecH9HSWy/E6rb/zHXhld/NO2QExehO3vPWIwV1YBOJC9qXp0zYMBPB1USUQp8vrX I7mBi5jYc2g6L9MpGxLhJqo1wMjcl28GrF6601f3q+YpWtKpSZLsNTUkL3M/vyWxAbqLpDGjUWB 16Js0R/8z5ZzLhn9NDDP92OLkCVw65uzRAMlDW9Gqmqqsx43
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Returning early from stm32_usart_serial_remove() results in a resource
leak as several cleanup functions are not called. The driver core ignores
the return value and there is no possibility to clean up later.

uart_remove_one_port() only returns non-zero if there is some
inconsistency (i.e. stm32_usart_driver.state[port->line].uart_port == NULL).
This should never happen, and even if it does it's a bad idea to exit
early in the remove callback without cleaning up.

This prepares changing the prototype of struct platform_driver::remove to
return void. See commit 5c5a7680e67b ("platform: Provide a remove callback
that returns no value") for further details about this quest.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/stm32-usart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 1e38fc9b10c1..e9e11a259621 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1755,13 +1755,10 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	int err;
 	u32 cr3;
 
 	pm_runtime_get_sync(&pdev->dev);
-	err = uart_remove_one_port(&stm32_usart_driver, port);
-	if (err)
-		return(err);
+	uart_remove_one_port(&stm32_usart_driver, port);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.39.2

