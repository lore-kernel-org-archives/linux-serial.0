Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF00C3F2C6
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 07:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA03920726
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 07:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCCHWh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:22:37 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7364 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgCCHWh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 02:22:37 -0500
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 02:22:35 EST
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e5e035d2c5-c6d2e; Tue, 03 Mar 2020 15:12:30 +0800 (CST)
X-RM-TRANSID: 2ee65e5e035d2c5-c6d2e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.208.44])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5e5e03553e9-cdb48;
        Tue, 03 Mar 2020 15:12:30 +0800 (CST)
X-RM-TRANSID: 2eea5e5e03553e9-cdb48
From:   tangbin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 2/2] tty:serial:mvebu-uart:fix a wrong return
Date:   Tue,  3 Mar 2020 15:13:09 +0800
Message-Id: <20200303071309.17172-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

in this place,the right return should be
return PTR_ERR(),not return -PTR_ERR()

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



