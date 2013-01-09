From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v4 2/3] ACPI / UART: Add ACPI enumeration support for UART.
Date: Wed, 9 Jan 2013 09:18:02 +0000 (UTC)
Message-ID: <a5fffeddd854a21c21c7a9d7f3aafa558ad3dc62.1357837482.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com> <cover.1357837482.git.lv.zheng@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39318 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757438Ab3AIJRu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Jan 2013 04:17:50 -0500
Date: Fri, 11 Jan 2013 01:17:13 +0800
In-Reply-To: <cover.1357837482.git.lv.zheng@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

ACPI 5.0 specification introduces mechanisms of enumerating the slave
devices connected on the serial buses.
This patch follows the specification, implementing such UART enumeration
machanism for Linux.
In order to use this UART device enumeration mechanism, driver writers
are required to call the following API:
Call acpi_tty_register_devices _after_ the creation of the tty ports:
   tty_port_register_device(port, driver, i, parent);
   acpi_uart_register_devices(port);
Where:
   port: the registered tty port.
   parent: the physical device of the UART ports.
   driver and index: required parameters for tty_port_register_device.
In this patch, only SERIAL_CORE drivers are enabled to use this ACPI
UART enumeration mechanism. This can be changed if there are needs
updated in the future.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/Kconfig     |    6 ++
 drivers/acpi/Makefile    |    1 +
 drivers/acpi/acpi_uart.c |  215 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/tty/tty_enum.c   |    1 +
 include/linux/tty.h      |    8 ++
 5 files changed, 231 insertions(+)
 create mode 100644 drivers/acpi/acpi_uart.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 38c5078..98e2d4e 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -187,6 +187,12 @@ config ACPI_I2C
 	help
 	  ACPI I2C enumeration support.
 
+config ACPI_UART
+	def_tristate TTY_ENUM
+	depends on TTY_ENUM
+	help
+	  ACPI UART enumeration support.
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	select THERMAL
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 2a4502b..784f332 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_I2C)		+= acpi_i2c.o
+obj-$(CONFIG_ACPI_UART)		+= acpi_uart.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o processor_throttling.o
diff --git a/drivers/acpi/acpi_uart.c b/drivers/acpi/acpi_uart.c
new file mode 100644
index 0000000..6b1842a
--- /dev/null
+++ b/drivers/acpi/acpi_uart.c
@@ -0,0 +1,215 @@
+/*
+ * acpi_uart.c - ACPI UART enumeration support
+ *
+ * Copyright (c) 2012, Intel Corporation
+ * Author: Lv Zheng <lv.zheng@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/init.h>
+#include <linux/tty.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <acpi/acpi.h>
+#include <acpi/acpi_bus.h>
+
+
+static int acpi_uart_add_resources(struct acpi_resource *ares, void *context)
+{
+	struct tty_board_info *info = context;
+
+	if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
+		struct acpi_resource_uart_serialbus *sb;
+
+		sb = &ares->data.uart_serial_bus;
+		if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_UART)
+			return 1;
+
+		/* baud rate */
+		info->baud = sb->default_baud_rate;
+
+		/* data bits */
+		info->cflag &= ~CSIZE;
+		switch (sb->data_bits) {
+		case ACPI_UART_5_DATA_BITS:
+			info->cflag |= CS5;
+			break;
+		case ACPI_UART_6_DATA_BITS:
+			info->cflag |= CS6;
+			break;
+		case ACPI_UART_7_DATA_BITS:
+			info->cflag |= CS7;
+			break;
+		case ACPI_UART_8_DATA_BITS:
+		default:
+			info->cflag |= CS8;
+			break;
+		}
+
+		/* parity */
+		info->cflag &= ~(PARENB | PARODD);
+		if (sb->parity == ACPI_UART_PARITY_EVEN)
+			info->cflag |= PARENB;
+		else if (sb->parity == ACPI_UART_PARITY_ODD)
+			info->cflag |= (PARENB | PARODD);
+
+		/* stop bits */
+		if (sb->stop_bits == ACPI_UART_2_STOP_BITS)
+			info->cflag |= CSTOPB;
+		else
+			info->cflag &= ~CSTOPB;
+
+		/* HW control */
+		if (sb->flow_control & ACPI_UART_FLOW_CONTROL_HW)
+			info->cflag |= CRTSCTS;
+		else
+			info->cflag &= ~CRTSCTS;
+
+		/* SW control */
+		if (sb->flow_control & ACPI_UART_FLOW_CONTROL_XON_XOFF)
+			info->iflag |= (IXON | IXOFF);
+		else
+			info->iflag &= ~(IXON|IXOFF|IXANY);
+
+		/* endianess */
+		if (sb->endian == ACPI_UART_LITTLE_ENDIAN)
+			info->mctrl |= TIOCM_LE;
+		else
+			info->mctrl &= ~TIOCM_LE;
+
+		/* terminal lines */
+		if (sb->lines_enabled & ACPI_UART_DATA_TERMINAL_READY)
+			info->mctrl |= TIOCM_DTR;
+		else
+			info->mctrl &= ~TIOCM_DTR;
+		if (sb->lines_enabled & ACPI_UART_REQUEST_TO_SEND)
+			info->mctrl |= TIOCM_RTS;
+		else
+			info->mctrl &= ~TIOCM_RTS;
+
+		/* modem lines */
+		if (sb->lines_enabled & ACPI_UART_CLEAR_TO_SEND)
+			info->mctrl |= TIOCM_CTS;
+		else
+			info->mctrl &= ~TIOCM_CTS;
+		if (sb->lines_enabled & ACPI_UART_CARRIER_DETECT)
+			info->mctrl |= TIOCM_CAR;
+		else
+			info->mctrl &= ~TIOCM_CAR;
+		if (sb->lines_enabled & ACPI_UART_RING_INDICATOR)
+			info->mctrl |= TIOCM_RNG;
+		else
+			info->mctrl &= ~TIOCM_RNG;
+		if (sb->lines_enabled & ACPI_UART_DATA_SET_READY)
+			info->mctrl |= TIOCM_DSR;
+		else
+			info->mctrl &= ~TIOCM_DSR;
+	} else if (info->irq < 0) {
+		struct resource r;
+
+		if (acpi_dev_resource_interrupt(ares, 0, &r))
+			info->irq = r.start;
+	}
+
+	return 1;
+}
+
+static acpi_status acpi_uart_add_device(acpi_handle handle, u32 level,
+					void *context, void **return_value)
+{
+	struct tty_port *port = context;
+	struct tty_board_info *board_info;
+	struct acpi_device *adev;
+	struct list_head resource_list;
+	int ret;
+	struct tty_slave *tts;
+	int nr_ids, i;
+	size_t info_size;
+	struct acpi_hardware_id *id;
+	char node_name[5];
+	struct acpi_buffer buffer = { sizeof(node_name), node_name };
+
+	if (acpi_bus_get_device(handle, &adev))
+		return AE_OK;
+	if (acpi_bus_get_status(adev) || !adev->status.present)
+		return AE_OK;
+
+	/* Allocate board info structure. */
+	nr_ids = 0;
+	list_for_each_entry(id, &adev->pnp.ids, list)
+		nr_ids++;
+	info_size = sizeof(struct tty_board_info) + (TTY_NAME_SIZE * nr_ids);
+	board_info = kzalloc(info_size, GFP_KERNEL);
+	if (!board_info)
+		return AE_OK;
+
+	/* Enumerate resources. */
+	board_info->acpi_node.handle = handle;
+	board_info->irq = -1;
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     acpi_uart_add_resources, board_info);
+	acpi_dev_free_resource_list(&resource_list);
+	if (ret < 0 || !board_info->baud)
+		goto fail;
+
+	/* Use ACPI node name as device name. */
+	acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
+	strlcpy(board_info->type, node_name, TTY_NAME_SIZE);
+
+	/* Store PnP IDs. */
+	i = 0;
+	list_for_each_entry(id, &adev->pnp.ids, list) {
+		if (i >= nr_ids)
+			break;
+		strlcpy(board_info->ids[i], id->id, TTY_NAME_SIZE);
+		i++;
+	}
+	board_info->nr_ids = nr_ids;
+
+	tts = tty_bus_register_slave(port, board_info);
+	if (!tts)
+		dev_err(&adev->dev, "failed to add %s UART device from ACPI\n",
+			dev_name(&adev->dev));
+
+fail:
+	kfree(board_info);
+	return AE_OK;
+}
+
+static struct device *acpi_uart_port_parent(struct tty_port *port)
+{
+	return port->dev ? port->dev->parent : NULL;
+}
+
+/**
+ * acpi_uart_register_devices - register the uart slave devices behind the
+ *                              tty port
+ * @port: the host tty port
+ *
+ * Enumerate all tty slave devices behind the host device by walking the
+ * ACPI namespace. When a device is found, it will be added to the Linux
+ * device model and bound to the corresponding ACPI handle.
+ */
+void acpi_uart_register_devices(struct tty_port *port)
+{
+	acpi_handle handle;
+	acpi_status status;
+	struct device *dev;
+
+	dev = acpi_uart_port_parent(port);
+	if (!dev)
+		return;
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+				     acpi_uart_add_device, NULL, port, NULL);
+	if (ACPI_FAILURE(status))
+		dev_warn(dev, "failed to enumerate UART slaves\n");
+}
+EXPORT_SYMBOL_GPL(acpi_uart_register_devices);
diff --git a/drivers/tty/tty_enum.c b/drivers/tty/tty_enum.c
index 2e91cb6..5081dff 100644
--- a/drivers/tty/tty_enum.c
+++ b/drivers/tty/tty_enum.c
@@ -260,6 +260,7 @@ struct tty_slave *tty_bus_register_slave(struct tty_port *port,
 	tts->dev.parent = dev;
 	tts->dev.bus = &tty_enum_bus;
 	tts->dev.type = &tty_slave_type;
+	ACPI_HANDLE_SET(&tts->dev, info->acpi_node.handle);
 
 	tts->dev.platform_data = info->platform_data;
 	if (info->archdata)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 36eb9d1..c32d16c 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -172,6 +172,7 @@ struct tty_board_info;
  * @irq: stored in tty_slave.irq
  * @platform_data: stored in tty_slave.dev.platform_data
  * @archdata: copied into tty_slave.dev.archdata
+ * @acpi_node: ACPI device node
  * @nr_ids: number of IDs
  * @ids: ID strings
  *
@@ -189,6 +190,7 @@ struct tty_board_info {
 	int irq;
 	void *platform_data;
 	struct dev_archdata *archdata;
+	struct acpi_dev_node acpi_node;
 
 	int nr_ids;
 	/* This must be the last member of tty_board_info */
@@ -741,4 +743,10 @@ do {									\
 } while (0)
 
 
+#if IS_ENABLED(CONFIG_ACPI_UART)
+void acpi_uart_register_devices(struct tty_port *port);
+#else
+static inline void acpi_uart_register_devices(struct tty_port *port) {}
+#endif
+
 #endif
-- 
1.7.10

