Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786DFC43332
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 22:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EC220754
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584571217;
	bh=mWITq1H2XrmeVHpjdvnmMMo+okm1i3eV3ifbsG6jwno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YFeNRzqc6aMcfi9m6wt7IieCvHEZkgrbXe3x6D0nlUlE2vQqfQsOdJo3cqpM+4Oob
	 IR2f+2DD2Zih1piRFsuuW4jEYlzIX4cqNkXYNdJbvnXSER3vsHtveKbEgWYIukP+iL
	 Wa6yN+Y0sGlpxgtYfoyUpqufInDe650krVPKeoEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCRWkQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgCRWkM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 18:40:12 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA3E42076C;
        Wed, 18 Mar 2020 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584571211;
        bh=mWITq1H2XrmeVHpjdvnmMMo+okm1i3eV3ifbsG6jwno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjtLUyHD9fxTg9BEJbmQGt5zw96zOyq0a6j7bEiL7jS78n5PM6tXfsarLSkPfDOzq
         x9LSNEvVMW+jwvQF0WBH2qbGr3oHtFRvhm+zMwr4JfAzgbVUuzuTHVDyGKbeVR0crJ
         QvP4ir4usP+uCoj5DQgLDXTup+Eff7lGJeBNZFvE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 1/2] vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual console
Date:   Wed, 18 Mar 2020 15:38:09 -0700
Message-Id: <20200318223810.162440-2-ebiggers@kernel.org>
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

The VT_DISALLOCATE ioctl can free a virtual console while tty_release()
is still running, causing a use-after-free in con_shutdown().  This
occurs because VT_DISALLOCATE considers a virtual console's
'struct vc_data' to be unused as soon as the corresponding tty's
refcount hits 0.  But actually it may be still being closed.

Fix this by making vc_data be reference-counted via the embedded
'struct tty_port'.  A newly allocated virtual console has refcount 1.
Opening it for the first time increments the refcount to 2.  Closing it
for the last time decrements the refcount (in tty_operations::cleanup()
so that it happens late enough), as does VT_DISALLOCATE.

Reproducer:
	#include <fcntl.h>
	#include <linux/vt.h>
	#include <sys/ioctl.h>
	#include <unistd.h>

	int main()
	{
		if (fork()) {
			for (;;)
				close(open("/dev/tty5", O_RDWR));
		} else {
			int fd = open("/dev/tty10", O_RDWR);

			for (;;)
				ioctl(fd, VT_DISALLOCATE, 5);
		}
	}

KASAN report:
	BUG: KASAN: use-after-free in con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
	Write of size 8 at addr ffff88806a4ec108 by task syz_vt/129

	CPU: 0 PID: 129 Comm: syz_vt Not tainted 5.6.0-rc2 #11
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
	Call Trace:
	 [...]
	 con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
	 release_tty+0xa8/0x410 drivers/tty/tty_io.c:1514
	 tty_release_struct+0x34/0x50 drivers/tty/tty_io.c:1629
	 tty_release+0x984/0xed0 drivers/tty/tty_io.c:1789
	 [...]

	Allocated by task 129:
	 [...]
	 kzalloc include/linux/slab.h:669 [inline]
	 vc_allocate drivers/tty/vt/vt.c:1085 [inline]
	 vc_allocate+0x1ac/0x680 drivers/tty/vt/vt.c:1066
	 con_install+0x4d/0x3f0 drivers/tty/vt/vt.c:3229
	 tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
	 tty_init_dev+0x94/0x350 drivers/tty/tty_io.c:1341
	 tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
	 tty_open+0x3ca/0xb30 drivers/tty/tty_io.c:2035
	 [...]

	Freed by task 130:
	 [...]
	 kfree+0xbf/0x1e0 mm/slab.c:3757
	 vt_disallocate drivers/tty/vt/vt_ioctl.c:300 [inline]
	 vt_ioctl+0x16dc/0x1e30 drivers/tty/vt/vt_ioctl.c:818
	 tty_ioctl+0x9db/0x11b0 drivers/tty/tty_io.c:2660
	 [...]

Fixes: 4001d7b7fc27 ("vt: push down the tty lock so we can see what is left to tackle")
Cc: <stable@vger.kernel.org> # v3.4+
Reported-by: syzbot+522643ab5729b0421998@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/tty/vt/vt.c       | 14 +++++++++++++-
 drivers/tty/vt/vt_ioctl.c | 12 ++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bbc26d73209a4..ec34f1f5f3bb5 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1102,6 +1102,9 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 	tty_port_init(&vc->port);
 	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 
+	/* if this wasn't the case, we'd have to implement port->ops.destruct */
+	BUILD_BUG_ON(offsetof(struct vc_data, port) != 0);
+
 	visual_init(vc, currcons, 1);
 
 	if (!*vc->vc_uni_pagedir_loc)
@@ -3250,6 +3253,7 @@ static int con_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	tty->driver_data = vc;
 	vc->port.tty = tty;
+	tty_port_get(&vc->port);
 
 	if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
 		tty->winsize.ws_row = vc_cons[currcons].d->vc_rows;
@@ -3285,6 +3289,13 @@ static void con_shutdown(struct tty_struct *tty)
 	console_unlock();
 }
 
+static void con_cleanup(struct tty_struct *tty)
+{
+	struct vc_data *vc = tty->driver_data;
+
+	tty_port_put(&vc->port);
+}
+
 static int default_color           = 7; /* white */
 static int default_italic_color    = 2; // green (ASCII)
 static int default_underline_color = 3; // cyan (ASCII)
@@ -3410,7 +3421,8 @@ static const struct tty_operations con_ops = {
 	.throttle = con_throttle,
 	.unthrottle = con_unthrottle,
 	.resize = vt_resize,
-	.shutdown = con_shutdown
+	.shutdown = con_shutdown,
+	.cleanup = con_cleanup,
 };
 
 static struct cdev vc0_cdev;
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 7297997fcf04c..f62f498f63c05 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -310,10 +310,8 @@ static int vt_disallocate(unsigned int vc_num)
 		vc = vc_deallocate(vc_num);
 	console_unlock();
 
-	if (vc && vc_num >= MIN_NR_CONSOLES) {
-		tty_port_destroy(&vc->port);
-		kfree(vc);
-	}
+	if (vc && vc_num >= MIN_NR_CONSOLES)
+		tty_port_put(&vc->port);
 
 	return ret;
 }
@@ -333,10 +331,8 @@ static void vt_disallocate_all(void)
 	console_unlock();
 
 	for (i = 1; i < MAX_NR_CONSOLES; i++) {
-		if (vc[i] && i >= MIN_NR_CONSOLES) {
-			tty_port_destroy(&vc[i]->port);
-			kfree(vc[i]);
-		}
+		if (vc[i] && i >= MIN_NR_CONSOLES)
+			tty_port_put(&vc[i]->port);
 	}
 }
 
-- 
2.25.1

