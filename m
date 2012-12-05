From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/4] ACPI / UART: Add ACPI enumeration support for UART bus.
Date: Wed,  5 Dec 2012 11:51:51 +0800
Message-ID: <fe1d943a9cec53d90a637ffb38d707a6f6500269.1354677952.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com> <cover.1354677952.git.lv.zheng@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:9003 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176Ab2LEDv5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Dec 2012 22:51:57 -0500
In-Reply-To: <cover.1354677952.git.lv.zheng@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

ACPI 5.0 specification introduces the methods of enumerating the target
devices connected on the serial buses.
This patch follows the specification, implementing such UART enumeration
machanism for the Linux.

In order to use this UART device enumeration mechanism, driver writers
are required to call the following APIs:
1. APIs called _after_ the creation of the uart ports:
   adap = acpi_uart_register_devices(driver, adap, parent, line);
   Where:
    driver: the low level UART driver
    parent: the physical device of the UART ports
    adap: the management list of the target devices, can be set as NULL
    line: the line number of the target device
2. APIs called _before_ the deletion of the uart ports:
   acpi_uart_unregister_devices(adap);
   Where:
    adap: the management list of the UART target devices

NOTE: If the driver writer has already created the management list for
      the UART target devices, the adap parameter can be set to the
      already created non-NULL value.
NOTE: The ACPI 5.0 specification assumes one physical device per-port.
      In this situation, the line parameter might be set to 0 when the
      acpi_uart_register_devices() is called.
      This patch set can also support the multi-port UART adapters,
      where the line should be set as ACPI_UART_LINE_UNKNOWN.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/Kconfig      |    7 ++
 drivers/acpi/Makefile     |    1 +
 drivers/acpi/acpi_uart.c  |  262 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi_uart.h |   40 +++++++
 4 files changed, 310 insertions(+)
 create mode 100644 drivers/acpi/acpi_uart.c
 create mode 100644 include/linux/acpi_uart.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 0300bf6..d40203f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -187,6 +187,12 @@ config ACPI_I2C
 	help
 	  ACPI I2C enumeration support.
 
+config ACPI_UART
+	def_tristate SERIAL_CORE
+	depends on SERIAL_CORE
+	help
+	  ACPI UART enumeration support.
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	select THERMAL
@@ -200,6 +206,7 @@ config ACPI_PROCESSOR
 
 	  To compile this driver as a module, choose M here:
 	  the module will be called processor.
+
 config ACPI_IPMI
 	tristate "IPMI"
 	depends on EXPERIMENTAL && IPMI_SI && IPMI_HANDLER
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
index 0000000..74caf9c
--- /dev/null
+++ b/drivers/acpi/acpi_uart.c
@@ -0,0 +1,262 @@
+/*
+ * acpi_uart.c - ACPI UART enumeration support
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
+#include <linux/init.h>
+#include <linux/serial_bus.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/acpi_uart.h>
+#include <acpi/acpi.h>
+#include <acpi/acpi_bus.h>
+
+
+static int
+acpi_uart_add_resources(struct acpi_resource *ares, void *context)
+{
+	struct uart_board_info *info = context;
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
+struct acpi_uart_walk {
+	struct tty_driver *drv;
+	unsigned int line;
+	struct device *parent;
+};
+
+static acpi_status acpi_uart_add_device(acpi_handle handle, u32 level,
+					void *context, void **return_value)
+{
+	struct acpi_uart_walk *walk = context;
+	struct tty_driver *drv = walk->drv;
+	unsigned int line = walk->line;
+	struct device *parent = walk->parent;
+	struct acpi_device_info *info;
+	struct uart_board_info board_info;
+	struct acpi_device *adev;
+	struct list_head resource_list;
+	int ret;
+	acpi_status status;
+	struct klist *adap = *return_value;
+	struct uart_device *udev;
+
+	BUG_ON(!parent || !adap || !drv);
+
+	/*
+	 * Current BIOS will create physical adapter DEVICE per port.
+	 * This implementation assumes multi-port DEVICE will use _ADR
+	 * as serial port line number though there is no such explicit
+	 * proof for this assumption in the ACPI specification.
+	 *
+	 * NOTE: There is no real BIOS implementation using _ADR as line
+	 *       number.
+	 */
+	if (line == ACPI_UART_LINE_UNKNOWN) {
+		status = acpi_get_object_info(handle, &info);
+		if (ACPI_FAILURE(status))
+			return AE_OK;
+		if (info->valid & ACPI_VALID_ADR)
+			line = info->address;
+	}
+
+	if (line == ACPI_UART_LINE_UNKNOWN)
+		return AE_OK;
+	if (acpi_bus_get_device(handle, &adev))
+		return AE_OK;
+	if (acpi_bus_get_status(adev) || !adev->status.present)
+		return AE_OK;
+
+	memset(&board_info, 0, sizeof(board_info));
+	board_info.irq = -1;
+	board_info.line = line;
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     acpi_uart_add_resources, &board_info);
+	acpi_dev_free_resource_list(&resource_list);
+
+	if (ret < 0 || !board_info.baud)
+		return AE_OK;
+
+	strlcpy(board_info.type, dev_name(&adev->dev), sizeof(board_info.type));
+
+	udev = uart_register_device(adap, parent, drv, &board_info);
+	if (!udev) {
+		dev_err(&adev->dev, "failed to add #%d uart device from ACPI\n",
+			line);
+		return AE_OK;
+	}
+
+	return AE_OK;
+}
+
+/**
+ * acpi_uart_register_devices - register the uart slave devices behind the
+ *                              uart host adapter
+ * @adap: the logical uart host adapter
+ * @dev: the physical uart host adapter
+ * @drv: the tty host driver
+ * @line: the serial line number
+ *
+ * Enumerate all uart slave devices behind the adapter by walking the ACPI
+ * namespace. When a device is found, it will be added to the Linux device
+ * model and bound to the corresponding ACPI handle.
+ * If the physical device is a multiple port device, line should be -1.
+ * If the physical device is a single port device, line should be the line
+ * number.
+ */
+struct klist *acpi_uart_register_devices(struct klist *adap,
+					 struct device *parent,
+					 struct tty_driver *drv,
+					 unsigned int line)
+{
+	acpi_handle handle;
+	acpi_status status;
+	struct klist *klist = NULL;
+	struct acpi_uart_walk walk = {drv, line, parent};
+
+	BUG_ON(!drv || !parent);
+
+	handle = ACPI_HANDLE(parent);
+	if (!handle)
+		return NULL;
+
+	if (!adap) {
+		klist = kzalloc(sizeof(struct klist), GFP_KERNEL);
+		if (!klist)
+			return NULL;
+		(void)uart_add_adapter(klist);
+		adap = klist;
+	}
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+				     acpi_uart_add_device, NULL, &walk,
+				     (void **)&adap);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(parent, "failed to enumerate UART slaves\n");
+		goto fail;
+	}
+
+	return adap;
+
+fail:
+	uart_del_adapter(klist);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(acpi_uart_register_devices);
+
+/**
+ * acpi_uart_register_devices - unregister the uart slave devices behind the
+ *                              uart host adapter
+ * @adap: the logical uart host adapter
+ *
+ * Reverse effect of acpi_uart_register_devices().
+ */
+void acpi_uart_unregister_devices(struct klist *adap)
+{
+	uart_del_adapter(adap);
+	kfree(adap);
+}
+EXPORT_SYMBOL_GPL(acpi_uart_unregister_devices);
diff --git a/include/linux/acpi_uart.h b/include/linux/acpi_uart.h
new file mode 100644
index 0000000..a928425
--- /dev/null
+++ b/include/linux/acpi_uart.h
@@ -0,0 +1,40 @@
+/*
+ * acpi_uart.h - ACPI UART enumeration support
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
+#ifndef _LINUX_ACPI_UART_H
+#define _LINUX_ACPI_UART_H
+
+struct uart_driver;
+
+#define ACPI_UART_LINE_UNKNOWN	((unsigned int)-1)
+
+#if IS_ENABLED(CONFIG_ACPI_UART)
+struct klist *acpi_uart_register_devices(struct klist *adap,
+					 struct device *parent,
+					 struct tty_driver *drv,
+					 unsigned int line);
+void acpi_uart_unregister_devices(struct klist *adap);
+#else
+static inline struct klist *acpi_uart_register_devices(struct klist *adap,
+						       struct device *parent,
+						       struct tty_driver *drv,
+						       unsigned int line)
+{
+	return NULL;
+}
+
+static inline void acpi_uart_unregister_devices(struct klist *adap)
+{
+}
+#endif
+
+#endif /* _LINUX_ACPI_UART_H */
-- 
1.7.10

