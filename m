Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3D0C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 06:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE5D6105A
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 06:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhEJHA3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 May 2021 03:00:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:58258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhEJHA2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 May 2021 03:00:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C659AFC1;
        Mon, 10 May 2021 06:59:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] tty: remove unused tty_throttle
Date:   Mon, 10 May 2021 08:59:22 +0200
Message-Id: <20210510065923.5112-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The last user was removed in commit e91e52e42814 (n_tty: Fix stuck
throttled driver) in 2013. So remove exported tty_throttle completely.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_ioctl.c    | 31 +++++--------------------------
 include/linux/tty.h        |  1 -
 include/linux/tty_driver.h |  2 +-
 3 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 13acc3decd87..b3ac47569f8a 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -96,28 +96,6 @@ void tty_driver_flush_buffer(struct tty_struct *tty)
 }
 EXPORT_SYMBOL(tty_driver_flush_buffer);
 
-/**
- *	tty_throttle		-	flow control
- *	@tty: terminal
- *
- *	Indicate that a tty should stop transmitting data down the stack.
- *	Takes the termios rwsem to protect against parallel throttle/unthrottle
- *	and also to ensure the driver can consistently reference its own
- *	termios data at this point when implementing software flow control.
- */
-
-void tty_throttle(struct tty_struct *tty)
-{
-	down_write(&tty->termios_rwsem);
-	/* check TTY_THROTTLED first so it indicates our state */
-	if (!test_and_set_bit(TTY_THROTTLED, &tty->flags) &&
-	    tty->ops->throttle)
-		tty->ops->throttle(tty);
-	tty->flow_change = 0;
-	up_write(&tty->termios_rwsem);
-}
-EXPORT_SYMBOL(tty_throttle);
-
 /**
  *	tty_unthrottle		-	flow control
  *	@tty: terminal
@@ -146,10 +124,11 @@ EXPORT_SYMBOL(tty_unthrottle);
  *	tty_throttle_safe	-	flow control
  *	@tty: terminal
  *
- *	Similar to tty_throttle() but will only attempt throttle
- *	if tty->flow_change is TTY_THROTTLE_SAFE. Prevents an accidental
- *	throttle due to race conditions when throttling is conditional
- *	on factors evaluated prior to throttling.
+ *	Indicate that a tty should stop transmitting data down the stack.
+ *	tty_throttle_safe will only attempt throttle if tty->flow_change is
+ *	TTY_THROTTLE_SAFE. Prevents an accidental throttle due to race
+ *	conditions when throttling is conditional on factors evaluated prior to
+ *	throttling.
  *
  *	Returns 0 if tty is throttled (or was already throttled)
  */
diff --git a/include/linux/tty.h b/include/linux/tty.h
index a14b4588368c..97c1e264f203 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -461,7 +461,6 @@ extern int tty_put_char(struct tty_struct *tty, unsigned char c);
 extern unsigned int tty_chars_in_buffer(struct tty_struct *tty);
 extern unsigned int tty_write_room(struct tty_struct *tty);
 extern void tty_driver_flush_buffer(struct tty_struct *tty);
-extern void tty_throttle(struct tty_struct *tty);
 extern void tty_unthrottle(struct tty_struct *tty);
 extern int tty_throttle_safe(struct tty_struct *tty);
 extern int tty_unthrottle_safe(struct tty_struct *tty);
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index a4694bb125cc..448f8ee6db6e 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -136,7 +136,7 @@
  * 	the line discipline are close to full, and it should somehow
  * 	signal that no more characters should be sent to the tty.
  *
- *	Optional: Always invoke via tty_throttle(), called under the
+ *	Optional: Always invoke via tty_throttle_safe(), called under the
  *	termios lock.
  * 
  * void (*unthrottle)(struct tty_struct * tty);
-- 
2.31.1

