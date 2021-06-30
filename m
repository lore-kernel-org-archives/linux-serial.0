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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B24C11F65
	for <linux-serial@archiver.kernel.org>; Wed, 30 Jun 2021 11:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC58861919
	for <linux-serial@archiver.kernel.org>; Wed, 30 Jun 2021 11:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhF3L1k (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Jun 2021 07:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhF3L1j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Jun 2021 07:27:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C31C061756;
        Wed, 30 Jun 2021 04:25:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a127so2117403pfa.10;
        Wed, 30 Jun 2021 04:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=29+GEYVJGSurUohvXnAFypVRG5Ebr54t54b9IharxTo=;
        b=SLc8Cb4XM02o0nZB60JoBKIn92x1wm8XdOd1OoT3JN9UrnixuH8YiWUwTd9ydPVMCa
         OAIAQuHRzIlUpY3L1bf8WojccTnObmNL3Y3lmxN9Lkw7No2adS95fGLrt3khONgHMY2A
         Avx9/KSRQ9wlKnVlJhMPNkyFRu2oVygCKyyISx8EwkluamaVck9I2t+f4SSqVoeURMwJ
         y3QEeFBiZ4yHVEeXieYL/FRm+wkfcVJAO+RUT9A0FIDEaGhX0waLAlN2ZarbyO7IJR0m
         xA4TeXCIm1VdlXqvIIHra9kWn4TVV0nR6IZwZXKYt9/ZcsDQLXXd/sOVzgYuM56vjJTb
         ZfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=29+GEYVJGSurUohvXnAFypVRG5Ebr54t54b9IharxTo=;
        b=NXMez1V9kvP7ZYc8UAvhRP8//F71AnfVKjE+VrCPowDzJRuUYwtgfnc/vkZibOJpgg
         tou/O8WQrj0LII4frQelT9PMRGbgZIihEbqUoAUGvoica4x0/A8zPb4KiMYrvPZTQh0S
         PJHYQTUPo9MJ8CLxKRc7YK7llibFLSrzudztJPtLhypyVPv0QbKZW6h3QtMJNGnv28H3
         k8OO8Zhs0gTmkQNIwUwoLjQKlc5ooOo2yzpnMmYyJgnvF5hGnMSwaUC9Pl8SidEV2TUl
         Yca2heRvgaJOulOUHE30K1yGTi4mr9BtunIoEkcF99yowUIkrk6dIxzdifmM+HggR2yk
         +bnA==
X-Gm-Message-State: AOAM531r+jonwUpHeHz5VpJLZAyHxV80ZmG2AwpzYd5m7uFZD2+CL02B
        3+nJ1Ort3e/q7jkvBrU5tL3iqfswlniTQ8hE
X-Google-Smtp-Source: ABdhPJx5XUCk8OKv7e1Iq4Xs9i2AhQa1PBaqoDpe7ibAXnmXNwU5Lz4Qka5erRlTLDZLWTSHCY0sdg==
X-Received: by 2002:a63:6642:: with SMTP id a63mr33480670pgc.241.1625052309591;
        Wed, 30 Jun 2021 04:25:09 -0700 (PDT)
Received: from localhost.localdomain ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id c20sm21764985pfp.203.2021.06.30.04.25.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jun 2021 04:25:08 -0700 (PDT)
From:   Bing Fan <hptsfb@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] arm pl011 serial: support multi-irq request
Date:   Wed, 30 Jun 2021 19:25:05 +0800
Message-Id: <1625052305-18929-1-git-send-email-hptsfb@gmail.com>
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
 drivers/tty/serial/amba-pl011.c | 35 ++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 78682c12156a..e84f4b9dff87 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1701,11 +1701,40 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 	}
 }
 
+static void pl011_release_irq(struct uart_amba_port *uap, unsigned int max_cnt)
+{
+	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
+	int i;
+
+	for (i = 0; i < max_cnt; i++) {
+		if (amba_dev->irq[i])
+			free_irq(amba_dev->irq[i], uap);
+	}
+}
+
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
+		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);
+		if (ret) {
+			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
+			pl011_release_irq(uap, i - 1);
+			break;
+		}
+	}
+
+	return ret;
 }
 
 /*
@@ -1864,7 +1893,7 @@ static void pl011_shutdown(struct uart_port *port)
 
 	pl011_dma_shutdown(uap);
 
-	free_irq(uap->port.irq, uap);
+	pl011_release_irq(uap, AMBA_NR_IRQS);
 
 	pl011_disable_uart(uap);
 
@@ -1894,7 +1923,7 @@ static void sbsa_uart_shutdown(struct uart_port *port)
 
 	pl011_disable_interrupts(uap);
 
-	free_irq(uap->port.irq, uap);
+	pl011_release_irq(uap, AMBA_NR_IRQS);
 
 	if (uap->port.ops->flush_buffer)
 		uap->port.ops->flush_buffer(port);
-- 
2.17.1

