Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5436EC4338F
	for <linux-serial@archiver.kernel.org>; Wed, 11 Aug 2021 11:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F0C60F21
	for <linux-serial@archiver.kernel.org>; Wed, 11 Aug 2021 11:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhHKLBM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Aug 2021 07:01:12 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:53742 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhHKLBM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Aug 2021 07:01:12 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Aug 2021 07:01:11 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46113ab96d18-63d46; Wed, 11 Aug 2021 18:51:02 +0800 (CST)
X-RM-TRANSID: 2ee46113ab96d18-63d46
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66113ab91f32-3a776;
        Wed, 11 Aug 2021 18:51:01 +0800 (CST)
X-RM-TRANSID: 2ee66113ab91f32-3a776
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] serial: stm32: fix the conditional expression writing
Date:   Wed, 11 Aug 2021 18:51:36 +0800
Message-Id: <20210811105136.25392-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In the function stm32_usart_init_port, intent of the code maybe when
irq returns a value of zero, the return should be '-ENODEV'. But the
conditional expression '? :' maybe clerical error, it should be
'?:' to make '-ENODEV' work.
But in fact, as the example in platform.c is
  * int irq = platform_get_irq(pdev, 0);
  * if (irq < 0)
  * return irq;
So the return value of zero is unnecessary to check, at last remove
the unnecessary '?: -ENODEV'.

Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/tty/serial/stm32-usart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ef793b3b4..090822cd1 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1034,8 +1034,8 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 	int ret, irq;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return irq ? : -ENODEV;
+	if (irq < 0)
+		return irq;
 
 	port->iotype	= UPIO_MEM;
 	port->flags	= UPF_BOOT_AUTOCONF;
-- 
2.20.1.windows.1



