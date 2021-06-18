Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40DDC48BE8
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB22E611CE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhFRGRp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhFRGR3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8846B21B42;
        Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=leLTXwajvlyeJKw41T/Godr6c8XcW1aFlkn/bziTvjU=;
        b=lvh1VVLSagblL2ZPwb3bDO0wCkdTuYOgYY/kCkE3jnfBsr9l7gtYxPYWJonkVBRKcVZu+B
        10OgHrKAdkww4iG0HxctCxAwX05ASLTrgxIPH6ShL68BY7znQaQ+wirTO/huuwjzaSKXIG
        10b3E/4vPt+xxZ0gCXaEBNRD27ZWJAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=leLTXwajvlyeJKw41T/Godr6c8XcW1aFlkn/bziTvjU=;
        b=kN4iEFd4JNZUPIcgCrOHrS2kWSaPJf+ubPNylzc+H2MzAJptmBO/KEiHo6Nfqsci6GSnLg
        RbrgVpJ5Jyfca9Aw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 61292A3BC8;
        Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/70] mxser: remove nonsense from ISR
Date:   Fri, 18 Jun 2021 08:14:17 +0200
Message-Id: <20210618061516.662-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

request_irq was passed a board. There is no need to check dev_id and/or
find the appropriate board in the ISR. Neither check if board is NULL.
Remove this nonsense.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index db594a64ff00..6602b2741271 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2207,23 +2207,13 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 {
 	int status, iir, i;
-	struct mxser_board *brd = NULL;
+	struct mxser_board *brd = dev_id;
 	struct mxser_port *port;
 	int max, irqbits, bits, msr;
 	unsigned int int_cnt, pass_counter = 0;
 	int handled = IRQ_NONE;
 	struct tty_struct *tty;
 
-	for (i = 0; i < MXSER_BOARDS; i++)
-		if (dev_id == &mxser_boards[i]) {
-			brd = dev_id;
-			break;
-		}
-
-	if (i == MXSER_BOARDS)
-		goto irq_stop;
-	if (brd == NULL)
-		goto irq_stop;
 	max = brd->info->nports;
 	while (pass_counter++ < MXSER_ISR_PASS_LIMIT) {
 		irqbits = inb(brd->vector) & brd->vector_mask;
@@ -2299,7 +2289,6 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 		}
 	}
 
-irq_stop:
 	return handled;
 }
 
-- 
2.32.0

