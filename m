From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 2/6] serdev: add multiplexer support
Date: Wed, 16 Aug 2017 15:22:24 +0200
Message-ID: <1502889748-31499-3-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Adds an interface for slave device multiplexing using the mux subsystem.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serdev/Kconfig  |  1 +
 drivers/tty/serdev/Makefile |  2 +-
 drivers/tty/serdev/core.c   | 13 ++++++++-
 drivers/tty/serdev/mux.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serdev.h      | 14 ++++++++--
 5 files changed, 92 insertions(+), 4 deletions(-)
 create mode 100644 drivers/tty/serdev/mux.c

diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
index cdc6b82..8fd75cb 100644
--- a/drivers/tty/serdev/Kconfig
+++ b/drivers/tty/serdev/Kconfig
@@ -3,6 +3,7 @@
 #
 menuconfig SERIAL_DEV_BUS
 	tristate "Serial device bus"
+	select MULTIPLEXER
 	help
 	  Core support for devices connected via a serial port.
 
diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
index 0cbdb94..abe5b2a 100644
--- a/drivers/tty/serdev/Makefile
+++ b/drivers/tty/serdev/Makefile
@@ -1,5 +1,5 @@
 serdev-objs := core.o
 
-obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o
+obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o mux.o
 
 obj-$(CONFIG_SERIAL_DEV_CTRL_TTYPORT) += serdev-ttyport.o
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 8491056..22acd08 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -307,7 +307,8 @@ struct serdev_device *serdev_device_alloc(struct serdev_controller *ctrl)
 		return NULL;
 
 	serdev->ctrl = ctrl;
-	ctrl->serdev = serdev;
+	if (!ctrl->serdev)
+		ctrl->serdev = serdev;
 	device_initialize(&serdev->dev);
 	serdev->dev.parent = &ctrl->dev;
 	serdev->dev.bus = &serdev_bus_type;
@@ -370,6 +371,7 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 	struct serdev_device *serdev = NULL;
 	int err;
 	bool found = false;
+	u32 reg;
 
 	for_each_available_child_of_node(ctrl->dev.of_node, node) {
 		if (!of_get_property(node, "compatible", NULL))
@@ -383,6 +385,11 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 
 		serdev->dev.of_node = node;
 
+		if (!of_property_read_u32(node, "reg", &reg)) {
+			serdev->mux_addr = reg;
+			serdev->nr = reg;
+		}
+
 		err = serdev_device_add(serdev);
 		if (err) {
 			dev_err(&serdev->dev,
@@ -416,6 +423,10 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 	if (ret)
 		return ret;
 
+	if (ctrl->dev.of_node &&
+	    of_serdev_register_mux(ctrl) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ret = of_serdev_register_devices(ctrl);
 	if (ret)
 		goto out_dev_del;
diff --git a/drivers/tty/serdev/mux.c b/drivers/tty/serdev/mux.c
new file mode 100644
index 0000000..fc9405b
--- /dev/null
+++ b/drivers/tty/serdev/mux.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2017 Ulrich Hecht
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/mux/consumer.h>
+#include <linux/mux/driver.h>
+#include <linux/of_gpio.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+
+int serdev_device_mux_select(struct serdev_device *serdev)
+{
+	struct mux_control *mux = serdev->ctrl->mux;
+	int ret;
+
+	if (!mux)
+		return -EINVAL;
+
+	ret = mux_control_select(mux, serdev->mux_addr);
+	serdev->ctrl->mux_do_not_deselect = ret < 0;
+
+	serdev->ctrl->serdev = serdev;
+
+	return ret;
+}
+
+int serdev_device_mux_deselect(struct serdev_device *serdev)
+{
+	struct mux_control *mux = serdev->ctrl->mux;
+
+	if (!mux)
+		return -EINVAL;
+
+	if (!serdev->ctrl->mux_do_not_deselect)
+		return mux_control_deselect(mux);
+	else
+		return 0;
+}
+
+int of_serdev_register_mux(struct serdev_controller *ctrl)
+{
+	struct mux_control *mux;
+	struct device *dev = &ctrl->dev;
+
+	mux = devm_mux_control_get(dev, NULL);
+
+	if (IS_ERR(mux)) {
+		if (PTR_ERR(mux) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get control mux\n");
+		return PTR_ERR(mux);
+	}
+
+	ctrl->mux = mux;
+
+	return 0;
+}
+
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 8f60f11..3ed0f75 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/termios.h>
 #include <linux/delay.h>
+#include <linux/rtmutex.h>
 
 struct serdev_controller;
 struct serdev_device;
@@ -51,6 +52,7 @@ struct serdev_device {
 	const struct serdev_device_ops *ops;
 	struct completion write_comp;
 	struct mutex write_lock;
+	int mux_addr;
 };
 
 static inline struct serdev_device *to_serdev_device(struct device *d)
@@ -82,6 +84,8 @@ enum serdev_parity {
 	SERDEV_PARITY_ODD,
 };
 
+int of_serdev_register_mux(struct serdev_controller *ctrl);
+
 /*
  * serdev controller structures
  */
@@ -103,14 +107,18 @@ struct serdev_controller_ops {
  * struct serdev_controller - interface to the serdev controller
  * @dev:	Driver model representation of the device.
  * @nr:		number identifier for this controller/bus.
- * @serdev:	Pointer to slave device for this controller.
+ * @serdev:	Pointer to active slave device for this controller.
  * @ops:	Controller operations.
+ * @mux:	Slave multiplexer control.
+ * @mux_do_not_deselect: Set if slave selection failed.
  */
 struct serdev_controller {
 	struct device		dev;
 	unsigned int		nr;
 	struct serdev_device	*serdev;
 	const struct serdev_controller_ops *ops;
+	struct mux_control	*mux;
+	int			mux_do_not_deselect;
 };
 
 static inline struct serdev_controller *to_serdev_controller(struct device *d)
@@ -190,7 +198,7 @@ static inline int serdev_controller_receive_buf(struct serdev_controller *ctrl,
 {
 	struct serdev_device *serdev = ctrl->serdev;
 
-	if (!serdev || !serdev->ops->receive_buf)
+	if (!serdev || !serdev->ops || !serdev->ops->receive_buf)
 		return -EINVAL;
 
 	return serdev->ops->receive_buf(serdev, data, count);
@@ -210,6 +218,8 @@ void serdev_device_write_wakeup(struct serdev_device *);
 int serdev_device_write(struct serdev_device *, const unsigned char *, size_t, unsigned long);
 void serdev_device_write_flush(struct serdev_device *);
 int serdev_device_write_room(struct serdev_device *);
+int serdev_device_mux_select(struct serdev_device *);
+int serdev_device_mux_deselect(struct serdev_device *);
 
 /*
  * serdev device driver functions
-- 
2.7.4
