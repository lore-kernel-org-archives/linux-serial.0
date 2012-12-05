From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 4/4] UART: Add dummy devices to test the enumeration.
Date: Wed,  5 Dec 2012 11:52:05 +0800
Message-ID: <24a196e308709ae0fb2f74eaaa71aef6b2444551.1354677953.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com> <cover.1354677952.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1354677952.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org

This is a test patch that should not be merged to any of the published
Linux source tree.

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
ttyS3
# cat /sys/bus/uart/devices/DUMMY/tty_attrs
115200 8N1 HW SW
# cat /sys/bus/uart/devices/DUMMY/modem_lines
LE:RTS,

# ls -l /sys/bus/uart/devices
DUMMY -> ../../../devices/platform/serial8250/DUMMY
# ls -l /sys/devices/platform/serial8250/DUMMY
subsystem -> ../../../../bus/uart
host_node -> ../tty/ttyS3
# ls -l /sys/devices/platform/serial8250/tty/ttyS3
target_node -> ../../DUMMY

2. The result of the UART customized DSDT target device is as follows:

The test is based on the following customized DSDT (containing the dummy
uart host adapter INTF000 and target device INTF001):
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

# udevadm monitor --kernel --environment > ~/uart.uevents
# echo add > /sys/bus/uart/uevent
# echo add > /sys/bus/uart/devices/INTF001/uevent
# cat ~/uart.uevents
monitor will print the received events for:
KERNEL - the kernel uevent

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

# cat /sys/bus/uart/devices/INTF001:00/modalias
uart:INTF001:00
# cat /sys/bus/uart/devices/INTF001:00/tty_dev
ttyS0
# cat /sys/bus/uart/devices/INTF001:00/tty_attrs
115200 8N0 HW
# cat /sys/bus/uart/devices/INTF001:00/modem_lines
LE:RTS,CTS,

# ls -l /sys/bus/uart/devices
INTF001:00 -> ../../../devices/platform/INTF000:00/INTF001:00
# ls -l /sys/devices/platform/INTF000:00/INTF001:00
subsystem -> ../../../../bus/uart
host_node -> ../tty/ttyS0
# ls -l /sys/devices/platform/INTF000:00/tty/ttyS0
target_node -> ../../INTF001:00

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/scan.c                  |    1 +
 drivers/tty/serial/8250/8250.c       |   12 ++++
 drivers/tty/serial/8250/8250_dummy.c |  129 ++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig      |   10 +++
 drivers/tty/serial/8250/Makefile     |    1 +
 drivers/tty/serial/serial_bus.c      |   17 +++++
 include/linux/serial_bus.h           |    5 ++
 7 files changed, 175 insertions(+)
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
index af78374..745e05d 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -35,6 +35,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
+#include <linux/serial_bus.h>
 #include <linux/nmi.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
@@ -2986,6 +2987,8 @@ void serial8250_resume_port(int line)
 	uart_resume_port(&serial8250_reg, port);
 }
 
+struct uart_device *uart_dummy;
+
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
@@ -2996,6 +2999,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 	struct plat_serial8250_port *p = dev->dev.platform_data;
 	struct uart_8250_port uart;
 	int ret, i, irqflag = 0;
+	unsigned int dummy_line;
 
 	memset(&uart, 0, sizeof(uart));
 
@@ -3031,6 +3035,13 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 				p->irq, ret);
 		}
 	}
+
+	dummy_line = serial8250_ports[nr_uarts-1].port.line;
+	pr_info("registering DUMMY at line %d.\n", dummy_line);
+	uart_dummy = uart_register_dummy(&dev->dev,
+					 serial8250_reg.tty_driver,
+					 dummy_line);
+
 	return 0;
 }
 
@@ -3041,6 +3052,7 @@ static int __devexit serial8250_remove(struct platform_device *dev)
 {
 	int i;
 
+	uart_unregister_device(uart_dummy);
 	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
diff --git a/drivers/tty/serial/8250/8250_dummy.c b/drivers/tty/serial/8250/8250_dummy.c
new file mode 100644
index 0000000..c5ec064
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_dummy.c
@@ -0,0 +1,129 @@
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
+#include <linux/serial_bus.h>
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
+	mgr = acpi_uart_register_devices(dummy8250_mgr,
+					 &pdev->dev,
+					 serial8250_reg.tty_driver,
+					 data->line);
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
index afbb885..d25058a 100644
--- a/drivers/tty/serial/serial_bus.c
+++ b/drivers/tty/serial/serial_bus.c
@@ -387,6 +387,23 @@ void uart_del_adapter(struct klist *adap)
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
+struct uart_device *uart_register_dummy(struct device *dev,
+					struct tty_driver *drv,
+					unsigned int line)
+{
+	dummy_target.line = line;
+	return uart_register_device(NULL, dev, drv, &dummy_target);
+}
+EXPORT_SYMBOL_GPL(uart_register_dummy);
+
 struct bus_type uart_bus_type = {
 	.name		= "uart",
 };
diff --git a/include/linux/serial_bus.h b/include/linux/serial_bus.h
index 6d66fe2..917bbae 100644
--- a/include/linux/serial_bus.h
+++ b/include/linux/serial_bus.h
@@ -72,4 +72,9 @@ struct device *uart_tty_find(struct tty_driver *drv, unsigned int line,
 			     struct device *dev);
 void uart_tty_name(struct tty_driver *driver, unsigned int line, char *p);
 
+/* Test dummy device registration */
+struct uart_device *uart_register_dummy(struct device *dev,
+					struct tty_driver *drv,
+					unsigned int line);
+
 #endif /* LINUX_SERIAL_BUS_H */
-- 
1.7.10

