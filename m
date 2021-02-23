Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E816EC43381
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 08:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B566E64D5D
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 08:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhBWI4x (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Feb 2021 03:56:53 -0500
Received: from m12-11.163.com ([220.181.12.11]:48204 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhBWI4i (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Feb 2021 03:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=t2+xH
        3961CWW/1G3xqyAxTKD/5mOtwqsyjG8AHRSgeM=; b=coJxC0jqB4f9zH2zVCY4g
        Kji2dfPDwBQQwie1V041dDAYQpTP+Iki5CJoRUeCJhLIUtIi6LOyRRX9+rXuaF+4
        VGPcvdCYjzBlp/wJoTExxE66zBO3a/xTITZWwv3gNWsHYHe8tJfYwlNmTpYfEY0K
        jBzlH7FGTZjKrUTiPSC3VM=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp7 (Coremail) with SMTP id C8CowADXudmhtzRgKHoAPA--.61720S2;
        Tue, 23 Feb 2021 16:06:58 +0800 (CST)
From:   dingsenjie@163.com
To:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] tty/serial:Remove superfluous "breaks"
Date:   Tue, 23 Feb 2021 16:06:30 +0800
Message-Id: <20210223080630.44644-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowADXudmhtzRgKHoAPA--.61720S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4rtr18Jry5GrWfJrW8Zwb_yoWDCwb_A3
        4vga48XF1DCFWSyry7t345ZrWIyanruF1IqF1vqasxW34UZ3ySyFWDuwnxXr47GFs7XrZ7
        ur9I9343Ar1kCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0niSJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/xtbBRQJCyFPAKJicewAAsJ
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Remove superfluous "breaks", as there is a "return" before them.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 drivers/tty/serial/imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 425624d..6c1c31a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -300,7 +300,6 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 	switch (offset) {
 	case UCR1:
 		return sport->ucr1;
-		break;
 	case UCR2:
 		/*
 		 * UCR2_SRST is the only bit in the cached registers that might
@@ -311,16 +310,12 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 		if (!(sport->ucr2 & UCR2_SRST))
 			sport->ucr2 = readl(sport->port.membase + offset);
 		return sport->ucr2;
-		break;
 	case UCR3:
 		return sport->ucr3;
-		break;
 	case UCR4:
 		return sport->ucr4;
-		break;
 	case UFCR:
 		return sport->ufcr;
-		break;
 	default:
 		return readl(sport->port.membase + offset);
 	}
-- 
1.9.1

