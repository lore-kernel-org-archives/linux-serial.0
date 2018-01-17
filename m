From: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] serdev: add method to set parity
Date: Wed, 17 Jan 2018 16:42:19 +0100
Message-ID: <1516203739-4705-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Adds serdev_device_set_parity() and an implementation for ttyport.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Broken out of the "[PATCH 0/6] serdev multiplexing support" series
because this kind of functionality is apparently also required
for "[RFC v2 0/9] Realtek Bluetooth serdev support (H5 protocol)",
which contains an earlier revision of this patch.

CU
Uli


 drivers/tty/serdev/core.c           | 12 ++++++++++++
 drivers/tty/serdev/serdev-ttyport.c | 18 ++++++++++++++++++
 include/linux/serdev.h              | 10 ++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 5dc88f6..1f25896 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -290,6 +290,18 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
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
index a5abb05..710e9a9 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -224,6 +224,23 @@ static int ttyport_set_tiocm(struct serdev_controller *ctrl, unsigned int set, u
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
@@ -235,6 +252,7 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.wait_until_sent = ttyport_wait_until_sent,
 	.get_tiocm = ttyport_get_tiocm,
 	.set_tiocm = ttyport_set_tiocm,
+	.set_parity = ttyport_set_parity,
 };
 
 struct device *serdev_tty_port_register(struct tty_port *port,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 48d8ce2..4dd3cb7 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -78,6 +78,12 @@ static inline struct serdev_device_driver *to_serdev_device_driver(struct device
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
@@ -92,6 +98,7 @@ struct serdev_controller_ops {
 	void (*wait_until_sent)(struct serdev_controller *, long);
 	int (*get_tiocm)(struct serdev_controller *);
 	int (*set_tiocm)(struct serdev_controller *, unsigned int, unsigned int);
+	int (*set_parity)(struct serdev_controller *, enum serdev_parity);
 };
 
 /**
@@ -301,6 +308,9 @@ static inline int serdev_device_set_rts(struct serdev_device *serdev, bool enabl
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
