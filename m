From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/4] UART: Add UART subsystem as a bus.
Date: Wed,  5 Dec 2012 11:51:43 +0800
Message-ID: <84a7dfd86a51ee65b4abfaafcdf7a2e473fdd876.1354677952.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com> <cover.1354677952.git.lv.zheng@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13801 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176Ab2LEDvt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Dec 2012 22:51:49 -0500
In-Reply-To: <cover.1354677952.git.lv.zheng@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

Tranditional UARTs are used as communication pipes between the hosts
while the modern computing systems equipped with HSU (High Speed UARTs)
would connect on-board target devices using the UART ports. The role of
the UART controllers is changed from the communication facility to the
platform bus.

In the recent ACPI 5.0 specification updates, firmwares are provided the
possibilities to enumerate the UART target devices known to the platform
vendors.
Thus there are the needs for enumerating the UART target devices:
1. hotplug uevent
2. serial configuration
Currently, only serial cards on the specific bus (ex. PCMCIA) can be
enumerated and userspace can obtain the hotplug event of the UART target
devices. Linux kernel is lack of an overall enumeration mechanism for
UART target devices.
In order to send uevent, a device need to be a class device or a bus
device. This patch introduces a bus_type subsystem to manage the new
UART target device type for the purpose of being ready for the possible
future extensions.
When the UART target devices are created, userspace uevent rules can
pass the creation details to the userspace driver managers
(ex. hciattach). Here is an example of the uevents and exported
attributes of these new UART target devices:

Test DSDT (dummy UART host adapter INTF000 and target device INTF001):
  Device (UA00)
  {
      Name (_HID, "INTF000")  // _HID: Hardware ID
      Name (RBUF, ResourceTemplate ()
      {
          Memory32Fixed (ReadWrite,
              0x00000000,         // Address Base
              0x00001000)         // Address Length
      })
      Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
      {
          Return (RBUF)
      }
      Method (_STA, 0, NotSerialized)  // _STA: Status
      {
          Return (0x0F)
      }
      Device (BTH0)
      {
          Name (_HID, "INTF001")  // _HID: Hardware ID
          Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
          {
              Name (UBUF, ResourceTemplate ()
              {
                  UartSerialBus (0x0001C200, DataBitsEight, StopBitsOne,
                      0xC0, LittleEndian, ParityTypeNone, FlowControlHardware,
                      0x0020, 0x0020, "\\_SB.PCI0.UA00",
                      0x00, ResourceConsumer, ,
                      )
              })
              Return (UBUF)
          }
          Method (_STA, 0, NotSerialized)  // _STA: Status
          {
              Return (0x0F)
          }
      }
  }

uevent and environments:
KERNEL[252.443458] add      /bus/uart (bus)
ACTION=add
DEVPATH=/bus/uart
SEQNUM=1142
SUBSYSTEM=bus

KERNEL[268.491709] add      /devices/platform/INTF000:00/INTF001:00 (uart)
ACTION=add
DEVPATH=/devices/platform/INTF000:00/INTF001:00
DEVTYPE=uart_device
MODALIAS=uart:INTF001:00
SEQNUM=1144
SUBSYSTEM=uart

kobject attribute files:
# cat /sys/bus/uart/devices/INTF001:00/modalias
uart:INTF001:00
# cat /sys/bus/uart/devices/INTF001:00/tty_dev
ttyS0
# cat /sys/bus/uart/devices/INTF001:00/tty_attrs
115200 8N0 HW
# cat /sys/bus/uart/devices/INTF001:00/modem_lines
LE:RTS,CTS,

kobject sysfs links:
# ls -l /sys/bus/uart/devices
INTF001:00 -> ../../../devices/platform/INTF000:00/INTF001:00
# ls -l /sys/devices/platform/INTF000:00/INTF001:00
subsystem -> ../../../../bus/uart
host_node -> ../tty/ttyS0
# ls -l /sys/devices/platform/INTF000:00/tty/ttyS0
target_node -> ../../INTF001:00

History:
v1:
  1. Add uart bus type subsystem.
  2. Add physical uart target device (uart_device).
  3. Add logical uart host adapter (klist).
  4. Add uart target device attributes.
  5. Create tty_device<->uart_device links.
v2.
  1. Change uart driver related stuff to tty driver.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/tty/serial/Makefile     |    2 +-
 drivers/tty/serial/serial_bus.c |  412 +++++++++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h |    5 +
 include/linux/serial_bus.h      |   75 +++++++
 4 files changed, 493 insertions(+), 1 deletion(-)
 create mode 100644 drivers/tty/serial/serial_bus.c
 create mode 100644 include/linux/serial_bus.h

diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 4f694da..4400521 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the kernel serial device drivers.
 #
 
-obj-$(CONFIG_SERIAL_CORE) += serial_core.o
+obj-$(CONFIG_SERIAL_CORE) += serial_core.o serial_bus.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o
 
 # These Sparc drivers have to appear before others such as 8250
diff --git a/drivers/tty/serial/serial_bus.c b/drivers/tty/serial/serial_bus.c
new file mode 100644
index 0000000..afbb885
--- /dev/null
+++ b/drivers/tty/serial/serial_bus.c
@@ -0,0 +1,412 @@
+/*
+ * serial_bus.c - UART bus implementation
+ *
+ * Copyright (c) 2012, Intel Corporation
+ * Author: Lv Zheng <lv.zheng@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+/*
+ * Tranditional UARTs are used as communication pipes between the hosts
+ * while the modern computing systems equipped with HSU (High Speed UARTs)
+ * would connect on-board target devices using the UART ports. The role of
+ * the UART controllers are changed from the communication facility to the
+ * platform bus.
+ *
+ * UART target devices are created in the kernel as struct uart_device.
+ * It is defined for the following purposes:
+ * 1. Sending hotplug notifications to the userspace
+ * 2. Exporting serial configuration parameters to the userspace
+ * 3. Allowing target device based PM to be added easily
+ *
+ */
+
+#include <linux/serial.h>
+#include <linux/serial_bus.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+
+
+struct uart_match {
+	dev_t devt;
+};
+
+static int do_uart_tty_find(struct device *dev, void *data)
+{
+	struct uart_match *match = data;
+	return dev->devt == match->devt;
+}
+
+/**
+ * uart_tty_find - find the tty device using the line number
+ * @drv: the tty host driver
+ * @line: the line number of the tty device
+ * @dev: the physical uart host adapter
+ *
+ * Return a matching tty device on the host adapter.
+ */
+struct device *uart_tty_find(struct tty_driver *drv, unsigned int line,
+			     struct device *dev)
+{
+	struct uart_match match;
+
+	match.devt = MKDEV(drv->major, drv->minor_start + line);
+
+	return device_find_child(dev, &match, do_uart_tty_find);
+}
+EXPORT_SYMBOL_GPL(uart_tty_find);
+
+/**
+ * uart_tty_name - get the name of the tty device according to the line
+ *                 number
+ * @drv: the tty host driver
+ * @line: the line number of the tty device
+ * @p: pointer to the buffer containing the returned name
+ *
+ * Return the name of the tty device.
+ */
+void uart_tty_name(struct tty_driver *drv, unsigned int line, char *p)
+{
+	BUG_ON(!drv || !p);
+
+	if (drv->flags & TTY_DRIVER_UNNUMBERED_NODE)
+		strcpy(p, drv->name);
+	else
+		sprintf(p, "%s%d", drv->name, line + drv->name_base);
+}
+EXPORT_SYMBOL_GPL(uart_tty_name);
+
+static ssize_t uart_dev_show_name(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct uart_device *udev = to_uart_device(dev);
+	return sprintf(buf, "%s\n", udev->name);
+}
+
+static ssize_t uart_dev_show_modalias(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct uart_device *udev = to_uart_device(dev);
+	return sprintf(buf, "%s%s\n", UART_MODULE_PREFIX, udev->name);
+}
+
+static ssize_t uart_dev_show_tty_dev(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct uart_device *udev = to_uart_device(dev);
+	return sprintf(buf, "%s\n", udev->tty_name);
+}
+
+static ssize_t uart_dev_show_tty_attrs(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct uart_device *udev = to_uart_device(dev);
+	int len = 0;
+
+	/* baud rate */
+	len += sprintf(buf+len, "%d ", udev->baud);
+
+	/* data bits */
+	switch (udev->cflag & CSIZE) {
+	case CS5:
+		len += sprintf(buf+len, "5");
+		break;
+	case CS6:
+		len += sprintf(buf+len, "6");
+		break;
+	case CS7:
+		len += sprintf(buf+len, "7");
+		break;
+	case CS8:
+	default:
+		len += sprintf(buf+len, "8");
+		break;
+	}
+
+	/* parity */
+	if (udev->cflag & PARODD)
+		len += sprintf(buf+len, "O");
+	else if (udev->cflag & PARENB)
+		len += sprintf(buf+len, "E");
+	else
+		len += sprintf(buf+len, "N");
+
+	/* stop bits */
+	len += sprintf(buf+len, "%d", udev->cflag & CSTOPB ? 1 : 0);
+
+	/* HW/SW control */
+	if (udev->cflag & CRTSCTS)
+		len += sprintf(buf+len, " HW");
+	if ((udev->iflag & (IXON|IXOFF|IXANY)) != 0)
+		len += sprintf(buf+len, " SW");
+
+	len += sprintf(buf+len, "\n");
+	return len;
+}
+
+static ssize_t uart_dev_show_modem_lines(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct uart_device *udev = to_uart_device(dev);
+	int len = 0;
+
+	/* endian */
+	if (udev->mctrl & TIOCM_LE)
+		len += sprintf(buf+len, "LE:");
+	else
+		len += sprintf(buf+len, "BE:");
+
+	/* terminal lines */
+	if (udev->mctrl & TIOCM_DTR)
+		len += sprintf(buf+len, "DTR,");
+	if (udev->mctrl & TIOCM_RTS)
+		len += sprintf(buf+len, "RTS,");
+
+	/* modem lines */
+	if (udev->mctrl & TIOCM_CTS)
+		len += sprintf(buf+len, "CTS,");
+	if (udev->mctrl & TIOCM_CAR)
+		len += sprintf(buf+len, "CAR,");
+	if (udev->mctrl & TIOCM_RNG)
+		len += sprintf(buf+len, "RNG,");
+	if (udev->mctrl & TIOCM_DSR)
+		len += sprintf(buf+len, "DSR,");
+
+	len += sprintf(buf+len, "\n");
+	return len;
+}
+
+static DEVICE_ATTR(name, S_IRUGO, uart_dev_show_name, NULL);
+static DEVICE_ATTR(modalias, S_IRUGO, uart_dev_show_modalias, NULL);
+static DEVICE_ATTR(tty_dev, S_IRUGO, uart_dev_show_tty_dev, NULL);
+static DEVICE_ATTR(tty_attrs, S_IRUGO, uart_dev_show_tty_attrs, NULL);
+static DEVICE_ATTR(modem_lines, S_IRUGO, uart_dev_show_modem_lines, NULL);
+
+static struct attribute *uart_dev_attrs[] = {
+	&dev_attr_name.attr,
+	/* coldplug: modprobe $(cat .../modalias) */
+	&dev_attr_modalias.attr,
+	&dev_attr_tty_dev.attr,
+	&dev_attr_tty_attrs.attr,
+	&dev_attr_modem_lines.attr,
+	NULL,
+};
+
+static struct attribute_group uart_dev_attr_group = {
+	.attrs	= uart_dev_attrs,
+};
+
+static const struct attribute_group *uart_dev_attr_groups[] = {
+	&uart_dev_attr_group,
+	NULL,
+};
+
+#ifdef CONFIG_HOTPLUG
+static int uart_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct uart_device *udev = to_uart_device(dev);
+
+	if (add_uevent_var(env, "MODALIAS=%s%s",
+			   UART_MODULE_PREFIX, udev->name))
+		return -ENOMEM;
+
+	dev_dbg(dev, "uevent\n");
+	return 0;
+}
+#else
+#define uart_device_uevent	NULL
+#endif
+
+static void uart_device_release(struct device *dev)
+{
+	struct uart_device *udev = to_uart_device(dev);
+
+	put_device(udev->tty);
+	kfree(udev);
+}
+
+struct device_type uart_device_type = {
+	.name		= "uart_device",
+	.groups		= uart_dev_attr_groups,
+	.uevent		= uart_device_uevent,
+	.release	= uart_device_release,
+};
+EXPORT_SYMBOL_GPL(uart_device_type);
+
+/**
+ * uart_register_device - register a physical uart target device
+ * @adap: the logical uart host adapter
+ * @dev: the physical uart host adapter
+ * @drv: the tty host driver
+ * @info: the uart target device description
+ *
+ * Initialize and add a physical uart target device.
+ *
+ * This returns the new uart target device, which may be saved for later use
+ * with uart_unregister_device; or NULL to indicate an error.
+ */
+struct uart_device *uart_register_device(struct klist *adap,
+					 struct device *dev,
+					 struct tty_driver *drv,
+					 struct uart_board_info const *info)
+{
+	struct uart_device *udev;
+	struct device *tty;
+	int status;
+
+	BUG_ON((!adap && !dev) || !drv);
+
+	udev = kzalloc(sizeof(struct uart_device), GFP_KERNEL);
+	if (!udev)
+		return NULL;
+
+	strlcpy(udev->name, info->type, sizeof(udev->name));
+
+	udev->baud = info->baud;
+	udev->cflag = info->cflag;
+	udev->iflag = info->iflag;
+	udev->mctrl = info->mctrl;
+
+	udev->dev.parent = dev;
+	udev->dev.bus = &uart_bus_type;
+	udev->dev.type = &uart_device_type;
+
+	tty = uart_tty_find(drv, info->line, dev);
+	if (!tty) {
+		dev_err(dev, "Cannot find associated tty device at line %d.\n",
+			info->line);
+		goto fail;
+	}
+	udev->tty = get_device(tty);
+	uart_tty_name(drv, info->line, udev->tty_name);
+
+	dev_set_name(&udev->dev, "%s", udev->name);
+	status = device_register(&udev->dev);
+	if (status) {
+		dev_err(dev,
+			"Failed to register uart target device at line %d.\n",
+			info->line);
+		goto fail2;
+	}
+	dev_info(&udev->dev, "Registered at line %d.\n", info->line);
+
+	status = sysfs_create_link(&tty->kobj, &udev->dev.kobj, "target_node");
+	status = sysfs_create_link(&udev->dev.kobj, &tty->kobj, "host_node");
+
+	if (adap) {
+		udev->adap = adap;
+		klist_add_tail(&udev->klist_parent, adap);
+	}
+
+	return udev;
+
+fail2:
+	put_device(tty);
+fail:
+	kfree(udev);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(uart_register_device);
+
+/**
+ * uart_unregister_device - unregister a physical uart target device
+ * @udev: the physical uart target device
+ *
+ * Reverse effect of uart_register_device().
+ */
+void uart_unregister_device(struct uart_device *udev)
+{
+	if (!udev)
+		return;
+	dev_info(&udev->dev, "Unregistering...\n");
+
+	if (udev->adap)
+		klist_del(&udev->klist_parent);
+	sysfs_remove_link(&udev->dev.kobj, "host_node");
+	if (udev->tty)
+		sysfs_remove_link(&udev->tty->kobj, "target_node");
+	device_unregister(&udev->dev);
+}
+EXPORT_SYMBOL_GPL(uart_unregister_device);
+
+static void klist_uart_get(struct klist_node *n)
+{
+	struct uart_device *udev = uart_device_from_parent(n);
+	get_device(&udev->dev);
+}
+
+static void klist_uart_put(struct klist_node *n)
+{
+	struct uart_device *udev = uart_device_from_parent(n);
+	put_device(&udev->dev);
+}
+
+static struct uart_device *uart_next_device(struct klist_iter *i)
+{
+	struct klist_node *n = klist_next(i);
+	return n ? uart_device_from_parent(n) : NULL;
+}
+
+/**
+ * uart_add_adapter - register a logical uart host adapter
+ * @adap: the logical uart host adapter
+ *
+ * Initialize a logical uart host adapter.
+ */
+int uart_add_adapter(struct klist *adap)
+{
+	klist_init(adap, klist_uart_get, klist_uart_put);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uart_add_adapter);
+
+/**
+ * uart_del_adapter - unregister a logical uart host adapter
+ * @adap: the logical uart host adapter
+ *
+ * Reverse effect of uart_add_adapter().
+ */
+void uart_del_adapter(struct klist *adap)
+{
+	struct klist_iter i;
+	struct uart_device *udev;
+
+	if (!adap)
+		return;
+
+	klist_iter_init(adap, &i);
+	while ((udev = uart_next_device(&i)))
+		uart_unregister_device(udev);
+	klist_iter_exit(&i);
+}
+EXPORT_SYMBOL_GPL(uart_del_adapter);
+
+struct bus_type uart_bus_type = {
+	.name		= "uart",
+};
+EXPORT_SYMBOL_GPL(uart_bus_type);
+
+static int __init uart_bus_init(void)
+{
+	int retval;
+
+	retval = bus_register(&uart_bus_type);
+	if (retval)
+		return retval;
+
+	return 0;
+}
+
+static void __exit uart_bus_exit(void)
+{
+	bus_unregister(&uart_bus_type);
+}
+
+subsys_initcall(uart_bus_init);
+module_exit(uart_bus_exit);
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index fed3def..28df140 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -455,6 +455,11 @@ struct spi_device_id {
 			__attribute__((aligned(sizeof(kernel_ulong_t))));
 };
 
+/* uart */
+
+#define UART_NAME_SIZE	32
+#define UART_MODULE_PREFIX "uart:"
+
 /* dmi */
 enum dmi_field {
 	DMI_NONE,
diff --git a/include/linux/serial_bus.h b/include/linux/serial_bus.h
new file mode 100644
index 0000000..6d66fe2
--- /dev/null
+++ b/include/linux/serial_bus.h
@@ -0,0 +1,75 @@
+/*
+ * serial_bus.h - UART bus implementation
+ *
+ * Copyright (c) 2012, Intel Corporation
+ * Author: Lv Zheng <lv.zheng@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+#ifndef LINUX_SERIAL_BUS_H
+#define LINUX_SERIAL_BUS_H
+
+#include <linux/compiler.h>
+#include <linux/tty.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+
+struct uart_device;
+
+/*
+ * UART Bus
+ */
+struct uart_board_info {
+	char type[UART_NAME_SIZE];
+	unsigned int line;	/* port index */
+	unsigned int cflag;	/* termio cflag */
+	unsigned int iflag;	/* termio iflag */
+	unsigned int mctrl;	/* modem ctrl settings */
+	unsigned int baud;
+	int irq;
+};
+
+extern struct bus_type uart_bus_type;
+
+int uart_add_adapter(struct klist *adap);
+void uart_del_adapter(struct klist *adap);
+
+struct uart_device {
+	char			name[UART_NAME_SIZE];
+	char			tty_name[64];
+	unsigned int		cflag;	/* termio cflag */
+	unsigned int		iflag;	/* termio iflag */
+	unsigned int		mctrl;	/* modem ctrl settings */
+	unsigned int		baud;
+	struct device		dev;
+	struct device		*tty;
+	struct klist_node	klist_parent;
+	struct klist		*adap;	/* set for multi-port adapter */
+};
+
+extern struct device_type uart_device_type;
+
+#define is_uart_device(d) ((d) && (d)->type == &uart_device_type)
+#define to_uart_device(d) container_of(d, struct uart_device, dev)
+#define uart_device_from_parent(n)	\
+	container_of(n, struct uart_device, klist_parent)
+
+static inline struct uart_device *uart_verify_device(struct device *dev)
+{
+	return is_uart_device(dev) ? to_uart_device(dev) : NULL;
+}
+
+struct uart_device *uart_register_device(struct klist *adap,
+					 struct device *dev,
+					 struct tty_driver *drv,
+					 struct uart_board_info const *info);
+void uart_unregister_device(struct uart_device *udev);
+
+struct device *uart_tty_find(struct tty_driver *drv, unsigned int line,
+			     struct device *dev);
+void uart_tty_name(struct tty_driver *driver, unsigned int line, char *p);
+
+#endif /* LINUX_SERIAL_BUS_H */
-- 
1.7.10

