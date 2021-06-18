Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96037C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F1A6120A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhFRGSg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59054 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhFRGRs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6258C21B65;
        Fri, 18 Jun 2021 06:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yA6rnJDBroYZw48I68eobmgJUVc2kvZtUvzdSgX9j4Q=;
        b=Kmjg4V5bc87TBpFNd1/QTbVvVQoEsLIRWGF2NpD/vMr4wgW8VPWn2+huZxoUPtG3XaUOvi
        qIEg2ANJHEi/RR+IdAkiyABPgrMjkh2C4iM6myDJbN7QlRDFwr//BkbEzRyvQF+j9yiDsh
        LD2r6+V1onAAHsQ5qj8QdGB/lJuhvVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yA6rnJDBroYZw48I68eobmgJUVc2kvZtUvzdSgX9j4Q=;
        b=aDo4TKobZ+VBmM5PZZ+HZB8i9RfQSak7K1cQgyp3VLYRO7Ffhpkq6+NBc2uxI0lmBiwBqe
        k8uGfWw2Vxl7FPAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 42E77A3BB2;
        Fri, 18 Jun 2021 06:15:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 43/70] mxser: move board init into mxser_initbrd
Date:   Fri, 18 Jun 2021 08:14:49 +0200
Message-Id: <20210618061516.662-44-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

What's done in ->probe for board is actually its initialization. So move
it to mxser_initbrd where it belongs.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 53 ++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index ff85a6e15d9d..3b20eb96d788 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1888,9 +1888,36 @@ static int mxser_initbrd(struct mxser_board *brd)
 	struct mxser_port *info;
 	unsigned int i;
 	int retval;
+	bool is_mu860;
+
+	brd->must_hwid = mxser_must_get_hwid(brd->ports[0].ioaddr);
+	is_mu860 = brd->must_hwid == MOXA_MUST_MU860_HWID;
+
+	for (i = 0; i < UART_INFO_NUM; i++) {
+		if (Gpci_uart_info[i].type == brd->must_hwid) {
+			brd->max_baud = Gpci_uart_info[i].max_baud;
+
+			/* exception....CP-102 */
+			if (brd->info->flags & MXSER_HIGHBAUD)
+				brd->max_baud = 921600;
+			break;
+		}
+	}
+
+	if (is_mu860) {
+		/* set to RS232 mode by default */
+		outb(0, brd->vector + 4);
+		outb(0, brd->vector + 0x0c);
+	}
 
 	for (i = 0; i < brd->info->nports; i++) {
 		info = &brd->ports[i];
+		if (is_mu860) {
+			if (i < 4)
+				info->opmode_ioaddr = brd->vector + 4;
+			else
+				info->opmode_ioaddr = brd->vector + 0x0c;
+		}
 		tty_port_init(&info->port);
 		info->port.ops = &mxser_port_ops;
 		info->board = brd;
@@ -1941,7 +1968,7 @@ static int mxser_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	struct mxser_board *brd;
-	unsigned int i, j;
+	unsigned int i;
 	unsigned long ioaddress;
 	struct device *tty_dev;
 	int retval = -EINVAL;
@@ -1988,30 +2015,6 @@ static int mxser_probe(struct pci_dev *pdev,
 	/* irq */
 	brd->irq = pdev->irq;
 
-	brd->must_hwid = mxser_must_get_hwid(brd->ports[0].ioaddr);
-
-	for (j = 0; j < UART_INFO_NUM; j++) {
-		if (Gpci_uart_info[j].type == brd->must_hwid) {
-			brd->max_baud = Gpci_uart_info[j].max_baud;
-
-			/* exception....CP-102 */
-			if (brd->info->flags & MXSER_HIGHBAUD)
-				brd->max_baud = 921600;
-			break;
-		}
-	}
-
-	if (brd->must_hwid == MOXA_MUST_MU860_HWID) {
-		for (i = 0; i < brd->info->nports; i++) {
-			if (i < 4)
-				brd->ports[i].opmode_ioaddr = ioaddress + 4;
-			else
-				brd->ports[i].opmode_ioaddr = ioaddress + 0x0c;
-		}
-		outb(0, ioaddress + 4);	/* default set to RS232 mode */
-		outb(0, ioaddress + 0x0c);	/* default set to RS232 mode */
-	}
-
 	/* mxser_initbrd will hook ISR. */
 	retval = mxser_initbrd(brd);
 	if (retval)
-- 
2.32.0

