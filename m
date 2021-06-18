Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38507C49EA2
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26CB1611CE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhFRGT2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:19:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59016 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhFRGSZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:18:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0C1F121B76;
        Fri, 18 Jun 2021 06:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iwTedBNKcRnucuoBg0xtuBYFokFV3kZJEyrOb6NMuq0=;
        b=KQN+3DPCqLXZWUp6hdkWmykRKBIPrPF5pOfYy3YuKcF/3lViOrmcCwxS3kuC0dMvL7MShH
        Hx+GCukPKvYze8nEAKDkY57yqX6zrJCXDWzxCCByJFzhxuqPmZgM6sI0XxjCyjDGZGyInw
        spw8o8cfpe/Jo34vdMpGS8ElBw7gEzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iwTedBNKcRnucuoBg0xtuBYFokFV3kZJEyrOb6NMuq0=;
        b=jDLMBpnN7CelL/MN672ZKPSdHa1uaawMCjnzxNgcWG6r9lReA5zxV6+k0O5M0z7BjaM9Jf
        GgTKJX0LAQ+nkHDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D9253A3BC3;
        Fri, 18 Jun 2021 06:15:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 65/70] mxser: rename flags to old_speed in mxser_set_serial_info
Date:   Fri, 18 Jun 2021 08:15:11 +0200
Message-Id: <20210618061516.662-66-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Local 'flags' are used to store speed in mxser_set_serial_info, not
actual flags (by doing & ASYNC_SPD_MASK). So rename 'flags' to
'old_speed' (after what it is).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 2f724b4d3f43..f238d17d6fdf 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1057,7 +1057,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 	struct tty_port *port = &info->port;
 	speed_t baud;
 	unsigned long sl_flags;
-	unsigned int flags, close_delay, closing_wait;
+	unsigned int old_speed, close_delay, closing_wait;
 	int retval = 0;
 
 	if (tty_io_error(tty))
@@ -1071,7 +1071,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 		return -EINVAL;
 	}
 
-	flags = port->flags & ASYNC_SPD_MASK;
+	old_speed = port->flags & ASYNC_SPD_MASK;
 
 	close_delay = msecs_to_jiffies(ss->close_delay * 10);
 	closing_wait = ss->closing_wait;
@@ -1115,7 +1115,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 	}
 
 	if (tty_port_initialized(port)) {
-		if (flags != (port->flags & ASYNC_SPD_MASK)) {
+		if (old_speed != (port->flags & ASYNC_SPD_MASK)) {
 			spin_lock_irqsave(&info->slock, sl_flags);
 			mxser_change_speed(tty);
 			spin_unlock_irqrestore(&info->slock, sl_flags);
-- 
2.32.0

