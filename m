From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: ep93xx: uart support (pl010)
Date: Sun, 26 Mar 2006 17:16:16 +0200
Message-ID: <20060326151616.GA5651@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:17029 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1751294AbWCZPQT
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 26 Mar 2006 10:16:19 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Alessandro Zummo <a.zummo@towertech.it>

This patch adds support for the three UARTs in the Cirrus EP93xx
SoC to the amba-pl010 serial driver.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

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
 
@@ -86,6 +83,23 @@
 #define UART_DUMMY_RSR_RX	/*256*/0
 #define UART_PORT_SIZE		64
 
+#ifdef CONFIG_ARCH_EP93XX
+/*
+ * On the EP93xx, RTS and DTR are in the two least significant bits
+ * of the Modem Control Register, which is an EP93xx add-on to the
+ * pl010 UART located at offset 0x100.
+ *
+ * bit 1: RTS (inverted)
+ * bit 0: DTR (inverted)
+ */
+#define UART010_MCR		(0x0100)
+#define UART_PUT_MCR(p,c)	writel((c), (p)->membase + UART010_MCR);
+
+#undef UART_PORT_SIZE
+#define UART_PORT_SIZE		0x1000
+#endif
+
+#ifdef CONFIG_ARCH_INTEGRATOR
 /*
  * On the Integrator platform, the port RTS and DTR are provided by
  * bits in the following SC_CTRLS register bits:
@@ -95,6 +109,7 @@
  */
 #define SC_CTRLC	(IO_ADDRESS(INTEGRATOR_SC_BASE) + INTEGRATOR_SC_CTRLC_OFFSET)
 #define SC_CTRLS	(IO_ADDRESS(INTEGRATOR_SC_BASE) + INTEGRATOR_SC_CTRLS_OFFSET)
+#endif
 
 /*
  * We wrap our port structure around the generic uart_port.
@@ -315,6 +330,22 @@ static unsigned int pl010_get_mctrl(stru
 	return result;
 }
 
+#ifdef CONFIG_ARCH_EP93XX
+static void pl010_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	unsigned int mcr;
+
+	mcr = 0;
+	if (!(mctrl & TIOCM_RTS))
+		mcr |= 2;
+	if (!(mctrl & TIOCM_DTR))
+		mcr |= 1;
+
+	UART_PUT_MCR(port, mcr);
+}
+#endif
+
+#ifdef CONFIG_ARCH_INTEGRATOR
 static void pl010_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
@@ -333,6 +364,7 @@ static void pl010_set_mctrl(struct uart_
 	__raw_writel(ctrls, SC_CTRLS);
 	__raw_writel(ctrlc, SC_CTRLC);
 }
+#endif
 
 static void pl010_break_ctl(struct uart_port *port, int break_state)
 {
@@ -556,7 +588,52 @@ static struct uart_ops amba_pl010_pops =
 	.verify_port	= pl010_verify_port,
 };
 
-static struct uart_amba_port amba_ports[UART_NR] = {
+#ifdef CONFIG_ARCH_EP93XX
+static struct uart_amba_port amba_ports[] = {
+	{
+		.port	= {
+			.membase	= (void *)EP93XX_UART1_BASE,
+			.mapbase	= EP93XX_UART1_PHYS_BASE,
+			.iotype		= UPIO_MEM,
+			.irq		= IRQ_EP93XX_UART1,
+			.uartclk	= 14745600,
+			.fifosize	= 16,
+			.ops		= &amba_pl010_pops,
+			.flags		= UPF_BOOT_AUTOCONF,
+			.line		= 0,
+		},
+	},
+	{
+		.port	= {
+			.membase	= (void *)EP93XX_UART2_BASE,
+			.mapbase	= EP93XX_UART2_PHYS_BASE,
+			.iotype		= UPIO_MEM,
+			.irq		= IRQ_EP93XX_UART2,
+			.uartclk	= 14745600,
+			.fifosize	= 16,
+			.ops		= &amba_pl010_pops,
+			.flags		= UPF_BOOT_AUTOCONF,
+			.line		= 1,
+		},
+	},
+	{
+		.port	= {
+			.membase	= (void *)EP93XX_UART3_BASE,
+			.mapbase	= EP93XX_UART3_PHYS_BASE,
+			.iotype		= UPIO_MEM,
+			.irq		= IRQ_EP93XX_UART3,
+			.uartclk	= 14745600,
+			.fifosize	= 16,
+			.ops		= &amba_pl010_pops,
+			.flags		= UPF_BOOT_AUTOCONF,
+			.line		= 2,
+		},
+	},
+};
+#endif
+
+#ifdef CONFIG_ARCH_INTEGRATOR
+static struct uart_amba_port amba_ports[] = {
 	{
 		.port	= {
 			.membase	= (void *)IO_ADDRESS(INTEGRATOR_UART0_BASE),
@@ -588,6 +665,7 @@ static struct uart_amba_port amba_ports[
 		.rts_mask	= 1 << 6,
 	}
 };
+#endif
 
 #ifdef CONFIG_SERIAL_AMBA_PL010_CONSOLE
 
@@ -669,7 +747,7 @@ static int __init pl010_console_setup(st
 	 * if so, search for the first available port that does have
 	 * console support.
 	 */
-	if (co->index >= UART_NR)
+	if (co->index >= ARRAY_SIZE(amba_ports))
 		co->index = 0;
 	port = &amba_ports[co->index].port;
 
@@ -721,7 +799,7 @@ static struct uart_driver amba_reg = {
 	.dev_name		= "ttyAM",
 	.major			= SERIAL_AMBA_MAJOR,
 	.minor			= SERIAL_AMBA_MINOR,
-	.nr			= UART_NR,
+	.nr			= ARRAY_SIZE(amba_ports),
 	.cons			= AMBA_CONSOLE,
 };
 
@@ -729,7 +807,7 @@ static int pl010_probe(struct amba_devic
 {
 	int i;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < ARRAY_SIZE(amba_ports); i++) {
 		if (amba_ports[i].port.mapbase != dev->res.start)
 			continue;
 
