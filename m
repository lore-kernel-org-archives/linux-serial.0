From: Rob Herring <robh@kernel.org>
Subject: [RFC PATCH 1/3] uart bus: Introduce new bus for UART slave devices
Date: Wed, 17 Aug 2016 20:14:43 -0500
Message-ID: <20160818011445.22726-2-robh@kernel.org>
References: <20160818011445.22726-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818011445.22726-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The UART bus is designed for slave devices such as Bluetooth, WiFi, GPS
and NFC connected to UARTs on host processors. Tradionally these have
been handled with tty line disciplines, rfkill, and userspace glue such
as hci_attach. This approach has many drawbacks since it doesn't fit
into the Linux driver model. Handling of sideband signals, power control
and firmware loading are the main issues.

This creates a UART bus with controllers (i.e. host UARTs) and slave
devices. Typically, these are point to point connections, but some
devices have muxing protocols or a h/w mux is conceivable. Any muxing is
not yet supported.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/Kconfig             |   2 +
 drivers/Makefile            |   1 +
 drivers/uart/Kconfig        |  17 ++
 drivers/uart/Makefile       |   3 +
 drivers/uart/core.c         | 458 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/uart/loopback.c     |  72 +++++++
 include/linux/uart_device.h | 163 ++++++++++++++++
 7 files changed, 716 insertions(+)
 create mode 100644 drivers/uart/Kconfig
 create mode 100644 drivers/uart/Makefile
 create mode 100644 drivers/uart/core.c
 create mode 100644 drivers/uart/loopback.c
 create mode 100644 include/linux/uart_device.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index e1e2066..9145494 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -202,4 +202,6 @@ source "drivers/hwtracing/intel_th/Kconfig"
 
 source "drivers/fpga/Kconfig"
 
+source "drivers/uart/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 53abb4a..c915417 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -173,3 +173,4 @@ obj-$(CONFIG_STM)		+= hwtracing/stm/
 obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
+obj-$(CONFIG_UART_DEV)		+= uart/
diff --git a/drivers/uart/Kconfig b/drivers/uart/Kconfig
new file mode 100644
index 0000000..b232ce3
--- /dev/null
+++ b/drivers/uart/Kconfig
@@ -0,0 +1,17 @@
+#
+# UART slave driver configuration
+#
+menuconfig UART_DEV
+	tristate "UART device support"
+	help
+	  Support for devices connected via a UART
+
+if UART_DEV
+
+config UART_DEV_LOOPBACK
+	tristate "Loopback Test Driver"
+	help
+	  This option enables a loopback test driver. Anything received from
+	  the connected device will be echoed back.
+
+endif
diff --git a/drivers/uart/Makefile b/drivers/uart/Makefile
new file mode 100644
index 0000000..704eec0
--- /dev/null
+++ b/drivers/uart/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_UART_DEV) := core.o
+
+obj-$(CONFIG_UART_DEV_LOOPBACK) += loopback.o
diff --git a/drivers/uart/core.c b/drivers/uart/core.c
new file mode 100644
index 0000000..5b5d0e1
--- /dev/null
+++ b/drivers/uart/core.c
@@ -0,0 +1,458 @@
+/*
+ * Copyright (C) 2016 Linaro Ltd.
+ * Author: Rob Herring <robh@kernel.org>
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
+#define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/idr.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/uart_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/serial_core.h>
+
+static bool is_registered;
+static DEFINE_IDA(ctrl_ida);
+
+static void uart_dev_release(struct device *dev)
+{
+	struct uart_device *udev = to_uart_device(dev);
+	kfree(udev);
+}
+
+static const struct device_type uart_dev_type = {
+	.release	= uart_dev_release,
+};
+
+static void uart_ctrl_release(struct device *dev)
+{
+	struct uart_controller *ctrl = to_uart_controller(dev);
+	ida_simple_remove(&ctrl_ida, ctrl->nr);
+	kfree(ctrl);
+}
+
+static const struct device_type uart_ctrl_type = {
+	.release	= uart_ctrl_release,
+};
+
+static int uart_device_match(struct device *dev, struct device_driver *drv)
+{
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	if (drv->name)
+		return strncmp(dev_name(dev), drv->name,
+			       SPMI_NAME_SIZE) == 0;
+
+	return 0;
+}
+
+/**
+ * uart_device_add() - add a device previously constructed via uart_device_alloc()
+ * @udev:	uart_device to be added
+ */
+int uart_device_add(struct uart_device *udev)
+{
+	struct uart_controller *ctrl = udev->ctrl;
+	int err;
+
+	dev_set_name(&udev->dev, "uartdev-%d", ctrl->nr);
+
+	err = device_add(&udev->dev);
+	if (err < 0) {
+		dev_err(&udev->dev, "Can't add %s, status %d\n",
+			dev_name(&udev->dev), err);
+		goto err_device_add;
+	}
+
+	dev_dbg(&udev->dev, "device %s registered\n", dev_name(&udev->dev));
+
+err_device_add:
+	return err;
+}
+EXPORT_SYMBOL_GPL(uart_device_add);
+
+/**
+ * uart_device_remove(): remove an SPMI device
+ * @udev:	uart_device to be removed
+ */
+void uart_device_remove(struct uart_device *udev)
+{
+	device_unregister(&udev->dev);
+}
+EXPORT_SYMBOL_GPL(uart_device_remove);
+
+int uart_dev_config(struct uart_device *udev, int baud, int parity, int bits, int flow)
+{
+	return uart_set_options(udev->ctrl->port, NULL, baud, parity, bits, flow);
+}
+
+int uart_dev_connect(struct uart_device *udev)
+{
+	unsigned long page;
+	struct uart_port *port = udev->ctrl->port;
+	struct uart_state *state = port->state;
+
+	WARN_ON(!state);
+
+	if (!state->xmit.buf) {
+		/* This is protected by the per port mutex */
+		page = get_zeroed_page(GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+
+		state->xmit.buf = (unsigned char *) page;
+		uart_circ_clear(&state->xmit);
+	}
+
+	if (!udev->ctrl->recv.buf) {
+		/* This is protected by the per port mutex */
+		page = get_zeroed_page(GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+
+		udev->ctrl->recv.buf = (unsigned char *) page;
+		uart_circ_clear(&udev->ctrl->recv);
+	}
+
+	if (port && port->ops->pm)
+		port->ops->pm(port, UART_PM_STATE_ON, state->pm_state);
+	state->pm_state = UART_PM_STATE_ON;
+
+	port->ops->set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
+
+	return udev->ctrl->port->ops->startup(udev->ctrl->port);
+}
+
+int uart_dev_rx(struct uart_device *udev, u8 *buf, size_t count)
+{
+	struct uart_port *port = udev->ctrl->port;
+	struct uart_state *state = port->state;
+	struct circ_buf *circ = &udev->ctrl->recv;
+	int c, ret = 0;
+
+	if (!circ->buf)
+		return 0;
+
+	while (1) {
+		c = CIRC_CNT_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
+		if (count < c)
+			c = count;
+		if (c <= 0)
+			break;
+		memcpy(buf, circ->buf + circ->tail, c);
+		circ->tail = (circ->tail + c) & (PAGE_SIZE - 1);
+
+		buf += c;
+		count -= c;
+		ret += c;
+	}
+
+	return ret;
+}
+
+int uart_dev_tx(struct uart_device *udev, u8 *buf, size_t count)
+{
+	struct uart_port *port = udev->ctrl->port;
+	struct uart_state *state = port->state;
+	struct circ_buf *circ = &state->xmit;
+	unsigned long flags;
+	int c, ret = 0;
+
+	if (!circ->buf)
+		return 0;
+
+//	port = uart_port_lock(state, flags);
+	while (1) {
+		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
+		if (count < c)
+			c = count;
+		if (c <= 0)
+			break;
+		memcpy(circ->buf + circ->head, buf, c);
+		circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
+		buf += c;
+		count -= c;
+		ret += c;
+	}
+	port->ops->start_tx(port);
+
+//	uart_port_unlock(port, flags);
+
+	return ret;
+}
+
+
+static int uart_drv_probe(struct device *dev)
+{
+	const struct uart_dev_driver *sdrv = to_uart_dev_driver(dev->driver);
+	struct uart_device *udev = to_uart_device(dev);
+	int err;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	err = sdrv->probe(udev);
+	if (err)
+		goto fail_probe;
+
+	return 0;
+
+fail_probe:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+	return err;
+}
+
+static int uart_drv_remove(struct device *dev)
+{
+	const struct uart_dev_driver *sdrv = to_uart_dev_driver(dev->driver);
+
+	pm_runtime_get_sync(dev);
+	sdrv->remove(to_uart_device(dev));
+	pm_runtime_put_noidle(dev);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+	return 0;
+}
+
+static struct bus_type uart_bus_type = {
+	.name		= "uart",
+	.match		= uart_device_match,
+	.probe		= uart_drv_probe,
+	.remove		= uart_drv_remove,
+};
+
+/**
+ * uart_controller_alloc() - Allocate a new SPMI device
+ * @ctrl:	associated controller
+ *
+ * Caller is responsible for either calling uart_device_add() to add the
+ * newly allocated controller, or calling uart_device_put() to discard it.
+ */
+struct uart_device *uart_device_alloc(struct uart_controller *ctrl)
+{
+	struct uart_device *udev;
+
+	udev = kzalloc(sizeof(*udev), GFP_KERNEL);
+	if (!udev)
+		return NULL;
+
+	udev->ctrl = ctrl;
+	device_initialize(&udev->dev);
+	udev->dev.parent = &ctrl->dev;
+	udev->dev.bus = &uart_bus_type;
+	udev->dev.type = &uart_dev_type;
+	return udev;
+}
+EXPORT_SYMBOL_GPL(uart_device_alloc);
+
+/**
+ * uart_controller_alloc() - Allocate a new SPMI controller
+ * @parent:	parent device
+ * @size:	size of private data
+ *
+ * Caller is responsible for either calling uart_controller_add() to add the
+ * newly allocated controller, or calling uart_controller_put() to discard it.
+ * The allocated private data region may be accessed via
+ * uart_controller_get_drvdata()
+ */
+struct uart_controller *uart_controller_alloc(struct device *parent,
+					      size_t size)
+{
+	struct uart_controller *ctrl;
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
+	ctrl->dev.type = &uart_ctrl_type;
+	ctrl->dev.bus = &uart_bus_type;
+	ctrl->dev.parent = parent;
+	ctrl->dev.of_node = parent->of_node;
+	uart_controller_set_drvdata(ctrl, &ctrl[1]);
+
+	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		dev_err(parent,
+			"unable to allocate SPMI controller identifier.\n");
+		uart_controller_put(ctrl);
+		return NULL;
+	}
+
+	ctrl->nr = id;
+	dev_set_name(&ctrl->dev, "uart-%d", id);
+
+	dev_dbg(&ctrl->dev, "allocated controller 0x%p id %d\n", ctrl, id);
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(uart_controller_alloc);
+
+static void of_uart_register_devices(struct uart_controller *ctrl)
+{
+	struct device_node *node;
+	int err;
+
+	if (!ctrl->dev.of_node)
+		return;
+
+	for_each_available_child_of_node(ctrl->dev.of_node, node) {
+		struct uart_device *udev;
+		u32 reg[2];
+
+		dev_dbg(&ctrl->dev, "adding child %s\n", node->full_name);
+
+		udev = uart_device_alloc(ctrl);
+		if (!udev)
+			continue;
+
+		udev->dev.of_node = node;
+
+		err = uart_device_add(udev);
+		if (err) {
+			dev_err(&udev->dev,
+				"failure adding device. status %d\n", err);
+			uart_device_put(udev);
+		}
+	}
+}
+
+/**
+ * uart_controller_add() - Add an SPMI controller
+ * @ctrl:	controller to be registered.
+ *
+ * Register a controller previously allocated via uart_controller_alloc() with
+ * the SPMI core.
+ */
+int uart_controller_add(struct uart_controller *ctrl)
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
+	if (IS_ENABLED(CONFIG_OF))
+		of_uart_register_devices(ctrl);
+
+	dev_dbg(&ctrl->dev, "uart-%d registered: dev:%p\n",
+		ctrl->nr, &ctrl->dev);
+
+	return 0;
+};
+EXPORT_SYMBOL_GPL(uart_controller_add);
+
+int uart_controller_rx(struct uart_controller *ctrl, unsigned int ch)
+{
+	struct circ_buf *circ = &ctrl->recv;
+	unsigned long flags;
+	int c, ret = 0;
+
+	if (!circ->buf)
+		return -ENODEV;
+
+	c = CIRC_SPACE_TO_END(circ->head, circ->tail, PAGE_SIZE);
+	if (c <= 0)
+		return 0;
+
+	circ->buf[circ->head] = ch;
+	circ->head = (circ->head + 1) & (PAGE_SIZE - 1);
+
+	return 1;
+}
+
+/* Remove a device associated with a controller */
+static int uart_ctrl_remove_device(struct device *dev, void *data)
+{
+	struct uart_device *spmidev = to_uart_device(dev);
+	if (dev->type == &uart_dev_type)
+		uart_device_remove(spmidev);
+	return 0;
+}
+
+/**
+ * uart_controller_remove(): remove an SPMI controller
+ * @ctrl:	controller to remove
+ *
+ * Remove a SPMI controller.  Caller is responsible for calling
+ * uart_controller_put() to discard the allocated controller.
+ */
+void uart_controller_remove(struct uart_controller *ctrl)
+{
+	int dummy;
+
+	if (!ctrl)
+		return;
+
+	dummy = device_for_each_child(&ctrl->dev, NULL,
+				      uart_ctrl_remove_device);
+	device_del(&ctrl->dev);
+}
+EXPORT_SYMBOL_GPL(uart_controller_remove);
+
+/**
+ * uart_driver_register() - Register client driver with SPMI core
+ * @sdrv:	client driver to be associated with client-device.
+ *
+ * This API will register the client driver with the SPMI framework.
+ * It is typically called from the driver's module-init function.
+ */
+int __uart_dev_driver_register(struct uart_dev_driver *sdrv, struct module *owner)
+{
+	sdrv->driver.bus = &uart_bus_type;
+	sdrv->driver.owner = owner;
+	return driver_register(&sdrv->driver);
+}
+EXPORT_SYMBOL_GPL(__uart_driver_register);
+
+static void __exit uart_exit(void)
+{
+	bus_unregister(&uart_bus_type);
+}
+module_exit(uart_exit);
+
+static int __init uart_init(void)
+{
+	int ret;
+
+	ret = bus_register(&uart_bus_type);
+	if (ret)
+		return ret;
+
+	is_registered = true;
+	return 0;
+}
+postcore_initcall(uart_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("UART module");
+//MODULE_ALIAS("platform:spmi");
diff --git a/drivers/uart/loopback.c b/drivers/uart/loopback.c
new file mode 100644
index 0000000..80b7769
--- /dev/null
+++ b/drivers/uart/loopback.c
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) 2016 Linaro Ltd.
+ * Author: Rob Herring <robh@kernel.org>
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
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/uart_device.h>
+#include <linux/workqueue.h>
+
+struct loopback_data {
+	struct uart_device *udev;
+	struct delayed_work work;
+};
+
+static void loopback_work(struct work_struct *work)
+{
+	struct loopback_data *data = container_of((struct delayed_work *)work, struct loopback_data, work);
+	struct uart_device *udev = data->udev;
+	int cnt;
+	char buf[64];
+
+	cnt = uart_dev_rx(udev, buf, sizeof(buf));
+	uart_dev_tx(udev, buf, cnt);
+
+	schedule_delayed_work(&data->work, 5);
+}
+
+static int loopback_probe(struct uart_device *udev)
+{
+	struct loopback_data *data;
+
+	data = devm_kzalloc(&udev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->udev = udev;
+
+	dev_info(&udev->dev, "loopback probe!!!\n");
+
+	uart_dev_connect(udev);
+	uart_dev_config(udev, 115200, 'n', 8, 0);
+
+
+	INIT_DELAYED_WORK(&data->work, loopback_work);
+	schedule_delayed_work(&data->work, 100);
+
+	return 0;
+}
+
+static const struct of_device_id loopback_of_match[] = {
+	{ .compatible = "loopback-uart", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, loopback_of_match);
+
+static struct uart_dev_driver loopback_driver = {
+	.probe = loopback_probe,
+	.driver	= {
+		.name	= "loopback-uart",
+		.of_match_table = of_match_ptr(loopback_of_match),
+	},
+};
+module_uart_dev_driver(loopback_driver);
diff --git a/include/linux/uart_device.h b/include/linux/uart_device.h
new file mode 100644
index 0000000..a91d778
--- /dev/null
+++ b/include/linux/uart_device.h
@@ -0,0 +1,163 @@
+/*
+ * Copyright (C) 2016 Linaro Ltd.
+ * Author: Rob Herring <robh@kernel.org>
+ *
+ * Based on include/linux/spmi.h:
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
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
+#ifndef _LINUX_UART_DEVICE_H
+#define _LINUX_UART_DEVICE_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/circ_buf.h>
+#include <linux/mod_devicetable.h>
+
+/**
+ * struct uart_device - Basic representation of an SPMI device
+ * @dev:	Driver model representation of the device.
+ * @ctrl:	SPMI controller managing the bus hosting this device.
+ * @usid:	This devices' Unique Slave IDentifier.
+ */
+struct uart_device {
+	struct device		dev;
+	struct uart_controller	*ctrl;
+};
+
+static inline struct uart_device *to_uart_device(struct device *d)
+{
+	return container_of(d, struct uart_device, dev);
+}
+
+static inline void *uart_device_get_drvdata(const struct uart_device *sdev)
+{
+	return dev_get_drvdata(&sdev->dev);
+}
+
+static inline void uart_device_set_drvdata(struct uart_device *sdev, void *data)
+{
+	dev_set_drvdata(&sdev->dev, data);
+}
+
+struct uart_device *uart_device_alloc(struct uart_controller *ctrl);
+
+static inline void uart_device_put(struct uart_device *sdev)
+{
+	if (sdev)
+		put_device(&sdev->dev);
+}
+
+int uart_device_add(struct uart_device *sdev);
+
+void uart_device_remove(struct uart_device *sdev);
+
+struct uart_port;
+
+/**
+ * struct uart_controller - interface to the SPMI master controller
+ * @dev:	Driver model representation of the device.
+ * @nr:		board-specific number identifier for this controller/bus
+ * @cmd:	sends a non-data command sequence on the SPMI bus.
+ * @read_cmd:	sends a register read command sequence on the SPMI bus.
+ * @write_cmd:	sends a register write command sequence on the SPMI bus.
+ */
+struct uart_controller {
+	struct device		dev;
+	struct uart_port	*port;
+	unsigned int		nr;
+	struct circ_buf		recv;
+};
+
+static inline struct uart_controller *to_uart_controller(struct device *d)
+{
+	return container_of(d, struct uart_controller, dev);
+}
+
+static inline
+void *uart_controller_get_drvdata(const struct uart_controller *ctrl)
+{
+	return dev_get_drvdata(&ctrl->dev);
+}
+
+static inline void uart_controller_set_drvdata(struct uart_controller *ctrl,
+					       void *data)
+{
+	dev_set_drvdata(&ctrl->dev, data);
+}
+
+struct uart_controller *uart_controller_alloc(struct device *parent,
+					      size_t size);
+
+/**
+ * uart_controller_put() - decrement controller refcount
+ * @ctrl	SPMI controller.
+ */
+static inline void uart_controller_put(struct uart_controller *ctrl)
+{
+	if (ctrl)
+		put_device(&ctrl->dev);
+}
+
+int uart_controller_add(struct uart_controller *ctrl);
+void uart_controller_remove(struct uart_controller *ctrl);
+
+int uart_controller_rx(struct uart_controller *ctrl, unsigned int ch);
+
+/**
+ * struct spmi_driver - SPMI slave device driver
+ * @driver:	SPMI device drivers should initialize name and owner field of
+ *		this structure.
+ * @probe:	binds this driver to a SPMI device.
+ * @remove:	unbinds this driver from the SPMI device.
+ *
+ * If PM runtime support is desired for a slave, a device driver can call
+ * pm_runtime_put() from their probe() routine (and a balancing
+ * pm_runtime_get() in remove()).  PM runtime support for a slave is
+ * implemented by issuing a SLEEP command to the slave on runtime_suspend(),
+ * transitioning the slave into the SLEEP state.  On runtime_resume(), a WAKEUP
+ * command is sent to the slave to bring it back to ACTIVE.
+ */
+struct uart_dev_driver {
+	struct device_driver driver;
+	int	(*probe)(struct uart_device *sdev);
+	void	(*remove)(struct uart_device *sdev);
+};
+
+static inline struct uart_dev_driver *to_uart_dev_driver(struct device_driver *d)
+{
+	return container_of(d, struct uart_dev_driver, driver);
+}
+
+#define uart_dev_driver_register(sdrv) \
+	__uart_dev_driver_register(sdrv, THIS_MODULE)
+int __uart_dev_driver_register(struct uart_dev_driver *sdrv, struct module *owner);
+
+/**
+ * spmi_driver_unregister() - unregister an SPMI client driver
+ * @sdrv:	the driver to unregister
+ */
+static inline void uart_dev_driver_unregister(struct uart_dev_driver *sdrv)
+{
+	if (sdrv)
+		driver_unregister(&sdrv->driver);
+}
+
+#define module_uart_dev_driver(__uart_dev_driver) \
+	module_driver(__uart_dev_driver, uart_dev_driver_register, \
+			uart_dev_driver_unregister)
+
+int uart_dev_config(struct uart_device *udev, int baud, int parity, int bits, int flow);
+int uart_dev_connect(struct uart_device *udev);
+int uart_dev_tx(struct uart_device *udev, u8 *buf, size_t count);
+int uart_dev_rx(struct uart_device *udev, u8 *buf, size_t count);
+
+#endif
-- 
2.9.2
