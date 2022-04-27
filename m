Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA0DC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 27 Apr 2022 13:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbiD0N0v (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 Apr 2022 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiD0N0s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Apr 2022 09:26:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659C2DD66;
        Wed, 27 Apr 2022 06:23:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CD93E1F44716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651065816;
        bh=DmoK0UuR6v0KpHbytvgVmKG60bVewljbgv1egm4cK/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvT6aF6BxtYKQDJmcGXm54ZVfHKQuAwNDg1kNCCy3eEcAhO1olbkSIAadBtFoY2qL
         tbgrM/unQKwMq5ZcHl7NsBqivWgIw0ThY+9E29fUyQiMoP9zqIOYVwUrg9tdNftBkf
         E66pCVA65kafC7IWLGpoYojTL8oNVjhVqptymXiJV0Q7Xh5Vpl3MyFShwtZRyE/3p5
         9O6JGABSPB4OSeEvXfXbkh3gnkKDx9rScLFgOJCGIl/bK4vah5EiuMF9HE3c3VEvsg
         BD3WVR+7GSY1X/ZBf/sTiTVtTvDDo3CCgg/Rdeqd+HtJKEfu5jx5MrIHhMXkvfbqHl
         Fx96R6HVv0RBA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] serial: 8250_mtk: Make sure to select the right FEATURE_SEL
Date:   Wed, 27 Apr 2022 15:23:27 +0200
Message-Id: <20220427132328.228297-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427132328.228297-1-angelogioacchino.delregno@collabora.com>
References: <20220427132328.228297-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Set the FEATURE_SEL at probe time to make sure that BIT(0) is enabled:
this guarantees that when the port is configured as AP UART, the
right register layout is interpreted by the UART IP.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index cd62a5f34014..28e36459642c 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -54,6 +54,9 @@
 #define MTK_UART_TX_TRIGGER	1
 #define MTK_UART_RX_TRIGGER	MTK_UART_RX_SIZE
 
+#define MTK_UART_FEATURE_SEL	39	/* Feature Selection register */
+#define MTK_UART_FEAT_NEWRMAP	BIT(0)	/* Use new register map */
+
 #ifdef CONFIG_SERIAL_8250_DMA
 enum dma_rx_status {
 	DMA_RX_START = 0,
@@ -569,6 +572,10 @@ static int mtk8250_probe(struct platform_device *pdev)
 		uart.dma = data->dma;
 #endif
 
+	/* Set AP UART new register map */
+	writel(MTK_UART_FEAT_NEWRMAP, uart.port.membase +
+	       (MTK_UART_FEATURE_SEL << uart.port.regshift));
+
 	/* Disable Rate Fix function */
 	writel(0x0, uart.port.membase +
 			(MTK_UART_RATE_FIX << uart.port.regshift));
-- 
2.35.1

