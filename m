Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A78C6FA83
	for <linux-serial@archiver.kernel.org>; Sun, 11 Sep 2022 09:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIKJ0B (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 11 Sep 2022 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIKJ0A (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 11 Sep 2022 05:26:00 -0400
X-Greylist: delayed 2195 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Sep 2022 02:25:59 PDT
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA724970
        for <linux-serial@vger.kernel.org>; Sun, 11 Sep 2022 02:25:59 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id C7B18101EE86E;
        Sun, 11 Sep 2022 11:25:57 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 83754603E021;
        Sun, 11 Sep 2022 11:25:57 +0200 (CEST)
X-Mailbox-Line: From f191dcca0d8ea03598c463fc0d3fba8941ff2275 Mon Sep 17 00:00:00 2001
Message-Id: <f191dcca0d8ea03598c463fc0d3fba8941ff2275.1662888075.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 11 Sep 2022 11:24:24 +0200
Subject: [PATCH] serial: omap: Disallow RS-485 if rts-gpio is not specified
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The serial-omap driver requires an rts-gpio for RS-485 to work.
Historically it has allowed enabling RS-485 even if no rts-gpio was
specified in the device tree.

That doesn't make any sense, so disable RS-485 on probe if rts-gpio is
missing and disallow user space from enabling it.

Three NULL pointer checks for up->rts_gpiod can be dropped as a result,
simplifying the driver slightly.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/omap-serial.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index c87d85b901a7..9c4fd0985f3d 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -300,8 +300,7 @@ static void serial_omap_stop_tx(struct uart_port *port)
 			serial_out(up, UART_OMAP_SCR, up->scr);
 			res = (port->rs485.flags & SER_RS485_RTS_AFTER_SEND) ?
 				1 : 0;
-			if (up->rts_gpiod &&
-			    gpiod_get_value(up->rts_gpiod) != res) {
+			if (gpiod_get_value(up->rts_gpiod) != res) {
 				if (port->rs485.delay_rts_after_send > 0)
 					mdelay(
 					port->rs485.delay_rts_after_send);
@@ -397,7 +396,7 @@ static void serial_omap_start_tx(struct uart_port *port)
 
 		/* if rts not already enabled */
 		res = (port->rs485.flags & SER_RS485_RTS_ON_SEND) ? 1 : 0;
-		if (up->rts_gpiod && gpiod_get_value(up->rts_gpiod) != res) {
+		if (gpiod_get_value(up->rts_gpiod) != res) {
 			gpiod_set_value(up->rts_gpiod, res);
 			if (port->rs485.delay_rts_before_send > 0)
 				mdelay(port->rs485.delay_rts_before_send);
@@ -1336,13 +1335,11 @@ serial_omap_config_rs485(struct uart_port *port, struct ktermios *termios,
 	up->ier = 0;
 	serial_out(up, UART_IER, 0);
 
-	if (up->rts_gpiod) {
-		/* enable / disable rts */
-		val = (rs485->flags & SER_RS485_ENABLED) ?
-			SER_RS485_RTS_AFTER_SEND : SER_RS485_RTS_ON_SEND;
-		val = (rs485->flags & val) ? 1 : 0;
-		gpiod_set_value(up->rts_gpiod, val);
-	}
+	/* enable / disable rts */
+	val = (rs485->flags & SER_RS485_ENABLED) ?
+	      SER_RS485_RTS_AFTER_SEND : SER_RS485_RTS_ON_SEND;
+	val = (rs485->flags & val) ? 1 : 0;
+	gpiod_set_value(up->rts_gpiod, val);
 
 	/* Enable interrupts */
 	up->ier = mode;
@@ -1547,11 +1544,13 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 		ret = PTR_ERR(up->rts_gpiod);
 	        if (ret == -EPROBE_DEFER)
 			return ret;
-		/*
-		 * FIXME: the code historically ignored any other error than
-		 * -EPROBE_DEFER and just went on without GPIO.
-		 */
+
 		up->rts_gpiod = NULL;
+		up->port.rs485_supported = (const struct serial_rs485) { };
+		if (rs485conf->flags & SER_RS485_ENABLED) {
+			dev_err(dev, "disabling RS-485 (rts-gpio missing in device tree)\n");
+			memset(rs485conf, 0, sizeof(*rs485conf));
+		}
 	} else {
 		gpiod_set_consumer_name(up->rts_gpiod, "omap-serial");
 	}
-- 
2.36.1

