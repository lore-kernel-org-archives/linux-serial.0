From: Aristeu Rozanski <aris@ruivo.org>
Subject: [PATCH RFC 1/6] serial_core: add termiox support
Date: Tue, 30 Sep 2008 14:41:56 -0400
Message-ID: <20080930184156.291954353@ruivo.org>
References: <20080930184155.944902515@ruivo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([66.92.68.119]:54567 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbYI3SmR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Sep 2008 14:42:17 -0400
Received: from jake.ruivo.org (gw.qemu.cathedral [192.168.72.1])
	by lobo.ruivo.org (Postfix) with ESMTP id 6F072526D7
	for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2008 14:41:55 -0400 (EDT)
Content-Disposition: inline; filename=serial_core-add_settermiosx.patch
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This patch adds support for termiox on serial_core and implements allocation
and freeing of termiox structure in tty_struct if the driver has support for
termiox

Signed-off-by: Aristeu Rozanski <aris@redhat.com>

---
 drivers/char/tty_io.c        |   82 ++++++++++++++++++++++++++++++++++++++-----
 drivers/serial/serial_core.c |   13 ++++++
 include/linux/serial_core.h  |    2 +
 include/linux/tty_driver.h   |    1 
 4 files changed, 90 insertions(+), 8 deletions(-)

--- linux-next.orig/drivers/serial/serial_core.c	2008-09-25 11:50:12.000000000 -0400
+++ linux-next/drivers/serial/serial_core.c	2008-09-25 11:50:49.000000000 -0400
@@ -2292,6 +2292,16 @@ static void uart_poll_put_char(struct tt
 }
 #endif
 
+#ifdef TCSETX
+static int uart_set_termiox(struct tty_struct *tty, struct termiox *new)
+{
+	tty->termiox->x_cflag = new->x_cflag &
+				(RTSXOFF | CTSXON | DTRXOFF | DSRXON);
+
+	return 0;
+}
+#endif
+
 static const struct tty_operations uart_ops = {
 	.open		= uart_open,
 	.close		= uart_close,
@@ -2322,6 +2332,9 @@ static const struct tty_operations uart_
 	.poll_get_char	= uart_poll_get_char,
 	.poll_put_char	= uart_poll_put_char,
 #endif
+#ifdef TCSETX
+	.set_termiox	= uart_set_termiox,
+#endif
 };
 
 /**
--- linux-next.orig/include/linux/serial_core.h	2008-09-25 11:50:12.000000000 -0400
+++ linux-next/include/linux/serial_core.h	2008-09-25 11:50:14.000000000 -0400
@@ -190,6 +190,8 @@ struct uart_ops {
 	void		(*flush_buffer)(struct uart_port *);
 	void		(*set_termios)(struct uart_port *, struct ktermios *new,
 				       struct ktermios *old);
+	void		(*set_termiox)(struct uart_port *, struct termiox *new,
+				       struct termiox *old);
 	void		(*set_ldisc)(struct uart_port *);
 	void		(*pm)(struct uart_port *, unsigned int state,
 			      unsigned int oldstate);
--- linux-next.orig/drivers/char/tty_io.c	2008-09-25 11:50:12.000000000 -0400
+++ linux-next/drivers/char/tty_io.c	2008-09-25 11:50:14.000000000 -0400
@@ -1257,6 +1257,32 @@ int tty_init_termios(struct tty_struct *
 }
 
 /**
+ *	tty_init_termiox()	- allocates a termiox structure if needed
+ *	@tty: tty to be set up
+ *
+ *	If the driver supports it, initialize the termiox structure
+ */
+static int tty_init_termiox(struct tty_struct *tty)
+{
+	struct termiox *tp;
+	int idx = tty->index;
+
+	if (tty->driver->ops->set_termiox == NULL)
+		return 0;
+
+	tp = tty->driver->termiox[idx];
+	if (tp == NULL) {
+		tp = kzalloc(sizeof(struct termiox), GFP_KERNEL);
+		if (tp == NULL)
+			return -ENOMEM;
+		tty->driver->termiox[idx] = tp;
+	}
+	tty->termiox = tp;
+
+	return 0;
+}
+
+/**
  *	tty_driver_install_tty() - install a tty entry in the driver
  *	@driver: the driver for the tty
  *	@tty: the tty
@@ -1276,13 +1302,19 @@ static int tty_driver_install_tty(struct
 	if (driver->ops->install)
 		return driver->ops->install(driver, tty);
 
-	if (tty_init_termios(tty) == 0) {
-		tty_driver_kref_get(driver);
-		tty->count++;
-		driver->ttys[idx] = tty;
-		return 0;
+	if (tty_init_termios(tty) != 0)
+		return -ENOMEM;
+
+	if (tty_init_termiox(tty) != 0) {
+		tty_free_termios(tty);
+		return -ENOMEM;
 	}
-	return -ENOMEM;
+
+	tty_driver_kref_get(driver);
+	tty->count++;
+	driver->ttys[idx] = tty;
+
+	return 0;
 }
 
 /**
@@ -1436,10 +1468,24 @@ void tty_free_termios(struct tty_struct 
 }
 EXPORT_SYMBOL(tty_free_termios);
 
+void tty_free_termiox(struct tty_struct *tty)
+{
+	struct termiox *tp;
+	int idx = tty->index;
+
+	if (tty->driver->ops->set_termiox) {
+		tp = tty->termiox;
+		tty->driver->termiox[idx] = NULL;
+		kfree(tp);
+	}
+}
+EXPORT_SYMBOL(tty_free_termiox);
+
 void tty_shutdown(struct tty_struct *tty)
 {
 	tty_driver_remove_tty(tty->driver, tty);
 	tty_free_termios(tty);
+	tty_free_termiox(tty);
 }
 EXPORT_SYMBOL(tty_shutdown);
 
@@ -2892,6 +2938,7 @@ static void destruct_tty_driver(struct k
 	struct tty_driver *driver = container_of(kref, struct tty_driver, kref);
 	int i;
 	struct ktermios *tp;
+	struct termiox *tx;
 	void *p;
 
 	if (driver->flags & TTY_DRIVER_INSTALLED) {
@@ -2909,10 +2956,22 @@ static void destruct_tty_driver(struct k
 			if (!(driver->flags & TTY_DRIVER_DYNAMIC_DEV))
 				tty_unregister_device(driver, i);
 		}
+
+		if (driver->ops->set_termiox) {
+			for (i = 0; i < driver->num; i++) {
+				tx = driver->termiox[i];
+				if (tx) {
+					driver->termiox[i] = NULL;
+					kfree(tx);
+				}
+			}
+		}
+
 		p = driver->ttys;
 		proc_tty_unregister_driver(driver);
 		driver->ttys = NULL;
 		driver->termios = NULL;
+		driver->termiox = NULL;
 		kfree(p);
 		cdev_del(&driver->cdev);
 	}
@@ -2944,12 +3003,15 @@ EXPORT_SYMBOL(put_tty_driver);
 int tty_register_driver(struct tty_driver *driver)
 {
 	int error;
-	int i;
+	int i, size;
 	dev_t dev;
 	void **p = NULL;
 
 	if (!(driver->flags & TTY_DRIVER_DEVPTS_MEM) && driver->num) {
-		p = kzalloc(driver->num * 2 * sizeof(void *), GFP_KERNEL);
+		size = driver->num * 2 * sizeof(void *);
+		if (driver->ops->set_termiox)
+			size += driver->num * sizeof(void *);
+		p = kzalloc(size, GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
 	}
@@ -2973,9 +3035,12 @@ int tty_register_driver(struct tty_drive
 	if (p) {
 		driver->ttys = (struct tty_struct **)p;
 		driver->termios = (struct ktermios **)(p + driver->num);
+		if (driver->ops->set_termiox)
+			driver->termiox = (struct termiox **)(p + 2 * driver->num);
 	} else {
 		driver->ttys = NULL;
 		driver->termios = NULL;
+		driver->termiox = NULL;
 	}
 
 	cdev_init(&driver->cdev, &tty_fops);
@@ -2985,6 +3050,7 @@ int tty_register_driver(struct tty_drive
 		unregister_chrdev_region(dev, driver->num);
 		driver->ttys = NULL;
 		driver->termios = NULL;
+		driver->termiox = NULL;
 		kfree(p);
 		return error;
 	}
--- linux-next.orig/include/linux/tty_driver.h	2008-09-25 11:50:12.000000000 -0400
+++ linux-next/include/linux/tty_driver.h	2008-09-25 11:50:14.000000000 -0400
@@ -293,6 +293,7 @@ struct tty_driver {
 	struct tty_struct **ttys;
 	struct ktermios **termios;
 	struct ktermios **termios_locked;
+	struct termiox **termiox;
 	void *driver_state;
 
 	/*

-- 
Aristeu

