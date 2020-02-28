Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE89CC3F2CD
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F6F246A8
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB1NqL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:46:11 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:49307 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgB1NqK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 08:46:10 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id EE5AD1008CFF6;
        Fri, 28 Feb 2020 14:46:08 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id ACF8561249E8;
        Fri, 28 Feb 2020 14:46:08 +0100 (CET)
X-Mailbox-Line: From 65edffce4670a19e598015c03cbe46f1ffd93e43 Mon Sep 17 00:00:00 2001
Message-Id: <65edffce4670a19e598015c03cbe46f1ffd93e43.1582895077.git.lukas@wunner.de>
In-Reply-To: <cover.1582895077.git.lukas@wunner.de>
References: <cover.1582895077.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 28 Feb 2020 14:31:08 +0100
Subject: [PATCH 8/8] serial: 8250: Support console on software emulated rs485
 ports
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

Commit e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
introduced support to use RTS as an rs485 Transmit Enable signal if data
is transmitted through the tty layer.

Console messages bypass the tty layer and instead are emitted via
serial8250_console_write().  Amend that function to drive RTS as well,
allowing for a console on rs485 ports.

Note that serial8250_console_write() may be called concurrently to the
tty layer accessing the port.  The two protect their accesses with the
port lock, but serial8250_console_write() may find RTS still being
asserted by the tty layer, in which case it shouldn't be deasserted
after the console message has been printed.  Recognize such situations
by checking the em485->tx_stopped flag.

If a delay_rts_before_send or delay_rts_after_send has been specified,
serial8250_console_write() busy-waits for its duration.  Optimizations
for those wait times are conceivable:  E.g. if RTS is already asserted,
we could check whether em485->start_tx_timer is active and wait only
for the remaining expire time.  But this would require calling into
the hrtimer infrastructure, which involves acquiring locks and
potentially reprogramming timer hardware.  Such operations seem too
risky in the context of console printout, which needs to work even when
the kernel has crashed and emits a BUG splat.  So I've gone with a
simplistic solution which just always waits for the full delay.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_port.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8e8cca690bf9..0879bb8855cf 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3204,6 +3204,7 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 void serial8250_console_write(struct uart_8250_port *up, const char *s,
 			      unsigned int count)
 {
+	struct uart_8250_em485 *em485 = up->em485;
 	struct uart_port *port = &up->port;
 	unsigned long flags;
 	unsigned int ier;
@@ -3234,6 +3235,12 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		up->canary = 0;
 	}
 
+	if (em485) {
+		if (em485->tx_stopped)
+			up->rs485_start_tx(up);
+		mdelay(port->rs485.delay_rts_before_send);
+	}
+
 	uart_console_write(port, s, count, serial8250_console_putchar);
 
 	/*
@@ -3243,6 +3250,12 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	wait_for_xmitr(up, BOTH_EMPTY);
 	serial_port_out(port, UART_IER, ier);
 
+	if (em485) {
+		mdelay(port->rs485.delay_rts_before_send);
+		if (em485->tx_stopped)
+			up->rs485_stop_tx(up);
+	}
+
 	/*
 	 *	The receive handling will happen properly because the
 	 *	receive ready bit will still be set; it is not cleared
-- 
2.24.0

