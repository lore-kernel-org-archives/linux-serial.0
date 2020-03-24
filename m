Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC07C43331
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 18:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F7F2074D
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 18:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="lHRgAxrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCXSsS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:48:18 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:41419 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgCXSsS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 14:48:18 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 93ECF23061;
        Tue, 24 Mar 2020 19:48:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585075696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ohh+i9NSBEkpWOYwm9D4yhAUjRHzH1Owl/vtdP1oVGo=;
        b=lHRgAxrUdxFEixCr0cBuxWWLhw6haXXklhQXFFXjrK4MTrEx+f5Fk0PeXoygg/Ld3YqARj
        FylYBW+9tkVWyn4a5s/AIu6KR+wvU11cRr+g+ACP4Bwiz3KjtsvYrqrFtApjkXZjMcFk8I
        ZDxouIvh5D788PruLo8pbDGTh9z3lzI=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 1/3] tty: serial: fsl_lpuart: move dev_info_once()
Date:   Tue, 24 Mar 2020 19:47:56 +0100
Message-Id: <20200324184758.8204-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 93ECF23061
X-Spamd-Result: default: False [4.90 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM(0.00)[0.217];
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

Don't take the spinlock and use dev_info_once(). This may cause a hang
because the console takes this spinlock, too. Just print this info after
we've released the lock.

Fixes: 159381df1442f ("tty: serial: fsl_lpuart: fix DMA operation when using IOMMU")
Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 9c6a018b1390..960fc2658f19 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1517,9 +1517,6 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 
 	sport->dma_tx_chan = dma_request_chan(sport->port.dev, "tx");
 	if (IS_ERR(sport->dma_tx_chan)) {
-		dev_info_once(sport->port.dev,
-			      "DMA tx channel request failed, operating without tx DMA (%ld)\n",
-			      PTR_ERR(sport->dma_tx_chan));
 		sport->dma_tx_chan = NULL;
 		goto err;
 	}
@@ -1551,9 +1548,6 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 
 	sport->dma_rx_chan = dma_request_chan(sport->port.dev, "rx");
 	if (IS_ERR(sport->dma_rx_chan)) {
-		dev_info_once(sport->port.dev,
-			      "DMA rx channel request failed, operating without rx DMA (%ld)\n",
-			      PTR_ERR(sport->dma_rx_chan));
 		sport->dma_rx_chan = NULL;
 		goto err;
 	}
@@ -1601,6 +1595,13 @@ static int lpuart_startup(struct uart_port *port)
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
+	if (!sport->dma_rx_chan)
+		dev_info_once(sport->port.dev,
+			      "DMA rx channel request failed, operating without rx DMA\n");
+	if (!sport->dma_tx_chan)
+		dev_info_once(sport->port.dev,
+			      "DMA tx channel request failed, operating without tx DMA\n");
+
 	return 0;
 }
 
@@ -1653,13 +1654,20 @@ static int lpuart32_startup(struct uart_port *port)
 
 	lpuart32_setup_watermark_enable(sport);
 
-
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(sport);
 
 	lpuart32_configure(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+
+	if (!sport->dma_rx_chan)
+		dev_info_once(sport->port.dev,
+			      "DMA rx channel request failed, operating without rx DMA\n");
+	if (!sport->dma_tx_chan)
+		dev_info_once(sport->port.dev,
+			      "DMA tx channel request failed, operating without tx DMA\n");
+
 	return 0;
 }
 
-- 
2.20.1

