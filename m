Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4882DC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 14:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB8E206D4
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 14:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgEROrM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 10:47:12 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:45505 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgEROrM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 10:47:12 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id DCDE410189B69;
        Mon, 18 May 2020 16:47:09 +0200 (CEST)
Received: from localhost (pd95be530.dip0.t-ipconnect.de [217.91.229.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 9A0F8612B6E6;
        Mon, 18 May 2020 16:47:09 +0200 (CEST)
X-Mailbox-Line: From 94c6c800d1ca9fa04766dd1d43a8272c5ad4bedd Mon Sep 17 00:00:00 2001
Message-Id: <94c6c800d1ca9fa04766dd1d43a8272c5ad4bedd.1589811297.git.lukas@wunner.de>
In-Reply-To: <cover.1589811297.git.lukas@wunner.de>
References: <cover.1589811297.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 18 May 2020 16:45:02 +0200
Subject: [PATCH v3 2/2] serial: 8250: Support rs485 bus termination GPIO
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit e8759ad17d41 ("serial: uapi: Add support for bus termination")
introduced the ability to enable rs485 bus termination from user space.
So far the feature is only used by a single driver, 8250_exar.c, using a
hardcoded GPIO pin specific to Siemens IOT2040 products.

Provide for a more generic solution by allowing specification of an
rs485 bus termination GPIO pin in the device tree:  Amend the serial
core to retrieve the GPIO from the device tree (or ACPI table) and amend
the default ->rs485_config() callback for 8250 drivers to change the
GPIO on request from user space.

Perhaps 8250_exar.c can be converted to the generic approach in a
follow-up patch.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_port.c |  3 +++
 drivers/tty/serial/serial_core.c    | 16 ++++++++++++++++
 include/linux/serial_core.h         |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4d83c85a7389..4f6ff54175ce 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -681,6 +681,9 @@ int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485)
 	memset(rs485->padding, 0, sizeof(rs485->padding));
 	port->rs485 = *rs485;
 
+	gpiod_set_value(port->rs485_term_gpio,
+			rs485->flags & SER_RS485_TERMINATE_BUS);
+
 	/*
 	 * Both serial8250_em485_init() and serial8250_em485_destroy()
 	 * are idempotent.
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 43b6682877d5..57840cf90388 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3317,6 +3317,7 @@ int uart_get_rs485_mode(struct uart_port *port)
 	 * to get to a defined state with the following properties:
 	 */
 	rs485conf->flags &= ~(SER_RS485_RX_DURING_TX | SER_RS485_ENABLED |
+			      SER_RS485_TERMINATE_BUS |
 			      SER_RS485_RTS_AFTER_SEND);
 	rs485conf->flags |= SER_RS485_RTS_ON_SEND;
 
@@ -3331,6 +3332,21 @@ int uart_get_rs485_mode(struct uart_port *port)
 		rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
 	}
 
+	/*
+	 * Disabling termination by default is the safe choice:  Else if many
+	 * bus participants enable it, no communication is possible at all.
+	 * Works fine for short cables and users may enable for longer cables.
+	 */
+	port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",
+							GPIOD_OUT_LOW);
+	if (IS_ERR(port->rs485_term_gpio)) {
+		ret = PTR_ERR(port->rs485_term_gpio);
+		port->rs485_term_gpio = NULL;
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Cannot get rs485-term-gpios\n");
+		return ret;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b649a2b894e7..9fd550e7946a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/console.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/circ_buf.h>
 #include <linux/spinlock.h>
@@ -251,6 +252,7 @@ struct uart_port {
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
+	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };
-- 
2.26.2

