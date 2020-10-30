Return-Path: <SRS0=xb/S=EF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17291C4363A
	for <linux-serial@archiver.kernel.org>; Fri, 30 Oct 2020 13:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D822076E
	for <linux-serial@archiver.kernel.org>; Fri, 30 Oct 2020 13:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgJ3NnW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Oct 2020 09:43:22 -0400
Received: from out28-77.mail.aliyun.com ([115.124.28.77]:37977 "EHLO
        out28-77.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgJ3NnW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Oct 2020 09:43:22 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1107079|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0265387-0.00197939-0.971482;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.IqYD0cV_1604065398;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.IqYD0cV_1604065398)
          by smtp.aliyun-inc.com(10.194.99.38);
          Fri, 30 Oct 2020 21:43:18 +0800
From:   Liu Xiang <liuxiang_1999@126.com>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, Liu Xiang <liuxiang_1999@126.com>
Subject: [PATCH] tty: serial: linflexuart: Remove unnecessary '|' operation and add error count
Date:   Fri, 30 Oct 2020 21:43:11 +0800
Message-Id: <1604065391-3790-1-git-send-email-liuxiang_1999@126.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The '|' operation of status in linflex_rxint is unnecessary,
so it can be removed.

Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 3e28be4..d870480 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -252,23 +252,22 @@ static irqreturn_t linflex_rxint(int irq, void *dev_id)
 		flg = TTY_NORMAL;
 		sport->icount.rx++;
 
-		if (status & (LINFLEXD_UARTSR_BOF | LINFLEXD_UARTSR_SZF |
-			      LINFLEXD_UARTSR_FEF | LINFLEXD_UARTSR_PE)) {
-			if (status & LINFLEXD_UARTSR_SZF)
-				status |= LINFLEXD_UARTSR_SZF;
+		if (status & (LINFLEXD_UARTSR_BOF | LINFLEXD_UARTSR_FEF |
+				LINFLEXD_UARTSR_PE)) {
 			if (status & LINFLEXD_UARTSR_BOF)
-				status |= LINFLEXD_UARTSR_BOF;
+				sport->icount.overrun++;
 			if (status & LINFLEXD_UARTSR_FEF) {
-				if (!rx)
+				if (!rx) {
 					brk = true;
-				status |= LINFLEXD_UARTSR_FEF;
+					sport->icount.brk++;
+				} else
+					sport->icount.frame++;
 			}
 			if (status & LINFLEXD_UARTSR_PE)
-				status |=  LINFLEXD_UARTSR_PE;
+				sport->icount.parity++;
 		}
 
-		writel(status | LINFLEXD_UARTSR_RMB | LINFLEXD_UARTSR_DRFRFE,
-		       sport->membase + UARTSR);
+		writel(status, sport->membase + UARTSR);
 		status = readl(sport->membase + UARTSR);
 
 		if (brk) {
-- 
1.9.1

