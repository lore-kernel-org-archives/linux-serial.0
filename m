From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [RFC 2/4] serdev: add GPIO-based multiplexer support
Date: Wed, 14 Jun 2017 16:38:48 +0200
Message-ID: <1497451130-7741-3-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1497451130-7741-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1497451130-7741-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: robh@kernel.org, linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Adds an interface for slave device multiplexing, and an implementation
for GPIO-based multiplexers.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serdev/Kconfig    |  3 ++
 drivers/tty/serdev/Makefile   |  1 +
 drivers/tty/serdev/core.c     | 43 ++++++++++++++++++++++-
 drivers/tty/serdev/mux-gpio.c | 80 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/serdev.h        | 26 ++++++++++++--
 5 files changed, 149 insertions(+), 4 deletions(-)
 create mode 100644 drivers/tty/serdev/mux-gpio.c

diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
index cdc6b82..7946eeb 100644
--- a/drivers/tty/serdev/Kconfig
+++ b/drivers/tty/serdev/Kconfig
@@ -13,4 +13,7 @@ config SERIAL_DEV_CTRL_TTYPORT
 	depends on TTY
 	depends on SERIAL_DEV_BUS != m
 
+config SERIAL_DEV_MUX_GPIO
+	bool "Serial device GPIO multiplexer"
+
 endif
diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
index 0cbdb94..08a90fa 100644
--- a/drivers/tty/serdev/Makefile
+++ b/drivers/tty/serdev/Makefile
@@ -1,5 +1,6 @@
 serdev-objs := core.o
 
 obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o
+obj-$(CONFIG_SERIAL_DEV_MUX_GPIO) += mux-gpio.o
 
 obj-$(CONFIG_SERIAL_DEV_CTRL_TTYPORT) += serdev-ttyport.o
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 1fbaa4c..9a2c76b 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -305,7 +305,8 @@ struct serdev_device *serdev_device_alloc(struct serdev_controller *ctrl)
 		return NULL;
 
 	serdev->ctrl = ctrl;
-	ctrl->serdev = serdev;
+	if (!ctrl->serdev)
+		ctrl->serdev = serdev;
 	device_initialize(&serdev->dev);
 	serdev->dev.parent = &ctrl->dev;
 	serdev->dev.bus = &serdev_bus_type;
@@ -368,6 +369,8 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 	struct serdev_device *serdev = NULL;
 	int err;
 	bool found = false;
+	int nr = 0;
+	u32 reg;
 
 	for_each_available_child_of_node(ctrl->dev.of_node, node) {
 		if (!of_get_property(node, "compatible", NULL))
@@ -380,6 +383,10 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 			continue;
 
 		serdev->dev.of_node = node;
+		serdev->nr = nr++;
+
+		if (!of_property_read_u32(node, "reg", &reg))
+			serdev->mux_addr = reg;
 
 		err = serdev_device_add(serdev);
 		if (err) {
@@ -395,6 +402,36 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 	return 0;
 }
 
+int serdev_device_mux_select(struct serdev_device *serdev)
+{
+	struct serdev_mux *mux = serdev->ctrl->mux;
+
+	if (!mux || !mux->ops || !mux->ops->select)
+		return -EINVAL;
+
+	rt_mutex_lock(&mux->mux_lock);
+
+	mux->ops->select(serdev);
+	serdev->ctrl->serdev = serdev;
+
+	return 0;
+}
+
+int serdev_device_mux_deselect(struct serdev_device *serdev)
+{
+	struct serdev_mux *mux = serdev->ctrl->mux;
+
+	if (!mux || serdev->ctrl->serdev != serdev)
+		return -EINVAL;
+
+	if (mux->ops->deselect)
+		mux->ops->deselect(serdev);
+
+	rt_mutex_unlock(&mux->mux_lock);
+
+	return 0;
+}
+
 /**
  * serdev_controller_add() - Add an serdev controller
  * @ctrl:	controller to be registered.
@@ -414,6 +451,10 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_SERIAL_DEV_MUX_GPIO
+	of_serdev_register_gpio_mux(ctrl);
+#endif
+
 	ret = of_serdev_register_devices(ctrl);
 	if (ret)
 		goto out_dev_del;
diff --git a/drivers/tty/serdev/mux-gpio.c b/drivers/tty/serdev/mux-gpio.c
new file mode 100644
index 0000000..5bedff1
--- /dev/null
+++ b/drivers/tty/serdev/mux-gpio.c
@@ -0,0 +1,80 @@
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
+#include <linux/of_gpio.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+
+static int serdev_device_mux_select_gpio(struct serdev_device *serdev)
+{
+	int i;
+	u32 addr;
+	struct serdev_mux *mux = serdev->ctrl->mux;
+
+	addr = serdev->mux_addr;
+	for (i = 0; i < mux->ngpios; ++i, addr >>= 1) {
+		gpio_request_one(mux->gpios[i], GPIOF_DIR_OUT |
+				(addr & 1) ? GPIOF_INIT_HIGH : GPIOF_INIT_LOW,
+				"mux-enable-gpio");
+	}
+
+	return 0;
+}
+
+static int serdev_device_mux_deselect_gpio(struct serdev_device *serdev)
+{
+	int i;
+	struct serdev_mux *mux = serdev->ctrl->mux;
+
+	for (i = 0; i < mux->ngpios; ++i)
+		gpio_free(mux->gpios[i]);
+
+	return 0;
+}
+
+static const struct serdev_mux_ops gpio_mux_ops = {
+	.select = serdev_device_mux_select_gpio,
+	.deselect = serdev_device_mux_deselect_gpio,
+};
+
+int of_serdev_register_gpio_mux(struct serdev_controller *ctrl)
+{
+	int i, ngpios;
+	struct serdev_mux *mux;
+	struct device_node *np = ctrl->dev.of_node;
+
+	ngpios = of_gpio_named_count(np, "mux-select-gpios");
+	if (ngpios <= 0)
+		return -ENODEV;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	rt_mutex_init(&mux->mux_lock);
+	mux->ops = &gpio_mux_ops;
+
+	mux->ngpios = ngpios;
+
+	mux->gpios = kcalloc(ngpios, sizeof(int), GFP_KERNEL);
+	if (!mux->gpios)
+		return -ENOMEM;
+
+	for (i = 0; i < ngpios; ++i)
+		mux->gpios[i] = of_get_named_gpio(np, "mux-select-gpios", i);
+
+	ctrl->mux = mux;
+
+	return 0;
+}
+
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 8b67fcd..e86a0ad 100644
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
@@ -76,6 +78,20 @@ static inline struct serdev_device_driver *to_serdev_device_driver(struct device
 	return container_of(d, struct serdev_device_driver, driver);
 }
 
+struct serdev_mux_ops {
+	int (*select)(struct serdev_device *);
+	int (*deselect)(struct serdev_device *);
+};
+
+struct serdev_mux {
+	int ngpios;
+	int *gpios;
+	struct rt_mutex mux_lock;
+	const struct serdev_mux_ops *ops;
+};
+
+int of_serdev_register_gpio_mux(struct serdev_controller *ctrl);
+
 /*
  * serdev controller structures
  */
@@ -97,14 +113,16 @@ struct serdev_controller_ops {
  * struct serdev_controller - interface to the serdev controller
  * @dev:	Driver model representation of the device.
  * @nr:		number identifier for this controller/bus.
- * @serdev:	Pointer to slave device for this controller.
+ * @serdev:	Pointer to active slave device for this controller.
  * @ops:	Controller operations.
+ * @mux:	Slave multiplexer.
  */
 struct serdev_controller {
 	struct device		dev;
 	unsigned int		nr;
 	struct serdev_device	*serdev;
 	const struct serdev_controller_ops *ops;
+	struct serdev_mux	*mux;
 };
 
 static inline struct serdev_controller *to_serdev_controller(struct device *d)
@@ -172,7 +190,7 @@ static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl
 {
 	struct serdev_device *serdev = ctrl->serdev;
 
-	if (!serdev || !serdev->ops->write_wakeup)
+	if (!serdev || !serdev->ops || !serdev->ops->write_wakeup)
 		return;
 
 	serdev->ops->write_wakeup(serdev);
@@ -184,7 +202,7 @@ static inline int serdev_controller_receive_buf(struct serdev_controller *ctrl,
 {
 	struct serdev_device *serdev = ctrl->serdev;
 
-	if (!serdev || !serdev->ops->receive_buf)
+	if (!serdev || !serdev->ops || !serdev->ops->receive_buf)
 		return -EINVAL;
 
 	return serdev->ops->receive_buf(serdev, data, count);
@@ -204,6 +222,8 @@ void serdev_device_write_wakeup(struct serdev_device *);
 int serdev_device_write(struct serdev_device *, const unsigned char *, size_t, unsigned long);
 void serdev_device_write_flush(struct serdev_device *);
 int serdev_device_write_room(struct serdev_device *);
+int serdev_device_mux_select(struct serdev_device *);
+int serdev_device_mux_deselect(struct serdev_device *);
 
 /*
  * serdev device driver functions
-- 
2.7.4
