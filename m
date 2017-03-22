From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2.1] serdev: implement get/set tiocm
Date: Wed, 22 Mar 2017 01:58:37 +0100
Message-ID: <20170322005837.6047-1-sre@kernel.org>
References: <20170321223216.11733-7-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321223216.11733-7-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add method for getting and setting tiocm.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Changes since PATCHv2:
 * fix serdev_device_set_tiocm inline definition for disabled SERDEV
 * use <linux/termios.h> instead of <asm-generic/termios.h>
---
 drivers/tty/serdev/core.c           | 22 ++++++++++++++++++++++
 drivers/tty/serdev/serdev-ttyport.c | 24 ++++++++++++++++++++++++
 include/linux/serdev.h              | 13 +++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index a63b74031e22..1e1cbae3a0ea 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -184,6 +184,28 @@ void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
 }
 EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
 
+int serdev_device_get_tiocm(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->get_tiocm)
+		return -ENOTSUPP;
+
+	return ctrl->ops->get_tiocm(ctrl);
+}
+EXPORT_SYMBOL_GPL(serdev_device_get_tiocm);
+
+int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->set_tiocm)
+		return -ENOTSUPP;
+
+	return ctrl->ops->set_tiocm(ctrl, set, clear);
+}
+EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
+
 static int serdev_drv_probe(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index db2bc601e554..c5bdb901ff11 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -179,6 +179,28 @@ static void ttyport_wait_until_sent(struct serdev_controller *ctrl, long timeout
 	tty_wait_until_sent(tty, timeout);
 }
 
+static int ttyport_get_tiocm(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	if (!tty->ops->tiocmget)
+		return -ENOTSUPP;
+
+	return tty->driver->ops->tiocmget(tty);
+}
+
+static int ttyport_set_tiocm(struct serdev_controller *ctrl, unsigned int set, unsigned int clear)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	if (!tty->ops->tiocmset)
+		return -ENOTSUPP;
+
+	return tty->driver->ops->tiocmset(tty, set, clear);
+}
+
 static const struct serdev_controller_ops ctrl_ops = {
 	.write_buf = ttyport_write_buf,
 	.write_flush = ttyport_write_flush,
@@ -188,6 +210,8 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.set_flow_control = ttyport_set_flow_control,
 	.set_baudrate = ttyport_set_baudrate,
 	.wait_until_sent = ttyport_wait_until_sent,
+	.get_tiocm = ttyport_get_tiocm,
+	.set_tiocm = ttyport_set_tiocm,
 };
 
 struct device *serdev_tty_port_register(struct tty_port *port,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index a308b206d204..e29a270f603c 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -15,6 +15,7 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/termios.h>
 
 struct serdev_controller;
 struct serdev_device;
@@ -82,6 +83,8 @@ struct serdev_controller_ops {
 	void (*set_flow_control)(struct serdev_controller *, bool);
 	unsigned int (*set_baudrate)(struct serdev_controller *, unsigned int);
 	void (*wait_until_sent)(struct serdev_controller *, long);
+	int (*get_tiocm)(struct serdev_controller *);
+	int (*set_tiocm)(struct serdev_controller *, unsigned int, unsigned int);
 };
 
 /**
@@ -188,6 +191,8 @@ void serdev_device_close(struct serdev_device *);
 unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
 void serdev_device_set_flow_control(struct serdev_device *, bool);
 void serdev_device_wait_until_sent(struct serdev_device *, long);
+int serdev_device_get_tiocm(struct serdev_device *);
+int serdev_device_set_tiocm(struct serdev_device *, int, int);
 int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
 void serdev_device_write_flush(struct serdev_device *);
 int serdev_device_write_room(struct serdev_device *);
@@ -226,6 +231,14 @@ static inline unsigned int serdev_device_set_baudrate(struct serdev_device *sdev
 }
 static inline void serdev_device_set_flow_control(struct serdev_device *sdev, bool enable) {}
 static inline void serdev_device_wait_until_sent(struct serdev_device *sdev, long timeout) {}
+static inline int serdev_device_get_tiocm(struct serdev_device *serdev)
+{
+	return -ENOTSUPP;
+}
+static inline int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
+{
+	return -ENOTSUPP;
+}
 static inline int serdev_device_write_buf(struct serdev_device *sdev, const unsigned char *buf, size_t count)
 {
 	return -ENODEV;
-- 
2.11.0
