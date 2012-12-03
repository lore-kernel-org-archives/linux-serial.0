From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 3/3] UART: Add dummy devices to test the enumeration.
Date: Mon,  3 Dec 2012 11:40:15 +0800
Message-ID: <5a1174c1b6d140fc7f828361fd3080336656de6c.1354505472.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19699 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530Ab2LCDkk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Dec 2012 22:40:40 -0500
In-Reply-To: <cover.1354505471.git.lv.zheng@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This is a hidden test patch that would not be sent to the public.
There might be some udev add-ons for matching the UART target devices from
the user space.

1. The result of the UART dummy target device is as follows:

# udevadm monitor --kernel --environment > ~/uart.uevents
# echo add > /sys/bus/uart/uevent
# echo add > /sys/bus/uart/devices/DUMMY/uevent
# cat ~/uart.uevents
monitor will print the received events for:
KERNEL - the kernel uevent

KERNEL[252.443458] add      /bus/uart (bus)
ACTION=add
DEVPATH=/bus/uart
SEQNUM=1142
SUBSYSTEM=bus

KERNEL[268.491709] add      /devices/platform/serial8250/DUMMY (uart)
ACTION=add
DEVPATH=/devices/platform/serial8250/DUMMY
DEVTYPE=uart_device
MODALIAS=uart:DUMMY
SEQNUM=1144
SUBSYSTEM=uart

# cat /sys/bus/uart/devices/DUMMY/modalias
uart:DUMMY
# cat /sys/bus/uart/devices/DUMMY/tty_dev
ttyS0
# cat /sys/bus/uart/devices/DUMMY/tty_attrs
115200 8N1 HW SW
# cat /sys/bus/uart/devices/DUMMY/modem_lines
LE:RTS,

2. The result of the UART customized DSDT target device is as follows:

The test result is attached as part of the first patch in this series.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/scan.c                  |    1 +
 drivers/tty/serial/8250/8250.c       |   10 ++-
 drivers/tty/serial/8250/8250_dummy.c |  128 ++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig      |   10 +++
 drivers/tty/serial/8250/Makefile     |    1 +
 drivers/tty/serial/serial_bus.c      |   17 +++++
 include/linux/serial_8250.h          |    2 +
 include/linux/serial_core.h          |    3 +
 8 files changed, 170 insertions(+), 2 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_dummy.c

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 67a7fa6..4892015 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -36,6 +36,7 @@ static const char *dummy_hid = "device";
 static const struct acpi_device_id acpi_platform_device_ids[] = {
 
 	{ "PNP0D40" },
+	{ "INTF000" },
 
 	{ }
 };
diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 3ba4234..6f503f4 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -56,7 +56,7 @@ static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
 
 static unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
 
-static struct uart_driver serial8250_reg;
+struct uart_driver serial8250_reg;
 
 static int serial_index(struct uart_port *port)
 {
@@ -2902,7 +2902,7 @@ int serial8250_find_port(struct uart_port *p)
 #define SERIAL8250_CONSOLE	NULL
 #endif
 
-static struct uart_driver serial8250_reg = {
+struct uart_driver serial8250_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
 	.dev_name		= "ttyS",
@@ -2910,6 +2910,7 @@ static struct uart_driver serial8250_reg = {
 	.minor			= 64,
 	.cons			= SERIAL8250_CONSOLE,
 };
+EXPORT_SYMBOL_GPL(serial8250_reg);
 
 /*
  * early_serial_setup - early registration for 8250 ports
@@ -2987,6 +2988,8 @@ void serial8250_resume_port(int line)
 	uart_resume_port(&serial8250_reg, port);
 }
 
+struct uart_device *uart_dummy;
+
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
@@ -3032,6 +3035,8 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 				p->irq, ret);
 		}
 	}
+	uart_dummy = uart_register_dummy(&serial8250_reg, &dev->dev, 0);
+
 	return 0;
 }
 
@@ -3042,6 +3047,7 @@ static int __devexit serial8250_remove(struct platform_device *dev)
 {
 	int i;
 
+	uart_unregister_device(uart_dummy);
 	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
diff --git a/drivers/tty/serial/8250/8250_dummy.c b/drivers/tty/serial/8250/8250_dummy.c
new file mode 100644
index 0000000..5720fbb
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_dummy.c
@@ -0,0 +1,128 @@
+/*
+ * 8250_dummy.c: Dummy 8250 UART target device enumerator
+ *
+ * Copyright (c) 2012, Intel Corporation
+ * Author: Lv Zheng <lv.zheng@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/acpi.h>
+#include <linux/acpi_uart.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct dummy8250_data {
+	int	last_lcr;
+	int	line;
+};
+
+static void dummy8250_serial_out(struct uart_port *p, int offset, int value)
+{
+}
+
+static unsigned int dummy8250_serial_in(struct uart_port *p, int offset)
+{
+	return 0;
+}
+
+struct klist *dummy8250_mgr;
+int dummy8250_num;
+
+static int __devinit dummy8250_probe(struct platform_device *pdev)
+{
+	struct uart_8250_port uart = {};
+	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct dummy8250_data *data;
+#ifdef CONFIG_ACPI_UART
+	struct klist *mgr;
+#endif
+
+	dev_info(&pdev->dev, "1\n");
+	if (!regs) {
+		dev_err(&pdev->dev, "no registers defined\n");
+		return -EINVAL;
+	}
+
+	dev_info(&pdev->dev, "2\n");
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	uart.port.private_data = data;
+
+	spin_lock_init(&uart.port.lock);
+	uart.port.mapbase = regs->start;
+	uart.port.type = PORT_8250;
+	uart.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP |
+		UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	uart.port.dev = &pdev->dev;
+
+	uart.port.iotype = UPIO_MEM;
+	uart.port.serial_in = dummy8250_serial_in;
+	uart.port.serial_out = dummy8250_serial_out;
+	uart.port.uartclk = 40000000;
+
+	dev_info(&pdev->dev, "3\n");
+	data->line = serial8250_register_8250_port(&uart);
+	if (data->line < 0)
+		return data->line;
+
+#ifdef CONFIG_ACPI_UART
+	dev_info(&pdev->dev, "4\n");
+	mgr = acpi_uart_register_devices(&serial8250_reg, dummy8250_mgr,
+					 &pdev->dev, data->line);
+	if (mgr) {
+		dummy8250_mgr = mgr;
+		dummy8250_num++;
+	}
+#endif
+	dev_info(&pdev->dev, "5\n");
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int __devexit dummy8250_remove(struct platform_device *pdev)
+{
+	struct dummy8250_data *data = platform_get_drvdata(pdev);
+
+#ifdef CONFIG_ACPI_UART
+	dummy8250_num--;
+	if (!dummy8250_num)
+		acpi_uart_unregister_devices(dummy8250_mgr);
+#endif
+	serial8250_unregister_port(data->line);
+
+	return 0;
+}
+
+static const struct acpi_device_id dummy8250_match[] = {
+	{ .id = "INTF000" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, dummy8250_match);
+
+static struct platform_driver dummy8250_platform_driver = {
+	.driver = {
+		.name			= "dummy-uart",
+		.owner			= THIS_MODULE,
+		.acpi_match_table	= dummy8250_match,
+	},
+	.probe				= dummy8250_probe,
+	.remove				= __devexit_p(dummy8250_remove),
+};
+
+module_platform_driver(dummy8250_platform_driver);
+
+MODULE_AUTHOR("Lv Zheng");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Dummy 8250 serial port driver");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f3d283f..3ba480a 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -270,6 +270,16 @@ config SERIAL_8250_DW
 	  Selecting this option will enable handling of the extra features
 	  present in the Synopsys DesignWare APB UART.
 
+config SERIAL_8250_DUMMY
+	tristate "Support for dummy ACPI 8250"
+	depends on SERIAL_8250 && ACPI
+	help
+	  Selecting this option will enable a test UART target device DUMMY
+	  under the ISA serial8250 and a test UART host adapter INTF000
+	  as an platform device for the purpose of testing the ACPI UART
+	  enumeration support.
+	  If unsure, say "N" here.
+
 config SERIAL_8250_EM
 	tristate "Support for Emma Mobile intergrated serial port"
 	depends on SERIAL_8250 && ARM && HAVE_CLK
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 108fe7f..fb82aa9 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
+obj-$(CONFIG_SERIAL_8250_DUMMY)		+= 8250_dummy.o
diff --git a/drivers/tty/serial/serial_bus.c b/drivers/tty/serial/serial_bus.c
index a6674da..e3d0509 100644
--- a/drivers/tty/serial/serial_bus.c
+++ b/drivers/tty/serial/serial_bus.c
@@ -384,6 +384,23 @@ void uart_del_adapter(struct klist *adap)
 }
 EXPORT_SYMBOL_GPL(uart_del_adapter);
 
+static struct uart_board_info dummy_target = {
+	.type = "DUMMY",
+	.baud = 115200,
+	.cflag = CS8 | CSTOPB | CRTSCTS,
+	.iflag = (IXON | IXOFF),
+	.mctrl = TIOCM_LE | TIOCM_RTS,
+};
+
+struct uart_device *uart_register_dummy(struct uart_driver *drv,
+					struct device *dev,
+					unsigned int line)
+{
+	dummy_target.line = line;
+	return uart_register_device(drv, NULL, dev, &dummy_target);
+}
+EXPORT_SYMBOL_GPL(uart_register_dummy);
+
 struct bus_type uart_bus_type = {
 	.name		= "uart",
 };
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index c174c90..3b6c260 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -120,4 +120,6 @@ extern void serial8250_set_isa_configurator(void (*v)
 					(int port, struct uart_port *up,
 						unsigned short *capabilities));
 
+extern struct uart_driver serial8250_reg;
+
 #endif
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 422f8cc4..a3d1d5d 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -418,6 +418,9 @@ struct uart_device *uart_register_device(struct uart_driver *drv,
 					 struct device *dev,
 					 struct uart_board_info const *info);
 void uart_unregister_device(struct uart_device *udev);
+struct uart_device *uart_register_dummy(struct uart_driver *drv,
+					struct device *dev,
+					unsigned int line);
 
 struct device *uart_tty_find(struct uart_driver *drv,
 			     struct device *dev, unsigned int line);
-- 
1.7.10

