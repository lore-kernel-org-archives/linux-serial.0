From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2] serdev: add method to set parity
Date: Mon, 22 Jan 2018 18:56:32 +0100
Message-ID: <1516643792-22840-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: marcel@holtmann.org
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, johan@kernel.org, sre@kernel.org, linux-bluetooth@vger.kernel.org, robh@kernel.org, martin.blumenstingl@googlemail.com, gregkh@linuxfoundation.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, geert@linux-m68k.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Adds serdev_device_set_parity() and an implementation for ttyport.
The interface uses an enum with the values SERIAL_PARITY_NONE,
SERIAL_PARITY_EVEN and SERIAL_PARITY_ODD.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---

Hi!

This revision addresses Johan's comments (see below for details) and adds
Sebastian's Reviewed-by tag. Thank you for your reviews!

CU
Uli


Changes since v1:
- added Reviewed-by tag
- expanded commit message
- shuffled stuff around to keep line-setting bits together
- clear CMSPAR
- (hopefully) detect errors correctly by checking tty->termios after call
  to tty_set_termios().


 drivers/tty/serdev/core.c           | 12 ++++++++++++
 drivers/tty/serdev/serdev-ttyport.c | 24 ++++++++++++++++++++++++
 include/linux/serdev.h              | 10 ++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 5dc88f6..ceee0ca 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -257,6 +257,18 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
 }
 EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
 
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
 void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index a5abb05..fa16729 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -194,6 +194,29 @@ static void ttyport_set_flow_control(struct serdev_controller *ctrl, bool enable
 	tty_set_termios(tty, &ktermios);
 }
 
+static int ttyport_set_parity(struct serdev_controller *ctrl,
+			      enum serdev_parity parity)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+	struct ktermios ktermios = tty->termios;
+
+	ktermios.c_cflag &= ~(PARENB | PARODD | CMSPAR);
+	if (parity != SERDEV_PARITY_NONE) {
+		ktermios.c_cflag |= PARENB;
+		if (parity == SERDEV_PARITY_ODD)
+			ktermios.c_cflag |= PARODD;
+	}
+
+	tty_set_termios(tty, &ktermios);
+
+	if ((tty->termios.c_cflag & (PARENB | PARODD | CMSPAR)) !=
+	    (ktermios.c_cflag & (PARENB | PARODD | CMSPAR)))
+		return -EINVAL;
+
+	return 0;
+}
+
 static void ttyport_wait_until_sent(struct serdev_controller *ctrl, long timeout)
 {
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
@@ -231,6 +254,7 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.open = ttyport_open,
 	.close = ttyport_close,
 	.set_flow_control = ttyport_set_flow_control,
+	.set_parity = ttyport_set_parity,
 	.set_baudrate = ttyport_set_baudrate,
 	.wait_until_sent = ttyport_wait_until_sent,
 	.get_tiocm = ttyport_get_tiocm,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 48d8ce2..f153b2c 100644
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
@@ -88,6 +94,7 @@ struct serdev_controller_ops {
 	int (*open)(struct serdev_controller *);
 	void (*close)(struct serdev_controller *);
 	void (*set_flow_control)(struct serdev_controller *, bool);
+	int (*set_parity)(struct serdev_controller *, enum serdev_parity);
 	unsigned int (*set_baudrate)(struct serdev_controller *, unsigned int);
 	void (*wait_until_sent)(struct serdev_controller *, long);
 	int (*get_tiocm)(struct serdev_controller *);
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
