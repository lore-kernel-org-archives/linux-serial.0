From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/4] tty: vt, remove reduntant check
Date: Thu, 31 Mar 2016 10:08:14 +0200
Message-ID: <1459411697-26019-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

MAX_NR_CONSOLES and MAX_NR_USER_CONSOLES are both 63 since they were
introduced in 1.1.54. And since vc_allocate does:

if (currcons >= MAX_NR_CONSOLES)
	return -ENXIO;

if (!vc_cons[currcons].d) {
	if (currcons >= MAX_NR_USER_CONSOLES && !capable(CAP_SYS_RESOURCE))
		return -EPERM;
}

the second check is pointless. Remove both the check and the macro
MAX_NR_USER_CONSOLES.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/vt/vt.c     | 4 ----
 include/uapi/linux/vt.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3e3c7575e92d..90305d569c06 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -768,10 +768,6 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 	    struct vc_data *vc;
 	    struct vt_notifier_param param;
 
-	    /* prevent users from taking too much memory */
-	    if (currcons >= MAX_NR_USER_CONSOLES && !capable(CAP_SYS_RESOURCE))
-	      return -EPERM;
-
 	    /* due to the granularity of kmalloc, we waste some memory here */
 	    /* the alloc is done in two steps, to optimize the common situation
 	       of a 25x80 console (structsize=216, screenbuf_size=4000) */
diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
index 978578bd1895..f69034887e68 100644
--- a/include/uapi/linux/vt.h
+++ b/include/uapi/linux/vt.h
@@ -8,7 +8,6 @@
  */
 #define MIN_NR_CONSOLES 1       /* must be at least 1 */
 #define MAX_NR_CONSOLES	63	/* serial lines start at 64 */
-#define MAX_NR_USER_CONSOLES 63	/* must be root to allocate above this */
 		/* Note: the ioctl VT_GETSTATE does not work for
 		   consoles 16 and higher (since it returns a short) */
 
-- 
2.7.4
