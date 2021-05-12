Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8428C43611
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D2961412
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhELOOk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 10:14:40 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:37491 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhELOOS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 10:14:18 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D5EC32225B;
        Wed, 12 May 2021 16:13:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620828789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPGkhq/BSP3LqTLYGR9T4LGJDXj4OLPuBBkkFMuOrqY=;
        b=ZkdYqzQbY8Nb7BNiheV3T0G+5i3ReRFHj5pE77IPIK9nBw+eTPZy/hiO0GAmGSCvF2qP2+
        p0VsUFPEcYz8ZjdVxVCods3UxNIshP65+jiJzk7y17Z8E6lLXTzeiGqy9rGGYNglN9rrU+
        RrRzjk6Myh/v+Dx1b4+e6Z+LUilTTYs=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Johan Hovold <johan@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 9/9] serial: fsl_lpuart: disable DMA for console and fix sysrq
Date:   Wed, 12 May 2021 16:12:55 +0200
Message-Id: <20210512141255.18277-10-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512141255.18277-1-michael@walle.cc>
References: <20210512141255.18277-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SYSRQ doesn't work with DMA. This is because there is no error
indication whether a symbol had a framing error or not. Actually,
this is not completely correct, there is a bit in the data register
which is set in this case, but we'd have to read change the DMA access
to 16 bit and we'd need to post process the data, thus make the DMA
pointless in the first place.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Please note, that there is already sysrq/break support in the 8 bit
version. But I think there is a race between the hardware DMA controller
and the ISR in this driver. I'm not sure though and can't test it.

Angelo, maybe you could test it, I'd presume with this patch you don't need
the special handling in the ISR anymore.

 drivers/tty/serial/fsl_lpuart.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 1ed019d91177..0185bb8b6000 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1587,6 +1587,9 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 	u32 uartbaud;
 	int ret;
 
+	if (uart_console(&sport->port))
+		goto err;
+
 	if (!sport->dma_tx_chan)
 		goto err;
 
@@ -1616,6 +1619,9 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 	int ret;
 	unsigned char cr3;
 
+	if (uart_console(&sport->port))
+		goto err;
+
 	if (!sport->dma_rx_chan)
 		goto err;
 
-- 
2.20.1

