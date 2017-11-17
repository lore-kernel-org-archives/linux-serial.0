From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v1 1/8] serdev: implement parity configuration
Date: Fri, 17 Nov 2017 23:35:36 +0100
Message-ID: <20171117223543.32429-2-martin.blumenstingl@googlemail.com>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171117223543.32429-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Some Bluetooth modules (for example the ones found in Realtek RTL8723BS
and RTL8723DS) want to communicate with the host with even parity
enabled.
Add a new function and the corresponding internal callbacks so parity
can be configured. This supports enabling and disabling parity as well
as setting the type to odd or even.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/tty/serdev/core.c           | 12 ++++++++++++
 drivers/tty/serdev/serdev-ttyport.c | 21 +++++++++++++++++++++
 include/linux/serdev.h              |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 1bef39828ca7..d327b02980f5 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -225,6 +225,18 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
 }
 EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
 
+void serdev_device_set_parity(struct serdev_device *serdev, bool enable,
+			      bool odd)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->set_parity)
+		return;
+
+	ctrl->ops->set_parity(ctrl, enable, odd);
+}
+EXPORT_SYMBOL_GPL(serdev_device_set_parity);
+
 void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index ce7ad0acee7a..418548ba8992 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -170,6 +170,26 @@ static void ttyport_set_flow_control(struct serdev_controller *ctrl, bool enable
 	tty_set_termios(tty, &ktermios);
 }
 
+static void ttyport_set_parity(struct serdev_controller *ctrl, bool enable,
+			       bool odd)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+	struct ktermios ktermios = tty->termios;
+
+	if (enable)
+		ktermios.c_cflag |= PARENB;
+	else
+		ktermios.c_cflag &= ~PARENB;
+
+	if (odd)
+		ktermios.c_cflag |= PARODD;
+	else
+		ktermios.c_cflag &= ~PARODD;
+
+	tty_set_termios(tty, &ktermios);
+}
+
 static void ttyport_wait_until_sent(struct serdev_controller *ctrl, long timeout)
 {
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
@@ -207,6 +227,7 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.open = ttyport_open,
 	.close = ttyport_close,
 	.set_flow_control = ttyport_set_flow_control,
+	.set_parity = ttyport_set_parity,
 	.set_baudrate = ttyport_set_baudrate,
 	.wait_until_sent = ttyport_wait_until_sent,
 	.get_tiocm = ttyport_get_tiocm,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index e69402d4a8ae..ccc541aa5c70 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -86,6 +86,7 @@ struct serdev_controller_ops {
 	int (*open)(struct serdev_controller *);
 	void (*close)(struct serdev_controller *);
 	void (*set_flow_control)(struct serdev_controller *, bool);
+	void (*set_parity)(struct serdev_controller *, bool, bool);
 	unsigned int (*set_baudrate)(struct serdev_controller *, unsigned int);
 	void (*wait_until_sent)(struct serdev_controller *, long);
 	int (*get_tiocm)(struct serdev_controller *);
@@ -195,6 +196,7 @@ int serdev_device_open(struct serdev_device *);
 void serdev_device_close(struct serdev_device *);
 unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
 void serdev_device_set_flow_control(struct serdev_device *, bool);
+void serdev_device_set_parity(struct serdev_device *, bool, bool);
 int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
 void serdev_device_wait_until_sent(struct serdev_device *, long);
 int serdev_device_get_tiocm(struct serdev_device *);
@@ -237,6 +239,7 @@ static inline unsigned int serdev_device_set_baudrate(struct serdev_device *sdev
 	return 0;
 }
 static inline void serdev_device_set_flow_control(struct serdev_device *sdev, bool enable) {}
+static inline void serdev_device_set_parity(struct serdev_device *, bool, bool) {}
 static inline int serdev_device_write_buf(struct serdev_device *serdev,
 					  const unsigned char *buf,
 					  size_t count)
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
