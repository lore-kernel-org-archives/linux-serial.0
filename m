From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 3/6] tty/pty: switch to tty_port helpers
Date: Fri, 15 Jun 2018 18:39:16 +0900
Message-ID: <20180615093919.559-4-sergey.senozhatsky@gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

Do not directly lock/unlock tty_port->lock, but use tty_port_lock
helper macros.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/tty/pty.c                |  4 ++--
 drivers/tty/serial/serial_core.c |  8 +++----
 drivers/tty/tty_port.c           | 38 ++++++++++++++++----------------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index b0e2c4847a5d..dddeecc2289e 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -116,13 +116,13 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 		return 0;
 
 	if (c > 0) {
-		spin_lock_irqsave(&to->port->lock, flags);
+		tty_port_lock_irqsave(&to->port->lock, flags);
 		/* Stuff the data into the input queue of the other end */
 		c = tty_insert_flip_string(to->port, buf, c);
 		/* And shovel */
 		if (c)
 			tty_flip_buffer_push(to->port);
-		spin_unlock_irqrestore(&to->port->lock, flags);
+		tty_port_unlock_irqrestore(&to->port->lock, flags);
 	}
 	return c;
 }
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9c14a453f73c..48b3377d7f77 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1480,9 +1480,9 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 
 		state = drv->state + tty->index;
 		port = &state->port;
-		spin_lock_irq(&port->lock);
+		tty_port_lock_irq(&port->lock);
 		--port->count;
-		spin_unlock_irq(&port->lock);
+		tty_port_unlock_irq(&port->lock);
 		return;
 	}
 
@@ -1603,9 +1603,9 @@ static void uart_hangup(struct tty_struct *tty)
 	if (tty_port_active(port)) {
 		uart_flush_buffer(tty);
 		uart_shutdown(tty, state);
-		spin_lock_irqsave(&port->lock, flags);
+		tty_port_lock_irqsave(&port->lock, flags);
 		port->count = 0;
-		spin_unlock_irqrestore(&port->lock, flags);
+		tty_port_unlock_irqrestore(&port->lock, flags);
 		tty_port_set_active(port, 0);
 		tty_port_tty_set(port, NULL);
 		if (uport && !uart_console(uport))
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 25d736880013..4237d282f89f 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -285,9 +285,9 @@ struct tty_struct *tty_port_tty_get(struct tty_port *port)
 	unsigned long flags;
 	struct tty_struct *tty;
 
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	tty = tty_kref_get(port->tty);
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 	return tty;
 }
 EXPORT_SYMBOL(tty_port_tty_get);
@@ -305,10 +305,10 @@ void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	tty_kref_put(port->tty);
 	port->tty = tty_kref_get(tty);
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 }
 EXPORT_SYMBOL(tty_port_tty_set);
 
@@ -349,13 +349,13 @@ void tty_port_hangup(struct tty_port *port)
 	struct tty_struct *tty;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	port->count = 0;
 	tty = port->tty;
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 	port->tty = NULL;
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 	tty_port_set_active(port, 0);
 	tty_port_shutdown(port, tty);
 	tty_kref_put(tty);
@@ -496,10 +496,10 @@ int tty_port_block_til_ready(struct tty_port *port,
 	retval = 0;
 
 	/* The port lock protects the port counts */
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	port->count--;
 	port->blocked_open++;
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 
 	while (1) {
 		/* Indicate we are open */
@@ -536,11 +536,11 @@ int tty_port_block_til_ready(struct tty_port *port,
 
 	/* Update counts. A parallel hangup will have set count to zero and
 	   we must not mess that up further */
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	if (!tty_hung_up_p(filp))
 		port->count++;
 	port->blocked_open--;
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 	if (retval == 0)
 		tty_port_set_active(port, 1);
 	return retval;
@@ -570,7 +570,7 @@ int tty_port_close_start(struct tty_port *port,
 	if (tty_hung_up_p(filp))
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	if (tty->count == 1 && port->count != 1) {
 		tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
 			 port->count);
@@ -583,10 +583,10 @@ int tty_port_close_start(struct tty_port *port,
 	}
 
 	if (port->count) {
-		spin_unlock_irqrestore(&port->lock, flags);
+		tty_port_unlock_irqrestore(&port->lock, flags);
 		return 0;
 	}
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 
 	tty->closing = 1;
 
@@ -615,16 +615,16 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 	tty_ldisc_flush(tty);
 	tty->closing = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 
 	if (port->blocked_open) {
-		spin_unlock_irqrestore(&port->lock, flags);
+		tty_port_unlock_irqrestore(&port->lock, flags);
 		if (port->close_delay)
 			msleep_interruptible(jiffies_to_msecs(port->close_delay));
-		spin_lock_irqsave(&port->lock, flags);
+		tty_port_lock_irqsave(&port->lock, flags);
 		wake_up_interruptible(&port->open_wait);
 	}
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 	tty_port_set_active(port, 0);
 }
 EXPORT_SYMBOL(tty_port_close_end);
@@ -675,9 +675,9 @@ EXPORT_SYMBOL_GPL(tty_port_install);
 int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 							struct file *filp)
 {
-	spin_lock_irq(&port->lock);
+	tty_port_lock_irq(&port->lock);
 	++port->count;
-	spin_unlock_irq(&port->lock);
+	tty_port_unlock_irq(&port->lock);
 	tty_port_tty_set(port, tty);
 
 	/*
-- 
2.17.1
