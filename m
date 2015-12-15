From: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5] serial: support for 16550A serial ports on LP-8x4x
Date: Wed, 16 Dec 2015 00:04:45 +0300
Message-ID: <1450213494-21884-1-git-send-email-ynvich@gmail.com>
References: <1397668667-27328-1-git-send-email-ynvich@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397668667-27328-1-git-send-email-ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The patch adds support for 3 additional LP-8x4x built-in serial
ports.

The device can also host up to 8 extension cards with 4 serial ports
on each card for a total of 35 ports. However, I don't have
the hardware to test extension cards, so they are not supported, yet.

Signed-off-by: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
CC: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
---
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

 .../devicetree/bindings/serial/lp8x4x-serial.txt   |  35 +++++
 drivers/tty/serial/8250/8250_lp8x4x.c              | 168 +++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |  12 ++
 drivers/tty/serial/8250/Makefile                   |   1 +
 4 files changed, 216 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/lp8x4x-serial.txt
 create mode 100644 drivers/tty/serial/8250/8250_lp8x4x.c

diff --git a/Documentation/devicetree/bindings/serial/lp8x4x-serial.txt b/Documentation/devicetree/bindings/serial/lp8x4x-serial.txt
new file mode 100644
index 0000000..5f9a4c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/lp8x4x-serial.txt
@@ -0,0 +1,35 @@
+UART ports on ICP DAS LP-8x4x
+
+ICP DAS LP-8x4x contains three additional serial ports interfaced via
+Analog Devices ADM213EA chips in addition to 3 serial ports on PXA CPU.
+
+Required properties:
+- compatible : should be "icpdas,uart-lp8x4x"
+
+- reg : should provide 16 byte man IO memory region and 1 byte region for
+	termios
+
+- interrupts : should provide interrupt
+
+- interrupt-parent : should provide a link to interrupt controller either
+		     explicitly or implicitly from a parent node
+
+Examples (from pxa27x-lp8x4x.dts):
+
+		uart@9050 {
+			compatible = "icpdas,uart-lp8x4x";
+			reg = <0x9050 0x10
+			       0x9030 0x02>;
+			interrupt-parent = <&fpgairg>;
+			interrupts = <13>;
+			status = "okay";
+		};
+
+		uart@9060 {
+			compatible = "icpdas,uart-lp8x4x";
+			reg = <0x9060 0x10
+			       0x9032 0x02>;
+			interrupt-parent = <&fpgairg>;
+			interrupts = <14>;
+			status = "okay";
+		};
diff --git a/drivers/tty/serial/8250/8250_lp8x4x.c b/drivers/tty/serial/8250/8250_lp8x4x.c
new file mode 100644
index 0000000..0e07220
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_lp8x4x.c
@@ -0,0 +1,168 @@
+/*  linux/drivers/tty/serial/8250/8250_lp8x4x.c
+ *
+ *  Support for 16550A serial ports on ICP DAS LP-8x4x
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
+struct lp8x4x_serial_data {
+	int			line;
+	void			*ios_mem;
+};
+
+static void lp8x4x_serial_set_termios(struct uart_port *port,
+		struct ktermios *termios, struct ktermios *old)
+{
+	unsigned int len;
+	unsigned int baud;
+	struct lp8x4x_serial_data *data = port->private_data;
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
+	default:
+	case CS8:
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
+	/*
+	 * Ask the core to calculate the divisor for us.
+	 */
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
+	iowrite8(len, data->ios_mem);
+
+}
+
+static const struct of_device_id lp8x4x_serial_dt_ids[] = {
+	{ .compatible = "icpdas,uart-lp8x4x", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lp8x4x_serial_dt_ids);
+
+static int lp8x4x_serial_probe(struct platform_device *pdev)
+{
+	struct uart_8250_port uart = {};
+	struct lp8x4x_serial_data *data;
+	struct resource *mmres, *mires, *irqres;
+	int ret;
+
+	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mires = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	irqres = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!mmres || !mires || !irqres)
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
+	uart.port.irq = irqres->start;
+	uart.port.flags = UPF_IOREMAP;
+	uart.port.dev = &pdev->dev;
+	uart.port.uartclk = 14745600;
+	uart.port.set_termios = lp8x4x_serial_set_termios;
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
+static int lp8x4x_serial_remove(struct platform_device *pdev)
+{
+	struct lp8x4x_serial_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+
+	return 0;
+}
+
+static struct platform_driver lp8x4x_serial_driver = {
+	.probe          = lp8x4x_serial_probe,
+	.remove         = lp8x4x_serial_remove,
+
+	.driver		= {
+		.name	= "uart-lp8x4x",
+		.of_match_table = lp8x4x_serial_dt_ids,
+	},
+};
+
+module_platform_driver(lp8x4x_serial_driver);
+
+MODULE_AUTHOR("Sergei Ianovich");
+MODULE_DESCRIPTION("8250 serial port module for LP-8x4x");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 48b6253..00eb6b0 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -387,3 +387,15 @@ config SERIAL_8250_PXA
 	  can enable its onboard serial ports by enabling this option.
 
 	  If you choose M here, the module name will be 8250_pxa.
+
+config SERIAL_8250_LP8X4X
+	tristate "Support 16550A ports on ICP DAS LP-8x4x"
+	depends on OF && SERIAL_8250 && SERIAL_8250_MANY_PORTS && ARCH_PXA
+	select LP8X4X_IRQ
+	help
+	  In addition to serial ports on PXA270 SoC, LP-8x4x has 1 dual
+	  RS232/RS485 port, 1 RS485 port and 1 RS232 port.
+
+	  Say N here, unless you plan to run this kernel on a LP-8x4x system.
+
+	  If you choose M here, the module name will be 8250_lp8x4x.
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 7e54413..8bdbf40 100644
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
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
