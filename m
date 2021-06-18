Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525B0C49EA4
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6AF611CD
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhFRGTT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:19:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhFRGSP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:18:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 96E8621B66;
        Fri, 18 Jun 2021 06:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yksK7LzDOGP61ARBRrE+5NpcXJ2ZmxHs03eLeRZb+zM=;
        b=QrkM0mG3fFrKQ7wGURVxqZmEFam2FhCoSB5GARcZJaQ6vKFDF8MTGZezp2QRvpx0HP7qJl
        et+Sr59tBvNNdWFu03faPMKLLFh/5cyldUs4fyYooBEtTjplIUrh154qmIUfad7w7yxJi1
        ZdUIOeA6ezN+V9PH3IBxF3cbmWDCWQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yksK7LzDOGP61ARBRrE+5NpcXJ2ZmxHs03eLeRZb+zM=;
        b=rzY7t2gLiuvP+45F6ZFTICK6D8qAYY7cDVAwS9s+T4yZrhDzmidBkjXaBDQ4yz8mVBCOHp
        RIu/srm3VhC9iRBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 64D7BA3BC3;
        Fri, 18 Jun 2021 06:15:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 63/70] mxser: access info->MCR under info->slock
Date:   Fri, 18 Jun 2021 08:15:09 +0200
Message-Id: <20210618061516.662-64-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

info->MCR is protected by info->slock all over the code. Extend the lock
in mxser_tiocmget around the info->MCR fetch too.

It likely doesn't change anything, but it's always good to be consistent.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 54b9a9c7c9e9..5dd121450813 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1162,13 +1162,13 @@ static int mxser_tiocmget(struct tty_struct *tty)
 	if (tty_io_error(tty))
 		return -EIO;
 
-	control = info->MCR;
-
 	spin_lock_irqsave(&info->slock, flags);
+	control = info->MCR;
 	status = inb(info->ioaddr + UART_MSR);
 	if (status & UART_MSR_ANY_DELTA)
 		mxser_check_modem_status(tty, info, status);
 	spin_unlock_irqrestore(&info->slock, flags);
+
 	return ((control & UART_MCR_RTS) ? TIOCM_RTS : 0) |
 		    ((control & UART_MCR_DTR) ? TIOCM_DTR : 0) |
 		    ((status & UART_MSR_DCD) ? TIOCM_CAR : 0) |
-- 
2.32.0

