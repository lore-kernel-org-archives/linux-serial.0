From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 5/8] tty: Replace ASYNC_SUSPENDED bit and update atomically
Date: Sat,  9 Apr 2016 17:53:24 -0700
Message-ID: <1460249607-8014-6-git-send-email-peter@hurleysoftware.com>
References: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Grant Edwards <grant.b.edwards@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Replace ASYNC_SUSPENDED bit in the tty_port::flags field with
TTY_PORT_SUSPENDED bit in the tty_port::iflags field. Introduce helpers
tty_port_set_suspended() and tty_port_suspended() to abstract
atomic bit ops.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/s390/char/con3215.c      | 12 ++++++------
 drivers/tty/serial/serial_core.c |  8 ++++----
 include/linux/tty.h              | 13 +++++++++++++
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index e7e078b..114fe28 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -289,7 +289,7 @@ static void raw3215_timeout(unsigned long __data)
 
 	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 	raw->flags &= ~RAW3215_TIMER_RUNS;
-	if (!(raw->port.flags & ASYNC_SUSPENDED)) {
+	if (!tty_port_suspended(&raw->port)) {
 		raw3215_mk_write_req(raw);
 		raw3215_start_io(raw);
 		if ((raw->queued_read || raw->queued_write) &&
@@ -312,7 +312,7 @@ static void raw3215_timeout(unsigned long __data)
 static inline void raw3215_try_io(struct raw3215_info *raw)
 {
 	if (!(raw->port.flags & ASYNC_INITIALIZED) ||
-			(raw->port.flags & ASYNC_SUSPENDED))
+	    tty_port_suspended(&raw->port))
 		return;
 	if (raw->queued_read != NULL)
 		raw3215_start_io(raw);
@@ -494,7 +494,7 @@ static void raw3215_make_room(struct raw3215_info *raw, unsigned int length)
 		/* While console is frozen for suspend we have no other
 		 * choice but to drop message from the buffer to make
 		 * room for even more messages. */
-		if (raw->port.flags & ASYNC_SUSPENDED) {
+		if (tty_port_suspended(&raw->port)) {
 			raw3215_drop_line(raw);
 			continue;
 		}
@@ -773,7 +773,7 @@ static int raw3215_pm_stop(struct ccw_device *cdev)
 	raw = dev_get_drvdata(&cdev->dev);
 	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 	raw3215_make_room(raw, RAW3215_BUFFER_SIZE);
-	raw->port.flags |= ASYNC_SUSPENDED;
+	tty_port_set_suspended(&raw->port, 1);
 	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 	return 0;
 }
@@ -786,7 +786,7 @@ static int raw3215_pm_start(struct ccw_device *cdev)
 	/* Allow I/O again and flush output buffer. */
 	raw = dev_get_drvdata(&cdev->dev);
 	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
-	raw->port.flags &= ~ASYNC_SUSPENDED;
+	tty_port_set_suspended(&raw->port, 0);
 	raw->flags |= RAW3215_FLUSHING;
 	raw3215_try_io(raw);
 	raw->flags &= ~RAW3215_FLUSHING;
@@ -859,7 +859,7 @@ static void con3215_flush(void)
 	unsigned long flags;
 
 	raw = raw3215[0];  /* console 3215 is the first one */
-	if (raw->port.flags & ASYNC_SUSPENDED)
+	if (tty_port_suspended(&raw->port))
 		/* The console is still frozen for suspend. */
 		if (ccw_device_force_console(raw->cdev))
 			/* Forcing didn't work, no panic message .. */
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2471380..9336067 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -249,7 +249,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	 * a DCD drop (hangup) at just the right time.  Clear suspended bit so
 	 * we don't try to resume a port that has been shutdown.
 	 */
-	clear_bit(ASYNCB_SUSPENDED, &port->flags);
+	tty_port_set_suspended(port, 0);
 
 	/*
 	 * Free the transmit buffer page.
@@ -2007,7 +2007,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		const struct uart_ops *ops = uport->ops;
 		int tries;
 
-		set_bit(ASYNCB_SUSPENDED, &port->flags);
+		tty_port_set_suspended(port, 1);
 		clear_bit(ASYNCB_INITIALIZED, &port->flags);
 
 		spin_lock_irq(&uport->lock);
@@ -2088,7 +2088,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			console_start(uport->cons);
 	}
 
-	if (port->flags & ASYNC_SUSPENDED) {
+	if (tty_port_suspended(port)) {
 		const struct uart_ops *ops = uport->ops;
 		int ret;
 
@@ -2118,7 +2118,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			}
 		}
 
-		clear_bit(ASYNCB_SUSPENDED, &port->flags);
+		tty_port_set_suspended(port, 0);
 	}
 
 	mutex_unlock(&port->mutex);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 4254dfb..7ac5add 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -597,6 +597,19 @@ static inline void tty_port_set_check_carrier(struct tty_port *port, bool val)
 		clear_bit(TTY_PORT_CHECK_CD, &port->iflags);
 }
 
+static inline bool tty_port_suspended(struct tty_port *port)
+{
+	return test_bit(TTY_PORT_SUSPENDED, &port->iflags);
+}
+
+static inline void tty_port_set_suspended(struct tty_port *port, bool val)
+{
+	if (val)
+		set_bit(TTY_PORT_SUSPENDED, &port->iflags);
+	else
+		clear_bit(TTY_PORT_SUSPENDED, &port->iflags);
+}
+
 extern struct tty_struct *tty_port_tty_get(struct tty_port *port);
 extern void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
 extern int tty_port_carrier_raised(struct tty_port *port);
-- 
2.8.1
