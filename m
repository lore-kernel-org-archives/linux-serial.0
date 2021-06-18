Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E1DC49361
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD55A61209
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhFRGSQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46898 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhFRGRq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 615BD1FDFD;
        Fri, 18 Jun 2021 06:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vFxXMMvn/v5hxITo4hlF/D6aJyBEU9IXn2dLjh/Lcs=;
        b=rsUZalgG8gvuQg0L15daU43RUZ2z0CqQKIInpVT/yLe8tC/fOWLgvTXJyv4C6T7xP84S1F
        TnT7AY+GCDVdMIqygdySEs6mWCSjlY7vhq/4h3Tlz0JjGlz/GGDU26zk6/Kam0VTTdEBii
        L95sq5oDdBz/JvehewXqqS/Ye/p9AJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996924;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vFxXMMvn/v5hxITo4hlF/D6aJyBEU9IXn2dLjh/Lcs=;
        b=fi4jjY/f5TkyaOsdiq4HS66ZWZRRkwK8dC4D95Wv0I5777Mx6qnCDORj2UyOgDUBDzDQ3T
        r4GO4VJ5Rnrra5Bw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3A710A3B9E;
        Fri, 18 Jun 2021 06:15:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 34/70] mxser: remove unused mxser_port::stop_rx
Date:   Fri, 18 Jun 2021 08:14:40 +0200
Message-Id: <20210618061516.662-35-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's been a long time since mxser_port::stop_rx was abandoned. Remove it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index e10fbe7270c9..b47b17ec1f12 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -281,7 +281,6 @@ struct mxser_port {
 	u8 IER;			/* Interrupt Enable Register */
 	u8 MCR;			/* Modem control register */
 
-	unsigned char stop_rx;
 	unsigned char ldisc_stop_rx;
 
 	int custom_divisor;
@@ -2009,7 +2008,6 @@ static int mxser_initbrd(struct mxser_board *brd)
 		tty_port_init(&info->port);
 		info->port.ops = &mxser_port_ops;
 		info->board = brd;
-		info->stop_rx = 0;
 		info->ldisc_stop_rx = 0;
 
 		/* Enhance mode enabled here */
-- 
2.32.0

