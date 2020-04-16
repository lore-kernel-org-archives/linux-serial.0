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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BAFC2BB85
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 15:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D8621D91
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 15:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQxiKUpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbgDPPeq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395251AbgDPPen (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 11:34:43 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF2DC061A41
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2020 08:34:42 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x2so16737059qtr.0
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2020 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ut5uXotweyhZ8nkWaY+37qUO6fA/u0AaPvOL+nYemdU=;
        b=rQxiKUpP3zjPxdxV3Bi4X8kvHETpgNacBS2Oh7GsBv8mk4PuBvZDv5PNByXslIVqiw
         K02MIpzd/oMd7kZWHTd3vCOW3LaTBYv/qGW3/1qO6Zcp+Z2gzos6kn6qlwg1wETIQ7S9
         a1VkqsvNwg7pWzlEw0MEUc4rDMxLJMVwXoifVuS1RnXvQaUjQT6dhlKqjwvQtO8WkKWo
         SBCGfukkUoU1m14lh0FR0QBDAU4bUlwTsDrZrbSc9Ej0swZzuKhPSJoHiN8TaWppMRD5
         kaoV6aLctMXMatNt/kRlCYe5dd2eGPOp3VRHI0WhHxrpE4ochOB3IkI8Nn+LsJTqV1Cc
         x24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ut5uXotweyhZ8nkWaY+37qUO6fA/u0AaPvOL+nYemdU=;
        b=FpSiNff1ruSxidfljkXe3Di3rv4K0Seoe0bFEyZGkHmMnTIJM6YVEYvSmdcoYeRGxh
         /AgfKj2bdYcVQSP/kheQwutL5ZUgIRvtFJEc7XYzKa7H1ukrgSQCEqs2C0/GK5IlffV5
         Wm4fVNbARtpGjlt8uIqNiLGFDmOHezLkXlOrR3ImA+NBGtOBhLMCdFNAqpw9EScCA8G3
         fSR0pMpVDR6WOtT3ZIu6B3/GnJrzyB+xlnyGJ/GC9rykNm4wY4lhvtWufScuBibI6eyS
         oghllnq1eN4JVow5GRc52Dxvb3eheB7U0pFlhx9Cxhf9KIKAAqob35Cr3VjOjdEOwLIb
         u9SA==
X-Gm-Message-State: AGi0PuadzMVgF2uGAfnh504Y4RSfcvPreqpMqNm2F1IFdq36Fv2kP32L
        6iSp6V82sguJeOVHwAOCVnM=
X-Google-Smtp-Source: APiQypL/EQW93whnmKznl+oMdvXli0bsUyvkW5qBegxRSmfFtqnifxNjbfIjs1IJM+W44bTpeLqoKg==
X-Received: by 2002:ac8:3102:: with SMTP id g2mr12938794qtb.349.1587051281520;
        Thu, 16 Apr 2020 08:34:41 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:271:809b:81f0:1d41:9d6b])
        by smtp.gmail.com with ESMTPSA id g67sm15231182qkf.96.2020.04.16.08.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:34:40 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     michael@walle.cc, linux-serial@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] serial: fsl_lpuart: Change DMA failure messages to debug level
Date:   Thu, 16 Apr 2020 12:34:53 -0300
Message-Id: <20200416153453.18825-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently the following messages are seen when booting i.MX8QXP:

fsl-lpuart 5a060000.serial: DMA tx channel request failed, operating without tx DMA (-19)
fsl-lpuart 5a060000.serial: DMA rx channel request failed, operating without rx DMA (-19)

It is not really useful to have such messages on every boot, so change
them to debug level instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Drop the reference to the previous commit as well as the Fixes tag.

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

