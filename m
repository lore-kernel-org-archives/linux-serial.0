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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B86C2BB55
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 20:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8FF221BE5
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 20:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piToHmqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgDPUTw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728305AbgDPUTr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 16:19:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1FC061A41
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2020 13:12:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w3so37457plz.5
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2020 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mdld2TSwrjCL8Or77q1eiGOrXbCr1Q7AW1LhQ3P05Rc=;
        b=piToHmqFYmxGYFI6kkctoj0yPB6CmVdJ7fphEavw333j7ESiN53+qiLpXnZvicXJkQ
         85ToigFFDTr1nIYIg7h1VlWK13kGdzU5MHn/Oh/LBvKJ2JKtxnb+oPLuMa4sSV+nZBH9
         ld73fRG/aX01WjHlN3jyavvVA1NNnJrfXnGiPxMSGSG5TvDWlQKpibcmqBiEJh4Hmq6y
         YGcJOh2q2YfLRLRXheZ2Uwqh0BRo1cLTUqBwGlpHSgWSrtOUwShiKz/tm3rVr2RTYU5Z
         DNdRpDw2blipRU2ty/T1ycIm602EY3ftk2CrfuIFxynfmHtn8Hn8yUpV0pcc45FLixtN
         v0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mdld2TSwrjCL8Or77q1eiGOrXbCr1Q7AW1LhQ3P05Rc=;
        b=b2f9Emrv5qzq3ZTVVyyAbYuAPtvJWuqUA6DLpVIfW5Yvv1oaErcA5JVybKtgdvh6wy
         8X16Co4ZEWu5sZpE7gRM8v3BkRcO4LfXbsmngzosLzuc/LtIdYka7OP96ttbVudgzj64
         UYi+YNwntMpB997y+l2LuWCptZWOHd503BGyWdyR7axjIQHl4tyyz2t5kIrulllciGC4
         sjA2XKEFTEW9gQjuXaVdqS32ojHXrAM2gMU4mJd24zBqSc6BKrv6RyglkKFPgKbc2gf7
         RCW8ml+cOv+/xyOSQbGfwHEIXeqGOcKRU+fVlqe26hh6hYOj8qyXhVXfWWW9dGIvGKDo
         vaiQ==
X-Gm-Message-State: AGi0PuZuXXDECswOjI545cjbfLNhg9bwtZvuVfPvtZWgPDJRXCJDvoAG
        /672SEkIWbOjJiMSuCl7rTo=
X-Google-Smtp-Source: APiQypKEttWXOit8+KDLINXPhywlevr4IIeRhvp5hmcCHiBvLxo8mCagomH4UYOK4EBYVpv6BXP0Dg==
X-Received: by 2002:a17:90b:97:: with SMTP id bb23mr39362pjb.59.1587067966438;
        Thu, 16 Apr 2020 13:12:46 -0700 (PDT)
Received: from localhost.localdomain ([223.235.106.208])
        by smtp.gmail.com with ESMTPSA id m14sm3490316pje.19.2020.04.16.13.12.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 13:12:45 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, gregkh@linuxfoundation.org,
        manivannan.sadhasivam@linaro.org, afaerber@suse.de
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org,
        Amit Singh Tomar <amittomer25@gmail.com>
Subject: [PATCH] tty: serial: owl: add "much needed" clk_prepare_enable()
Date:   Fri, 17 Apr 2020 01:41:57 +0530
Message-Id: <1587067917-1400-1-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

commit 8ba92cf59335 ("arm64: dts: actions: s700: Add Clock Management Unit")
breaks the UART on Cubieboard7-lite (based on S700 SoC), This is due to the
fact that generic clk routine clk_disable_unused() disables the gate clks,
and that in turns disables OWL UART (but UART driver never enables it). To
prove this theory, Andre suggested to use "clk_ignore_unused" in kernel
commnd line and it worked (Kernel happily lands into RAMFS world :)).

This commit fix this up by adding clk_prepare_enable().

Fixes: 8ba92cf59335 ("arm64: dts: actions: s700: Add Clock Management Unit")

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
 drivers/tty/serial/owl-uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 42c8cc9..c149f8c3 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -680,6 +680,12 @@ static int owl_uart_probe(struct platform_device *pdev)
 		return PTR_ERR(owl_port->clk);
 	}
 
+	ret = clk_prepare_enable(owl_port->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not enable clk\n");
+		return ret;
+	}
+
 	owl_port->port.dev = &pdev->dev;
 	owl_port->port.line = pdev->id;
 	owl_port->port.type = PORT_OWL;
@@ -712,6 +718,7 @@ static int owl_uart_remove(struct platform_device *pdev)
 
 	uart_remove_one_port(&owl_uart_driver, &owl_port->port);
 	owl_uart_ports[pdev->id] = NULL;
+	clk_disable_unprepare(owl_port->clk);
 
 	return 0;
 }
-- 
2.7.4

