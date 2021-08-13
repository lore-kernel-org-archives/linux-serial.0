Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B3C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 16:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2AC9610EA
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 16:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhHMQdc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:33:32 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:2797 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235727AbhHMQdb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 12:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628872384; x=1660408384;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M1JuyTv8KH3zNhU0+oltIbZZxsxagglNMDA/3NkorWs=;
  b=p+kk4/xr+mUt+FWkaZTdmmVpjB31wdEP70/Vo01e+7Tnrazu4VjsVZs9
   z4nt6Y6gSEWdiE2LxU/m4GrQf99lSD+QxphaQ9BAHJ2wa5TRMWuPwJznP
   Sn90QmVJR38akaoh8lrTEikERMnJKYVmR3KY/2Ejn16BP24nGJevqZdQ3
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Aug 2021 09:33:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 09:32:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.15; Fri, 13 Aug 2021 09:32:55 -0700
Received: from QIANCAI.na.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.858.15; Fri, 13 Aug 2021 09:32:54 -0700
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Bing Fan <hptsfb@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] Revert "arm pl011 serial: support multi-irq request"
Date:   Fri, 13 Aug 2021 12:31:35 -0400
Message-ID: <20210813163135.205-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03d.na.qualcomm.com (10.85.0.91) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit b0819465be8be0c76af15436a9e6db4dab4c196e which
results in amba_device-specific code being called from
sbsa_uart_startup() and sbsa_uart_shutdown().

Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 drivers/tty/serial/amba-pl011.c | 34 +++------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cf6ff229e267..d361cd84ff8c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1777,39 +1777,11 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 	}
 }
 
-static void pl011_release_irq(struct uart_amba_port *uap, unsigned int max_cnt)
-{
-	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
-	int i;
-
-	for (i = 0; i < max_cnt; i++)
-		if (amba_dev->irq[i])
-			free_irq(amba_dev->irq[i], uap);
-}
-
 static int pl011_allocate_irq(struct uart_amba_port *uap)
 {
-	int ret = 0;
-	int i;
-	unsigned int virq;
-	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
-
 	pl011_write(uap->im, uap, REG_IMSC);
 
-	for (i = 0; i < AMBA_NR_IRQS; i++) {
-		virq = amba_dev->irq[i];
-		if (virq == 0)
-			break;
-
-		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);
-		if (ret) {
-			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
-			pl011_release_irq(uap, i - 1);
-			break;
-		}
-	}
-
-	return ret;
+	return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011", uap);
 }
 
 /*
@@ -1981,7 +1953,7 @@ static void pl011_shutdown(struct uart_port *port)
 	if ((port->rs485.flags & SER_RS485_ENABLED) && uap->rs485_tx_started)
 		pl011_rs485_tx_stop(uap);
 
-	pl011_release_irq(uap, AMBA_NR_IRQS);
+	free_irq(uap->port.irq, uap);
 
 	pl011_disable_uart(uap);
 
@@ -2011,7 +1983,7 @@ static void sbsa_uart_shutdown(struct uart_port *port)
 
 	pl011_disable_interrupts(uap);
 
-	pl011_release_irq(uap, AMBA_NR_IRQS);
+	free_irq(uap->port.irq, uap);
 
 	if (uap->port.ops->flush_buffer)
 		uap->port.ops->flush_buffer(port);
-- 
2.25.1

