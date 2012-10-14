From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 02/12] serial: clps711x: Convert all static variables to dynamic
Date: Sun, 14 Oct 2012 11:05:24 +0400
Message-ID: <1350198334-18737-2-git-send-email-shc_work@mail.ru>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:38875 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHFw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:05:52 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>

This patch converts all static variables of clps711x serial driver
to dynamic allocating. In this case we are should remove console_initcall()
and declare console during driver registration. Early kernel messages can
be retrieved by add "earlyprintk" option to the kernel command line.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |  211 +++++++++++++++++------------------------
 1 files changed, 89 insertions(+), 122 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 07fef1c..de6aa33 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -43,28 +43,29 @@
 #include <asm/irq.h>
 
 #define UART_CLPS711X_NAME	"uart-clps711x"
+#define UART_CLPS711X_NR	2
+#define UART_CLPS711X_MAJOR	204
+#define UART_CLPS711X_MINOR	40
 
-#define UART_NR		2
-
-#define SERIAL_CLPS711X_MAJOR	204
-#define SERIAL_CLPS711X_MINOR	40
-#define SERIAL_CLPS711X_NR	UART_NR
-
-/*
- * We use the relevant SYSCON register as a base address for these ports.
- */
-#define UBRLCR(port)		((port)->iobase + UBRLCR1 - SYSCON1)
-#define UARTDR(port)		((port)->iobase + UARTDR1 - SYSCON1)
-#define SYSFLG(port)		((port)->iobase + SYSFLG1 - SYSCON1)
-#define SYSCON(port)		((port)->iobase + SYSCON1 - SYSCON1)
-
-#define TX_IRQ(port)		((port)->irq)
-#define RX_IRQ(port)		((port)->irq + 1)
+#define UBRLCR(port)		((port)->line ? UBRLCR2 : UBRLCR1)
+#define UARTDR(port)		((port)->line ? UARTDR2 : UARTDR1)
+#define SYSFLG(port)		((port)->line ? SYSFLG2 : SYSFLG1)
+#define SYSCON(port)		((port)->line ? SYSCON2 : SYSCON1)
+#define TX_IRQ(port)		((port)->line ? IRQ_UTXINT2 : IRQ_UTXINT1)
+#define RX_IRQ(port)		((port)->line ? IRQ_URXINT2 : IRQ_URXINT1)
 
 #define UART_ANY_ERR		(UARTDR_FRMERR | UARTDR_PARERR | UARTDR_OVERR)
 
 #define tx_enabled(port)	((port)->unused[0])
 
+struct clps711x_port {
+	struct uart_driver	uart;
+	struct uart_port	port[UART_CLPS711X_NR];
+#ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
+	struct console		console;
+#endif
+};
+
 static void clps711xuart_stop_tx(struct uart_port *port)
 {
 	if (tx_enabled(port)) {
@@ -382,7 +383,7 @@ static int clps711xuart_request_port(struct uart_port *port)
 	return 0;
 }
 
-static struct uart_ops clps711x_pops = {
+static struct uart_ops uart_clps711x_ops = {
 	.tx_empty	= clps711xuart_tx_empty,
 	.set_mctrl	= clps711xuart_set_mctrl_null,
 	.get_mctrl	= clps711xuart_get_mctrl,
@@ -400,72 +401,39 @@ static struct uart_ops clps711x_pops = {
 	.request_port	= clps711xuart_request_port,
 };
 
-static struct uart_port clps711x_ports[UART_NR] = {
-	{
-		.iobase		= SYSCON1,
-		.irq		= IRQ_UTXINT1, /* IRQ_URXINT1, IRQ_UMSINT */
-		.uartclk	= 3686400,
-		.fifosize	= 16,
-		.ops		= &clps711x_pops,
-		.line		= 0,
-		.flags		= UPF_BOOT_AUTOCONF,
-	},
-	{
-		.iobase		= SYSCON2,
-		.irq		= IRQ_UTXINT2, /* IRQ_URXINT2 */
-		.uartclk	= 3686400,
-		.fifosize	= 16,
-		.ops		= &clps711x_pops,
-		.line		= 1,
-		.flags		= UPF_BOOT_AUTOCONF,
-	}
-};
-
 #ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
-static void clps711xuart_console_putchar(struct uart_port *port, int ch)
+static void uart_clps711x_console_putchar(struct uart_port *port, int ch)
 {
 	while (clps_readl(SYSFLG(port)) & SYSFLG_UTXFF)
 		barrier();
-	clps_writel(ch, UARTDR(port));
+
+	clps_writew(ch, UARTDR(port));
 }
 
-/*
- *	Print a string to the serial port trying not to disturb
- *	any possible real use of the port...
- *
- *	The console_lock must be held when we get here.
- *
- *	Note that this is called with interrupts already disabled
- */
-static void
-clps711xuart_console_write(struct console *co, const char *s,
-			   unsigned int count)
+static void uart_clps711x_console_write(struct console *co, const char *c,
+					unsigned n)
 {
-	struct uart_port *port = clps711x_ports + co->index;
-	unsigned int status, syscon;
+	struct clps711x_port *s = (struct clps711x_port *)co->data;
+	struct uart_port *port = &s->port[co->index];
+	u32 syscon;
 
-	/*
-	 *	Ensure that the port is enabled.
-	 */
+	/* Ensure that the port is enabled */
 	syscon = clps_readl(SYSCON(port));
 	clps_writel(syscon | SYSCON_UARTEN, SYSCON(port));
 
-	uart_console_write(port, s, count, clps711xuart_console_putchar);
+	uart_console_write(port, c, n, uart_clps711x_console_putchar);
 
-	/*
-	 *	Finally, wait for transmitter to become empty
-	 *	and restore the uart state.
-	 */
-	do {
-		status = clps_readl(SYSFLG(port));
-	} while (status & SYSFLG_UBUSY);
+	/* Wait for transmitter to become empty */
+	while (clps_readl(SYSFLG(port)) & SYSFLG_UBUSY)
+		barrier();
 
+	/* Restore the uart state */
 	clps_writel(syscon, SYSCON(port));
 }
 
-static void __init
-clps711xuart_console_get_options(struct uart_port *port, int *baud,
-				 int *parity, int *bits)
+static void uart_clps711x_console_get_options(struct uart_port *port,
+					      int *baud, int *parity,
+					      int *bits)
 {
 	if (clps_readl(SYSCON(port)) & SYSCON_UARTEN) {
 		unsigned int ubrlcr, quot;
@@ -490,86 +458,85 @@ clps711xuart_console_get_options(struct uart_port *port, int *baud,
 	}
 }
 
-static int __init clps711xuart_console_setup(struct console *co, char *options)
+static int uart_clps711x_console_setup(struct console *co, char *options)
 {
-	struct uart_port *port;
-	int baud = 38400;
-	int bits = 8;
-	int parity = 'n';
-	int flow = 'n';
-
-	/*
-	 * Check whether an invalid uart number has been specified, and
-	 * if so, search for the first available port that does have
-	 * console support.
-	 */
-	port = uart_get_console(clps711x_ports, UART_NR, co);
+	int baud = 38400, bits = 8, parity = 'n', flow = 'n';
+	struct clps711x_port *s = (struct clps711x_port *)co->data;
+	struct uart_port *port = &s->port[(co->index > 0) ? co->index : 0];
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
-		clps711xuart_console_get_options(port, &baud, &parity, &bits);
+		uart_clps711x_console_get_options(port, &baud, &parity, &bits);
 
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
-
-static struct uart_driver clps711x_reg;
-static struct console clps711x_console = {
-	.name		= "ttyCL",
-	.write		= clps711xuart_console_write,
-	.device		= uart_console_device,
-	.setup		= clps711xuart_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &clps711x_reg,
-};
-
-static int __init clps711xuart_console_init(void)
-{
-	register_console(&clps711x_console);
-	return 0;
-}
-console_initcall(clps711xuart_console_init);
-
-#define CLPS711X_CONSOLE	&clps711x_console
-#else
-#define CLPS711X_CONSOLE	NULL
 #endif
 
-static struct uart_driver clps711x_reg = {
-	.driver_name		= "ttyCL",
-	.dev_name		= "ttyCL",
-	.major			= SERIAL_CLPS711X_MAJOR,
-	.minor			= SERIAL_CLPS711X_MINOR,
-	.nr			= UART_NR,
-
-	.cons			= CLPS711X_CONSOLE,
-};
-
 static int __devinit uart_clps711x_probe(struct platform_device *pdev)
 {
+	struct clps711x_port *s;
 	int ret, i;
 
-	printk(KERN_INFO "Serial: CLPS711x driver\n");
+	s = devm_kzalloc(&pdev->dev, sizeof(struct clps711x_port), GFP_KERNEL);
+	if (!s) {
+		dev_err(&pdev->dev, "Error allocating port structure\n");
+		return -ENOMEM;
+	}
+	platform_set_drvdata(pdev, s);
 
-	ret = uart_register_driver(&clps711x_reg);
-	if (ret)
-		return ret;
+	s->uart.owner		= THIS_MODULE;
+	s->uart.dev_name	= "ttyCL";
+	s->uart.major		= UART_CLPS711X_MAJOR;
+	s->uart.minor		= UART_CLPS711X_MINOR;
+	s->uart.nr		= UART_CLPS711X_NR;
+#ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
+	s->uart.cons		= &s->console;
+	s->uart.cons->device	= uart_console_device;
+	s->uart.cons->write	= uart_clps711x_console_write;
+	s->uart.cons->setup	= uart_clps711x_console_setup;
+	s->uart.cons->flags	= CON_PRINTBUFFER;
+	s->uart.cons->index	= -1;
+	s->uart.cons->data	= s;
+	strcpy(s->uart.cons->name, "ttyCL");
+#endif
+	ret = uart_register_driver(&s->uart);
+	if (ret) {
+		dev_err(&pdev->dev, "Registering UART driver failed\n");
+		goto err_out;
+	}
 
-	for (i = 0; i < UART_NR; i++)
-		uart_add_one_port(&clps711x_reg, &clps711x_ports[i]);
+	for (i = 0; i < UART_CLPS711X_NR; i++) {
+		s->port[i].line		= i;
+		s->port[i].dev		= &pdev->dev;
+		s->port[i].irq		= TX_IRQ(&s->port[i]);
+		s->port[i].iobase	= SYSCON(&s->port[i]);
+		s->port[i].type		= PORT_CLPS711X;
+		s->port[i].fifosize	= 16;
+		s->port[i].flags	= UPF_SKIP_TEST | UPF_FIXED_TYPE;
+		s->port[i].uartclk	= 3686400;
+		s->port[i].ops		= &uart_clps711x_ops;
+		WARN_ON(uart_add_one_port(&s->uart, &s->port[i]));
+	}
 
 	return 0;
+
+err_out:
+	platform_set_drvdata(pdev, NULL);
+
+	return ret;
 }
 
 static int __devexit uart_clps711x_remove(struct platform_device *pdev)
 {
+	struct clps711x_port *s = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < UART_NR; i++)
-		uart_remove_one_port(&clps711x_reg, &clps711x_ports[i]);
+	for (i = 0; i < UART_CLPS711X_NR; i++)
+		uart_remove_one_port(&s->uart, &s->port[i]);
 
-	uart_unregister_driver(&clps711x_reg);
+	uart_unregister_driver(&s->uart);
+	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.8.6

