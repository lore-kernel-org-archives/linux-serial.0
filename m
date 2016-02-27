From: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6] serial: support for 16550A serial ports on LP-8x4x
Date: Sat, 27 Feb 2016 19:14:25 +0300
Message-ID: <1456589675-25377-1-git-send-email-ynvich@gmail.com>
References: <1450213494-21884-1-git-send-email-ynvich@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450213494-21884-1-git-send-email-ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED
	DEVICE TREE" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The patch adds support for 3 additional LP-8x4x built-in serial
ports.

The device can also host up to 8 extension cards with 4 serial ports
on each card for a total of 35 ports. However, I don't have
the hardware to test extension cards, so they are not supported, yet.

Signed-off-by: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
CC: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
CC: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
   v5..v6
   fix review comments by Arnd Bergmann
   * remove wildcards from compatible
   * update doc file
   * drop interrupt parent from doc file
   * replace uart w/ serial in device names in doc file

   fix review comments by Andy Shevchenko
   * exchange labels in switch block
   * replace iowrite8() with writeb()
   * compact comment to one line

   v4..v5
   * constify struct of_device_id
   * drop .owner from struct platform_driver
   * rewrite set_termios() baud rate hadnling as suggested by Alan Cox

   v3..v4
   * move DTS bindings to a different patch (8/21) as suggested by
     Heikki Krogerus

   v2..v3
   * no changes (except number 10/16 -> 12/21)

   v0..v2
   * register platform driver instead of platform device
   * use device tree
   * use devm helpers where possible

 .../bindings/serial/icpdas-lp8841-uart.txt         |  41 +++++
 drivers/tty/serial/8250/8250_lp8841.c              | 166 +++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |  14 ++
 drivers/tty/serial/8250/Makefile                   |   2 +
 4 files changed, 223 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/icpdas-lp8841-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_lp8841.c

diff --git a/Documentation/devicetree/bindings/serial/icpdas-lp8841-uart.txt b/Documentation/devicetree/bindings/serial/icpdas-lp8841-uart.txt
new file mode 100644
index 0000000..d6acd22
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/icpdas-lp8841-uart.txt
@@ -0,0 +1,41 @@
+* UART ports on ICP DAS LP-8841
+
+LP-8441, LP-8141 and LP-8041 are fully compatible.
+
+ICP DAS LP-8841 contains three additional serial ports interfaced via
+Analog Devices ADM213EA chips in addition to 3 serial ports on PXA CPU.
+
+The chips themselves are standard, they would work with 8250_core if
+properly connected. However, they are not connected normally. Al least
+some of their config pins are wired to a different address region. So
+the driver is board-specific.
+
+Required properties:
+- compatible : should be "icpdas,uart-lp8841"
+
+- reg : should provide 16 byte man IO memory region and 1 byte region for
+	termios
+
+- interrupts : should provide interrupt
+
+Optional property:
+- interrupt-parent : should provide a link to interrupt controller either
+		     explicitly or implicitly from a parent node
+
+Examples (from pxa27x-lp8x4x.dts):
+
+		serial@9050 {
+			compatible = "icpdas,uart-lp8841";
+			reg = <0x9050 0x10
+			       0x9030 0x02>;
+			interrupts = <13>;
+			status = "okay";
+		};
+
+		serial@9060 {
+			compatible = "icpdas,uart-lp8841";
+			reg = <0x9060 0x10
+			       0x9032 0x02>;
+			interrupts = <14>;
+			status = "okay";
+		};
diff --git a/drivers/tty/serial/8250/8250_lp8841.c b/drivers/tty/serial/8250/8250_lp8841.c
new file mode 100644
index 0000000..6fef37f
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_lp8841.c
@@ -0,0 +1,166 @@
+/*  linux/drivers/tty/serial/8250/8250_lp8841.c
+ *
+ *  Support for 16550A serial ports on ICP DAS LP-8841
+ *
+ *  Copyright (C) 2013 Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/serial_8250.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+struct lp8841_serial_data {
+	int			line;
+	void			*ios_mem;
+};
+
+static void lp8841_serial_set_termios(struct uart_port *port,
+		struct ktermios *termios, struct ktermios *old)
+{
+	unsigned int len;
+	unsigned int baud;
+	struct lp8841_serial_data *data = port->private_data;
+
+	serial8250_do_set_termios(port, termios, old);
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		len = 7;
+		break;
+	case CS6:
+		len = 8;
+		break;
+	case CS7:
+		len = 9;
+		break;
+	case CS8:
+	default:
+		len = 10;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		len++;
+	if (termios->c_cflag & PARENB)
+		len++;
+	if (!(termios->c_cflag & PARODD))
+		len++;
+#ifdef CMSPAR
+	if (termios->c_cflag & CMSPAR)
+		len++;
+#endif
+
+	len -= 9;
+	len &= 3;
+	len <<= 3;
+
+	/* Ask the core to calculate the divisor for us. */
+	baud = tty_termios_baud_rate(termios);
+
+	switch (baud) {
+	case 115200:
+		len |= 7;
+		break;
+	case 57600:
+		len |= 6;
+		break;
+	case 38400:
+		len |= 5;
+		break;
+	case 19200:
+		len |= 4;
+		break;
+	case 9600:
+		len |= 3;
+		break;
+	case 4800:
+		len |= 2;
+		break;
+	case 2400:
+	default:
+		len |= 1;
+		break;
+	};
+	writeb(len, data->ios_mem);
+
+}
+
+static const struct of_device_id lp8841_serial_dt_ids[] = {
+	{ .compatible = "icpdas,lp8841-uart", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lp8841_serial_dt_ids);
+
+static int lp8841_serial_probe(struct platform_device *pdev)
+{
+	struct uart_8250_port uart = {};
+	struct lp8841_serial_data *data;
+	struct resource *mmres, *mires;
+	int ret;
+
+	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mires = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!mmres || !mires)
+		return -ENODEV;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->ios_mem = devm_ioremap_resource(&pdev->dev, mires);
+	if (!data->ios_mem)
+		return -EFAULT;
+
+	uart.port.iotype = UPIO_MEM;
+	uart.port.mapbase = mmres->start;
+	uart.port.iobase = mmres->start;
+	uart.port.regshift = 1;
+	uart.port.irq = platform_get_irq(pdev, 0);
+	uart.port.flags = UPF_IOREMAP;
+	uart.port.dev = &pdev->dev;
+	uart.port.uartclk = 14745600;
+	uart.port.set_termios = lp8841_serial_set_termios;
+	uart.port.private_data = data;
+
+	ret = serial8250_register_8250_port(&uart);
+	if (ret < 0)
+		return ret;
+
+	data->line = ret;
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int lp8841_serial_remove(struct platform_device *pdev)
+{
+	struct lp8841_serial_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+
+	return 0;
+}
+
+static struct platform_driver lp8841_serial_driver = {
+	.probe          = lp8841_serial_probe,
+	.remove         = lp8841_serial_remove,
+
+	.driver		= {
+		.name	= "uart-lp8841",
+		.of_match_table = lp8841_serial_dt_ids,
+	},
+};
+
+module_platform_driver(lp8841_serial_driver);
+
+MODULE_AUTHOR("Sergei Ianovich");
+MODULE_DESCRIPTION("8250 serial port module for LP-8841");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 3b5cf9c..68640c1 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -394,3 +394,17 @@ config SERIAL_8250_PXA
 	help
 	  If you have a machine based on an Intel XScale PXA2xx CPU you
 	  can enable its onboard serial ports by enabling this option.
+
+	  If you choose M here, the module name will be 8250_pxa.
+
+config SERIAL_8250_LP8841
+	tristate "Support 16550A ports on ICP DAS LP-8841"
+	depends on SERIAL_8250 && MACH_PXA27X_DT
+	select LP8841_IRQ
+	help
+	  In addition to serial ports on PXA270 SoC, LP-8841 has 1 dual
+	  RS232/RS485 port, 1 RS485 port and 1 RS232 port.
+
+	  Say N here, unless you plan to run this kernel on a LP-8841 system.
+
+	  If you choose M here, the module name will be 8250_lp8841.
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index d1e2f2d..10b4bf0 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
 obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
+obj-$(CONFIG_SERIAL_8250_LP8X4X)	+= 8250_lp8x4x.o
 obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
@@ -30,5 +31,6 @@ obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
+obj-$(CONFIG_SERIAL_8250_LP8841)	+= 8250_lp8841.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
