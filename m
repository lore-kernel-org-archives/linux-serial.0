Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB3C4338F
	for <linux-serial@archiver.kernel.org>; Sat, 14 Aug 2021 12:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71EF360F42
	for <linux-serial@archiver.kernel.org>; Sat, 14 Aug 2021 12:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbhHNMt5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 14 Aug 2021 08:49:57 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:64274 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbhHNMt5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 14 Aug 2021 08:49:57 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb6117bbc762b-8c6f8; Sat, 14 Aug 2021 20:49:12 +0800 (CST)
X-RM-TRANSID: 2eeb6117bbc762b-8c6f8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.250.151])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76117bbc2f36-269aa;
        Sat, 14 Aug 2021 20:49:11 +0800 (CST)
X-RM-TRANSID: 2ee76117bbc2f36-269aa
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] serial: stm32: use the defined variable to simplify code
Date:   Sat, 14 Aug 2021 20:49:51 +0800
Message-Id: <20210814124951.30084-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use the defined variable 'dev' to make the code cleaner.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/tty/serial/stm32-usart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index d4ea86e28..8f032e77b 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1176,7 +1176,7 @@ static int stm32_usart_of_dma_rx_probe(struct stm32_port *stm32port,
 	if (uart_console(port))
 		return -ENODEV;
 
-	stm32port->rx_buf = dma_alloc_coherent(&pdev->dev, RX_BUF_L,
+	stm32port->rx_buf = dma_alloc_coherent(dev, RX_BUF_L,
 					       &stm32port->rx_dma_buf,
 					       GFP_KERNEL);
 	if (!stm32port->rx_buf)
@@ -1242,7 +1242,7 @@ static int stm32_usart_of_dma_tx_probe(struct stm32_port *stm32port,
 
 	stm32port->tx_dma_busy = false;
 
-	stm32port->tx_buf = dma_alloc_coherent(&pdev->dev, TX_BUF_L,
+	stm32port->tx_buf = dma_alloc_coherent(dev, TX_BUF_L,
 					       &stm32port->tx_dma_buf,
 					       GFP_KERNEL);
 	if (!stm32port->tx_buf)
-- 
2.20.1.windows.1



