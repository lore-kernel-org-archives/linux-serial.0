Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665C3C3F2D2
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E24246AE
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgB1NnS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:43:18 -0500
Received: from mailout1.hostsharing.net ([83.223.95.204]:35669 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgB1NnS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 08:43:18 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id BCDAF1003DBE8;
        Fri, 28 Feb 2020 14:43:15 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 82AE561249E8;
        Fri, 28 Feb 2020 14:43:15 +0100 (CET)
X-Mailbox-Line: From 5ac0464ae4414708e723a1e0d52b0c1b2bd41b9b Mon Sep 17 00:00:00 2001
Message-Id: <5ac0464ae4414708e723a1e0d52b0c1b2bd41b9b.1582895077.git.lukas@wunner.de>
In-Reply-To: <cover.1582895077.git.lukas@wunner.de>
References: <cover.1582895077.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 28 Feb 2020 14:31:06 +0100
Subject: [PATCH 6/8] serial: 8250: Generalize rs485 software emulation
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
So far the only drivers taking advantage of it are 8250_omap.c and
8250_of.c.

We're about to make use of the feature in 8250_bcm2835aux.c as well.
The bcm2835aux differs from omap chips by inverting the meaning of RTS
in the MCR register.  Moreover, omap achieves half-duplex mode by
disabling the RX interrupt and clearing the RX FIFO when TX stops.
The bcm2835aux requires disabling the receiver instead.

Support these behavioral differences by generalizing the rs485 emulation:
Introduce ->rs485_start_tx() and ->rs485_stop_tx() callbacks in struct
uart_8250_port, provide generic implementations containing the existing
code and use them as callbacks in 8250_omap.c and 8250_of.c.

start_tx_rs485() is idempotent in that it recognizes whether RTS is
already asserted.  Achieve the same by introducing a tx_stopped flag in
struct uart_8250_em485.  This may even perform a little better on arches
where memory access is faster than mmio access.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250.h      |  2 +
 drivers/tty/serial/8250/8250_core.c |  2 +
 drivers/tty/serial/8250/8250_of.c   |  7 ++-
 drivers/tty/serial/8250/8250_omap.c |  2 +
 drivers/tty/serial/8250/8250_port.c | 82 +++++++++++++++++++----------
 include/linux/serial_8250.h         |  3 ++
 6 files changed, 67 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index e83b66e0f593..0df02c055107 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -157,6 +157,8 @@ void serial8250_rpm_get_tx(struct uart_8250_port *p);
 void serial8250_rpm_put_tx(struct uart_8250_port *p);
 
 int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485);
+void serial8250_em485_start_tx(struct uart_8250_port *p);
+void serial8250_em485_stop_tx(struct uart_8250_port *p);
 void serial8250_em485_destroy(struct uart_8250_port *p);
 
 /* MCR <-> TIOCM conversion */
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9a1d09fbb836..f6eb00406ddf 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1007,6 +1007,8 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.unthrottle	= up->port.unthrottle;
 		uart->port.rs485_config	= up->port.rs485_config;
 		uart->port.rs485	= up->port.rs485;
+		uart->rs485_start_tx	= up->rs485_start_tx;
+		uart->rs485_stop_tx	= up->rs485_stop_tx;
 		uart->dma		= up->dma;
 
 		/* Take tx_loadsz from fifosize if it wasn't set separately */
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 4a68a8785caa..65e9045dafe6 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -29,11 +29,12 @@ struct of_serial_info {
  * Fill a struct uart_port for a given device node
  */
 static int of_platform_serial_setup(struct platform_device *ofdev,
-			int type, struct uart_port *port,
+			int type, struct uart_8250_port *up,
 			struct of_serial_info *info)
 {
 	struct resource resource;
 	struct device_node *np = ofdev->dev.of_node;
+	struct uart_port *port = &up->port;
 	u32 clk, spd, prop;
 	int ret, irq;
 
@@ -155,6 +156,8 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	port->dev = &ofdev->dev;
 	port->rs485_config = serial8250_em485_config;
+	up->rs485_start_tx = serial8250_em485_start_tx;
+	up->rs485_stop_tx = serial8250_em485_stop_tx;
 
 	switch (type) {
 	case PORT_RT2880:
@@ -201,7 +204,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 		return -ENOMEM;
 
 	memset(&port8250, 0, sizeof(port8250));
-	ret = of_platform_serial_setup(ofdev, port_type, &port8250.port, info);
+	ret = of_platform_serial_setup(ofdev, port_type, &port8250, info);
 	if (ret)
 		goto err_free;
 
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index fff70cb25046..dd69226ce918 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1158,6 +1158,8 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.throttle = omap_8250_throttle;
 	up.port.unthrottle = omap_8250_unthrottle;
 	up.port.rs485_config = serial8250_em485_config;
+	up.rs485_start_tx = serial8250_em485_start_tx;
+	up.rs485_stop_tx = serial8250_em485_stop_tx;
 	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
 	ret = of_alias_get_id(np, "serial");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1a71625a0d43..8e8cca690bf9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -557,17 +557,6 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
 	}
 }
 
-static inline void serial8250_em485_rts_after_send(struct uart_8250_port *p)
-{
-	unsigned char mcr = serial8250_in_MCR(p);
-
-	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
-		mcr |= UART_MCR_RTS;
-	else
-		mcr &= ~UART_MCR_RTS;
-	serial8250_out_MCR(p, mcr);
-}
-
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
 
@@ -632,7 +621,9 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 	p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
 	p->em485->port = p;
 	p->em485->active_timer = NULL;
-	serial8250_em485_rts_after_send(p);
+	p->em485->tx_stopped = true;
+
+	p->rs485_stop_tx(p);
 
 	return 0;
 }
@@ -1439,9 +1430,21 @@ static void serial8250_stop_rx(struct uart_port *port)
 	serial8250_rpm_put(up);
 }
 
-static void __do_stop_tx_rs485(struct uart_8250_port *p)
+/**
+ * serial8250_em485_stop_tx() - generic ->rs485_stop_tx() callback
+ * @up: uart 8250 port
+ *
+ * Generic callback usable by 8250 uart drivers to stop rs485 transmission.
+ */
+void serial8250_em485_stop_tx(struct uart_8250_port *p)
 {
-	serial8250_em485_rts_after_send(p);
+	unsigned char mcr = serial8250_in_MCR(p);
+
+	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		mcr |= UART_MCR_RTS;
+	else
+		mcr &= ~UART_MCR_RTS;
+	serial8250_out_MCR(p, mcr);
 
 	/*
 	 * Empty the RX FIFO, we are not interested in anything
@@ -1455,6 +1458,8 @@ static void __do_stop_tx_rs485(struct uart_8250_port *p)
 		serial_port_out(&p->port, UART_IER, p->ier);
 	}
 }
+EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
+
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 {
 	struct uart_8250_em485 *em485;
@@ -1467,8 +1472,9 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 	serial8250_rpm_get(p);
 	spin_lock_irqsave(&p->port.lock, flags);
 	if (em485->active_timer == &em485->stop_tx_timer) {
-		__do_stop_tx_rs485(p);
+		p->rs485_stop_tx(p);
 		em485->active_timer = NULL;
+		em485->tx_stopped = true;
 	}
 	spin_unlock_irqrestore(&p->port.lock, flags);
 	serial8250_rpm_put(p);
@@ -1489,7 +1495,7 @@ static void __stop_tx_rs485(struct uart_8250_port *p)
 	struct uart_8250_em485 *em485 = p->em485;
 
 	/*
-	 * __do_stop_tx_rs485 is going to set RTS according to config
+	 * rs485_stop_tx() is going to set RTS according to config
 	 * AND flush RX FIFO if required.
 	 */
 	if (p->port.rs485.delay_rts_after_send > 0) {
@@ -1497,8 +1503,9 @@ static void __stop_tx_rs485(struct uart_8250_port *p)
 		start_hrtimer_ms(&em485->stop_tx_timer,
 				   p->port.rs485.delay_rts_after_send);
 	} else {
-		__do_stop_tx_rs485(p);
+		p->rs485_stop_tx(p);
 		em485->active_timer = NULL;
+		em485->tx_stopped = true;
 	}
 }
 
@@ -1572,25 +1579,42 @@ static inline void __start_tx(struct uart_port *port)
 	}
 }
 
-static inline void start_tx_rs485(struct uart_port *port)
+/**
+ * serial8250_em485_start_tx() - generic ->rs485_start_tx() callback
+ * @up: uart 8250 port
+ *
+ * Generic callback usable by 8250 uart drivers to start rs485 transmission.
+ * Assumes that setting the RTS bit in the MCR register means RTS is high.
+ * (Some chips use inverse semantics.)  Further assumes that reception is
+ * stoppable by disabling the UART_IER_RDI interrupt.  (Some chips set the
+ * UART_LSR_DR bit even when UART_IER_RDI is disabled, foiling this approach.)
+ */
+void serial8250_em485_start_tx(struct uart_8250_port *up)
 {
-	struct uart_8250_port *up = up_to_u8250p(port);
-	struct uart_8250_em485 *em485 = up->em485;
-	unsigned char mcr;
+	unsigned char mcr = serial8250_in_MCR(up);
 
 	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
 		serial8250_stop_rx(&up->port);
 
+	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
+		mcr |= UART_MCR_RTS;
+	else
+		mcr &= ~UART_MCR_RTS;
+	serial8250_out_MCR(up, mcr);
+}
+EXPORT_SYMBOL_GPL(serial8250_em485_start_tx);
+
+static inline void start_tx_rs485(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct uart_8250_em485 *em485 = up->em485;
+
 	em485->active_timer = NULL;
 
-	mcr = serial8250_in_MCR(up);
-	if (!!(up->port.rs485.flags & SER_RS485_RTS_ON_SEND) !=
-	    !!(mcr & UART_MCR_RTS)) {
-		if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
-			mcr |= UART_MCR_RTS;
-		else
-			mcr &= ~UART_MCR_RTS;
-		serial8250_out_MCR(up, mcr);
+	if (em485->tx_stopped) {
+		em485->tx_stopped = false;
+
+		up->rs485_start_tx(up);
 
 		if (up->port.rs485.delay_rts_before_send > 0) {
 			em485->active_timer = &em485->start_tx_timer;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 6a8e8c48c882..0901c2aa366c 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -81,6 +81,7 @@ struct uart_8250_em485 {
 	struct hrtimer		stop_tx_timer;  /* "rs485 stop tx" timer */
 	struct hrtimer		*active_timer;  /* pointer to active timer */
 	struct uart_8250_port	*port;          /* for hrtimer callbacks */
+	unsigned int		tx_stopped:1;	/* tx is currently stopped */
 };
 
 /*
@@ -132,6 +133,8 @@ struct uart_8250_port {
 	void			(*dl_write)(struct uart_8250_port *, int);
 
 	struct uart_8250_em485 *em485;
+	void			(*rs485_start_tx)(struct uart_8250_port *);
+	void			(*rs485_stop_tx)(struct uart_8250_port *);
 
 	/* Serial port overrun backoff */
 	struct delayed_work overrun_backoff;
-- 
2.24.0

