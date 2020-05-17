Return-Path: <SRS0=Hdmd=67=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8761C433E1
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 21:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A206620820
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 21:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgEQV4i (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 May 2020 17:56:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45146 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbgEQV4h (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 May 2020 17:56:37 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaRGf-0002am-0i; Sun, 17 May 2020 23:56:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v3 3/5] serial: 8250: Support separate rs485 rx-enable GPIO
Date:   Sun, 17 May 2020 23:56:08 +0200
Message-Id: <20200517215610.2131618-4-heiko@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517215610.2131618-1-heiko@sntech.de>
References: <20200517215610.2131618-1-heiko@sntech.de>
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
like done here by introducing a new rs485-specific gpio that can be
set depending on the RX_DURING_TX setting in the common em485 callbacks.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250_port.c |  7 ++++++-
 drivers/tty/serial/serial_core.c    | 10 ++++++++++
 include/linux/serial_core.h         |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6975bd3ecb7d..9e8fec85d1a3 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1444,6 +1444,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 void serial8250_em485_stop_tx(struct uart_8250_port *p)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
+	struct uart_port *port = &p->port;
 
 	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
 		mcr |= UART_MCR_RTS;
@@ -1457,6 +1458,7 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
 	 * Enable previously disabled RX interrupts.
 	 */
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
+		gpiod_set_value(port->rs485_re_gpio, 1);
 		serial8250_clear_and_reinit_fifos(p);
 
 		p->ier |= UART_IER_RLSI | UART_IER_RDI;
@@ -1597,9 +1599,12 @@ static inline void __start_tx(struct uart_port *port)
 void serial8250_em485_start_tx(struct uart_8250_port *up)
 {
 	unsigned char mcr = serial8250_in_MCR(up);
+	struct uart_port *port = &up->port;
 
-	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
+	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
+		gpiod_set_value(port->rs485_re_gpio, 0);
 		serial8250_stop_rx(&up->port);
+	}
 
 	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
 		mcr |= UART_MCR_RTS;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 15ad8737b72b..c0d3ab32b49a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3149,6 +3149,16 @@ int uart_get_rs485_mode(struct uart_port *port)
 		return ret;
 	}
 
+	port->rs485_re_gpio = devm_gpiod_get_optional(dev, "rs485-rx-enable",
+						      GPIOD_OUT_HIGH);
+	if (IS_ERR(port->rs485_re_gpio)) {
+		ret = PTR_ERR(port->rs485_re_gpio);
+		port->rs485_re_gpio = NULL;
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Cannot get rs485-rx-enable-gpios\n");
+		return ret;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 108f95411471..dfe18ddb1674 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -253,6 +253,7 @@ struct uart_port {
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
+	struct gpio_desc	*rs485_re_gpio;		/* gpio RS485 receive enable */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };
-- 
2.25.1

