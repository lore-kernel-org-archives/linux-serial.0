Return-Path: <SRS0=h5S4=2B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190F9C43603
	for <linux-serial@archiver.kernel.org>; Wed, 11 Dec 2019 16:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1DE206A5
	for <linux-serial@archiver.kernel.org>; Wed, 11 Dec 2019 16:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfLKQj2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:39:28 -0500
Received: from mail.sysgo.com ([176.9.12.79]:56120 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbfLKQj2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Dec 2019 11:39:28 -0500
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2019 11:39:27 EST
From:   David Engraf <david.engraf@sysgo.com>
To:     richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] tty/serial: atmel: fix out of range clock divider handling
Date:   Wed, 11 Dec 2019 17:29:54 +0100
Message-Id: <20191211162954.8393-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use MCK_DIV8 when the clock divider is > 65535. Unfortunately the mode
register was already written thus the clock selection is ignored.

Fix by writing the mode register after calculating the baudrate.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 drivers/tty/serial/atmel_serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a8dc8af83f39..9983e2fabbac 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2270,9 +2270,6 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		mode |= ATMEL_US_USMODE_NORMAL;
 	}
 
-	/* set the mode, clock divisor, parity, stop bits and data size */
-	atmel_uart_writel(port, ATMEL_US_MR, mode);
-
 	/*
 	 * when switching the mode, set the RTS line state according to the
 	 * new mode, otherwise keep the former state
@@ -2315,6 +2312,9 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 	quot = cd | fp << ATMEL_US_FP_OFFSET;
 
+	/* set the mode, clock divisor, parity, stop bits and data size */
+	atmel_uart_writel(port, ATMEL_US_MR, mode);
+
 	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
 		atmel_uart_writel(port, ATMEL_US_BRGR, quot);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
-- 
2.17.1

