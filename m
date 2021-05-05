Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88189C4363F
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53462613F5
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhEEJUv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:41878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232477AbhEEJUh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 246FEB27C;
        Wed,  5 May 2021 09:19:40 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 25/35] tty: remove tty_operations::chars_in_buffer for non-buffering
Date:   Wed,  5 May 2021 11:19:18 +0200
Message-Id: <20210505091928.22010-26-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The only user of tty_ops::chars_in_buffer is tty_chars_in_buffer. And it
considers tty_ops::chars_in_buffer optional. In case it's NULL, zero is
returned. So remove all those chars_in_buffer from tty_ops which return
zero. (Zero means such driver doesn't buffer.)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
c: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/alpha/kernel/srmcons.c         |  7 -------
 arch/parisc/kernel/pdc_cons.c       |  6 ------
 arch/xtensa/platforms/iss/console.c |  7 -------
 drivers/s390/char/tty3270.c         | 12 ------------
 drivers/tty/pty.c                   | 17 -----------------
 drivers/tty/vt/vt.c                 |  6 ------
 6 files changed, 55 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 2110b7e7f988..fc03471a0b0f 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -148,12 +148,6 @@ srmcons_write_room(struct tty_struct *tty)
 	return 512;
 }
 
-static int
-srmcons_chars_in_buffer(struct tty_struct *tty)
-{
-	return 0;
-}
-
 static int
 srmcons_open(struct tty_struct *tty, struct file *filp)
 {
@@ -200,7 +194,6 @@ static const struct tty_operations srmcons_ops = {
 	.close		= srmcons_close,
 	.write		= srmcons_write,
 	.write_room	= srmcons_write_room,
-	.chars_in_buffer= srmcons_chars_in_buffer,
 };
 
 static int __init
diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index fe2ed0bbd07e..39ccad063533 100644
--- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -108,17 +108,11 @@ static unsigned int pdc_console_tty_write_room(struct tty_struct *tty)
 	return 32768; /* no limit, no buffer used */
 }
 
-static int pdc_console_tty_chars_in_buffer(struct tty_struct *tty)
-{
-	return 0; /* no buffer */
-}
-
 static const struct tty_operations pdc_console_tty_ops = {
 	.open = pdc_console_tty_open,
 	.close = pdc_console_tty_close,
 	.write = pdc_console_tty_write,
 	.write_room = pdc_console_tty_write_room,
-	.chars_in_buffer = pdc_console_tty_chars_in_buffer,
 };
 
 static void pdc_console_poll(struct timer_list *unused)
diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 98ac3a7fdb0a..21184488c277 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -106,12 +106,6 @@ static unsigned int rs_write_room(struct tty_struct *tty)
 	return 2 * 1024;
 }
 
-static int rs_chars_in_buffer(struct tty_struct *tty)
-{
-	/* the iss doesn't buffer characters */
-	return 0;
-}
-
 static void rs_hangup(struct tty_struct *tty)
 {
 	/* Stub, once again.. */
@@ -135,7 +129,6 @@ static const struct tty_operations serial_ops = {
 	.put_char = rs_put_char,
 	.flush_chars = rs_flush_chars,
 	.write_room = rs_write_room,
-	.chars_in_buffer = rs_chars_in_buffer,
 	.hangup = rs_hangup,
 	.wait_until_sent = rs_wait_until_sent,
 	.proc_show = rs_proc_show,
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 82d4c961ed06..ba1fbce63fee 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1756,17 +1756,6 @@ tty3270_flush_chars(struct tty_struct *tty)
 	}
 }
 
-/*
- * Returns the number of characters in the output buffer. This is
- * used in tty_wait_until_sent to wait until all characters have
- * appeared on the screen.
- */
-static int
-tty3270_chars_in_buffer(struct tty_struct *tty)
-{
-	return 0;
-}
-
 static void
 tty3270_flush_buffer(struct tty_struct *tty)
 {
@@ -1892,7 +1881,6 @@ static const struct tty_operations tty3270_ops = {
 	.put_char = tty3270_put_char,
 	.flush_chars = tty3270_flush_chars,
 	.write_room = tty3270_write_room,
-	.chars_in_buffer = tty3270_chars_in_buffer,
 	.flush_buffer = tty3270_flush_buffer,
 	.throttle = tty3270_throttle,
 	.unthrottle = tty3270_unthrottle,
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index eb8556b19592..5ada7e9381eb 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -143,19 +143,6 @@ static unsigned int pty_write_room(struct tty_struct *tty)
 	return tty_buffer_space_avail(tty->link->port);
 }
 
-/**
- *	pty_chars_in_buffer	-	characters currently in our tx queue
- *	@tty: our tty
- *
- *	Report how much we have in the transmit queue. As everything is
- *	instantly at the other end this is easy to implement.
- */
-
-static int pty_chars_in_buffer(struct tty_struct *tty)
-{
-	return 0;
-}
-
 /* Set the lock flag on a pty */
 static int pty_set_lock(struct tty_struct *tty, int __user *arg)
 {
@@ -525,7 +512,6 @@ static const struct tty_operations master_pty_ops_bsd = {
 	.write = pty_write,
 	.write_room = pty_write_room,
 	.flush_buffer = pty_flush_buffer,
-	.chars_in_buffer = pty_chars_in_buffer,
 	.unthrottle = pty_unthrottle,
 	.ioctl = pty_bsd_ioctl,
 	.compat_ioctl = pty_bsd_compat_ioctl,
@@ -541,7 +527,6 @@ static const struct tty_operations slave_pty_ops_bsd = {
 	.write = pty_write,
 	.write_room = pty_write_room,
 	.flush_buffer = pty_flush_buffer,
-	.chars_in_buffer = pty_chars_in_buffer,
 	.unthrottle = pty_unthrottle,
 	.set_termios = pty_set_termios,
 	.cleanup = pty_cleanup,
@@ -776,7 +761,6 @@ static const struct tty_operations ptm_unix98_ops = {
 	.write = pty_write,
 	.write_room = pty_write_room,
 	.flush_buffer = pty_flush_buffer,
-	.chars_in_buffer = pty_chars_in_buffer,
 	.unthrottle = pty_unthrottle,
 	.ioctl = pty_unix98_ioctl,
 	.compat_ioctl = pty_unix98_compat_ioctl,
@@ -794,7 +778,6 @@ static const struct tty_operations pty_unix98_ops = {
 	.write = pty_write,
 	.write_room = pty_write_room,
 	.flush_buffer = pty_flush_buffer,
-	.chars_in_buffer = pty_chars_in_buffer,
 	.unthrottle = pty_unthrottle,
 	.set_termios = pty_set_termios,
 	.start = pty_start,
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 96c130714930..b838f656f4cd 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3270,11 +3270,6 @@ static unsigned int con_write_room(struct tty_struct *tty)
 	return 32768;		/* No limit, really; we're not buffering */
 }
 
-static int con_chars_in_buffer(struct tty_struct *tty)
-{
-	return 0;		/* we're not buffering */
-}
-
 /*
  * con_throttle and con_unthrottle are only used for
  * paste_selection(), which has to stuff in a large number of
@@ -3521,7 +3516,6 @@ static const struct tty_operations con_ops = {
 	.write_room = con_write_room,
 	.put_char = con_put_char,
 	.flush_chars = con_flush_chars,
-	.chars_in_buffer = con_chars_in_buffer,
 	.ioctl = vt_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = vt_compat_ioctl,
-- 
2.31.1

