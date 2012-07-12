From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 08/10] tty: tidy up the RESET_TERMIOS case
Date: Thu, 12 Jul 2012 13:01:10 +0100
Message-ID: <20120712120104.1321.3340.stgit@localhost.localdomain>
References: <20120712115643.1321.63498.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59543 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757357Ab2GLLoU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jul 2012 07:44:20 -0400
In-Reply-To: <20120712115643.1321.63498.stgit@localhost.localdomain>
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
index a0a53cf..111bed7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1250,16 +1250,20 @@ int tty_init_termios(struct tty_struct *tty)
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
@@ -1440,16 +1444,9 @@ err_release_tty:
 
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
@@ -3085,16 +3082,19 @@ static void destruct_tty_driver(struct kref *kref)
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
@@ -3134,6 +3134,7 @@ int tty_register_driver(struct tty_driver *driver)
 	void **p = NULL;
 	struct device *d;
 
+	/* FIXME: at this point we are overallocating for the RESET_TERMIOS case */
 	if (!(driver->flags & TTY_DRIVER_DEVPTS_MEM) && driver->num) {
 		p = kzalloc(driver->num * 2 * sizeof(void *), GFP_KERNEL);
 		if (!p)

