Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB3EC11F67
	for <linux-serial@archiver.kernel.org>; Wed, 30 Jun 2021 01:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8740A619A1
	for <linux-serial@archiver.kernel.org>; Wed, 30 Jun 2021 01:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhF3B60 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Jun 2021 21:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhF3B60 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Jun 2021 21:58:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5CEC061760;
        Tue, 29 Jun 2021 18:55:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p17-20020a17090b0111b02901723ab8d11fso325777pjz.1;
        Tue, 29 Jun 2021 18:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3XEmE3tBGvyuKAhQyT6Z2Ge4lC3BY97Gtc5iIn4CjGA=;
        b=KkAQGChq+8NzbfFmR1tyl6K0QlHezai+O4ffrI1vf7v6lauxKfb1Fc7VUR0Hrw+m/O
         eLkkgepe9fr73zl4t2xSr+PQGXGwOp5M8VNVyba0VYVX5BFIiS4TKzcrsv8kEG3+spRQ
         Efns8xzIx0ljwtQhXSdOVRfJP7BdRDFWE6ZO2c3mY89xN6Qu7uV7K6kIrxUetDaRMIa5
         C1C/xoSxwu6+d8KilP1P5JSyOy0tN0xjDziAHvrr8fx4raNHqaoXPKl6Pn/91SjI8Yxz
         FpdD4vA3C8MfnDThfHOoe9miXKRtGuZDX02Xv1JKmlyT8OPUkFBE2pk9YbpSeNP8TzEe
         HwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3XEmE3tBGvyuKAhQyT6Z2Ge4lC3BY97Gtc5iIn4CjGA=;
        b=X9g1WhOapj0KQkacZJtUw+82fZQGEoW9aKmZvrZlrJ+qNqcscsUeNLOHctRGoSFuKT
         BbulwmEf8tzsm712+RgG9UIPIvnSjU6u9gSf7XDgPTDXIj75RfgADBzEx6Ez2zj/KV9w
         QxeRhmrHG8vBwOvTzoDalrzGydth50kpcbD+FljqLhZ63QU3ERKmWfEPcxLd3I8C6mPi
         HzkyabVXMLsA0CXTNhlvYnaf9SdNQDAxxOuNmuXYFIxSBq1+dNRqJ0SYjAFmdgQCbOq4
         vCy5pnrliLPi415Rur1QWwBFi7mGTUOM8Mv1+bFaX6IYOHKEuuXLaY6yChF6ZPIBToXT
         b0XQ==
X-Gm-Message-State: AOAM530tZZo7uwfdzm2MkclnD46cFP5vkMFsTLLbtBlvM8qJx+/J92uy
        fdtjI44fSKVV4hg+F2mHFWNvu9ZOFqiAK5X3
X-Google-Smtp-Source: ABdhPJwfkhhsbKt9qHbVrR7ViYv6sCNsxDdFVpWaoQLudfM9KvIjS2M9aJyE3EK53g63l761z109KA==
X-Received: by 2002:a17:902:b08c:b029:128:4b85:b6f7 with SMTP id p12-20020a170902b08cb02901284b85b6f7mr24966157plr.39.1625018157087;
        Tue, 29 Jun 2021 18:55:57 -0700 (PDT)
Received: from localhost.localdomain ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id j12sm19412048pjw.52.2021.06.29.18.55.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 18:55:56 -0700 (PDT)
From:   Bing Fan <hptsfb@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm pl011 serial: support multi-irq request
Date:   Wed, 30 Jun 2021 09:55:53 +0800
Message-Id: <1625018153-14672-1-git-send-email-hptsfb@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bing Fan <tombinfan@tencent.com>

In order to make pl011 work better, multiple interrupts are
required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
at the same time, pl011 to GIC does not merge the interrupt
lines(each serial-interrupt corresponding to different GIC hardware
interrupt), so need to enable and request multiple gic interrupt
numbers in the driver.

Signed-off-by: Bing Fan <tombinfan@tencent.com>
---
 drivers/tty/serial/amba-pl011.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 78682c12156a..8b471de0e31c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1703,9 +1703,26 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 
 static int pl011_allocate_irq(struct uart_amba_port *uap)
 {
+	int ret = 0;
+	int i;
+	unsigned int virq;
+	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
+
 	pl011_write(uap->im, uap, REG_IMSC);
 
-	return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011", uap);
+	for (i = 0; i < AMBA_NR_IRQS; i++) {
+		virq = amba_dev->irq[i];
+		if (virq == 0)
+			break;
+
+		ret = request_irq(virq, pl011_int, IRQF_SHARED, "uart-pl011-*", uap);
+		if (ret) {
+			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
+			break;
+		}
+	}
+
+	return ret;
 }
 
 /*
-- 
2.17.1

