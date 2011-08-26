From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH] tty: add a DesignWare 8250 driver
Date: Fri, 26 Aug 2011 15:28:45 +0100
Message-ID: <1314368925-13097-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41971 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab1HZO24 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 10:28:56 -0400
Received: by wyg24 with SMTP id 24so2498686wyg.19
        for <linux-serial@vger.kernel.org>; Fri, 26 Aug 2011 07:28:55 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Jamie Iles <jamie@jamieiles.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Arnd Bergmann <arnd@arndb.de>

The Synopsys DesignWare 8250 is an 8250 that has an extra interrupt that
gets raised when writing to the LCR when busy.  To handle this we need
special serial_out, serial_in and handle_irq methods.  Add a new
platform driver that uses these accessors.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---

This is a second attempt at a driver for this UART, and I've learned a
few things about loadable modules and listening to Arnd!  I've tried a
wider variety of build tests and I'm convinced this one is okay.

 .../bindings/tty/serial/snps-dw-apb-uart.txt       |   25 +++
 drivers/tty/serial/8250_dw.c                       |  194 ++++++++++++++++++++
 drivers/tty/serial/Kconfig                         |    7 +
 drivers/tty/serial/Makefile                        |    1 +
 4 files changed, 227 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/snps-dw-apb-uart.txt
 create mode 100644 drivers/tty/serial/8250_dw.c

diff --git a/Documentation/devicetree/bindings/tty/serial/snps-dw-apb-uart.txt b/Documentation/devicetree/bindings/tty/serial/snps-dw-apb-uart.txt
new file mode 100644
index 0000000..f13f1c5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/snps-dw-apb-uart.txt
@@ -0,0 +1,25 @@
+* Synopsys DesignWare ABP UART
+
+Required properties:
+- compatible : "snps,dw-apb-uart"
+- reg : offset and length of the register set for the device.
+- interrupts : should contain uart interrupt.
+- clock-frequency : the input clock frequency for the UART.
+
+Optional properties:
+- reg-shift : quantity to shift the register offsets by.  If this property is
+  not present then the register offsets are not shifted.
+- reg-io-width : the size (in bytes) of the IO accesses that should be
+  performed on the device.  If this property is not present then single byte
+  accesses are used.
+
+Example:
+
+	uart@80230000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x80230000 0x100>;
+		clock-frequency = <3686400>;
+		interrupts = <10>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+	};
diff --git a/drivers/tty/serial/8250_dw.c b/drivers/tty/serial/8250_dw.c
new file mode 100644
index 0000000..bf1fba6
--- /dev/null
+++ b/drivers/tty/serial/8250_dw.c
@@ -0,0 +1,194 @@
+/*
+ * Synopsys DesignWare 8250 driver.
+ *
+ * Copyright 2011 Picochip, Jamie Iles.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * The Synopsys DesignWare 8250 has an extra feature whereby it detects if the
+ * LCR is written whilst busy.  If it is, then a busy detect interrupt is
+ * raised, the LCR needs to be rewritten and the uart status register read.
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct dw8250_data {
+	int	last_lcr;
+	int	line;
+};
+
+static void dw8250_serial_out(struct uart_port *p, int offset, int value)
+{
+	struct dw8250_data *d = p->private_data;
+
+	if (offset == UART_LCR)
+		d->last_lcr = value;
+
+	offset <<= p->regshift;
+	writeb(value, p->membase + offset);
+}
+
+static unsigned int dw8250_serial_in(struct uart_port *p, int offset)
+{
+	offset <<= p->regshift;
+
+	return readb(p->membase + offset);
+}
+
+static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
+{
+	struct dw8250_data *d = p->private_data;
+
+	if (offset == UART_LCR)
+		d->last_lcr = value;
+
+	offset <<= p->regshift;
+	writel(value, p->membase + offset);
+}
+
+static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
+{
+	offset <<= p->regshift;
+
+	return readl(p->membase + offset);
+}
+
+/* Offset for the DesignWare's UART Status Register. */
+#define UART_USR	0x1f
+
+static int dw8250_handle_irq(struct uart_port *p)
+{
+	struct dw8250_data *d = p->private_data;
+	unsigned int iir = p->serial_in(p, UART_IIR);
+
+	if (serial8250_handle_irq(p, iir)) {
+		return 1;
+	} else if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
+		/* Clear the USR and write the LCR again. */
+		(void)p->serial_in(p, UART_USR);
+		p->serial_out(p, d->last_lcr, UART_LCR);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int __devinit dw8250_probe(struct platform_device *pdev)
+{
+	struct uart_port port = {};
+	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	struct device_node *np = pdev->dev.of_node;
+	u32 val;
+	struct dw8250_data *data;
+
+	if (!regs || !irq) {
+		dev_err(&pdev->dev, "no registers/irq defined\n");
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	port.private_data = data;
+
+	spin_lock_init(&port.lock);
+	port.mapbase = regs->start;
+	port.irq = irq->start;
+	port.handle_irq = dw8250_handle_irq;
+	port.type = PORT_8250;
+	port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP |
+		UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	port.dev = &pdev->dev;
+
+	port.iotype = UPIO_MEM;
+	port.serial_in = dw8250_serial_in;
+	port.serial_out = dw8250_serial_out;
+	if (!of_property_read_u32(np, "reg-io-width", &val)) {
+		switch (val) {
+		case 1:
+			break;
+		case 4:
+			port.iotype = UPIO_MEM32;
+			port.serial_in = dw8250_serial_in32;
+			port.serial_out = dw8250_serial_out32;
+			break;
+		default:
+			dev_err(&pdev->dev, "unsupported reg-io-width (%u)\n",
+				val);
+			return -EINVAL;
+		}
+	}
+
+	if (!of_property_read_u32(np, "reg-shift", &val))
+		port.regshift = val;
+
+	if (of_property_read_u32(np, "clock-frequency", &val)) {
+		dev_err(&pdev->dev, "no clock-frequency property set\n");
+		return -EINVAL;
+	}
+	port.uartclk = val;
+
+	data->line = serial8250_register_port(&port);
+	if (data->line < 0)
+		return data->line;
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int __devexit dw8250_remove(struct platform_device *pdev)
+{
+	struct dw8250_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+
+	return 0;
+}
+
+static const struct of_device_id dw8250_match[] = {
+	{ .compatible = "snps,dw-apb-uart" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dw8250_match);
+
+static struct platform_driver dw8250_platform_driver = {
+	.driver = {
+		.name		= "dw-apb-uart",
+		.owner		= THIS_MODULE,
+		.of_match_table	= dw8250_match,
+	},
+	.probe			= dw8250_probe,
+	.remove			= __devexit_p(dw8250_remove),
+};
+
+static int __init dw8250_init(void)
+{
+	return platform_driver_register(&dw8250_platform_driver);
+}
+module_init(dw8250_init);
+
+static void __exit dw8250_exit(void)
+{
+	platform_driver_unregister(&dw8250_platform_driver);
+}
+module_exit(dw8250_exit);
+
+MODULE_AUTHOR("Jamie Iles");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Synopsys DesignWare 8250 serial port driver");
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4dcb37bb..1cdd1cd 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -267,6 +267,13 @@ config SERIAL_8250_RM9K
 	  port hardware found on MIPS RM9122 and similar processors.
 	  If unsure, say N.
 
+config SERIAL_8250_DW
+	tristate "Support for Synopsys DesignWare 8250 quirks"
+	depends on SERIAL_8250 && OF
+	help
+	  Selecting this option will enable handling of the extra features
+	  present in the Synopsys DesignWare APB UART.
+
 comment "Non-8250 serial port support"
 
 config SERIAL_AMBA_PL010
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 83b4da6..06c9808 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_SERIAL_8250_BOCA) += 8250_boca.o
 obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554) += 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_HUB6) += 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_MCA) += 8250_mca.o
+obj-$(CONFIG_SERIAL_8250_DW) += 8250_dw.o
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
-- 
1.7.4.1

