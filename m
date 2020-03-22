Return-Path: <SRS0=JG5f=5H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B5C4332E
	for <linux-serial@archiver.kernel.org>; Sun, 22 Mar 2020 03:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CDA20774
	for <linux-serial@archiver.kernel.org>; Sun, 22 Mar 2020 03:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584848674;
	bh=+19Z5Tye1PAVVFfmfRIwC11NhXs130KCz5NNO25vAd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D4vyRCHhJgLpv+65iZ4Oc84UCdqNiTahLDcpq+Vz5bCxfuUcBYED2zWupbOrnFNL/
	 QCMyKhGwfiqB0wP7sOyir86Qvr99esdbAGNjEqsx89wmT8gpXN1nFRjcyFPCFT1+Cr
	 JyE4E3JSNa2K26qmFAeKG9AcgfEvnxIhCtn1HkAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgCVDo3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Mar 2020 23:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgCVDo3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Mar 2020 23:44:29 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D7B20719;
        Sun, 22 Mar 2020 03:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584848668;
        bh=+19Z5Tye1PAVVFfmfRIwC11NhXs130KCz5NNO25vAd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+JCO1WHdA8wlOv1RWpGRU+eIEjaWP9HWjzrFaTow9dijQCgIjlmzSINrDFFSxMCr
         s9VleGzkWGzSbP+tLdp0+KgaMdQHAxbQcMW80Iy8yX5EeTqUHR9Sxf1QjzJ9tK2Kw+
         3jUV8B2WShWLZS2iozxWnXQRiney8kPK9zUhdsMs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v3 1/2] vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual console
Date:   Sat, 21 Mar 2020 20:43:04 -0700
Message-Id: <20200322034305.210082-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200322034305.210082-1-ebiggers@kernel.org>
References: <20200320193424.GM851@sol.localdomain>
 <20200322034305.210082-1-ebiggers@kernel.org>
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
 drivers/tty/vt/vt.c       | 23 ++++++++++++++++++++++-
 drivers/tty/vt/vt_ioctl.c | 12 ++++--------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bbc26d73209a4..309a39197be0a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1075,6 +1075,17 @@ static void visual_deinit(struct vc_data *vc)
 	module_put(vc->vc_sw->owner);
 }
 
+static void vc_port_destruct(struct tty_port *port)
+{
+	struct vc_data *vc = container_of(port, struct vc_data, port);
+
+	kfree(vc);
+}
+
+static const struct tty_port_operations vc_port_ops = {
+	.destruct = vc_port_destruct,
+};
+
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
 {
 	struct vt_notifier_param param;
@@ -1100,6 +1111,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 
 	vc_cons[currcons].d = vc;
 	tty_port_init(&vc->port);
+	vc->port.ops = &vc_port_ops;
 	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 
 	visual_init(vc, currcons, 1);
@@ -3250,6 +3262,7 @@ static int con_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	tty->driver_data = vc;
 	vc->port.tty = tty;
+	tty_port_get(&vc->port);
 
 	if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
 		tty->winsize.ws_row = vc_cons[currcons].d->vc_rows;
@@ -3285,6 +3298,13 @@ static void con_shutdown(struct tty_struct *tty)
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
@@ -3410,7 +3430,8 @@ static const struct tty_operations con_ops = {
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
2.25.2

