Return-Path: <SRS0=p7su=5L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70102C43331
	for <linux-serial@archiver.kernel.org>; Thu, 26 Mar 2020 12:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA4F2070A
	for <linux-serial@archiver.kernel.org>; Thu, 26 Mar 2020 12:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgCZMVb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:21:31 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:48467 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZMVa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Mar 2020 08:21:30 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 7195C100AF9A3;
        Thu, 26 Mar 2020 13:21:28 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E40CA60EB710;
        Thu, 26 Mar 2020 13:21:27 +0100 (CET)
X-Mailbox-Line: From 96f915a678051faf9e14c9391a069339e6c62bd6 Mon Sep 17 00:00:00 2001
Message-Id: <96f915a678051faf9e14c9391a069339e6c62bd6.1585224378.git.lukas@wunner.de>
In-Reply-To: <b420d9c3b1c8b0492db55cc6f62076bfd9968b2f.1585224378.git.lukas@wunner.de>
References: <b420d9c3b1c8b0492db55cc6f62076bfd9968b2f.1585224378.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 26 Mar 2020 13:20:16 +0100
Subject: [PATCH tty-next 2/2] serial: 8250: Optimize irq enable after console
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

Commit 6194c38fc20d ("serial: 8250: Support console on software emulated
rs485 ports") amended serial8250_console_write() with rs485 support, but
positioned the invocation of ->rs485_stop_tx() after re-enablement of
interrupts.  The irq handler and ->console_write() are serialized with
the port spinlock, so no problem there, but due to the rs485 delay, the
irq handler may unnecessarily spin for a while.  Avoid that by moving
->rs485_stop_tx() before re-enablement of interrupts, which also mirrors
the order at the beginning of serial8250_console_write().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a1d3aef3c406..f77bf820b7a3 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3268,7 +3268,6 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	serial_port_out(port, UART_IER, ier);
 
 	if (em485) {
 		mdelay(port->rs485.delay_rts_after_send);
@@ -3276,6 +3275,8 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 			up->rs485_stop_tx(up);
 	}
 
+	serial_port_out(port, UART_IER, ier);
+
 	/*
 	 *	The receive handling will happen properly because the
 	 *	receive ready bit will still be set; it is not cleared
-- 
2.25.0

