Return-Path: <SRS0=8UUK=5M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B5CC43331
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 14:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FACD206F2
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 14:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0Oiu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:38:50 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:45107 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgC0Oiu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Mar 2020 10:38:50 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id D019F100376D4;
        Fri, 27 Mar 2020 15:38:48 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 85AA561CED4A;
        Fri, 27 Mar 2020 15:38:48 +0100 (CET)
X-Mailbox-Line: From 9dd67f33c90d23f7fafa3b81b1e812ddabf9ca24 Mon Sep 17 00:00:00 2001
Message-Id: <9dd67f33c90d23f7fafa3b81b1e812ddabf9ca24.1585319447.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 27 Mar 2020 15:38:15 +0100
Subject: [PATCH v2 tty-next 1/2] serial: 8250: Fix rs485 delay after console
 write
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Heiko Schocher <hs@denx.de>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Stefan Wahren <wahrenst@gmx.net>,
        Martin Sperl <kernel@martin.sperl.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Due to a silly copy-paste mistake, commit 7f9803072ff6 ("serial: 8250:
Support console on software emulated rs485 ports") erroneously pauses
for the duration of delay_rts_before_send after writing to the console,
instead of delay_rts_after_send.  Mea culpa.

Fixes: 7f9803072ff6 ("serial: 8250: Support console on software emulated rs485 ports")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
v2:
 fix hash of referenced commit

 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2f973280c34a..a1d3aef3c406 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3271,7 +3271,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	serial_port_out(port, UART_IER, ier);
 
 	if (em485) {
-		mdelay(port->rs485.delay_rts_before_send);
+		mdelay(port->rs485.delay_rts_after_send);
 		if (em485->tx_stopped)
 			up->rs485_stop_tx(up);
 	}
-- 
2.25.0

