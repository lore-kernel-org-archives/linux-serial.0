From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v9 2/3] serial: exar: split out the exar code from 8250_pci
Date: Sat, 14 Jan 2017 22:50:51 +0000
Message-ID: <1484434252-7663-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1484434252-7663-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1484434252-7663-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, gnomes@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Add the serial driver for the Exar chips. And also register the
platform device for the GPIO provided by the Exar chips.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

Andy,
I hope the grouping and ordering of the header files are ok this time.
One comment has been changed to Kerneldoc description, but as I have never
made a kerneldoc description before so not sure if it is correct.
I have already replied in a separate mail about the problem if we
register gpio before.

 drivers/tty/serial/8250/8250_exar.c | 433 ++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig     |   4 +
 drivers/tty/serial/8250/Makefile    |   1 +
 3 files changed, 438 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_exar.c

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
new file mode 100644
index 0000000..9eb6ded
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -0,0 +1,433 @@
+/*
+ *  Probe module for 8250/16550-type Exar chips PCI serial ports.
+ *
+ *  Based on drivers/tty/serial/8250/8250_pci.c,
+ *
+ *  Copyright (C) 2017 Sudip Mukherjee, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ */
+
+#undef DEBUG
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tty.h>
+#include <linux/8250_pci.h>
+
+#include <asm/byteorder.h>
+
+#include "8250.h"
+
+#define PCI_DEVICE_ID_COMMTECH_4224PCIE	0x0020
+#define PCI_DEVICE_ID_COMMTECH_4228PCIE	0x0021
+#define PCI_DEVICE_ID_COMMTECH_4222PCIE	0x0022
+#define PCI_DEVICE_ID_EXAR_XR17V4358	0x4358
+#define PCI_DEVICE_ID_EXAR_XR17V8358	0x8358
+
+#define UART_EXAR_MPIOINT_7_0	0x8f	/* MPIOINT[7:0] */
+#define UART_EXAR_MPIOLVL_7_0	0x90	/* MPIOLVL[7:0] */
+#define UART_EXAR_MPIO3T_7_0	0x91	/* MPIO3T[7:0] */
+#define UART_EXAR_MPIOINV_7_0	0x92	/* MPIOINV[7:0] */
+#define UART_EXAR_MPIOSEL_7_0	0x93	/* MPIOSEL[7:0] */
+#define UART_EXAR_MPIOOD_7_0	0x94	/* MPIOOD[7:0] */
+#define UART_EXAR_MPIOINT_15_8	0x95	/* MPIOINT[15:8] */
+#define UART_EXAR_MPIOLVL_15_8	0x96	/* MPIOLVL[15:8] */
+#define UART_EXAR_MPIO3T_15_8	0x97	/* MPIO3T[15:8] */
+#define UART_EXAR_MPIOINV_15_8	0x98	/* MPIOINV[15:8] */
+#define UART_EXAR_MPIOSEL_15_8	0x99	/* MPIOSEL[15:8] */
+#define UART_EXAR_MPIOOD_15_8	0x9a	/* MPIOOD[15:8] */
+
+struct exar8250;
+
+/**
+ * @uart_offset the space between channels
+ *
+ * @reg_shift describes how the UART registers are mapped to PCI memory
+ *		by the card.
+ */
+
+struct exar8250_board {
+	unsigned int num_ports;
+	unsigned int base_baud;
+	unsigned int uart_offset;
+	unsigned int reg_shift;
+	bool has_slave;
+	int	(*setup)(struct exar8250 *, struct pci_dev *,
+			 const struct exar8250_board *,
+			 struct uart_8250_port *, int);
+	void	(*exit)(struct pci_dev *pcidev);
+};
+
+struct exar8250 {
+	unsigned int		nr;
+	struct exar8250_board	*board;
+	int			line[0];
+};
+
+static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
+			 const struct exar8250_board *board,
+			 struct uart_8250_port *port, int idx)
+{
+	unsigned int offset, bar = 0;
+
+	if (board->uart_offset)
+		offset = idx * board->uart_offset;
+	else
+		offset = idx * 0x200;
+
+	port->port.iotype = UPIO_MEM;
+	port->port.iobase = 0;
+	port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
+	port->port.membase = pcim_iomap_table(pcidev)[bar] + offset;
+	port->port.regshift = board->reg_shift;
+
+	return 0;
+}
+
+static int
+pci_xr17c154_setup(struct exar8250 *priv, struct pci_dev *pcidev,
+		   const struct exar8250_board *board,
+		   struct uart_8250_port *port, int idx)
+{
+	port->port.flags |= UPF_EXAR_EFR;
+	return default_setup(priv, pcidev, board, port, idx);
+}
+
+static void setup_gpio(u8 __iomem *p)
+{
+	writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
+	writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
+	writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
+	writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
+	writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
+	writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
+	writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
+	writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
+	writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
+	writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
+	writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
+	writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
+}
+
+static void *
+xr17v35x_register_gpio(struct pci_dev *pcidev)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc("gpio_exar", PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return NULL;
+
+	platform_set_drvdata(pdev, pcidev);
+	if (platform_device_add(pdev) < 0) {
+		platform_device_put(pdev);
+		return NULL;
+	}
+
+	return pdev;
+}
+
+static int
+pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
+		   const struct exar8250_board *board,
+		   struct uart_8250_port *port, int idx)
+{
+	u8 __iomem *p;
+	int ret;
+
+	p = pci_ioremap_bar(pcidev, 0);
+	if (!p)
+		return -ENOMEM;
+
+	port->port.flags |= UPF_EXAR_EFR;
+
+	/*
+	 * Setup the uart clock for the devices on expansion slot to
+	 * half the clock speed of the main chip (which is 125MHz)
+	 */
+	if (board->has_slave && idx >= 8)
+		port->port.uartclk = (7812500 * 16 / 2);
+
+	/* Setup Multipurpose Input/Output pins. */
+	if (idx == 0)
+		setup_gpio(p);
+
+	writeb(0x00, p + UART_EXAR_8XMODE);
+	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
+	writeb(128, p + UART_EXAR_TXTRG);
+	writeb(128, p + UART_EXAR_RXTRG);
+	iounmap(p);
+
+	ret = default_setup(priv, pcidev, board, port, idx);
+	if (ret)
+		return ret;
+
+	if (idx == 0)
+		port->port.private_data =
+			xr17v35x_register_gpio(pcidev);
+
+	return 0;
+}
+
+static void pci_xr17v35x_exit(struct pci_dev *pcidev)
+{
+	struct exar8250 *priv = pci_get_drvdata(pcidev);
+	struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
+	struct platform_device *pdev = port->port.private_data;
+
+	if (!pdev)
+		return;
+
+	platform_device_unregister(pdev);
+	port->port.private_data = NULL;
+}
+
+static int
+exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
+{
+	unsigned int nr_ports, i, bar = 0, maxnr;
+	struct exar8250_board *board;
+	struct uart_8250_port uart;
+	struct exar8250 *priv;
+	int rc;
+
+	rc = pcim_enable_device(pcidev);
+	if (rc)
+		return rc;
+
+	board = (struct exar8250_board *)ent->driver_data;
+	if (!board) {
+		board = devm_kzalloc(&pcidev->dev, sizeof(*board),
+				     GFP_KERNEL);
+		board->base_baud = 1843200;
+	}
+
+	maxnr = pci_resource_len(pcidev, bar) >>
+			(board->reg_shift + 3);
+
+	nr_ports = board->num_ports ? board->num_ports :
+					pcidev->device & 0x0f;
+
+	priv = devm_kzalloc(&pcidev->dev, sizeof(*priv) +
+			    sizeof(unsigned int) * nr_ports,
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->board = board;
+
+	memset(&uart, 0, sizeof(uart));
+	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	uart.port.uartclk = board->base_baud * 16;
+	uart.port.irq = pcidev->irq;
+	uart.port.dev = &pcidev->dev;
+
+	for (i = 0; i < nr_ports && i < maxnr; i++) {
+		if (board->setup)
+			rc = board->setup(priv, pcidev, board, &uart, i);
+		else
+			rc = pci_xr17c154_setup(priv, pcidev, board, &uart, i);
+
+		if (rc) {
+			dev_err(&pcidev->dev,
+				"Failed to setup port %u\n", i);
+			break;
+		}
+
+		dev_dbg(&pcidev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
+			uart.port.iobase, uart.port.irq, uart.port.iotype);
+
+		priv->line[i] = serial8250_register_8250_port(&uart);
+		if (priv->line[i] < 0) {
+			dev_err(&pcidev->dev,
+				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
+				uart.port.iobase, uart.port.irq,
+				uart.port.iotype, priv->line[i]);
+			break;
+		}
+	}
+	priv->nr = i;
+	pci_set_drvdata(pcidev, priv);
+	return 0;
+}
+
+static void exar_pci_remove(struct pci_dev *pcidev)
+{
+	struct exar8250 *priv = pci_get_drvdata(pcidev);
+	unsigned int i;
+
+	for (i = 0; i < priv->nr; i++)
+		serial8250_unregister_port(priv->line[i]);
+
+	if (priv->board->exit)
+		priv->board->exit(pcidev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int exar_suspend(struct device *dev)
+{
+	struct pci_dev *pcidev = to_pci_dev(dev);
+	struct exar8250 *priv = pci_get_drvdata(pcidev);
+	unsigned int i;
+
+	for (i = 0; i < priv->nr; i++)
+		if (priv->line[i] >= 0)
+			serial8250_suspend_port(priv->line[i]);
+
+	/* Ensure that every init quirk is properly torn down */
+
+	if (priv->board->exit)
+		priv->board->exit(pcidev);
+
+	return 0;
+}
+
+static int exar_resume(struct device *dev)
+{
+	struct pci_dev *pcidev = to_pci_dev(dev);
+	struct exar8250 *priv = pci_get_drvdata(pcidev);
+	unsigned int i;
+
+	for (i = 0; i < priv->nr; i++)
+		if (priv->line[i] >= 0)
+			serial8250_resume_port(priv->line[i]);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
+
+static const struct exar8250_board pbn_exar_ibm_saturn = {
+	.num_ports	= 1,
+	.base_baud	= 921600,
+};
+
+static const struct exar8250_board pbn_exar_XR17C152 = {
+	.base_baud	= 921600,
+};
+
+static const struct exar8250_board pbn_exar_XR17C154 = {
+	.base_baud	= 921600,
+};
+
+static const struct exar8250_board pbn_exar_XR17C158 = {
+	.base_baud	= 921600,
+};
+
+static const struct exar8250_board pbn_exar_XR17V352 = {
+	.base_baud	= 7812500,
+	.uart_offset	= 0x400,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+static const struct exar8250_board pbn_exar_XR17V354 = {
+	.base_baud	= 7812500,
+	.uart_offset	= 0x400,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+static const struct exar8250_board pbn_exar_XR17V358 = {
+	.base_baud	= 7812500,
+	.uart_offset	= 0x400,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+static const struct exar8250_board pbn_exar_XR17V4358 = {
+	.num_ports	= 12,
+	.base_baud	= 7812500,
+	.uart_offset	= 0x400,
+	.has_slave	= true,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+static const struct exar8250_board pbn_exar_XR17V8358 = {
+	.num_ports	= 16,
+	.base_baud	= 7812500,
+	.uart_offset	= 0x400,
+	.has_slave	= true,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
+#define CONNECT_DEVICE(devid, sdevid) {\
+	PCI_DEVICE_SUB(\
+		PCI_VENDOR_ID_EXAR,\
+		PCI_DEVICE_ID_EXAR_##devid,\
+		PCI_SUBVENDOR_ID_CONNECT_TECH,\
+		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_##sdevid)\
+	}
+
+#define EXAR_DEVICE(vend, devid, bd) {\
+	PCI_VDEVICE(\
+		vend, PCI_DEVICE_ID_##devid), (kernel_ulong_t)&bd \
+	}
+
+static struct pci_device_id exar_pci_tbl[] = {
+	CONNECT_DEVICE(XR17C152, UART_2_232),
+	CONNECT_DEVICE(XR17C154, UART_4_232),
+	CONNECT_DEVICE(XR17C158, UART_8_232),
+	CONNECT_DEVICE(XR17C152, UART_1_1),
+	CONNECT_DEVICE(XR17C154, UART_2_2),
+	CONNECT_DEVICE(XR17C158, UART_4_4),
+	CONNECT_DEVICE(XR17C152, UART_2),
+	CONNECT_DEVICE(XR17C154, UART_4),
+	CONNECT_DEVICE(XR17C158, UART_8),
+	CONNECT_DEVICE(XR17C152, UART_2_485),
+	CONNECT_DEVICE(XR17C154, UART_4_485),
+	CONNECT_DEVICE(XR17C158, UART_8_485),
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
+			       PCI_DEVICE_ID_EXAR_XR17C152,
+			       PCI_VENDOR_ID_IBM,
+			       PCI_SUBDEVICE_ID_IBM_SATURN_SERIAL_ONE_PORT),
+			       0, 0, (kernel_ulong_t)&pbn_exar_ibm_saturn
+	},
+
+	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
+	EXAR_DEVICE(EXAR, EXAR_XR17C152, pbn_exar_XR17C152),
+	EXAR_DEVICE(EXAR, EXAR_XR17C154, pbn_exar_XR17C154),
+	EXAR_DEVICE(EXAR, EXAR_XR17C158, pbn_exar_XR17C158),
+
+	/* Exar Corp. XR17V[48]35[248] Dual/Quad/Octal/Hexa PCIe UARTs */
+	EXAR_DEVICE(EXAR, EXAR_XR17V352, pbn_exar_XR17V352),
+	EXAR_DEVICE(EXAR, EXAR_XR17V354, pbn_exar_XR17V354),
+	EXAR_DEVICE(EXAR, EXAR_XR17V358, pbn_exar_XR17V358),
+	EXAR_DEVICE(EXAR, EXAR_XR17V4358, pbn_exar_XR17V4358),
+	EXAR_DEVICE(EXAR, EXAR_XR17V8358, pbn_exar_XR17V8358),
+	EXAR_DEVICE(COMMTECH, COMMTECH_4222PCIE, pbn_exar_XR17V352),
+	EXAR_DEVICE(COMMTECH, COMMTECH_4224PCIE, pbn_exar_XR17V354),
+	EXAR_DEVICE(COMMTECH, COMMTECH_4228PCIE, pbn_exar_XR17V358),
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
+
+static struct pci_driver exar_pci_driver = {
+	.name		= "exar_serial",
+	.probe		= exar_pci_probe,
+	.remove		= exar_pci_remove,
+	.driver         = {
+		.pm     = &exar_pci_pm,
+	},
+	.id_table	= exar_pci_tbl,
+};
+module_pci_driver(exar_pci_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Exar Serial Dricer");
+MODULE_AUTHOR("Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 0b8b674..9e1f7bf 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -127,6 +127,10 @@ config SERIAL_8250_PCI
 	  Note that serial ports on NetMos 9835 Multi-I/O cards are handled
 	  by the parport_serial driver, enabled with CONFIG_PARPORT_SERIAL.
 
+config SERIAL_8250_EXAR
+        tristate "8250/16550 PCI device support"
+        depends on SERIAL_8250_PCI
+
 config SERIAL_8250_HP300
 	tristate
 	depends on SERIAL_8250 && HP300
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 850e721..2f30f9e 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
 obj-$(CONFIG_SERIAL_8250_GSC)		+= 8250_gsc.o
 obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
+obj-$(CONFIG_SERIAL_8250_EXAR)		+= 8250_exar.o
 obj-$(CONFIG_SERIAL_8250_HP300)		+= 8250_hp300.o
 obj-$(CONFIG_SERIAL_8250_CS)		+= serial_cs.o
 obj-$(CONFIG_SERIAL_8250_ACORN)		+= 8250_acorn.o
-- 
1.9.1

