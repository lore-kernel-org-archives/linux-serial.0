From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] serial: bfin_5xx: move resources into board files
Date: Wed, 27 Oct 2010 04:18:47 -0400
Message-ID: <1288167527-31648-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53209 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389Ab0J0ISi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Oct 2010 04:18:38 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Rather than maintain Kconfig entries where people have to enter raw
numbers and hardcode lists of addresses/pins in the driver itself,
push it all to platform resources.  This lets us simplify the driver,
the Kconfig, and gives board porters greater flexibility.

In the process, we need to also start supporting the early platform
interface.  Not a big deal, but it causes the patch to be bigger than
a simple resource relocation.

All the Blackfin boards already have their resources updated and in
place for this change.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
Note: this is for 2.6.38 ... it depends on a Blackfin clean up patch
	that i'll be merging at the start of the 2.6.38 cycle.  looking
	for feedback here and/or just an Ack so i may merge it through my
	Blackfin tree with the related changes.

 arch/blackfin/include/asm/bfin_serial.h |   12 +
 drivers/serial/Kconfig                  |   70 +----
 drivers/serial/bfin_5xx.c               |  638 +++++++++++++++++++------------
 3 files changed, 400 insertions(+), 320 deletions(-)

diff --git a/arch/blackfin/include/asm/bfin_serial.h b/arch/blackfin/include/asm/bfin_serial.h
index e9510ea..1ff9f14 100644
--- a/arch/blackfin/include/asm/bfin_serial.h
+++ b/arch/blackfin/include/asm/bfin_serial.h
@@ -13,6 +13,17 @@
 #include <mach/anomaly.h>
 #include <mach/bfin_serial.h>
 
+#if defined(CONFIG_BFIN_UART0_CTSRTS) || \
+    defined(CONFIG_BFIN_UART1_CTSRTS) || \
+    defined(CONFIG_BFIN_UART2_CTSRTS) || \
+    defined(CONFIG_BFIN_UART3_CTSRTS)
+# ifdef BFIN_UART_BF54X_STYLE
+#  define CONFIG_SERIAL_BFIN_HARD_CTSRTS
+# else
+#  define CONFIG_SERIAL_BFIN_CTSRTS
+# endif
+#endif
+
 struct circ_buf;
 struct timer_list;
 struct work_struct;
@@ -203,6 +214,7 @@ struct bfin_uart_regs {
 #define UART_PUT_LSR(p, v)    bfin_write16(port_membase(p) + OFFSET_LSR, v)
 
 /* This handles hard CTS/RTS */
+#define BFIN_UART_CTSRTS_HARD
 #define UART_CLEAR_SCTS(p)      bfin_write16((port_membase(p) + OFFSET_MSR), SCTS)
 #define UART_GET_CTS(x)         (UART_GET_MSR(x) & CTS)
 #define UART_DISABLE_RTS(x)     UART_PUT_MCR(x, UART_GET_MCR(x) & ~(ARTS | MRTS))
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index aff9dcd..06a2ca5 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -776,24 +776,7 @@ config BFIN_UART0_CTSRTS
 	bool "Enable UART0 hardware flow control"
 	depends on SERIAL_BFIN_UART0
 	help
-	  Enable hardware flow control in the driver. Using GPIO emulate the CTS/RTS
-	  signal.
-
-config UART0_CTS_PIN
-	int "UART0 CTS pin"
-	depends on BFIN_UART0_CTSRTS && !BF548
-	default 23
-	help
-	  The default pin is GPIO_GP7.
-	  Refer to arch/blackfin/mach-*/include/mach/gpio.h to see the GPIO map.
-
-config UART0_RTS_PIN
-	int "UART0 RTS pin"
-	depends on BFIN_UART0_CTSRTS && !BF548
-	default 22
-	help
-	  The default pin is GPIO_GP6.
-	  Refer to arch/blackfin/mach-*/include/mach/gpio.h to see the GPIO map.
+	  Enable hardware flow control in the driver.
 
 config SERIAL_BFIN_UART1
 	bool "Enable UART1"
@@ -805,22 +788,7 @@ config BFIN_UART1_CTSRTS
 	bool "Enable UART1 hardware flow control"
 	depends on SERIAL_BFIN_UART1
 	help
-	  Enable hardware flow control in the driver. Using GPIO emulate the CTS/RTS
-	  signal.
-
-config UART1_CTS_PIN
-	int "UART1 CTS pin"
-	depends on BFIN_UART1_CTSRTS && !BF548
-	default -1
-	help
-	  Refer to arch/blackfin/mach-*/include/mach/gpio.h to see the GPIO map.
-
-config UART1_RTS_PIN
-	int "UART1 RTS pin"
-	depends on BFIN_UART1_CTSRTS && !BF548
-	default -1
-	help
-	  Refer to arch/blackfin/mach-*/include/mach/gpio.h to see the GPIO map.
+	  Enable hardware flow control in the driver.
 
 config SERIAL_BFIN_UART2
 	bool "Enable UART2"
@@ -832,22 +800,7 @@ config BFIN_UART2_CTSRTS
 	bool "Enable UART2 hardware flow control"
 	depends on SERIAL_BFIN_UART2
 	help
-	  Enable hardware flow control in the driver. Using GPIO emulate the CTS/RTS
-	  signal.
-
-config UART2_CTS_PIN
-	int "UART2 CTS pin"
-	depends on BFIN_UART2_CTSRTS && !BF548
-	default -1
-	help
-	  Refer to arch/blackfin/mach-*/include/mach/gpio.h to see the GPIO map.
-
-config UART2_RTS_PIN
-	int "UART2 RTS pin"
-	depends on BFIN_UART2_CTSRTS && !BF548
-	default -1
-	help
-	  Refer to arch/blackfin/mach-*/include/mach/gpio.h to see the GPIO map.
+	  Enable hardware flow control in the driver.
 
 config SERIAL_BFIN_UART3
 	bool "Enable UART3"
@@ -859,22 +812,7 @@ config BFIN_UART3_CTSRTS
 	bool "Enable UART3 hardware flow control"
 	depends on SERIAL_BFIN_UART3
 	help
-	  Enable hardware flow control in the driver. Using GPIO emulate the CTS/RTS
-	  signal.
-
-config UART3_CTS_PIN
-	int "UART3 CTS pin"
-	depends on BFIN_UART3_CTSRTS && !BF548
-	default -1
-	help
-	  Refer to arch/blackfin/mach-*/include/mach/gpio.h to see the GPIO map.
-
-config UART3_RTS_PIN
-	int "UART3 RTS pin"
-	depends on BFIN_UART3_CTSRTS && !BF548
-	default -1
-	help
-	  Refer to arch/blackfin/mach-*/include/mach/gpio.h to see the GPIO map.
+	  Enable hardware flow control in the driver.
 
 config SERIAL_IMX
 	bool "IMX serial port support"
diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 80f15ca..9d4263d 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -1,7 +1,7 @@
 /*
  * Blackfin On-Chip Serial Driver
  *
- * Copyright 2006-2008 Analog Devices Inc.
+ * Copyright 2006-2010 Analog Devices Inc.
  *
  * Enter bugs at http://blackfin.uclinux.org/
  *
@@ -12,6 +12,9 @@
 #define SUPPORT_SYSRQ
 #endif
 
+#define DRIVER_NAME "bfin-uart"
+#define pr_fmt(fmt) DRIVER_NAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/gfp.h>
@@ -23,21 +26,20 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
-#include <linux/dma-mapping.h>
-
-#if defined(CONFIG_KGDB_SERIAL_CONSOLE) || \
-	defined(CONFIG_KGDB_SERIAL_CONSOLE_MODULE)
+#include <linux/gpio.h>
+#include <linux/irq.h>
 #include <linux/kgdb.h>
-#include <asm/irq_regs.h>
-#endif
-
-#include <asm/gpio.h>
-#include <mach/bfin_serial_5xx.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
 
-#include <asm/dma.h>
-#include <asm/io.h>
-#include <asm/irq.h>
+#include <asm/portmux.h>
 #include <asm/cacheflush.h>
+#include <asm/dma.h>
+
+#define port_membase(uart)     (((struct bfin_serial_port *)(uart))->port.membase)
+#define get_lsr_cache(uart)    (((struct bfin_serial_port *)(uart))->lsr)
+#define put_lsr_cache(uart, v) (((struct bfin_serial_port *)(uart))->lsr = (v))
+#include <asm/bfin_serial.h>
 
 #ifdef CONFIG_SERIAL_BFIN_MODULE
 # undef CONFIG_EARLY_PRINTK
@@ -48,12 +50,11 @@
 #endif
 
 /* UART name and device definitions */
-#define BFIN_SERIAL_NAME	"ttyBF"
+#define BFIN_SERIAL_DEV_NAME	"ttyBF"
 #define BFIN_SERIAL_MAJOR	204
 #define BFIN_SERIAL_MINOR	64
 
-static struct bfin_serial_port bfin_serial_ports[BFIN_UART_NR_PORTS];
-static int nr_active_ports = ARRAY_SIZE(bfin_serial_resource);
+static struct bfin_serial_port *bfin_serial_ports[BFIN_UART_NR_PORTS];
 
 #if defined(CONFIG_KGDB_SERIAL_CONSOLE) || \
 	defined(CONFIG_KGDB_SERIAL_CONSOLE_MODULE)
@@ -744,14 +745,14 @@ static int bfin_serial_startup(struct uart_port *port)
 		}
 	}
 	if (uart->rts_pin >= 0) {
-		gpio_request(uart->rts_pin, DRIVER_NAME);
 		gpio_direction_output(uart->rts_pin, 0);
 	}
 #endif
 #ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
-	if (request_irq(uart->status_irq,
+	if (uart->cts_pin >= 0 && request_irq(uart->status_irq,
 		bfin_serial_mctrl_cts_int,
 		IRQF_DISABLED, "BFIN_UART_MODEM_STATUS", uart)) {
+		uart->cts_pin = -1;
 		pr_info("Unable to attach BlackFin UART Modem \
 			Status interrupt.\n");
 	}
@@ -798,11 +799,9 @@ static void bfin_serial_shutdown(struct uart_port *port)
 #ifdef CONFIG_SERIAL_BFIN_CTSRTS
 	if (uart->cts_pin >= 0)
 		free_irq(gpio_to_irq(uart->cts_pin), uart);
-	if (uart->rts_pin >= 0)
-		gpio_free(uart->rts_pin);
 #endif
 #ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
-	if (UART_GET_IER(uart) & EDSSI)
+	if (uart->cts_pin >= 0)
 		free_irq(uart->status_irq, uart);
 #endif
 }
@@ -964,33 +963,33 @@ bfin_serial_verify_port(struct uart_port *port, struct serial_struct *ser)
  */
 static void bfin_serial_set_ldisc(struct uart_port *port, int ld)
 {
-	int line = port->line;
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
 	unsigned short val;
 
 	switch (ld) {
 	case N_IRDA:
-		val = UART_GET_GCTL(&bfin_serial_ports[line]);
+		val = UART_GET_GCTL(uart);
 		val |= (IREN | RPOLC);
-		UART_PUT_GCTL(&bfin_serial_ports[line], val);
+		UART_PUT_GCTL(uart, val);
 		break;
 	default:
-		val = UART_GET_GCTL(&bfin_serial_ports[line]);
+		val = UART_GET_GCTL(uart);
 		val &= ~(IREN | RPOLC);
-		UART_PUT_GCTL(&bfin_serial_ports[line], val);
+		UART_PUT_GCTL(uart, val);
 	}
 }
 
 static void bfin_serial_reset_irda(struct uart_port *port)
 {
-	int line = port->line;
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
 	unsigned short val;
 
-	val = UART_GET_GCTL(&bfin_serial_ports[line]);
+	val = UART_GET_GCTL(uart);
 	val &= ~(IREN | RPOLC);
-	UART_PUT_GCTL(&bfin_serial_ports[line], val);
+	UART_PUT_GCTL(uart, val);
 	SSYNC();
 	val |= (IREN | RPOLC);
-	UART_PUT_GCTL(&bfin_serial_ports[line], val);
+	UART_PUT_GCTL(uart, val);
 	SSYNC();
 }
 
@@ -1072,85 +1071,6 @@ static struct uart_ops bfin_serial_pops = {
 #endif
 };
 
-static void __init bfin_serial_hw_init(void)
-{
-#ifdef CONFIG_SERIAL_BFIN_UART0
-	peripheral_request(P_UART0_TX, DRIVER_NAME);
-	peripheral_request(P_UART0_RX, DRIVER_NAME);
-#endif
-
-#ifdef CONFIG_SERIAL_BFIN_UART1
-	peripheral_request(P_UART1_TX, DRIVER_NAME);
-	peripheral_request(P_UART1_RX, DRIVER_NAME);
-
-# if defined(CONFIG_BFIN_UART1_CTSRTS) && defined(CONFIG_BF54x)
-	peripheral_request(P_UART1_RTS, DRIVER_NAME);
-	peripheral_request(P_UART1_CTS, DRIVER_NAME);
-# endif
-#endif
-
-#ifdef CONFIG_SERIAL_BFIN_UART2
-	peripheral_request(P_UART2_TX, DRIVER_NAME);
-	peripheral_request(P_UART2_RX, DRIVER_NAME);
-#endif
-
-#ifdef CONFIG_SERIAL_BFIN_UART3
-	peripheral_request(P_UART3_TX, DRIVER_NAME);
-	peripheral_request(P_UART3_RX, DRIVER_NAME);
-
-# if defined(CONFIG_BFIN_UART3_CTSRTS) && defined(CONFIG_BF54x)
-	peripheral_request(P_UART3_RTS, DRIVER_NAME);
-	peripheral_request(P_UART3_CTS, DRIVER_NAME);
-# endif
-#endif
-}
-
-static void __init bfin_serial_init_ports(void)
-{
-	static int first = 1;
-	int i;
-
-	if (!first)
-		return;
-	first = 0;
-
-	bfin_serial_hw_init();
-
-	for (i = 0; i < nr_active_ports; i++) {
-		spin_lock_init(&bfin_serial_ports[i].port.lock);
-		bfin_serial_ports[i].port.uartclk   = get_sclk();
-		bfin_serial_ports[i].port.fifosize  = BFIN_UART_TX_FIFO_SIZE;
-		bfin_serial_ports[i].port.ops       = &bfin_serial_pops;
-		bfin_serial_ports[i].port.line      = i;
-		bfin_serial_ports[i].port.iotype    = UPIO_MEM;
-		bfin_serial_ports[i].port.membase   =
-			(void __iomem *)bfin_serial_resource[i].uart_base_addr;
-		bfin_serial_ports[i].port.mapbase   =
-			bfin_serial_resource[i].uart_base_addr;
-		bfin_serial_ports[i].port.irq       =
-			bfin_serial_resource[i].uart_irq;
-		bfin_serial_ports[i].status_irq	    =
-			bfin_serial_resource[i].uart_status_irq;
-		bfin_serial_ports[i].port.flags     = UPF_BOOT_AUTOCONF;
-#ifdef CONFIG_SERIAL_BFIN_DMA
-		bfin_serial_ports[i].tx_done	    = 1;
-		bfin_serial_ports[i].tx_count	    = 0;
-		bfin_serial_ports[i].tx_dma_channel =
-			bfin_serial_resource[i].uart_tx_dma_channel;
-		bfin_serial_ports[i].rx_dma_channel =
-			bfin_serial_resource[i].uart_rx_dma_channel;
-		init_timer(&(bfin_serial_ports[i].rx_dma_timer));
-#endif
-#if defined(CONFIG_SERIAL_BFIN_CTSRTS) || \
-	defined(CONFIG_SERIAL_BFIN_HARD_CTSRTS)
-		bfin_serial_ports[i].cts_pin	    =
-			bfin_serial_resource[i].uart_cts_pin;
-		bfin_serial_ports[i].rts_pin	    =
-			bfin_serial_resource[i].uart_rts_pin;
-#endif
-	}
-}
-
 #if defined(CONFIG_SERIAL_BFIN_CONSOLE) || defined(CONFIG_EARLY_PRINTK)
 /*
  * If the port was already initialised (eg, by a boot loader),
@@ -1198,6 +1118,34 @@ bfin_serial_console_get_options(struct bfin_serial_port *uart, int *baud,
 
 static struct uart_driver bfin_serial_reg;
 
+static void bfin_serial_console_putchar(struct uart_port *port, int ch)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+	while (!(UART_GET_LSR(uart) & THRE))
+		barrier();
+	UART_PUT_CHAR(uart, ch);
+}
+
+#endif /* defined (CONFIG_SERIAL_BFIN_CONSOLE) ||
+		 defined (CONFIG_EARLY_PRINTK) */
+
+#ifdef CONFIG_SERIAL_BFIN_CONSOLE
+#define CLASS_BFIN_CONSOLE	"bfin-console"
+/*
+ * Interrupts are disabled on entering
+ */
+static void
+bfin_serial_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct bfin_serial_port *uart = bfin_serial_ports[co->index];
+	unsigned long flags;
+
+	spin_lock_irqsave(&uart->port.lock, flags);
+	uart_console_write(&uart->port, s, count, bfin_serial_console_putchar);
+	spin_unlock_irqrestore(&uart->port.lock, flags);
+
+}
+
 static int __init
 bfin_serial_console_setup(struct console *co, char *options)
 {
@@ -1217,9 +1165,12 @@ bfin_serial_console_setup(struct console *co, char *options)
 	 * if so, search for the first available port that does have
 	 * console support.
 	 */
-	if (co->index == -1 || co->index >= nr_active_ports)
-		co->index = 0;
-	uart = &bfin_serial_ports[co->index];
+	if (co->index < 0 || co->index >= BFIN_UART_NR_PORTS)
+		return -ENODEV;
+
+	uart = bfin_serial_ports[co->index];
+	if (!uart)
+		return -ENODEV;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -1228,36 +1179,9 @@ bfin_serial_console_setup(struct console *co, char *options)
 
 	return uart_set_options(&uart->port, co, baud, parity, bits, flow);
 }
-#endif /* defined (CONFIG_SERIAL_BFIN_CONSOLE) ||
-				 defined (CONFIG_EARLY_PRINTK) */
-
-#ifdef CONFIG_SERIAL_BFIN_CONSOLE
-static void bfin_serial_console_putchar(struct uart_port *port, int ch)
-{
-	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
-	while (!(UART_GET_LSR(uart) & THRE))
-		barrier();
-	UART_PUT_CHAR(uart, ch);
-	SSYNC();
-}
-
-/*
- * Interrupts are disabled on entering
- */
-static void
-bfin_serial_console_write(struct console *co, const char *s, unsigned int count)
-{
-	struct bfin_serial_port *uart = &bfin_serial_ports[co->index];
-	unsigned long flags;
-
-	spin_lock_irqsave(&uart->port.lock, flags);
-	uart_console_write(&uart->port, s, count, bfin_serial_console_putchar);
-	spin_unlock_irqrestore(&uart->port.lock, flags);
-
-}
 
 static struct console bfin_serial_console = {
-	.name		= BFIN_SERIAL_NAME,
+	.name		= BFIN_SERIAL_DEV_NAME,
 	.write		= bfin_serial_console_write,
 	.device		= uart_console_device,
 	.setup		= bfin_serial_console_setup,
@@ -1265,44 +1189,30 @@ static struct console bfin_serial_console = {
 	.index		= -1,
 	.data		= &bfin_serial_reg,
 };
-
-static int __init bfin_serial_rs_console_init(void)
-{
-	bfin_serial_init_ports();
-	register_console(&bfin_serial_console);
-
-	return 0;
-}
-console_initcall(bfin_serial_rs_console_init);
-
 #define BFIN_SERIAL_CONSOLE	&bfin_serial_console
 #else
 #define BFIN_SERIAL_CONSOLE	NULL
 #endif /* CONFIG_SERIAL_BFIN_CONSOLE */
 
+#ifdef	CONFIG_EARLY_PRINTK
+static struct bfin_serial_port bfin_earlyprintk_port;
+#define CLASS_BFIN_EARLYPRINTK	"bfin-earlyprintk"
 
-#ifdef CONFIG_EARLY_PRINTK
-static __init void early_serial_putc(struct uart_port *port, int ch)
+/*
+ * Interrupts are disabled on entering
+ */
+static void
+bfin_earlyprintk_console_write(struct console *co, const char *s, unsigned int count)
 {
-	unsigned timeout = 0xffff;
-	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
-
-	while ((!(UART_GET_LSR(uart) & THRE)) && --timeout)
-		cpu_relax();
-	UART_PUT_CHAR(uart, ch);
-}
+	unsigned long flags;
 
-static __init void early_serial_write(struct console *con, const char *s,
-					unsigned int n)
-{
-	struct bfin_serial_port *uart = &bfin_serial_ports[con->index];
-	unsigned int i;
+	if (bfin_earlyprintk_port.port.line != co->index)
+		return;
 
-	for (i = 0; i < n; i++, s++) {
-		if (*s == '\n')
-			early_serial_putc(&uart->port, '\r');
-		early_serial_putc(&uart->port, *s);
-	}
+	spin_lock_irqsave(&bfin_earlyprintk_port.port.lock, flags);
+	uart_console_write(&bfin_earlyprintk_port.port, s, count,
+		bfin_serial_console_putchar);
+	spin_unlock_irqrestore(&bfin_earlyprintk_port.port.lock, flags);
 }
 
 /*
@@ -1313,113 +1223,204 @@ static __init void early_serial_write(struct console *con, const char *s,
  */
 static struct __initdata console bfin_early_serial_console = {
 	.name = "early_BFuart",
-	.write = early_serial_write,
+	.write = bfin_earlyprintk_console_write,
 	.device = uart_console_device,
 	.flags = CON_PRINTBUFFER,
 	.index = -1,
 	.data  = &bfin_serial_reg,
 };
-
-struct console __init *bfin_earlyserial_init(unsigned int port,
-						unsigned int cflag)
-{
-	struct bfin_serial_port *uart;
-	struct ktermios t;
-
-#ifdef CONFIG_SERIAL_BFIN_CONSOLE
-	/*
-	 * If we are using early serial, don't let the normal console rewind
-	 * log buffer, since that causes things to be printed multiple times
-	 */
-	bfin_serial_console.flags &= ~CON_PRINTBUFFER;
 #endif
 
-	if (port == -1 || port >= nr_active_ports)
-		port = 0;
-	bfin_serial_init_ports();
-	bfin_early_serial_console.index = port;
-	uart = &bfin_serial_ports[port];
-	t.c_cflag = cflag;
-	t.c_iflag = 0;
-	t.c_oflag = 0;
-	t.c_lflag = ICANON;
-	t.c_line = port;
-	bfin_serial_set_termios(&uart->port, &t, &t);
-	return &bfin_early_serial_console;
-}
-
-#endif /* CONFIG_EARLY_PRINTK */
-
 static struct uart_driver bfin_serial_reg = {
 	.owner			= THIS_MODULE,
-	.driver_name		= "bfin-uart",
-	.dev_name		= BFIN_SERIAL_NAME,
+	.driver_name		= DRIVER_NAME,
+	.dev_name		= BFIN_SERIAL_DEV_NAME,
 	.major			= BFIN_SERIAL_MAJOR,
 	.minor			= BFIN_SERIAL_MINOR,
 	.nr			= BFIN_UART_NR_PORTS,
 	.cons			= BFIN_SERIAL_CONSOLE,
 };
 
-static int bfin_serial_suspend(struct platform_device *dev, pm_message_t state)
+static int bfin_serial_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	int i;
+	struct bfin_serial_port *uart = platform_get_drvdata(pdev);
 
-	for (i = 0; i < nr_active_ports; i++) {
-		if (bfin_serial_ports[i].port.dev != &dev->dev)
-			continue;
-		uart_suspend_port(&bfin_serial_reg, &bfin_serial_ports[i].port);
-	}
+	return uart_suspend_port(&bfin_serial_reg, &uart->port);
+}
 
-	return 0;
+static int bfin_serial_resume(struct platform_device *pdev)
+{
+	struct bfin_serial_port *uart = platform_get_drvdata(pdev);
+
+	return uart_resume_port(&bfin_serial_reg, &uart->port);
 }
 
-static int bfin_serial_resume(struct platform_device *dev)
+static int bfin_serial_probe(struct platform_device *pdev)
 {
-	int i;
+	struct resource *res;
+	struct bfin_serial_port *uart = NULL;
+	int ret = 0;
 
-	for (i = 0; i < nr_active_ports; i++) {
-		if (bfin_serial_ports[i].port.dev != &dev->dev)
-			continue;
-		uart_resume_port(&bfin_serial_reg, &bfin_serial_ports[i].port);
+	if (pdev->id < 0 || pdev->id >= BFIN_UART_NR_PORTS) {
+		dev_err(&pdev->dev, "Wrong bfin uart platform device id.\n");
+		return -ENOENT;
 	}
 
-	return 0;
-}
+	if (bfin_serial_ports[pdev->id] == NULL) {
 
-static int bfin_serial_probe(struct platform_device *dev)
-{
-	struct resource *res = dev->resource;
-	int i;
+		uart = kzalloc(sizeof(*uart), GFP_KERNEL);
+		if (!uart) {
+			dev_err(&pdev->dev,
+				"fail to malloc bfin_serial_port\n");
+			return -ENOMEM;
+		}
+		bfin_serial_ports[pdev->id] = uart;
 
-	for (i = 0; i < dev->num_resources; i++, res++)
-		if (res->flags & IORESOURCE_MEM)
-			break;
+#ifdef CONFIG_EARLY_PRINTK
+		if (!(bfin_earlyprintk_port.port.membase
+			&& bfin_earlyprintk_port.port.line == pdev->id)) {
+			/*
+			 * If the peripheral PINs of current port is allocated
+			 * in earlyprintk probe stage, don't do it again.
+			 */
+#endif
+		ret = peripheral_request_list(
+			(unsigned short *)pdev->dev.platform_data, DRIVER_NAME);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"fail to request bfin serial peripherals\n");
+			goto out_error_free_mem;
+		}
+#ifdef CONFIG_EARLY_PRINTK
+		}
+#endif
+
+		spin_lock_init(&uart->port.lock);
+		uart->port.uartclk   = get_sclk();
+		uart->port.fifosize  = BFIN_UART_TX_FIFO_SIZE;
+		uart->port.ops       = &bfin_serial_pops;
+		uart->port.line      = pdev->id;
+		uart->port.iotype    = UPIO_MEM;
+		uart->port.flags     = UPF_BOOT_AUTOCONF;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (res == NULL) {
+			dev_err(&pdev->dev, "Cannot get IORESOURCE_MEM\n");
+			ret = -ENOENT;
+			goto out_error_free_peripherals;
+		}
+
+		uart->port.membase = ioremap(res->start,
+			res->end - res->start);
+		if (!uart->port.membase) {
+			dev_err(&pdev->dev, "Cannot map uart IO\n");
+			ret = -ENXIO;
+			goto out_error_free_peripherals;
+		}
+		uart->port.mapbase = res->start;
 
-	if (i < dev->num_resources) {
-		for (i = 0; i < nr_active_ports; i++, res++) {
-			if (bfin_serial_ports[i].port.mapbase != res->start)
-				continue;
-			bfin_serial_ports[i].port.dev = &dev->dev;
-			uart_add_one_port(&bfin_serial_reg, &bfin_serial_ports[i].port);
+		uart->port.irq = platform_get_irq(pdev, 0);
+		if (uart->port.irq < 0) {
+			dev_err(&pdev->dev, "No uart RX/TX IRQ specified\n");
+			ret = -ENOENT;
+			goto out_error_unmap;
 		}
+
+		uart->status_irq = platform_get_irq(pdev, 1);
+		if (uart->status_irq < 0) {
+			dev_err(&pdev->dev, "No uart status IRQ specified\n");
+			ret = -ENOENT;
+			goto out_error_unmap;
+		}
+
+#ifdef CONFIG_SERIAL_BFIN_DMA
+		uart->tx_done	    = 1;
+		uart->tx_count	    = 0;
+
+		res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (res == NULL) {
+			dev_err(&pdev->dev, "No uart TX DMA channel specified\n");
+			ret = -ENOENT;
+			goto out_error_unmap;
+		}
+		uart->tx_dma_channel = res->start;
+
+		res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+		if (res == NULL) {
+			dev_err(&pdev->dev, "No uart RX DMA channel specified\n");
+			ret = -ENOENT;
+			goto out_error_unmap;
+		}
+		uart->rx_dma_channel = res->start;
+
+		init_timer(&(uart->rx_dma_timer));
+#endif
+
+#if defined(CONFIG_SERIAL_BFIN_CTSRTS) || \
+	defined(CONFIG_SERIAL_BFIN_HARD_CTSRTS)
+		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+		if (res == NULL)
+			uart->cts_pin = -1;
+		else
+			uart->cts_pin = res->start;
+
+		res = platform_get_resource(pdev, IORESOURCE_IO, 1);
+		if (res == NULL)
+			uart->rts_pin = -1;
+		else
+			uart->rts_pin = res->start;
+# if defined(CONFIG_SERIAL_BFIN_CTSRTS)
+		if (uart->rts_pin >= 0)
+			gpio_request(uart->rts_pin, DRIVER_NAME);
+# endif
+#endif
 	}
 
-	return 0;
+#ifdef CONFIG_SERIAL_BFIN_CONSOLE
+	if (!is_early_platform_device(pdev)) {
+#endif
+		uart = bfin_serial_ports[pdev->id];
+		uart->port.dev = &pdev->dev;
+		dev_set_drvdata(&pdev->dev, uart);
+		ret = uart_add_one_port(&bfin_serial_reg, &uart->port);
+#ifdef CONFIG_SERIAL_BFIN_CONSOLE
+	}
+#endif
+
+	if (!ret)
+		return 0;
+
+	if (uart) {
+out_error_unmap:
+		iounmap(uart->port.membase);
+out_error_free_peripherals:
+		peripheral_free_list(
+			(unsigned short *)pdev->dev.platform_data);
+out_error_free_mem:
+		kfree(uart);
+		bfin_serial_ports[pdev->id] = NULL;
+	}
+
+	return ret;
 }
 
-static int bfin_serial_remove(struct platform_device *dev)
+static int __devexit bfin_serial_remove(struct platform_device *pdev)
 {
-	int i;
-
-	for (i = 0; i < nr_active_ports; i++) {
-		if (bfin_serial_ports[i].port.dev != &dev->dev)
-			continue;
-		uart_remove_one_port(&bfin_serial_reg, &bfin_serial_ports[i].port);
-		bfin_serial_ports[i].port.dev = NULL;
-#if defined(CONFIG_SERIAL_BFIN_CTSRTS)
-		gpio_free(bfin_serial_ports[i].cts_pin);
-		gpio_free(bfin_serial_ports[i].rts_pin);
+	struct bfin_serial_port *uart = platform_get_drvdata(pdev);
+
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	if (uart) {
+		uart_remove_one_port(&bfin_serial_reg, &uart->port);
+#ifdef CONFIG_SERIAL_BFIN_CTSRTS
+		if (uart->rts_pin >= 0)
+			gpio_free(uart->rts_pin);
 #endif
+		iounmap(uart->port.membase);
+		peripheral_free_list(
+			(unsigned short *)pdev->dev.platform_data);
+		kfree(uart);
+		bfin_serial_ports[pdev->id] = NULL;
 	}
 
 	return 0;
@@ -1427,31 +1428,160 @@ static int bfin_serial_remove(struct platform_device *dev)
 
 static struct platform_driver bfin_serial_driver = {
 	.probe		= bfin_serial_probe,
-	.remove		= bfin_serial_remove,
+	.remove		= __devexit_p(bfin_serial_remove),
 	.suspend	= bfin_serial_suspend,
 	.resume		= bfin_serial_resume,
 	.driver		= {
-		.name	= "bfin-uart",
+		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
 	},
 };
 
-static int __init bfin_serial_init(void)
+#if defined(CONFIG_SERIAL_BFIN_CONSOLE)
+static __initdata struct early_platform_driver early_bfin_serial_driver = {
+	.class_str = CLASS_BFIN_CONSOLE,
+	.pdrv = &bfin_serial_driver,
+	.requested_id = EARLY_PLATFORM_ID_UNSET,
+};
+
+static int __init bfin_serial_rs_console_init(void)
+{
+	early_platform_driver_register(&early_bfin_serial_driver, DRIVER_NAME);
+
+	early_platform_driver_probe(CLASS_BFIN_CONSOLE, BFIN_UART_NR_PORTS, 0);
+
+	register_console(&bfin_serial_console);
+
+	return 0;
+}
+console_initcall(bfin_serial_rs_console_init);
+#endif
+
+#ifdef CONFIG_EARLY_PRINTK
+/*
+ * Memory can't be allocated dynamically during earlyprink init stage.
+ * So, do individual probe for earlyprink with a static uart port variable.
+ */
+static int bfin_earlyprintk_probe(struct platform_device *pdev)
 {
+	struct resource *res;
 	int ret;
 
-	pr_info("Serial: Blackfin serial driver\n");
+	if (pdev->id < 0 || pdev->id >= BFIN_UART_NR_PORTS) {
+		dev_err(&pdev->dev, "Wrong earlyprintk platform device id.\n");
+		return -ENOENT;
+	}
+
+	ret = peripheral_request_list(
+		(unsigned short *)pdev->dev.platform_data, DRIVER_NAME);
+	if (ret) {
+		dev_err(&pdev->dev,
+				"fail to request bfin serial peripherals\n");
+			return ret;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "Cannot get IORESOURCE_MEM\n");
+		ret = -ENOENT;
+		goto out_error_free_peripherals;
+	}
+
+	bfin_earlyprintk_port.port.membase = ioremap(res->start,
+			res->end - res->start);
+	if (!bfin_earlyprintk_port.port.membase) {
+		dev_err(&pdev->dev, "Cannot map uart IO\n");
+		ret = -ENXIO;
+		goto out_error_free_peripherals;
+	}
+	bfin_earlyprintk_port.port.mapbase = res->start;
+	bfin_earlyprintk_port.port.line = pdev->id;
+	bfin_earlyprintk_port.port.uartclk = get_sclk();
+	bfin_earlyprintk_port.port.fifosize  = BFIN_UART_TX_FIFO_SIZE;
+	spin_lock_init(&bfin_earlyprintk_port.port.lock);
+
+	return 0;
+
+out_error_free_peripherals:
+	peripheral_free_list(
+		(unsigned short *)pdev->dev.platform_data);
+
+	return ret;
+}
+
+static struct platform_driver bfin_earlyprintk_driver = {
+	.probe		= bfin_earlyprintk_probe,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static __initdata struct early_platform_driver early_bfin_earlyprintk_driver = {
+	.class_str = CLASS_BFIN_EARLYPRINTK,
+	.pdrv = &bfin_earlyprintk_driver,
+	.requested_id = EARLY_PLATFORM_ID_UNSET,
+};
+
+struct console __init *bfin_earlyserial_init(unsigned int port,
+						unsigned int cflag)
+{
+	struct ktermios t;
+	char port_name[20];
 
-	bfin_serial_init_ports();
+	if (port < 0 || port >= BFIN_UART_NR_PORTS)
+		return NULL;
+
+	/*
+	 * Only probe resource of the given port in earlyprintk boot arg.
+	 * The expected port id should be indicated in port name string.
+	 */
+	snprintf(port_name, 20, DRIVER_NAME ".%d", port);
+	early_platform_driver_register(&early_bfin_earlyprintk_driver,
+		port_name);
+	early_platform_driver_probe(CLASS_BFIN_EARLYPRINTK, 1, 0);
+
+	if (!bfin_earlyprintk_port.port.membase)
+		return NULL;
+
+#ifdef CONFIG_SERIAL_BFIN_CONSOLE
+	/*
+	 * If we are using early serial, don't let the normal console rewind
+	 * log buffer, since that causes things to be printed multiple times
+	 */
+	bfin_serial_console.flags &= ~CON_PRINTBUFFER;
+#endif
+
+	bfin_early_serial_console.index = port;
+	t.c_cflag = cflag;
+	t.c_iflag = 0;
+	t.c_oflag = 0;
+	t.c_lflag = ICANON;
+	t.c_line = port;
+	bfin_serial_set_termios(&bfin_earlyprintk_port.port, &t, &t);
+
+	return &bfin_early_serial_console;
+}
+#endif /* CONFIG_EARLY_PRINTK */
+
+static int __init bfin_serial_init(void)
+{
+	int ret;
+
+	pr_info("Blackfin serial driver\n");
 
 	ret = uart_register_driver(&bfin_serial_reg);
-	if (ret == 0) {
-		ret = platform_driver_register(&bfin_serial_driver);
-		if (ret) {
-			pr_debug("uart register failed\n");
-			uart_unregister_driver(&bfin_serial_reg);
-		}
+	if (ret) {
+		pr_err("failed to register %s:%d\n",
+			bfin_serial_reg.driver_name, ret);
+	}
+
+	ret = platform_driver_register(&bfin_serial_driver);
+	if (ret) {
+		pr_err("fail to register bfin uart\n");
+		uart_unregister_driver(&bfin_serial_reg);
 	}
+
 	return ret;
 }
 
@@ -1465,7 +1595,7 @@ static void __exit bfin_serial_exit(void)
 module_init(bfin_serial_init);
 module_exit(bfin_serial_exit);
 
-MODULE_AUTHOR("Aubrey.Li <aubrey.li@analog.com>");
+MODULE_AUTHOR("Sonic Zhang, Aubrey Li");
 MODULE_DESCRIPTION("Blackfin generic serial port driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CHARDEV_MAJOR(BFIN_SERIAL_MAJOR);
-- 
1.7.3.2

