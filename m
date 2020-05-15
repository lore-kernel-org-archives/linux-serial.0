Return-Path: <SRS0=qiNw=65=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769A1C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 15 May 2020 13:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE4520657
	for <linux-serial@archiver.kernel.org>; Fri, 15 May 2020 13:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgEONHe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 May 2020 09:07:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45142 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEONHd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 May 2020 09:07:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 25BC11A06F9;
        Fri, 15 May 2020 15:07:32 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BA7571A06CB;
        Fri, 15 May 2020 15:07:29 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 31B13402A6;
        Fri, 15 May 2020 21:07:26 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: Use __maybe_unused instead of #if CONFIG_PM_SLEEP
Date:   Fri, 15 May 2020 20:58:01 +0800
Message-Id: <1589547481-25932-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use __maybe_unused for power management related functions to simplify
the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6a9909e..cca485d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2662,8 +2662,7 @@ static int lpuart_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int lpuart_suspend(struct device *dev)
+static int __maybe_unused lpuart_suspend(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	unsigned long temp;
@@ -2721,7 +2720,7 @@ static int lpuart_suspend(struct device *dev)
 	return 0;
 }
 
-static int lpuart_resume(struct device *dev)
+static int __maybe_unused lpuart_resume(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	bool irq_wake = irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq));
@@ -2752,7 +2751,6 @@ static int lpuart_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(lpuart_pm_ops, lpuart_suspend, lpuart_resume);
 
-- 
2.7.4

