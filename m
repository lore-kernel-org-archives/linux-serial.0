From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 15/16] tty: vt, ignore PIO_UNIMAPCLR param
Date: Thu, 23 Jun 2016 13:34:36 +0200
Message-ID: <20160623113437.28416-15-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

We do not do hashtables for unicode fonts since 1995 (1.3.28). So it
is time to remove the second parameter of con_clear_unimap and ignore
the advice from userspace completely.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 13 ++++++-------
 drivers/tty/vt/vt_ioctl.c   |  8 +-------
 include/linux/vt_kern.h     |  5 ++---
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index c8c91f0476a2..9d7ab7b66a8a 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -499,9 +499,8 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
 	return 0;
 }
 
-/* ui is a leftover from using a hashtable, but might be used again
-   Caller must hold the lock */
-static int con_do_clear_unimap(struct vc_data *vc, struct unimapinit *ui)
+/* Caller must hold the lock */
+static int con_do_clear_unimap(struct vc_data *vc)
 {
 	struct uni_pagedir *p, *q;
 
@@ -524,11 +523,11 @@ static int con_do_clear_unimap(struct vc_data *vc, struct unimapinit *ui)
 	return 0;
 }
 
-int con_clear_unimap(struct vc_data *vc, struct unimapinit *ui)
+int con_clear_unimap(struct vc_data *vc)
 {
 	int ret;
 	console_lock();
-	ret = con_do_clear_unimap(vc, ui);
+	ret = con_do_clear_unimap(vc);
 	console_unlock();
 	return ret;
 }
@@ -556,7 +555,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 		int j, k;
 		u16 **p1, *p2, l;
 		
-		err1 = con_do_clear_unimap(vc, NULL);
+		err1 = con_do_clear_unimap(vc);
 		if (err1) {
 			console_unlock();
 			return err1;
@@ -677,7 +676,7 @@ int con_set_default_unimap(struct vc_data *vc)
 	
 	/* The default font is always 256 characters */
 
-	err = con_do_clear_unimap(vc, NULL);
+	err = con_do_clear_unimap(vc);
 	if (err)
 		return err;
     
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 97d5a74558a3..f62c598810ff 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -1006,16 +1006,10 @@ int vt_ioctl(struct tty_struct *tty,
 		break;
 
 	case PIO_UNIMAPCLR:
-	      { struct unimapinit ui;
 		if (!perm)
 			return -EPERM;
-		ret = copy_from_user(&ui, up, sizeof(struct unimapinit));
-		if (ret)
-			ret = -EFAULT;
-		else
-			con_clear_unimap(vc, &ui);
+		con_clear_unimap(vc);
 		break;
-	      }
 
 	case PIO_UNIMAP:
 	case GIO_UNIMAP:
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index 160f81fe3eb8..6abd24f258bc 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -59,14 +59,13 @@ int tioclinux(struct tty_struct *tty, unsigned long arg);
 #ifdef CONFIG_CONSOLE_TRANSLATIONS
 /* consolemap.c */
 
-struct unimapinit;
 struct unipair;
 
 int con_set_trans_old(unsigned char __user * table);
 int con_get_trans_old(unsigned char __user * table);
 int con_set_trans_new(unsigned short __user * table);
 int con_get_trans_new(unsigned short __user * table);
-int con_clear_unimap(struct vc_data *vc, struct unimapinit *ui);
+int con_clear_unimap(struct vc_data *vc);
 int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list);
 int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct unipair __user *list);
 int con_set_default_unimap(struct vc_data *vc);
@@ -92,7 +91,7 @@ static inline int con_get_trans_new(unsigned short __user *table)
 {
 	return -EINVAL;
 }
-static inline int con_clear_unimap(struct vc_data *vc, struct unimapinit *ui)
+static inline int con_clear_unimap(struct vc_data *vc)
 {
 	return 0;
 }
-- 
2.9.0
