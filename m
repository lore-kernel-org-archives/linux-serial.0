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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26FFC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 03:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36366109E
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 03:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbhHMDcA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 23:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbhHMDb7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 23:31:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBD1C061756;
        Thu, 12 Aug 2021 20:31:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e19so10086911pla.10;
        Thu, 12 Aug 2021 20:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rKxkk1OGoYLIBCFaY2z2KhD/DQkY6T8I7zVzhchtmnQ=;
        b=uIvMPinvSOI6li292hHx6mgL1Cvq6feCCTJR8F/XKxVNkxn8J6Q5lvwud2TiFC/be9
         Jo+JQUcC9n6btS8i/Bb+fJ09TMlOIe8ZAoy1Md8FAU4w5yoij+qxCiGM2VCZ1w3pOPFY
         QZEZI4+tF8sUSRwKqidOuyn3Gpk9i1sHn3NAne3VUQuJVlSZpGfi0cLHlJc6g7KmWUKJ
         6demgcu2NSzFLglg6VjqiySFweqIOZteouOJQvTONI/0Coe9yvLOE97RJhTaQmneseKO
         O03teI9DQ5OSjqcZRSILJswKQBCbk0QcbOe1MsII37Elmp3jOnZ+lTfyvLkXc/rFUKz5
         gs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rKxkk1OGoYLIBCFaY2z2KhD/DQkY6T8I7zVzhchtmnQ=;
        b=itxa/wepoXVqO/SS9zKt+P/iVZk9V9aeV5Xe/+ITX9cX4rcYIr5UroOLsMEudAeyem
         f6jgS8cBD1tl0vlTW+xPN6MC3KH8dE12/NvILUW140CpAXaiGD24qg5mcGrvSf7mVR31
         q7XzFzKVOSy/CXDJfoBG4vA9f4Kfuu9Laywn9xrm4+tsMdBLcm+vEXViEyWA9w+SZBz+
         bg59OPjaIWBZ80Fp2Iq6gaaVBN/8kj6VdSxv/8Jy10OnYTPFtNmV44ZTmVasdFAKsIq6
         G1VFYk7H7kSFPBdqJ1mKqAgokp6fjo7g5VUvxIu3TFNBSGdKRZxktGEbY8ePIH2oCZu3
         JTLg==
X-Gm-Message-State: AOAM532iBU2x1gt0j1Z4D6sn0aAeET4nJVETbI03rsb4bfwXaQoOI0FO
        9p0cXRjpjqRTih4u3uEUsCkKcHqeujEF2HCG
X-Google-Smtp-Source: ABdhPJzJucFmDBDGxN1ed9G6xFCh9M14DT4TYxWxlCY1Eu5QFB4Jy8lY31YKEKYgjAsA6hlRd62TEw==
X-Received: by 2002:a63:6c5:: with SMTP id 188mr345143pgg.39.1628825492871;
        Thu, 12 Aug 2021 20:31:32 -0700 (PDT)
Received: from localhost.localdomain ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id 4sm203125pjb.21.2021.08.12.20.31.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Aug 2021 20:31:32 -0700 (PDT)
From:   Bing Fan <hptsfb@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] arm pl011 serial: support multi-irq request
Date:   Fri, 13 Aug 2021 11:31:30 +0800
Message-Id: <1628825490-18937-1-git-send-email-hptsfb@gmail.com>
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
 drivers/tty/serial/amba-pl011.c | 39 +++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e14f3378b8a0..eaac3431459c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1701,6 +1701,41 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 	}
 }
 
+static void pl011_release_multi_irqs(struct uart_amba_port *uap, unsigned int max_cnt)
+{
+	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
+	int i;
+
+	for (i = 0; i < max_cnt; i++)
+		if (amba_dev->irq[i])
+			free_irq(amba_dev->irq[i], uap);
+}
+
+static int pl011_allocate_multi_irqs(struct uart_amba_port *uap)
+{
+	int ret = 0;
+	int i;
+	unsigned int virq;
+	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
+
+	pl011_write(uap->im, uap, REG_IMSC);
+
+	for (i = 0; i < AMBA_NR_IRQS; i++) {
+		virq = amba_dev->irq[i];
+		if (virq == 0)
+			break;
+
+		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);
+		if (ret) {
+			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
+			pl011_release_multi_irqs(uap, i - 1);
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static int pl011_allocate_irq(struct uart_amba_port *uap)
 {
 	pl011_write(uap->im, uap, REG_IMSC);
@@ -1753,7 +1788,7 @@ static int pl011_startup(struct uart_port *port)
 	if (retval)
 		goto clk_dis;
 
-	retval = pl011_allocate_irq(uap);
+	retval = pl011_allocate_multi_irqs(uap);
 	if (retval)
 		goto clk_dis;
 
@@ -1864,7 +1899,7 @@ static void pl011_shutdown(struct uart_port *port)
 
 	pl011_dma_shutdown(uap);
 
-	free_irq(uap->port.irq, uap);
+	pl011_release_multi_irqs(uap, AMBA_NR_IRQS);
 
 	pl011_disable_uart(uap);
 
-- 
2.17.1

