Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EAAC38A2D
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 17:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiJZRXb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 13:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiJZRXa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 13:23:30 -0400
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DDFB9AFAB
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 10:23:28 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 67F545DCC6;
        Wed, 26 Oct 2022 19:22:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1666804957;
        bh=7bASoVJYWw0nTMzLn8cj2xEolAZJM/TyDIkS61tWXuk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=V7jVUhyLTxOjnPArByEhFDEamM69r3l7rA9Z3iohzeffduMrP7fmH5Sh1DSBqamNc
         a07oUJ20B/oE6hY6nSR1YAdEwgnq/ECX6q7msrTrzZCQLCOVdPo/OMPqdmmmjCAGe2
         0vKQehkCZWU1tkAcdLGIDpBmzcmoj4f8hqbu444QAiEcmxiLsA/8p5UYi1KcXVGWiJ
         rr26RX8JStZwfLgzEunHtPKWtzOw4XP+4CiQM0bAnecV6HYMziwNb2Ilgh80NwUAjM
         rnXpdEfZCDz4O2ibYYUS4KVEKhMoDnz9gmPPGaKMNqrmOXCIShymN5fpgfEHxgmxoG
         H80sMcRNoZhNA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 26 Oct 2022 18:52:20 +0200
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
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@denx.de>,
        Linux Team <linux-imx@nxp.com>
Subject: [PATCH 3/4] serial: imx: Add support for rs485 RX_DURING_TX GPIO
Date:   Wed, 26 Oct 2022 18:50:48 +0200
Message-ID: <20221026165049.9541-4-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20221026165049.9541-1-cniedermaier@dh-electronics.com>
References: <20221026165049.9541-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If a RX_DURING_TX GPIO is defined by the DT property "rs485-rx-during-tx-gpios"
this patch switches this GPIO accordingly to the RS485 flag RX_DURING_TX in user
space. In addition, the i.MX UART receiver is no longer turned on and off during
sending, because now the hardware is responsible for connecting or disconnecting
Rx during Tx controlled by this GPIO.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Linux Team <linux-imx@nxp.com>
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/imx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 05b432dc7a85..16f8baaf4f12 100644
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
@@ -697,7 +698,8 @@ static void imx_uart_start_tx(struct uart_port *port)
 				imx_uart_rts_inactive(sport, &ucr2);
 			imx_uart_writel(sport, ucr2, UCR2);
 
-			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
+			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX) &&
+			    !port->rs485_rx_during_tx_gpio)
 				imx_uart_stop_rx(port);
 
 			sport->tx_state = WAIT_AFTER_RTS;
@@ -1931,6 +1933,13 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 	    rs485conf->flags & SER_RS485_RX_DURING_TX)
 		imx_uart_start_rx(port);
 
+	if (port->rs485_rx_during_tx_gpio) {
+		if (rs485conf->flags & SER_RS485_RX_DURING_TX)
+			gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio, 1);
+		else
+			gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio, 0);
+	}
+
 	return 0;
 }
 
-- 
2.11.0

