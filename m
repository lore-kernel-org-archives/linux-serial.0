Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5DCC4338F
	for <linux-serial@archiver.kernel.org>; Sat, 14 Aug 2021 13:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B01F60551
	for <linux-serial@archiver.kernel.org>; Sat, 14 Aug 2021 13:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbhHNNPv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 14 Aug 2021 09:15:51 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:20348 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbhHNNO5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 14 Aug 2021 09:14:57 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96117c17fa0c-8ce31; Sat, 14 Aug 2021 21:13:38 +0800 (CST)
X-RM-TRANSID: 2ee96117c17fa0c-8ce31
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.250.151])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56117c17dce6-27868;
        Sat, 14 Aug 2021 21:13:37 +0800 (CST)
X-RM-TRANSID: 2ee56117c17dce6-27868
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] serial: stm32: use devm_platform_get_and_ioremap_resource()
Date:   Sat, 14 Aug 2021 21:14:18 +0800
Message-Id: <20210814131418.13608-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify code.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/tty/serial/stm32-usart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 090822cd1..d4ea86e28 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1064,8 +1064,7 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 				      &stm32port->txftcfg);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	port->membase = devm_ioremap_resource(&pdev->dev, res);
+	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(port->membase))
 		return PTR_ERR(port->membase);
 	port->mapbase = res->start;
-- 
2.20.1.windows.1



