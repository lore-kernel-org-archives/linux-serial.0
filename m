Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D574C41621
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E8464E75
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbhCCCQ6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:16:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:39920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835892AbhCBGYq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 232A7B035;
        Tue,  2 Mar 2021 06:22:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 32/44] tty: xtensa/iss, setup the timer statically
Date:   Tue,  2 Mar 2021 07:22:02 +0100
Message-Id: <20210302062214.29627-32-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use DEFINE_TIMER and avoid runtime initialization of the serial_timer.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/platforms/iss/console.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 3b89d9ceb06a..8ea261b8c022 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -31,21 +31,18 @@
 #define SERIAL_MAX_NUM_LINES 1
 #define SERIAL_TIMER_VALUE (HZ / 10)
 
+static void rs_poll(struct timer_list *);
+
 static struct tty_driver *serial_driver;
 static struct tty_port serial_port;
-static struct timer_list serial_timer;
-
+static DEFINE_TIMER(serial_timer, rs_poll);
 static DEFINE_SPINLOCK(timer_lock);
 
-static void rs_poll(struct timer_list *);
-
 static int rs_open(struct tty_struct *tty, struct file * filp)
 {
 	spin_lock_bh(&timer_lock);
-	if (tty->count == 1) {
-		timer_setup(&serial_timer, rs_poll, 0);
+	if (tty->count == 1)
 		mod_timer(&serial_timer, jiffies + SERIAL_TIMER_VALUE);
-	}
 	spin_unlock_bh(&timer_lock);
 
 	return 0;
-- 
2.30.1

