Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A057C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 17:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiJZRi3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiJZRi2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 13:38:28 -0400
X-Greylist: delayed 1388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Oct 2022 10:38:26 PDT
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A3F38A7E7
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 10:38:26 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id DD3A75E898;
        Wed, 26 Oct 2022 19:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1666805859;
        bh=TmMyXjcM0YsNPNvSSd5+dJKufXYGQ0pbaGROlQHD9IE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=GxJf0zvnl0KTpx/0pucbPmBQKBITUWdxmwkTOJH53+8vAEvqnD2SVfGlGTku6G4OM
         fPnxiHqLDzfxB176zJj2TDCnjU6IpLzfcFjXWzdNqjiBlnPDolTO4eNAxRnf+iOqqx
         3jnshxwyQtQ6BZxdZyiXQRpq+dGDxDxmR2QlQ9AuCrnNbfdjdGAo9MN3fgl5hF3YGx
         s+LF5zdSfuTPGnlwY7SRCoU6CGM+rTfDRc9jNorZgiH6eE7/SlHtSX2zQIDnhCaMNS
         rsTOMY0BRcKtgbizCJom3OAon6IJwZunaKybGQLsDgP/pVUYCoET04keyOkFwAx2vO
         EVnBQO8uGVRSw==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 26 Oct 2022 18:52:21 +0200
Received: from localhost.localdomain (172.16.51.8) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15 via Frontend Transport; Wed, 26 Oct 2022 18:52:21 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <marex@denx.de>,
        <jirislaby@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 4/4] serial: stm32: Add support for rs485 RX_DURING_TX GPIO
Date:   Wed, 26 Oct 2022 18:50:49 +0200
Message-ID: <20221026165049.9541-5-cniedermaier@dh-electronics.com>
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
space. Controlled by this GPIO, now the hardware is responsible for connecting
or disconnecting Rx during Tx.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Marek Vasut <marex@denx.de>
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/stm32-usart.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index dfdbcf092fac..91ff6d386932 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -226,7 +226,14 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
 
 	stm32_usart_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
 
-	rs485conf->flags |= SER_RS485_RX_DURING_TX;
+	if (port->rs485_rx_during_tx_gpio) {
+		if (rs485conf->flags & SER_RS485_RX_DURING_TX)
+			gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio, 1);
+		else
+			gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio, 0);
+	} else {
+		rs485conf->flags |= SER_RS485_RX_DURING_TX;
+	}
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		cr1 = readl_relaxed(port->membase + ofs->cr1);
-- 
2.11.0

