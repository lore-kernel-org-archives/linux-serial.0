Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E9EC2BA12
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 17:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90832077D
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 17:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="upgFVbek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgDCRty (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:49:54 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42621 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgDCRty (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 13:49:54 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5C49E22FF5;
        Fri,  3 Apr 2020 19:49:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585936191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=76ONF2brR4UH2L2O0KzOMhJ0PFTRaWglQINMn8OL8ak=;
        b=upgFVbekBHvxdaDNGJVhpdVyscg0XYHYqZq6hVIog0+GliunUNwJYzZ6vAKcaQfXyWxAly
        zgQl8GxMQ8qEysW34mSD0D+WljfvOQKc2Gb20PCZQeAp47+QNqfJgHLzIuYLn95TJkPiPz
        UiTgey0wO9TTCPggoxERk3qrT64JTpE=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Colin Ian King <colin.king@canonical.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] tty: serial: fsl_lpuart: make coverity happy
Date:   Fri,  3 Apr 2020 19:49:42 +0200
Message-Id: <20200403174942.9594-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 5C49E22FF5
X-Spamd-Result: default: False [4.90 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.956];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Coverity reports the following:

  var_compare_op: Comparing chan to null implies that chan might be null.

  1234        if (chan)
  1235                dmaengine_terminate_all(chan);
  1236

  Dereference after null check (FORWARD_NULL)
  var_deref_op: Dereferencing null pointer chan.

  1237        dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);

Technically, this is correct. But lpuart_dma_rx_free() is guarded by
lpuart_dma_rx_use which is only true if there is a dma channel, see
lpuart_rx_dma_startup(). In any way, this looks bogus. So remove
the superfluous "if (chan)" check and make coverity happy.

Fixes: a092ab25fdaa ("tty: serial: fsl_lpuart: fix DMA mapping")
Signed-off-by: Michael Walle <michael@walle.cc>
Reported-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 4cb04d8bf034..83d803729d23 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1210,9 +1210,7 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 					struct lpuart_port, port);
 	struct dma_chan *chan = sport->dma_rx_chan;
 
-	if (chan)
-		dmaengine_terminate_all(chan);
-
+	dmaengine_terminate_all(chan);
 	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
 	kfree(sport->rx_ring.buf);
 	sport->rx_ring.tail = 0;
-- 
2.20.1

