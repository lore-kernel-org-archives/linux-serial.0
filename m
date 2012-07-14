From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 09/12] tty: tidy up the RESET_TERMIOS case
Date: Sat, 14 Jul 2012 15:34:04 +0100
Message-ID: <20120714143356.26945.61497.stgit@localhost.localdomain>
References: <20120714142740.26945.98609.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34155 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2GNORL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2012 10:17:11 -0400
In-Reply-To: <20120714142740.26945.98609.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

If we are going to reset the termios then we don't need the driver side
buffers at all as we now have the tty allocation.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/tty_io.c |   45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index cfd12da..d6feca1 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1249,16 +1249,20 @@ int tty_init_termios(struct tty_struct *tty)
 	struct ktermios *tp;
 	int idx = tty->index;
 
-	tp = tty->driver->termios[idx];
-	if (tp == NULL) {
-		tp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
-		if (tp == NULL)
-			return -ENOMEM;
-		*tp = tty->driver->init_termios;
-		tty->driver->termios[idx] = tp;
-	}
-	tty->termios = *tp;
-
+	if (tty->driver->flags & TTY_DRIVER_RESET_TERMIOS)
+		tty->termios = tty->driver->init_termios;
+	else {
+		tp = tty->driver->termios[idx];
+		if (tp == NULL) {
+			tp = kzalloc(sizeof(struct ktermios[2]), GFP_KERNEL);
+			if (tp == NULL)
+				return -ENOMEM;
+			tp[0] = tty->driver->init_termios;
+			tty->driver->termios[idx] = tp;
+		}
+		tty->termios = tp[0];
+		tty->termios_locked = tp[1];
+        }
 	/* Compatibility until drivers always set this */
 	tty->termios.c_ispeed = tty_termios_input_baud_rate(&tty->termios);
 	tty->termios.c_ospeed = tty_termios_baud_rate(&tty->termios);
@@ -1435,16 +1439,9 @@ err_release_tty:
 
 void tty_free_termios(struct tty_struct *tty)
 {
-	struct ktermios *tp;
 	int idx = tty->index;
 	/* Kill this flag and push into drivers for locking etc */
-	if (tty->driver->flags & TTY_DRIVER_RESET_TERMIOS) {
-		/* FIXME: Locking on ->termios array */
-		tp = tty->driver->termios[idx];
-		tty->driver->termios[idx] = NULL;
-		kfree(tp);
-	}
-	else
+	if (!(tty->driver->flags & TTY_DRIVER_RESET_TERMIOS))
 		*tty->driver->termios[idx] = tty->termios;
 }
 EXPORT_SYMBOL(tty_free_termios);
@@ -3072,16 +3069,19 @@ static void destruct_tty_driver(struct kref *kref)
 		 * drivers are removed from the kernel.
 		 */
 		for (i = 0; i < driver->num; i++) {
-			tp = driver->termios[i];
-			if (tp) {
-				driver->termios[i] = NULL;
-				kfree(tp);
+			if (!(driver->flags & TTY_DRIVER_RESET_TERMIOS)) {
+				tp = driver->termios[i];
+				if (tp) {
+					driver->termios[i] = NULL;
+					kfree(tp);
+				}
 			}
 			if (!(driver->flags & TTY_DRIVER_DYNAMIC_DEV))
 				tty_unregister_device(driver, i);
 		}
 		p = driver->ttys;
 		proc_tty_unregister_driver(driver);
+		/* FIXME: who frees driver->termios itself */
 		driver->ttys = NULL;
 		driver->termios = NULL;
 		kfree(p);
@@ -3121,6 +3121,7 @@ int tty_register_driver(struct tty_driver *driver)
 	void **p = NULL;
 	struct device *d;
 
+	/* FIXME: at this point we are overallocating for the RESET_TERMIOS case */
 	if (!(driver->flags & TTY_DRIVER_DEVPTS_MEM) && driver->num) {
 		p = kzalloc(driver->num * 2 * sizeof(void *), GFP_KERNEL);
 		if (!p)

