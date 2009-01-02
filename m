From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 38/75] tty: relock the mxser driver
Date: Fri, 02 Jan 2009 13:45:58 +0000
Message-ID: <20090102134556.13472.3207.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37580 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752046AbZABNqG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:06 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/mxser.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)


diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
index ff5ff61..e2471cf 100644
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -591,11 +591,11 @@ static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
 	retval = 0;
 	add_wait_queue(&port->open_wait, &wait);
 
-	spin_lock_irqsave(&mp->slock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 	if (!tty_hung_up_p(filp))
 		port->count--;
-	spin_unlock_irqrestore(&mp->slock, flags);
 	port->blocked_open++;
+	spin_unlock_irqrestore(&port->lock, flags);
 	while (1) {
 		tty_port_raise_dtr_rts(port);
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -617,12 +617,13 @@ static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
+	spin_lock_irqsave(&port->lock, flags);
 	if (!tty_hung_up_p(filp))
 		port->count++;
 	port->blocked_open--;
-	if (retval)
-		return retval;
-	port->flags |= ASYNC_NORMAL_ACTIVE;
+	if (retval == 0)
+		port->flags |= ASYNC_NORMAL_ACTIVE;
+	spin_unlock_irqrestore(&port->lock, flags);
 	return 0;
 }
 
@@ -1102,9 +1103,9 @@ static int mxser_open(struct tty_struct *tty, struct file *filp)
 	/*
 	 * Start up serial port
 	 */
-	spin_lock_irqsave(&info->slock, flags);
+	spin_lock_irqsave(&info->port.lock, flags);
 	info->port.count++;
-	spin_unlock_irqrestore(&info->slock, flags);
+	spin_unlock_irqrestore(&info->port.lock, flags);
 	retval = mxser_startup(tty);
 	if (retval)
 		return retval;
@@ -1157,10 +1158,10 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	if (!info)
 		return;
 
-	spin_lock_irqsave(&info->slock, flags);
+	spin_lock_irqsave(&info->port.lock, flags);
 
 	if (tty_hung_up_p(filp)) {
-		spin_unlock_irqrestore(&info->slock, flags);
+		spin_unlock_irqrestore(&info->port.lock, flags);
 		return;
 	}
 	if ((tty->count == 1) && (info->port.count != 1)) {
@@ -1181,11 +1182,11 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 		info->port.count = 0;
 	}
 	if (info->port.count) {
-		spin_unlock_irqrestore(&info->slock, flags);
+		spin_unlock_irqrestore(&info->port.lock, flags);
 		return;
 	}
 	info->port.flags |= ASYNC_CLOSING;
-	spin_unlock_irqrestore(&info->slock, flags);
+	spin_unlock_irqrestore(&info->port.lock, flags);
 	/*
 	 * Save the termios structure, since this port may have
 	 * separate termios for callout and dialin.
@@ -2161,10 +2162,7 @@ static void mxser_hangup(struct tty_struct *tty)
 
 	mxser_flush_buffer(tty);
 	mxser_shutdown(tty);
-	info->port.count = 0;
-	info->port.flags &= ~ASYNC_NORMAL_ACTIVE;
-	tty_port_tty_set(&info->port, NULL);
-	wake_up_interruptible(&info->port.open_wait);
+	tty_port_hangup(&info->port);
 }
 
 /*

