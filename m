From: Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/5] serdev: Introduce new bus for serial attached devices
Date: Wed, 25 Jan 2017 14:23:41 -0600
Message-ID: <20170125202343.30923-4-robh@kernel.org>
References: <20170125202343.30923-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170125202343.30923-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The serdev bus is designed for devices such as Bluetooth, WiFi, GPS
and NFC connected to UARTs on host processors. Tradionally these have
been handled with tty line disciplines, rfkill, and userspace glue such
as hciattach. This approach has many drawbacks since it doesn't fit
into the Linux driver model. Handling of sideband signals, power control
and firmware loading are the main issues.

This creates a serdev bus with controllers (i.e. host serial ports) and
attached devices. Typically, these are point to point connections, but
some devices have muxing protocols or a h/w mux is conceivable. Any
muxing is not yet supported with the serdev bus.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-By: Sebastian Reichel <sre@kernel.org>
---
v3:
- Added empty device functions for !CONFIG_SERIAL_DEV_BUS

v2:
- Change the sysfs visible names to "serial". Kept serdev as kernel
  internal name.
- Make function ptr checks and calls follow a consistent structure
- Return error if controller .open() is missing
- Sort includes
- Add an ACPI TODO note
- Fix serdev_controller_add error path handling
- Fix DT child device adding error handling
- Add modalias sysfs attr and uevent hook
- Fix module email address

 MAINTAINERS                 |   8 +
 drivers/char/Kconfig        |   1 +
 drivers/tty/Makefile        |   1 +
 drivers/tty/serdev/Kconfig  |   8 +
 drivers/tty/serdev/Makefile |   3 +
 drivers/tty/serdev/core.c   | 421 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serdev.h      | 241 +++++++++++++++++++++++++
 7 files changed, 683 insertions(+)
 create mode 100644 drivers/tty/serdev/Kconfig
 create mode 100644 drivers/tty/serdev/Makefile
 create mode 100644 drivers/tty/serdev/core.c
 create mode 100644 include/linux/serdev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c36976d3bd1a..90db2b5d418c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10831,6 +10831,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/serial/
 F:	drivers/tty/serial/
 
+SERIAL DEVICE BUS
+M:	Rob Herring <robh@kernel.org>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/slave-device.txt
+F:	drivers/tty/serdev/
+F:	include/linux/serdev.h
+
 SERIAL IR RECEIVER
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index fde005ef9d36..db8f74bbaf3e 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -46,6 +46,7 @@ config SGI_MBCS
          say Y or M here, otherwise say N.
 
 source "drivers/tty/serial/Kconfig"
+source "drivers/tty/serdev/Kconfig"
 
 config TTY_PRINTK
 	tristate "TTY driver to output user messages via printk"
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 5817e2397463..b95bed92da9f 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_R3964)		+= n_r3964.o
 obj-y				+= vt/
 obj-$(CONFIG_HVC_DRIVER)	+= hvc/
 obj-y				+= serial/
+obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
 
 # tty drivers
 obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
new file mode 100644
index 000000000000..3b6ecd187bef
--- /dev/null
+++ b/drivers/tty/serdev/Kconfig
@@ -0,0 +1,8 @@
+#
+# Serial bus device driver configuration
+#
+menuconfig SERIAL_DEV_BUS
+	tristate "Serial device bus"
+	help
+	  Core support for devices connected via a serial port.
+
diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
new file mode 100644
index 000000000000..01a9b62183f4
--- /dev/null
+++ b/drivers/tty/serdev/Makefile
@@ -0,0 +1,3 @@
+serdev-objs := core.o
+
+obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
new file mode 100644
index 000000000000..f4c6c90add78
--- /dev/null
+++ b/drivers/tty/serdev/core.c
@@ -0,0 +1,421 @@
+/*
+ * Copyright (C) 2016-2017 Linaro Ltd., Rob Herring <robh@kernel.org>
+ *
+ * Based on drivers/spmi/spmi.c:
+ * Copyright (c) 2012-2015, The Linux Foundation. All rights reserved.
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
+#include <linux/errno.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+
+static bool is_registered;
+static DEFINE_IDA(ctrl_ida);
+
+static void serdev_device_release(struct device *dev)
+{
+	struct serdev_device *serdev = to_serdev_device(dev);
+	kfree(serdev);
+}
+
+static const struct device_type serdev_device_type = {
+	.release	= serdev_device_release,
+};
+
+static void serdev_ctrl_release(struct device *dev)
+{
+	struct serdev_controller *ctrl = to_serdev_controller(dev);
+	ida_simple_remove(&ctrl_ida, ctrl->nr);
+	kfree(ctrl);
+}
+
+static const struct device_type serdev_ctrl_type = {
+	.release	= serdev_ctrl_release,
+};
+
+static int serdev_device_match(struct device *dev, struct device_driver *drv)
+{
+	/* TODO: ACPI and platform matching */
+	return of_driver_match_device(dev, drv);
+}
+
+static int serdev_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	/* TODO: ACPI and platform modalias */
+	return of_device_uevent_modalias(dev, env);
+}
+
+/**
+ * serdev_device_add() - add a device previously constructed via serdev_device_alloc()
+ * @serdev:	serdev_device to be added
+ */
+int serdev_device_add(struct serdev_device *serdev)
+{
+	struct device *parent = serdev->dev.parent;
+	int err;
+
+	dev_set_name(&serdev->dev, "%s-%d", dev_name(parent), serdev->nr);
+
+	err = device_add(&serdev->dev);
+	if (err < 0) {
+		dev_err(&serdev->dev, "Can't add %s, status %d\n",
+			dev_name(&serdev->dev), err);
+		goto err_device_add;
+	}
+
+	dev_dbg(&serdev->dev, "device %s registered\n", dev_name(&serdev->dev));
+
+err_device_add:
+	return err;
+}
+EXPORT_SYMBOL_GPL(serdev_device_add);
+
+/**
+ * serdev_device_remove(): remove an serdev device
+ * @serdev:	serdev_device to be removed
+ */
+void serdev_device_remove(struct serdev_device *serdev)
+{
+	device_unregister(&serdev->dev);
+}
+EXPORT_SYMBOL_GPL(serdev_device_remove);
+
+int serdev_device_open(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->open)
+		return -EINVAL;
+
+	return ctrl->ops->open(ctrl);
+}
+EXPORT_SYMBOL_GPL(serdev_device_open);
+
+void serdev_device_close(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->close)
+		return;
+
+	ctrl->ops->close(ctrl);
+}
+EXPORT_SYMBOL_GPL(serdev_device_close);
+
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
+void serdev_device_write_flush(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->write_flush)
+		return;
+
+	ctrl->ops->write_flush(ctrl);
+}
+EXPORT_SYMBOL_GPL(serdev_device_write_flush);
+
+int serdev_device_write_room(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->write_room)
+		return 0;
+
+	return serdev->ctrl->ops->write_room(ctrl);
+}
+EXPORT_SYMBOL_GPL(serdev_device_write_room);
+
+unsigned int serdev_device_set_baudrate(struct serdev_device *serdev, unsigned int speed)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->set_baudrate)
+		return 0;
+
+	return ctrl->ops->set_baudrate(ctrl, speed);
+
+}
+EXPORT_SYMBOL_GPL(serdev_device_set_baudrate);
+
+void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->set_flow_control)
+		return;
+
+	ctrl->ops->set_flow_control(ctrl, enable);
+}
+EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
+
+static int serdev_drv_probe(struct device *dev)
+{
+	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
+
+	return sdrv->probe(to_serdev_device(dev));
+}
+
+static int serdev_drv_remove(struct device *dev)
+{
+	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
+
+	sdrv->remove(to_serdev_device(dev));
+	return 0;
+}
+
+static ssize_t modalias_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	ssize_t len = of_device_get_modalias(dev, buf, PAGE_SIZE - 2);
+	buf[len] = '\n';
+	buf[len+1] = 0;
+	return len+1;
+}
+
+static struct device_attribute serdev_device_attrs[] = {
+	__ATTR_RO(modalias),
+	__ATTR_NULL
+};
+
+static struct bus_type serdev_bus_type = {
+	.name		= "serial",
+	.match		= serdev_device_match,
+	.probe		= serdev_drv_probe,
+	.remove		= serdev_drv_remove,
+	.uevent		= serdev_uevent,
+	.dev_attrs	= serdev_device_attrs,
+};
+
+/**
+ * serdev_controller_alloc() - Allocate a new serdev device
+ * @ctrl:	associated controller
+ *
+ * Caller is responsible for either calling serdev_device_add() to add the
+ * newly allocated controller, or calling serdev_device_put() to discard it.
+ */
+struct serdev_device *serdev_device_alloc(struct serdev_controller *ctrl)
+{
+	struct serdev_device *serdev;
+
+	serdev = kzalloc(sizeof(*serdev), GFP_KERNEL);
+	if (!serdev)
+		return NULL;
+
+	serdev->ctrl = ctrl;
+	ctrl->serdev = serdev;
+	device_initialize(&serdev->dev);
+	serdev->dev.parent = &ctrl->dev;
+	serdev->dev.bus = &serdev_bus_type;
+	serdev->dev.type = &serdev_device_type;
+	return serdev;
+}
+EXPORT_SYMBOL_GPL(serdev_device_alloc);
+
+/**
+ * serdev_controller_alloc() - Allocate a new serdev controller
+ * @parent:	parent device
+ * @size:	size of private data
+ *
+ * Caller is responsible for either calling serdev_controller_add() to add the
+ * newly allocated controller, or calling serdev_controller_put() to discard it.
+ * The allocated private data region may be accessed via
+ * serdev_controller_get_drvdata()
+ */
+struct serdev_controller *serdev_controller_alloc(struct device *parent,
+					      size_t size)
+{
+	struct serdev_controller *ctrl;
+	int id;
+
+	if (WARN_ON(!parent))
+		return NULL;
+
+	ctrl = kzalloc(sizeof(*ctrl) + size, GFP_KERNEL);
+	if (!ctrl)
+		return NULL;
+
+	device_initialize(&ctrl->dev);
+	ctrl->dev.type = &serdev_ctrl_type;
+	ctrl->dev.bus = &serdev_bus_type;
+	ctrl->dev.parent = parent;
+	ctrl->dev.of_node = parent->of_node;
+	serdev_controller_set_drvdata(ctrl, &ctrl[1]);
+
+	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		dev_err(parent,
+			"unable to allocate serdev controller identifier.\n");
+		serdev_controller_put(ctrl);
+		return NULL;
+	}
+
+	ctrl->nr = id;
+	dev_set_name(&ctrl->dev, "serial%d", id);
+
+	dev_dbg(&ctrl->dev, "allocated controller 0x%p id %d\n", ctrl, id);
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(serdev_controller_alloc);
+
+static int of_serdev_register_devices(struct serdev_controller *ctrl)
+{
+	struct device_node *node;
+	struct serdev_device *serdev = NULL;
+	int err;
+	bool found = false;
+
+	for_each_available_child_of_node(ctrl->dev.of_node, node) {
+		if (!of_get_property(node, "compatible", NULL))
+			continue;
+
+		dev_dbg(&ctrl->dev, "adding child %s\n", node->full_name);
+
+		serdev = serdev_device_alloc(ctrl);
+		if (!serdev)
+			continue;
+
+		serdev->dev.of_node = node;
+
+		err = serdev_device_add(serdev);
+		if (err) {
+			dev_err(&serdev->dev,
+				"failure adding device. status %d\n", err);
+			serdev_device_put(serdev);
+		} else
+			found = true;
+	}
+	if (!found)
+		return -ENODEV;
+
+	return 0;
+}
+
+/**
+ * serdev_controller_add() - Add an serdev controller
+ * @ctrl:	controller to be registered.
+ *
+ * Register a controller previously allocated via serdev_controller_alloc() with
+ * the serdev core.
+ */
+int serdev_controller_add(struct serdev_controller *ctrl)
+{
+	int ret;
+
+	/* Can't register until after driver model init */
+	if (WARN_ON(!is_registered))
+		return -EAGAIN;
+
+	ret = device_add(&ctrl->dev);
+	if (ret)
+		return ret;
+
+	ret = of_serdev_register_devices(ctrl);
+	if (ret)
+		goto out_dev_del;
+
+	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
+		ctrl->nr, &ctrl->dev);
+	return 0;
+
+out_dev_del:
+	device_del(&ctrl->dev);
+	return ret;
+};
+EXPORT_SYMBOL_GPL(serdev_controller_add);
+
+/* Remove a device associated with a controller */
+static int serdev_remove_device(struct device *dev, void *data)
+{
+	struct serdev_device *serdev = to_serdev_device(dev);
+	if (dev->type == &serdev_device_type)
+		serdev_device_remove(serdev);
+	return 0;
+}
+
+/**
+ * serdev_controller_remove(): remove an serdev controller
+ * @ctrl:	controller to remove
+ *
+ * Remove a serdev controller.  Caller is responsible for calling
+ * serdev_controller_put() to discard the allocated controller.
+ */
+void serdev_controller_remove(struct serdev_controller *ctrl)
+{
+	int dummy;
+
+	if (!ctrl)
+		return;
+
+	dummy = device_for_each_child(&ctrl->dev, NULL,
+				      serdev_remove_device);
+	device_del(&ctrl->dev);
+}
+EXPORT_SYMBOL_GPL(serdev_controller_remove);
+
+/**
+ * serdev_driver_register() - Register client driver with serdev core
+ * @sdrv:	client driver to be associated with client-device.
+ *
+ * This API will register the client driver with the serdev framework.
+ * It is typically called from the driver's module-init function.
+ */
+int __serdev_device_driver_register(struct serdev_device_driver *sdrv, struct module *owner)
+{
+	sdrv->driver.bus = &serdev_bus_type;
+	sdrv->driver.owner = owner;
+
+	/* force drivers to async probe so I/O is possible in probe */
+        sdrv->driver.probe_type = PROBE_PREFER_ASYNCHRONOUS;
+
+	return driver_register(&sdrv->driver);
+}
+EXPORT_SYMBOL_GPL(__serdev_device_driver_register);
+
+static void __exit serdev_exit(void)
+{
+	bus_unregister(&serdev_bus_type);
+}
+module_exit(serdev_exit);
+
+static int __init serdev_init(void)
+{
+	int ret;
+
+	ret = bus_register(&serdev_bus_type);
+	if (ret)
+		return ret;
+
+	is_registered = true;
+	return 0;
+}
+/* Must be before serial drivers register */
+postcore_initcall(serdev_init);
+
+MODULE_AUTHOR("Rob Herring <robh@kernel.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Serial attached device bus");
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
new file mode 100644
index 000000000000..4f8f76d02ca8
--- /dev/null
+++ b/include/linux/serdev.h
@@ -0,0 +1,241 @@
+/*
+ * Copyright (C) 2016-2017 Linaro Ltd., Rob Herring <robh@kernel.org>
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
+#ifndef _LINUX_SERDEV_H
+#define _LINUX_SERDEV_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+
+struct serdev_controller;
+struct serdev_device;
+
+/*
+ * serdev device structures
+ */
+
+/**
+ * struct serdev_device_ops - Callback operations for a serdev device
+ * @receive_buf:	Function called with data received from device.
+ * @write_wakeup:	Function called when ready to transmit more data.
+ */
+struct serdev_device_ops {
+	int (*receive_buf)(struct serdev_device *, const unsigned char *, size_t);
+	void (*write_wakeup)(struct serdev_device *);
+};
+
+/**
+ * struct serdev_device - Basic representation of an serdev device
+ * @dev:	Driver model representation of the device.
+ * @nr:		Device number on serdev bus.
+ * @ctrl:	serdev controller managing this device.
+ * @ops:	Device operations.
+ */
+struct serdev_device {
+	struct device dev;
+	int nr;
+	struct serdev_controller *ctrl;
+	const struct serdev_device_ops *ops;
+};
+
+static inline struct serdev_device *to_serdev_device(struct device *d)
+{
+	return container_of(d, struct serdev_device, dev);
+}
+
+/**
+ * struct serdev_device_driver - serdev slave device driver
+ * @driver:	serdev device drivers should initialize name field of this
+ *		structure.
+ * @probe:	binds this driver to a serdev device.
+ * @remove:	unbinds this driver from the serdev device.
+ */
+struct serdev_device_driver {
+	struct device_driver driver;
+	int	(*probe)(struct serdev_device *);
+	void	(*remove)(struct serdev_device *);
+};
+
+static inline struct serdev_device_driver *to_serdev_device_driver(struct device_driver *d)
+{
+	return container_of(d, struct serdev_device_driver, driver);
+}
+
+/*
+ * serdev controller structures
+ */
+struct serdev_controller_ops {
+	int (*write_buf)(struct serdev_controller *, const unsigned char *, size_t);
+	void (*write_flush)(struct serdev_controller *);
+	int (*write_room)(struct serdev_controller *);
+	int (*open)(struct serdev_controller *);
+	void (*close)(struct serdev_controller *);
+	void (*set_flow_control)(struct serdev_controller *, bool);
+	unsigned int (*set_baudrate)(struct serdev_controller *, unsigned int);
+};
+
+/**
+ * struct serdev_controller - interface to the serdev controller
+ * @dev:	Driver model representation of the device.
+ * @nr:		number identifier for this controller/bus.
+ * @serdev:	Pointer to slave device for this controller.
+ * @ops:	Controller operations.
+ */
+struct serdev_controller {
+	struct device		dev;
+	unsigned int		nr;
+	struct serdev_device	*serdev;
+	const struct serdev_controller_ops *ops;
+};
+
+static inline struct serdev_controller *to_serdev_controller(struct device *d)
+{
+	return container_of(d, struct serdev_controller, dev);
+}
+
+static inline void *serdev_device_get_drvdata(const struct serdev_device *serdev)
+{
+	return dev_get_drvdata(&serdev->dev);
+}
+
+static inline void serdev_device_set_drvdata(struct serdev_device *serdev, void *data)
+{
+	dev_set_drvdata(&serdev->dev, data);
+}
+
+/**
+ * serdev_device_put() - decrement serdev device refcount
+ * @serdev	serdev device.
+ */
+static inline void serdev_device_put(struct serdev_device *serdev)
+{
+	if (serdev)
+		put_device(&serdev->dev);
+}
+
+static inline void serdev_device_set_client_ops(struct serdev_device *serdev,
+					      const struct serdev_device_ops *ops)
+{
+	serdev->ops = ops;
+}
+
+static inline
+void *serdev_controller_get_drvdata(const struct serdev_controller *ctrl)
+{
+	return ctrl ? dev_get_drvdata(&ctrl->dev) : NULL;
+}
+
+static inline void serdev_controller_set_drvdata(struct serdev_controller *ctrl,
+					       void *data)
+{
+	dev_set_drvdata(&ctrl->dev, data);
+}
+
+/**
+ * serdev_controller_put() - decrement controller refcount
+ * @ctrl	serdev controller.
+ */
+static inline void serdev_controller_put(struct serdev_controller *ctrl)
+{
+	if (ctrl)
+		put_device(&ctrl->dev);
+}
+
+struct serdev_device *serdev_device_alloc(struct serdev_controller *);
+int serdev_device_add(struct serdev_device *);
+void serdev_device_remove(struct serdev_device *);
+
+struct serdev_controller *serdev_controller_alloc(struct device *, size_t);
+int serdev_controller_add(struct serdev_controller *);
+void serdev_controller_remove(struct serdev_controller *);
+
+static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl)
+{
+	struct serdev_device *serdev = ctrl->serdev;
+
+	if (!serdev || !serdev->ops->write_wakeup)
+		return;
+
+	serdev->ops->write_wakeup(ctrl->serdev);
+}
+
+static inline int serdev_controller_receive_buf(struct serdev_controller *ctrl,
+					      const unsigned char *data,
+					      size_t count)
+{
+	struct serdev_device *serdev = ctrl->serdev;
+
+	if (!serdev || !serdev->ops->receive_buf)
+		return -EINVAL;
+
+	return serdev->ops->receive_buf(ctrl->serdev, data, count);
+}
+
+#ifdef CONFIG_SERIAL_DEV_BUS
+
+int serdev_device_open(struct serdev_device *);
+void serdev_device_close(struct serdev_device *);
+unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
+void serdev_device_set_flow_control(struct serdev_device *, bool);
+int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
+void serdev_device_write_flush(struct serdev_device *);
+int serdev_device_write_room(struct serdev_device *);
+
+/*
+ * serdev device driver functions
+ */
+int __serdev_device_driver_register(struct serdev_device_driver *, struct module *);
+#define serdev_device_driver_register(sdrv) \
+	__serdev_device_driver_register(sdrv, THIS_MODULE)
+
+/**
+ * serdev_device_driver_unregister() - unregister an serdev client driver
+ * @sdrv:	the driver to unregister
+ */
+static inline void serdev_device_driver_unregister(struct serdev_device_driver *sdrv)
+{
+	if (sdrv)
+		driver_unregister(&sdrv->driver);
+}
+
+#define module_serdev_device_driver(__serdev_device_driver) \
+	module_driver(__serdev_device_driver, serdev_device_driver_register, \
+			serdev_device_driver_unregister)
+
+#else
+
+static inline int serdev_device_open(struct serdev_device *sdev)
+{
+	return -ENODEV;
+}
+static inline void serdev_device_close(struct serdev_device *sdev) {}
+static inline unsigned int serdev_device_set_baudrate(struct serdev_device *sdev, unsigned int baudrate)
+{
+	return 0;
+}
+static inline void serdev_device_set_flow_control(struct serdev_device *sdev, bool enable) {}
+static inline int serdev_device_write_buf(struct serdev_device *sdev, const unsigned char *buf, size_t count)
+{
+	return -ENODEV;
+}
+static inline void serdev_device_write_flush(struct serdev_device *sdev) {}
+static inline int serdev_device_write_room(struct serdev_device *sdev)
+{
+	return 0;
+}
+
+#define serdev_device_driver_register(x)
+#define serdev_device_driver_unregister(x)
+
+#endif /* CONFIG_SERIAL_DEV_BUS */
+
+#endif /*_LINUX_SERDEV_H */
-- 
2.10.1
