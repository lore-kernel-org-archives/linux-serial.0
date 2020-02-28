Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CFAC3F2D1
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D2D246AE
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgB1LyJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:54:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:34714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgB1LyJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 06:54:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9A9B3B3A2;
        Fri, 28 Feb 2020 11:54:07 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
Subject: [PATCH 2/2] vt: selection, push sel_lock up
Date:   Fri, 28 Feb 2020 12:54:06 +0100
Message-Id: <20200228115406.5735-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228115406.5735-1-jslaby@suse.cz>
References: <20200228115406.5735-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

sel_lock cannot nest in the console lock. Thanks to syzkaller, the
kernel states firmly:

> WARNING: possible circular locking dependency detected
> 5.6.0-rc3-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.4/20336 is trying to acquire lock:
> ffff8880a2e952a0 (&tty->termios_rwsem){++++}, at: tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
>
> but task is already holding lock:
> ffffffff89462e70 (sel_lock){+.+.}, at: paste_selection+0x118/0x470 drivers/tty/vt/selection.c:374
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (sel_lock){+.+.}:
>        mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
>        set_selection_kernel+0x3b8/0x18a0 drivers/tty/vt/selection.c:217
>        set_selection_user+0x63/0x80 drivers/tty/vt/selection.c:181
>        tioclinux+0x103/0x530 drivers/tty/vt/vt.c:3050
>        vt_ioctl+0x3f1/0x3a30 drivers/tty/vt/vt_ioctl.c:364

This is ioctl(TIOCL_SETSEL).
Locks held on the path: console_lock -> sel_lock

> -> #1 (console_lock){+.+.}:
>        console_lock+0x46/0x70 kernel/printk/printk.c:2289
>        con_flush_chars+0x50/0x650 drivers/tty/vt/vt.c:3223
>        n_tty_write+0xeae/0x1200 drivers/tty/n_tty.c:2350
>        do_tty_write drivers/tty/tty_io.c:962 [inline]
>        tty_write+0x5a1/0x950 drivers/tty/tty_io.c:1046

This is write().
Locks held on the path: termios_rwsem -> console_lock

> -> #0 (&tty->termios_rwsem){++++}:
>        down_write+0x57/0x140 kernel/locking/rwsem.c:1534
>        tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
>        mkiss_receive_buf+0x12aa/0x1340 drivers/net/hamradio/mkiss.c:902
>        tty_ldisc_receive_buf+0x12f/0x170 drivers/tty/tty_buffer.c:465
>        paste_selection+0x346/0x470 drivers/tty/vt/selection.c:389
>        tioclinux+0x121/0x530 drivers/tty/vt/vt.c:3055
>        vt_ioctl+0x3f1/0x3a30 drivers/tty/vt/vt_ioctl.c:364

This is ioctl(TIOCL_PASTESEL).
Locks held on the path: sel_lock -> termios_rwsem

> other info that might help us debug this:
>
> Chain exists of:
>   &tty->termios_rwsem --> console_lock --> sel_lock

Clearly. From the above, we have:
 console_lock -> sel_lock
 sel_lock -> termios_rwsem
 termios_rwsem -> console_lock

Fix this by reversing the console_lock -> sel_lock dependency in
ioctl(TIOCL_SETSEL). First, lock sel_lock, then console_lock.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
Fixes: 07e6124a1a46 ("vt: selection, close sel_buffer race")
---
 drivers/tty/vt/selection.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 5b0b897396eb..7556139cd0da 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -219,7 +219,6 @@ static int __set_selection_kernel(struct tiocl_selection *v, struct tty_struct *
 	if (ps > pe)	/* make sel_start <= sel_end */
 		swap(ps, pe);
 
-	mutex_lock(&sel_lock);
 	if (sel_cons != vc_cons[fg_console].d) {
 		clear_selection();
 		sel_cons = vc_cons[fg_console].d;
@@ -265,10 +264,9 @@ static int __set_selection_kernel(struct tiocl_selection *v, struct tty_struct *
 			break;
 		case TIOCL_SELPOINTER:
 			highlight_pointer(pe);
-			goto unlock;
+			return 0;
 		default:
-			ret = -EINVAL;
-			goto unlock;
+			return -EINVAL;
 	}
 
 	/* remove the pointer */
@@ -290,7 +288,7 @@ static int __set_selection_kernel(struct tiocl_selection *v, struct tty_struct *
 	else if (new_sel_start == sel_start)
 	{
 		if (new_sel_end == sel_end)	/* no action required */
-			goto unlock;
+			return 0;
 		else if (new_sel_end > sel_end)	/* extend to right */
 			highlight(sel_end + 2, new_sel_end);
 		else				/* contract from right */
@@ -318,8 +316,7 @@ static int __set_selection_kernel(struct tiocl_selection *v, struct tty_struct *
 	if (!bp) {
 		printk(KERN_WARNING "selection: kmalloc() failed\n");
 		clear_selection();
-		ret = -ENOMEM;
-		goto unlock;
+		return -ENOMEM;
 	}
 	kfree(sel_buffer);
 	sel_buffer = bp;
@@ -344,8 +341,7 @@ static int __set_selection_kernel(struct tiocl_selection *v, struct tty_struct *
 		}
 	}
 	sel_buffer_lth = bp - sel_buffer;
-unlock:
-	mutex_unlock(&sel_lock);
+
 	return ret;
 }
 
@@ -353,9 +349,11 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 {
 	int ret;
 
+	mutex_lock(&sel_lock);
 	console_lock();
 	ret = __set_selection_kernel(v, tty);
 	console_unlock();
+	mutex_unlock(&sel_lock);
 
 	return ret;
 }
-- 
2.25.1

