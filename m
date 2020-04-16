Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9EEC352BE
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D222222D
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZQn2p0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406527AbgDPPPO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503348AbgDPPPM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 11:15:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4FC061A0C
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2020 08:15:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j4so21577834qkc.11
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2020 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J1nUfeF0NuLOPreIr4EEgwD378eXhIJfkzeXFz/nFMc=;
        b=UZQn2p0mhTFI0FekFMI8ZziOOIgfaLWJLjvUmwc8JTM0VqaTNcGjneAnXuHI70GKQI
         kF+60mBpAcF8yYcNPuvWxdXFUZ8q7/yTHET0tNSWKkeOmP3fleUDQwknfYuPhc6DmTuw
         HMKJlmcgRh1mMkpenBi4Arweis5x+7J4p0VFlMcei6xsVjobLvAuORv804Z9ZTWXUQKB
         XSi7Eg+CGWTTjiNm3POZshEQ+zHF9uX+2lyK0ir9g/qnUEkj3kuqdTSdottl3qZiSHnX
         LXzQqDP+K6r+ZkKmEoZanByRCMXLObDUiOpF87lZXpkUV9oz5m1FqcDdWM3nJoKJSKr7
         qRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J1nUfeF0NuLOPreIr4EEgwD378eXhIJfkzeXFz/nFMc=;
        b=StMuIjWG+CnzHyV9ExYTBobejFR5IjbRNcbIkVy2TCXCQl4LGa02BJaZ7ULia10nGA
         muEi+87mLR9/B/yXoxh7o1mLa+1RN0X0fyJdxsEEL7Edhi5xvaRYfWn18uRxMqYK0nQH
         aOW2oDIq7POBxsy+rLsX25wsQd0u6/fib67q2aBKJAkfiYI4FTLdYm5HQE7+T88KVPN/
         wlMTbCNXokOzPBnZkDk9de/tcQggHWQFHccHAG8+tpg1cXNEMGCRwtSM9WE0/GphBIh+
         KY3JXfn9mJJ45Hoqyybu/WpmrgN5+3iUN+idnsWbax1mTgOHN0GlgXYxSCmc21j+Z1e7
         psKQ==
X-Gm-Message-State: AGi0PubLJx3mFko+Qg6Vb41FnpQsN52tY0XiGyFxW6fKZPRziITTrUze
        bs8cD7/W0zztQQvD9aNbZRU=
X-Google-Smtp-Source: APiQypK+W9+Ms32Z2xtm1TrBOwGKgjc7oF5Ad33+ha8OyLAHyv807En2eSnZBcAE6oA84LjBNikg7Q==
X-Received: by 2002:a37:4b97:: with SMTP id y145mr32970652qka.167.1587050110488;
        Thu, 16 Apr 2020 08:15:10 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:271:809b:81f0:1d41:9d6b])
        by smtp.gmail.com with ESMTPSA id o6sm14795771qkd.113.2020.04.16.08.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:15:09 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     michael@walle.cc, linux-serial@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: fsl_lpuart: Change DMA failure messages to debug level
Date:   Thu, 16 Apr 2020 12:15:41 -0300
Message-Id: <20200416151541.18385-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit 159381df1442 ("tty: serial: fsl_lpuart: fix DMA operation when
using IOMMU") commit the following messages are seen when booting i.MX8QXP:

fsl-lpuart 5a060000.serial: DMA tx channel request failed, operating without tx DMA (-19)
fsl-lpuart 5a060000.serial: DMA rx channel request failed, operating without rx DMA (-19)

It is not really useful to have such messages on every boot, so change
them to debug level instead.

Fixes: 159381df1442 ("tty: serial: fsl_lpuart: fix DMA operation when using IOMMU")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/fsl_lpuart.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5d41075964f2..11131cd6cb30 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1514,17 +1514,17 @@ static void lpuart_request_dma(struct lpuart_port *sport)
 {
 	sport->dma_tx_chan = dma_request_chan(sport->port.dev, "tx");
 	if (IS_ERR(sport->dma_tx_chan)) {
-		dev_info_once(sport->port.dev,
-			      "DMA tx channel request failed, operating without tx DMA (%ld)\n",
-			      PTR_ERR(sport->dma_tx_chan));
+		dev_dbg_once(sport->port.dev,
+			     "DMA tx channel request failed, operating without tx DMA (%ld)\n",
+			     PTR_ERR(sport->dma_tx_chan));
 		sport->dma_tx_chan = NULL;
 	}
 
 	sport->dma_rx_chan = dma_request_chan(sport->port.dev, "rx");
 	if (IS_ERR(sport->dma_rx_chan)) {
-		dev_info_once(sport->port.dev,
-			      "DMA rx channel request failed, operating without rx DMA (%ld)\n",
-			      PTR_ERR(sport->dma_rx_chan));
+		dev_dbg_once(sport->port.dev,
+			     "DMA rx channel request failed, operating without rx DMA (%ld)\n",
+			     PTR_ERR(sport->dma_rx_chan));
 		sport->dma_rx_chan = NULL;
 	}
 }
-- 
2.17.1

