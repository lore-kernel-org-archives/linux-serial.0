From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v2 8/9] serial: samsung: merge probe() function from all SoC
 specific extensions
Date: Mon, 10 Oct 2011 15:38:04 +0530
Message-ID: <1318241285-23568-9-git-send-email-thomas.abraham@linaro.org>
References: <1318241285-23568-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45063 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab1JJKHX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Oct 2011 06:07:23 -0400
In-reply-to: <1318241285-23568-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org

With reset port, set clock and get clock functions in SoC specific extentions
being removed, only the driver probe is left over in these extensions. The
probe function itself can be merged into one and moved into the samsung common
serial driver. With driver probe also moved, all the SoC specific extentions
are no longer required and they are deleted.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/plat-samsung/include/plat/regs-serial.h |   12 +
 drivers/tty/serial/Kconfig                       |   45 +---
 drivers/tty/serial/Makefile                      |    5 -
 drivers/tty/serial/s3c2410.c                     |   74 -----
 drivers/tty/serial/s3c2412.c                     |   78 -----
 drivers/tty/serial/s3c2440.c                     |   77 -----
 drivers/tty/serial/s3c6400.c                     |   79 -----
 drivers/tty/serial/s5pv210.c                     |   94 ------
 drivers/tty/serial/samsung.c                     |  360 +++++++++++++++-------
 drivers/tty/serial/samsung.h                     |   18 +-
 10 files changed, 265 insertions(+), 577 deletions(-)
 delete mode 100644 drivers/tty/serial/s3c2410.c
 delete mode 100644 drivers/tty/serial/s3c2412.c
 delete mode 100644 drivers/tty/serial/s3c2440.c
 delete mode 100644 drivers/tty/serial/s3c6400.c
 delete mode 100644 drivers/tty/serial/s5pv210.c

diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index 133fa97..29c26a8 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -232,6 +232,18 @@
 #define S3C2410_UCON_CLKSEL2	(1 << 2)
 #define S3C2410_UCON_CLKSEL3	(1 << 3)
 
+/* Default values for s5pv210 UCON and UFCON uart registers */
+#define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+				 S3C2410_UCON_RXILEVEL |	\
+				 S3C2410_UCON_TXIRQMODE |	\
+				 S3C2410_UCON_RXIRQMODE |	\
+				 S3C2410_UCON_RXFIFO_TOI |	\
+				 S3C2443_UCON_RXERR_IRQEN)
+
+#define S5PV210_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+				 S5PV210_UFCON_TXTRIG4 |	\
+				 S5PV210_UFCON_RXTRIG4)
+
 #ifndef __ASSEMBLY__
 
 /* configuration structure for per-machine configurations for the
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4dcb37b..6c6c90d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -450,7 +450,7 @@ config SERIAL_SAMSUNG
 config SERIAL_SAMSUNG_UARTS_4
 	bool
 	depends on ARM && PLAT_SAMSUNG
-	default y if CPU_S3C2443
+	default y if !(CPU_S3C2410 || SERIAL_S3C2412 || CPU_S3C2440 || CPU_S3C2442)
 	help
 	  Internal node for the common case of 4 Samsung compatible UARTs
 
@@ -458,7 +458,7 @@ config SERIAL_SAMSUNG_UARTS
 	int
 	depends on ARM && PLAT_SAMSUNG
 	default 6 if ARCH_S5P6450
-	default 4 if SERIAL_SAMSUNG_UARTS_4
+	default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
 	default 3
 	help
 	  Select the number of available UART ports for the Samsung S3C
@@ -488,47 +488,6 @@ config SERIAL_SAMSUNG_CONSOLE
 	  your boot loader about how to pass options to the kernel at
 	  boot time.)
 
-config SERIAL_S3C2410
-	tristate "Samsung S3C2410 Serial port support"
-	depends on SERIAL_SAMSUNG && CPU_S3C2410
-	default y if CPU_S3C2410
-	help
-	  Serial port support for the Samsung S3C2410 SoC
-
-config SERIAL_S3C2412
-	tristate "Samsung S3C2412/S3C2413 Serial port support"
-	depends on SERIAL_SAMSUNG && CPU_S3C2412
-	default y if CPU_S3C2412
-	help
-	  Serial port support for the Samsung S3C2412 and S3C2413 SoC
-
-config SERIAL_S3C2440
-	tristate "Samsung S3C2440/S3C2442/S3C2416 Serial port support"
-	depends on SERIAL_SAMSUNG && (CPU_S3C2440 || CPU_S3C2442 || CPU_S3C2416)
-	default y if CPU_S3C2440
-	default y if CPU_S3C2442
-	select SERIAL_SAMSUNG_UARTS_4 if CPU_S3C2416
-	help
-	  Serial port support for the Samsung S3C2440, S3C2416 and S3C2442 SoC
-
-config SERIAL_S3C6400
-	tristate "Samsung S3C6400/S3C6410/S5P6440/S5P6450/S5PC100 Serial port support"
-	depends on SERIAL_SAMSUNG && (CPU_S3C6400 || CPU_S3C6410 || CPU_S5P6440 || CPU_S5P6450 || CPU_S5PC100)
-	select SERIAL_SAMSUNG_UARTS_4
-	default y
-	help
-	  Serial port support for the Samsung S3C6400, S3C6410, S5P6440, S5P6450
-	  and S5PC100 SoCs
-
-config SERIAL_S5PV210
-	tristate "Samsung S5PV210 Serial port support"
-	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_EXYNOS4210)
-	select SERIAL_SAMSUNG_UARTS_4 if (CPU_S5PV210 || CPU_EXYNOS4210)
-	default y
-	help
-	  Serial port support for Samsung's S5P Family of SoC's
-
-
 config SERIAL_MAX3100
 	tristate "MAX3100 support"
 	depends on SPI
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 83b4da6..afa6f7b 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -38,11 +38,6 @@ obj-$(CONFIG_SERIAL_BCM63XX) += bcm63xx_uart.o
 obj-$(CONFIG_SERIAL_BFIN) += bfin_5xx.o
 obj-$(CONFIG_SERIAL_BFIN_SPORT) += bfin_sport_uart.o
 obj-$(CONFIG_SERIAL_SAMSUNG) += samsung.o
-obj-$(CONFIG_SERIAL_S3C2410) += s3c2410.o
-obj-$(CONFIG_SERIAL_S3C2412) += s3c2412.o
-obj-$(CONFIG_SERIAL_S3C2440) += s3c2440.o
-obj-$(CONFIG_SERIAL_S3C6400) += s3c6400.o
-obj-$(CONFIG_SERIAL_S5PV210) += s5pv210.o
 obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
 obj-$(CONFIG_SERIAL_MAX3107) += max3107.o
 obj-$(CONFIG_SERIAL_MAX3107_AAVA) += max3107-aava.o
diff --git a/drivers/tty/serial/s3c2410.c b/drivers/tty/serial/s3c2410.c
deleted file mode 100644
index 1491c32..0000000
--- a/drivers/tty/serial/s3c2410.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Driver for Samsung S3C2410 SoC onboard UARTs.
- *
- * Ben Dooks, Copyright (c) 2003-2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
-
-#include <asm/irq.h>
-#include <mach/hardware.h>
-
-#include <plat/regs-serial.h>
-#include <mach/regs-gpio.h>
-
-#include "samsung.h"
-
-static struct s3c24xx_uart_info s3c2410_uart_inf = {
-	.name		= "Samsung S3C2410 UART",
-	.type		= PORT_S3C2410,
-	.fifosize	= 16,
-	.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
-	.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
-	.rx_fifofull	= S3C2410_UFSTAT_RXFULL,
-	.tx_fifofull	= S3C2410_UFSTAT_TXFULL,
-	.tx_fifomask	= S3C2410_UFSTAT_TXMASK,
-	.tx_fifoshift	= S3C2410_UFSTAT_TXSHIFT,
-	.def_clk_sel	= S3C2410_UCON_CLKSEL0,
-	.num_clks	= 2,
-	.clksel_mask	= S3C2410_UCON_CLKMASK,
-	.clksel_shift	= S3C2410_UCON_CLKSHIFT,
-};
-
-static int s3c2410_serial_probe(struct platform_device *dev)
-{
-	return s3c24xx_serial_probe(dev, &s3c2410_uart_inf);
-}
-
-static struct platform_driver s3c2410_serial_driver = {
-	.probe		= s3c2410_serial_probe,
-	.remove		= __devexit_p(s3c24xx_serial_remove),
-	.driver		= {
-		.name	= "s3c2410-uart",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init s3c2410_serial_init(void)
-{
-	return s3c24xx_serial_init(&s3c2410_serial_driver, &s3c2410_uart_inf);
-}
-
-static void __exit s3c2410_serial_exit(void)
-{
-	platform_driver_unregister(&s3c2410_serial_driver);
-}
-
-module_init(s3c2410_serial_init);
-module_exit(s3c2410_serial_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("Samsung S3C2410 SoC Serial port driver");
-MODULE_ALIAS("platform:s3c2410-uart");
diff --git a/drivers/tty/serial/s3c2412.c b/drivers/tty/serial/s3c2412.c
deleted file mode 100644
index 38ae730..0000000
--- a/drivers/tty/serial/s3c2412.c
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * Driver for Samsung S3C2412 and S3C2413 SoC onboard UARTs.
- *
- * Ben Dooks, Copyright (c) 2003-2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
-
-#include <asm/irq.h>
-#include <mach/hardware.h>
-
-#include <plat/regs-serial.h>
-#include <mach/regs-gpio.h>
-
-#include "samsung.h"
-
-static struct s3c24xx_uart_info s3c2412_uart_inf = {
-	.name		= "Samsung S3C2412 UART",
-	.type		= PORT_S3C2412,
-	.fifosize	= 64,
-	.has_divslot	= 1,
-	.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
-	.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
-	.rx_fifofull	= S3C2440_UFSTAT_RXFULL,
-	.tx_fifofull	= S3C2440_UFSTAT_TXFULL,
-	.tx_fifomask	= S3C2440_UFSTAT_TXMASK,
-	.tx_fifoshift	= S3C2440_UFSTAT_TXSHIFT,
-	.def_clk_sel	= S3C2410_UCON_CLKSEL2,
-	.num_clks	= 4,
-	.clksel_mask	= S3C2412_UCON_CLKMASK,
-	.clksel_shift	= S3C2412_UCON_CLKSHIFT,
-};
-
-/* device management */
-
-static int s3c2412_serial_probe(struct platform_device *dev)
-{
-	dbg("s3c2440_serial_probe: dev=%p\n", dev);
-	return s3c24xx_serial_probe(dev, &s3c2412_uart_inf);
-}
-
-static struct platform_driver s3c2412_serial_driver = {
-	.probe		= s3c2412_serial_probe,
-	.remove		= __devexit_p(s3c24xx_serial_remove),
-	.driver		= {
-		.name	= "s3c2412-uart",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static inline int s3c2412_serial_init(void)
-{
-	return s3c24xx_serial_init(&s3c2412_serial_driver, &s3c2412_uart_inf);
-}
-
-static inline void s3c2412_serial_exit(void)
-{
-	platform_driver_unregister(&s3c2412_serial_driver);
-}
-
-module_init(s3c2412_serial_init);
-module_exit(s3c2412_serial_exit);
-
-MODULE_DESCRIPTION("Samsung S3C2412,S3C2413 SoC Serial port driver");
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:s3c2412-uart");
diff --git a/drivers/tty/serial/s3c2440.c b/drivers/tty/serial/s3c2440.c
deleted file mode 100644
index 70652f5..0000000
--- a/drivers/tty/serial/s3c2440.c
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * Driver for Samsung S3C2440 and S3C2442 SoC onboard UARTs.
- *
- * Ben Dooks, Copyright (c) 2003-2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
-
-#include <asm/irq.h>
-#include <mach/hardware.h>
-
-#include <plat/regs-serial.h>
-#include <mach/regs-gpio.h>
-
-#include "samsung.h"
-
-static struct s3c24xx_uart_info s3c2440_uart_inf = {
-	.name		= "Samsung S3C2440 UART",
-	.type		= PORT_S3C2440,
-	.fifosize	= 64,
-	.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
-	.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
-	.rx_fifofull	= S3C2440_UFSTAT_RXFULL,
-	.tx_fifofull	= S3C2440_UFSTAT_TXFULL,
-	.tx_fifomask	= S3C2440_UFSTAT_TXMASK,
-	.tx_fifoshift	= S3C2440_UFSTAT_TXSHIFT,
-	.def_clk_sel	= S3C2410_UCON_CLKSEL2,
-	.num_clks	= 4,
-	.clksel_mask	= S3C2440_UCON_CLKMASK,
-	.clksel_shift	= S3C2440_UCON_CLKSHIFT,
-};
-
-/* device management */
-
-static int s3c2440_serial_probe(struct platform_device *dev)
-{
-	dbg("s3c2440_serial_probe: dev=%p\n", dev);
-	return s3c24xx_serial_probe(dev, &s3c2440_uart_inf);
-}
-
-static struct platform_driver s3c2440_serial_driver = {
-	.probe		= s3c2440_serial_probe,
-	.remove		= __devexit_p(s3c24xx_serial_remove),
-	.driver		= {
-		.name	= "s3c2440-uart",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init s3c2440_serial_init(void)
-{
-	return s3c24xx_serial_init(&s3c2440_serial_driver, &s3c2440_uart_inf);
-}
-
-static void __exit s3c2440_serial_exit(void)
-{
-	platform_driver_unregister(&s3c2440_serial_driver);
-}
-
-module_init(s3c2440_serial_init);
-module_exit(s3c2440_serial_exit);
-
-MODULE_DESCRIPTION("Samsung S3C2440,S3C2442 SoC Serial port driver");
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:s3c2440-uart");
diff --git a/drivers/tty/serial/s3c6400.c b/drivers/tty/serial/s3c6400.c
deleted file mode 100644
index 30a69f1..0000000
--- a/drivers/tty/serial/s3c6400.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * Driver for Samsung S3C6400 and S3C6410 SoC onboard UARTs.
- *
- * Copyright 2008 Openmoko,  Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
-
-#include <asm/irq.h>
-#include <mach/hardware.h>
-
-#include <plat/regs-serial.h>
-
-#include "samsung.h"
-
-static struct s3c24xx_uart_info s3c6400_uart_inf = {
-	.name		= "Samsung S3C6400 UART",
-	.type		= PORT_S3C6400,
-	.fifosize	= 64,
-	.has_divslot	= 1,
-	.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
-	.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
-	.rx_fifofull	= S3C2440_UFSTAT_RXFULL,
-	.tx_fifofull	= S3C2440_UFSTAT_TXFULL,
-	.tx_fifomask	= S3C2440_UFSTAT_TXMASK,
-	.tx_fifoshift	= S3C2440_UFSTAT_TXSHIFT,
-	.def_clk_sel	= S3C2410_UCON_CLKSEL2,
-	.num_clks	= 4,
-	.clksel_mask	= S3C6400_UCON_CLKMASK,
-	.clksel_shift	= S3C6400_UCON_CLKSHIFT,
-};
-
-/* device management */
-
-static int s3c6400_serial_probe(struct platform_device *dev)
-{
-	dbg("s3c6400_serial_probe: dev=%p\n", dev);
-	return s3c24xx_serial_probe(dev, &s3c6400_uart_inf);
-}
-
-static struct platform_driver s3c6400_serial_driver = {
-	.probe		= s3c6400_serial_probe,
-	.remove		= __devexit_p(s3c24xx_serial_remove),
-	.driver		= {
-		.name	= "s3c6400-uart",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init s3c6400_serial_init(void)
-{
-	return s3c24xx_serial_init(&s3c6400_serial_driver, &s3c6400_uart_inf);
-}
-
-static void __exit s3c6400_serial_exit(void)
-{
-	platform_driver_unregister(&s3c6400_serial_driver);
-}
-
-module_init(s3c6400_serial_init);
-module_exit(s3c6400_serial_exit);
-
-MODULE_DESCRIPTION("Samsung S3C6400,S3C6410 SoC Serial port driver");
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:s3c6400-uart");
diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
deleted file mode 100644
index d232094..0000000
--- a/drivers/tty/serial/s5pv210.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Based on drivers/serial/s3c6400.c
- *
- * Driver for Samsung S5PV210 SoC UARTs.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
-#include <linux/delay.h>
-
-#include <asm/irq.h>
-#include <mach/hardware.h>
-#include <plat/regs-serial.h>
-#include "samsung.h"
-
-#define S5PV210_UART_DEFAULT_INFO(fifo_size)			\
-		.name		= "Samsung S5PV210 UART0",	\
-		.type		= PORT_S3C6400,			\
-		.fifosize	= fifo_size,			\
-		.has_divslot	= 1,				\
-		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
-		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
-		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,	\
-		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,	\
-		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,	\
-		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,	\
-		.def_clk_sel	= S3C2410_UCON_CLKSEL0,		\
-		.num_clks	= 2,				\
-		.clksel_mask	= S5PV210_UCON_CLKMASK,		\
-		.clksel_shift	= S5PV210_UCON_CLKSHIFT
-
-static struct s3c24xx_uart_info s5p_port_fifo256 = {
-	S5PV210_UART_DEFAULT_INFO(256),
-};
-
-static struct s3c24xx_uart_info s5p_port_fifo64 = {
-	S5PV210_UART_DEFAULT_INFO(64),
-};
-
-static struct s3c24xx_uart_info s5p_port_fifo16 = {
-	S5PV210_UART_DEFAULT_INFO(16),
-};
-
-static struct s3c24xx_uart_info *s5p_uart_inf[] = {
-	[0] = &s5p_port_fifo256,
-	[1] = &s5p_port_fifo64,
-	[2] = &s5p_port_fifo16,
-	[3] = &s5p_port_fifo16,
-};
-
-/* device management */
-static int s5p_serial_probe(struct platform_device *pdev)
-{
-	return s3c24xx_serial_probe(pdev, s5p_uart_inf[pdev->id]);
-}
-
-static struct platform_driver s5p_serial_driver = {
-	.probe		= s5p_serial_probe,
-	.remove		= __devexit_p(s3c24xx_serial_remove),
-	.driver		= {
-		.name	= "s5pv210-uart",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init s5p_serial_init(void)
-{
-	return s3c24xx_serial_init(&s5p_serial_driver, *s5p_uart_inf);
-}
-
-static void __exit s5p_serial_exit(void)
-{
-	platform_driver_unregister(&s5p_serial_driver);
-}
-
-module_init(s5p_serial_init);
-module_exit(s5p_serial_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:s5pv210-uart");
-MODULE_DESCRIPTION("Samsung S5PV210 UART Driver support");
-MODULE_AUTHOR("Thomas Abraham <thomas.ab@samsung.com>");
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 78aea1a..c89987b 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -206,7 +206,7 @@ static int s3c24xx_serial_rx_fifocnt(struct s3c24xx_uart_port *ourport,
 	struct s3c24xx_uart_info *info = ourport->info;
 
 	if (ufstat & info->rx_fifofull)
-		return info->fifosize;
+		return ourport->port.fifosize;
 
 	return (ufstat & info->rx_fifomask) >> info->rx_fifoshift;
 }
@@ -1079,11 +1079,10 @@ static inline void s3c24xx_serial_cpufreq_deregister(struct s3c24xx_uart_port *p
  */
 
 static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
-				    struct s3c24xx_uart_info *info,
 				    struct platform_device *platdev)
 {
 	struct uart_port *port = &ourport->port;
-	struct s3c2410_uartcfg *cfg = platdev->dev.platform_data;
+	struct s3c2410_uartcfg *cfg = ourport->cfg;
 	struct resource *res;
 	int ret;
 
@@ -1095,32 +1094,13 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	if (port->mapbase != 0)
 		return 0;
 
-	/*
-	 * If platform data is supplied, keep a copy of the location of
-	 * platform data in the driver's private data.
-	 */
-	if (cfg)
-		ourport->cfg = cfg;
-
-	if (cfg->hwport > CONFIG_SERIAL_SAMSUNG_UARTS) {
-		printk(KERN_ERR "%s: port %d bigger than %d\n", __func__,
-		       cfg->hwport, CONFIG_SERIAL_SAMSUNG_UARTS);
-		return -ERANGE;
-	}
-
 	/* setup info for port */
 	port->dev	= &platdev->dev;
-	ourport->info	= info;
 
 	/* Startup sequence is different for s3c64xx and higher SoC's */
 	if (s3c24xx_serial_has_interrupt_mask(port))
 		s3c24xx_serial_ops.startup = s3c64xx_serial_startup;
 
-	/* copy the info in from provided structure */
-	ourport->port.fifosize = info->fifosize;
-
-	dbg("s3c24xx_serial_init_port: %p (hw %d)...\n", port, cfg->hwport);
-
 	port->uartclk = 1;
 
 	if (cfg->uart_flags & UPF_CONS_FLOW) {
@@ -1187,34 +1167,46 @@ static DEVICE_ATTR(clock_source, S_IRUGO, s3c24xx_serial_show_clksrc, NULL);
 
 static int probe_index;
 
-int s3c24xx_serial_probe(struct platform_device *dev,
-			 struct s3c24xx_uart_info *info)
+static int s3c24xx_serial_probe(struct platform_device *pdev)
 {
 	struct s3c24xx_uart_port *ourport;
 	int ret;
 
-	dbg("s3c24xx_serial_probe(%p, %p) %d\n", dev, info, probe_index);
+	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, probe_index);
 
 	ourport = &s3c24xx_serial_ports[probe_index];
+
+	ourport->drv_data = (struct s3c24xx_serial_drv_data *)
+			platform_get_device_id(pdev)->driver_data;
+
+	ourport->info = ourport->drv_data->info;
+	ourport->cfg = (pdev->dev.platform_data) ?
+			(struct s3c2410_uartcfg *)pdev->dev.platform_data :
+			ourport->drv_data->def_cfg;
+
+	ourport->port.fifosize = (ourport->info->fifosize) ?
+		ourport->info->fifosize :
+		ourport->drv_data->fifosize[probe_index];
+
 	probe_index++;
 
 	dbg("%s: initialising port %p...\n", __func__, ourport);
 
-	ret = s3c24xx_serial_init_port(ourport, info, dev);
+	ret = s3c24xx_serial_init_port(ourport, pdev);
 	if (ret < 0)
 		goto probe_err;
 
 	dbg("%s: adding port\n", __func__);
 	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
-	platform_set_drvdata(dev, &ourport->port);
+	platform_set_drvdata(pdev, &ourport->port);
 
-	ret = device_create_file(&dev->dev, &dev_attr_clock_source);
+	ret = device_create_file(&pdev->dev, &dev_attr_clock_source);
 	if (ret < 0)
-		printk(KERN_ERR "%s: failed to add clksrc attr.\n", __func__);
+		dev_err(&pdev->dev, "failed to add clock source attr.\n");
 
 	ret = s3c24xx_serial_cpufreq_register(ourport);
 	if (ret < 0)
-		dev_err(&dev->dev, "failed to add cpufreq notifier\n");
+		dev_err(&pdev->dev, "failed to add cpufreq notifier\n");
 
 	return 0;
 
@@ -1222,9 +1214,7 @@ int s3c24xx_serial_probe(struct platform_device *dev,
 	return ret;
 }
 
-EXPORT_SYMBOL_GPL(s3c24xx_serial_probe);
-
-int __devexit s3c24xx_serial_remove(struct platform_device *dev)
+static int __devexit s3c24xx_serial_remove(struct platform_device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
 
@@ -1237,8 +1227,6 @@ int __devexit s3c24xx_serial_remove(struct platform_device *dev)
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(s3c24xx_serial_remove);
-
 /* UART power management code */
 #ifdef CONFIG_PM_SLEEP
 static int s3c24xx_serial_suspend(struct device *dev)
@@ -1278,41 +1266,6 @@ static const struct dev_pm_ops s3c24xx_serial_pm_ops = {
 #define SERIAL_SAMSUNG_PM_OPS	NULL
 #endif /* CONFIG_PM_SLEEP */
 
-int s3c24xx_serial_init(struct platform_driver *drv,
-			struct s3c24xx_uart_info *info)
-{
-	dbg("s3c24xx_serial_init(%p,%p)\n", drv, info);
-
-	drv->driver.pm = SERIAL_SAMSUNG_PM_OPS;
-
-	return platform_driver_register(drv);
-}
-
-EXPORT_SYMBOL_GPL(s3c24xx_serial_init);
-
-/* module initialisation code */
-
-static int __init s3c24xx_serial_modinit(void)
-{
-	int ret;
-
-	ret = uart_register_driver(&s3c24xx_uart_drv);
-	if (ret < 0) {
-		printk(KERN_ERR "failed to register UART driver\n");
-		return -1;
-	}
-
-	return 0;
-}
-
-static void __exit s3c24xx_serial_modexit(void)
-{
-	uart_unregister_driver(&s3c24xx_uart_drv);
-}
-
-module_init(s3c24xx_serial_modinit);
-module_exit(s3c24xx_serial_modexit);
-
 /* Console code */
 
 #ifdef CONFIG_SERIAL_SAMSUNG_CONSOLE
@@ -1418,36 +1371,12 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 		else
 			rate = 1;
 
-
 		*baud = rate / (16 * (ubrdiv + 1));
 		dbg("calculated baud %d\n", *baud);
 	}
 
 }
 
-/* s3c24xx_serial_init_ports
- *
- * initialise the serial ports from the machine provided initialisation
- * data.
-*/
-
-static int s3c24xx_serial_init_ports(struct s3c24xx_uart_info **info)
-{
-	struct s3c24xx_uart_port *ptr = s3c24xx_serial_ports;
-	struct platform_device **platdev_ptr;
-	int i;
-
-	dbg("s3c24xx_serial_init_ports: initialising ports...\n");
-
-	platdev_ptr = s3c24xx_uart_devs;
-
-	for (i = 0; i < CONFIG_SERIAL_SAMSUNG_UARTS; i++, ptr++, platdev_ptr++) {
-		s3c24xx_serial_init_port(ptr, info[i], *platdev_ptr);
-	}
-
-	return 0;
-}
-
 static int __init
 s3c24xx_serial_console_setup(struct console *co, char *options)
 {
@@ -1491,11 +1420,6 @@ s3c24xx_serial_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-/* s3c24xx_serial_initconsole
- *
- * initialise the console from one of the uart drivers
-*/
-
 static struct console s3c24xx_serial_console = {
 	.name		= S3C24XX_SERIAL_NAME,
 	.device		= uart_console_device,
@@ -1505,34 +1429,238 @@ static struct console s3c24xx_serial_console = {
 	.setup		= s3c24xx_serial_console_setup,
 	.data		= &s3c24xx_uart_drv,
 };
+#endif /* CONFIG_SERIAL_SAMSUNG_CONSOLE */
+
+#ifdef CONFIG_CPU_S3C2410
+static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
+	.info = &(struct s3c24xx_uart_info) {
+		.name		= "Samsung S3C2410 UART",
+		.type		= PORT_S3C2410,
+		.fifosize	= 16,
+		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
+		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S3C2410_UFSTAT_RXFULL,
+		.tx_fifofull	= S3C2410_UFSTAT_TXFULL,
+		.tx_fifomask	= S3C2410_UFSTAT_TXMASK,
+		.tx_fifoshift	= S3C2410_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
+		.num_clks	= 2,
+		.clksel_mask	= S3C2410_UCON_CLKMASK,
+		.clksel_shift	= S3C2410_UCON_CLKSHIFT,
+	},
+	.def_cfg = &(struct s3c2410_uartcfg) {
+		.ucon		= S3C2410_UCON_DEFAULT,
+		.ufcon		= S3C2410_UFCON_DEFAULT,
+	},
+};
+#define S3C2410_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2410_serial_drv_data)
+#else
+#define S3C2410_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#endif
 
-int s3c24xx_serial_initconsole(struct platform_driver *drv,
-			       struct s3c24xx_uart_info **info)
+#ifdef CONFIG_CPU_S3C2412
+static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
+	.info = &(struct s3c24xx_uart_info) {
+		.name		= "Samsung S3C2412 UART",
+		.type		= PORT_S3C2412,
+		.fifosize	= 64,
+		.has_divslot	= 1,
+		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
+		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S3C2440_UFSTAT_RXFULL,
+		.tx_fifofull	= S3C2440_UFSTAT_TXFULL,
+		.tx_fifomask	= S3C2440_UFSTAT_TXMASK,
+		.tx_fifoshift	= S3C2440_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL2,
+		.num_clks	= 4,
+		.clksel_mask	= S3C2412_UCON_CLKMASK,
+		.clksel_shift	= S3C2412_UCON_CLKSHIFT,
+	},
+	.def_cfg = &(struct s3c2410_uartcfg) {
+		.ucon		= S3C2410_UCON_DEFAULT,
+		.ufcon		= S3C2410_UFCON_DEFAULT,
+	},
+};
+#define S3C2412_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2412_serial_drv_data)
+#else
+#define S3C2412_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#endif
 
-{
-	struct platform_device *dev = s3c24xx_uart_devs[0];
+#if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2416) || \
+	defined(CONFIG_CPU_S3C2443)
+static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
+	.info = &(struct s3c24xx_uart_info) {
+		.name		= "Samsung S3C2440 UART",
+		.type		= PORT_S3C2440,
+		.fifosize	= 64,
+		.has_divslot	= 1,
+		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
+		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S3C2440_UFSTAT_RXFULL,
+		.tx_fifofull	= S3C2440_UFSTAT_TXFULL,
+		.tx_fifomask	= S3C2440_UFSTAT_TXMASK,
+		.tx_fifoshift	= S3C2440_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL2,
+		.num_clks	= 4,
+		.clksel_mask	= S3C2412_UCON_CLKMASK,
+		.clksel_shift	= S3C2412_UCON_CLKSHIFT,
+	},
+	.def_cfg = &(struct s3c2410_uartcfg) {
+		.ucon		= S3C2410_UCON_DEFAULT,
+		.ufcon		= S3C2410_UFCON_DEFAULT,
+	},
+};
+#define S3C2440_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2440_serial_drv_data)
+#else
+#define S3C2440_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#endif
 
-	dbg("s3c24xx_serial_initconsole\n");
+#if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410) || \
+	defined(CONFIG_CPU_S5P6440) || defined(CONFIG_CPU_S5P6450) || \
+	defined(CONFIG_CPU_S5PC100)
+static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
+	.info = &(struct s3c24xx_uart_info) {
+		.name		= "Samsung S3C6400 UART",
+		.type		= PORT_S3C6400,
+		.fifosize	= 64,
+		.has_divslot	= 1,
+		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
+		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S3C2440_UFSTAT_RXFULL,
+		.tx_fifofull	= S3C2440_UFSTAT_TXFULL,
+		.tx_fifomask	= S3C2440_UFSTAT_TXMASK,
+		.tx_fifoshift	= S3C2440_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL2,
+		.num_clks	= 4,
+		.clksel_mask	= S3C6400_UCON_CLKMASK,
+		.clksel_shift	= S3C6400_UCON_CLKSHIFT,
+	},
+	.def_cfg = &(struct s3c2410_uartcfg) {
+		.ucon		= S3C2410_UCON_DEFAULT,
+		.ufcon		= S3C2410_UFCON_DEFAULT,
+	},
+};
+#define S3C6400_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c6400_serial_drv_data)
+#else
+#define S3C6400_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#endif
 
-	/* select driver based on the cpu */
+#ifdef CONFIG_CPU_S5PV210
+static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
+	.info = &(struct s3c24xx_uart_info) {
+		.name		= "Samsung S5PV210 UART",
+		.type		= PORT_S3C6400,
+		.has_divslot	= 1,
+		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
+		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
+		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,
+		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,
+		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
+		.num_clks	= 2,
+		.clksel_mask	= S5PV210_UCON_CLKMASK,
+		.clksel_shift	= S5PV210_UCON_CLKSHIFT,
+	},
+	.def_cfg = &(struct s3c2410_uartcfg) {
+		.ucon		= S5PV210_UCON_DEFAULT,
+		.ufcon		= S5PV210_UFCON_DEFAULT,
+	},
+	.fifosize = { 256, 64, 16, 16 },
+};
+#define S5PV210_SERIAL_DRV_DATA ((kernel_ulong_t)&s5pv210_serial_drv_data)
+#else
+#define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
+#endif
 
-	if (dev == NULL) {
-		printk(KERN_ERR "s3c24xx: no devices for console init\n");
-		return 0;
-	}
+#ifdef CONFIG_CPU_EXYNOS4210
+static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
+	.info = &(struct s3c24xx_uart_info) {
+		.name		= "Samsung Exynos4 UART",
+		.type		= PORT_S3C6400,
+		.has_divslot	= 1,
+		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
+		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
+		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,
+		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,
+		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
+		.num_clks	= 1,
+		.clksel_mask	= 0,
+		.clksel_shift	= 0,
+	},
+	.def_cfg = &(struct s3c2410_uartcfg) {
+		.ucon		= S5PV210_UCON_DEFAULT,
+		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.has_fracval	= 1,
+	},
+	.fifosize = { 256, 64, 16, 16 },
+};
+#define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos4210_serial_drv_data)
+#else
+#define EXYNOS4210_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#endif
 
-	if (strcmp(dev->name, drv->driver.name) != 0)
-		return 0;
+static struct platform_device_id s3c24xx_serial_driver_ids[] = {
+	{
+		.name		= "s3c2410-uart",
+		.driver_data	= S3C2410_SERIAL_DRV_DATA,
+	}, {
+		.name		= "s3c2412-uart",
+		.driver_data	= S3C2412_SERIAL_DRV_DATA,
+	}, {
+		.name		= "s3c2440-uart",
+		.driver_data	= S3C2440_SERIAL_DRV_DATA,
+	}, {
+		.name		= "s3c6400-uart",
+		.driver_data	= S3C6400_SERIAL_DRV_DATA,
+	}, {
+		.name		= "s5pv210-uart",
+		.driver_data	= S5PV210_SERIAL_DRV_DATA,
+	}, {
+		.name		= "exynos4210-uart",
+		.driver_data	= EXYNOS4210_SERIAL_DRV_DATA,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, s3c24xx_serial_driver_ids);
+
+static struct platform_driver samsung_serial_driver = {
+	.probe		= s3c24xx_serial_probe,
+	.remove		= __devexit_p(s3c24xx_serial_remove),
+	.id_table	= s3c24xx_serial_driver_ids,
+	.driver		= {
+		.name	= "samsung-uart",
+		.owner	= THIS_MODULE,
+		.pm	= SERIAL_SAMSUNG_PM_OPS,
+	},
+};
 
-	s3c24xx_serial_console.data = &s3c24xx_uart_drv;
-	s3c24xx_serial_init_ports(info);
+/* module initialisation code */
 
-	register_console(&s3c24xx_serial_console);
-	return 0;
+static int __init s3c24xx_serial_modinit(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&s3c24xx_uart_drv);
+	if (ret < 0) {
+		printk(KERN_ERR "failed to register UART driver\n");
+		return -1;
+	}
+
+	return platform_driver_register(&samsung_serial_driver);
 }
 
-#endif /* CONFIG_SERIAL_SAMSUNG_CONSOLE */
+static void __exit s3c24xx_serial_modexit(void)
+{
+	uart_unregister_driver(&s3c24xx_uart_drv);
+}
+
+module_init(s3c24xx_serial_modinit);
+module_exit(s3c24xx_serial_modexit);
 
+MODULE_ALIAS("platform:samsung-uart");
 MODULE_DESCRIPTION("Samsung SoC Serial port driver");
 MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index c9cab2c..1a4bca3 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -32,6 +32,12 @@ struct s3c24xx_uart_info {
 	int (*reset_port)(struct uart_port *, struct s3c2410_uartcfg *);
 };
 
+struct s3c24xx_serial_drv_data {
+	struct s3c24xx_uart_info	*info;
+	struct s3c2410_uartcfg		*def_cfg;
+	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
+};
+
 struct s3c24xx_uart_port {
 	unsigned char			rx_claimed;
 	unsigned char			tx_claimed;
@@ -45,6 +51,7 @@ struct s3c24xx_uart_port {
 	struct clk			*clk;
 	struct clk			*baudclk;
 	struct uart_port		port;
+	struct s3c24xx_serial_drv_data	*drv_data;
 
 	/* reference to platform data */
 	struct s3c2410_uartcfg		*cfg;
@@ -69,17 +76,6 @@ struct s3c24xx_uart_port {
 #define wr_regb(port, reg, val) __raw_writeb(val, portaddr(port, reg))
 #define wr_regl(port, reg, val) __raw_writel(val, portaddr(port, reg))
 
-extern int s3c24xx_serial_probe(struct platform_device *dev,
-				struct s3c24xx_uart_info *uart);
-
-extern int __devexit s3c24xx_serial_remove(struct platform_device *dev);
-
-extern int s3c24xx_serial_initconsole(struct platform_driver *drv,
-				      struct s3c24xx_uart_info **uart);
-
-extern int s3c24xx_serial_init(struct platform_driver *drv,
-			       struct s3c24xx_uart_info *info);
-
 #ifdef CONFIG_SERIAL_SAMSUNG_DEBUG
 
 extern void printascii(const char *);
-- 
1.6.6.rc2

