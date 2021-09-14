Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAE7C4321E
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA80061159
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhINJPl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:15:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34550 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhINJPg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:15:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CCD36220D4;
        Tue, 14 Sep 2021 09:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=395yGS0ex2VEogWBSAu+RwdEzwssPbbJ8k+scfecEoE=;
        b=SlwUZn918D+t+/O/s9bdpcv0HtFMw5Jo8MiakKPq5598ISRcR+jMTDBRwQqWzVlBi2ta7e
        9mQzdV58bHvrNxLYtTPQ3OnJgThis3VKJU+xtW1v4X6huteBRPR90fT8gzYiOUo2tsk/AA
        bitz/ZkosGG6Gz06R6oPjvVPnczqW10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610858;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=395yGS0ex2VEogWBSAu+RwdEzwssPbbJ8k+scfecEoE=;
        b=EZfV9JNECZa3I9IKkNFmY1Kbt8x5/44vofy57cayI+AguE8164rxgqfBhC6CfUeTvWX9m/
        jrWtOfsa3oCGALBg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1431CA3B8E;
        Tue, 14 Sep 2021 09:14:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 12/16] tty: arch/, stop using tty_flip_buffer_push
Date:   Tue, 14 Sep 2021 11:14:11 +0200
Message-Id: <20210914091415.17918-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
going to remove the former, so call the latter directly in arch/.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-parisc@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-xtensa@linux-xtensa.org
---
 arch/parisc/kernel/pdc_cons.c       | 2 +-
 arch/um/drivers/chan_kern.c         | 2 +-
 arch/xtensa/platforms/iss/console.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index 2661cdd256ae..221af0ab3382 100644
--- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -128,7 +128,7 @@ static void pdc_console_poll(struct timer_list *unused)
 	}
 
 	if (count)
-		tty_flip_buffer_push(&tty_port);
+		tty_schedule_flip(&tty_port);
 
 	if (pdc_cons.flags & CON_ENABLED)
 		mod_timer(&pdc_console_timer, jiffies + PDC_CONS_POLL_DELAY);
diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 62997055c454..62164db99f99 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -566,5 +566,5 @@ void chan_interrupt(struct line *line, int irq)
 			return;
 	}
  out:
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 }
diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 81d7c7e8f7e9..8d8580d1ef56 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -84,7 +84,7 @@ static void rs_poll(struct timer_list *unused)
 	}
 
 	if (i)
-		tty_flip_buffer_push(port);
+		tty_schedule_flip(port);
 	if (rd)
 		mod_timer(&serial_timer, jiffies + SERIAL_TIMER_VALUE);
 	spin_unlock(&timer_lock);
-- 
2.33.0

