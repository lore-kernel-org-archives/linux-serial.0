Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E3DC18E5B
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 09:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF99B2076A
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 09:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="mQ83xjso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgCYJHK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:07:10 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:49625 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCYJHK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 05:07:10 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A613F231D9;
        Wed, 25 Mar 2020 10:07:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585127228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IsTTS0WBXuzG7rVz9eYl2v2OdWYP4Urtsy+pv/WCNv4=;
        b=mQ83xjso+xWAbE+9xXZuv8P/T65lEKPvtZzkCm5zsi9JSOZM/UN++lrgUFzohClh1gWanB
        OqdX69Je8TUKqt6DiHGIy4zGr/MIjB9lPK8HlRQW41E+VbCE9Zc80fgbTJR40G18HSpvlg
        6+7O4zx1TekzQiun3Nmb1cSasY13UgI=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Duan <fugang.duan@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 1/2] tty: serial: fsl_lpuart: move dma_request_chan()
Date:   Wed, 25 Mar 2020 10:06:57 +0100
Message-Id: <20200325090658.25967-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: A613F231D9
X-Spamd-Result: default: False [4.90 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM(0.00)[0.154];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Move dma_request_chan() out of the atomic context. First this call
should not be in the atomic context at all and second the
dev_info_once() may cause a hang because because the console takes this
spinlock, too.

Fixes: 159381df1442f ("tty: serial: fsl_lpuart: fix DMA operation when using IOMMU")
Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - instead of just moving the dev_info_once() out of the spinlock protected
   section, move the whole dma_request_chan(). Thanks Andy!

I've tested this on my board. Andy, Leonard, can you double check it? For
all which are not aware, this deadlock happens only if you have the kernel
console output on the lpuart, so if someone wants to test it, make sure you
have something like console=ttyLP0,115200.

 drivers/tty/serial/fsl_lpuart.c | 36 +++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 9c6a018b1390..131018979b77 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1510,20 +1510,33 @@ static void rx_dma_timer_init(struct lpuart_port *sport)
 	add_timer(&sport->lpuart_timer);
 }
 
-static void lpuart_tx_dma_startup(struct lpuart_port *sport)
+static void lpuart_request_dma(struct lpuart_port *sport)
 {
-	u32 uartbaud;
-	int ret;
-
 	sport->dma_tx_chan = dma_request_chan(sport->port.dev, "tx");
 	if (IS_ERR(sport->dma_tx_chan)) {
 		dev_info_once(sport->port.dev,
 			      "DMA tx channel request failed, operating without tx DMA (%ld)\n",
 			      PTR_ERR(sport->dma_tx_chan));
 		sport->dma_tx_chan = NULL;
-		goto err;
 	}
 
+	sport->dma_rx_chan = dma_request_chan(sport->port.dev, "rx");
+	if (IS_ERR(sport->dma_rx_chan)) {
+		dev_info_once(sport->port.dev,
+			      "DMA rx channel request failed, operating without rx DMA (%ld)\n",
+			      PTR_ERR(sport->dma_rx_chan));
+		sport->dma_rx_chan = NULL;
+	}
+}
+
+static void lpuart_tx_dma_startup(struct lpuart_port *sport)
+{
+	u32 uartbaud;
+	int ret;
+
+	if (!sport->dma_tx_chan)
+		goto err;
+
 	ret = lpuart_dma_tx_request(&sport->port);
 	if (!ret)
 		goto err;
@@ -1549,14 +1562,8 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 {
 	int ret;
 
-	sport->dma_rx_chan = dma_request_chan(sport->port.dev, "rx");
-	if (IS_ERR(sport->dma_rx_chan)) {
-		dev_info_once(sport->port.dev,
-			      "DMA rx channel request failed, operating without rx DMA (%ld)\n",
-			      PTR_ERR(sport->dma_rx_chan));
-		sport->dma_rx_chan = NULL;
+	if (!sport->dma_rx_chan)
 		goto err;
-	}
 
 	ret = lpuart_start_rx_dma(sport);
 	if (ret)
@@ -1592,6 +1599,8 @@ static int lpuart_startup(struct uart_port *port)
 	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_RXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
 
+	lpuart_request_dma(sport);
+
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	lpuart_setup_watermark_enable(sport);
@@ -1649,11 +1658,12 @@ static int lpuart32_startup(struct uart_port *port)
 		sport->port.fifosize = sport->txfifo_size;
 	}
 
+	lpuart_request_dma(sport);
+
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	lpuart32_setup_watermark_enable(sport);
 
-
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(sport);
 
-- 
2.20.1

