From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: clps711x: reworked driver version
Date: Thu, 11 Oct 2012 19:51:29 +0400
Message-ID: <1349970689-24198-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2.mail.ru ([94.100.176.130]:37684 "EHLO smtp2.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754776Ab2JKPvi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Oct 2012 11:51:38 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

This patch presents reworked version of CLPS711X serial driver.
The changes from the old version:
- Driver converted to platform_device.
- Using CPU clock subsystem for getting base UART speed, since CPU can run
  on different speeds.
- Remove console_initcall and make console dynamically. Earler messages in
  this case can be retrieved by using "earlyprintk" kernel option.
- Using resource-managed functions (devm_xx).
- Make all variables dynamically (reduce BSS).
- Cleanup code & comments.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |  594 +++++++++++++++++++----------------------
 1 files changed, 277 insertions(+), 317 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index d0f719f..77b83be 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -10,15 +10,6 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #if defined(CONFIG_SERIAL_CLPS711X_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
@@ -26,172 +17,169 @@
 #endif
 
 #include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/init.h>
-#include <linux/console.h>
-#include <linux/sysrq.h>
-#include <linux/spinlock.h>
 #include <linux/device.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
+#include <linux/console.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
 
 #include <mach/hardware.h>
-#include <asm/irq.h>
-
-#define UART_NR		2
 
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
-
-#define UART_ANY_ERR		(UARTDR_FRMERR | UARTDR_PARERR | UARTDR_OVERR)
-
-#define tx_enabled(port)	((port)->unused[0])
+#define UART_CLPS711X_NAME	"uart-clps711x"
+#define UART_CLPS711X_NR	2
+#define UART_CLPS711X_MAJOR	204
+#define UART_CLPS711X_MINOR	40
+
+#define UBRLCR(port)		((port)->line ? UBRLCR2 : UBRLCR1)
+#define UARTDR(port)		((port)->line ? UARTDR2 : UARTDR1)
+#define SYSFLG(port)		((port)->line ? SYSFLG2 : SYSFLG1)
+#define SYSCON(port)		((port)->line ? SYSCON2 : SYSCON1)
+#define TX_IRQ(port)		((port)->line ? IRQ_UTXINT2 : IRQ_UTXINT1)
+#define RX_IRQ(port)		((port)->line ? IRQ_URXINT2 : IRQ_URXINT1)
+
+struct clps711x_port {
+	struct uart_driver	uart;
+	struct clk		*uart_clk;
+	struct uart_port	port[UART_CLPS711X_NR];
+	int			tx_enabled[UART_CLPS711X_NR];
+#ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
+	struct console		console;
+#endif
+};
 
-static void clps711xuart_stop_tx(struct uart_port *port)
+static void uart_clps711x_stop_tx(struct uart_port *port)
 {
-	if (tx_enabled(port)) {
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
+
+	if (s->tx_enabled[port->line]) {
 		disable_irq(TX_IRQ(port));
-		tx_enabled(port) = 0;
+		s->tx_enabled[port->line] = 0;
 	}
 }
 
-static void clps711xuart_start_tx(struct uart_port *port)
+static void uart_clps711x_start_tx(struct uart_port *port)
 {
-	if (!tx_enabled(port)) {
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
+
+	if (!s->tx_enabled[port->line]) {
 		enable_irq(TX_IRQ(port));
-		tx_enabled(port) = 1;
+		s->tx_enabled[port->line] = 1;
 	}
 }
 
-static void clps711xuart_stop_rx(struct uart_port *port)
+static void uart_clps711x_stop_rx(struct uart_port *port)
 {
 	disable_irq(RX_IRQ(port));
 }
 
-static void clps711xuart_enable_ms(struct uart_port *port)
+static void uart_clps711x_enable_ms(struct uart_port *port)
 {
+	/* Do nothing */
 }
 
-static irqreturn_t clps711xuart_int_rx(int irq, void *dev_id)
+static irqreturn_t uart_clps711x_int_rx(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	struct tty_struct *tty = port->state->port.tty;
+	struct tty_struct *tty = tty_port_tty_get(&port->state->port);
 	unsigned int status, ch, flg;
 
-	status = clps_readl(SYSFLG(port));
-	while (!(status & SYSFLG_URXFE)) {
-		ch = clps_readl(UARTDR(port));
+	if (!tty)
+		return IRQ_HANDLED;
 
-		port->icount.rx++;
+	for (;;) {
+		status = clps_readl(SYSFLG(port));
+		if (status & SYSFLG_URXFE)
+			break;
+
+		ch = clps_readw(UARTDR(port));
+		status = ch & (UARTDR_FRMERR | UARTDR_PARERR | UARTDR_OVERR);
+		ch &= 0xff;
 
+		port->icount.rx++;
 		flg = TTY_NORMAL;
 
-		/*
-		 * Note that the error handling code is
-		 * out of the main execution path
-		 */
-		if (unlikely(ch & UART_ANY_ERR)) {
-			if (ch & UARTDR_PARERR)
+		if (unlikely(status)) {
+			if (status & UARTDR_PARERR)
 				port->icount.parity++;
-			else if (ch & UARTDR_FRMERR)
+			else if (status & UARTDR_FRMERR)
 				port->icount.frame++;
-			if (ch & UARTDR_OVERR)
+			else if (status & UARTDR_OVERR)
 				port->icount.overrun++;
 
-			ch &= port->read_status_mask;
+			status &= port->read_status_mask;
 
-			if (ch & UARTDR_PARERR)
+			if (status & UARTDR_PARERR)
 				flg = TTY_PARITY;
-			else if (ch & UARTDR_FRMERR)
+			else if (status & UARTDR_FRMERR)
 				flg = TTY_FRAME;
-
-#ifdef SUPPORT_SYSRQ
-			port->sysrq = 0;
-#endif
+			else if (status & UARTDR_OVERR)
+				flg = TTY_OVERRUN;
 		}
 
 		if (uart_handle_sysrq_char(port, ch))
-			goto ignore_char;
+			continue;
 
-		/*
-		 * CHECK: does overrun affect the current character?
-		 * ASSUMPTION: it does not.
-		 */
-		uart_insert_char(port, ch, UARTDR_OVERR, ch, flg);
+		if (status & port->ignore_status_mask)
+			continue;
 
-	ignore_char:
-		status = clps_readl(SYSFLG(port));
+		uart_insert_char(port, status, UARTDR_OVERR, ch, flg);
 	}
+
 	tty_flip_buffer_push(tty);
+
+	tty_kref_put(tty);
+
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t clps711xuart_int_tx(int irq, void *dev_id)
+static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 	struct circ_buf *xmit = &port->state->xmit;
-	int count;
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
 
 	if (port->x_char) {
-		clps_writel(port->x_char, UARTDR(port));
+		clps_writew(port->x_char, UARTDR(port));
 		port->icount.tx++;
 		port->x_char = 0;
 		return IRQ_HANDLED;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
-		goto disable_tx_irq;
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		disable_irq_nosync(TX_IRQ(port));
+		s->tx_enabled[port->line] = 0;
+		return IRQ_HANDLED;
+	}
 
-	count = port->fifosize >> 1;
-	do {
-		clps_writel(xmit->buf[xmit->tail], UARTDR(port));
+	while (!uart_circ_empty(xmit)) {
+		clps_writew(xmit->buf[xmit->tail], UARTDR(port));
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
-		if (uart_circ_empty(xmit))
+		if (clps_readl(SYSFLG(port) & SYSFLG_UTXFF))
 			break;
-	} while (--count > 0);
+	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
-	if (uart_circ_empty(xmit)) {
-	disable_tx_irq:
-		disable_irq_nosync(TX_IRQ(port));
-		tx_enabled(port) = 0;
-	}
-
 	return IRQ_HANDLED;
 }
 
-static unsigned int clps711xuart_tx_empty(struct uart_port *port)
+static unsigned int uart_clps711x_tx_empty(struct uart_port *port)
 {
-	unsigned int status = clps_readl(SYSFLG(port));
-	return status & SYSFLG_UBUSY ? 0 : TIOCSER_TEMT;
+	return (clps_readl(SYSFLG(port) & SYSFLG_UBUSY)) ? 0 : TIOCSER_TEMT;
 }
 
-static unsigned int clps711xuart_get_mctrl(struct uart_port *port)
+static unsigned int uart_clps711x_get_mctrl(struct uart_port *port)
 {
-	unsigned int port_addr;
-	unsigned int result = 0;
-	unsigned int status;
+	unsigned int status, result = 0;
 
-	port_addr = SYSFLG(port);
-	if (port_addr == SYSFLG1) {
+	if (port->line == 0) {
 		status = clps_readl(SYSFLG1);
 		if (status & SYSFLG1_DCD)
 			result |= TIOCM_CAR;
@@ -199,104 +187,87 @@ static unsigned int clps711xuart_get_mctrl(struct uart_port *port)
 			result |= TIOCM_DSR;
 		if (status & SYSFLG1_CTS)
 			result |= TIOCM_CTS;
-	}
+	} else
+		result = TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
 
 	return result;
 }
 
-static void
-clps711xuart_set_mctrl_null(struct uart_port *port, unsigned int mctrl)
+static void uart_clps711x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	/* Do nothing */
 }
 
-static void clps711xuart_break_ctl(struct uart_port *port, int break_state)
+static void uart_clps711x_break_ctl(struct uart_port *port, int break_state)
 {
 	unsigned long flags;
 	unsigned int ubrlcr;
 
 	spin_lock_irqsave(&port->lock, flags);
+
 	ubrlcr = clps_readl(UBRLCR(port));
-	if (break_state == -1)
+	if (break_state)
 		ubrlcr |= UBRLCR_BREAK;
 	else
 		ubrlcr &= ~UBRLCR_BREAK;
 	clps_writel(ubrlcr, UBRLCR(port));
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static int clps711xuart_startup(struct uart_port *port)
+static int uart_clps711x_startup(struct uart_port *port)
 {
-	unsigned int syscon;
-	int retval;
-
-	tx_enabled(port) = 1;
-
-	/*
-	 * Allocate the IRQs
-	 */
-	retval = request_irq(TX_IRQ(port), clps711xuart_int_tx, 0,
-			     "clps711xuart_tx", port);
-	if (retval)
-		return retval;
-
-	retval = request_irq(RX_IRQ(port), clps711xuart_int_rx, 0,
-			     "clps711xuart_rx", port);
-	if (retval) {
-		free_irq(TX_IRQ(port), port);
-		return retval;
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
+	int ret;
+
+	s->tx_enabled[port->line] = 1;
+
+	/* Allocate the IRQs */
+	ret = devm_request_irq(port->dev, TX_IRQ(port), uart_clps711x_int_tx,
+			       0, UART_CLPS711X_NAME " TX", port);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(port->dev, RX_IRQ(port), uart_clps711x_int_rx,
+			       0, UART_CLPS711X_NAME " RX", port);
+	if (ret) {
+		devm_free_irq(port->dev, TX_IRQ(port), port);
+		return ret;
 	}
 
-	/*
-	 * enable the port
-	 */
-	syscon = clps_readl(SYSCON(port));
-	syscon |= SYSCON_UARTEN;
-	clps_writel(syscon, SYSCON(port));
+	/* Enable the port */
+	clps_writel(clps_readl(SYSCON(port)) | SYSCON_UARTEN, SYSCON(port));
 
 	return 0;
 }
 
-static void clps711xuart_shutdown(struct uart_port *port)
+static void uart_clps711x_shutdown(struct uart_port *port)
 {
-	unsigned int ubrlcr, syscon;
-
-	/*
-	 * Free the interrupt
-	 */
-	free_irq(TX_IRQ(port), port);	/* TX interrupt */
-	free_irq(RX_IRQ(port), port);	/* RX interrupt */
+	/* Free the interrupts */
+	devm_free_irq(port->dev, TX_IRQ(port), port);	/* TX interrupt */
+	devm_free_irq(port->dev, RX_IRQ(port), port);	/* RX interrupt */
 
-	/*
-	 * disable the port
-	 */
-	syscon = clps_readl(SYSCON(port));
-	syscon &= ~SYSCON_UARTEN;
-	clps_writel(syscon, SYSCON(port));
+	/* Disable the port */
+	clps_writel(clps_readl(SYSCON(port)) & ~SYSCON_UARTEN, SYSCON(port));
 
-	/*
-	 * disable break condition and fifos
-	 */
-	ubrlcr = clps_readl(UBRLCR(port));
-	ubrlcr &= ~(UBRLCR_FIFOEN | UBRLCR_BREAK);
-	clps_writel(ubrlcr, UBRLCR(port));
+	/* Disable break condition */
+	clps_writel(clps_readl(UBRLCR(port)) & ~UBRLCR_BREAK, UBRLCR(port));
 }
 
-static void
-clps711xuart_set_termios(struct uart_port *port, struct ktermios *termios,
-			 struct ktermios *old)
+static void uart_clps711x_set_termios(struct uart_port *port,
+				      struct ktermios *termios,
+				      struct ktermios *old)
 {
 	unsigned int ubrlcr, baud, quot;
 	unsigned long flags;
 
-	/*
-	 * We don't implement CREAD.
-	 */
-	termios->c_cflag |= CREAD;
+	/* Mask termios capabilities we don't support */
+	termios->c_cflag &= ~CMSPAR;
+	termios->c_iflag &= ~(BRKINT | IGNBRK);
 
-	/*
-	 * Ask the core to calculate the divisor for us.
-	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	/* Ask the core to calculate the divisor for us */
+	baud = uart_get_baud_rate(port, termios, old, port->uartclk / 4096,
+						      port->uartclk / 16);
 	quot = uart_get_divisor(port, baud);
 
 	switch (termios->c_cflag & CSIZE) {
@@ -309,160 +280,117 @@ clps711xuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	case CS7:
 		ubrlcr = UBRLCR_WRDLEN7;
 		break;
-	default: // CS8
+	case CS8:
+	default:
 		ubrlcr = UBRLCR_WRDLEN8;
 		break;
 	}
+
 	if (termios->c_cflag & CSTOPB)
 		ubrlcr |= UBRLCR_XSTOP;
+
 	if (termios->c_cflag & PARENB) {
 		ubrlcr |= UBRLCR_PRTEN;
 		if (!(termios->c_cflag & PARODD))
 			ubrlcr |= UBRLCR_EVENPRT;
 	}
-	if (port->fifosize > 1)
-		ubrlcr |= UBRLCR_FIFOEN;
 
-	spin_lock_irqsave(&port->lock, flags);
+	/* Enable FIFO */
+	ubrlcr |= UBRLCR_FIFOEN;
 
-	/*
-	 * Update the per-port timeout.
-	 */
-	uart_update_timeout(port, termios->c_cflag, baud);
+	spin_lock_irqsave(&port->lock, flags);
 
+	/* Set read status mask */
 	port->read_status_mask = UARTDR_OVERR;
 	if (termios->c_iflag & INPCK)
 		port->read_status_mask |= UARTDR_PARERR | UARTDR_FRMERR;
 
-	/*
-	 * Characters to ignore
-	 */
+	/* Set status ignore mask */
 	port->ignore_status_mask = 0;
-	if (termios->c_iflag & IGNPAR)
-		port->ignore_status_mask |= UARTDR_FRMERR | UARTDR_PARERR;
-	if (termios->c_iflag & IGNBRK) {
-		/*
-		 * If we're ignoring parity and break indicators,
-		 * ignore overruns to (for real raw support).
-		 */
-		if (termios->c_iflag & IGNPAR)
-			port->ignore_status_mask |= UARTDR_OVERR;
-	}
+	if (!(termios->c_cflag & CREAD))
+		port->ignore_status_mask |= UARTDR_OVERR | UARTDR_PARERR |
+					    UARTDR_FRMERR;
 
-	quot -= 1;
+	uart_update_timeout(port, termios->c_cflag, baud);
 
-	clps_writel(ubrlcr | quot, UBRLCR(port));
+	clps_writel(ubrlcr | (quot - 1), UBRLCR(port));
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static const char *clps711xuart_type(struct uart_port *port)
+static const char *uart_clps711x_type(struct uart_port *port)
 {
-	return port->type == PORT_CLPS711X ? "CLPS711x" : NULL;
+	return (port->type == PORT_CLPS711X) ? "CLPS711X" : NULL;
 }
 
-/*
- * Configure/autoconfigure the port.
- */
-static void clps711xuart_config_port(struct uart_port *port, int flags)
+static void uart_clps711x_config_port(struct uart_port *port, int flags)
 {
 	if (flags & UART_CONFIG_TYPE)
 		port->type = PORT_CLPS711X;
 }
 
-static void clps711xuart_release_port(struct uart_port *port)
+static void uart_clps711x_release_port(struct uart_port *port)
 {
+	/* Do nothing */
 }
 
-static int clps711xuart_request_port(struct uart_port *port)
+static int uart_clps711x_request_port(struct uart_port *port)
 {
+	/* Do nothing */
 	return 0;
 }
 
-static struct uart_ops clps711x_pops = {
-	.tx_empty	= clps711xuart_tx_empty,
-	.set_mctrl	= clps711xuart_set_mctrl_null,
-	.get_mctrl	= clps711xuart_get_mctrl,
-	.stop_tx	= clps711xuart_stop_tx,
-	.start_tx	= clps711xuart_start_tx,
-	.stop_rx	= clps711xuart_stop_rx,
-	.enable_ms	= clps711xuart_enable_ms,
-	.break_ctl	= clps711xuart_break_ctl,
-	.startup	= clps711xuart_startup,
-	.shutdown	= clps711xuart_shutdown,
-	.set_termios	= clps711xuart_set_termios,
-	.type		= clps711xuart_type,
-	.config_port	= clps711xuart_config_port,
-	.release_port	= clps711xuart_release_port,
-	.request_port	= clps711xuart_request_port,
-};
-
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
+static const struct uart_ops uart_clps711x_ops = {
+	.tx_empty	= uart_clps711x_tx_empty,
+	.set_mctrl	= uart_clps711x_set_mctrl,
+	.get_mctrl	= uart_clps711x_get_mctrl,
+	.stop_tx	= uart_clps711x_stop_tx,
+	.start_tx	= uart_clps711x_start_tx,
+	.stop_rx	= uart_clps711x_stop_rx,
+	.enable_ms	= uart_clps711x_enable_ms,
+	.break_ctl	= uart_clps711x_break_ctl,
+	.startup	= uart_clps711x_startup,
+	.shutdown	= uart_clps711x_shutdown,
+	.set_termios	= uart_clps711x_set_termios,
+	.type		= uart_clps711x_type,
+	.config_port	= uart_clps711x_config_port,
+	.release_port	= uart_clps711x_release_port,
+	.request_port	= uart_clps711x_request_port,
 };
 
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
@@ -487,92 +415,124 @@ clps711xuart_console_get_options(struct uart_port *port, int *baud,
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
+#endif
 
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
+static int __devinit uart_clps711x_probe(struct platform_device *pdev)
 {
-	register_console(&clps711x_console);
-	return 0;
-}
-console_initcall(clps711xuart_console_init);
+	struct clps711x_port *s;
+	int ret, i;
+
+	s = devm_kzalloc(&pdev->dev, sizeof(struct clps711x_port), GFP_KERNEL);
+	if (!s) {
+		dev_err(&pdev->dev, "Error allocating port structure\n");
+		return -ENOMEM;
+	}
+	platform_set_drvdata(pdev, s);
 
-#define CLPS711X_CONSOLE	&clps711x_console
-#else
-#define CLPS711X_CONSOLE	NULL
+	s->uart_clk = devm_clk_get(&pdev->dev, "uart");
+	if (IS_ERR(s->uart_clk)) {
+		dev_err(&pdev->dev, "Can't get UART clocks\n");
+		ret = PTR_ERR(s->uart_clk);
+		goto err_out;
+	}
+
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
 #endif
+	ret = uart_register_driver(&s->uart);
+	if (ret) {
+		dev_err(&pdev->dev, "Registering UART driver failed\n");
+		devm_clk_put(&pdev->dev, s->uart_clk);
+		goto err_out;
+	}
 
-static struct uart_driver clps711x_reg = {
-	.driver_name		= "ttyCL",
-	.dev_name		= "ttyCL",
-	.major			= SERIAL_CLPS711X_MAJOR,
-	.minor			= SERIAL_CLPS711X_MINOR,
-	.nr			= UART_NR,
+	for (i = 0; i < UART_CLPS711X_NR; i++) {
+		s->port[i].line		= i;
+		s->port[i].dev		= &pdev->dev;
+		s->port[i].irq		= TX_IRQ(&s->port[i]);
+		s->port[i].iobase	= SYSCON(&s->port[i]);
+		s->port[i].type		= PORT_CLPS711X;
+		s->port[i].fifosize	= 16;
+		s->port[i].flags	= UPF_SKIP_TEST | UPF_FIXED_TYPE;
+		s->port[i].uartclk	= clk_get_rate(s->uart_clk);
+		s->port[i].ops		= &uart_clps711x_ops;
+		WARN_ON(uart_add_one_port(&s->uart, &s->port[i]));
+	}
 
-	.cons			= CLPS711X_CONSOLE,
-};
+	return 0;
 
-static int __init clps711xuart_init(void)
-{
-	int ret, i;
+err_out:
+	platform_set_drvdata(pdev, NULL);
 
-	printk(KERN_INFO "Serial: CLPS711x driver\n");
+	return ret;
+}
 
-	ret = uart_register_driver(&clps711x_reg);
-	if (ret)
-		return ret;
+static int __devexit uart_clps711x_remove(struct platform_device *pdev)
+{
+	struct clps711x_port *s = platform_get_drvdata(pdev);
+	int i;
 
-	for (i = 0; i < UART_NR; i++)
-		uart_add_one_port(&clps711x_reg, &clps711x_ports[i]);
+	for (i = 0; i < UART_CLPS711X_NR; i++)
+		uart_remove_one_port(&s->uart, &s->port[i]);
+
+	devm_clk_put(&pdev->dev, s->uart_clk);
+	uart_unregister_driver(&s->uart);
+	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
 
-static void __exit clps711xuart_exit(void)
-{
-	int i;
+static struct platform_driver clps711x_uart_driver = {
+	.driver = {
+		.name	= UART_CLPS711X_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe	= uart_clps711x_probe,
+	.remove	= __devexit_p(uart_clps711x_remove),
+};
+module_platform_driver(clps711x_uart_driver);
 
-	for (i = 0; i < UART_NR; i++)
-		uart_remove_one_port(&clps711x_reg, &clps711x_ports[i]);
+static struct platform_device clps711x_uart_device = {
+	.name	= UART_CLPS711X_NAME,
+};
 
-	uart_unregister_driver(&clps711x_reg);
+static int __init uart_clps711x_init(void)
+{
+	return platform_device_register(&clps711x_uart_device);
 }
+module_init(uart_clps711x_init);
 
-module_init(clps711xuart_init);
-module_exit(clps711xuart_exit);
+static void __exit uart_clps711x_exit(void)
+{
+	platform_device_unregister(&clps711x_uart_device);
+}
+module_exit(uart_clps711x_exit);
 
 MODULE_AUTHOR("Deep Blue Solutions Ltd");
-MODULE_DESCRIPTION("CLPS-711x generic serial driver");
+MODULE_DESCRIPTION("CLPS711X serial driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_CHARDEV(SERIAL_CLPS711X_MAJOR, SERIAL_CLPS711X_MINOR);
-- 
1.7.8.6

