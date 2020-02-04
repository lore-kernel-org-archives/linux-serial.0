Return-Path: <SRS0=wW49=3Y=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286BCC2D0B1
	for <linux-serial@archiver.kernel.org>; Tue,  4 Feb 2020 11:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059C420730
	for <linux-serial@archiver.kernel.org>; Tue,  4 Feb 2020 11:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgBDLjY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:39:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:51638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgBDLjY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Feb 2020 06:39:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D683DB13C;
        Tue,  4 Feb 2020 11:39:22 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Paul Burton <paulburton@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_ioc3: Fix ioremap call
Date:   Tue,  4 Feb 2020 12:39:12 +0100
Message-Id: <20200204113912.14048-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 4bdc0d676a64 ("remove ioremap_nocache and devm_ioremap_nocache")
removed devm_ioremap_nocache, but 8250_ioc3 wasn't upstream at that
time. So fix 8250_ioc3 by using devm_ioremap.

Fixes: 0ce5ebd24d25 ("mfd: ioc3: Add driver for SGI IOC3 chip")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/tty/serial/8250/8250_ioc3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
index 4c405f1b9c67..d5a39e105a76 100644
--- a/drivers/tty/serial/8250/8250_ioc3.c
+++ b/drivers/tty/serial/8250/8250_ioc3.c
@@ -47,7 +47,7 @@ static int serial8250_ioc3_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	membase = devm_ioremap_nocache(&pdev->dev, r->start, resource_size(r));
+	membase = devm_ioremap(&pdev->dev, r->start, resource_size(r));
 	if (!membase)
 		return -ENOMEM;
 
-- 
2.24.1

