Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2839C49EA4
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89E06112D
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhFRGSz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47242 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhFRGRz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE6541FDF4;
        Fri, 18 Jun 2021 06:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69VkPmomv6jEhRvNGak5sOcsu55PwvFOz0PO27Q7kMM=;
        b=nWEn5nWD/exF1e7gVvIYwi4GnvkXfwFvEVittcxcAnPVh2uOSYtRlbJDOYFSa/gBsdE9C4
        ntRnNTz18zAGhoaZsUlbPv+a9ZivJ4dqusrq+0KGfa3ywpGPrC8TcupqHebC0ty0MC4oAM
        5ta5KLkFVx1JeKDt3xlvWTUommq6wPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69VkPmomv6jEhRvNGak5sOcsu55PwvFOz0PO27Q7kMM=;
        b=KMgAtb1xCMMfrsnJLx4GDT0YMS1VODpi2GAI2N31QlgiDPA+n8GBb8hgGTpf/B88SsR2vY
        /nnwRys/MCxgGbDg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A12C8A3B9D;
        Fri, 18 Jun 2021 06:15:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 45/70] mxser: pci, switch to managed resources
Date:   Fri, 18 Jun 2021 08:14:51 +0200
Message-Id: <20210618061516.662-46-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Switch to managed resources for PCI using pcim_enable_device.
Regions and device disabling is now taken care of by the core and we
need not unwind. Neither in ->probe, nor in ->remove. That simplifies
the code.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 196750676400..be58ee025180 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1978,7 +1978,7 @@ static int mxser_probe(struct pci_dev *pdev,
 		mxser_cards[ent->driver_data].name,
 		pdev->bus->number, PCI_SLOT(pdev->devfn));
 
-	retval = pci_enable_device(pdev);
+	retval = pcim_enable_device(pdev);
 	if (retval) {
 		dev_err(&pdev->dev, "PCI enable failed\n");
 		goto err;
@@ -1988,7 +1988,7 @@ static int mxser_probe(struct pci_dev *pdev,
 	ioaddress = pci_resource_start(pdev, 2);
 	retval = pci_request_region(pdev, 2, "mxser(IO)");
 	if (retval)
-		goto err_dis;
+		goto err;
 
 	brd->info = &mxser_cards[ent->driver_data];
 	for (i = 0; i < brd->info->nports; i++)
@@ -2007,7 +2007,7 @@ static int mxser_probe(struct pci_dev *pdev,
 	/* mxser_initbrd will hook ISR. */
 	retval = mxser_initbrd(brd);
 	if (retval)
-		goto err_rel3;
+		goto err_zero;
 
 	for (i = 0; i < brd->info->nports; i++) {
 		tty_dev = tty_port_register_device(&brd->ports[i].port,
@@ -2028,13 +2028,8 @@ static int mxser_probe(struct pci_dev *pdev,
 	for (i = 0; i < brd->info->nports; i++)
 		tty_port_destroy(&brd->ports[i].port);
 	free_irq(brd->irq, brd);
-err_rel3:
-	pci_release_region(pdev, 3);
 err_zero:
 	brd->info = NULL;
-	pci_release_region(pdev, 2);
-err_dis:
-	pci_disable_device(pdev);
 err:
 	return retval;
 }
@@ -2051,9 +2046,6 @@ static void mxser_remove(struct pci_dev *pdev)
 
 	free_irq(brd->irq, brd);
 
-	pci_release_region(pdev, 2);
-	pci_release_region(pdev, 3);
-	pci_disable_device(pdev);
 	brd->info = NULL;
 }
 
-- 
2.32.0

