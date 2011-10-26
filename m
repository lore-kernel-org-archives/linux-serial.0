From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 03/79] TTY: serial, remove BTM from wait_until_sent
Date: Wed, 26 Oct 2011 14:12:08 +0200
Message-ID: <1319631204-23262-3-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60917 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab1JZMN2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:28 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Andreas Bombe <aeb@debian.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

During the BKL removal process, the BKL was switched to tty_lock
(BTM). Now we should start pruning the BTM further. Let's start with
wait_until_sent of the serial layer. This will allow us to switch to
the tty port helpers and thus clean it up much.

In wait_until_sent there are some uport members accessed, but neither
of them is protected by BTM at the location they are set ('=>' means
function call):
* uport->fifosize (set in tty_ioctl => uart_ioctl => uart_set_info)
* uport->type (set in add_one_port prior to tty_register_device)
* uport->timeout (set usually in tty_ioctl => tty_mode_ioctl =>
  tty_set_termios => uart_set_termios => uart_change_speed =>
  uport->ops->set_termios => uart_update_timeout)
* call to uport->ops->tx_empty()

If the tx_empty hook needs some lock to protect accesses to registers,
it should take &uport->lock spinlock like 8250 does. Otherwise there
still might be races e.g. with ISRs.

This should also fix the issue Andreas is seeing (BTM in comparison to
BKL doesn't have any hidden functionality like unlocking during
sleeping).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
References: https://lkml.org/lkml/2011/5/25/562
Cc: Alan Cox <alan@linux.intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Bombe <aeb@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |   30 +++++++-----------------------
 1 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index db7912c..2cbf1bd 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -57,7 +57,7 @@ static struct lock_class_key port_lock_key;
 
 static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 					struct ktermios *old_termios);
-static void __uart_wait_until_sent(struct uart_port *port, int timeout);
+static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
 static void uart_change_pm(struct uart_state *state, int pm_state);
 
 /*
@@ -1304,16 +1304,8 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	tty->closing = 1;
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE) {
-		/*
-		 * hack: open-coded tty_wait_until_sent to avoid
-		 * recursive tty_lock
-		 */
-		long timeout = msecs_to_jiffies(port->closing_wait);
-		if (wait_event_interruptible_timeout(tty->write_wait,
-				!tty_chars_in_buffer(tty), timeout) >= 0)
-			__uart_wait_until_sent(uport, timeout);
-	}
+	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, msecs_to_jiffies(port->closing_wait));
 
 	/*
 	 * At this point, we stop accepting input.  To do this, we
@@ -1329,7 +1321,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 		 * has completely drained; this is especially
 		 * important if there is a transmit FIFO!
 		 */
-		__uart_wait_until_sent(uport, uport->timeout);
+		uart_wait_until_sent(tty, uport->timeout);
 	}
 
 	uart_shutdown(tty, state);
@@ -1363,8 +1355,10 @@ done:
 	mutex_unlock(&port->mutex);
 }
 
-static void __uart_wait_until_sent(struct uart_port *port, int timeout)
+static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 {
+	struct uart_state *state = tty->driver_data;
+	struct uart_port *port = state->uart_port;
 	unsigned long char_time, expire;
 
 	if (port->type == PORT_UNKNOWN || port->fifosize == 0)
@@ -1416,16 +1410,6 @@ static void __uart_wait_until_sent(struct uart_port *port, int timeout)
 	}
 }
 
-static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
-{
-	struct uart_state *state = tty->driver_data;
-	struct uart_port *port = state->uart_port;
-
-	tty_lock();
-	__uart_wait_until_sent(port, timeout);
-	tty_unlock();
-}
-
 /*
  * This is called with the BKL held in
  *  linux/drivers/char/tty_io.c:do_tty_hangup()
-- 
1.7.7

