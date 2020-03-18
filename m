Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF56C4332D
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 22:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AC120775
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 22:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584571213;
	bh=colkYx7pSr0toZDex4E4q5AtOLNC10md1CRDUSFnnno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eK/wkHP47vo5epO5kODfII+Wu13L/T1TVoIQBmAy6nrTn4/vvHjUBWUYCDekIZrjg
	 R8tgM0SE4hY1S92mQnmQ8Nz4If11WAsBndTMkLXWIxNpoBiET3/xEncN5mNrB35AZJ
	 pVEyQKBvMYY1eYfDA654RTfAYCozmMrKntQlhYYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCRWkM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgCRWkL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 18:40:11 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF6720774;
        Wed, 18 Mar 2020 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584571211;
        bh=colkYx7pSr0toZDex4E4q5AtOLNC10md1CRDUSFnnno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wCmjejYVwgA0GCmtb2SoBEeOhW3Oyjn3/YVW+rSCkuULdhS6ArHgIm4KXrn1M6eeW
         MtIWIfsfOQldq1WQHS8mC6ndVompYhcR6PuvUGMsghnIK+t13Xf/SucG/LDvJ0ng6h
         EELIiTa4H/t1dR1BfOXfrQpdZUrg+2bdTu6BH2BU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 2/2] vt: vt_ioctl: fix use-after-free in vt_in_use()
Date:   Wed, 18 Mar 2020 15:38:10 -0700
Message-Id: <20200318223810.162440-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318223810.162440-1-ebiggers@kernel.org>
References: <20200318222704.GC2334@sol.localdomain>
 <20200318223810.162440-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

vt_in_use() dereferences console_driver->ttys[i] without proper locking.
This is broken because the tty can be closed and freed concurrently.

We could fix this by using 'READ_ONCE(console_driver->ttys[i]) != NULL'
and skipping the check of tty_struct::count.  But, looking at
console_driver->ttys[i] isn't really appropriate anyway because even if
it is NULL the tty can still be in the process of being closed.

Instead, fix it by making vt_in_use() require console_lock() and check
whether the vt is allocated and has port refcount > 1.  This works since
following the patch "vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use
virtual console" the port refcount is incremented while the vt is open.

Reproducer (very unreliable, but it worked for me after a few minutes):

	#include <fcntl.h>
	#include <linux/vt.h>

	int main()
	{
		int fd, nproc;
		struct vt_stat state;
		char ttyname[16];

		fd = open("/dev/tty10", O_RDONLY);
		for (nproc = 1; nproc < 8; nproc *= 2)
			fork();
		for (;;) {
			sprintf(ttyname, "/dev/tty%d", rand() % 8);
			close(open(ttyname, O_RDONLY));
			ioctl(fd, VT_GETSTATE, &state);
		}
	}

KASAN report:

	BUG: KASAN: use-after-free in vt_in_use drivers/tty/vt/vt_ioctl.c:48 [inline]
	BUG: KASAN: use-after-free in vt_ioctl+0x1ad3/0x1d70 drivers/tty/vt/vt_ioctl.c:657
	Read of size 4 at addr ffff888065722468 by task syz-vt2/132

	CPU: 0 PID: 132 Comm: syz-vt2 Not tainted 5.6.0-rc5-00130-g089b6d3654916 #13
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
	Call Trace:
	 [...]
	 vt_in_use drivers/tty/vt/vt_ioctl.c:48 [inline]
	 vt_ioctl+0x1ad3/0x1d70 drivers/tty/vt/vt_ioctl.c:657
	 tty_ioctl+0x9db/0x11b0 drivers/tty/tty_io.c:2660
	 [...]

	Allocated by task 136:
	 [...]
	 kzalloc include/linux/slab.h:669 [inline]
	 alloc_tty_struct+0x96/0x8a0 drivers/tty/tty_io.c:2982
	 tty_init_dev+0x23/0x350 drivers/tty/tty_io.c:1334
	 tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
	 tty_open+0x3ca/0xb30 drivers/tty/tty_io.c:2035
	 [...]

	Freed by task 41:
	 [...]
	 kfree+0xbf/0x200 mm/slab.c:3757
	 free_tty_struct+0x8d/0xb0 drivers/tty/tty_io.c:177
	 release_one_tty+0x22d/0x2f0 drivers/tty/tty_io.c:1468
	 process_one_work+0x7f1/0x14b0 kernel/workqueue.c:2264
	 worker_thread+0x8b/0xc80 kernel/workqueue.c:2410
	 [...]

Fixes: 4001d7b7fc27 ("vt: push down the tty lock so we can see what is left to tackle")
Cc: <stable@vger.kernel.org> # v3.4+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/tty/vt/vt_ioctl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index f62f498f63c05..ca0e57b1c0b43 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -43,9 +43,11 @@ bool vt_dont_switch;
 
 static inline bool vt_in_use(unsigned int i)
 {
-	extern struct tty_driver *console_driver;
+	const struct vc_data *vc = vc_cons[i].d;
 
-	return console_driver->ttys[i] && console_driver->ttys[i]->count;
+	WARN_CONSOLE_UNLOCKED();
+
+	return vc && kref_read(&vc->port.kref) > 1;
 }
 
 static inline bool vt_busy(int i)
@@ -643,15 +645,16 @@ int vt_ioctl(struct tty_struct *tty,
 		struct vt_stat __user *vtstat = up;
 		unsigned short state, mask;
 
-		/* Review: FIXME: Console lock ? */
 		if (put_user(fg_console + 1, &vtstat->v_active))
 			ret = -EFAULT;
 		else {
 			state = 1;	/* /dev/tty0 is always open */
+			console_lock();
 			for (i = 0, mask = 2; i < MAX_NR_CONSOLES && mask;
 							++i, mask <<= 1)
 				if (vt_in_use(i))
 					state |= mask;
+			console_unlock();
 			ret = put_user(state, &vtstat->v_state);
 		}
 		break;
@@ -661,10 +664,11 @@ int vt_ioctl(struct tty_struct *tty,
 	 * Returns the first available (non-opened) console.
 	 */
 	case VT_OPENQRY:
-		/* FIXME: locking ? - but then this is a stupid API */
+		console_lock();
 		for (i = 0; i < MAX_NR_CONSOLES; ++i)
 			if (!vt_in_use(i))
 				break;
+		console_unlock();
 		uival = i < MAX_NR_CONSOLES ? (i+1) : -1;
 		goto setint;		 
 
-- 
2.25.1

