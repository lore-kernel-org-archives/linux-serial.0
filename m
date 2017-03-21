From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 05/11] serdev: add serdev_device_wait_until_sent
Date: Tue, 21 Mar 2017 23:32:10 +0100
Message-ID: <20170321223216.11733-6-sre@kernel.org>
References: <20170321223216.11733-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321223216.11733-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add method, which waits until the transmission buffer has been sent.
Note, that the change in ttyport_write_wakeup is related, since
tty_wait_until_sent will hang without that change.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/tty/serdev/core.c           | 11 +++++++++++
 drivers/tty/serdev/serdev-ttyport.c | 15 ++++++++++++++-
 include/linux/serdev.h              |  3 +++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index f4c6c90add78..a63b74031e22 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -173,6 +173,17 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
 }
 EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
 
+void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->wait_until_sent)
+		return;
+
+	ctrl->ops->wait_until_sent(ctrl, timeout);
+}
+EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
+
 static int serdev_drv_probe(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index d05393594f15..db2bc601e554 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -14,6 +14,7 @@
 #include <linux/serdev.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
+#include <linux/poll.h>
 
 #define SERPORT_ACTIVE		1
 
@@ -47,10 +48,13 @@ static void ttyport_write_wakeup(struct tty_port *port)
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
 
 	if (!test_and_clear_bit(TTY_DO_WRITE_WAKEUP, &port->tty->flags))
-		return;
+		goto out;
 
 	if (test_bit(SERPORT_ACTIVE, &serport->flags))
 		serdev_controller_write_wakeup(ctrl);
+
+out:
+	wake_up_interruptible_poll(&port->tty->write_wait, POLLOUT);
 }
 
 static const struct tty_port_client_operations client_ops = {
@@ -167,6 +171,14 @@ static void ttyport_set_flow_control(struct serdev_controller *ctrl, bool enable
 	tty_set_termios(tty, &ktermios);
 }
 
+static void ttyport_wait_until_sent(struct serdev_controller *ctrl, long timeout)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	tty_wait_until_sent(tty, timeout);
+}
+
 static const struct serdev_controller_ops ctrl_ops = {
 	.write_buf = ttyport_write_buf,
 	.write_flush = ttyport_write_flush,
@@ -175,6 +187,7 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.close = ttyport_close,
 	.set_flow_control = ttyport_set_flow_control,
 	.set_baudrate = ttyport_set_baudrate,
+	.wait_until_sent = ttyport_wait_until_sent,
 };
 
 struct device *serdev_tty_port_register(struct tty_port *port,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 9519da6253a8..a308b206d204 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -81,6 +81,7 @@ struct serdev_controller_ops {
 	void (*close)(struct serdev_controller *);
 	void (*set_flow_control)(struct serdev_controller *, bool);
 	unsigned int (*set_baudrate)(struct serdev_controller *, unsigned int);
+	void (*wait_until_sent)(struct serdev_controller *, long);
 };
 
 /**
@@ -186,6 +187,7 @@ int serdev_device_open(struct serdev_device *);
 void serdev_device_close(struct serdev_device *);
 unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
 void serdev_device_set_flow_control(struct serdev_device *, bool);
+void serdev_device_wait_until_sent(struct serdev_device *, long);
 int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
 void serdev_device_write_flush(struct serdev_device *);
 int serdev_device_write_room(struct serdev_device *);
@@ -223,6 +225,7 @@ static inline unsigned int serdev_device_set_baudrate(struct serdev_device *sdev
 	return 0;
 }
 static inline void serdev_device_set_flow_control(struct serdev_device *sdev, bool enable) {}
+static inline void serdev_device_wait_until_sent(struct serdev_device *sdev, long timeout) {}
 static inline int serdev_device_write_buf(struct serdev_device *sdev, const unsigned char *buf, size_t count)
 {
 	return -ENODEV;
-- 
2.11.0
