Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879A2C3F2D2
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673CF246AE
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB1NoT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:44:19 -0500
Received: from mailout1.hostsharing.net ([83.223.95.204]:59771 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgB1NoS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 08:44:18 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 3AC5D1003DBE8;
        Fri, 28 Feb 2020 14:44:16 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 07A9161249E8;
        Fri, 28 Feb 2020 14:44:16 +0100 (CET)
X-Mailbox-Line: From dd86460e20a8f979b7272a0bde73640312b902b1 Mon Sep 17 00:00:00 2001
Message-Id: <dd86460e20a8f979b7272a0bde73640312b902b1.1582895077.git.lukas@wunner.de>
In-Reply-To: <cover.1582895077.git.lukas@wunner.de>
References: <cover.1582895077.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 28 Feb 2020 14:31:07 +0100
Subject: [PATCH 7/8] serial: 8250_bcm2835aux: Support rs485 software emulation
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

Amend 8250_bcm2835aux.c to support rs485 as introduced for 8250_omap.c
by commit e490c9144cfa ("tty: Add software emulated RS485 support for
8250").

The bcm2835aux differs from omap chips by inverting the meaning of RTS
in the MCR register:  If the bit is clear, RTS is high.  With omap, it's
apparently the other way round.

Moreover, omap achieves half-duplex mode by disabling the UART_IER_RDI
interrupt and clearing the RX FIFO when TX stops.  This approach doesn't
work on bcm2835aux because the UART_LSR_DR bit is set even when
UART_IER_RDI is disabled.  Consequently, serial8250_handle_irq() invokes
serial8250_rx_chars() to empty the FIFO and characters are received even
though the user requested half-duplex.  Solve by disabling the receiver
using the non-standard CNTL register.

Cache that register in the driver's private data for performance.  Set
the private data pointer before calling serial8250_register_8250_port()
to prevent a null pointer deref in case one of the rs485 callbacks is
invoked immediately after port registration.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 62 ++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 5cc03bf24f85..12d03e678295 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -6,6 +6,10 @@
  *
  * Based on 8250_lpc18xx.c:
  * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * The bcm2835aux is capable of RTS auto flow-control, but this driver doesn't
+ * take advantage of it yet.  When adding support, be sure not to enable it
+ * simultaneously to rs485.
  */
 
 #include <linux/clk.h>
@@ -16,16 +20,64 @@
 
 #include "8250.h"
 
+#define BCM2835_AUX_UART_CNTL		8
+#define BCM2835_AUX_UART_CNTL_RXEN	0x01 /* Receiver enable */
+#define BCM2835_AUX_UART_CNTL_TXEN	0x02 /* Transmitter enable */
+#define BCM2835_AUX_UART_CNTL_AUTORTS	0x04 /* RTS set by RX fill level */
+#define BCM2835_AUX_UART_CNTL_AUTOCTS	0x08 /* CTS stops transmitter */
+#define BCM2835_AUX_UART_CNTL_RTS3	0x00 /* RTS set until 3 chars left */
+#define BCM2835_AUX_UART_CNTL_RTS2	0x10 /* RTS set until 2 chars left */
+#define BCM2835_AUX_UART_CNTL_RTS1	0x20 /* RTS set until 1 chars left */
+#define BCM2835_AUX_UART_CNTL_RTS4	0x30 /* RTS set until 4 chars left */
+#define BCM2835_AUX_UART_CNTL_RTSINV	0x40 /* Invert auto RTS polarity */
+#define BCM2835_AUX_UART_CNTL_CTSINV	0x80 /* Invert auto CTS polarity */
+
 /**
  * struct bcm2835aux_data - driver private data of BCM2835 auxiliary UART
  * @clk: clock producer of the port's uartclk
  * @line: index of the port's serial8250_ports[] entry
+ * @cntl: cached copy of CNTL register
  */
 struct bcm2835aux_data {
 	struct clk *clk;
 	int line;
+	u32 cntl;
 };
 
+static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
+{
+	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
+		struct bcm2835aux_data *data = dev_get_drvdata(up->port.dev);
+
+		data->cntl &= ~BCM2835_AUX_UART_CNTL_RXEN;
+		serial_out(up, BCM2835_AUX_UART_CNTL, data->cntl);
+	}
+
+	/*
+	 * On the bcm2835aux, the MCR register contains no other
+	 * flags besides RTS.  So no need for a read-modify-write.
+	 */
+	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
+		serial8250_out_MCR(up, 0);
+	else
+		serial8250_out_MCR(up, UART_MCR_RTS);
+}
+
+static void bcm2835aux_rs485_stop_tx(struct uart_8250_port *up)
+{
+	if (up->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		serial8250_out_MCR(up, 0);
+	else
+		serial8250_out_MCR(up, UART_MCR_RTS);
+
+	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
+		struct bcm2835aux_data *data = dev_get_drvdata(up->port.dev);
+
+		data->cntl |= BCM2835_AUX_UART_CNTL_RXEN;
+		serial_out(up, BCM2835_AUX_UART_CNTL, data->cntl);
+	}
+}
+
 static int bcm2835aux_serial_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port up = { };
@@ -47,6 +99,14 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	up.port.fifosize = 8;
 	up.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE |
 			UPF_SKIP_TEST | UPF_IOREMAP;
+	up.port.rs485_config = serial8250_em485_config;
+	up.rs485_start_tx = bcm2835aux_rs485_start_tx;
+	up.rs485_stop_tx = bcm2835aux_rs485_stop_tx;
+
+	/* initialize cached copy with power-on reset value */
+	data->cntl = BCM2835_AUX_UART_CNTL_RXEN | BCM2835_AUX_UART_CNTL_TXEN;
+
+	platform_set_drvdata(pdev, data);
 
 	/* get the clock - this also enables the HW */
 	data->clk = devm_clk_get(&pdev->dev, NULL);
@@ -102,8 +162,6 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	}
 	data->line = ret;
 
-	platform_set_drvdata(pdev, data);
-
 	return 0;
 
 dis_clk:
-- 
2.24.0

