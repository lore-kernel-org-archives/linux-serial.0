Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67DCC433E0
	for <linux-serial@archiver.kernel.org>; Sat, 13 Mar 2021 07:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D33464F19
	for <linux-serial@archiver.kernel.org>; Sat, 13 Mar 2021 07:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhCMHsj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 13 Mar 2021 02:48:39 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:35406 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhCMHse (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Mar 2021 02:48:34 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 1AA7A40015C;
        Sat, 13 Mar 2021 15:48:32 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Andrij Abyzov <aabyzov@slb.com>, Wang Qing <wangqing@vivo.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: 8250: delete redundant printing of return value
Date:   Sat, 13 Mar 2021 15:48:26 +0800
Message-Id: <1615621707-2330-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSEwZTEofGBodTklNVkpNSk5NSUpMSklPSkxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTo6Tio5CT8LD1FWVh8fCRw6
        Kz0wFDJVSlVKTUpOTUlKTEpJTE5CVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTENKNwY+
X-HM-Tid: 0a782a8ee9d4d991kuws1aa7a40015c
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

platform_get_irq() has already checked and printed the return value, 
the printing here is nothing special, it is not necessary at all.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/tty/serial/8250/8250_fsl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index fbcc90c..cd19400
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -104,11 +104,8 @@ static int fsl8250_acpi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "cannot get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	memset(&port8250, 0, sizeof(port8250));
 
-- 
2.7.4

