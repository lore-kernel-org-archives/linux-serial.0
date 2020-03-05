Return-Path: <SRS0=YkBk=4W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D99AC3F2D1
	for <linux-serial@archiver.kernel.org>; Thu,  5 Mar 2020 01:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5961B207FD
	for <linux-serial@archiver.kernel.org>; Thu,  5 Mar 2020 01:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgCEBiE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:38:04 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3533 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgCEBiD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Mar 2020 20:38:03 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55e6057de450-eefeb; Thu, 05 Mar 2020 09:37:34 +0800 (CST)
X-RM-TRANSID: 2ee55e6057de450-eefeb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.208.44])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45e6057da021-e0544;
        Thu, 05 Mar 2020 09:37:34 +0800 (CST)
X-RM-TRANSID: 2ee45e6057da021-e0544
From:   tangbin <tangbin@cmss.chinamobile.com>
To:     jslaby@suse.com
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v2]tty:serial:mvebu-uart:fix a wrong return
Date:   Thu,  5 Mar 2020 09:38:23 +0800
Message-Id: <20200305013823.20976-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--v1------------------------------------
in this place,the right return should be
return PTR_ERR(),not return -PTR_ERR()

--v2------------------------------------
in this place, the function should return a
negative value and the PTR_ERR already returns
a negative,so return -PTR_ERR() is wrong.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index c12a12556..4e9a59071 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -851,7 +851,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 
 	port->membase = devm_ioremap_resource(&pdev->dev, reg);
 	if (IS_ERR(port->membase))
-		return -PTR_ERR(port->membase);
+		return PTR_ERR(port->membase);
 
 	mvuart = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_uart),
 			      GFP_KERNEL);
-- 
2.20.1.windows.1



