Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF8CC3F2D2
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF54246AE
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgB1NmM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:42:12 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:36799 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1NmM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 08:42:12 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 08:42:11 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id EF6311008D087;
        Fri, 28 Feb 2020 14:42:09 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id AC59861249E8;
        Fri, 28 Feb 2020 14:42:09 +0100 (CET)
X-Mailbox-Line: From bca638405550eaf92f0c6060b553b687f35885e0 Mon Sep 17 00:00:00 2001
Message-Id: <bca638405550eaf92f0c6060b553b687f35885e0.1582895077.git.lukas@wunner.de>
In-Reply-To: <cover.1582895077.git.lukas@wunner.de>
References: <cover.1582895077.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 28 Feb 2020 14:31:05 +0100
Subject: [PATCH 5/8] serial: 8250: Deduplicate rs485 active_timer assignment
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

When rs485 transmission over an 8250 port stops, __stop_tx() assigns
active_timer = NULL before calling __stop_tx_rs485().

That function in turn either assigns active_timer = stop_tx_timer and
rearms the timer (in case a delay_rts_after_send needs to be observed)
or directly calls __do_stop_tx_rs485().

Move the assignment active_timer = NULL to __stop_tx_rs485() into the
branch which directly calls __do_stop_tx_rs485(), thereby avoiding a
duplicate assignment and simplifying the code.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_port.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d281aea061d6..1a71625a0d43 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1498,6 +1498,7 @@ static void __stop_tx_rs485(struct uart_8250_port *p)
 				   p->port.rs485.delay_rts_after_send);
 	} else {
 		__do_stop_tx_rs485(p);
+		em485->active_timer = NULL;
 	}
 }
 
@@ -1522,8 +1523,6 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
 			return;
 
-		em485->active_timer = NULL;
-
 		__stop_tx_rs485(p);
 	}
 	__do_stop_tx(p);
-- 
2.24.0

