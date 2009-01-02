From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 34/75] isicom: redo locking to use tty port locks
Date: Fri, 02 Jan 2009 13:45:26 +0000
Message-ID: <20090102134524.13472.12450.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37588 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756953AbZABNqN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:13 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

This helps set the basis for moving block_til_ready into common code. We also
introduce a tty_port_hangup helper as this will also be generally needed.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/isicom.c     |   35 +++++++++++++++--------------------
 drivers/char/synclinkmp.c |   20 ++++++++++++++------
 drivers/char/tty_port.c   |   24 ++++++++++++++++++++++++
 include/linux/tty.h       |    1 +
 4 files changed, 54 insertions(+), 26 deletions(-)


diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index a449449..db53db9 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -841,7 +841,6 @@ static int isicom_carrier_raised(struct tty_port *port)
 static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	struct isi_port *ip)
 {
-	struct isi_board *card = ip->card;
 	struct tty_port *port = &ip->port;
 	int do_clocal = 0, retval;
 	unsigned long flags;
@@ -876,11 +875,11 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	retval = 0;
 	add_wait_queue(&port->open_wait, &wait);
 
-	spin_lock_irqsave(&card->card_lock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 	if (!tty_hung_up_p(filp))
 		port->count--;
 	port->blocked_open++;
-	spin_unlock_irqrestore(&card->card_lock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	while (1) {
 		tty_port_raise_dtr_rts(port);
@@ -905,14 +904,13 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
-	spin_lock_irqsave(&card->card_lock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 	if (!tty_hung_up_p(filp))
 		port->count++;
 	port->blocked_open--;
-	spin_unlock_irqrestore(&card->card_lock, flags);
-	if (retval)
-		return retval;
-	port->flags |= ASYNC_NORMAL_ACTIVE;
+	if (retval == 0)
+		port->flags |= ASYNC_NORMAL_ACTIVE;
+	spin_unlock_irqrestore(&port->lock, flags);
 	return 0;
 }
 
@@ -1034,9 +1032,9 @@ static void isicom_close(struct tty_struct *tty, struct file *filp)
 
 	pr_dbg("Close start!!!.\n");
 
-	spin_lock_irqsave(&card->card_lock, flags);
+	spin_lock_irqsave(&port->port.lock, flags);
 	if (tty_hung_up_p(filp)) {
-		spin_unlock_irqrestore(&card->card_lock, flags);
+		spin_unlock_irqrestore(&port->port.lock, flags);
 		return;
 	}
 
@@ -1054,12 +1052,12 @@ static void isicom_close(struct tty_struct *tty, struct file *filp)
 	}
 
 	if (port->port.count) {
-		spin_unlock_irqrestore(&card->card_lock, flags);
+		spin_unlock_irqrestore(&port->port.lock, flags);
 		return;
 	}
 	port->port.flags |= ASYNC_CLOSING;
 	tty->closing = 1;
-	spin_unlock_irqrestore(&card->card_lock, flags);
+	spin_unlock_irqrestore(&port->port.lock, flags);
 
 	if (port->port.closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, port->port.closing_wait);
@@ -1076,22 +1074,22 @@ static void isicom_close(struct tty_struct *tty, struct file *filp)
 	isicom_flush_buffer(tty);
 	tty_ldisc_flush(tty);
 
-	spin_lock_irqsave(&card->card_lock, flags);
+	spin_lock_irqsave(&port->port.lock, flags);
 	tty->closing = 0;
 
 	if (port->port.blocked_open) {
-		spin_unlock_irqrestore(&card->card_lock, flags);
+		spin_unlock_irqrestore(&port->port.lock, flags);
 		if (port->port.close_delay) {
 			pr_dbg("scheduling until time out.\n");
 			msleep_interruptible(
 				jiffies_to_msecs(port->port.close_delay));
 		}
-		spin_lock_irqsave(&card->card_lock, flags);
+		spin_lock_irqsave(&port->port.lock, flags);
 		wake_up_interruptible(&port->port.open_wait);
 	}
 	port->port.flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CLOSING);
 	wake_up_interruptible(&port->port.close_wait);
-	spin_unlock_irqrestore(&card->card_lock, flags);
+	spin_unlock_irqrestore(&port->port.lock, flags);
 }
 
 /* write et all */
@@ -1430,10 +1428,7 @@ static void isicom_hangup(struct tty_struct *tty)
 	isicom_shutdown_port(port);
 	spin_unlock_irqrestore(&port->card->card_lock, flags);
 
-	port->port.count = 0;
-	port->port.flags &= ~ASYNC_NORMAL_ACTIVE;
-	tty_port_tty_set(&port->port, NULL);
-	wake_up_interruptible(&port->port.open_wait);
+	tty_port_hangup(&port->port);
 }
 
 
diff --git a/drivers/char/synclinkmp.c b/drivers/char/synclinkmp.c
index fcf1ec7..1f5c21e 100644
--- a/drivers/char/synclinkmp.c
+++ b/drivers/char/synclinkmp.c
@@ -3331,6 +3331,17 @@ static int carrier_raised(struct tty_port *port)
 	return (info->serial_signals & SerialSignal_DCD) ? 1 : 0;
 }
 
+static void raise_dtr_rts(struct tty_port *port)
+{
+	SLMP_INFO *info = container_of(port, SLMP_INFO, port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&info->lock,flags);
+	info->serial_signals |= SerialSignal_RTS + SerialSignal_DTR;
+ 	set_signals(info);
+	spin_unlock_irqrestore(&info->lock,flags);
+}
+
 /* Block the current process until the specified port is ready to open.
  */
 static int block_til_ready(struct tty_struct *tty, struct file *filp,
@@ -3381,12 +3392,8 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	port->blocked_open++;
 
 	while (1) {
-		if ((tty->termios->c_cflag & CBAUD)) {
-			spin_lock_irqsave(&info->lock,flags);
-			info->serial_signals |= SerialSignal_RTS + SerialSignal_DTR;
-		 	set_signals(info);
-			spin_unlock_irqrestore(&info->lock,flags);
-		}
+		if (tty->termios->c_cflag & CBAUD)
+			tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -3793,6 +3800,7 @@ static void add_device(SLMP_INFO *info)
 
 static const struct tty_port_operations port_ops = {
 	.carrier_raised = carrier_raised,
+	.raise_dtr_rts = raise_dtr_rts,
 };
 
 /* Allocate and initialize a device instance structure
diff --git a/drivers/char/tty_port.c b/drivers/char/tty_port.c
index 0557b63..9f418bc 100644
--- a/drivers/char/tty_port.c
+++ b/drivers/char/tty_port.c
@@ -7,6 +7,7 @@
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
+#include <linux/serial.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/slab.h>
@@ -96,6 +97,29 @@ void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 EXPORT_SYMBOL(tty_port_tty_set);
 
 /**
+ *	tty_port_hangup		-	hangup helper
+ *	@port: tty port
+ *
+ *	Perform port level tty hangup flag and count changes. Drop the tty
+ *	reference.
+ */
+
+void tty_port_hangup(struct tty_port *port)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	port->count = 0;
+	port->flags &= ~ASYNC_NORMAL_ACTIVE;
+	if (port->tty)
+		tty_kref_put(port->tty);
+	port->tty = NULL;
+	spin_unlock_irqrestore(&port->lock, flags);
+	wake_up_interruptible(&port->open_wait);
+}
+EXPORT_SYMBOL(tty_port_hangup);
+
+/**
  *	tty_port_carrier_raised	-	carrier raised check
  *	@port: tty port
  *
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 5001bbc..a1a9314 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -438,6 +438,7 @@ extern struct tty_struct *tty_port_tty_get(struct tty_port *port);
 extern void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
 extern int tty_port_carrier_raised(struct tty_port *port);
 extern void tty_port_raise_dtr_rts(struct tty_port *port);
+extern void tty_port_hangup(struct tty_port *port);
 
 extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);

