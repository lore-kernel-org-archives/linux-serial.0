From: Mathieu OTHACEHE <m.othacehe@gmail.com>
Subject: [PATCH v2] tty: serial: 8250: add MOXA Smartio MUE boards support
Date: Sat, 20 Feb 2016 12:00:26 +0100
Message-ID: <1455966026-19245-1-git-send-email-m.othacehe@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, heikki.krogerus@linux.intel.com, hpeter@gmail.com, soeren.grunewald@desy.de, udknight@gmail.com, JBeulich@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu OTHACEHE <m.othacehe@gmail.com>
List-Id: linux-serial@vger.kernel.org

Add support for :

- CP-102E: 2 ports RS232 PCIE card
- CP-102EL: 2 ports RS232 PCIE card
- CP-132EL: 2 ports RS422/485 PCIE card
- CP-114EL: 4 ports RS232/422/485 PCIE card
- CP-104EL-A: 4 ports RS232 PCIE card
- CP-168EL-A: 8 ports RS232 PCIE card
- CP-118EL-A: 8 ports RS232/422/485 PCIE card
- CP-118E-A: 8 ports RS422/485 PCIE card
- CP-138E-A: 8 ports RS422/485 PCIE card
- CP-134EL-A: 4 ports RS422/485 PCIE card
- CP-116E-A (A): 8 ports RS232/422/485 PCIE card
- CP-116E-A (B): 8 ports RS232/422/485 PCIE card

This patch is based on information extracted from
vendor mxupcie driver available on MOXA website.

I was able to test it on a CP-168EL-A on PC.

Signed-off-by: Mathieu OTHACEHE <m.othacehe@gmail.com>
---

Hi,

Here is v2 of the driver, I moved driver code from 8250_pci.c to 8250_moxa.c
as suggested by Andy.

I also fixed other problems pointed out by Jiri and Andy.

Thanks,
Mathieu

Changelog:
V2:
* Move everything to 8250_moxa.c
* Use PCI_DEVICE macro
* Group driver_data by port number as this is the only singularity between boards.

 drivers/tty/serial/8250/8250_moxa.c | 162 ++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig     |  10 +++
 drivers/tty/serial/8250/Makefile    |   1 +
 3 files changed, 173 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_moxa.c

diff --git a/drivers/tty/serial/8250/8250_moxa.c b/drivers/tty/serial/8250/8250_moxa.c
new file mode 100644
index 0000000..c88586b
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_moxa.c
@@ -0,0 +1,162 @@
+/*
+ * 8250_moxa.c - MOXA Smartio/Industio MUE multiport serial driver.
+ *
+ * Author: Mathieu OTHACEHE <m.othacehe@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "8250.h"
+
+#define	PCI_DEVICE_ID_MOXA_CP102E	0x1024
+#define	PCI_DEVICE_ID_MOXA_CP102EL	0x1025
+#define	PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
+#define	PCI_DEVICE_ID_MOXA_CP114EL	0x1144
+#define	PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
+#define	PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161
+#define	PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
+#define	PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
+#define	PCI_DEVICE_ID_MOXA_CP132EL	0x1322
+#define	PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
+#define	PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
+#define	PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
+
+#define MOXA_BASE_BAUD 921600
+#define MOXA_UART_OFFSET 0x200
+
+struct moxa8250_board {
+	unsigned int num_ports;
+	int line[0];
+};
+
+enum {
+	moxa8250_2p = 0,
+	moxa8250_4p,
+	moxa8250_8p
+};
+
+static struct moxa8250_board moxa8250_boards[] = {
+	[moxa8250_2p] = { .num_ports = 2},
+	[moxa8250_4p] = { .num_ports = 4},
+	[moxa8250_8p] = { .num_ports = 8},
+};
+
+static int moxa8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct uart_8250_port uart;
+	struct moxa8250_board *brd;
+	void __iomem *ioaddr;
+	int nr_ports, ret, i, offset;
+
+	brd = &moxa8250_boards[id->driver_data];
+	nr_ports = brd->num_ports;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	brd = devm_kzalloc(&pdev->dev, sizeof(struct moxa8250_board) +
+			   sizeof(unsigned int) * nr_ports, GFP_KERNEL);
+	if (!brd)
+		return -ENOMEM;
+
+	memset(&uart, 0, sizeof(struct uart_8250_port));
+
+	uart.port.dev = &pdev->dev;
+	uart.port.irq = pdev->irq;
+	uart.port.private_data = brd;
+	uart.port.uartclk = MOXA_BASE_BAUD * 16;
+	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+
+	ioaddr = pcim_iomap(pdev, 1, 0);
+
+	for (i = 0; i < nr_ports; i++) {
+
+		/*
+		 * MOXA Smartio MUE boards with 4 ports have
+		 * a different offset for port #3
+		 */
+		if (nr_ports == 4 && i == 3)
+			offset = 7 * MOXA_UART_OFFSET;
+		else
+			offset = i * MOXA_UART_OFFSET;
+
+		uart.port.iotype = UPIO_MEM;
+		uart.port.iobase = 0;
+		uart.port.mapbase = pci_resource_start(pdev, 1) + offset;
+		uart.port.membase = ioaddr + offset;
+		uart.port.regshift = 0;
+
+		dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
+			uart.port.iobase, uart.port.irq, uart.port.iotype);
+
+		brd->line[i] = serial8250_register_8250_port(&uart);
+		if (brd->line[i] < 0) {
+			dev_err(&pdev->dev,
+				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
+				uart.port.iobase, uart.port.irq,
+				uart.port.iotype, brd->line[i]);
+			break;
+		}
+	}
+
+	pci_set_drvdata(pdev, brd);
+	return 0;
+}
+
+static void moxa8250_remove(struct pci_dev *pdev)
+{
+	struct moxa8250_board *brd = pci_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < brd->num_ports; i++)
+		serial8250_unregister_port(brd->line[i]);
+}
+
+static const struct pci_device_id pci_ids[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E),
+	 .driver_data = moxa8250_2p},
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL),
+	 .driver_data = moxa8250_2p},
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A),
+	 .driver_data = moxa8250_4p},
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL),
+	 .driver_data = moxa8250_4p},
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A),
+	 .driver_data = moxa8250_8p},
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B),
+	 .driver_data = moxa8250_8p},
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A),
+	 .driver_data = moxa8250_8p},
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I),
+	 .driver_data = moxa8250_8p},
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL),
+	 .driver_data = moxa8250_2p},
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A),
+	 .driver_data = moxa8250_4p},
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),
+	 .driver_data = moxa8250_8p},
+	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),
+	 .driver_data = moxa8250_8p},
+	{0}
+};
+
+MODULE_DEVICE_TABLE(pci, pci_ids);
+
+static struct pci_driver moxa8250_pci_driver = {
+	.name           = "8250_moxa",
+	.id_table       = pci_ids,
+	.probe          = moxa8250_probe,
+	.remove         = moxa8250_remove,
+};
+
+module_pci_driver(moxa8250_pci_driver);
+
+MODULE_AUTHOR("Mathieu OTHACEHE");
+MODULE_DESCRIPTION("MOXA SmartIO MUE driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 67ad6b0..349f571 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -402,6 +402,16 @@ config SERIAL_8250_MID
 	  present on the UART found on Intel Medfield SOC and various other
 	  Intel platforms.
 
+config SERIAL_8250_MOXA
+	tristate "MOXA SmartIO MUE support"
+	depends on SERIAL_8250 && PCI
+	help
+	  Say Y here if you have a Moxa SmartIO MUE multiport serial card.
+	  If unsure, say N.
+
+	  This driver can also be built as a module. The module will be called
+	  8250_moxa. If you want to do that, say M here.
+
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 5c1869f..c9a2d6e 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
 obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+= 8250_uniphier.o
 obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
+obj-$(CONFIG_SERIAL_8250_MOXA)		+= 8250_moxa.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.7.0
