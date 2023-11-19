Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DF2C072A2
	for <linux-serial@archiver.kernel.org>; Sun, 19 Nov 2023 16:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjKSQW2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Nov 2023 11:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKSQW2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Nov 2023 11:22:28 -0500
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04E6126
        for <linux-serial@vger.kernel.org>; Sun, 19 Nov 2023 08:22:24 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4kYvrrFxYgbbT4kYvreJzl; Sun, 19 Nov 2023 17:22:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700410942;
        bh=kEuqgZIEPcB/w+zrez3UmGeoQW8VSNG01XU6Pt+hyqs=;
        h=From:To:Cc:Subject:Date;
        b=enN28/GCg/o1MtohjakZQm91u1MvRpCSbQuHhXWFMR6UvfttSKKILWBIsfbftK5aA
         CowZAZeDniDETM4+CmkQOq+OVHiUhBEC+LHslvrat23jziV0EgQKbrRzukdfzcVwrH
         Lmvg9rsTpPuqXHPhgHcfut0o/Q2YjxYPc1XTTIp2B+Dc5+i9WESPIAN1/rw5WTCkKl
         tSNDNG/MbMBNND77Tl46u2cQERux4HBllG7ElqCF7BQTvPIY6PXo1xCDfJZ67efZPF
         mNGBosP2DFpJaAkpreGbS07hRlZnmcXAs73qtYybR5YDvtRoRm/+58bVlgN1EF813W
         f9nBg1Y1KqXqg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 Nov 2023 17:22:22 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: mxs-auart: convert not to use dma_request_slave_channel()
Date:   Sun, 19 Nov 2023 17:22:20 +0100
Message-Id: <94812f7063e4db5590254ec45fe9bb3c6569509e.1700410918.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

dma_request_slave_channel() is deprecated. dma_request_chan() should
be used directly instead.

Switch to the preferred function and update the error handling accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I don't think that setting s->xx_dma_chan to NULL in case of error is
needed, because their would be some other problems or leak if it was
needed.
---
 drivers/tty/serial/mxs-auart.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 8eeecf8ad359..1bbe8f2e2fcc 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -904,21 +904,27 @@ static void mxs_auart_dma_exit(struct mxs_auart_port *s)
 
 static int mxs_auart_dma_init(struct mxs_auart_port *s)
 {
+	struct dma_chan *chan;
+
 	if (auart_dma_enabled(s))
 		return 0;
 
 	/* init for RX */
-	s->rx_dma_chan = dma_request_slave_channel(s->dev, "rx");
-	if (!s->rx_dma_chan)
+	chan = dma_request_chan(s->dev, "rx");
+	if (IS_ERR(chan))
 		goto err_out;
+	s->rx_dma_chan = chan;
+
 	s->rx_dma_buf = kzalloc(UART_XMIT_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!s->rx_dma_buf)
 		goto err_out;
 
 	/* init for TX */
-	s->tx_dma_chan = dma_request_slave_channel(s->dev, "tx");
-	if (!s->tx_dma_chan)
+	chan = dma_request_chan(s->dev, "tx");
+	if (IS_ERR(chan))
 		goto err_out;
+	s->tx_dma_chan = chan;
+
 	s->tx_dma_buf = kzalloc(UART_XMIT_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!s->tx_dma_buf)
 		goto err_out;
-- 
2.34.1

