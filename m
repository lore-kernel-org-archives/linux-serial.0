From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 1/3] vc: Locking clean up
Date: Wed, 19 May 2010 13:11:03 +0100
Message-ID: <20100519121013.17652.62076.stgit@localhost.localdomain>
References: <20100519120901.17652.67379.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36500 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754635Ab0ESMxb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 May 2010 08:53:31 -0400
In-Reply-To: <20100519120901.17652.67379.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

The virtual console layer uses the BKL for various things that don't really
need it. Clean them out. Someone really needs to relock selection.c in its
entirity. Have fun...

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/selection.c |    4 ++++
 drivers/char/vt.c        |    7 ++++---
 2 files changed, 8 insertions(+), 3 deletions(-)


diff --git a/drivers/char/selection.c b/drivers/char/selection.c
index f97b9e8..6e79340 100644
--- a/drivers/char/selection.c
+++ b/drivers/char/selection.c
@@ -26,6 +26,7 @@
 #include <linux/selection.h>
 #include <linux/tiocl.h>
 #include <linux/console.h>
+#include <linux/smp_lock.h>
 
 /* Don't take this from <ctype.h>: 011-015 on the screen aren't spaces */
 #define isspace(c)	((c) == ' ')
@@ -312,6 +313,8 @@ int paste_selection(struct tty_struct *tty)
 	struct  tty_ldisc *ld;
 	DECLARE_WAITQUEUE(wait, current);
 
+	lock_kernel();
+
 	acquire_console_sem();
 	poke_blanked_console();
 	release_console_sem();
@@ -335,5 +338,6 @@ int paste_selection(struct tty_struct *tty)
 	__set_current_state(TASK_RUNNING);
 
 	tty_ldisc_deref(ld);
+	unlock_kernel();
 	return 0;
 }
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index bd1d116..c5e30e3 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -280,8 +280,12 @@ static inline unsigned short *screenpos(struct vc_data *vc, int offset, int view
 	return p;
 }
 
+/* Called  from the keyboard irq path.. */
 static inline void scrolldelta(int lines)
 {
+	/* FIXME */
+	/* scrolldelta needs some kind of consistency lock, but the BKL was
+	   and still is not protecting versus the scheduled back end */
 	scrollback_delta += lines;
 	schedule_console_callback();
 }
@@ -2604,8 +2608,6 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 		return -EFAULT;
 	ret = 0;
 
-	lock_kernel();
-
 	switch (type)
 	{
 		case TIOCL_SETSEL:
@@ -2680,7 +2682,6 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 			ret = -EINVAL;
 			break;
 	}
-	unlock_kernel();
 	return ret;
 }
 

