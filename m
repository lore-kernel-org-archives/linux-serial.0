From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 1/6] serdev: add method to set parity
Date: Wed, 16 Aug 2017 15:22:23 +0200
Message-ID: <1502889748-31499-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Adds serdev_device_set_parity() and an implementation for ttyport.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serdev/core.c           | 12 ++++++++++++
 drivers/tty/serdev/serdev-ttyport.c | 18 ++++++++++++++++++
 include/linux/serdev.h              | 10 ++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index ae1aaa0..8491056 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -242,6 +242,18 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
 }
 EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
 
+int serdev_device_set_parity(struct serdev_device *serdev,
+			     enum serdev_parity parity)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->set_parity)
+		return -ENOTSUPP;
+
+	return ctrl->ops->set_parity(ctrl, parity);
+}
+EXPORT_SYMBOL_GPL(serdev_device_set_parity);
+
 static int serdev_drv_probe(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 302018d..2883f12 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -195,6 +195,23 @@ static int ttyport_set_tiocm(struct serdev_controller *ctrl, unsigned int set, u
 	return tty->driver->ops->tiocmset(tty, set, clear);
 }
 
+static int ttyport_set_parity(struct serdev_controller *ctrl,
+			      enum serdev_parity parity)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+	struct ktermios ktermios = tty->termios;
+
+	ktermios.c_cflag &= ~(PARENB | PARODD);
+	if (parity != SERDEV_PARITY_NONE) {
+		ktermios.c_cflag |= PARENB;
+		if (parity == SERDEV_PARITY_ODD)
+			ktermios.c_cflag |= PARODD;
+	}
+
+	return tty_set_termios(tty, &ktermios);
+}
+
 static const struct serdev_controller_ops ctrl_ops = {
 	.write_buf = ttyport_write_buf,
 	.write_flush = ttyport_write_flush,
@@ -206,6 +223,7 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.wait_until_sent = ttyport_wait_until_sent,
 	.get_tiocm = ttyport_get_tiocm,
 	.set_tiocm = ttyport_set_tiocm,
+	.set_parity = ttyport_set_parity,
 };
 
 struct device *serdev_tty_port_register(struct tty_port *port,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index e69402d..8f60f11 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -76,6 +76,12 @@ static inline struct serdev_device_driver *to_serdev_device_driver(struct device
 	return container_of(d, struct serdev_device_driver, driver);
 }
 
+enum serdev_parity {
+	SERDEV_PARITY_NONE,
+	SERDEV_PARITY_EVEN,
+	SERDEV_PARITY_ODD,
+};
+
 /*
  * serdev controller structures
  */
@@ -90,6 +96,7 @@ struct serdev_controller_ops {
 	void (*wait_until_sent)(struct serdev_controller *, long);
 	int (*get_tiocm)(struct serdev_controller *);
 	int (*set_tiocm)(struct serdev_controller *, unsigned int, unsigned int);
+	int (*set_parity)(struct serdev_controller *, enum serdev_parity);
 };
 
 /**
@@ -298,6 +305,9 @@ static inline int serdev_device_set_rts(struct serdev_device *serdev, bool enabl
 		return serdev_device_set_tiocm(serdev, 0, TIOCM_RTS);
 }
 
+int serdev_device_set_parity(struct serdev_device *serdev,
+			     enum serdev_parity parity);
+
 /*
  * serdev hooks into TTY core
  */
-- 
2.7.4
