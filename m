Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32522C48BCD
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 09:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D21C613FE
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 09:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhFJJFJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:05:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54652 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFJJFF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Jun 2021 05:05:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2649E21A57;
        Thu, 10 Jun 2021 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623315788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9zJnlK0M9zK1s7LFYWTHI7bGhdiHzu95gNYT76VYNsg=;
        b=FSVY4urd94WuthBQNAXlq0zi5iAG0rR2P4g5OhzEhOoPFbqHIHP8wpNgGlrIIA8TIH7UZm
        oj4Oie0zBQqyXxLmwkLDOaKykZRcOCuIs0EvaHm0pyIXQDEl6HFBCH1nmu3m5G02yDFgca
        83gipd/K+/r7DCjV2Hv9Tytoxo5Lq2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623315788;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9zJnlK0M9zK1s7LFYWTHI7bGhdiHzu95gNYT76VYNsg=;
        b=4fs0VClsnxDZXIHeTVlNMdNc/96ls986YCO+6+kkj5/kEeUmpLqMnh5J4EmsQfHNCToSqF
        BpbY4v+a8h7CRPBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ED203A3B90;
        Thu, 10 Jun 2021 09:03:07 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH] ipwireless: remove unused ipw_tty::closing
Date:   Thu, 10 Jun 2021 11:03:07 +0200
Message-Id: <20210610090307.2689-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's only set, but never read.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
---
 drivers/tty/ipwireless/tty.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index e01ca68f24f4..e3a5a5ba752c 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -54,7 +54,6 @@ struct ipw_tty {
 	unsigned int control_lines;
 	struct mutex ipw_tty_mutex;
 	int tx_bytes_queued;
-	int closing;
 };
 
 static struct ipw_tty *ttys[IPWIRELESS_PCMCIA_MINORS];
@@ -525,7 +524,6 @@ void ipwireless_tty_free(struct ipw_tty *tty)
 				printk(KERN_INFO IPWIRELESS_PCCARD_NAME
 				       ": deregistering %s device ttyIPWp%d\n",
 				       tty_type_name(ttyj->tty_type), j);
-			ttyj->closing = 1;
 			if (ttyj->port.tty != NULL) {
 				mutex_unlock(&ttyj->ipw_tty_mutex);
 				tty_vhangup(ttyj->port.tty);
-- 
2.32.0

