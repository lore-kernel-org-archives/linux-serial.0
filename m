Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1524EECAAA1
	for <linux-serial@archiver.kernel.org>; Sun, 11 Sep 2022 09:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIKJSG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 11 Sep 2022 05:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIKJSF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 11 Sep 2022 05:18:05 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Sep 2022 02:18:04 PDT
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3853BC4F
        for <linux-serial@vger.kernel.org>; Sun, 11 Sep 2022 02:18:03 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id D9F7810189B5A;
        Sun, 11 Sep 2022 11:12:21 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id AA79E603E021;
        Sun, 11 Sep 2022 11:12:21 +0200 (CEST)
X-Mailbox-Line: From 5b36af26e57553f084334666e7d24c7fd131a01e Mon Sep 17 00:00:00 2001
Message-Id: <5b36af26e57553f084334666e7d24c7fd131a01e.1662887231.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 11 Sep 2022 11:12:15 +0200
Subject: [PATCH] serial: ar933x: Deassert Transmit Enable on ->rs485_config()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Golle <daniel@makrotopia.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ar933x_uart driver neglects to deassert Transmit Enable when
->rs485_config() is invoked.  Fix it.

Fixes: 9be1064fe524 ("serial: ar933x_uart: add RS485 support")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.7+
Cc: Daniel Golle <daniel@makrotopia.org>
---
 drivers/tty/serial/ar933x_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 0a4020dba165..925484a42c82 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -583,6 +583,13 @@ static const struct uart_ops ar933x_uart_ops = {
 static int ar933x_config_rs485(struct uart_port *port, struct ktermios *termios,
 				struct serial_rs485 *rs485conf)
 {
+	struct ar933x_uart_port *up =
+			container_of(port, struct ar933x_uart_port, port);
+
+	if (port->rs485.flags & SER_RS485_ENABLED)
+		gpiod_set_value(up->rts_gpiod,
+			!!(rs485conf->flags & SER_RS485_RTS_AFTER_SEND));
+
 	return 0;
 }
 
-- 
2.36.1

