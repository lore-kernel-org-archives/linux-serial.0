Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD8C4724C
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 07:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B025C20663
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 07:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iphw8LOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgEFHXl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 03:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbgEFHXk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 03:23:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D4DC061A0F
        for <linux-serial@vger.kernel.org>; Wed,  6 May 2020 00:23:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r4so714820pgg.4
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2020 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LGrd0GCp2GzoXCciri6QP/vYjybcGcRtj9Gm0aAra8=;
        b=iphw8LOHvc14me23EkcDGAveepL+5oyVXgA/7aVqeoEgbqB/kHqW7UDZshvRhYen0n
         Phl9jDxNaaJWm//QIjLLLSHud5Tr5atoUUu0Gu+K+/HzYd0qIGMH+h04d3AooOrF2bEU
         84xw9tqPnkasKhkgaE0aNrQBUtzcxyTwUu7Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LGrd0GCp2GzoXCciri6QP/vYjybcGcRtj9Gm0aAra8=;
        b=bX1H/qMY3HJK7PGMY6v5DuF2e/RE4JDOqcfH9pJ8e5ue3x9cAvFyV15/lWYxMmoIUB
         297KeCDHZZeCRJeWXu3xdQDelkTPL9pta5EAnDISc5VwTl6sNtFWyEzfllwye2wyfBqY
         cG2x4lmWP0Cc4HktNuZQ3NsIWeDTCNa/p/Gq53NM5Z0GjDdsUgDHs4kBQ8f5x2KJIe8I
         3yO8zIOhlV02RwZtUpvXmpoVOgrjMiTUED7jEq6pBMEyPp0whHohKFD9cjCSx1StJiOh
         rCY8AYqEzIAWklm9x67fX5EwFGGQV7zpAXRTtYfxfnKOdyms9oW0Vb2T8QwIR/sv5Bwt
         v0cQ==
X-Gm-Message-State: AGi0PubUHl6ngovULy3RGIgsHQX2iWCfis8iw/ze5s5nsqUhXRPKJBKz
        F5bmYFzfha9wuHsM9UsBxfxmDA==
X-Google-Smtp-Source: APiQypKo1Sd/AT6g8MTRHUbLALuWztAtTilmBnoQG2IBw8cdHyWnDYPoOcoAWJvi465bvD3/LJF4qA==
X-Received: by 2002:aa7:982a:: with SMTP id q10mr6950169pfl.212.1588749818693;
        Wed, 06 May 2020 00:23:38 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id i18sm3980351pjx.33.2020.05.06.00.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 00:23:38 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        long.cheng@mediatek.com, changqi.hu@mediatek.com
Cc:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, Claire Chang <tientzu@chromium.org>
Subject: [PATCH 3/3] uart: mediatek: move the in-band wakeup logic to core
Date:   Wed,  6 May 2020 15:23:14 +0800
Message-Id: <20200506072314.112409-4-tientzu@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200506072314.112409-1-tientzu@chromium.org>
References: <20200506072314.112409-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Move the in-band wakeup logic to core so that we can control the wakeup
behavior by serdev controller's power/wakeup node and align with other
serial drivers.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/tty/serial/8250/8250_mtk.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index f839380c2f4c1..52cb41e4e493d 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -71,7 +71,6 @@ struct mtk8250_data {
 #ifdef CONFIG_SERIAL_8250_DMA
 	enum dma_rx_status	rx_status;
 #endif
-	int			rx_wakeup_irq;
 };
 
 /* flow control mode */
@@ -496,6 +495,8 @@ static int mtk8250_probe(struct platform_device *pdev)
 	struct uart_8250_port uart = {};
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	struct resource *wakeup_irq =
+		platform_get_resource(pdev, IORESOURCE_IRQ, 1);
 	struct mtk8250_data *data;
 	int err;
 
@@ -525,6 +526,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 	spin_lock_init(&uart.port.lock);
 	uart.port.mapbase = regs->start;
 	uart.port.irq = irq->start;
+	uart.port.wakeup_irq = wakeup_irq ? wakeup_irq->start : -ENXIO;
 	uart.port.pm = mtk8250_do_pm;
 	uart.port.type = PORT_16550;
 	uart.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
@@ -556,8 +558,6 @@ static int mtk8250_probe(struct platform_device *pdev)
 	if (data->line < 0)
 		return data->line;
 
-	data->rx_wakeup_irq = platform_get_irq_optional(pdev, 1);
-
 	return 0;
 }
 
@@ -581,23 +581,9 @@ static int mtk8250_remove(struct platform_device *pdev)
 static int __maybe_unused mtk8250_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
-	int irq = data->rx_wakeup_irq;
-	int err;
 
 	serial8250_suspend_port(data->line);
-
 	pinctrl_pm_select_sleep_state(dev);
-	if (irq >= 0) {
-		err = enable_irq_wake(irq);
-		if (err) {
-			dev_err(dev,
-				"failed to enable irq wake on IRQ %d: %d\n",
-				irq, err);
-			pinctrl_pm_select_default_state(dev);
-			serial8250_resume_port(data->line);
-			return err;
-		}
-	}
 
 	return 0;
 }
@@ -605,12 +591,8 @@ static int __maybe_unused mtk8250_suspend(struct device *dev)
 static int __maybe_unused mtk8250_resume(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
-	int irq = data->rx_wakeup_irq;
 
-	if (irq >= 0)
-		disable_irq_wake(irq);
 	pinctrl_pm_select_default_state(dev);
-
 	serial8250_resume_port(data->line);
 
 	return 0;
-- 
2.26.2.526.g744177e7f7-goog

