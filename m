Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C7C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F257F611CD
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhFRGTC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:19:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbhFRGR5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D60BD1FE06;
        Fri, 18 Jun 2021 06:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSEl8JeZsPc4N7k8UmKtUhJ1wPYAFzh/UljyKTXN5ng=;
        b=dnE3rGQgusC6UzsIbk0sBJVuuhepWX5CEILww3uB23yLVdmxrmWmlmcjuPXk95ZSVkl22k
        ItetLvkgb5NfMv3oFefWGvuNF8YUOcQECJJgZNqJSIdpCoWJho8rz+jFmEdSlzFzX7+j+p
        /7RdaPS440OKEBuH9eqMVF0ewYieA8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSEl8JeZsPc4N7k8UmKtUhJ1wPYAFzh/UljyKTXN5ng=;
        b=uVi0OmdSjNNCmH8xQRg+OFFsXDd2sISEuWQ5IFKrYL9qoT1LjUfe8Jr0SaTUyx4PPoRdzv
        DRcUe9qsvJ5dXfBA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ABD5BA3BA6;
        Fri, 18 Jun 2021 06:15:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 55/70] mxser: cleanup mxser_rs_break
Date:   Fri, 18 Jun 2021 08:15:01 +0200
Message-Id: <20210618061516.662-56-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mxser_rs_break now does all inb, outb, & or | in a single statement. The
code is hard to follow, so make it more readable by doing one-line =
one-statement.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index e5f8d08de8fd..5789c4343f10 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1553,15 +1553,17 @@ static int mxser_rs_break(struct tty_struct *tty, int break_state)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
+	u8 lcr;
 
 	spin_lock_irqsave(&info->slock, flags);
+	lcr = inb(info->ioaddr + UART_LCR);
 	if (break_state == -1)
-		outb(inb(info->ioaddr + UART_LCR) | UART_LCR_SBC,
-			info->ioaddr + UART_LCR);
+		lcr |= UART_LCR_SBC;
 	else
-		outb(inb(info->ioaddr + UART_LCR) & ~UART_LCR_SBC,
-			info->ioaddr + UART_LCR);
+		lcr &= ~UART_LCR_SBC;
+	outb(lcr, info->ioaddr + UART_LCR);
 	spin_unlock_irqrestore(&info->slock, flags);
+
 	return 0;
 }
 
-- 
2.32.0

