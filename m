From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] serial: clps711x: Driver refactor
Date: Wed, 11 Dec 2013 19:50:50 +0400
Message-ID: <1386777050-24792-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp44.i.mail.ru ([94.100.177.104]:44175 "EHLO smtp44.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070Ab3LKPvG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Dec 2013 10:51:06 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Alexander Shiyan <shc_work@mail.ru>

This is a complex patch for refactoring CLPS711X serial driver.
Major changes:
- Eliminate <mach/hardware.h> usage.
- Devicetree support.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/devices.c |  21 ++
 drivers/tty/serial/clps711x.c    | 448 ++++++++++++++++++++++-----------------
 2 files changed, 275 insertions(+), 194 deletions(-)

diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
index fb77d14..2001488 100644
--- a/arch/arm/mach-clps711x/devices.c
+++ b/arch/arm/mach-clps711x/devices.c
@@ -61,8 +61,29 @@ static void __init clps711x_add_syscon(void)
 						&clps711x_syscon_res[i], 1);
 }
 
+static const struct resource clps711x_uart1_res[] __initconst = {
+	DEFINE_RES_MEM(CLPS711X_PHYS_BASE + UARTDR1, SZ_128),
+	DEFINE_RES_IRQ(IRQ_UTXINT1),
+	DEFINE_RES_IRQ(IRQ_URXINT1),
+};
+
+static const struct resource clps711x_uart2_res[] __initconst = {
+	DEFINE_RES_MEM(CLPS711X_PHYS_BASE + UARTDR2, SZ_128),
+	DEFINE_RES_IRQ(IRQ_UTXINT2),
+	DEFINE_RES_IRQ(IRQ_URXINT2),
+};
+
+static void __init clps711x_add_uart(void)
+{
+	platform_device_register_simple("clps711x-uart", 0, clps711x_uart1_res,
+					ARRAY_SIZE(clps711x_uart1_res));
+	platform_device_register_simple("clps711x-uart", 1, clps711x_uart2_res,
+					ARRAY_SIZE(clps711x_uart2_res));
+};
+
 void __init clps711x_devices_init(void)
 {
 	clps711x_add_gpio();
 	clps711x_add_syscon();
+	clps711x_add_uart();
 }
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 8d0b994..4f59f1c 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -21,44 +21,66 @@
 #include <linux/console.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
-#include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/io.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/ioport.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 
-#include <mach/hardware.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/clps711x.h>
 
-#define UART_CLPS711X_NAME	"uart-clps711x"
+#define UART_CLPS711X_DEVNAME	"ttyCL"
 #define UART_CLPS711X_NR	2
 #define UART_CLPS711X_MAJOR	204
 #define UART_CLPS711X_MINOR	40
 
-#define UBRLCR(port)		((port)->line ? UBRLCR2 : UBRLCR1)
-#define UARTDR(port)		((port)->line ? UARTDR2 : UARTDR1)
-#define SYSFLG(port)		((port)->line ? SYSFLG2 : SYSFLG1)
-#define SYSCON(port)		((port)->line ? SYSCON2 : SYSCON1)
-#define TX_IRQ(port)		((port)->line ? IRQ_UTXINT2 : IRQ_UTXINT1)
-#define RX_IRQ(port)		((port)->line ? IRQ_URXINT2 : IRQ_URXINT1)
+#define UARTDR_OFFSET		(0x00)
+#define UBRLCR_OFFSET		(0x40)
+
+#define UARTDR_FRMERR		(1 << 8)
+#define UARTDR_PARERR		(1 << 9)
+#define UARTDR_OVERR		(1 << 10)
+
+#define UBRLCR_BAUD_MASK	((1 << 12) - 1)
+#define UBRLCR_BREAK		(1 << 12)
+#define UBRLCR_PRTEN		(1 << 13)
+#define UBRLCR_EVENPRT		(1 << 14)
+#define UBRLCR_XSTOP		(1 << 15)
+#define UBRLCR_FIFOEN		(1 << 16)
+#define UBRLCR_WRDLEN5		(0 << 17)
+#define UBRLCR_WRDLEN6		(1 << 17)
+#define UBRLCR_WRDLEN7		(2 << 17)
+#define UBRLCR_WRDLEN8		(3 << 17)
+#define UBRLCR_WRDLEN_MASK	(3 << 17)
 
 struct clps711x_port {
-	struct uart_driver	uart;
-	struct clk		*uart_clk;
-	struct uart_port	port[UART_CLPS711X_NR];
-	int			tx_enabled[UART_CLPS711X_NR];
-#ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
-	struct console		console;
-#endif
+	struct uart_port	port;
+	unsigned int		tx_enabled;
+	int			rx_irq;
+	struct regmap		*syscon;
+	bool			use_ms;
+};
+
+static struct uart_driver clps711x_uart = {
+	.owner		= THIS_MODULE,
+	.driver_name	= UART_CLPS711X_DEVNAME,
+	.dev_name	= UART_CLPS711X_DEVNAME,
+	.major		= UART_CLPS711X_MAJOR,
+	.minor		= UART_CLPS711X_MINOR,
+	.nr		= UART_CLPS711X_NR,
 };
 
 static void uart_clps711x_stop_tx(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 
-	if (s->tx_enabled[port->line]) {
-		disable_irq(TX_IRQ(port));
-		s->tx_enabled[port->line] = 0;
+	if (s->tx_enabled) {
+		disable_irq(port->irq);
+		s->tx_enabled = 0;
 	}
 }
 
@@ -66,33 +88,26 @@ static void uart_clps711x_start_tx(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 
-	if (!s->tx_enabled[port->line]) {
-		enable_irq(TX_IRQ(port));
-		s->tx_enabled[port->line] = 1;
+	if (!s->tx_enabled) {
+		s->tx_enabled = 1;
+		enable_irq(port->irq);
 	}
 }
 
-static void uart_clps711x_stop_rx(struct uart_port *port)
-{
-	disable_irq(RX_IRQ(port));
-}
-
-static void uart_clps711x_enable_ms(struct uart_port *port)
-{
-	/* Do nothing */
-}
-
 static irqreturn_t uart_clps711x_int_rx(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	unsigned int status, ch, flg;
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
+	unsigned int status, flg;
+	u32 sysflg;
+	u16 ch;
 
 	for (;;) {
-		status = clps_readl(SYSFLG(port));
-		if (status & SYSFLG_URXFE)
+		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
+		if (sysflg & SYSFLG_URXFE)
 			break;
 
-		ch = clps_readw(UARTDR(port));
+		ch = readw_relaxed(port->membase + UARTDR_OFFSET);
 		status = ch & (UARTDR_FRMERR | UARTDR_PARERR | UARTDR_OVERR);
 		ch &= 0xff;
 
@@ -136,25 +151,31 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 	struct circ_buf *xmit = &port->state->xmit;
+	u32 sysflg;
 
 	if (port->x_char) {
-		clps_writew(port->x_char, UARTDR(port));
+		writew_relaxed(port->x_char, port->membase + UARTDR_OFFSET);
 		port->icount.tx++;
 		port->x_char = 0;
 		return IRQ_HANDLED;
 	}
 
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		disable_irq_nosync(TX_IRQ(port));
-		s->tx_enabled[port->line] = 0;
+		if (s->tx_enabled) {
+			disable_irq_nosync(port->irq);
+			s->tx_enabled = 0;
+		}
 		return IRQ_HANDLED;
 	}
 
 	while (!uart_circ_empty(xmit)) {
-		clps_writew(xmit->buf[xmit->tail], UARTDR(port));
+		writew_relaxed(xmit->buf[xmit->tail],
+			       port->membase + UARTDR_OFFSET);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
-		if (clps_readl(SYSFLG(port) & SYSFLG_UTXFF))
+
+		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
+		if (sysflg & SYSFLG_UTXFF)
 			break;
 	}
 
@@ -166,20 +187,27 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 
 static unsigned int uart_clps711x_tx_empty(struct uart_port *port)
 {
-	return (clps_readl(SYSFLG(port) & SYSFLG_UBUSY)) ? 0 : TIOCSER_TEMT;
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
+	u32 sysflg;
+
+	regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
+
+	return (sysflg & SYSFLG_UBUSY) ? 0 : TIOCSER_TEMT;
 }
 
 static unsigned int uart_clps711x_get_mctrl(struct uart_port *port)
 {
-	unsigned int status, result = 0;
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
+	unsigned int result = 0;
+	u32 sysflg;
 
-	if (port->line == 0) {
-		status = clps_readl(SYSFLG1);
-		if (status & SYSFLG1_DCD)
+	if (s->use_ms) {
+		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
+		if (sysflg & SYSFLG1_DCD)
 			result |= TIOCM_CAR;
-		if (status & SYSFLG1_DSR)
+		if (sysflg & SYSFLG1_DSR)
 			result |= TIOCM_DSR;
-		if (status & SYSFLG1_CTS)
+		if (sysflg & SYSFLG1_CTS)
 			result |= TIOCM_CTS;
 	} else
 		result = TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
@@ -194,65 +222,43 @@ static void uart_clps711x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void uart_clps711x_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long flags;
 	unsigned int ubrlcr;
 
-	spin_lock_irqsave(&port->lock, flags);
-
-	ubrlcr = clps_readl(UBRLCR(port));
+	ubrlcr = readl_relaxed(port->membase + UBRLCR_OFFSET);
 	if (break_state)
 		ubrlcr |= UBRLCR_BREAK;
 	else
 		ubrlcr &= ~UBRLCR_BREAK;
-	clps_writel(ubrlcr, UBRLCR(port));
-
-	spin_unlock_irqrestore(&port->lock, flags);
+	writel_relaxed(ubrlcr, port->membase + UBRLCR_OFFSET);
 }
 
 static int uart_clps711x_startup(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
-	int ret;
-
-	s->tx_enabled[port->line] = 1;
-	/* Allocate the IRQs */
-	ret = devm_request_irq(port->dev, TX_IRQ(port), uart_clps711x_int_tx,
-			       0, UART_CLPS711X_NAME " TX", port);
-	if (ret)
-		return ret;
-
-	ret = devm_request_irq(port->dev, RX_IRQ(port), uart_clps711x_int_rx,
-			       0, UART_CLPS711X_NAME " RX", port);
-	if (ret) {
-		devm_free_irq(port->dev, TX_IRQ(port), port);
-		return ret;
-	}
 
 	/* Disable break */
-	clps_writel(clps_readl(UBRLCR(port)) & ~UBRLCR_BREAK, UBRLCR(port));
+	writel_relaxed(readl_relaxed(port->membase + UBRLCR_OFFSET) &
+		       ~UBRLCR_BREAK, port->membase + UBRLCR_OFFSET);
 
 	/* Enable the port */
-	clps_writel(clps_readl(SYSCON(port)) | SYSCON_UARTEN, SYSCON(port));
-
-	return 0;
+	return regmap_update_bits(s->syscon, SYSCON_OFFSET,
+				  SYSCON_UARTEN, SYSCON_UARTEN);
 }
 
 static void uart_clps711x_shutdown(struct uart_port *port)
 {
-	/* Free the interrupts */
-	devm_free_irq(port->dev, TX_IRQ(port), port);
-	devm_free_irq(port->dev, RX_IRQ(port), port);
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
 
 	/* Disable the port */
-	clps_writel(clps_readl(SYSCON(port)) & ~SYSCON_UARTEN, SYSCON(port));
+	regmap_update_bits(s->syscon, SYSCON_OFFSET, SYSCON_UARTEN, 0);
 }
 
 static void uart_clps711x_set_termios(struct uart_port *port,
 				      struct ktermios *termios,
 				      struct ktermios *old)
 {
-	unsigned int ubrlcr, baud, quot;
-	unsigned long flags;
+	u32 ubrlcr;
+	unsigned int baud, quot;
 
 	/* Mask termios capabilities we don't support */
 	termios->c_cflag &= ~CMSPAR;
@@ -291,8 +297,6 @@ static void uart_clps711x_set_termios(struct uart_port *port,
 	/* Enable FIFO */
 	ubrlcr |= UBRLCR_FIFOEN;
 
-	spin_lock_irqsave(&port->lock, flags);
-
 	/* Set read status mask */
 	port->read_status_mask = UARTDR_OVERR;
 	if (termios->c_iflag & INPCK)
@@ -306,9 +310,7 @@ static void uart_clps711x_set_termios(struct uart_port *port,
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	clps_writel(ubrlcr | (quot - 1), UBRLCR(port));
-
-	spin_unlock_irqrestore(&port->lock, flags);
+	writel_relaxed(ubrlcr | (quot - 1), port->membase + UBRLCR_OFFSET);
 }
 
 static const char *uart_clps711x_type(struct uart_port *port)
@@ -322,14 +324,12 @@ static void uart_clps711x_config_port(struct uart_port *port, int flags)
 		port->type = PORT_CLPS711X;
 }
 
-static void uart_clps711x_release_port(struct uart_port *port)
+static void uart_clps711x_nop_void(struct uart_port *port)
 {
-	/* Do nothing */
 }
 
-static int uart_clps711x_request_port(struct uart_port *port)
+static int uart_clps711x_nop_int(struct uart_port *port)
 {
-	/* Do nothing */
 	return 0;
 }
 
@@ -339,181 +339,241 @@ static const struct uart_ops uart_clps711x_ops = {
 	.get_mctrl	= uart_clps711x_get_mctrl,
 	.stop_tx	= uart_clps711x_stop_tx,
 	.start_tx	= uart_clps711x_start_tx,
-	.stop_rx	= uart_clps711x_stop_rx,
-	.enable_ms	= uart_clps711x_enable_ms,
+	.stop_rx	= uart_clps711x_nop_void,
+	.enable_ms	= uart_clps711x_nop_void,
 	.break_ctl	= uart_clps711x_break_ctl,
 	.startup	= uart_clps711x_startup,
 	.shutdown	= uart_clps711x_shutdown,
 	.set_termios	= uart_clps711x_set_termios,
 	.type		= uart_clps711x_type,
 	.config_port	= uart_clps711x_config_port,
-	.release_port	= uart_clps711x_release_port,
-	.request_port	= uart_clps711x_request_port,
+	.release_port	= uart_clps711x_nop_void,
+	.request_port	= uart_clps711x_nop_int,
 };
 
 #ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
 static void uart_clps711x_console_putchar(struct uart_port *port, int ch)
 {
-	while (clps_readl(SYSFLG(port)) & SYSFLG_UTXFF)
-		barrier();
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
+	u32 sysflg;
+
+	do {
+		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
+	} while (sysflg & SYSFLG_UTXFF);
 
-	clps_writew(ch, UARTDR(port));
+	writew_relaxed(ch, port->membase + UARTDR_OFFSET);
 }
 
 static void uart_clps711x_console_write(struct console *co, const char *c,
 					unsigned n)
 {
-	struct clps711x_port *s = (struct clps711x_port *)co->data;
-	struct uart_port *port = &s->port[co->index];
-	u32 syscon;
-
-	/* Ensure that the port is enabled */
-	syscon = clps_readl(SYSCON(port));
-	clps_writel(syscon | SYSCON_UARTEN, SYSCON(port));
+	struct uart_port *port = clps711x_uart.state[co->index].uart_port;
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
+	u32 sysflg;
 
 	uart_console_write(port, c, n, uart_clps711x_console_putchar);
 
 	/* Wait for transmitter to become empty */
-	while (clps_readl(SYSFLG(port)) & SYSFLG_UBUSY)
-		barrier();
-
-	/* Restore the uart state */
-	clps_writel(syscon, SYSCON(port));
+	do {
+		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
+	} while (sysflg & SYSFLG_UBUSY);
 }
 
-static void uart_clps711x_console_get_options(struct uart_port *port,
-					      int *baud, int *parity,
-					      int *bits)
+static int uart_clps711x_console_setup(struct console *co, char *options)
 {
-	if (clps_readl(SYSCON(port)) & SYSCON_UARTEN) {
-		unsigned int ubrlcr, quot;
+	int baud = 38400, bits = 8, parity = 'n', flow = 'n';
+	int ret, index = co->index;
+	struct clps711x_port *s;
+	struct uart_port *port;
+	u32 ubrlcr, syscon;
+	unsigned int quot;
 
-		ubrlcr = clps_readl(UBRLCR(port));
+	if (index < 0 || index >= UART_CLPS711X_NR)
+		return -EINVAL;
 
-		*parity = 'n';
-		if (ubrlcr & UBRLCR_PRTEN) {
-			if (ubrlcr & UBRLCR_EVENPRT)
-				*parity = 'e';
-			else
-				*parity = 'o';
-		}
+	port = clps711x_uart.state[index].uart_port;
+	if (!port)
+		return -ENODEV;
 
-		if ((ubrlcr & UBRLCR_WRDLEN_MASK) == UBRLCR_WRDLEN7)
-			*bits = 7;
-		else
-			*bits = 8;
+	s = dev_get_drvdata(port->dev);
 
-		quot = ubrlcr & UBRLCR_BAUD_MASK;
-		*baud = port->uartclk / (16 * (quot + 1));
-	}
-}
+	if (!options) {
+		regmap_read(s->syscon, SYSCON_OFFSET, &syscon);
+		if (syscon & SYSCON_UARTEN) {
+			ubrlcr = readl_relaxed(port->membase + UBRLCR_OFFSET);
 
-static int uart_clps711x_console_setup(struct console *co, char *options)
-{
-	int baud = 38400, bits = 8, parity = 'n', flow = 'n';
-	struct clps711x_port *s = (struct clps711x_port *)co->data;
-	struct uart_port *port = &s->port[(co->index > 0) ? co->index : 0];
+			if (ubrlcr & UBRLCR_PRTEN) {
+				if (ubrlcr & UBRLCR_EVENPRT)
+					parity = 'e';
+				else
+					parity = 'o';
+			}
 
-	if (options)
+			if ((ubrlcr & UBRLCR_WRDLEN_MASK) == UBRLCR_WRDLEN7)
+				bits = 7;
+
+			quot = ubrlcr & UBRLCR_BAUD_MASK;
+			baud = port->uartclk / (16 * (quot + 1));
+		}
+	} else
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-	else
-		uart_clps711x_console_get_options(port, &baud, &parity, &bits);
 
-	return uart_set_options(port, co, baud, parity, bits, flow);
+	ret = uart_set_options(port, co, baud, parity, bits, flow);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(s->syscon, SYSCON_OFFSET,
+				  SYSCON_UARTEN, SYSCON_UARTEN);
 }
+
+static struct console clps711x_console = {
+	.name	= UART_CLPS711X_DEVNAME,
+	.device	= uart_console_device,
+	.write	= uart_clps711x_console_write,
+	.setup	= uart_clps711x_console_setup,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
 #endif
 
 static int uart_clps711x_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
+	int ret, index = np ? of_alias_get_id(np, "serial") : pdev->id;
 	struct clps711x_port *s;
-	int ret, i;
+	struct resource *res;
+	struct clk *uart_clk;
 
-	s = devm_kzalloc(&pdev->dev, sizeof(struct clps711x_port), GFP_KERNEL);
-	if (!s) {
-		dev_err(&pdev->dev, "Error allocating port structure\n");
+	if (index < 0 || index >= UART_CLPS711X_NR)
+		return -EINVAL;
+
+	s = devm_kzalloc(&pdev->dev, sizeof(*s), GFP_KERNEL);
+	if (!s)
 		return -ENOMEM;
+
+	uart_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(uart_clk))
+		return PTR_ERR(uart_clk);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	s->port.membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(s->port.membase))
+		return PTR_ERR(s->port.membase);
+
+	s->port.irq = platform_get_irq(pdev, 0);
+	if (IS_ERR_VALUE(s->port.irq))
+		return s->port.irq;
+
+	s->rx_irq = platform_get_irq(pdev, 1);
+	if (IS_ERR_VALUE(s->rx_irq))
+		return s->rx_irq;
+
+	if (!np) {
+		char syscon_name[9];
+
+		sprintf(syscon_name, "syscon.%i", index + 1);
+		s->syscon = syscon_regmap_lookup_by_pdevname(syscon_name);
+		if (IS_ERR(s->syscon))
+			return PTR_ERR(s->syscon);
+
+		s->use_ms = !index;
+	} else {
+		s->syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
+		if (IS_ERR(s->syscon))
+			return PTR_ERR(s->syscon);
+
+		if (!index) {
+			bool use_irda;
+
+			s->use_ms = of_property_read_bool(np, "uart-use-ms");
+			use_irda = of_property_read_bool(np, "uart-use-irda");
+			regmap_update_bits(s->syscon, SYSCON_OFFSET,
+					   SYSCON1_SIREN,
+					   use_irda ? SYSCON1_SIREN : 0);
+		}
 	}
+
+	s->port.line		= index;
+	s->port.dev		= &pdev->dev;
+	s->port.iotype		= UPIO_MEM32;
+	s->port.mapbase		= res->start;
+	s->port.type		= PORT_CLPS711X;
+	s->port.fifosize	= 16;
+	s->port.flags		= UPF_SKIP_TEST | UPF_FIXED_TYPE;
+	s->port.uartclk		= clk_get_rate(uart_clk);
+	s->port.ops		= &uart_clps711x_ops;
+
 	platform_set_drvdata(pdev, s);
 
-	s->uart_clk = devm_clk_get(&pdev->dev, "uart");
-	if (IS_ERR(s->uart_clk)) {
-		dev_err(&pdev->dev, "Can't get UART clocks\n");
-		return PTR_ERR(s->uart_clk);
-	}
+	ret = uart_add_one_port(&clps711x_uart, &s->port);
+	if (ret)
+		return ret;
 
-	s->uart.owner		= THIS_MODULE;
-	s->uart.dev_name	= "ttyCL";
-	s->uart.major		= UART_CLPS711X_MAJOR;
-	s->uart.minor		= UART_CLPS711X_MINOR;
-	s->uart.nr		= UART_CLPS711X_NR;
-#ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
-	s->uart.cons		= &s->console;
-	s->uart.cons->device	= uart_console_device;
-	s->uart.cons->write	= uart_clps711x_console_write;
-	s->uart.cons->setup	= uart_clps711x_console_setup;
-	s->uart.cons->flags	= CON_PRINTBUFFER;
-	s->uart.cons->index	= -1;
-	s->uart.cons->data	= s;
-	strcpy(s->uart.cons->name, "ttyCL");
-#endif
-	ret = uart_register_driver(&s->uart);
+	/* Disable port */
+	if (!uart_console(&s->port))
+		regmap_update_bits(s->syscon, SYSCON_OFFSET, SYSCON_UARTEN, 0);
+
+	s->tx_enabled = 1;
+
+	ret = devm_request_irq(&pdev->dev, s->port.irq, uart_clps711x_int_tx, 0,
+			       dev_name(&pdev->dev), &s->port);
 	if (ret) {
-		dev_err(&pdev->dev, "Registering UART driver failed\n");
+		uart_remove_one_port(&clps711x_uart, &s->port);
 		return ret;
 	}
 
-	for (i = 0; i < UART_CLPS711X_NR; i++) {
-		s->port[i].line		= i;
-		s->port[i].dev		= &pdev->dev;
-		s->port[i].irq		= TX_IRQ(&s->port[i]);
-		s->port[i].iobase	= SYSCON(&s->port[i]);
-		s->port[i].type		= PORT_CLPS711X;
-		s->port[i].fifosize	= 16;
-		s->port[i].flags	= UPF_SKIP_TEST | UPF_FIXED_TYPE;
-		s->port[i].uartclk	= clk_get_rate(s->uart_clk);
-		s->port[i].ops		= &uart_clps711x_ops;
-		WARN_ON(uart_add_one_port(&s->uart, &s->port[i]));
-	}
+	ret = devm_request_irq(&pdev->dev, s->rx_irq, uart_clps711x_int_rx, 0,
+			       dev_name(&pdev->dev), &s->port);
+	if (ret)
+		uart_remove_one_port(&clps711x_uart, &s->port);
 
-	return 0;
+	return ret;
 }
 
 static int uart_clps711x_remove(struct platform_device *pdev)
 {
 	struct clps711x_port *s = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < UART_CLPS711X_NR; i++)
-		uart_remove_one_port(&s->uart, &s->port[i]);
-
-	uart_unregister_driver(&s->uart);
 
-	return 0;
+	return uart_remove_one_port(&clps711x_uart, &s->port);
 }
 
-static struct platform_driver clps711x_uart_driver = {
+static const struct of_device_id __maybe_unused clps711x_uart_dt_ids[] = {
+	{ .compatible = "cirrus,clps711x-uart", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clps711x_uart_dt_ids);
+
+static struct platform_driver clps711x_uart_platform = {
 	.driver = {
-		.name	= UART_CLPS711X_NAME,
-		.owner	= THIS_MODULE,
+		.name		= "clps711x-uart",
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(clps711x_uart_dt_ids),
 	},
 	.probe	= uart_clps711x_probe,
 	.remove	= uart_clps711x_remove,
 };
-module_platform_driver(clps711x_uart_driver);
-
-static struct platform_device clps711x_uart_device = {
-	.name	= UART_CLPS711X_NAME,
-};
 
 static int __init uart_clps711x_init(void)
 {
-	return platform_device_register(&clps711x_uart_device);
+	int ret;
+
+#ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
+	clps711x_uart.cons = &clps711x_console;
+	clps711x_console.data = &clps711x_uart;
+#endif
+
+	ret = uart_register_driver(&clps711x_uart);
+	if (ret)
+		return ret;
+
+	return platform_driver_register(&clps711x_uart_platform);
 }
 module_init(uart_clps711x_init);
 
 static void __exit uart_clps711x_exit(void)
 {
-	platform_device_unregister(&clps711x_uart_device);
+	platform_driver_unregister(&clps711x_uart_platform);
+	uart_unregister_driver(&clps711x_uart);
 }
 module_exit(uart_clps711x_exit);
 
-- 
1.8.3.2

