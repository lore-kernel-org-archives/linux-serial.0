Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80868C2BA83
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 14:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6BA22314
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 14:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgBNOON (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:14:13 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42691 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgBNOOM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 09:14:12 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7E071C0003;
        Fri, 14 Feb 2020 14:14:10 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] tty: serial: efm32: fix spelling mistake "reserverd" -> "reserved"
Date:   Fri, 14 Feb 2020 15:14:06 +0100
Message-Id: <20200214141406.20792-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix a spelling mistake in a comment.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/tty/serial/efm32-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index 2ac87128d7fd..f12f29cf4f31 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -200,7 +200,7 @@ static void efm32_uart_rx_chars(struct efm32_uart_port *efm_port)
 		/*
 		 * This is a reserved bit and I only saw it read as 0. But to be
 		 * sure not to be confused too much by new devices adhere to the
-		 * warning in the reference manual that reserverd bits might
+		 * warning in the reference manual that reserved bits might
 		 * read as 1 in the future.
 		 */
 		rxdata &= ~SW_UARTn_RXDATAX_BERR;
-- 
2.24.1

