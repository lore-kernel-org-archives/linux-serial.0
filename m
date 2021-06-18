Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102AAC48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4BB611CE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhFRGR5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59680 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbhFRGRl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E91E221B4F;
        Fri, 18 Jun 2021 06:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=373VsUjCdmrfx4JVH30Rel8N/AJ7vp7LefOEwnhMQ0A=;
        b=y2SaWuxqUH3mLiNKv4u9OnhRdjPkLOava9ogh9yqkqwDGDfj8IVW97nRFA5dRIQf+OoINP
        tGK5hTs8+rOz9/to/dDThdDbWVFdPhiy729X4E+i16++QYQzoY6VFqhOKhTuV9AhX/6FKs
        7bcGJV+gsipgq53GvhPu+hNANN944bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=373VsUjCdmrfx4JVH30Rel8N/AJ7vp7LefOEwnhMQ0A=;
        b=ozsQncD//q2uYxqlFihpuUcr36BYAtusWbfvQssAU9I3pefx7G6nzEnVgDoAsiRqyiVTJe
        TlJpIv36x6VDS/CA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C303BA3BBA;
        Fri, 18 Jun 2021 06:15:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 18/70] mxser: correct types for uart variables
Date:   Fri, 18 Jun 2021 08:14:24 +0200
Message-Id: <20210618061516.662-19-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In struct mxser_port, all the UART registers and masks, and the xon/xoff
character are stored into int. Let's re-type all these as UART registers
are 8bit (u8) and xon/xoff character is an unsigned char (cc_t in
ktermios).

This save some bytes in memory, but more importantly the change makes it
what it really is.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 1b8032c9351e..45f36d92c5ea 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -335,9 +335,9 @@ struct mxser_port {
 	int baud_base;		/* max. speed */
 	int type;		/* UART type */
 
-	int x_char;		/* xon/xoff character */
-	int IER;		/* Interrupt Enable Register */
-	int MCR;		/* Modem control register */
+	unsigned char x_char;	/* xon/xoff character */
+	u8 IER;			/* Interrupt Enable Register */
+	u8 MCR;			/* Modem control register */
 
 	unsigned char stop_rx;
 	unsigned char ldisc_stop_rx;
@@ -348,8 +348,8 @@ struct mxser_port {
 	struct async_icount icount; /* kernel counters for 4 input interrupts */
 	unsigned int timeout;
 
-	int read_status_mask;
-	int ignore_status_mask;
+	u8 read_status_mask;
+	u8 ignore_status_mask;
 	u8 xmit_fifo_size;
 	int xmit_head;
 	int xmit_tail;
-- 
2.32.0

