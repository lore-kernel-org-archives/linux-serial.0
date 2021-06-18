Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402EAC49EA5
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22353611CD
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhFRGS4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47228 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhFRGRz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 982EE1FE0B;
        Fri, 18 Jun 2021 06:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4iMzWqsiH2FEa13Mieof0vval3USLIYyoGx4LCtHrA=;
        b=NeXs5VxDqCIxfk/qB2d1xcio2WzFHwu9hNXl3Ag9uVVM3p6iV8n/5HC4h6iHh1HKa5tURH
        kdyQbKYNjsodGF/T13DQuhHUnfY0TMgOuwLDD9m9TeCxdpnmJdW2oFqEKRUyrAAvvuFM/+
        +6GAbYky5XPvu+jEKDGbybyE+wySIxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4iMzWqsiH2FEa13Mieof0vval3USLIYyoGx4LCtHrA=;
        b=SNC3G7LG9PpOG1Xk37sfQ7xvMThuRKf1jB5XOirmDrk5eGbxGxNK2NOJEywgfpxdWrDqJY
        xn1fIoyKdBzA3yCQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6FEE5A3BB2;
        Fri, 18 Jun 2021 06:15:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 44/70] mxser: inline mxser_board_remove into mxser_remove
Date:   Fri, 18 Jun 2021 08:14:50 +0200
Message-Id: <20210618061516.662-45-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The only user of mxser_board_remove is mxser_remove. Move there those
few lines.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 3b20eb96d788..196750676400 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1953,17 +1953,6 @@ static int mxser_initbrd(struct mxser_board *brd)
 	return retval;
 }
 
-static void mxser_board_remove(struct mxser_board *brd)
-{
-	unsigned int i;
-
-	for (i = 0; i < brd->info->nports; i++) {
-		tty_unregister_device(mxvar_sdriver, brd->idx + i);
-		tty_port_destroy(&brd->ports[i].port);
-	}
-	free_irq(brd->irq, brd);
-}
-
 static int mxser_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
@@ -2053,8 +2042,14 @@ static int mxser_probe(struct pci_dev *pdev,
 static void mxser_remove(struct pci_dev *pdev)
 {
 	struct mxser_board *brd = pci_get_drvdata(pdev);
+	unsigned int i;
+
+	for (i = 0; i < brd->info->nports; i++) {
+		tty_unregister_device(mxvar_sdriver, brd->idx + i);
+		tty_port_destroy(&brd->ports[i].port);
+	}
 
-	mxser_board_remove(brd);
+	free_irq(brd->irq, brd);
 
 	pci_release_region(pdev, 2);
 	pci_release_region(pdev, 3);
-- 
2.32.0

