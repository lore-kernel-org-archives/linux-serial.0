From: Sergei Ianovich <ynvich@gmail.com>
Subject: [PATCH v5] serial: rewrite pxa2xx-uart to use 8250_core
Date: Wed, 23 Dec 2015 21:59:57 +0300
Message-ID: <1450897204-6839-1-git-send-email-ynvich@gmail.com>
References: <1449700088-28076-2-git-send-email-ynvich@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449700088-28076-2-git-send-email-ynvich@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sergei Ianovich <ynvich@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, James Cameron <quozl@laptop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Joachim Eastwood <manabian@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Mans Rullgard <mans@mansr.com>, Scott Wood <scottwood@freescale.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, Matthias Brugger <matthias.bgg@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

pxa2xx-uart was a separate uart platform driver. It was declaring
the same device names and numbers as 8250 driver. As a result,
it was impossible to use 8250 driver on PXA SoCs.

Upon closer examination pxa2xx-uart turned out to be a clone of
8250_core driver.

Workaround for Erratum #19 according to Marvel(R) PXA270M Processor
Specification Update (April 19, 2010) is dropped. 8250_core reads
from FIFO immediately after checking DR bit in LSR.

The patch leaves the original SERIAL_PXA driver around. The original
driver is just marked DEPRECATED in Kconfig and C source. When
the original driver is considered safe to remove, no changes
to SERIAL_8250 will be necessary.

Compiling SERIAL_8250_CONSOLE and SERIAL_PXA_CONSOLE even without
SERIAL_8250_PXA breaks console for SERIAL_PXA. For this reasons, the new
and the original drivers are made mutually exclusive.

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: James Cameron <quozl@laptop.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Robert Jarzmik <robert.jarzmik@free.fr>
CC: Russell King <linux@arm.linux.org.uk>

  The patch was reviewed/acked at version 3. Changes in version 4
  are simple unbitrotting. Changes in version 5 require re-review
  according to Robert Jarzmik comment.

  changes v4..v5 as suggested by Robert Jarzmik
  * keep pxa.c until it is considered safe to remove
  * keep SERIAL_PXA and SERIAL_PXA_CONSOLE Kconfig options,
    but deprecate them
  * allow selection of either the new or the original driver
    by Kconfig
  * ensure SERIAL_PXA_CONSOLE is respected with either driver

  changes v3..v4
  * remove owner field from platform_driver structure
  * make of_device_id structure constant
  * use CONFIG_SERIAL_8250_PXA instead of CONFIG_SERIAL_PXA

  changes v2..v3
  * remove devm_free/put as suggested by Heikki Krogerus
  * use SET_SYSTEM_SLEEP_PM_OPS macro to set pm ops as suggested
    by Heikki Krogerus

  changes v1..v2
  * actually implement workaround for E74 in dl_write as spooted
    by James Cameron
  * added comment about E19 in commit message
---
 drivers/tty/serial/8250/8250_pxa.c | 177 +++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |   8 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 drivers/tty/serial/Kconfig         |  17 +++-
 drivers/tty/serial/Makefile        |   2 +-
 drivers/tty/serial/pxa.c           |   4 +-
 6 files changed, 205 insertions(+), 4 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pxa.c

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
new file mode 100644
index 0000000..6a14df0
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -0,0 +1,177 @@
+/*
+ *  drivers/tty/serial/8250/8250_pxa.c -- driver for PXA on-board UARTS
+ *  Copyright:	(C) 2013 Sergei Ianovich <ynvich@gmail.com>
+ *
+ *  replaces drivers/serial/pxa.c by Nicolas Pitre
+ *  Created:	Feb 20, 2003
+ *  Copyright:	(C) 2003 Monta Vista Software, Inc.
+ *
+ *  Based on drivers/serial/8250.c by Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
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
+#include <linux/clk.h>
+#include <linux/pm_runtime.h>
+
+#include "8250.h"
+
+struct pxa8250_data {
+	int			line;
+	struct clk		*clk;
+};
+
+#ifdef CONFIG_PM
+static int serial_pxa_suspend(struct device *dev)
+{
+	struct pxa8250_data *data = dev_get_drvdata(dev);
+
+	serial8250_suspend_port(data->line);
+
+	return 0;
+}
+
+static int serial_pxa_resume(struct device *dev)
+{
+	struct pxa8250_data *data = dev_get_drvdata(dev);
+
+	serial8250_resume_port(data->line);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops serial_pxa_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(serial_pxa_suspend, serial_pxa_resume)
+};
+
+static const struct of_device_id serial_pxa_dt_ids[] = {
+	{ .compatible = "mrvl,pxa-uart", },
+	{ .compatible = "mrvl,mmp-uart", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
+
+/* Uart divisor latch write */
+static void serial_pxa_dl_write(struct uart_8250_port *up, int value)
+{
+	unsigned int dll;
+
+	serial_out(up, UART_DLL, value & 0xff);
+	/*
+	 * work around Erratum #74 according to Marvel(R) PXA270M Processor
+	 * Specification Update (April 19, 2010)
+	 */
+	dll = serial_in(up, UART_DLL);
+	WARN_ON(dll != (value & 0xff));
+
+	serial_out(up, UART_DLM, value >> 8 & 0xff);
+}
+
+
+static void serial_pxa_pm(struct uart_port *port, unsigned int state,
+	      unsigned int oldstate)
+{
+	struct pxa8250_data *data = port->private_data;
+
+	if (!state)
+		clk_prepare_enable(data->clk);
+	else
+		clk_disable_unprepare(data->clk);
+}
+
+static int serial_pxa_probe(struct platform_device *pdev)
+{
+	struct uart_8250_port uart = {};
+	struct pxa8250_data *data;
+	struct resource *mmres, *irqres;
+	int ret;
+
+	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irqres = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!mmres || !irqres)
+		return -ENODEV;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->clk))
+		return PTR_ERR(data->clk);
+
+	ret = clk_prepare(data->clk);
+	if (ret)
+		return ret;
+
+	uart.port.type = PORT_XSCALE;
+	uart.port.iotype = UPIO_MEM32;
+	uart.port.mapbase = mmres->start;
+	uart.port.regshift = 2;
+	uart.port.irq = irqres->start;
+	uart.port.fifosize = 64;
+	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST;
+	uart.port.dev = &pdev->dev;
+	uart.port.uartclk = clk_get_rate(data->clk);
+	uart.port.pm = serial_pxa_pm;
+	uart.port.private_data = data;
+	uart.dl_write = serial_pxa_dl_write;
+
+	ret = serial8250_register_8250_port(&uart);
+	if (ret < 0)
+		goto err_clk;
+
+	data->line = ret;
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+
+ err_clk:
+	clk_unprepare(data->clk);
+	return ret;
+}
+
+static int serial_pxa_remove(struct platform_device *pdev)
+{
+	struct pxa8250_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+
+	clk_unprepare(data->clk);
+
+	return 0;
+}
+
+static struct platform_driver serial_pxa_driver = {
+	.probe          = serial_pxa_probe,
+	.remove         = serial_pxa_remove,
+
+	.driver		= {
+		.name	= "pxa2xx-uart",
+		.pm	= &serial_pxa_pm_ops,
+		.of_match_table = serial_pxa_dt_ids,
+	},
+};
+
+module_platform_driver(serial_pxa_driver);
+
+MODULE_AUTHOR("Sergei Ianovich");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pxa2xx-uart");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 6412f14..4dc45ff 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -378,3 +378,11 @@ config SERIAL_8250_MID
 	  Selecting this option will enable handling of the extra features
 	  present on the UART found on Intel Medfield SOC and various other
 	  Intel platforms.
+
+config SERIAL_8250_PXA
+	tristate "PXA serial port support"
+	depends on SERIAL_8250
+	depends on ARCH_PXA || ARCH_MMP
+	help
+	  If you have a machine based on an Intel XScale PXA2xx CPU you
+	  can enable its onboard serial ports by enabling this option.
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index e177f86..7e54413 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -28,5 +28,6 @@ obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
 obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+= 8250_uniphier.o
 obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
+obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f38beb2..e477ff5 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -436,17 +436,27 @@ config SERIAL_MPSC_CONSOLE
 	  Say Y here if you want to support a serial console on a Marvell MPSC.
 
 config SERIAL_PXA
-	bool "PXA serial port support"
+	bool "PXA serial port support (DEPRECATED)"
 	depends on ARCH_PXA || ARCH_MMP
 	select SERIAL_CORE
+	select SERIAL_8250_PXA if SERIAL_8250
+	select SERIAL_PXA_NON8250 if !SERIAL_8250
 	help
 	  If you have a machine based on an Intel XScale PXA2xx CPU you
 	  can enable its onboard serial ports by enabling this option.
 
+	  Unless you have a specific need, you should use SERIAL_8250_PXA
+	  instead of this.
+
+config SERIAL_PXA_NON8250
+	bool
+	depends on !SERIAL_8250
+
 config SERIAL_PXA_CONSOLE
-	bool "Console on PXA serial port"
+	bool "Console on PXA serial port (DEPRECATED)"
 	depends on SERIAL_PXA
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_8250_CONSOLE if SERIAL_8250
 	help
 	  If you have enabled the serial port on the Intel XScale PXA
 	  CPU you can make it the console by answering Y to this option.
@@ -458,6 +468,9 @@ config SERIAL_PXA_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
+	  Unless you have a specific need, you should use SERIAL_8250_PXA
+	  and SERIAL_8250_CONSOLE instead of this.
+
 config SERIAL_SA1100
 	bool "SA1100 serial port support"
 	depends on ARCH_SA1100
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 5ab4111..96741d5 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_SERIAL_8250) += 8250/
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
-obj-$(CONFIG_SERIAL_PXA) += pxa.o
+obj-$(CONFIG_SERIAL_PXA_NON8250) += pxa.o
 obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
 obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
 obj-$(CONFIG_SERIAL_BCM63XX) += bcm63xx_uart.o
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 9becba6..74aac45 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -940,7 +940,9 @@ static struct platform_driver serial_pxa_driver = {
 	},
 };
 
-static int __init serial_pxa_init(void)
+
+/* 8250 driver for PXA serial ports should be used */
+static int __deprecated __init serial_pxa_init(void)
 {
 	int ret;
 
-- 
2.6.3
