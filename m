Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3009C43331
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D571420714
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgCYXOp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:14:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40176 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbgCYXOn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 19:14:43 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jHFEJ-0007ug-8g; Thu, 26 Mar 2020 00:14:35 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v2 6/7] serial: 8250: Support separate rs485 rx-enable GPIO
Date:   Thu, 26 Mar 2020 00:14:21 +0100
Message-Id: <20200325231422.1502366-7-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200325231422.1502366-1-heiko@sntech.de>
References: <20200325231422.1502366-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The RE signal is used to control the duplex mode of transmissions,
aka receiving data while sending in full duplex mode, while stopping
receiving data in half-duplex mode.

On a number of boards the !RE signal is tied to ground so reception
is always enabled except if the UART allows disabling the receiver.
This can be taken advantage of to implement half-duplex mode - like
done on 8250_bcm2835aux.

Another solution is to tie !RE to RTS always forcing half-duplex mode.

And finally there is the option to control the RE signal separately,
like done here by introducing a new rs485-specifc gpio that can be
set depending on the RX_DURING_TX setting in the common em485 callbacks.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250_port.c | 11 ++++++++++-
 drivers/tty/serial/serial_core.c    | 12 ++++++++++++
 include/linux/serial_core.h         |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 41ad7db6a31e..6a34204126d9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1445,6 +1445,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 void serial8250_em485_stop_tx(struct uart_8250_port *p)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
+	struct uart_port *port = &p->port;
 
 	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
 		mcr |= UART_MCR_RTS;
@@ -1458,6 +1459,9 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
 	 * Enable previously disabled RX interrupts.
 	 */
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
+		if (port->rs485_re_gpio)
+			gpiod_set_value(port->rs485_re_gpio, 1);
+
 		serial8250_clear_and_reinit_fifos(p);
 
 		p->ier |= UART_IER_RLSI | UART_IER_RDI;
@@ -1614,9 +1618,14 @@ static inline void __start_tx(struct uart_port *port)
 void serial8250_em485_start_tx(struct uart_8250_port *up)
 {
 	unsigned char mcr = serial8250_in_MCR(up);
+	struct uart_port *port = &up->port;
+
+	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
+		if (port->rs485_re_gpio)
+			gpiod_set_value(port->rs485_re_gpio, 0);
 
-	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
 		serial8250_stop_rx(&up->port);
+	}
 
 	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
 		mcr |= UART_MCR_RTS;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 77702b6371e3..5dc9ef31a6fa 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3356,6 +3356,18 @@ int uart_get_rs485_mode(struct uart_port *port)
 			rs485conf->flags |= SER_RS485_TERMINATE_BUS;
 	}
 
+	port->rs485_re_gpio = devm_gpiod_get(dev, "rs485-rx-enable",
+					       GPIOD_FLAGS_BIT_DIR_OUT);
+	if (IS_ERR(port->rs485_re_gpio)) {
+		ret = PTR_ERR(port->rs485_re_gpio);
+		port->rs485_re_gpio = NULL;
+		if (ret != -ENOENT) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Cannot get rs485-rx-enable-gpios\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 9521e23b2144..4d8f51b1d9b2 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -252,6 +252,7 @@ struct uart_port {
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
+	struct gpio_desc	*rs485_re_gpio;		/* gpio RS485 receive enable */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };
-- 
2.24.1

