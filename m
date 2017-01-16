From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/9] tty: move the non-file related parts of tty_release to new tty_release_struct
Date: Mon, 16 Jan 2017 16:54:28 -0600
Message-ID: <20170116225436.17505-2-robh@kernel.org>
References: <20170116225436.17505-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116225436.17505-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

For in-kernel tty users, we need to be able to create and destroy
'struct tty' that are not associated with a file. The creation side is
fine, but tty_release() needs to be split into the file handle portion
and the struct tty portion. Introduce a new function, tty_release_struct,
to handle just the destroying of a struct tty.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-By: Sebastian Reichel <sre@kernel.org>
---
v2:
- Add kerneldoc for tty_release_struct

 drivers/tty/tty_io.c | 50 ++++++++++++++++++++++++++++++++------------------
 include/linux/tty.h  |  1 +
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 734a635e7363..4790c0fb5a45 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1745,6 +1745,37 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 }

 /**
+ *	tty_release_struct	-	release a tty struct
+ *	@tty: tty device
+ *	@idx: index of the tty
+ *
+ *	Performs the final steps to release and free a tty device. It is
+ *	roughly the reverse of tty_init_dev.
+ */
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
+/**
  *	tty_release		-	vfs callback for close
  *	@inode: inode of tty
  *	@filp: file pointer for handle to tty
@@ -1898,25 +1929,8 @@ int tty_release(struct inode *inode, struct file *filp)
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
