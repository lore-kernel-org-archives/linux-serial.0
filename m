Return-Path: <SRS0=HSIU=4I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF3DC11D1C
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3927624673
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="ptgCAtca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgBTRxp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:53:45 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:44773 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgBTRxp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 12:53:45 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DB1F523E25;
        Thu, 20 Feb 2020 18:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582220632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaO+mat3+Uxwq9DbMCw/0coohVq5jCugVuQMQ8FIwrs=;
        b=ptgCAtcaxin2iQ8e/0hoxy/iy26QoyhSYD9ltPddw/z8KWYj71x/YYse9HLOPCEFGGkCYl
        xo/UQ76FQV8gx+vHdgsaRp5NrzqMc1Yt4he3/H81VfBuDj6q5Ku9xzaRaezcSQpu/6+cai
        QcM+2Be45WZedWXMy2HYtvm4jQgWfrg=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 3/7] tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
Date:   Thu, 20 Feb 2020 18:43:30 +0100
Message-Id: <20200220174334.23322-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220174334.23322-1-michael@walle.cc>
References: <20200220174334.23322-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: DB1F523E25
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.482];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The DMA channel might not be available at the first probe time. This is
esp. the case if the DMA controller has an IOMMU mapping.

Use the new dma_request_chan() API and handle EPROBE_DEFER errors. Also
reorder the code a bit, so that we don't prepare the whole UART just to
determine that the DMA channel is not ready yet and we have to undo all
the stuff. Try to map the DMA channels earlier.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 35 +++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c31b8f3db6bf..fd9f60d0817a 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2416,6 +2416,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	const struct lpuart_soc_data *sdata = of_id->data;
 	struct device_node *np = pdev->dev.of_node;
 	struct lpuart_port *sport;
+	struct dma_chan *dma_chan;
 	struct resource *res;
 	int ret;
 
@@ -2483,6 +2484,26 @@ static int lpuart_probe(struct platform_device *pdev)
 	}
 	sport->port.line = ret;
 
+	dma_chan = dma_request_chan(sport->port.dev, "tx");
+	if (PTR_ERR(dma_chan) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto failed_request_tx_dma;
+	} else if (IS_ERR(dma_chan))
+		dev_info(sport->port.dev, "DMA tx channel request failed, "
+				"operating without tx DMA\n");
+	else
+		sport->dma_tx_chan = dma_chan;
+
+	dma_chan = dma_request_chan(sport->port.dev, "rx");
+	if (PTR_ERR(dma_chan) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto failed_request_rx_dma;
+	} else if (IS_ERR(dma_chan))
+		dev_info(sport->port.dev, "DMA rx channel request failed, "
+				"operating without rx DMA\n");
+	else
+		sport->dma_rx_chan = dma_chan;
+
 	ret = lpuart_enable_clks(sport);
 	if (ret)
 		goto failed_clock_enable;
@@ -2520,22 +2541,16 @@ static int lpuart_probe(struct platform_device *pdev)
 
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
 failed_irq_request:
 	lpuart_disable_clks(sport);
 failed_clock_enable:
+	dma_release_channel(sport->dma_rx_chan);
+failed_request_rx_dma:
+	dma_release_channel(sport->dma_tx_chan);
+failed_request_tx_dma:
 failed_out_of_range:
 	if (sport->id_allocated)
 		ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
-- 
2.20.1

