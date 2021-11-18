Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D0C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4D361A3A
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbhKRHWP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:22:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46098 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243363AbhKRHWN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:22:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8FF42171F;
        Thu, 18 Nov 2021 07:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637219951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pC3mpAMy0wMIy3Q79HvEJTwRe6Ms5Egf/M2hTJu+lrM=;
        b=NSRjIi4vXa0poBLRLudV8EibtAigH3okNiR0L8125QtLtQdlwCHZzVMkN6OvVFom9JyVSl
        iYNVuiCw4VV8544qMntERj6VRODan+0FX9S7wwGAoOL5hEGiOyFAxsKmaAJfne7xfEWMDM
        p05yQOATxOmw8TCPw+VtWju9jlvHrQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637219951;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pC3mpAMy0wMIy3Q79HvEJTwRe6Ms5Egf/M2hTJu+lrM=;
        b=Io2SWb/4FVKjvRKh4Njwams3LmOGJTAJ+KaWRtNvcMSakP17+DJ9HORmJSpcO2BKti33DK
        VYVZ0G5AvSHLBYCA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B2152A3B84;
        Thu, 18 Nov 2021 07:19:11 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/4] tty: remove TTY_SOFT_SAK part from __do_SAK()
Date:   Thu, 18 Nov 2021 08:19:08 +0100
Message-Id: <20211118071911.12059-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118071911.12059-1-jslaby@suse.cz>
References: <20211118071911.12059-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Remove the TTY_SOFT_SAK part. It is never defined, so this is only
confusing.

It was actually never defined since its introduction in
0.99.14g.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6616d4a0d41d..829944dfaf48 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3028,9 +3028,6 @@ static int this_tty(const void *t, struct file *file, unsigned fd)
  */
 void __do_SAK(struct tty_struct *tty)
 {
-#ifdef TTY_SOFT_SAK
-	tty_hangup(tty);
-#else
 	struct task_struct *g, *p;
 	struct pid *session;
 	int		i;
@@ -3074,7 +3071,6 @@ void __do_SAK(struct tty_struct *tty)
 	} while_each_thread(g, p);
 	read_unlock(&tasklist_lock);
 	put_pid(session);
-#endif
 }
 
 static void do_SAK_work(struct work_struct *work)
-- 
2.33.1

