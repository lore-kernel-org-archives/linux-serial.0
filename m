Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E187C43217
	for <linux-serial@archiver.kernel.org>; Thu,  1 Dec 2022 11:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiLALXE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Dec 2022 06:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiLALWo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Dec 2022 06:22:44 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6A80A6CE3
        for <linux-serial@vger.kernel.org>; Thu,  1 Dec 2022 03:20:13 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 93F905E964;
        Thu,  1 Dec 2022 12:19:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669893557;
        bh=FlmKkoiFrEw7TwGNpagiI9P7WN6bC6dRqMXHKIF8BeY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=oaXShN/N6uhqot/zdWCQ8a1n0wzLspLOrFEk6Dghez5iD4rl17zk8nl5vGAy1lhpK
         EZcSu9hepKZoOHxX/YwTvZvfWcFFSLJehg7CHz3QvlABAJiso2aPZhcLfpktdaPhNX
         TrdmmGWgIZWcWAJF/XXfb3DFqTX8n1LINKxPUapzautZV2WV9jYREVNeYCye8xhB8B
         HBZv/6l1CArD4pXVbK/+MXiRIzJCkt9FgeoMmGLHVcZv+ZV9qrPAQTyeaEqtGYcm4G
         ZsJpgqXHcShSoEw/MLCh4LwNExTepvME4ENssvxKrh+m3THs0ieP07V7DwV4nPnqh2
         2WE7lz3BxVlxQ==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Thu, 1 Dec 2022 12:03:56 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Thu, 1 Dec 2022 12:03:56 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <marex@denx.de>,
        <jirislaby@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Dahl <ada@thorsis.com>, <kernel@dh-electronics.com>,
        Linux Team <linux-imx@nxp.com>
Subject: [PATCH V3 2/4] serial: core: Add option to output RS485 RX_DURING_TX state via GPIO
Date:   Thu, 1 Dec 2022 12:02:35 +0100
Message-ID: <20221201110237.7917-2-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20221201110237.7917-1-cniedermaier@dh-electronics.com>
References: <20221201110237.7917-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch provides a generic GPIO variable for outputting the state
of RS485 RX_DURING_TX. The GPIO is defined by the devicetree property
"rs485-rx-during-tx-gpios". To use it in a low level serial driver,
the evaluation of this variable must be implemented there accordingly.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Alexander Dahl <ada@thorsis.com>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: Linux Team <linux-imx@nxp.com>
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Rework of the commit message
    - Rework GPIO property comment
V3: - Rework GPIO property comment
---
 drivers/tty/serial/serial_core.c | 12 ++++++++++++
 include/linux/serial_core.h      |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b9fbbee598b8..867f2675caca 100644
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
index fd59f600094a..7d3784b18a6f 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -579,6 +579,7 @@ struct uart_port {
 	struct serial_rs485     rs485;
 	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
+	struct gpio_desc	*rs485_rx_during_tx_gpio; /* Output GPIO that sets the state of RS485 RX during TX */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };
-- 
2.11.0

