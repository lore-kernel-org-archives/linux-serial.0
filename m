From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] serdev: Restore serdev_device_write_buf for atomic context
Date: Fri, 28 Apr 2017 13:47:21 +0200
Message-ID: <1493380041-14710-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
List-Id: linux-serial@vger.kernel.org

Starting with commit 6fe729c4bdae ("serdev: Add serdev_device_write
subroutine") the function serdev_device_write_buf cannot be used in
atomic context anymore (mutex_lock is sleeping). So restore the old
behavior.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 6fe729c4bdae ("serdev: Add serdev_device_write subroutine")
---
 drivers/tty/serdev/core.c | 12 ++++++++++++
 include/linux/serdev.h    | 14 +++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 433de5e..f71b473 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -122,6 +122,18 @@ void serdev_device_write_wakeup(struct serdev_device *serdev)
 }
 EXPORT_SYMBOL_GPL(serdev_device_write_wakeup);
 
+int serdev_device_write_buf(struct serdev_device *serdev,
+			    const unsigned char *buf, size_t count)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->write_buf)
+		return -EINVAL;
+
+	return ctrl->ops->write_buf(ctrl, buf, count);
+}
+EXPORT_SYMBOL_GPL(serdev_device_write_buf);
+
 int serdev_device_write(struct serdev_device *serdev,
 			const unsigned char *buf, size_t count,
 			unsigned long timeout)
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index cda76c6..e2a225b 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -195,6 +195,7 @@ int serdev_device_open(struct serdev_device *);
 void serdev_device_close(struct serdev_device *);
 unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
 void serdev_device_set_flow_control(struct serdev_device *, bool);
+int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
 void serdev_device_wait_until_sent(struct serdev_device *, long);
 int serdev_device_get_tiocm(struct serdev_device *);
 int serdev_device_set_tiocm(struct serdev_device *, int, int);
@@ -236,6 +237,12 @@ static inline unsigned int serdev_device_set_baudrate(struct serdev_device *sdev
 	return 0;
 }
 static inline void serdev_device_set_flow_control(struct serdev_device *sdev, bool enable) {}
+static inline int serdev_device_write_buf(struct serdev_device *serdev,
+					  const unsigned char *buf,
+					  size_t count)
+{
+	return -ENODEV;
+}
 static inline void serdev_device_wait_until_sent(struct serdev_device *sdev, long timeout) {}
 static inline int serdev_device_get_tiocm(struct serdev_device *serdev)
 {
@@ -312,11 +319,4 @@ static inline struct device *serdev_tty_port_register(struct tty_port *port,
 static inline void serdev_tty_port_unregister(struct tty_port *port) {}
 #endif /* CONFIG_SERIAL_DEV_CTRL_TTYPORT */
 
-static inline int serdev_device_write_buf(struct serdev_device *serdev,
-					  const unsigned char *data,
-					  size_t count)
-{
-	return serdev_device_write(serdev, data, count, 0);
-}
-
 #endif /*_LINUX_SERDEV_H */
-- 
2.1.4
