From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 37/75] tty: relock riscom8 using port locks
Date: Fri, 02 Jan 2009 13:45:50 +0000
Message-ID: <20090102134549.13472.58674.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37595 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757048AbZABNqW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:22 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/riscom8.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)


diff --git a/drivers/char/riscom8.c b/drivers/char/riscom8.c
index 6ad1c2a..14662d7 100644
--- a/drivers/char/riscom8.c
+++ b/drivers/char/riscom8.c
@@ -919,14 +919,12 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	retval = 0;
 	add_wait_queue(&port->open_wait, &wait);
 
-	spin_lock_irqsave(&riscom_lock, flags);
-
+	spin_lock_irqsave(&port->lock, flags);
 	if (!tty_hung_up_p(filp))
 		port->count--;
-
-	spin_unlock_irqrestore(&riscom_lock, flags);
-
 	port->blocked_open++;
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	while (1) {
 
 		CD = tty_port_carrier_raised(port);
@@ -950,13 +948,13 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	}
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
+	spin_lock_irqsave(&port->lock, flags);
 	if (!tty_hung_up_p(filp))
 		port->count++;
 	port->blocked_open--;
-	if (retval)
-		return retval;
-
-	port->flags |= ASYNC_NORMAL_ACTIVE;
+	if (retval == 0)
+		port->flags |= ASYNC_NORMAL_ACTIVE;
+	spin_unlock_irqrestore(&port->lock, flags);
 	return 0;
 }
 
@@ -1015,7 +1013,7 @@ static void rc_close(struct tty_struct *tty, struct file *filp)
 	if (!port || rc_paranoia_check(port, tty->name, "close"))
 		return;
 
-	spin_lock_irqsave(&riscom_lock, flags);
+	spin_lock_irqsave(&port->port.lock, flags);
 
 	if (tty_hung_up_p(filp))
 		goto out;
@@ -1041,6 +1039,7 @@ static void rc_close(struct tty_struct *tty, struct file *filp)
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
+	spin_unlock_irqrestore(&port->port.lock, flags);
 	if (port->port.closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, port->port.closing_wait);
 	/*
@@ -1049,6 +1048,8 @@ static void rc_close(struct tty_struct *tty, struct file *filp)
 	 * interrupt driver to stop checking the data ready bit in the
 	 * line status register.
 	 */
+
+	spin_lock_irqsave(&riscom_lock, flags);
 	port->IER &= ~IER_RXD;
 	if (port->port.flags & ASYNC_INITIALIZED) {
 		port->IER &= ~IER_TXRDY;
@@ -1062,21 +1063,27 @@ static void rc_close(struct tty_struct *tty, struct file *filp)
 		 */
 		timeout = jiffies + HZ;
 		while (port->IER & IER_TXEMPTY) {
+			spin_unlock_irqrestore(&riscom_lock, flags);
 			msleep_interruptible(jiffies_to_msecs(port->timeout));
+			spin_lock_irqsave(&riscom_lock, flags);
 			if (time_after(jiffies, timeout))
 				break;
 		}
 	}
 	rc_shutdown_port(tty, bp, port);
 	rc_flush_buffer(tty);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 	tty_ldisc_flush(tty);
 
+	spin_lock_irqsave(&port->port.lock, flags);
 	tty->closing = 0;
 	port->port.tty = NULL;
 	if (port->port.blocked_open) {
+		spin_unlock_irqrestore(&port->port.lock, flags);
 		if (port->port.close_delay)
 			msleep_interruptible(jiffies_to_msecs(port->port.close_delay));
 		wake_up_interruptible(&port->port.open_wait);
+		spin_lock_irqsave(&port->port.lock, flags);
 	}
 	port->port.flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&port->port.close_wait);
@@ -1465,6 +1472,7 @@ static void rc_hangup(struct tty_struct *tty)
 {
 	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
 	struct riscom_board *bp;
+	unsigned long flags;
 
 	if (rc_paranoia_check(port, tty->name, "rc_hangup"))
 		return;
@@ -1472,10 +1480,12 @@ static void rc_hangup(struct tty_struct *tty)
 	bp = port_Board(port);
 
 	rc_shutdown_port(tty, bp, port);
+	spin_lock_irqsave(&port->port.lock, flags);
 	port->port.count = 0;
 	port->port.flags &= ~ASYNC_NORMAL_ACTIVE;
 	port->port.tty = NULL;
 	wake_up_interruptible(&port->port.open_wait);
+	spin_unlock_irqrestore(&port->port.lock, flags);
 }
 
 static void rc_set_termios(struct tty_struct *tty,

