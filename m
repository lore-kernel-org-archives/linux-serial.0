Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7EDC1975A
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 09:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276162076A
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 09:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Eo0/7uAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgCYJHL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:07:11 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:40739 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgCYJHK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 05:07:10 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ACD9223D18;
        Wed, 25 Mar 2020 10:07:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585127228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSw5htA3zFKuEj3IkQe1+1H4Y07G8jg2OZJczsY68JI=;
        b=Eo0/7uATpaLMl2SHqmmcLT0+Vz2JXDMjZrMHUpgx7pVps5CVU4NhV2DZdarbSXa0Zed0Gm
        7fVU88+Wpd4PhnjdWJsE6qW/TxPiHkMqMORH5CcGf1eeEgzRpyU2a9iipbq8QdUH6pwlA1
        2JkJbmSDGBu6E6li3HNGLQu7Moi//WI=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Duan <fugang.duan@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 2/2] tty: serial: fsl_lpuart: fix return value checking
Date:   Wed, 25 Mar 2020 10:06:58 +0100
Message-Id: <20200325090658.25967-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325090658.25967-1-michael@walle.cc>
References: <20200325090658.25967-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: ACD9223D18
X-Spamd-Result: default: False [4.90 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM(0.00)[0.200];
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

The return value of lpuart_dma_tx_request() is an negative errno on
failure and zero on success.

Fixes: 159381df1442f ("tty: serial: fsl_lpuart: fix DMA operation when using IOMMU")
Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - none

 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 131018979b77..5d41075964f2 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1538,7 +1538,7 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 		goto err;
 
 	ret = lpuart_dma_tx_request(&sport->port);
-	if (!ret)
+	if (ret)
 		goto err;
 
 	init_waitqueue_head(&sport->dma_wait);
-- 
2.20.1

