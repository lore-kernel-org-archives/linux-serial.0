Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D0C3F2CD
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7D824699
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1Nii (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:38:38 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:36527 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1Nih (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 08:38:37 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 8A2FC101E69E8;
        Fri, 28 Feb 2020 14:38:35 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 2307C61249E4;
        Fri, 28 Feb 2020 14:38:35 +0100 (CET)
X-Mailbox-Line: From 5908ea89b7f9da54872d6634b606d83db032297a Mon Sep 17 00:00:00 2001
Message-Id: <5908ea89b7f9da54872d6634b606d83db032297a.1582895077.git.lukas@wunner.de>
In-Reply-To: <cover.1582895077.git.lukas@wunner.de>
References: <cover.1582895077.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 28 Feb 2020 14:31:02 +0100
Subject: [PATCH 2/8] serial: 8250: Support rs485 devicetree properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Retrieve rs485 devicetree properties on registration of 8250 ports in
case they are attached to an rs485 transceiver.

If the property "linux,rs485-enabled-at-boot-time" is present, invoke
the ->rs485_config() callback to immediately deassert RTS, thereby
ceasing control of the bus.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 4 +++-
 drivers/tty/serial/8250/8250_port.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index f2a33c9082a6..9a1d09fbb836 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1013,8 +1013,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (uart->port.fifosize && !uart->tx_loadsz)
 			uart->tx_loadsz = uart->port.fifosize;
 
-		if (up->port.dev)
+		if (up->port.dev) {
 			uart->port.dev = up->port.dev;
+			uart_get_rs485_mode(uart->port.dev, &uart->port.rs485);
+		}
 
 		if (up->port.flags & UPF_FIXED_TYPE)
 			uart->port.type = up->port.type;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a8f4cedde4dc..40efcea8c6e7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2989,6 +2989,9 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 	if (flags & UART_CONFIG_TYPE)
 		autoconfig(up);
 
+	if (port->rs485.flags & SER_RS485_ENABLED)
+		port->rs485_config(port, &port->rs485);
+
 	/* if access method is AU, it is a 16550 with a quirk */
 	if (port->type == PORT_16550A && port->iotype == UPIO_AU)
 		up->bugs |= UART_BUG_NOMSR;
-- 
2.24.0

