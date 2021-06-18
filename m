Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D99AC48BE8
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B5661154
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhFRGSj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60022 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbhFRGRt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 34B9921B68;
        Fri, 18 Jun 2021 06:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Fy+e40HDa05bl2nXX0rRImWiTqxnJ4Lz3oLdTWrgt8=;
        b=A+USDCEK9OQDlD5MmyAIuXWmam2smwh/xIwL28b5iz95dfqSiOvEZJQDiriKf3CfyJgf5w
        3I3oAub/LK1GUSpOqsCW0NgCA03Zhy/A3/6iv9q0V4znbAX7tI9P8mdI5NSzN8VEdoLaxD
        GLC/zFcaNOpumP5RCgdVfT0uVUZR+ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Fy+e40HDa05bl2nXX0rRImWiTqxnJ4Lz3oLdTWrgt8=;
        b=upbi8hC0a/tQ2SnY804gJTKhavGqYy86FKjF99R/v33yTR80xCWU1VjpiTDrIUiqFCA/Sd
        RKFSsu5F9atbe6AQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0CF67A3B9D;
        Fri, 18 Jun 2021 06:15:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 47/70] mxser: remove info message from probe
Date:   Fri, 18 Jun 2021 08:14:53 +0200
Message-Id: <20210618061516.662-48-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is a dev_info in ->probe which prints device's name, bus and slot
numbers. All these can be fetched from the lspci output. So remove this
useless print.

This eliminates the whole mxser_cardinfo::name field.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 56 +++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 83c795acdb19..04a39c1f13bb 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -190,38 +190,37 @@ static const struct {
 #define UART_INFO_NUM	ARRAY_SIZE(Gpci_uart_info)
 
 struct mxser_cardinfo {
-	char *name;
 	unsigned int nports;
 	unsigned int flags;
 };
 
 static const struct mxser_cardinfo mxser_cards[] = {
-/* 0*/	{ "C168H/PCI series",	8, },
-	{ "C104H/PCI series",	4, },
-	{ "CP-132 series",	2, },
-	{ "CP-114 series",	4, },
-	{ "CT-114 series",	4, },
-/* 5*/	{ "CP-102 series",	2, MXSER_HIGHBAUD },
-	{ "CP-104U series",	4, },
-	{ "CP-168U series",	8, },
-	{ "CP-132U series",	2, },
-	{ "CP-134U series",	4, },
-/*10*/	{ "CP-104JU series",	4, },
-	{ "Moxa UC7000 Serial",	8, },		/* RC7000 */
-	{ "CP-118U series",	8, },
-	{ "CP-102UL series",	2, },
-	{ "CP-102U series",	2, },
-/*15*/	{ "CP-118EL series",	8, },
-	{ "CP-168EL series",	8, },
-	{ "CP-104EL series",	4, },
-	{ "CB-108 series",	8, },
-	{ "CB-114 series",	4, },
-/*20*/	{ "CB-134I series",	4, },
-	{ "CP-138U series",	8, },
-	{ "POS-104UL series",	4, },
-	{ "CP-114UL series",	4, },
-	{ "CP-102UF series",	2, },
-/*25*/	{ "CP-112UL series",	2, },
+/* 0*/	{ 8, },
+	{ 4, },
+	{ 2, },
+	{ 4, },
+	{ 4, },
+/* 5*/	{ 2, MXSER_HIGHBAUD },
+	{ 4, },
+	{ 8, },
+	{ 2, },
+	{ 4, },
+/*10*/	{ 4, },
+	{ 8, },		/* RC7000 */
+	{ 8, },
+	{ 2, },
+	{ 2, },
+/*15*/	{ 8, },
+	{ 8, },
+	{ 4, },
+	{ 8, },
+	{ 4, },
+/*20*/	{ 4, },
+	{ 8, },
+	{ 4, },
+	{ 4, },
+	{ 2, },
+/*25*/	{ 2, },
 };
 
 /* driver_data correspond to the lines in the structure above
@@ -1961,9 +1960,6 @@ static int mxser_probe(struct pci_dev *pdev,
 
 	brd = &mxser_boards[i];
 	brd->idx = i * MXSER_PORTS_PER_BOARD;
-	dev_info(&pdev->dev, "found MOXA %s board (BusNo=%d, DevNo=%d)\n",
-		mxser_cards[ent->driver_data].name,
-		pdev->bus->number, PCI_SLOT(pdev->devfn));
 
 	retval = pcim_enable_device(pdev);
 	if (retval) {
-- 
2.32.0

