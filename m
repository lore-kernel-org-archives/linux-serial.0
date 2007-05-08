From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH][MIPS] separate platform_device registration for VR41xx
 serial interface
Date: Wed, 9 May 2007 00:03:02 +0900
Message-ID: <20070509000302.21879fa9.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ralf,

This patch has separated platform_device registration for VR41xx serial interface.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X siu/Documentation/dontdiff siu-orig/arch/mips/vr41xx/common/Makefile siu/arch/mips/vr41xx/common/Makefile
--- siu-orig/arch/mips/vr41xx/common/Makefile	2007-05-08 16:54:57.796693000 +0900
+++ siu/arch/mips/vr41xx/common/Makefile	2007-05-08 18:39:19.640910500 +0900
@@ -2,4 +2,4 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y	+= bcu.o cmu.o icu.o init.o irq.o pmu.o type.o
+obj-y	+= bcu.o cmu.o icu.o init.o irq.o pmu.o siu.o type.o
diff -pruN -X siu/Documentation/dontdiff siu-orig/arch/mips/vr41xx/common/siu.c siu/arch/mips/vr41xx/common/siu.c
--- siu-orig/arch/mips/vr41xx/common/siu.c	1970-01-01 09:00:00.000000000 +0900
+++ siu/arch/mips/vr41xx/common/siu.c	2007-05-08 23:48:32.000598250 +0900
@@ -0,0 +1,120 @@
+/*
+ *  NEC VR4100 series SIU platform device.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/serial_core.h>
+
+#include <asm/cpu.h>
+#include <asm/vr41xx/siu.h>
+
+static unsigned int siu_type1_ports[SIU_PORTS_MAX] __initdata = {
+	PORT_VR41XX_SIU,
+	PORT_UNKNOWN,
+};
+
+static struct resource siu_type1_resource[] __initdata = {
+	{
+		.start	= 0x0c000000,
+		.end	= 0x0c00000a,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= SIU_IRQ,
+		.end	= SIU_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static unsigned int siu_type2_ports[SIU_PORTS_MAX] __initdata = {
+	PORT_VR41XX_SIU,
+	PORT_VR41XX_DSIU,
+};
+
+static struct resource siu_type2_resource[] __initdata = {
+	{
+		.start	= 0x0f000800,
+		.end	= 0x0f00080a,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= 0x0f000820,
+		.end	= 0x0f000829,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= SIU_IRQ,
+		.end	= SIU_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= DSIU_IRQ,
+		.end	= DSIU_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static int __init vr41xx_siu_add(void)
+{
+	struct platform_device *pdev;
+	struct resource *res;
+	unsigned int num;
+	int retval;
+
+	pdev = platform_device_alloc("SIU", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	switch (current_cpu_data.cputype) {
+	case CPU_VR4111:
+	case CPU_VR4121:
+		pdev->dev.platform_data = siu_type1_ports;
+		res = siu_type1_resource;
+		num = ARRAY_SIZE(siu_type1_resource);
+		break;
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133:
+		pdev->dev.platform_data = siu_type2_ports;
+		res = siu_type2_resource;
+		num = ARRAY_SIZE(siu_type2_resource);
+		break;
+	default:
+		retval = -ENODEV;
+		goto err_free_device;
+	}
+
+	retval = platform_device_add_resources(pdev, res, num);
+	if (retval)
+		goto err_free_device;
+
+	retval = platform_device_add(pdev);
+	if (retval)
+		goto err_free_device;
+
+	return 0;
+
+err_free_device:
+	platform_device_put(pdev);
+
+	return retval;
+}
+device_initcall(vr41xx_siu_add);
diff -pruN -X siu/Documentation/dontdiff siu-orig/drivers/serial/vr41xx_siu.c siu/drivers/serial/vr41xx_siu.c
--- siu-orig/drivers/serial/vr41xx_siu.c	2007-05-08 16:56:25.746189500 +0900
+++ siu/drivers/serial/vr41xx_siu.c	2007-05-08 19:25:01.199921000 +0900
@@ -1,7 +1,7 @@
 /*
  *  Driver for NEC VR4100 series Serial Interface Unit.
  *
- *  Copyright (C) 2004-2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2004-2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  Based on drivers/serial/8250.c, by Russell King.
  *
@@ -25,12 +25,12 @@
 #endif
 
 #include <linux/console.h>
-#include <linux/platform_device.h>
-#include <linux/err.h>
-#include <linux/ioport.h>
+#include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
@@ -38,11 +38,9 @@
 #include <linux/tty_flip.h>
 
 #include <asm/io.h>
-#include <asm/vr41xx/irq.h>
 #include <asm/vr41xx/siu.h>
 #include <asm/vr41xx/vr41xx.h>
 
-#define SIU_PORTS_MAX	2
 #define SIU_BAUD_BASE	1152000
 #define SIU_MAJOR	204
 #define SIU_MINOR_BASE	82
@@ -60,32 +58,13 @@
  #define IRUSESEL	0x02
  #define SIRSEL		0x01
 
-struct siu_port {
-	unsigned int type;
-	unsigned int irq;
-	unsigned long start;
-};
-
-static const struct siu_port siu_type1_ports[] = {
-	{	.type		= PORT_VR41XX_SIU,
-		.irq		= SIU_IRQ,
-		.start		= 0x0c000000UL,		},
-};
-
-#define SIU_TYPE1_NR_PORTS	(sizeof(siu_type1_ports) / sizeof(struct siu_port))
-
-static const struct siu_port siu_type2_ports[] = {
-	{	.type		= PORT_VR41XX_SIU,
-		.irq		= SIU_IRQ,
-		.start		= 0x0f000800UL,		},
-	{	.type		= PORT_VR41XX_DSIU,
-		.irq		= DSIU_IRQ,
-		.start		= 0x0f000820UL,		},
+static struct uart_port siu_uart_ports[SIU_PORTS_MAX] = {
+	[0 ... SIU_PORTS_MAX-1] = {
+		.lock	= __SPIN_LOCK_UNLOCKED(siu_uart_ports->lock),
+		.irq	= -1,
+	},
 };
 
-#define SIU_TYPE2_NR_PORTS	(sizeof(siu_type2_ports) / sizeof(struct siu_port))
-
-static struct uart_port siu_uart_ports[SIU_PORTS_MAX];
 static uint8_t lsr_break_flag[SIU_PORTS_MAX];
 
 #define siu_read(port, offset)		readb((port)->membase + (offset))
@@ -110,7 +89,6 @@ void vr41xx_select_siu_interface(siu_int
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
-
 EXPORT_SYMBOL_GPL(vr41xx_select_siu_interface);
 
 void vr41xx_use_irda(irda_use_t use)
@@ -132,7 +110,6 @@ void vr41xx_use_irda(irda_use_t use)
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
-
 EXPORT_SYMBOL_GPL(vr41xx_use_irda);
 
 void vr41xx_select_irda_module(irda_module_t module, irda_speed_t speed)
@@ -166,7 +143,6 @@ void vr41xx_select_irda_module(irda_modu
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
-
 EXPORT_SYMBOL_GPL(vr41xx_select_irda_module);
 
 static inline void siu_clear_fifo(struct uart_port *port)
@@ -177,21 +153,6 @@ static inline void siu_clear_fifo(struct
 	siu_write(port, UART_FCR, 0);
 }
 
-static inline int siu_probe_ports(void)
-{
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		return SIU_TYPE1_NR_PORTS;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		return SIU_TYPE2_NR_PORTS;
-	}
-
-	return 0;
-}
-
 static inline unsigned long siu_port_size(struct uart_port *port)
 {
 	switch (port->type) {
@@ -206,21 +167,10 @@ static inline unsigned long siu_port_siz
 
 static inline unsigned int siu_check_type(struct uart_port *port)
 {
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		if (port->line == 0)
-			return PORT_VR41XX_SIU;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		if (port->line == 0)
-			return PORT_VR41XX_SIU;
-		else if (port->line == 1)
-			return PORT_VR41XX_DSIU;
-		break;
-	}
+	if (port->line == 0)
+		return PORT_VR41XX_SIU;
+	if (port->line == 1 && port->irq != -1)
+		return PORT_VR41XX_DSIU;
 
 	return PORT_UNKNOWN;
 }
@@ -751,44 +701,34 @@ static struct uart_ops siu_uart_ops = {
 	.verify_port	= siu_verify_port,
 };
 
-static int siu_init_ports(void)
+static int siu_init_ports(struct platform_device *pdev)
 {
-	const struct siu_port *siu;
 	struct uart_port *port;
-	int i, num;
+	struct resource *res;
+	int *type = pdev->dev.platform_data;
+	int i;
 
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		siu = siu_type1_ports;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		siu = siu_type2_ports;
-		break;
-	default:
+	if (!type)
 		return 0;
-	}
 
 	port = siu_uart_ports;
-	num = siu_probe_ports();
-	for (i = 0; i < num; i++) {
-		spin_lock_init(&port->lock);
-		port->irq = siu->irq;
+	for (i = 0; i < SIU_PORTS_MAX; i++) {
+		port->type = type[i];
+		if (port->type == PORT_UNKNOWN)
+			continue;
+		port->irq = platform_get_irq(pdev, i);
 		port->uartclk = SIU_BAUD_BASE * 16;
 		port->fifosize = 16;
 		port->regshift = 0;
 		port->iotype = UPIO_MEM;
 		port->flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
-		port->type = siu->type;
 		port->line = i;
-		port->mapbase = siu->start;
-		siu++;
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		port->mapbase = res->start;
 		port++;
 	}
 
-	return num;
+	return i;
 }
 
 #ifdef CONFIG_SERIAL_VR41XX_CONSOLE
@@ -883,13 +823,9 @@ static struct console siu_console = {
 static int __devinit siu_console_init(void)
 {
 	struct uart_port *port;
-	int num, i;
-
-	num = siu_init_ports();
-	if (num <= 0)
-		return -ENODEV;
+	int i;
 
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < SIU_PORTS_MAX; i++) {
 		port = &siu_uart_ports[i];
 		port->ops = &siu_uart_ops;
 	}
@@ -920,7 +856,7 @@ static int __devinit siu_probe(struct pl
 	struct uart_port *port;
 	int num, i, retval;
 
-	num = siu_init_ports();
+	num = siu_init_ports(dev);
 	if (num <= 0)
 		return -ENODEV;
 
@@ -998,8 +934,6 @@ static int siu_resume(struct platform_de
 	return 0;
 }
 
-static struct platform_device *siu_platform_device;
-
 static struct platform_driver siu_device_driver = {
 	.probe		= siu_probe,
 	.remove		= __devexit_p(siu_remove),
@@ -1013,29 +947,12 @@ static struct platform_driver siu_device
 
 static int __init vr41xx_siu_init(void)
 {
-	int retval;
-
-	siu_platform_device = platform_device_alloc("SIU", -1);
-	if (!siu_platform_device)
-		return -ENOMEM;
-
-	retval = platform_device_add(siu_platform_device);
-	if (retval < 0) {
-		platform_device_put(siu_platform_device);
-		return retval;
-	}
-
-	retval = platform_driver_register(&siu_device_driver);
-	if (retval < 0)
-		platform_device_unregister(siu_platform_device);
-
-	return retval;
+	return platform_driver_register(&siu_device_driver);
 }
 
 static void __exit vr41xx_siu_exit(void)
 {
 	platform_driver_unregister(&siu_device_driver);
-	platform_device_unregister(siu_platform_device);
 }
 
 module_init(vr41xx_siu_init);
diff -pruN -X siu/Documentation/dontdiff siu-orig/include/asm-mips/vr41xx/siu.h siu/include/asm-mips/vr41xx/siu.h
--- siu-orig/include/asm-mips/vr41xx/siu.h	2007-05-08 16:57:23.021769000 +0900
+++ siu/include/asm-mips/vr41xx/siu.h	2007-05-08 16:54:45.507925000 +0900
@@ -20,6 +20,8 @@
 #ifndef __NEC_VR41XX_SIU_H
 #define __NEC_VR41XX_SIU_H
 
+#define SIU_PORTS_MAX 2
+
 typedef enum {
 	SIU_INTERFACE_RS232C,
 	SIU_INTERFACE_IRDA,
