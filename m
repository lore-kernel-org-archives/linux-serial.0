Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CACFFA373E
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 17:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiJZRB0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiJZRBY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 13:01:24 -0400
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 653CB7CE34
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 10:01:21 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id A1006720612;
        Wed, 26 Oct 2022 18:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1666803150;
        bh=P5tRVMcnlNYMWhLvLu89wfasV6TP7daHT6i93HjdQ/M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZrXM05iVd0VPQfJj2CPr1wrTQz7cL42g/I9tg6GMsdR1S9gtogia9TQa8LO/6t2Mw
         H14lC5qhHoYcATOtsYzoWI/T6gFM2SQbYeD0S83j23ErtheW+hyZU73aDnSyi5t5FT
         ONFdGx8xfmJgJms1PBdr/tIBf+acTUk0h4eno8STjCtqRX7NEowPw9d76JtpvCeC4Q
         xnNXWAlK5U/5sUFfRDWPjsrY6uUn8PFHSmmNz0weqETqLD36bj4YKw0kfD5QaPwAhz
         xareh9ToMv0JE+anvSET07Dbn8A91ZDtn13vYel5UosQT/c81Bg3pjccEySdLvJBP3
         bhGW8PCazeAXA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 26 Oct 2022 18:52:19 +0200
Received: from localhost.localdomain (172.16.51.8) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15 via Frontend Transport; Wed, 26 Oct 2022 18:52:19 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <marex@denx.de>,
        <jirislaby@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Team <linux-imx@nxp.com>
Subject: [PATCH 2/4] serial: core: Add option to control rs485 RX_DURING_TX by a GPIO
Date:   Wed, 26 Oct 2022 18:50:47 +0200
Message-ID: <20221026165049.9541-3-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20221026165049.9541-1-cniedermaier@dh-electronics.com>
References: <20221026165049.9541-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch provides a generic GPIO variable for the use of the rs485
feature RX_DURING_TX controlled by a GPIO. The GPIO is defined by the
devicetree property "rs485-rx-during-tx-gpios". To use it in a low
level serial driver, the evaluation of this variable must be
implemented there accordingly.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Linux Team <linux-imx@nxp.com>
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/serial_core.c | 12 ++++++++++++
 include/linux/serial_core.h      |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 179ee199df34..63150d922aa1 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3410,6 +3410,7 @@ int uart_get_rs485_mode(struct uart_port *port)
 	struct device *dev = port->dev;
 	u32 rs485_delay[2];
 	int ret;
+	int rx_during_tx_gpio_flag;
 
 	ret = device_property_read_u32_array(dev, "rs485-rts-delay",
 					     rs485_delay, 2);
@@ -3458,6 +3459,17 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (port->rs485_term_gpio)
 		port->rs485_supported.flags |= SER_RS485_TERMINATE_BUS;
 
+	rx_during_tx_gpio_flag = (rs485conf->flags & SER_RS485_RX_DURING_TX) ?
+				 GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	port->rs485_rx_during_tx_gpio = devm_gpiod_get_optional(dev,
+								"rs485-rx-during-tx",
+								rx_during_tx_gpio_flag);
+	if (IS_ERR(port->rs485_rx_during_tx_gpio)) {
+		ret = PTR_ERR(port->rs485_rx_during_tx_gpio);
+		port->rs485_rx_during_tx_gpio = NULL;
+		return dev_err_probe(dev, ret, "Cannot get rs485-rx-during-tx-gpios\n");
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d657f2a42a7b..b4cdeb6e952a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -579,6 +579,7 @@ struct uart_port {
 	struct serial_rs485     rs485;
 	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
+	struct gpio_desc	*rs485_rx_during_tx_gpio; /* Controls RS485 Rx enable during Tx */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };
-- 
2.11.0

