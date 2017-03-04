From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 08/10] serdev: add serdev_device_get_cts
Date: Sat,  4 Mar 2017 12:58:31 +0100
Message-ID: <20170304115833.3538-9-sre@kernel.org>
References: <20170304115833.3538-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170304115833.3538-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add method to get current CTS line state.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/tty/serdev/core.c           | 11 +++++++++++
 drivers/tty/serdev/serdev-ttyport.c | 15 +++++++++++++++
 include/linux/serdev.h              |  6 ++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index a63b74031e22..36eb3dfb1477 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -184,6 +184,17 @@ void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
 }
 EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
 
+bool serdev_device_get_cts(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->get_cts)
+		return false;
+
+	return ctrl->ops->get_cts(ctrl);
+}
+EXPORT_SYMBOL_GPL(serdev_device_get_cts);
+
 static int serdev_drv_probe(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index db2bc601e554..3eaca7560e2e 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -179,6 +179,20 @@ static void ttyport_wait_until_sent(struct serdev_controller *ctrl, long timeout
 	tty_wait_until_sent(tty, timeout);
 }
 
+static bool ttyport_get_cts(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+	int status;
+
+	if (!tty->ops->tiocmget)
+		return false;
+
+	status = tty->ops->tiocmget(tty);
+
+	return !!(status & TIOCM_CTS);
+}
+
 static const struct serdev_controller_ops ctrl_ops = {
 	.write_buf = ttyport_write_buf,
 	.write_flush = ttyport_write_flush,
@@ -188,6 +202,7 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.set_flow_control = ttyport_set_flow_control,
 	.set_baudrate = ttyport_set_baudrate,
 	.wait_until_sent = ttyport_wait_until_sent,
+	.get_cts = ttyport_get_cts,
 };
 
 struct device *serdev_tty_port_register(struct tty_port *port,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index a308b206d204..b0c47402d84a 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -82,6 +82,7 @@ struct serdev_controller_ops {
 	void (*set_flow_control)(struct serdev_controller *, bool);
 	unsigned int (*set_baudrate)(struct serdev_controller *, unsigned int);
 	void (*wait_until_sent)(struct serdev_controller *, long);
+	bool (*get_cts)(struct serdev_controller *);
 };
 
 /**
@@ -188,6 +189,7 @@ void serdev_device_close(struct serdev_device *);
 unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
 void serdev_device_set_flow_control(struct serdev_device *, bool);
 void serdev_device_wait_until_sent(struct serdev_device *, long);
+bool serdev_device_get_cts(struct serdev_device *);
 int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
 void serdev_device_write_flush(struct serdev_device *);
 int serdev_device_write_room(struct serdev_device *);
@@ -226,6 +228,10 @@ static inline unsigned int serdev_device_set_baudrate(struct serdev_device *sdev
 }
 static inline void serdev_device_set_flow_control(struct serdev_device *sdev, bool enable) {}
 static inline void serdev_device_wait_until_sent(struct serdev_device *sdev, long timeout) {}
+static inline bool serdev_device_get_cts(struct serdev_device *serdev)
+{
+	return false;
+}
 static inline int serdev_device_write_buf(struct serdev_device *sdev, const unsigned char *buf, size_t count)
 {
 	return -ENODEV;
-- 
2.11.0
