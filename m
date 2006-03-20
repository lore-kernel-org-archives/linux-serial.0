From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: ep93xx: uart support (pl010)
Date: Mon, 20 Mar 2006 21:54:31 +0100
Message-ID: <20060320205431.GA5832@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:35050 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1030270AbWCTUyd
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Mar 2006 15:54:33 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

(please CC, not on the list)

Hi!

The cirrus ep93xx is an ARM920T based CPU with three pl010 UARTs.  We
use the amba-pl010.c driver, but that has some integrator-isms which
the attached butt-ugly hack patch (attached only for illustration
purposes) ever so bluntly gets rid of.

What we'd ultimately would like to have would be:
- A place to put our uart_amba_port structures; and
- A hook for setting RTS and DTR.  The ep93xx UARTs have an additional
  'modem control' register (at offset #0x100) of which bit 1 and 0 are
  RTS (inverted) and DTR (inverted), respectively.  (Not implemented in
  the patch below.)

What is the best way to do this?  Just wrap the integrator-specific
bits in CONFIG_MACH_INTEGRATOR or somesuch, or better to move it
somewhere else altogether?


cheers,
Lennert


Index: linux-2.6.16/arch/arm/mach-ep93xx/core.c
===================================================================
--- linux-2.6.16.orig/arch/arm/mach-ep93xx/core.c
+++ linux-2.6.16/arch/arm/mach-ep93xx/core.c
@@ -370,6 +370,45 @@ void __init ep93xx_init_irq(void)
 /*************************************************************************
  * EP93xx peripheral handling
  *************************************************************************/
+static struct amba_device uart1_device = {
+	.dev		= {
+		.bus_id = "apb:uart1",
+	},
+	.res		= {
+		.start	= EP93XX_UART1_PHYS_BASE,
+		.end	= EP93XX_UART1_PHYS_BASE + 0x0fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	.irq		= { IRQ_EP93XX_UART1, NO_IRQ },
+	.periphid	= 0x00041010,
+};
+
+static struct amba_device uart2_device = {
+	.dev		= {
+		.bus_id = "apb:uart2",
+	},
+	.res		= {
+		.start	= EP93XX_UART2_PHYS_BASE,
+		.end	= EP93XX_UART2_PHYS_BASE + 0x0fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	.irq		= { IRQ_EP93XX_UART2, NO_IRQ },
+	.periphid	= 0x00041010,
+};
+
+static struct amba_device uart3_device = {
+	.dev		= {
+		.bus_id = "apb:uart3",
+	},
+	.res		= {
+		.start	= EP93XX_UART3_PHYS_BASE,
+		.end	= EP93XX_UART3_PHYS_BASE + 0x0fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	.irq		= { IRQ_EP93XX_UART3, NO_IRQ },
+	.periphid	= 0x00041010,
+};
+
 void __init ep93xx_init_devices(void)
 {
 	unsigned int v;
@@ -381,4 +420,8 @@ void __init ep93xx_init_devices(void)
 	v &= ~EP93XX_SYSCON_DEVICE_CONFIG_CRUNCH_ENABLE;
 	__raw_writel(0xaa, EP93XX_SYSCON_SWLOCK);
 	__raw_writel(v, EP93XX_SYSCON_DEVICE_CONFIG);
+
+	amba_device_register(&uart1_device, &iomem_resource);
+	amba_device_register(&uart2_device, &iomem_resource);
+	amba_device_register(&uart3_device, &iomem_resource);
 }
Index: linux-2.6.16/drivers/serial/amba-pl010.c
===================================================================
--- linux-2.6.16.orig/drivers/serial/amba-pl010.c
+++ linux-2.6.16/drivers/serial/amba-pl010.c
@@ -54,11 +54,8 @@
 #include <asm/irq.h>
 #include <asm/hardware.h>
 
-#define UART_NR		2
-
 #define SERIAL_AMBA_MAJOR	204
 #define SERIAL_AMBA_MINOR	16
-#define SERIAL_AMBA_NR		UART_NR
 
 #define AMBA_ISR_PASS_LIMIT	256
 
@@ -93,8 +90,8 @@
  *  UART0  7    6
  *  UART1  5    4
  */
-#define SC_CTRLC	(IO_ADDRESS(INTEGRATOR_SC_BASE) + INTEGRATOR_SC_CTRLC_OFFSET)
-#define SC_CTRLS	(IO_ADDRESS(INTEGRATOR_SC_BASE) + INTEGRATOR_SC_CTRLS_OFFSET)
+//#define SC_CTRLC	(IO_ADDRESS(INTEGRATOR_SC_BASE) + INTEGRATOR_SC_CTRLC_OFFSET)
+//#define SC_CTRLS	(IO_ADDRESS(INTEGRATOR_SC_BASE) + INTEGRATOR_SC_CTRLS_OFFSET)
 
 /*
  * We wrap our port structure around the generic uart_port.
@@ -330,8 +327,8 @@ static void pl010_set_mctrl(struct uart_
 	else
 		ctrls |= uap->dtr_mask;
 
-	__raw_writel(ctrls, SC_CTRLS);
-	__raw_writel(ctrlc, SC_CTRLC);
+//	__raw_writel(ctrls, SC_CTRLS);
+//	__raw_writel(ctrlc, SC_CTRLC);
 }
 
 static void pl010_break_ctl(struct uart_port *port, int break_state)
@@ -556,13 +553,13 @@ static struct uart_ops amba_pl010_pops =
 	.verify_port	= pl010_verify_port,
 };
 
-static struct uart_amba_port amba_ports[UART_NR] = {
+static struct uart_amba_port amba_ports[] = {
 	{
 		.port	= {
-			.membase	= (void *)IO_ADDRESS(INTEGRATOR_UART0_BASE),
-			.mapbase	= INTEGRATOR_UART0_BASE,
+			.membase	= (void *)EP93XX_UART1_BASE,
+			.mapbase	= EP93XX_APB_PHYS_BASE + 0x000c0000,
 			.iotype		= UPIO_MEM,
-			.irq		= IRQ_UARTINT0,
+			.irq		= IRQ_EP93XX_UART1,
 			.uartclk	= 14745600,
 			.fifosize	= 16,
 			.ops		= &amba_pl010_pops,
@@ -574,10 +571,10 @@ static struct uart_amba_port amba_ports[
 	},
 	{
 		.port	= {
-			.membase	= (void *)IO_ADDRESS(INTEGRATOR_UART1_BASE),
-			.mapbase	= INTEGRATOR_UART1_BASE,
+			.membase	= (void *)EP93XX_UART2_BASE,
+			.mapbase	= EP93XX_APB_PHYS_BASE + 0x000d0000,
 			.iotype		= UPIO_MEM,
-			.irq		= IRQ_UARTINT1,
+			.irq		= IRQ_EP93XX_UART2,
 			.uartclk	= 14745600,
 			.fifosize	= 16,
 			.ops		= &amba_pl010_pops,
@@ -586,7 +583,22 @@ static struct uart_amba_port amba_ports[
 		},
 		.dtr_mask	= 1 << 7,
 		.rts_mask	= 1 << 6,
-	}
+	},
+	{
+		.port	= {
+			.membase	= (void *)EP93XX_UART3_BASE,
+			.mapbase	= EP93XX_APB_PHYS_BASE + 0x000e0000,
+			.iotype		= UPIO_MEM,
+			.irq		= IRQ_EP93XX_UART3,
+			.uartclk	= 14745600,
+			.fifosize	= 16,
+			.ops		= &amba_pl010_pops,
+			.flags		= UPF_BOOT_AUTOCONF,
+			.line		= 2,
+		},
+		.dtr_mask	= 1 << 3,
+		.rts_mask	= 1 << 2,
+	},
 };
 
 #ifdef CONFIG_SERIAL_AMBA_PL010_CONSOLE
@@ -669,7 +681,7 @@ static int __init pl010_console_setup(st
 	 * if so, search for the first available port that does have
 	 * console support.
 	 */
-	if (co->index >= UART_NR)
+	if (co->index >= ARRAY_SIZE(amba_ports))
 		co->index = 0;
 	port = &amba_ports[co->index].port;
 
@@ -721,7 +733,7 @@ static struct uart_driver amba_reg = {
 	.dev_name		= "ttyAM",
 	.major			= SERIAL_AMBA_MAJOR,
 	.minor			= SERIAL_AMBA_MINOR,
-	.nr			= UART_NR,
+	.nr			= ARRAY_SIZE(amba_ports),
 	.cons			= AMBA_CONSOLE,
 };
 
@@ -729,7 +741,7 @@ static int pl010_probe(struct amba_devic
 {
 	int i;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < ARRAY_SIZE(amba_ports); i++) {
 		if (amba_ports[i].port.mapbase != dev->res.start)
 			continue;
 
