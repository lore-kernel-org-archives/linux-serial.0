Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D5DC49EA4
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C82A61154
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhFRGRm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhFRGR2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2330C21B52;
        Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxosIp5dp9pyQOqp1juxUY2HNSyClmwSRVJeLU3fHhE=;
        b=QbxTDRwajfAt03H9pg6X5iYRGk3kBZygAVycKrw1A+x0XLWzmc6bUad4iCvG2cekfzGo96
        uD9VMVyBvTzPCMoWUa1T4pVnkF/V0xksOKy0s4D6J/XSbzA910GNGHwD/4tKIknE8hhlhd
        JksQwLHZs4txLRHThfDy3WBfVH89OOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxosIp5dp9pyQOqp1juxUY2HNSyClmwSRVJeLU3fHhE=;
        b=O8AuCyrn7RKguj5bZC0erzy94tQjbTKMUnRUrzxXwbF3iGG0kF/idzj6Pg1PUhYw96WArw
        Zl579dLJYpqyjbBA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F2516A3B99;
        Fri, 18 Jun 2021 06:15:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/70] mxser: drop constant board::uart_type
Date:   Fri, 18 Jun 2021 08:14:15 +0200
Message-Id: <20210618061516.662-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

board::uart_type is always set to PORT_16550A. So, use this constant in
the code instead. And drop the mxser_board member.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 558bd4140ee1..a6121fea7a55 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -372,7 +372,6 @@ struct mxser_board {
 	unsigned long vector_mask;
 
 	enum mxser_must_hwid must_hwid;
-	int uart_type;
 
 	struct mxser_port ports[MXSER_PORTS_PER_BOARD];
 };
@@ -2361,7 +2360,7 @@ static int mxser_initbrd(struct mxser_board *brd)
 		if (brd->must_hwid != MOXA_OTHER_UART)
 			mxser_enable_must_enchance_mode(info->ioaddr);
 
-		info->type = brd->uart_type;
+		info->type = PORT_16550A;
 
 		process_txrx_fifo(info);
 
@@ -2454,7 +2453,6 @@ static int mxser_probe(struct pci_dev *pdev,
 	brd->irq = pdev->irq;
 
 	brd->must_hwid = mxser_must_get_hwid(brd->ports[0].ioaddr);
-	brd->uart_type = PORT_16550A;
 	brd->vector_mask = 0;
 
 	for (i = 0; i < brd->info->nports; i++) {
-- 
2.32.0

