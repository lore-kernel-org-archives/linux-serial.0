Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96818C48BE8
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A986120A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhFRGRs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59036 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhFRGRa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 216AA21B51;
        Fri, 18 Jun 2021 06:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1slZ3qSkLzaics74bWzedOlvybCAvig1qgHYjIlKIGo=;
        b=aUxqVovw+TrQNa4tDWZpC4KUwyaR8x15tBVt5o7LP7NvyuaJLvD8Irg8PWmFfYhebEeZKS
        WmDOiPkVqVZ1tOQfWedeB1KKKayteSKlJZzxI5S2a4tpHNAH5j3+rVWkwvgHQ8k8Svl98P
        ifaQenKaHGODPC6vTZ81IrOI1ZbjdL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1slZ3qSkLzaics74bWzedOlvybCAvig1qgHYjIlKIGo=;
        b=isrEqdEyx9AiExP6wC070BB1GdQkfNe+f0VlsT9sJAQs2g/Ez1SJ0nDLYbb+rP0ZsO9T7O
        6Yxi5XdL9pVLesBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EE4E1A3BBA;
        Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 14/70] mxser: simplify mxser_interrupt and drop mxser_board::vector_mask
Date:   Fri, 18 Jun 2021 08:14:20 +0200
Message-Id: <20210618061516.662-15-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mxser_board::vector_mask is just a bitfield with bits set for all
available ports.  We can obtain this value simply by
"BIT(brd->info->nports) - 1" directly in the ISR. So remove vector_mask
and simplify the code a bit.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 555b9b37b52f..df59ca88acab 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -368,7 +368,6 @@ struct mxser_board {
 	int irq;
 	const struct mxser_cardinfo *info;
 	unsigned long vector;
-	unsigned long vector_mask;
 
 	enum mxser_must_hwid must_hwid;
 	speed_t max_baud;
@@ -2273,18 +2272,18 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 	struct mxser_board *brd = dev_id;
 	struct mxser_port *port;
 	unsigned int int_cnt, pass_counter = 0;
-	int max, irqbits, bits, i;
+	unsigned int i, max = brd->info->nports;
 	int handled = IRQ_NONE;
+	u8 irqbits, bits, mask = BIT(max) - 1;
 
-	max = brd->info->nports;
 	while (pass_counter++ < MXSER_ISR_PASS_LIMIT) {
-		irqbits = inb(brd->vector) & brd->vector_mask;
-		if (irqbits == brd->vector_mask)
+		irqbits = inb(brd->vector) & mask;
+		if (irqbits == mask)
 			break;
 
 		handled = IRQ_HANDLED;
 		for (i = 0, bits = 1; i < max; i++, irqbits |= bits, bits <<= 1) {
-			if (irqbits == brd->vector_mask)
+			if (irqbits == mask)
 				break;
 			if (bits & irqbits)
 				continue;
@@ -2450,7 +2449,6 @@ static int mxser_probe(struct pci_dev *pdev,
 	brd->irq = pdev->irq;
 
 	brd->must_hwid = mxser_must_get_hwid(brd->ports[0].ioaddr);
-	brd->vector_mask = 0;
 
 	for (j = 0; j < UART_INFO_NUM; j++) {
 		if (Gpci_uart_info[j].type == brd->must_hwid) {
@@ -2475,7 +2473,6 @@ static int mxser_probe(struct pci_dev *pdev,
 	}
 
 	for (i = 0; i < brd->info->nports; i++) {
-		brd->vector_mask |= (1 << i);
 		brd->ports[i].baud_base = 921600;
 	}
 
-- 
2.32.0

