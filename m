Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A928C11F68
	for <linux-serial@archiver.kernel.org>; Thu,  1 Jul 2021 01:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EF36146B
	for <linux-serial@archiver.kernel.org>; Thu,  1 Jul 2021 01:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhGABlH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Jun 2021 21:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbhGABlF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Jun 2021 21:41:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590DC0617A8;
        Wed, 30 Jun 2021 18:38:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i6so4495570pfq.1;
        Wed, 30 Jun 2021 18:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AhIcCAsU0JMuAgIY80aubo73YLuVRNjzuPIRJkjz91M=;
        b=IYHpeVN0i0Jm/bwU3HHeloREaBl4e4LKoMR5Xlvgz+FYeCIgpuKaDI0UbnxFwrXWKI
         j4SMMdS+mREd6NdhWXN4DMfYATZM6gXfXWDCSZ15NUrNq+rIGWLA9f4vOIi9Rtcoooe5
         8vl3GRuI87J0OPIQS9Jyk6EE9jEifIQvTgOPkx7XrxzkxXM7VKlmcuhOek9S5/9z/DH6
         4gzM8swCRghNJi3MdJlN3fpE2uV5G0piyiZBjouU7Tw6JFQ9tblKL+GDb8yeK3CirjSP
         Eu2r0hiIH1pkS8V3R6FQjPlAW2isV+6LTyWW0fQtwa1IVxvAqYyx975iO5DaKPkBq+jI
         mBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AhIcCAsU0JMuAgIY80aubo73YLuVRNjzuPIRJkjz91M=;
        b=A1AaVAiybPaSqdQK7XZkpum4e2JlLRrIW9al9KySopIiCPewkfO+OhVEJRsn6BPjF2
         6HQMXnS9R4F5/LUw6N1Jse47cMVWLz+1ZA/fd8Oa0boPfwDLnVarEIiSJvovIDqVOr1o
         rD6Q0BBY4Ip1AYKYWm1GhUilM6lprRl3QP1MCfm584RFgdQViaLhAAbXTqWI1iKLo6oY
         IMH/Co7TCQZHpr2zzoIh/AFSjv0fIhWrbRuAKppaKVvX2wWX22AG3vOdQEwshyvrdPYb
         cnTmBzyNW8vVfCzc32aTP4/DsyLap55Al84WoVdZ2bQfZBhCnGWTuAO8wk9w9UyFbDbs
         5kUA==
X-Gm-Message-State: AOAM533iF8beOH+U2MiAggvXLoqaV3WxTiAw9Ba2ae4O8UEXPgFVUkVa
        bRFTC7rnTfXC0Q/w9oRKKaE=
X-Google-Smtp-Source: ABdhPJxb22qiES2bjC3lmrAzp8vd/ZbGrtgz3sMO4d0wi7AFKNinogUy5VXKvI5QBzM5lqVKGdtdbA==
X-Received: by 2002:a05:6a00:6:b029:305:4ab6:90ba with SMTP id h6-20020a056a000006b02903054ab690bamr26296699pfk.1.1625103515221;
        Wed, 30 Jun 2021 18:38:35 -0700 (PDT)
Received: from localhost.localdomain ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id 194sm837936pfy.51.2021.06.30.18.38.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jun 2021 18:38:34 -0700 (PDT)
From:   Bing Fan <hptsfb@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] arm pl011 serial: support multi-irq request
Date:   Thu,  1 Jul 2021 09:38:32 +0800
Message-Id: <1625103512-30182-1-git-send-email-hptsfb@gmail.com>
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
 drivers/tty/serial/amba-pl011.c | 34 ++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 78682c12156a..7bfe8efcc787 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1701,11 +1701,39 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 	}
 }
 
+static void pl011_release_irq(struct uart_amba_port *uap, unsigned int max_cnt)
+{
+	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
+	int i;
+
+	for (i = 0; i < max_cnt; i++)
+		if (amba_dev->irq[i])
+			free_irq(amba_dev->irq[i], uap);
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
@@ -1864,7 +1892,7 @@ static void pl011_shutdown(struct uart_port *port)
 
 	pl011_dma_shutdown(uap);
 
-	free_irq(uap->port.irq, uap);
+	pl011_release_irq(uap, AMBA_NR_IRQS);
 
 	pl011_disable_uart(uap);
 
@@ -1894,7 +1922,7 @@ static void sbsa_uart_shutdown(struct uart_port *port)
 
 	pl011_disable_interrupts(uap);
 
-	free_irq(uap->port.irq, uap);
+	pl011_release_irq(uap, AMBA_NR_IRQS);
 
 	if (uap->port.ops->flush_buffer)
 		uap->port.ops->flush_buffer(port);
-- 
2.17.1

