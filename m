Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28078C4321E
	for <linux-serial@archiver.kernel.org>; Fri,  2 Dec 2022 10:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiLBK6o (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Dec 2022 05:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiLBK6m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Dec 2022 05:58:42 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E90C98EB4
        for <linux-serial@vger.kernel.org>; Fri,  2 Dec 2022 02:58:39 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 2B0B95F004;
        Fri,  2 Dec 2022 11:57:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669978672;
        bh=GH9X3a34TqpRMNX4ntlT2tR1dTO6zJC2YpW02wfXLL8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=eZFgYARO+/vN1THalRyjTyPjg2+sSNMLoUI477RBGeOUR/0fGnr3ysZsABAFp1AnU
         gr4ctbgn+ZsSKOD6GYuJKil6RTfvRyeaqgycJpPm+3Ov+per2Qjcb0FpANvBkgMWPy
         zIC4bnq2KyZ3y6DqG+cBTe/R4Op5PHiY5IkcPVQ14dxvHudjPsQGVCHXe3maLurFi0
         bj+HAdQHxRXNLcoYdvw5u+EEqOqDVrk5hJCNbWdLFtCoW8xswll69dUiVm3LsJgZUz
         sHr2a5Kx2lK9haxNtkDHX7ymtjCjH05ZzM9icpzCBGJA6UsuO/X2D1ixL5BWfMiPSw
         kaaGggaplOS7A==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 2 Dec 2022 11:42:37 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Fri, 2 Dec 2022 11:42:37 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <marex@denx.de>,
        <jirislaby@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Dahl <ada@thorsis.com>, <kernel@dh-electronics.com>,
        Linux Team <linux-imx@nxp.com>
Subject: [PATCH V4 2/4] serial: core: Add option to output RS485 RX_DURING_TX state via GPIO
Date:   Fri, 2 Dec 2022 11:41:25 +0100
Message-ID: <20221202104127.122761-2-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20221202104127.122761-1-cniedermaier@dh-electronics.com>
References: <20221202104127.122761-1-cniedermaier@dh-electronics.com>
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
V4: - No changes
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

