Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BA9C4167B
	for <linux-serial@archiver.kernel.org>; Fri,  2 Dec 2022 11:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiLBL3s (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiLBL3Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Dec 2022 06:29:25 -0500
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67EEED4AD8
        for <linux-serial@vger.kernel.org>; Fri,  2 Dec 2022 03:28:58 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 1A7EC7201A0;
        Fri,  2 Dec 2022 12:27:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669980481;
        bh=Yw80B+VbXYxZbZl5QOEChJ2+lPK3kstlswLK+D6i38Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=mD1aba1DxgiExqPfgQvBYDdKgKQ7a5pVMsRNPU/PeJtuMHs0nKNujCm0HI7Aus7Xa
         svDc7ZqtEgh2sWVAltEYrP+uJd+AGryYNwJcXwLka1bjm7eB1D0fdh4x3j/PPGextN
         DpEh9XgfgF73CEoV4Ycfxk1V3hp3v889Tsxddtyu5sn2Q4UFh5OPSAnINDiVEyDO7i
         RxImd/flNi9QiZObGhFPiQE+n7iCPIeCxslgaBqvCeaw5uhy4172belboDEa28wyZ6
         o4rrjf+sITs23iWSope0G290OxeXiI/384CEJ7LcpqlYhHvwdFh0qp6/npoCTndCd5
         P/vx2AaRiqMUQ==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 2 Dec 2022 11:42:39 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Fri, 2 Dec 2022 11:42:39 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <marex@denx.de>,
        <jirislaby@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexander Dahl <ada@thorsis.com>, <kernel@dh-electronics.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH V4 4/4] serial: stm32: Add support for rs485 RX_DURING_TX output GPIO
Date:   Fri, 2 Dec 2022 11:41:27 +0100
Message-ID: <20221202104127.122761-4-cniedermaier@dh-electronics.com>
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
space. Controlled by this GPIO, now the hardware is responsible for connecting
or disconnecting RX during TX.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Alexander Dahl <ada@thorsis.com>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Rework of the commit message
V3: - No changes
V4: - Direct call of gpiod_set_value_cansleep() without if statement
---
 drivers/tty/serial/stm32-usart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index a1490033aa16..f1b1df78118f 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -226,7 +226,11 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
 
 	stm32_usart_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
 
-	rs485conf->flags |= SER_RS485_RX_DURING_TX;
+	if (port->rs485_rx_during_tx_gpio)
+		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
+					 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
+	else
+		rs485conf->flags |= SER_RS485_RX_DURING_TX;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		cr1 = readl_relaxed(port->membase + ofs->cr1);
-- 
2.11.0

