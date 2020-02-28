Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59EEC3F2D2
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87F6246AE
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1Nk0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:40:26 -0500
Received: from mailout1.hostsharing.net ([83.223.95.204]:33265 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1Nk0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 08:40:26 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id D17BF101303AB;
        Fri, 28 Feb 2020 14:40:23 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 9654361249E8;
        Fri, 28 Feb 2020 14:40:23 +0100 (CET)
X-Mailbox-Line: From fcef63642dc4eae41ae7842d23747b2bf5d40285 Mon Sep 17 00:00:00 2001
Message-Id: <fcef63642dc4eae41ae7842d23747b2bf5d40285.1582895077.git.lukas@wunner.de>
In-Reply-To: <cover.1582895077.git.lukas@wunner.de>
References: <cover.1582895077.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 28 Feb 2020 14:31:03 +0100
Subject: [PATCH 3/8] serial: 8250: Deduplicate ->rs485_config() callback
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
introduced support to use RTS as an rs485 Transmit Enable signal.
Drivers opt in to the feature by calling serial8250_em485_init() from
their ->rs485_config() callback.

So far there are two drivers doing that, 8250_omap.c and 8250_of.c.
Both use an identical callback.  We're about to add a third user of that
callback, therefore deduplicate it and move it to 8250_port.c.

Drivers now opt in to rs485 software emulation by assigning the generic
serial8250_rs485_config() callback introduced herein to their
.rs485_config struct member.  This change allows unexporting
serial8250_em485_init() and declaring it static.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
Cc: Heiko Schocher <hs@denx.de>
---
 drivers/tty/serial/8250/8250.h      |  2 +-
 drivers/tty/serial/8250/8250_of.c   | 32 +---------------------
 drivers/tty/serial/8250/8250_omap.c | 32 +---------------------
 drivers/tty/serial/8250/8250_port.c | 41 +++++++++++++++++++++++++++--
 4 files changed, 42 insertions(+), 65 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 33ad9d6de532..e83b66e0f593 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -156,7 +156,7 @@ void serial8250_rpm_put(struct uart_8250_port *p);
 void serial8250_rpm_get_tx(struct uart_8250_port *p);
 void serial8250_rpm_put_tx(struct uart_8250_port *p);
 
-int serial8250_em485_init(struct uart_8250_port *p);
+int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485);
 void serial8250_em485_destroy(struct uart_8250_port *p);
 
 /* MCR <-> TIOCM conversion */
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index ad92f451f3b9..4a68a8785caa 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -25,36 +25,6 @@ struct of_serial_info {
 	int line;
 };
 
-static int of_8250_rs485_config(struct uart_port *port,
-				  struct serial_rs485 *rs485)
-{
-	struct uart_8250_port *up = up_to_u8250p(port);
-
-	/* Clamp the delays to [0, 100ms] */
-	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
-	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
-
-	port->rs485 = *rs485;
-
-	/*
-	 * Both serial8250_em485_init and serial8250_em485_destroy
-	 * are idempotent
-	 */
-	if (rs485->flags & SER_RS485_ENABLED) {
-		int ret = serial8250_em485_init(up);
-
-		if (ret) {
-			rs485->flags &= ~SER_RS485_ENABLED;
-			port->rs485.flags &= ~SER_RS485_ENABLED;
-		}
-		return ret;
-	}
-
-	serial8250_em485_destroy(up);
-
-	return 0;
-}
-
 /*
  * Fill a struct uart_port for a given device node
  */
@@ -184,7 +154,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->flags |= UPF_SKIP_TEST;
 
 	port->dev = &ofdev->dev;
-	port->rs485_config = of_8250_rs485_config;
+	port->rs485_config = serial8250_em485_config;
 
 	switch (type) {
 	case PORT_RT2880:
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 6f343ca08440..fff70cb25046 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -714,36 +714,6 @@ static void omap_8250_throttle(struct uart_port *port)
 	pm_runtime_put_autosuspend(port->dev);
 }
 
-static int omap_8250_rs485_config(struct uart_port *port,
-				  struct serial_rs485 *rs485)
-{
-	struct uart_8250_port *up = up_to_u8250p(port);
-
-	/* Clamp the delays to [0, 100ms] */
-	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
-	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
-
-	port->rs485 = *rs485;
-
-	/*
-	 * Both serial8250_em485_init and serial8250_em485_destroy
-	 * are idempotent
-	 */
-	if (rs485->flags & SER_RS485_ENABLED) {
-		int ret = serial8250_em485_init(up);
-
-		if (ret) {
-			rs485->flags &= ~SER_RS485_ENABLED;
-			port->rs485.flags &= ~SER_RS485_ENABLED;
-		}
-		return ret;
-	}
-
-	serial8250_em485_destroy(up);
-
-	return 0;
-}
-
 static void omap_8250_unthrottle(struct uart_port *port)
 {
 	struct omap8250_priv *priv = port->private_data;
@@ -1187,7 +1157,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.shutdown = omap_8250_shutdown;
 	up.port.throttle = omap_8250_throttle;
 	up.port.unthrottle = omap_8250_unthrottle;
-	up.port.rs485_config = omap_8250_rs485_config;
+	up.port.rs485_config = serial8250_em485_config;
 	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
 	ret = of_alias_get_id(np, "serial");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 40efcea8c6e7..73244806d701 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -615,7 +615,7 @@ EXPORT_SYMBOL_GPL(serial8250_rpm_put);
  *
  *	Return 0 - success, -errno - otherwise
  */
-int serial8250_em485_init(struct uart_8250_port *p)
+static int serial8250_em485_init(struct uart_8250_port *p)
 {
 	if (p->em485)
 		return 0;
@@ -636,7 +636,6 @@ int serial8250_em485_init(struct uart_8250_port *p)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(serial8250_em485_init);
 
 /**
  *	serial8250_em485_destroy() - put uart_8250_port into normal state
@@ -664,6 +663,44 @@ void serial8250_em485_destroy(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_destroy);
 
+/**
+ * serial8250_em485_config() - generic ->rs485_config() callback
+ * @port: uart port
+ * @rs485: rs485 settings
+ *
+ * Generic callback usable by 8250 uart drivers to activate rs485 settings
+ * if the uart is incapable of driving RTS as a Transmit Enable signal in
+ * hardware, relying on software emulation instead.
+ */
+int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	/* clamp the delays to [0, 100ms] */
+	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
+	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
+
+	port->rs485 = *rs485;
+
+	/*
+	 * Both serial8250_em485_init() and serial8250_em485_destroy()
+	 * are idempotent.
+	 */
+	if (rs485->flags & SER_RS485_ENABLED) {
+		int ret = serial8250_em485_init(up);
+
+		if (ret) {
+			rs485->flags &= ~SER_RS485_ENABLED;
+			port->rs485.flags &= ~SER_RS485_ENABLED;
+		}
+		return ret;
+	}
+
+	serial8250_em485_destroy(up);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(serial8250_em485_config);
+
 /*
  * These two wrappers ensure that enable_runtime_pm_tx() can be called more than
  * once and disable_runtime_pm_tx() will still disable RPM because the fifo is
-- 
2.24.0

