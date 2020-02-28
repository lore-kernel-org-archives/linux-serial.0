Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C969C3F2D2
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F126246AE
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB1NlJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:41:09 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:33327 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1NlI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 08:41:08 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id CB6681002B644;
        Fri, 28 Feb 2020 14:41:06 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 7884961249E8;
        Fri, 28 Feb 2020 14:41:06 +0100 (CET)
X-Mailbox-Line: From ff833721bc372d38678f289eb2a44dbf016d5203 Mon Sep 17 00:00:00 2001
Message-Id: <ff833721bc372d38678f289eb2a44dbf016d5203.1582895077.git.lukas@wunner.de>
In-Reply-To: <cover.1582895077.git.lukas@wunner.de>
References: <cover.1582895077.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 28 Feb 2020 14:31:04 +0100
Subject: [PATCH 4/8] serial: 8250: Sanitize rs485 config harder
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Heiko Schocher <hs@denx.de>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Amend the generic ->rs485_config() callback to sanitize RTS polarity and
zero-fill the padding (in addition to the existing sanitization of the
RTS delays).

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_port.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 73244806d701..d281aea061d6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -676,10 +676,18 @@ int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
+	/* pick sane settings if the user hasn't */
+	if (!!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
+	    !!(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
+		rs485->flags |= SER_RS485_RTS_ON_SEND;
+		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
+	}
+
 	/* clamp the delays to [0, 100ms] */
 	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
 	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
 
+	memset(rs485->padding, 0, sizeof(rs485->padding));
 	port->rs485 = *rs485;
 
 	/*
-- 
2.24.0

