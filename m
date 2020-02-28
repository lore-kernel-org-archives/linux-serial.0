Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC1FC3F2CD
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65FA246AE
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgB1Nn2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:43:28 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:50607 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgB1Nn2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 08:43:28 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id CF59910189AC1;
        Fri, 28 Feb 2020 14:36:51 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 8222161249E4;
        Fri, 28 Feb 2020 14:36:51 +0100 (CET)
X-Mailbox-Line: From b1ce34ca9bc4d7bdc6e9852fcf30b1f4e37c8a80 Mon Sep 17 00:00:00 2001
Message-Id: <b1ce34ca9bc4d7bdc6e9852fcf30b1f4e37c8a80.1582895077.git.lukas@wunner.de>
In-Reply-To: <cover.1582895077.git.lukas@wunner.de>
References: <cover.1582895077.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 28 Feb 2020 14:31:01 +0100
Subject: [PATCH 1/8] serial: 8250: Don't touch RTS modem control while in
 rs485 mode
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

serial8250_do_set_mctrl() currently allows modifying the RTS modem
control line even when RTS is used as an rs485 Transmit Enable signal.
It is thus possible for user space to interfere with rs485 communication
by invoking a TIOCMSET ioctl().

Ignore such change requests and retain the current RTS polarity when in
rs485 mode.  Note that serial8250_set_mctrl() is always called with
port->lock held, so there's no risk that RTS is changed concurrently.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_port.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f398f162a1fd..a8f4cedde4dc 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1924,6 +1924,13 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned char mcr;
 
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		if (serial8250_in_MCR(up) & UART_MCR_RTS)
+			mctrl |= TIOCM_RTS;
+		else
+			mctrl &= ~TIOCM_RTS;
+	}
+
 	mcr = serial8250_TIOCM_to_MCR(mctrl);
 
 	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
-- 
2.24.0

