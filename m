From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v5] HACK: UART: Add dummy devices to test the enumeration
Date: Thu, 24 Jan 2013 18:30:44 +0800
Message-ID: <d1e98f85425191a419576ed3cd890d24a2c5ce73.1359023248.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:39586 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983Ab3AXCa7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Jan 2013 21:30:59 -0500
In-Reply-To: <cover.1354505471.git.lv.zheng@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This is a test patch that should not be merged into any of the published
Linux source tree.
This test is useful on platforms having not ACPI 5.0 UART serial enumerated
devices equipped.

The test is based on the following customized DSDT (containing the dummy
uart host adapter INTF000 and target device INTF001):

1. customized DSDT:
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
          Name (_CID, "PNPF001")  // _CID: Compatible ID
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

2. uevent monitor:
# udevadm monitor --kernel --environment > ~/uart.uevents
# echo add > /sys/class/tty/uevent
# echo add > /sys/class/tty/devices/BTH0:00/uevent
# cat ~/uart.uevents
monitor will print the received events for:
KERNEL - the kernel uevent

KERNEL[252.443458] add      /bus/tty_enum (bus)
ACTION=add
DEVPATH=/bus/tty_enum
SEQNUM=1142
SUBSYSTEM=bus

KERNEL[268.491709] add      /devices/platform/INTF000:00/tty/ttyS0/BTH0:00 (tty)
ACTION=add
DEVPATH=/devices/platform/INTF000:00/tty/ttyS0/BTH0:00
DEVTYPE=tty_slave
MODALIAS=tty::INTF001:PNPF001:
SEQNUM=1144
SUBSYSTEM=tty

3. kobjects attributes and links:
# cat /sys/bus/tty_enum/devices/BTH0:00/modalias
tty::INTF001:PNPF001:
# cat /sys/bus/tty_enum/devices/BTH0:00/tty_attrs
115200 8N0 HW
# cat /sys/bus/tty_enum/devices/BTH0:00/modem_lines
LE:RTS,CTS,

# ls -l /sys/bus/tty_enum/devices/
BTH0:00 -> ../../../devices/platform/INTF000:00/tty/ttyS0/tty/BTH0:00
# ls -l /sys/devices/platform/INTF000:00/tty/ttyS0/BTH0:00/
firmware_node -> ../../../../../LNXSYSTM:00/device:00/INTF000:00/INTF001:00
subsystem -> ../../../../../../bus/tty_enum
# ls -l /sys/bus/acpi/devices/INTF001:00/
physical_node -> ../../../../pnp0/00:00
physical_node1 -> ../../../../platform/INTF000:00/tty/ttyS0/BTH0:00

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/scan.c                  |    1 +
 drivers/tty/serial/8250/8250.c       |    5 +-
 drivers/tty/serial/8250/8250_dummy.c |  103 ++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig      |   10 ++++
 drivers/tty/serial/8250/Makefile     |    1 +
 include/linux/serial_8250.h          |    4 ++
 include/linux/serial_core.h          |   12 ++++
 7 files changed, 133 insertions(+), 3 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_dummy.c

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c88be6c..3a0f259 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -36,6 +36,7 @@ static const char *dummy_hid = "device";
 static const struct acpi_device_id acpi_platform_device_ids[] = {
 
 	{ "PNP0D40" },
+	{ "INTF000" },
 
 	/* Haswell LPSS devices */
 	{ "INT33C0", 0 },
diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index cb7db5a..663e077 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -56,8 +56,6 @@ static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
 
 static unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
 
-static struct uart_driver serial8250_reg;
-
 static int serial_index(struct uart_port *port)
 {
 	return (serial8250_reg.minor - 64) + port->line;
@@ -2938,7 +2936,7 @@ int serial8250_find_port(struct uart_port *p)
 #define SERIAL8250_CONSOLE	NULL
 #endif
 
-static struct uart_driver serial8250_reg = {
+struct uart_driver serial8250_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
 	.dev_name		= "ttyS",
@@ -2946,6 +2944,7 @@ static struct uart_driver serial8250_reg = {
 	.minor			= 64,
 	.cons			= SERIAL8250_CONSOLE,
 };
+EXPORT_SYMBOL_GPL(serial8250_reg);
 
 /*
  * early_serial_setup - early registration for 8250 ports
diff --git a/drivers/tty/serial/8250/8250_dummy.c b/drivers/tty/serial/8250/8250_dummy.c
new file mode 100644
index 0000000..e5aadeb
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_dummy.c
@@ -0,0 +1,103 @@
+/*
+ * 8250_dummy.c: Dummy 8250 UART target device enumerator
+ *
+ * Copyright (c) 2012, Intel Corporation
+ * Author: Lv Zheng <lv.zheng@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/serial_8250.h>
+#include <linux/acpi.h>
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
+static int __devinit dummy8250_probe(struct platform_device *pdev)
+{
+	struct uart_8250_port uart = {};
+	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct dummy8250_data *data;
+
+	if (!regs) {
+		dev_err(&pdev->dev, "no registers defined\n");
+		return -EINVAL;
+	}
+
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
+	data->line = serial8250_register_8250_port(&uart);
+	if (data->line < 0)
+		return data->line;
+
+#ifdef CONFIG_ACPI_UART
+	acpi_uart_register_devices(serial8250_tty_port(data->line));
+#endif
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int __devexit dummy8250_remove(struct platform_device *pdev)
+{
+	struct dummy8250_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
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
index d31f4c6..57ca8a1 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -269,6 +269,16 @@ config SERIAL_8250_DW
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
 	tristate "Support for Emma Mobile integrated serial port"
 	depends on SERIAL_8250 && ARM && HAVE_CLK
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index a23838a..39142aa 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
+obj-$(CONFIG_SERIAL_8250_DUMMY)		+= 8250_dummy.o
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index af47a8a..b61aa6c 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -100,6 +100,10 @@ struct uart_8250_port {
 	void			(*dl_write)(struct uart_8250_port *, int);
 };
 
+extern struct uart_driver serial8250_reg;
+
+#define serial8250_tty_port(line)	uart_tty_port(&serial8250_reg, (line))
+
 int serial8250_register_8250_port(struct uart_8250_port *);
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 82aebc8..e620fc1 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -257,6 +257,18 @@ struct uart_driver {
 	struct tty_driver	*tty_driver;
 };
 
+static inline struct tty_port *uart_tty_port(struct uart_driver *drv,
+					     unsigned int line)
+{
+	struct uart_state *state;
+
+	if (line >= drv->nr)
+		return NULL;
+
+	state = drv->state + line;
+	return &state->port;
+}
+
 void uart_write_wakeup(struct uart_port *port);
 
 /*
-- 
1.7.10

