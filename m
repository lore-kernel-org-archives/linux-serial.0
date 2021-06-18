Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC36C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20016112D
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhFRGSu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59682 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhFRGRz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 423F221B60;
        Fri, 18 Jun 2021 06:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EqNNoy5B0+kzzFl6xKjMTy0sA1jN2I6miCofIcPPE0=;
        b=eKadvXaVxpM7H2Uu7SvDEFzJ4toF2x8Ssw3d265EZ4u1CsGg5NAQ+jOKTSVjsDI3ZpfJba
        tro1R0HcxMP9g5iYQK6G56LOrkVmIOVgTdCSbsd11hccnF/9SDXO90cMyN32S5OZrLVhwV
        HDLrHtrIrYDwAPmtHMQJhG4oNKOm8Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EqNNoy5B0+kzzFl6xKjMTy0sA1jN2I6miCofIcPPE0=;
        b=f9nTa/lwGDDDLnhr+4J5A/TuUZf/vFkoH2yrt5FqFXY+talWljfnbk44bpfG+CSbRwpZ4T
        WkV+PslwmBwD5xDQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1A749A3B9F;
        Fri, 18 Jun 2021 06:15:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 52/70] mxser: alloc struct mxser_board dynamically
Date:   Fri, 18 Jun 2021 08:14:58 +0200
Message-Id: <20210618061516.662-53-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no need to preallocate an array of four struct mxser_board's.
In most cases a single board or two will be present in a machine. So
allocate struct mxser_board as needed in ->probe.

This makes mxser_boards a bit array. There we store which indexes are
free (unallocated).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 30b3a5ab6bea..0e99225e260f 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -278,7 +278,7 @@ struct mxser_board {
 	struct mxser_port ports[MXSER_PORTS_PER_BOARD];
 };
 
-static struct mxser_board mxser_boards[MXSER_BOARDS];
+static DECLARE_BITMAP(mxser_boards, MXSER_BOARDS);
 static struct tty_driver *mxvar_sdriver;
 
 static u8 __mxser_must_set_EFR(unsigned long baseio, u8 clear, u8 set,
@@ -1916,31 +1916,32 @@ static int mxser_probe(struct pci_dev *pdev,
 	struct device *tty_dev;
 	int retval = -EINVAL;
 
-	for (i = 0; i < MXSER_BOARDS; i++)
-		if (mxser_boards[i].nports == 0)
-			break;
-
+	i = find_first_zero_bit(mxser_boards, MXSER_BOARDS);
 	if (i >= MXSER_BOARDS) {
 		dev_err(&pdev->dev, "too many boards found (maximum %d), board "
 				"not configured\n", MXSER_BOARDS);
 		goto err;
 	}
 
-	brd = &mxser_boards[i];
+	brd = devm_kzalloc(&pdev->dev, sizeof(*brd), GFP_KERNEL);
+	if (!brd)
+		goto err;
+
 	brd->idx = i;
+	__set_bit(brd->idx, mxser_boards);
 	base = i * MXSER_PORTS_PER_BOARD;
 
 	retval = pcim_enable_device(pdev);
 	if (retval) {
 		dev_err(&pdev->dev, "PCI enable failed\n");
-		goto err;
+		goto err_zero;
 	}
 
 	/* io address */
 	ioaddress = pci_resource_start(pdev, 2);
 	retval = pci_request_region(pdev, 2, "mxser(IO)");
 	if (retval)
-		goto err;
+		goto err_zero;
 
 	brd->nports = nports;
 	for (i = 0; i < nports; i++)
@@ -1984,7 +1985,7 @@ static int mxser_probe(struct pci_dev *pdev,
 	for (i = 0; i < nports; i++)
 		tty_port_destroy(&brd->ports[i].port);
 err_zero:
-	brd->nports = 0;
+	__clear_bit(brd->idx, mxser_boards);
 err:
 	return retval;
 }
@@ -1999,7 +2000,7 @@ static void mxser_remove(struct pci_dev *pdev)
 		tty_port_destroy(&brd->ports[i].port);
 	}
 
-	brd->nports = 0;
+	__clear_bit(brd->idx, mxser_boards);
 }
 
 static struct pci_driver mxser_driver = {
-- 
2.32.0

