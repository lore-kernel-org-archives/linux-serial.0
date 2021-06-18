Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B35C49EA2
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0905C6120A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhFRGTO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:19:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47304 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhFRGR5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6B5971FE01;
        Fri, 18 Jun 2021 06:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyqk0DCGDyTr9Xsn3kqVsodTh5mdxcBNmSaiXNNpM1c=;
        b=TVEVfu31MNdEODJCqggzAoro6UEnL7RelE53/jsGuESQ4irL3YvFOTGrWjFZkAsBQoAStc
        NOKkyeDf6GPGXteHZ2W5OMK6/3BUUeuWDqxWi0I3xRzoTFStSf+r2qvgBNqM9h1lByJpFq
        hyTfmciHTLvvkcH0UOIQ6JFjMWXPspI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyqk0DCGDyTr9Xsn3kqVsodTh5mdxcBNmSaiXNNpM1c=;
        b=VzcEBp9w9HaDzF9KIYAKDXG+bouNsjF79HLT/MfVSAHTtiQI/j/d63Tc6N/yDiqOMWxhHQ
        bZJeoa7QfGiiqKAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4697CA3BA2;
        Fri, 18 Jun 2021 06:15:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 53/70] mxser: alloc only needed # of ports
Date:   Fri, 18 Jun 2021 08:14:59 +0200
Message-Id: <20210618061516.662-54-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Many boards have only 2 ports. But we always allocate 8 ports (struct
mxser_port) in each struct mxser_board.

Switch this to an empty/variable sized array ([]) and allocate the
needed number of ports using struct_size helper in ->probe.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 0e99225e260f..81e2b72fca3f 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -275,7 +275,7 @@ struct mxser_board {
 	enum mxser_must_hwid must_hwid;
 	speed_t max_baud;
 
-	struct mxser_port ports[MXSER_PORTS_PER_BOARD];
+	struct mxser_port ports[];
 };
 
 static DECLARE_BITMAP(mxser_boards, MXSER_BOARDS);
@@ -1923,7 +1923,8 @@ static int mxser_probe(struct pci_dev *pdev,
 		goto err;
 	}
 
-	brd = devm_kzalloc(&pdev->dev, sizeof(*brd), GFP_KERNEL);
+	brd = devm_kzalloc(&pdev->dev, struct_size(brd, ports, nports),
+			GFP_KERNEL);
 	if (!brd)
 		goto err;
 
-- 
2.32.0

