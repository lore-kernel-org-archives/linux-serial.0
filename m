Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0CBC49361
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4584B611CD
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhFRGSu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhFRGRz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 14BBE21B71;
        Fri, 18 Jun 2021 06:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+K4baIdwzbGwVzO2UC58euL9O9XT1UtzNqp38qQmGWE=;
        b=f8PcGgXu/M1QtU56SE9vDXjiJKfKOdHf4rIzDX/xKE74lh2HGVPZ2eSd2EmSN3d9lFKvHp
        9LOPMJRgPV5E6dVCzWJmeGB0TC1w10pU42EtbMN71XIxlGOQA/JPCWQTFkIgxWj6M4TWvt
        MOKwXqkhTx3DCcYn3jK5LhaeEFoWPTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+K4baIdwzbGwVzO2UC58euL9O9XT1UtzNqp38qQmGWE=;
        b=Khp9RyvMi6nLpmTORDCGRQ53KR15fkjPYKOcvMhmjf+rVZWhxaw7bC51BIHH9YNINaasFs
        T6Tk6nAnWxgELTBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E36F5A3B9F;
        Fri, 18 Jun 2021 06:15:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 56/70] mxser: cleanup mxser_dtr_rts
Date:   Fri, 18 Jun 2021 08:15:02 +0200
Message-Id: <20210618061516.662-57-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mxser_dtr_rts now does all inb, outb, & or | in a single statement.  The
code is hard to follow, so make it more readable by doing one-line =
one-statement.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 5789c4343f10..daf820c086f4 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -428,14 +428,15 @@ static void mxser_dtr_rts(struct tty_port *port, int on)
 {
 	struct mxser_port *mp = container_of(port, struct mxser_port, port);
 	unsigned long flags;
+	u8 mcr;
 
 	spin_lock_irqsave(&mp->slock, flags);
+	mcr = inb(mp->ioaddr + UART_MCR);
 	if (on)
-		outb(inb(mp->ioaddr + UART_MCR) |
-			UART_MCR_DTR | UART_MCR_RTS, mp->ioaddr + UART_MCR);
+		mcr |= UART_MCR_DTR | UART_MCR_RTS;
 	else
-		outb(inb(mp->ioaddr + UART_MCR)&~(UART_MCR_DTR | UART_MCR_RTS),
-			mp->ioaddr + UART_MCR);
+		mcr &= ~(UART_MCR_DTR | UART_MCR_RTS);
+	outb(mcr, mp->ioaddr + UART_MCR);
 	spin_unlock_irqrestore(&mp->slock, flags);
 }
 
-- 
2.32.0

