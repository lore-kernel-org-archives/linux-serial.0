Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E21CC43331
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 18:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8592076E
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 18:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="WjXLkTpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgCXSsV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:48:21 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:46949 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgCXSsS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 14:48:18 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7BFE323D18;
        Tue, 24 Mar 2020 19:48:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585075696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hVG1w0WMyiKZg71IVdq4790+VznMJKoTLR+bJtQXuAo=;
        b=WjXLkTppXqpqcj9AFfuMbogpMdJaIQEV3kIQAaprqwFshizlilUj4LfM2bc0tc9xFEDnLc
        qdZw9U80O8poDUT1zVm4JBdLtptG4oD2unM5ZQr310eSoK2InIVypY1MF6NX8dQuoTT18l
        j6IrAR1PgunWjpD+p9QlES671ghLMrs=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 2/3] tty: serial: fsl_lpuart: fix return value checking
Date:   Tue, 24 Mar 2020 19:47:57 +0100
Message-Id: <20200324184758.8204-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324184758.8204-1-michael@walle.cc>
References: <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
 <20200324184758.8204-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 7BFE323D18
X-Spamd-Result: default: False [4.90 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM(0.00)[0.255];
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

The return value of lpuart_dma_tx_request() is a negative errno on
failure and zero on success.

Fixes: 159381df1442f ("tty: serial: fsl_lpuart: fix DMA operation when using IOMMU")
Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 960fc2658f19..bbba298b68a4 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1522,7 +1522,7 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 	}
 
 	ret = lpuart_dma_tx_request(&sport->port);
-	if (!ret)
+	if (ret)
 		goto err;
 
 	init_waitqueue_head(&sport->dma_wait);
-- 
2.20.1

