Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7548CC2BAEE
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 18:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F6420775
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 18:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="f55ZEELx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCXSsU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:48:20 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:44833 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbgCXSsT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 14:48:19 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C7CAE23E21;
        Tue, 24 Mar 2020 19:48:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585075697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coDQ3BMYKViIn16BM07LUkgfCh1z1B3hMas8+q9F7Sw=;
        b=f55ZEELx7JwrXq8N7GdKDqFSn+gYu3SeNb6I2dSyn5zgnq99C6/MDIEAjK52rZENauJTVa
        VhB1C4dT/ElNuVPBurPT784TQ15z/UrztP1puoudFSc2ngLJlZpYDlgoPZ98W7q4Rq1EfZ
        Sn4ew/PKsWdDiXqfWjIE9LAtmNKX0Vo=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: [RFC PATCH 3/3] tty: serial: fsl_lpuart: fix possible console deadlock
Date:   Tue, 24 Mar 2020 19:47:58 +0100
Message-Id: <20200324184758.8204-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324184758.8204-1-michael@walle.cc>
References: <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
 <20200324184758.8204-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: C7CAE23E21
X-Spamd-Result: default: False [4.90 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM(0.00)[0.189];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If the kernel console output is on this console any
dev_{err,warn,info}() may result in a deadlock if the sport->port.lock
spinlock is already held. This is because the _console_write() try to
aquire this lock, too. Remove any error messages where the spinlock is
taken or print after the lock is released.

Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 35 +++++++--------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index bbba298b68a4..0910308b38b1 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -420,7 +420,6 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 {
 	struct circ_buf *xmit = &sport->port.state->xmit;
 	struct scatterlist *sgl = sport->tx_sgl;
-	struct device *dev = sport->port.dev;
 	struct dma_chan *chan = sport->dma_tx_chan;
 	int ret;
 
@@ -442,10 +441,8 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 
 	ret = dma_map_sg(chan->device->dev, sgl, sport->dma_tx_nents,
 			 DMA_TO_DEVICE);
-	if (!ret) {
-		dev_err(dev, "DMA mapping error for TX.\n");
+	if (!ret)
 		return;
-	}
 
 	sport->dma_tx_desc = dmaengine_prep_slave_sg(chan, sgl,
 					ret, DMA_MEM_TO_DEV,
@@ -453,7 +450,6 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 	if (!sport->dma_tx_desc) {
 		dma_unmap_sg(chan->device->dev, sgl, sport->dma_tx_nents,
 			      DMA_TO_DEVICE);
-		dev_err(dev, "Cannot prepare TX slave DMA!\n");
 		return;
 	}
 
@@ -520,21 +516,12 @@ static int lpuart_dma_tx_request(struct uart_port *port)
 	struct lpuart_port *sport = container_of(port,
 					struct lpuart_port, port);
 	struct dma_slave_config dma_tx_sconfig = {};
-	int ret;
 
 	dma_tx_sconfig.dst_addr = lpuart_dma_datareg_addr(sport);
 	dma_tx_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	dma_tx_sconfig.dst_maxburst = 1;
 	dma_tx_sconfig.direction = DMA_MEM_TO_DEV;
-	ret = dmaengine_slave_config(sport->dma_tx_chan, &dma_tx_sconfig);
-
-	if (ret) {
-		dev_err(sport->port.dev,
-				"DMA slave config failed, err = %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return dmaengine_slave_config(sport->dma_tx_chan, &dma_tx_sconfig);
 }
 
 static bool lpuart_is_32(struct lpuart_port *sport)
@@ -1074,8 +1061,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 
 	dmastat = dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
 	if (dmastat == DMA_ERROR) {
-		dev_err(sport->port.dev, "Rx DMA transfer failed!\n");
 		spin_unlock_irqrestore(&sport->port.lock, flags);
+		dev_err(sport->port.dev, "Rx DMA transfer failed!\n");
 		return;
 	}
 
@@ -1179,23 +1166,17 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
 	nent = dma_map_sg(chan->device->dev, &sport->rx_sgl, 1,
 			  DMA_FROM_DEVICE);
-
-	if (!nent) {
-		dev_err(sport->port.dev, "DMA Rx mapping error\n");
+	if (!nent)
 		return -EINVAL;
-	}
 
 	dma_rx_sconfig.src_addr = lpuart_dma_datareg_addr(sport);
 	dma_rx_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	dma_rx_sconfig.src_maxburst = 1;
 	dma_rx_sconfig.direction = DMA_DEV_TO_MEM;
-	ret = dmaengine_slave_config(chan, &dma_rx_sconfig);
 
-	if (ret < 0) {
-		dev_err(sport->port.dev,
-				"DMA Rx slave config failed, err = %d\n", ret);
+	ret = dmaengine_slave_config(chan, &dma_rx_sconfig);
+	if (ret < 0)
 		return ret;
-	}
 
 	sport->dma_rx_desc = dmaengine_prep_dma_cyclic(chan,
 				 sg_dma_address(&sport->rx_sgl),
@@ -1203,10 +1184,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 				 sport->rx_sgl.length / 2,
 				 DMA_DEV_TO_MEM,
 				 DMA_PREP_INTERRUPT);
-	if (!sport->dma_rx_desc) {
-		dev_err(sport->port.dev, "Cannot prepare cyclic DMA\n");
+	if (!sport->dma_rx_desc)
 		return -EFAULT;
-	}
 
 	sport->dma_rx_desc->callback = lpuart_dma_rx_complete;
 	sport->dma_rx_desc->callback_param = sport;
-- 
2.20.1

