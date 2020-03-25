Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956F3C43331
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D4E20714
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCYXOv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:14:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40174 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbgCYXOn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 19:14:43 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jHFEI-0007ug-4p; Thu, 26 Mar 2020 00:14:34 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com
Subject: [PATCH DON'T APPLY v2 3/7] serial: 8250: Support rs485 bus termination GPIO
Date:   Thu, 26 Mar 2020 00:14:18 +0100
Message-Id: <20200325231422.1502366-4-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200325231422.1502366-1-heiko@sntech.de>
References: <20200325231422.1502366-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

Amend the serial core to retrieve the rs485 bus termination GPIO from
the device tree (or ACPI table) and amend the default ->rs485_config()
callback for 8250 drivers to change the GPIO on request from user space.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/tty/serial/8250/8250_port.c |  5 +++++
 drivers/tty/serial/serial_core.c    | 25 +++++++++++++++++++++++++
 include/linux/serial_core.h         |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4440867b7d20..47c059987538 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -30,6 +30,7 @@
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
 #include <linux/ktime.h>
+#include <linux/gpio/consumer.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -681,6 +682,10 @@ int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485)
 	memset(rs485->padding, 0, sizeof(rs485->padding));
 	port->rs485 = *rs485;
 
+	if (port->rs485_term_gpio)
+		gpiod_set_value(port->rs485_term_gpio,
+				rs485->flags & SER_RS485_TERMINATE_BUS);
+
 	/*
 	 * Both serial8250_em485_init() and serial8250_em485_destroy()
 	 * are idempotent.
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 43b6682877d5..77702b6371e3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -27,6 +27,7 @@
 
 #include <linux/irq.h>
 #include <linux/uaccess.h>
+#include <linux/gpio/consumer.h>
 
 /*
  * This is used to lock changes in serial line configuration.
@@ -3317,6 +3318,7 @@ int uart_get_rs485_mode(struct uart_port *port)
 	 * to get to a defined state with the following properties:
 	 */
 	rs485conf->flags &= ~(SER_RS485_RX_DURING_TX | SER_RS485_ENABLED |
+			      SER_RS485_TERMINATE_BUS |
 			      SER_RS485_RTS_AFTER_SEND);
 	rs485conf->flags |= SER_RS485_RTS_ON_SEND;
 
@@ -3331,6 +3333,29 @@ int uart_get_rs485_mode(struct uart_port *port)
 		rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
 	}
 
+	if (port->rs485_term_gpio)
+		devm_gpiod_put(dev, port->rs485_term_gpio);
+
+	port->rs485_term_gpio = devm_gpiod_get(dev, "rs485-term",
+					       GPIOD_FLAGS_BIT_DIR_OUT);
+	if (IS_ERR(port->rs485_term_gpio)) {
+		ret = PTR_ERR(port->rs485_term_gpio);
+		port->rs485_term_gpio = NULL;
+		if (ret != -ENOENT) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Cannot get rs485-term-gpios\n");
+			return ret;
+		}
+	} else {
+		ret = gpiod_get_value(port->rs485_term_gpio);
+		if (ret < 0) {
+			dev_err(dev, "Cannot get rs485-term-gpios value\n");
+			return ret;
+		}
+		if (ret)
+			rs485conf->flags |= SER_RS485_TERMINATE_BUS;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b649a2b894e7..9521e23b2144 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -251,6 +251,7 @@ struct uart_port {
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
+	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };
-- 
2.24.1

