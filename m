Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD94C3F2D1
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 17:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC85214D8
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 17:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="spA1/oYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgCCRnZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:43:25 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:46151 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbgCCRnY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 12:43:24 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4385E23E3C;
        Tue,  3 Mar 2020 18:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583257401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7edbb9NYjCc5JcnsjhmvglVnqgFDebCZY58E/z3h3A=;
        b=spA1/oYxBwh9PYiH0WFfQjAlrEVieKI+N3GqamtiFsDlbFkZDsKXZqgySmq6V/wm6vVMwR
        agoWnmW2xNj5DQ/pb5x9FewUK5/V0VrlTjqDVuSQbMqzVx7i/QStsz0D5rdrmFOPDAs6OA
        HxCGTFIiuZXuWhaya7kPPUnQgJP6DmI=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 3/9] tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
Date:   Tue,  3 Mar 2020 18:43:00 +0100
Message-Id: <20200303174306.6015-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303174306.6015-1-michael@walle.cc>
References: <20200303174306.6015-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 4385E23E3C
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.502];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The DMA channel might not be available at probe time. This is esp. the
case if the DMA controller has an IOMMU mapping.

There is also another caveat. If there is no DMA controller at all,
dma_request_chan() will also return -EPROBE_DEFER. Thus we cannot test
for -EPROBE_DEFER in probe(). Otherwise the lpuart driver will fail to
probe if, for example, the DMA driver is not enabled in the kernel
configuration.

To workaround this, we request the DMA channel in _startup(). Other
serial drivers do it the same way.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 84 +++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c31b8f3db6bf..0b8c477b32a3 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1493,36 +1493,63 @@ static void rx_dma_timer_init(struct lpuart_port *sport)
 static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 {
 	u32 uartbaud;
+	int ret;
 
-	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
-		init_waitqueue_head(&sport->dma_wait);
-		sport->lpuart_dma_tx_use = true;
-		if (lpuart_is_32(sport)) {
-			uartbaud = lpuart32_read(&sport->port, UARTBAUD);
-			lpuart32_write(&sport->port,
-				       uartbaud | UARTBAUD_TDMAE, UARTBAUD);
-		} else {
-			writeb(readb(sport->port.membase + UARTCR5) |
-				UARTCR5_TDMAS, sport->port.membase + UARTCR5);
-		}
+	sport->dma_tx_chan = dma_request_slave_channel(sport->port.dev, "tx");
+	if (!sport->dma_tx_chan) {
+		dev_info_once(sport->port.dev,
+			      "DMA tx channel request failed, operating without tx DMA\n");
+		goto err;
+	}
+
+	ret = lpuart_dma_tx_request(&sport->port);
+	if (!ret)
+		goto err;
+
+	init_waitqueue_head(&sport->dma_wait);
+	sport->lpuart_dma_tx_use = true;
+	if (lpuart_is_32(sport)) {
+		uartbaud = lpuart32_read(&sport->port, UARTBAUD);
+		lpuart32_write(&sport->port,
+			       uartbaud | UARTBAUD_TDMAE, UARTBAUD);
 	} else {
-		sport->lpuart_dma_tx_use = false;
+		writeb(readb(sport->port.membase + UARTCR5) |
+		       UARTCR5_TDMAS, sport->port.membase + UARTCR5);
 	}
+
+	return;
+
+err:
+	sport->lpuart_dma_tx_use = false;
 }
 
 static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 {
-	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
-		/* set Rx DMA timeout */
-		sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
-		if (!sport->dma_rx_timeout)
-			sport->dma_rx_timeout = 1;
+	int ret;
 
-		sport->lpuart_dma_rx_use = true;
-		rx_dma_timer_init(sport);
-	} else {
-		sport->lpuart_dma_rx_use = false;
+	sport->dma_rx_chan = dma_request_slave_channel(sport->port.dev, "rx");
+	if (!sport->dma_rx_chan) {
+		dev_info_once(sport->port.dev,
+			      "DMA rx channel request failed, operating without rx DMA\n");
+		goto err;
 	}
+
+	ret = lpuart_start_rx_dma(sport);
+	if (ret)
+		goto err;
+
+	/* set Rx DMA timeout */
+	sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
+	if (!sport->dma_rx_timeout)
+		sport->dma_rx_timeout = 1;
+
+	sport->lpuart_dma_rx_use = true;
+	rx_dma_timer_init(sport);
+
+	return;
+
+err:
+	sport->lpuart_dma_rx_use = false;
 }
 
 static int lpuart_startup(struct uart_port *port)
@@ -1615,6 +1642,11 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
 	}
+
+	if (sport->dma_tx_chan)
+		dma_release_channel(sport->dma_tx_chan);
+	if (sport->dma_rx_chan)
+		dma_release_channel(sport->dma_rx_chan);
 }
 
 static void lpuart_shutdown(struct uart_port *port)
@@ -2520,16 +2552,6 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	sport->port.rs485_config(&sport->port, &sport->port.rs485);
 
-	sport->dma_tx_chan = dma_request_slave_channel(sport->port.dev, "tx");
-	if (!sport->dma_tx_chan)
-		dev_info(sport->port.dev, "DMA tx channel request failed, "
-				"operating without tx DMA\n");
-
-	sport->dma_rx_chan = dma_request_slave_channel(sport->port.dev, "rx");
-	if (!sport->dma_rx_chan)
-		dev_info(sport->port.dev, "DMA rx channel request failed, "
-				"operating without rx DMA\n");
-
 	return 0;
 
 failed_attach_port:
-- 
2.20.1

