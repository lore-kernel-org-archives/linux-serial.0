Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF8EC47089
	for <linux-serial@archiver.kernel.org>; Fri,  2 Dec 2022 11:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiLBLOK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiLBLOJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Dec 2022 06:14:09 -0500
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C39CD0380
        for <linux-serial@vger.kernel.org>; Fri,  2 Dec 2022 03:14:06 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id F2E745DC6B;
        Fri,  2 Dec 2022 12:12:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669979576;
        bh=XiwlRoN6SFWV7lwPXeKbFNSGAtiKGfBc2C/mQAEg570=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=kRmLj+n+nYdIKS6CYD2sKTblrIRDlnJSO1U1SuTbQAucx+ZdUvkL3DlJ0QaDUyMch
         TsY2CN2Cv8Uj/WEAyvpoX7NDRFaaqXfKkX3vPDJFPVEoU73sHfA+Zgntsj+sLr5o4v
         Nl9BWjgfI+LlY+ROrn0Rog91l5gIbebWlUzEa6D2oBTyHat6WZtQkv6WgouBLlGGHf
         IP7escxiPrWqYHnraVOpNb65sChpKd1u3a82+3AZyW+5k0xbGoE7fGsci+FKsqOkrG
         roFe9vwsl7Yu63dOcQv+218qd+89HHnH7FmBsNpt1ihkTFxiW4fwmKx9K5GjRDjtcW
         9Rr09ZiWL8/Fw==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 2 Dec 2022 11:42:38 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Fri, 2 Dec 2022 11:42:38 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <marex@denx.de>,
        <jirislaby@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexander Dahl <ada@thorsis.com>,
        Fabio Estevam <festevam@denx.de>, <kernel@dh-electronics.com>,
        Linux Team <linux-imx@nxp.com>
Subject: [PATCH V4 3/4] serial: imx: Add support for RS485 RX_DURING_TX output GPIO
Date:   Fri, 2 Dec 2022 11:41:26 +0100
Message-ID: <20221202104127.122761-3-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20221202104127.122761-1-cniedermaier@dh-electronics.com>
References: <20221202104127.122761-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If a RX_DURING_TX GPIO is defined by the DT property "rs485-rx-during-tx-gpios"
this patch switches this GPIO accordingly to the RS485 flag RX_DURING_TX in user
space. In addition, the i.MX UART receiver is no longer turned on and off during
sending, because now the hardware is responsible for connecting or disconnecting
RX during TX controlled by this GPIO.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Alexander Dahl <ada@thorsis.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: Linux Team <linux-imx@nxp.com>
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Rework of the commit message
V3: - No changes
V4: - Direct call of gpiod_set_value_cansleep() without if statement
---
 drivers/tty/serial/imx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 757825edb0cd..a2aea88128af 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -476,7 +476,8 @@ static void imx_uart_stop_tx(struct uart_port *port)
 				imx_uart_rts_inactive(sport, &ucr2);
 			imx_uart_writel(sport, ucr2, UCR2);
 
-			imx_uart_start_rx(port);
+			if (!port->rs485_rx_during_tx_gpio)
+				imx_uart_start_rx(port);
 
 			sport->tx_state = OFF;
 		}
@@ -705,7 +706,8 @@ static void imx_uart_start_tx(struct uart_port *port)
 				imx_uart_rts_inactive(sport, &ucr2);
 			imx_uart_writel(sport, ucr2, UCR2);
 
-			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
+			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX) &&
+			    !port->rs485_rx_during_tx_gpio)
 				imx_uart_stop_rx(port);
 
 			sport->tx_state = WAIT_AFTER_RTS;
@@ -1955,6 +1957,10 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 	    rs485conf->flags & SER_RS485_RX_DURING_TX)
 		imx_uart_start_rx(port);
 
+	if (port->rs485_rx_during_tx_gpio)
+		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
+					 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
+
 	return 0;
 }
 
-- 
2.11.0

