From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 35/75] tty: relock generic_serial
Date: Fri, 02 Jan 2009 13:45:36 +0000
Message-ID: <20090102134532.13472.35855.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37585 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756263AbZABNqH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:07 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Switch generic_serial to do port count locking via the tty_port structure
ready for moving to a common port wait routine. Keep the old driver lock for
internal calling so we don't risk messing up the drivers below until we
are ready.

Still needs kref conversions

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/generic_serial.c |   37 ++++++++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 13 deletions(-)


diff --git a/drivers/char/generic_serial.c b/drivers/char/generic_serial.c
index 2356994..2f040d1 100644
--- a/drivers/char/generic_serial.c
+++ b/drivers/char/generic_serial.c
@@ -376,7 +376,8 @@ static void gs_shutdown_port (struct gs_port *port)
 
 void gs_hangup(struct tty_struct *tty)
 {
-	struct gs_port   *port;
+	struct gs_port *port;
+	unsigned long flags;
 
 	func_enter ();
 
@@ -386,9 +387,11 @@ void gs_hangup(struct tty_struct *tty)
 		return;
 
 	gs_shutdown_port (port);
+	spin_lock_irqsave(&port->port.lock, flags);
 	port->port.flags &= ~(ASYNC_NORMAL_ACTIVE|GS_ACTIVE);
 	port->port.tty = NULL;
 	port->port.count = 0;
+	spin_unlock_irqrestore(&port->port.lock, flags);
 
 	wake_up_interruptible(&port->port.open_wait);
 	func_exit ();
@@ -454,12 +457,12 @@ int gs_block_til_ready(void *port_, struct file * filp)
 	add_wait_queue(&port->open_wait, &wait);
 
 	gs_dprintk (GS_DEBUG_BTR, "after add waitq.\n"); 
-	spin_lock_irqsave(&gp->driver_lock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 	if (!tty_hung_up_p(filp)) {
 		port->count--;
 	}
-	spin_unlock_irqrestore(&gp->driver_lock, flags);
 	port->blocked_open++;
+	spin_unlock_irqrestore(&port->lock, flags);
 	while (1) {
 		CD = tty_port_carrier_raised(port);
 		gs_dprintk (GS_DEBUG_BTR, "CD is now %d.\n", CD);
@@ -487,16 +490,17 @@ int gs_block_til_ready(void *port_, struct file * filp)
 		    port->blocked_open);
 	set_current_state (TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
+	
+	spin_lock_irqsave(&port->lock, flags);
 	if (!tty_hung_up_p(filp)) {
 		port->count++;
 	}
 	port->blocked_open--;
-	if (retval)
-		return retval;
-
-	port->flags |= ASYNC_NORMAL_ACTIVE;
+	if (retval == 0)
+        	port->flags |= ASYNC_NORMAL_ACTIVE;
+	spin_unlock_irqrestore(&port->lock, flags);
 	func_exit ();
-	return 0;
+	return retval;
 }			 
 
 
@@ -517,10 +521,10 @@ void gs_close(struct tty_struct * tty, struct file * filp)
 		port->port.tty = tty;
 	}
 
-	spin_lock_irqsave(&port->driver_lock, flags);
+	spin_lock_irqsave(&port->port.lock, flags);
 
 	if (tty_hung_up_p(filp)) {
-		spin_unlock_irqrestore(&port->driver_lock, flags);
+		spin_unlock_irqrestore(&port->port.lock, flags);
 		if (port->rd->hungup)
 			port->rd->hungup (port);
 		func_exit ();
@@ -539,7 +543,7 @@ void gs_close(struct tty_struct * tty, struct file * filp)
 
 	if (port->port.count) {
 		gs_dprintk(GS_DEBUG_CLOSE, "gs_close port %p: count: %d\n", port, port->port.count);
-		spin_unlock_irqrestore(&port->driver_lock, flags);
+		spin_unlock_irqrestore(&port->port.lock, flags);
 		func_exit ();
 		return;
 	}
@@ -560,8 +564,10 @@ void gs_close(struct tty_struct * tty, struct file * filp)
 	 * line status register.
 	 */
 
+	spin_lock_irqsave(&port->driver_lock, flags);
 	port->rd->disable_rx_interrupts (port);
 	spin_unlock_irqrestore(&port->driver_lock, flags);
+	spin_unlock_irqrestore(&port->port.lock, flags);
 
 	/* close has no way of returning "EINTR", so discard return value */
 	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
@@ -574,20 +580,25 @@ void gs_close(struct tty_struct * tty, struct file * filp)
 	tty_ldisc_flush(tty);
 	tty->closing = 0;
 
+	spin_lock_irqsave(&port->driver_lock, flags);
 	port->event = 0;
 	port->rd->close (port);
 	port->rd->shutdown_port (port);
+	spin_unlock_irqrestore(&port->driver_lock, flags);
+
+	spin_lock_irqsave(&port->port.lock, flags);
 	port->port.tty = NULL;
 
 	if (port->port.blocked_open) {
 		if (port->close_delay) {
-			spin_unlock_irqrestore(&port->driver_lock, flags);
+			spin_unlock_irqrestore(&port->port.lock, flags);
 			msleep_interruptible(jiffies_to_msecs(port->close_delay));
-			spin_lock_irqsave(&port->driver_lock, flags);
+			spin_lock_irqsave(&port->port.lock, flags);
 		}
 		wake_up_interruptible(&port->port.open_wait);
 	}
 	port->port.flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING | ASYNC_INITIALIZED);
+	spin_unlock_irqrestore(&port->port.lock, flags);
 	wake_up_interruptible(&port->port.close_wait);
 
 	func_exit ();

