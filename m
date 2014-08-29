From: Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH 1/1] drivers: introduce ARM SBSA generic UART driver
Date: Fri, 29 Aug 2014 17:13:23 +0100
Message-ID: <1409328803-1953-2-git-send-email-andre.przywara@arm.com>
References: <1409328803-1953-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55587 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753256AbaH2QOB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Aug 2014 12:14:01 -0400
In-Reply-To: <1409328803-1953-1-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

The ARM Server Base System Architecture (SBSA) describes a generic
UART which all compliant level 1 systems should implement. This is
actually a PL011 subset, so a full PL011 implementation will satisfy
this requirement.
However if a system does not have a PL011, a very stripped down
implementation complying to the SBSA defined specification will
suffice. The Linux PL011 driver is not guaranteed to drive this
limited device (and indeed the fast model implentation hangs the
kernel if driven by the PL011 driver).
So introduce a new driver just implementing the part specified by the
SBSA (which lacks DMA, the modem control signals and many of the
registers including baud rate control). This driver has been derived
by the actual PL011 one, removing all unnecessary code.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/serial/arm_sbsa_uart.txt   |    6 +
 drivers/tty/serial/Kconfig                         |   28 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/sbsa_uart.c                     |  793 ++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |    1 +
 5 files changed, 829 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
 create mode 100644 drivers/tty/serial/sbsa_uart.c

diff --git a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
new file mode 100644
index 0000000..8e2c5d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
@@ -0,0 +1,6 @@
+* ARM SBSA defined generic UART
+
+Required properties:
+- compatible: must be "arm,sbsa-uart"
+- reg: exactly one register range
+- interrupts: exactly one interrupt specifier
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 26cec64..faecfad 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -45,6 +45,34 @@ config SERIAL_AMBA_PL010_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
+config SERIAL_SBSA_UART
+	tristate "ARM SBSA UART serial port support"
+	select SERIAL_CORE
+	help
+	  This selects the UART defined in the ARM(R) Server Base System
+	  Architecture (SBSA).
+	  It is a true subset of the ARM(R) PL011 UART and this driver can
+	  also drive those full featured UARTs.
+	  To match the SBSA, this driver will not support initialization, DMA,
+	  baudrate control and modem control lines.
+
+config SERIAL_SBSA_UART_CONSOLE
+	bool "Support for console on ARM SBSA UART serial port"
+	depends on SERIAL_SBSA_UART=y
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	---help---
+	  Say Y here if you wish to use an ARM SBSA UART as the system
+	  console (the system console is the device which receives all kernel
+	  messages and warnings and which allows logins in single user mode).
+
+	  Even if you say Y here, the currently visible framebuffer console
+	  (/dev/tty0) will still be used as the system console by default, but
+	  you can alter that using a kernel command line option such as
+	  "console=ttyAMA0". (Try "man bootparam" or see the documentation of
+	  your boot loader (lilo or loadlin) about how to pass options to the
+	  kernel at boot time.)
+
 config SERIAL_AMBA_PL011
 	tristate "ARM AMBA PL011 serial port support"
 	depends on ARM_AMBA
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 0080cc3..2e560e9 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_SERIAL_8250) += 8250/
 
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
+obj-$(CONFIG_SERIAL_SBSA_UART) += sbsa_uart.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
 obj-$(CONFIG_SERIAL_PXA) += pxa.o
 obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
diff --git a/drivers/tty/serial/sbsa_uart.c b/drivers/tty/serial/sbsa_uart.c
new file mode 100644
index 0000000..941a305
--- /dev/null
+++ b/drivers/tty/serial/sbsa_uart.c
@@ -0,0 +1,793 @@
+/*
+ *  Driver for ARM SBSA specified serial ports (stripped down PL011)
+ *
+ *  Based on drivers/tty/char/amba-pl011.c
+ *
+ *  Copyright 2014 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * This is a driver implementing the ARM SBSA specified generic UART,
+ * which is a subset of the PL011 UART, but lacking:
+ *  - DMA
+ *  - hardware flow control
+ *  - modem control
+ *  - IrDA SIR
+ *  - word lengths other than 8 bits
+ *  - baudrate settings
+ */
+
+
+#if defined(CONFIG_SERIAL_SBSA_UART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/sysrq.h>
+#include <linux/device.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/amba/serial.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/sizes.h>
+#include <linux/io.h>
+
+#define UART_NR			14
+
+#define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
+#define UART_DUMMY_DR_RX	(1 << 16)
+
+/*
+ * Reads up to 256 characters from the FIFO or until it's empty and
+ * inserts them into the TTY layer. Returns the number of characters
+ * read from the FIFO.
+ */
+static int sbsa_uart_fifo_to_tty(struct uart_port *port)
+{
+	u16 status, ch;
+	unsigned int flag, max_count = 256;
+	int fifotaken = 0;
+
+	while (max_count--) {
+		status = readw(port->membase + UART01x_FR);
+		if (status & UART01x_FR_RXFE)
+			break;
+
+		/* Take chars from the FIFO and update status */
+		ch = readw(port->membase + UART01x_DR) | UART_DUMMY_DR_RX;
+		flag = TTY_NORMAL;
+		port->icount.rx++;
+		fifotaken++;
+
+		if (unlikely(ch & UART_DR_ERROR)) {
+			if (ch & UART011_DR_BE) {
+				ch &= ~(UART011_DR_FE | UART011_DR_PE);
+				port->icount.brk++;
+				if (uart_handle_break(port))
+					continue;
+			} else if (ch & UART011_DR_PE)
+				port->icount.parity++;
+			else if (ch & UART011_DR_FE)
+				port->icount.frame++;
+			if (ch & UART011_DR_OE)
+				port->icount.overrun++;
+
+			ch &= port->read_status_mask;
+
+			if (ch & UART011_DR_BE)
+				flag = TTY_BREAK;
+			else if (ch & UART011_DR_PE)
+				flag = TTY_PARITY;
+			else if (ch & UART011_DR_FE)
+				flag = TTY_FRAME;
+		}
+
+		if (uart_handle_sysrq_char(port, ch & 255))
+			continue;
+
+		uart_insert_char(port, ch, UART011_DR_OE, ch, flag);
+	}
+
+	return fifotaken;
+}
+
+static void sbsa_uart_mask_irq(struct uart_port *port, u16 irqclr, u16 irqset)
+{
+	u16 imsc;
+
+	imsc = readw(port->membase + UART011_IMSC);
+	imsc = (imsc & ~irqclr) | irqset;
+	writew(imsc, port->membase + UART011_IMSC);
+}
+
+static void sbsa_uart_stop_tx(struct uart_port *port)
+{
+	sbsa_uart_mask_irq(port, UART011_TXIM, 0);
+}
+
+static void sbsa_uart_start_tx(struct uart_port *port)
+{
+	sbsa_uart_mask_irq(port, 0, UART011_TXIM);
+}
+
+static void sbsa_uart_stop_rx(struct uart_port *port)
+{
+	sbsa_uart_mask_irq(port, UART011_RXIM | UART011_RTIM, 0);
+}
+
+static void sbsa_uart_rx_chars(struct uart_port *port)
+__releases(&uap->port.lock)
+__acquires(&uap->port.lock)
+{
+	sbsa_uart_fifo_to_tty(port);
+
+	spin_unlock(&port->lock);
+	tty_flip_buffer_push(&port->state->port);
+	spin_lock(&port->lock);
+}
+
+static void sbsa_uart_tx_chars(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	int count;
+
+	if (port->x_char) {
+		writew(port->x_char, port->membase + UART01x_DR);
+		port->icount.tx++;
+		port->x_char = 0;
+		return;
+	}
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		sbsa_uart_stop_tx(port);
+		return;
+	}
+
+	count = port->fifosize >> 1;
+	do {
+		writew(xmit->buf[xmit->tail], port->membase + UART01x_DR);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+		if (uart_circ_empty(xmit))
+			break;
+	} while (--count > 0);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit))
+		sbsa_uart_stop_tx(port);
+}
+
+static irqreturn_t sbsa_uart_int(int irq, void *dev_id)
+{
+	struct uart_port *port = dev_id;
+	unsigned long flags;
+	unsigned int status, pass_counter = 32;
+	int handled = 0;
+
+	spin_lock_irqsave(&port->lock, flags);
+	status = readw(port->membase + UART011_RIS);
+	status &= readw(port->membase + UART011_IMSC);
+	if (status) {
+		do {
+			writew(status & ~(UART011_TXIS|UART011_RTIS|
+					  UART011_RXIS),
+			       port->membase + UART011_ICR);
+
+			if (status & (UART011_RTIS|UART011_RXIS))
+				sbsa_uart_rx_chars(port);
+
+			if (status & UART011_TXIS)
+				sbsa_uart_tx_chars(port);
+
+			if (pass_counter-- == 0)
+				break;
+
+			status = readw(port->membase + UART011_RIS);
+			status &= ~readw(port->membase + UART011_IMSC);
+		} while (status != 0);
+		handled = 1;
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return IRQ_RETVAL(handled);
+}
+
+static unsigned int sbsa_uart_tx_empty(struct uart_port *port)
+{
+	unsigned int status = readw(port->membase + UART01x_FR);
+
+	return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
+}
+
+static unsigned int sbsa_uart_get_mctrl(struct uart_port *port)
+{
+	return 0;
+}
+
+static void sbsa_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+
+static void sbsa_uart_quiesce_irqs(struct uart_port *port)
+{
+	writew(readw(port->membase + UART011_RIS), port->membase + UART011_ICR);
+	/*
+	 * There is no way to clear TXIM as this is "ready to transmit IRQ", so
+	 * we simply mask it. start_tx() will unmask it.
+	 *
+	 * Note we can race with start_tx(), and if the race happens, the
+	 * polling user might get another interrupt just after we clear it.
+	 * But it should be OK and can happen even w/o the race, e.g.
+	 * controller immediately got some new data and raised the IRQ.
+	 *
+	 * And whoever uses polling routines assumes that it manages the device
+	 * (including tx queue), so we're also fine with start_tx()'s caller
+	 * side.
+	 */
+	writew(readw(port->membase + UART011_IMSC) & ~UART011_TXIM,
+	       port->membase + UART011_IMSC);
+}
+
+static int sbsa_uart_get_poll_char(struct uart_port *port)
+{
+	unsigned int status;
+
+	/*
+	 * The caller might need IRQs lowered, e.g. if used with KDB NMI
+	 * debugger.
+	 */
+	sbsa_uart_quiesce_irqs(port);
+
+	status = readw(port->membase + UART01x_FR);
+	if (status & UART01x_FR_RXFE)
+		return NO_POLL_CHAR;
+
+	return readw(port->membase + UART01x_DR);
+}
+
+static void sbsa_uart_put_poll_char(struct uart_port *port, unsigned char ch)
+{
+	while (readw(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+		barrier();
+
+	writew(ch, port->membase + UART01x_DR);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
+static int sbsa_uart_hwinit(struct uart_port *port)
+{
+	/* Clear pending error and receive interrupts */
+	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
+	       UART011_RTIS | UART011_RXIS, port->membase + UART011_ICR);
+
+	writew(UART011_RTIM | UART011_RXIM, port->membase + UART011_IMSC);
+
+	return 0;
+}
+
+static int sbsa_uart_startup(struct uart_port *port)
+{
+	int retval;
+
+	retval = sbsa_uart_hwinit(port);
+	if (retval)
+		return retval;
+
+	/*
+	 * Allocate the IRQ
+	 */
+	retval = request_irq(port->irq, sbsa_uart_int, 0, "uart-sbsa", port);
+	if (retval)
+		return retval;
+
+	/*
+	 * Provoke TX FIFO interrupt into asserting. Taking care to preserve
+	 * baud rate and data format specified by FBRD, IBRD and LCRH as the
+	 * UART may already be in use as a console.
+	 */
+	spin_lock_irq(&port->lock);
+
+	/*
+	 * this does not work on the SBSA UART, because it does not have
+	 * a CR and thus not loopback enable bit
+	 */
+	writew(0, port->membase + UART01x_DR);
+	while (readw(port->membase + UART01x_FR) & UART01x_FR_BUSY)
+		barrier();
+
+	/* Clear out any spuriously appearing RX interrupts and enable them */
+	writew(UART011_RTIS | UART011_RXIS, port->membase + UART011_ICR);
+	writew(UART011_RTIM | UART011_RXIM, port->membase + UART011_IMSC);
+	spin_unlock_irq(&port->lock);
+
+	return 0;
+}
+
+static void sbsa_uart_shutdown(struct uart_port *port)
+{
+	u16 im;
+
+	/*
+	 * disable all interrupts
+	 */
+	spin_lock_irq(&port->lock);
+	im = 0;
+	writew(im, port->membase + UART011_IMSC);
+	writew(0xffff, port->membase + UART011_ICR);
+	spin_unlock_irq(&port->lock);
+
+	/*
+	 * Free the interrupt
+	 */
+	free_irq(port->irq, port);
+
+}
+
+static void
+sbsa_uart_set_termios(struct uart_port *port, struct ktermios *termios,
+		  struct ktermios *old)
+{
+	unsigned long flags;
+	unsigned int baud = 115200;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/*
+	 * Update the per-port timeout.
+	 */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	port->read_status_mask = UART011_DR_OE | 255;
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |= UART011_DR_FE | UART011_DR_PE;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		port->read_status_mask |= UART011_DR_BE;
+
+	/*
+	 * Characters to ignore
+	 */
+	port->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |= UART011_DR_FE | UART011_DR_PE;
+	if (termios->c_iflag & IGNBRK) {
+		port->ignore_status_mask |= UART011_DR_BE;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |= UART011_DR_OE;
+	}
+
+	/*
+	 * Ignore all characters if CREAD is not set.
+	 */
+	if ((termios->c_cflag & CREAD) == 0)
+		port->ignore_status_mask |= UART_DUMMY_DR_RX;
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *sbsa_uart_type(struct uart_port *port)
+{
+	return port->type == PORT_SBSA ? "SBSA" : NULL;
+}
+
+/*
+ * Release the memory region(s) being used by 'port'
+ */
+static void sbsa_uart_release_port(struct uart_port *port)
+{
+	release_mem_region(port->mapbase, SZ_4K);
+}
+
+/*
+ * Request the memory region(s) being used by 'port'
+ */
+static int sbsa_uart_request_port(struct uart_port *port)
+{
+	return request_mem_region(port->mapbase, SZ_4K, "uart-sbsa")
+			!= NULL ? 0 : -EBUSY;
+}
+
+/*
+ * Configure/autoconfigure the port.
+ */
+static void sbsa_uart_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE) {
+		port->type = PORT_SBSA;
+		sbsa_uart_request_port(port);
+	}
+}
+
+/*
+ * verify the new serial_struct (for TIOCSSERIAL).
+ */
+static int sbsa_uart_verify_port(struct uart_port *port,
+				 struct serial_struct *ser)
+{
+	int ret = 0;
+
+	if (ser->type != PORT_UNKNOWN && ser->type != PORT_SBSA)
+		ret = -EINVAL;
+	if (ser->irq < 0 || ser->irq >= nr_irqs)
+		ret = -EINVAL;
+	return ret;
+}
+
+static struct uart_ops sbsa_uart_pops = {
+	.tx_empty	= sbsa_uart_tx_empty,
+	.set_mctrl	= sbsa_uart_set_mctrl,
+	.get_mctrl	= sbsa_uart_get_mctrl,
+	.stop_tx	= sbsa_uart_stop_tx,
+	.start_tx	= sbsa_uart_start_tx,
+	.stop_rx	= sbsa_uart_stop_rx,
+	.enable_ms	= NULL,
+	.break_ctl	= NULL,
+	.startup	= sbsa_uart_startup,
+	.shutdown	= sbsa_uart_shutdown,
+	.flush_buffer	= NULL,
+	.set_termios	= sbsa_uart_set_termios,
+	.type		= sbsa_uart_type,
+	.release_port	= sbsa_uart_release_port,
+	.request_port	= sbsa_uart_request_port,
+	.config_port	= sbsa_uart_config_port,
+	.verify_port	= sbsa_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_init     = sbsa_uart_hwinit,
+	.poll_get_char = sbsa_uart_get_poll_char,
+	.poll_put_char = sbsa_uart_put_poll_char,
+#endif
+};
+
+static struct uart_port *sbsa_uart_ports[UART_NR];
+
+#ifdef CONFIG_SERIAL_SBSA_UART_CONSOLE
+
+static void sbsa_uart_console_putchar(struct uart_port *port, int ch)
+{
+	while (readw(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+		barrier();
+	writew(ch, port->membase + UART01x_DR);
+}
+
+static void
+sbsa_uart_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct uart_port *port = sbsa_uart_ports[co->index];
+	unsigned int status;
+	unsigned long flags;
+	int locked = 1;
+
+	local_irq_save(flags);
+	if (port->sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock(&port->lock);
+	else
+		spin_lock(&port->lock);
+
+	uart_console_write(port, s, count, sbsa_uart_console_putchar);
+
+	/* Finally, wait for transmitter to become empty */
+	do {
+		status = readw(port->membase + UART01x_FR);
+	} while (status & UART01x_FR_BUSY);
+
+	if (locked)
+		spin_unlock(&port->lock);
+	local_irq_restore(flags);
+}
+
+static void __init
+sbsa_uart_console_get_options(struct uart_port *port, int *baud,
+			     int *parity, int *bits)
+{
+	*parity = 'n';
+	*bits = 8;
+	*baud = 115200;
+}
+
+static int __init sbsa_uart_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	int baud = 38400;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	/*
+	 * Check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index >= UART_NR)
+		co->index = 0;
+	port = sbsa_uart_ports[co->index];
+	if (!port)
+		return -ENODEV;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	else
+		sbsa_uart_console_get_options(port, &baud, &parity, &bits);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct uart_driver sbsa_uart_reg;
+static struct console sbsa_uart_console = {
+	.name		= "ttyAMA",
+	.write		= sbsa_uart_console_write,
+	.device		= uart_console_device,
+	.setup		= sbsa_uart_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &sbsa_uart_reg,
+};
+
+#define SBSA_UART_CONSOLE	(&sbsa_uart_console)
+
+static void sbsa_uart_putc(struct uart_port *port, int c)
+{
+	while (readw(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+		;
+	writew(c & 0xff, port->membase + UART01x_DR);
+	while (readw(port->membase + UART01x_FR) & UART01x_FR_BUSY)
+		;
+}
+
+static void sbsa_uart_early_write(struct console *con, const char *s,
+				  unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, sbsa_uart_putc);
+}
+
+static int __init sbsa_uart_early_console_setup(struct earlycon_device *device,
+						const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = sbsa_uart_early_write;
+	return 0;
+}
+EARLYCON_DECLARE(pl011, sbsa_uart_early_console_setup);
+OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", sbsa_uart_early_console_setup);
+
+#else
+#define SBSA_UART_CONSOLE	NULL
+#endif
+
+static struct uart_driver sbsa_uart_reg = {
+	.owner			= THIS_MODULE,
+	.driver_name		= "sbsa_uart",
+	.dev_name		= "ttyAMA",
+	.nr			= UART_NR,
+	.cons			= SBSA_UART_CONSOLE,
+};
+
+#ifdef CONFIG_OF
+
+static int dt_probe_serial_alias(int index, struct device *dev)
+{
+	struct device_node *np;
+	static bool seen_dev_with_alias;
+	static bool seen_dev_without_alias;
+	int ret = index;
+
+	if (!IS_ENABLED(CONFIG_OF))
+		return ret;
+
+	np = dev->of_node;
+	if (!np)
+		return ret;
+
+	ret = of_alias_get_id(np, "serial");
+	if (IS_ERR_VALUE(ret)) {
+		seen_dev_without_alias = true;
+		ret = index;
+	} else {
+		seen_dev_with_alias = true;
+		if (ret >= ARRAY_SIZE(sbsa_uart_ports) ||
+		    sbsa_uart_ports[ret] != NULL) {
+			dev_warn(dev, "requested serial port %d  not available.\n", ret);
+			ret = index;
+		}
+	}
+
+	if (seen_dev_with_alias && seen_dev_without_alias)
+		dev_warn(dev, "aliased and non-aliased serial devices found in device tree. Serial port enumeration may be unpredictable.\n");
+
+	return ret;
+}
+
+static const struct of_device_id arm_sbsa_match[] = {
+	{ .compatible = "arm,sbsa-uart", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, arm_sbsa_match);
+
+#else
+
+static int dt_probe_serial_alias(int index, struct device *dev)
+{
+	static int portnr;
+
+	return portnr++;
+}
+
+#endif
+
+static int sbsa_uart_probe(struct platform_device *pdev)
+{
+	struct resource *r;
+	struct uart_port *port;
+	int i, ret;
+
+	pr_info("DT probing for PL011-based SBSA UART\n");
+	for (i = 0; i < ARRAY_SIZE(sbsa_uart_ports); i++)
+		if (sbsa_uart_ports[i] == NULL)
+			break;
+
+	if (i == ARRAY_SIZE(sbsa_uart_ports)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
+	if (port == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	i = dt_probe_serial_alias(i, &pdev->dev);
+
+	port->membase = devm_ioremap_resource(&pdev->dev, r);
+	if (!port->membase) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	port->irq = platform_get_irq(pdev, 0);
+
+	dev_info(&pdev->dev, "found SBSA UART #%d at 0x%08llx\n", i, r->start);
+
+	port->fifosize = 32;
+	port->dev = &pdev->dev;
+	port->mapbase = r->start;
+	port->iotype = UPIO_MEM;
+	port->ops = &sbsa_uart_pops;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->line = i;
+
+	/* Ensure interrupts from this UART are masked and cleared */
+	writew(0, port->membase + UART011_IMSC);
+	writew(0xffff, port->membase + UART011_ICR);
+
+	sbsa_uart_ports[i] = port;
+
+	platform_set_drvdata(pdev, port);
+
+	if (!sbsa_uart_reg.state) {
+		ret = uart_register_driver(&sbsa_uart_reg);
+		if (ret < 0) {
+			pr_err("Failed to register ARM SBSA UART driver\n");
+			return ret;
+		}
+	}
+
+	ret = uart_add_one_port(&sbsa_uart_reg, port);
+	if (ret) {
+		sbsa_uart_ports[i] = NULL;
+		uart_unregister_driver(&sbsa_uart_reg);
+	}
+ out:
+	return ret;
+}
+
+static int sbsa_uart_remove(struct platform_device *pdev)
+{
+	struct uart_port *port = platform_get_drvdata(pdev);
+	bool busy = false;
+	int i;
+
+	uart_remove_one_port(&sbsa_uart_reg, port);
+
+	for (i = 0; i < ARRAY_SIZE(sbsa_uart_ports); i++)
+		if (sbsa_uart_ports[i] == port)
+			sbsa_uart_ports[i] = NULL;
+		else if (sbsa_uart_ports[i])
+			busy = true;
+
+	if (!busy)
+		uart_unregister_driver(&sbsa_uart_reg);
+	return 0;
+}
+
+static struct platform_driver arm_sbsa_uart_platform_driver = {
+	.probe		= sbsa_uart_probe,
+	.remove		= sbsa_uart_remove,
+	.driver = {
+		.name	= "sbsa-uart",
+		.of_match_table = of_match_ptr(arm_sbsa_match),
+	},
+};
+
+module_platform_driver(arm_sbsa_uart_platform_driver);
+
+#ifdef CONFIG_PM_SLEEP
+static int sbsa_uart_suspend(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+
+	if (!port)
+		return -EINVAL;
+
+	return uart_suspend_port(&sbsa_uart_reg, port);
+}
+
+static int sbsa_uart_resume(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+
+	if (!port)
+		return -EINVAL;
+
+	return uart_resume_port(&sbsa_uart_reg, port);
+}
+
+static SIMPLE_DEV_PM_OPS(sbsa_uart_dev_pm_ops, sbsa_uart_suspend,
+			 sbsa_uart_resume);
+
+#endif
+
+static int __init sbsa_uart_init(void)
+{
+	pr_info("Serial: ARM SBSA generic UART (PL011) driver\n");
+
+	return 0;
+}
+
+static void __exit sbsa_uart_exit(void)
+{
+}
+
+/*
+ * While this can be a module, if builtin it's most likely the console
+ * So let's leave module_exit but move module_init to an earlier place
+ */
+arch_initcall(sbsa_uart_init);
+module_exit(sbsa_uart_exit);
+
+MODULE_AUTHOR("ARM Ltd");
+MODULE_DESCRIPTION("ARM SBSA generic UART serial port driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 5820269..9f9ee0c 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -67,6 +67,7 @@
 #define PORT_CLPS711X	33
 #define PORT_SA1100	34
 #define PORT_UART00	35
+#define PORT_SBSA	36
 #define PORT_21285	37
 
 /* Sparc type numbers.  */
-- 
1.7.9.5

