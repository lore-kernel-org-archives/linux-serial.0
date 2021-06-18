Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A37C48BE8
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3908F611CE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhFRGSA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58952 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhFRGRl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DA3AA21B5B;
        Fri, 18 Jun 2021 06:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QicgmRLI5sis+DIc/je8KKnUPtR6F6ZKidUylbbEFPU=;
        b=ZC0SGGyOpkyXdORCLr9hC25cjCxSTJ8keOlc2NLyp/FIwHx7hVG1YVCcNGoBYBk80p+IbR
        qS8CYe7CRpc40xWVwCVck6nm9AfqSV3Oze86ZzyNPLzlbIQo1QgbTzzNXqJFm9PBKMxdSr
        IO6OEAR8QFLvzUDIRnjpZA1KX8QZXg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QicgmRLI5sis+DIc/je8KKnUPtR6F6ZKidUylbbEFPU=;
        b=wvPoB/oipGun8dYOMAlFM+sASIkAPf2EFGDKl7XNt4R4WTduPEJ4XiL06jGXCa1BbO9hdK
        FwjuQzUi3ILTacCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AFE89A3BBA;
        Fri, 18 Jun 2021 06:15:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 22/70] mxser: remove MOXA_GET_MAJOR deprecated ioctl
Date:   Fri, 18 Jun 2021 08:14:28 +0200
Message-Id: <20210618061516.662-23-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

MOXA_GET_MAJOR was deprecated in commit 41aee9a121fd (Char: mxser, ioctl
cleanup) in 2008. Remove this ioctl finally.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index a830a4359ea1..a55b20f98cb3 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -53,7 +53,6 @@
 #define MOXA_GETDATACOUNT	(MOXA + 23)
 #define MOXA_CHKPORTENABLE	(MOXA + 60)
 #define MOXA_HighSpeedOn	(MOXA + 61)
-#define MOXA_GET_MAJOR		(MOXA + 63)
 #define MOXA_GETMSTATUS		(MOXA + 65)
 #define MOXA_SET_OP_MODE	(MOXA + 66)
 #define MOXA_GET_OP_MODE	(MOXA + 67)
@@ -1499,12 +1498,6 @@ static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
 	int ret = 0;
 
 	switch (cmd) {
-	case MOXA_GET_MAJOR:
-		printk_ratelimited(KERN_WARNING "mxser: '%s' uses deprecated ioctl "
-					"%x (GET_MAJOR), fix your userspace\n",
-					current->comm, cmd);
-		return put_user(ttymajor, (int __user *)argp);
-
 	case MOXA_CHKPORTENABLE:
 		result = 0;
 		for (i = 0; i < MXSER_BOARDS; i++)
-- 
2.32.0

