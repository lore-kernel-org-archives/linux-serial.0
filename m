From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/9] tty: move the non-file related parts of tty_release to new tty_release_struct
Date: Fri,  6 Jan 2017 10:26:27 -0600
Message-ID: <20170106162635.19677-2-robh@kernel.org>
References: <20170106162635.19677-1-robh@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170106162635.19677-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

For in-kernel tty users, we need to be able to create and destroy
'struct tty' that are not associated with a file. The creation side is
fine, but tty_release() needs to be split into the file handle portion
and the struct tty portion. Introduce a new function, tty_release_struct,
to handle just the destroying of a struct tty.

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/tty/tty_io.c | 42 ++++++++++++++++++++++++------------------
 include/linux/tty.h  |  1 +
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 734a635e7363..5ebc090ec47f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1744,6 +1744,29 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 	return 0;
 }
 
+void tty_release_struct(struct tty_struct *tty, int idx)
+{
+	/*
+	 * Ask the line discipline code to release its structures
+	 */
+	tty_ldisc_release(tty);
+
+	/* Wait for pending work before tty destruction commmences */
+	tty_flush_works(tty);
+
+	tty_debug_hangup(tty, "freeing structure\n");
+	/*
+	 * The release_tty function takes care of the details of clearing
+	 * the slots and preserving the termios structure. The tty_unlock_pair
+	 * should be safe as we keep a kref while the tty is locked (so the
+	 * unlock never unlocks a freed tty).
+	 */
+	mutex_lock(&tty_mutex);
+	release_tty(tty, idx);
+	mutex_unlock(&tty_mutex);
+}
+EXPORT_SYMBOL_GPL(tty_release_struct);
+
 /**
  *	tty_release		-	vfs callback for close
  *	@inode: inode of tty
@@ -1898,25 +1921,8 @@ int tty_release(struct inode *inode, struct file *filp)
 		return 0;
 
 	tty_debug_hangup(tty, "final close\n");
-	/*
-	 * Ask the line discipline code to release its structures
-	 */
-	tty_ldisc_release(tty);
-
-	/* Wait for pending work before tty destruction commmences */
-	tty_flush_works(tty);
-
-	tty_debug_hangup(tty, "freeing structure\n");
-	/*
-	 * The release_tty function takes care of the details of clearing
-	 * the slots and preserving the termios structure. The tty_unlock_pair
-	 * should be safe as we keep a kref while the tty is locked (so the
-	 * unlock never unlocks a freed tty).
-	 */
-	mutex_lock(&tty_mutex);
-	release_tty(tty, idx);
-	mutex_unlock(&tty_mutex);
 
+	tty_release_struct(tty, idx);
 	return 0;
 }
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 40144f382516..86c7853282b7 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -528,6 +528,7 @@ extern int tty_alloc_file(struct file *file);
 extern void tty_add_file(struct tty_struct *tty, struct file *file);
 extern void tty_free_file(struct file *file);
 extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
+extern void tty_release_struct(struct tty_struct *tty, int idx);
 extern int tty_release(struct inode *inode, struct file *filp);
 extern void tty_init_termios(struct tty_struct *tty);
 extern int tty_standard_install(struct tty_driver *driver,
-- 
2.10.1
