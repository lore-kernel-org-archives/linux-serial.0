Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BCDC49EA2
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3973061154
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhFRGSY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46896 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhFRGRq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 26C531FDF8;
        Fri, 18 Jun 2021 06:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZTgWQKTNyBlxvsC+cKlY4x8M0AJWY8bYkfXrysDjhk=;
        b=ysEFrNm94GX71AAKKD60/nhf9nesNbfzAW5sHCUJwnmD0aWoY1LrkAiYxcCOqRB/bkof+v
        bip660GKN3fczRNlvnqruHZOS4fX4Dmc0rEGrJp/hITcvBGsfxFSrCf5HhMShhrxdizLrs
        VLizPXwRxSgAixOhF+kcLwb9tyAccSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996924;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZTgWQKTNyBlxvsC+cKlY4x8M0AJWY8bYkfXrysDjhk=;
        b=95QTXCVeT0+DY4aPN7KFw1yMhCTldC8lBVZ4GZVSuEtd3h8rcZgYj9AR3S1iwJ9hEjOw5P
        5Nt8AT3V/y3uzzDw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0285AA3BA3;
        Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 33/70] mxser: drop unused mxser_port::normal_termios
Date:   Fri, 18 Jun 2021 08:14:39 +0200
Message-Id: <20210618061516.662-34-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After the previous patches, mxser_port::normal_termios is unused, so
time to wave bye-bye.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 007137c3b5c9..e10fbe7270c9 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -297,8 +297,6 @@ struct mxser_port {
 	unsigned int xmit_cnt;
 	int closing;
 
-	struct ktermios normal_termios;
-
 	spinlock_t slock;
 };
 
@@ -2025,7 +2023,6 @@ static int mxser_initbrd(struct mxser_board *brd)
 		info->custom_divisor = info->baud_base * 16;
 		info->port.close_delay = 5 * HZ / 10;
 		info->port.closing_wait = 30 * HZ;
-		info->normal_termios = mxvar_sdriver->init_termios;
 		spin_lock_init(&info->slock);
 
 		/* before set INT ISR, disable all int */
-- 
2.32.0

