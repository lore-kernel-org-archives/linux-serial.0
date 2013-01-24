From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Thu, 24 Jan 2013 18:30:21 +0800
Message-ID: <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com> <cover.1359022955.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1359022955.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org

In the recent ACPI 5.0 specification updates, firmwares are provided the
possibilities to enumerate the UART slave devices known to the platform
vendors.
There are the needs in Linux to utilize the benefits:
1. hotplug uevent
2. serial configuration
Currently, only serial cards on the specific bus (ex. PCMCIA) can be
enumerated and userspace can obtain the hotplug event of the UART target
devices. Linux kernel is lack of an overall enumeration mechanism for
UART slave devices.
In order to send uevent, a device need to be a class device or a bus
device. This patch introduces a tty_enum bus since the enumerated slave
devices are expected to be physical devices.
When the UART slave devices are created, userspace uevent rules can
pass the creation details to the userspace driver managers
(ex. hciattach), then the device managers can read hardware IDs and the
serial configurations from the exported device attributes to match and
configure a userspace TTY device driver.
The created slave devices will be automatically unregistered when the
associated TTY ports are destructed.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Fengguang Wu <fengguang.wu@intel.com>
---
History:
v5
 1. Build/boot test of this patch relies on Fengguang's 0-day kernel
    tests.
---
 drivers/tty/Kconfig              |    3 +
 drivers/tty/Makefile             |    1 +
 drivers/tty/serial/Kconfig       |    1 +
 drivers/tty/serial/serial_core.c |    2 +-
 drivers/tty/tty_enum.c           |  356 ++++++++++++++++++++++++++++++++++++++
 drivers/tty/tty_port.c           |   42 ++++-
 include/linux/mod_devicetable.h  |    6 +
 include/linux/tty.h              |  104 +++++++++++
 8 files changed, 511 insertions(+), 4 deletions(-)
 create mode 100644 drivers/tty/tty_enum.c

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 29dfc24..c0c8dd5 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -162,6 +162,9 @@ config LEGACY_PTY_COUNT
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.
 
+config TTY_ENUM
+	bool
+
 config BFIN_JTAG_COMM
 	tristate "Blackfin JTAG Communication"
 	depends on BLACKFIN
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 35649d3..ce7b340 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_TTY)		+= tty_io.o n_tty.o tty_ioctl.o tty_ldisc.o \
 				   tty_buffer.o tty_port.o tty_mutex.o
+obj-$(CONFIG_TTY_ENUM)		+= tty_enum.o
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
 obj-$(CONFIG_AUDIT)		+= tty_audit.o
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e9aeccd..b269dab 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -764,6 +764,7 @@ config SERIAL_HS_LPC32XX_CONSOLE
 
 config SERIAL_CORE
 	tristate
+	select TTY_ENUM
 
 config SERIAL_CORE_CONSOLE
 	bool
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ca98a3f..94ae5e1 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2669,7 +2669,7 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	/*
 	 * Remove the devices from the tty layer
 	 */
-	tty_unregister_device(drv->tty_driver, uport->line);
+	tty_port_unregister_device(port, drv->tty_driver, uport->line);
 
 	if (port->tty)
 		tty_vhangup(port->tty);
diff --git a/drivers/tty/tty_enum.c b/drivers/tty/tty_enum.c
new file mode 100644
index 0000000..7947f47
--- /dev/null
+++ b/drivers/tty/tty_enum.c
@@ -0,0 +1,356 @@
+
+/*
+ * tty_enum.c - TTY enumeration support
+ *
+ * Copyright (c) 2012, Intel Corporation
+ * Author: Lv Zheng <lv.zheng@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+
+
+static LIST_HEAD(tty_bus_id_list);
+static DEFINE_MUTEX(tty_bus_lock);
+
+struct tty_bus_id {
+	char bus_id[TTY_NAME_SIZE];
+	unsigned int instance_no;
+	struct list_head node;
+};
+
+static ssize_t tty_slave_show_name(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct tty_slave *tts = to_tty_slave(dev);
+	return sprintf(buf, "%s\n", tts->name);
+}
+
+static int create_modalias(struct tty_slave *tts, char *modalias, int size)
+{
+	int len;
+	int count;
+	int i;
+
+	if (!tts->nr_ids)
+		return 0;
+
+	len = snprintf(modalias, size, "%s:", TTY_MODULE_PREFIX);
+	size -= len;
+
+	for (i = 0; i < tts->nr_ids; i++) {
+		count = snprintf(&modalias[len], size, "%s:", tts->ids[i]);
+		if (count < 0 || count >= size)
+			return -EINVAL;
+		len += count;
+		size -= count;
+	}
+
+	modalias[len] = '\0';
+	return len;
+}
+
+static ssize_t tty_slave_show_modalias(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct tty_slave *tts = to_tty_slave(dev);
+	size_t len;
+
+	/* Device has no IDs or string is >1024 */
+	len = create_modalias(tts, buf, 1024);
+	if (len <= 0)
+		return 0;
+	buf[len++] = '\n';
+	return len;
+}
+
+static ssize_t tty_slave_show_tty_attrs(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct tty_slave *tts = to_tty_slave(dev);
+	int len = 0;
+
+	/* baud rate */
+	len += sprintf(buf+len, "%d ", tts->baud);
+
+	/* data bits */
+	switch (tts->cflag & CSIZE) {
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
+	if (tts->cflag & PARODD)
+		len += sprintf(buf+len, "O");
+	else if (tts->cflag & PARENB)
+		len += sprintf(buf+len, "E");
+	else
+		len += sprintf(buf+len, "N");
+
+	/* stop bits */
+	len += sprintf(buf+len, "%d", tts->cflag & CSTOPB ? 1 : 0);
+
+	/* HW/SW control */
+	if (tts->cflag & CRTSCTS)
+		len += sprintf(buf+len, " HW");
+	if ((tts->iflag & (IXON|IXOFF|IXANY)) != 0)
+		len += sprintf(buf+len, " SW");
+
+	len += sprintf(buf+len, "\n");
+	return len;
+}
+
+static ssize_t tty_slave_show_modem_lines(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct tty_slave *tts = to_tty_slave(dev);
+	int len = 0;
+
+	/* endian */
+	if (tts->mctrl & TIOCM_LE)
+		len += sprintf(buf+len, "LE:");
+	else
+		len += sprintf(buf+len, "BE:");
+
+	/* terminal lines */
+	if (tts->mctrl & TIOCM_DTR)
+		len += sprintf(buf+len, "DTR,");
+	if (tts->mctrl & TIOCM_RTS)
+		len += sprintf(buf+len, "RTS,");
+
+	/* modem lines */
+	if (tts->mctrl & TIOCM_CTS)
+		len += sprintf(buf+len, "CTS,");
+	if (tts->mctrl & TIOCM_CAR)
+		len += sprintf(buf+len, "CAR,");
+	if (tts->mctrl & TIOCM_RNG)
+		len += sprintf(buf+len, "RNG,");
+	if (tts->mctrl & TIOCM_DSR)
+		len += sprintf(buf+len, "DSR,");
+
+	len += sprintf(buf+len, "\n");
+	return len;
+}
+
+static DEVICE_ATTR(name, S_IRUGO, tty_slave_show_name, NULL);
+static DEVICE_ATTR(modalias, S_IRUGO, tty_slave_show_modalias, NULL);
+static DEVICE_ATTR(tty_attrs, S_IRUGO, tty_slave_show_tty_attrs, NULL);
+static DEVICE_ATTR(modem_lines, S_IRUGO, tty_slave_show_modem_lines, NULL);
+
+static struct attribute *tty_slave_attrs[] = {
+	&dev_attr_name.attr,
+	/* coldplug: modprobe $(cat .../modalias) */
+	&dev_attr_modalias.attr,
+	&dev_attr_tty_attrs.attr,
+	&dev_attr_modem_lines.attr,
+	NULL,
+};
+
+static struct attribute_group tty_slave_group = {
+	.attrs	= tty_slave_attrs,
+};
+
+static const struct attribute_group *tty_slave_groups[] = {
+	&tty_slave_group,
+	NULL,
+};
+
+#ifdef CONFIG_HOTPLUG
+static int tty_slave_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct tty_slave *tts = to_tty_slave(dev);
+	int len;
+
+	if (!tts->nr_ids)
+		return 0;
+
+	if (add_uevent_var(env, "MODALIAS="))
+		return -ENOMEM;
+	len = create_modalias(tts, &env->buf[env->buflen - 1],
+			      sizeof(env->buf) - env->buflen);
+	if (len >= (sizeof(env->buf) - env->buflen))
+		return -ENOMEM;
+	env->buflen += len;
+
+	dev_dbg(dev, "uevent\n");
+	return 0;
+}
+#else
+#define tty_slave_uevent	NULL
+#endif
+
+static void tty_slave_release(struct device *dev)
+{
+	struct tty_slave *tts = to_tty_slave(dev);
+
+	kfree(tts);
+	/* Test code to see if slave device get released */
+	BUG();
+}
+
+struct device_type tty_slave_type = {
+	.name		= "tty_slave",
+	.groups		= tty_slave_groups,
+	.uevent		= tty_slave_uevent,
+	.release	= tty_slave_release,
+};
+EXPORT_SYMBOL_GPL(tty_slave_type);
+
+/**
+ * tty_bus_register_slave - register a physical tty slave device
+ * @port: the tty port
+ * @info: the tty slave device description
+ *
+ * Initialize and add a physical tty slave device.
+ *
+ * This returns the new physical tty slave device, which may be saved for
+ * later use with device_unregister; or NULL to indicate an error.
+ */
+struct tty_slave *tty_bus_register_slave(struct tty_port *port,
+		struct tty_board_info const *info)
+{
+	struct tty_slave *tts;
+	struct tty_bus_id *bus_id, *new_bus_id;
+	struct device *dev = NULL;
+	int i;
+	int status;
+	int found = 0;
+
+	/* Drivers having not called tty_port_register_device, should not
+	 * call this API.
+	 */
+	BUG_ON(!info || !port || !port->dev);
+	dev = port->dev;
+
+	tts = kzalloc(sizeof(struct tty_slave) + info->nr_ids * TTY_NAME_SIZE,
+		      GFP_KERNEL);
+	if (!tts) {
+		dev_err(dev, "Failed to alloc tty_slave %s.\n", info->type);
+		return NULL;
+	}
+
+	new_bus_id = kzalloc(sizeof(struct tty_bus_id), GFP_KERNEL);
+	if (!new_bus_id) {
+		dev_err(dev, "Failed to alloc tty_bus_id for %s.\n",
+			info->type);
+		goto fail;
+	}
+
+	tts->dev.parent = dev;
+	tts->dev.bus = &tty_enum_bus;
+	tts->dev.type = &tty_slave_type;
+
+	tts->dev.platform_data = info->platform_data;
+	if (info->archdata)
+		tts->dev.archdata = *info->archdata;
+
+	tts->baud = info->baud;
+	tts->cflag = info->cflag;
+	tts->iflag = info->iflag;
+	tts->mctrl = info->mctrl;
+	tts->irq = info->irq;
+
+	strlcpy(tts->name, info->type, TTY_NAME_SIZE);
+	for (i = 0; i < info->nr_ids; i++)
+		strlcpy(tts->ids[i], info->ids[i], TTY_NAME_SIZE);
+	tts->nr_ids = info->nr_ids;
+
+	mutex_lock(&tty_bus_lock);
+	list_for_each_entry(bus_id, &tty_bus_id_list, node) {
+		if (!strcmp(bus_id->bus_id, info->type)) {
+			bus_id->instance_no++;
+			found = 1;
+			kfree(new_bus_id);
+			break;
+		}
+	}
+	if (!found) {
+		bus_id = new_bus_id;
+		strcpy(bus_id->bus_id, info->type);
+		bus_id->instance_no = 0;
+		list_add_tail(&bus_id->node, &tty_bus_id_list);
+	}
+	dev_set_name(&tts->dev, "%s:%02x", bus_id->bus_id, bus_id->instance_no);
+	mutex_unlock(&tty_bus_lock);
+
+	status = device_register(&tts->dev);
+	if (status) {
+		dev_err(dev, "Failed to register slave device %s.\n",
+			info->type);
+		goto fail;
+	}
+	dev_info(dev, "Registered slave device %s.\n", info->type);
+
+	return tts;
+
+fail:
+	kfree(tts);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(tty_bus_register_slave);
+
+static int __unregister(struct device *dev, void *null)
+{
+	if (is_tty_slave(dev))
+		device_unregister(dev);
+	return 0;
+}
+
+void tty_bus_unregister_slaves(struct tty_port *port)
+{
+	if (port->dev)
+		(void)device_for_each_child(port->dev, NULL, __unregister);
+}
+EXPORT_SYMBOL_GPL(tty_bus_unregister_slaves);
+
+void tty_bus_register_master(struct tty_port *port, struct device *dev)
+{
+	BUG_ON(!port);
+	if (dev)
+		port->dev = get_device(dev);
+}
+EXPORT_SYMBOL_GPL(tty_bus_register_master);
+
+void tty_bus_unregister_master(struct tty_port *port)
+{
+	BUG_ON(!port);
+	if (port->dev) {
+		tty_bus_unregister_slaves(port);
+		put_device(port->dev);
+		port->dev = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(tty_bus_unregister_master);
+
+struct bus_type tty_enum_bus = {
+	.name		= "tty_enum",
+};
+EXPORT_SYMBOL_GPL(tty_enum_bus);
+
+static int __init tty_bus_init(void)
+{
+	return bus_register(&tty_enum_bus);
+}
+
+postcore_initcall(tty_bus_init);
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index b7ff59d..8864124 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -69,8 +69,13 @@ struct device *tty_port_register_device(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device)
 {
+	struct device *dev;
+
 	tty_port_link_device(port, driver, index);
-	return tty_register_device(driver, index, device);
+	dev = tty_register_device(driver, index, device);
+	tty_bus_register_master(port, dev);
+
+	return dev;
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device);
 
@@ -92,12 +97,33 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
 		struct device *device, void *drvdata,
 		const struct attribute_group **attr_grp)
 {
+	struct device *dev;
+
 	tty_port_link_device(port, driver, index);
-	return tty_register_device_attr(driver, index, device, drvdata,
-			attr_grp);
+	dev = tty_register_device_attr(driver, index, device, drvdata,
+				       attr_grp);
+	tty_bus_register_master(port, dev);
+
+	return dev;
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device_attr);
 
+/**
+ * tty_port_unregister_device_attr - unregister tty device
+ * @port: tty_port of the device
+ * @driver: tty_driver for this device
+ * @index: index of the tty
+ *
+ * The reverse call for tty_register_device.
+ */
+void tty_port_unregister_device(struct tty_port *port,
+		struct tty_driver *driver, unsigned index)
+{
+	tty_bus_unregister_master(port);
+	tty_unregister_device(driver, index);
+}
+EXPORT_SYMBOL_GPL(tty_port_unregister_device);
+
 int tty_port_alloc_xmit_buf(struct tty_port *port)
 {
 	/* We may sleep in get_zeroed_page() */
@@ -132,6 +158,16 @@ EXPORT_SYMBOL(tty_port_free_xmit_buf);
  */
 void tty_port_destroy(struct tty_port *port)
 {
+	/*
+	 * XXX: TTY Driver Cleanup
+	 *
+	 * If you got panic here, it means you have enabled the TTY bus
+	 * enumeration support for your TTY driver but you haven't updated
+	 * your TTY driver code to call the tty_port_unregister_device
+	 * instead of the tty_unregister_device as a destruction
+	 * corresponding to the tty_port_register_device.
+	 */
+	BUG_ON(port->dev);
 	tty_buffer_free_all(port);
 }
 EXPORT_SYMBOL(tty_port_destroy);
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index fed3def..f1c4875 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -433,6 +433,12 @@ struct rpmsg_device_id {
 	char name[RPMSG_NAME_SIZE];
 };
 
+/* tty */
+
+/* TTY slave name size */
+#define TTY_NAME_SIZE	32
+#define TTY_MODULE_PREFIX "tty:"
+
 /* i2c */
 
 #define I2C_NAME_SIZE	20
diff --git a/include/linux/tty.h b/include/linux/tty.h
index c75d886..b8d5dfb 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -9,6 +9,7 @@
 #include <linux/tty_ldisc.h>
 #include <linux/mutex.h>
 #include <linux/tty_flags.h>
+#include <linux/mod_devicetable.h>
 #include <uapi/linux/tty.h>
 
 
@@ -154,6 +155,105 @@ struct tty_bufhead {
 
 struct device;
 struct signal_struct;
+struct tty_slave;
+struct tty_board_info;
+
+/**
+ * struct tty_board_info - template for slave device creation
+ * @type: chip type, to initialize tty_slave.name
+ * @cflag: termio cflag, preferred termio cflag to be used to communicate
+ *         with this slave device
+ * @iflag: termio iflag, preferred termio iflag to be used to communicate
+ *         with this slave device
+ * @mctrl: termio mctrl, preferred termio mctrl to be used to communicate
+ *         with this slave device
+ * @baud: termio baud, preferred termio baud rate to be used to communicate
+ *        with this slave device
+ * @irq: stored in tty_slave.irq
+ * @platform_data: stored in tty_slave.dev.platform_data
+ * @archdata: copied into tty_slave.dev.archdata
+ * @nr_ids: number of IDs
+ * @ids: ID strings
+ *
+ * tty_board_info is used to build tables of information listing TTY
+ * devices that are present. This information is used to grow the driver
+ * model tree. For add-on boards, tty_bus_register_slave() does this
+ * dynamically with the host side physical device already known.
+ */
+struct tty_board_info {
+	char type[TTY_NAME_SIZE];
+	unsigned int cflag;	/* termio cflag */
+	unsigned int iflag;	/* termio iflag */
+	unsigned int mctrl;	/* modem ctrl settings */
+	unsigned int baud;
+	int irq;
+	void *platform_data;
+	struct dev_archdata *archdata;
+
+	int nr_ids;
+	/* This must be the last member of tty_board_info */
+	char ids[0][TTY_NAME_SIZE];
+};
+
+/**
+ * struct tty_slave - represent a TTY slave device
+ * @name: Indicates the type of the device, usually a chip name that's
+ *        generic enough to hide second-sourcing and compatible revisions
+ * @cflag: preferred termio cflag used to communicate with this slave
+ *         device
+ * @iflag: preferred termio iflag used to communicate with this slave
+ *         device
+ * @mctrl: preferred termio mctrl used to communicate with this slave
+ *         device
+ * @baud: preferred termio baud rate used to communicate with this slave
+ *        device
+ * @irq: indicates the IRQ generated by this slave device (if any)
+ * @dev: driver model device node for the slave device
+ * @nr_ids: number of IDs
+ * @ids: ID strings
+ *
+ * A tty_slave identifies a single device (i.e. chip) connected to a tty
+ * port.
+ */
+struct tty_slave {
+	char			name[TTY_NAME_SIZE];
+	unsigned int		cflag;	/* termio cflag */
+	unsigned int		iflag;	/* termio iflag */
+	unsigned int		mctrl;	/* modem ctrl settings */
+	unsigned int		baud;
+	int			irq;	/* irq issued by device */
+	struct device		dev;
+	int			nr_ids;
+	char			ids[0][TTY_NAME_SIZE];
+};
+
+extern struct device_type tty_slave_type;
+
+#define is_tty_slave(d) ((d) && (d)->type == &tty_slave_type)
+#define to_tty_slave(d) container_of(d, struct tty_slave, dev)
+
+static inline struct tty_slave *tty_verify_slave(struct device *dev)
+{
+	return is_tty_slave(dev) ? to_tty_slave(dev) : NULL;
+}
+
+#ifdef CONFIG_TTY_ENUM
+struct tty_slave *tty_bus_register_slave(struct tty_port *port,
+		struct tty_board_info const *info);
+void tty_bus_unregister_slaves(struct tty_port *port);
+void tty_bus_register_master(struct tty_port *port, struct device *dev);
+void tty_bus_unregister_master(struct tty_port *port);
+#else
+static inline struct tty_slave *tty_bus_register_slave(struct tty_port *port,
+		struct tty_board_info const *info)
+{
+	return NULL;
+}
+static inline void tty_bus_unregister_slaves(struct tty_port *port) {}
+static inline void tty_bus_register_master(struct tty_port *port,
+		struct device *dev) {}
+static inline void tty_bus_unregister_master(struct tty_port *port) {}
+#endif
 
 /*
  * Port level information. Each device keeps its own port level information
@@ -189,6 +289,7 @@ struct tty_port_operations {
 	
 struct tty_port {
 	struct tty_bufhead	buf;		/* Locked internally */
+	struct device		*dev;		/* Registered tty device */
 	struct tty_struct	*tty;		/* Back pointer */
 	struct tty_struct	*itty;		/* internal back ptr */
 	const struct tty_port_operations *ops;	/* Port operations */
@@ -358,6 +459,7 @@ extern struct ktermios tty_std_termios;
 extern int vcs_init(void);
 
 extern struct class *tty_class;
+extern struct bus_type tty_enum_bus;
 
 /**
  *	tty_kref_get		-	get a tty reference
@@ -478,6 +580,8 @@ extern struct device *tty_port_register_device_attr(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device, void *drvdata,
 		const struct attribute_group **attr_grp);
+extern void tty_port_unregister_device(struct tty_port *port,
+		struct tty_driver *driver, unsigned index);
 extern int tty_port_alloc_xmit_buf(struct tty_port *port);
 extern void tty_port_free_xmit_buf(struct tty_port *port);
 extern void tty_port_destroy(struct tty_port *port);
-- 
1.7.10

