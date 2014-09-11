From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 3/9] ARM: meson: serial: add MesonX SoC on-chip uart driver
Date: Thu, 11 Sep 2014 22:11:34 +0200
Message-ID: <1410466300-19168-4-git-send-email-carlo@caione.org>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410466300-19168-1-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, afaerber-l3A5Bk7waGM@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The SoC has four fully functional UARTs which use the same programming
model. They are named UART_A, UART_B, UART_C and UART_AO (Always-On)
which cannot be powered off.

Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
---
 drivers/tty/serial/Kconfig       |  18 ++
 drivers/tty/serial/Makefile      |   1 +
 drivers/tty/serial/meson_uart.c  | 634 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h |   3 +
 4 files changed, 656 insertions(+)
 create mode 100644 drivers/tty/serial/meson_uart.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fb57159..89d50c6 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -200,6 +200,24 @@ config SERIAL_KS8695_CONSOLE
 	  receives all kernel messages and warnings and which allows
 	  logins in single user mode).
 
+config SERIAL_MESON
+	tristate "Meson serial port support"
+	depends on ARCH_MESON
+	select SERIAL_CORE
+	help
+	  This enables the driver for the on-chip UARTs of the Amlogic
+	  MesonX processors.
+
+config SERIAL_MESON_CONSOLE
+	bool "Support for console on meson"
+	depends on SERIAL_MESON=y
+	select SERIAL_CORE_CONSOLE
+	help
+	  Say Y here if you wish to use a Amlogic MesonX UART as the
+	  system console (the system console is the device which
+	  receives all kernel messages and warnings and which allows
+	  logins in single user mode) as /dev/ttyAMLx.
+
 config SERIAL_CLPS711X
 	tristate "CLPS711X serial port support"
 	depends on ARCH_CLPS711X || COMPILE_TEST
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 0080cc3..9a548ac 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
 obj-$(CONFIG_SERIAL_ICOM) += icom.o
 obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
 obj-$(CONFIG_SERIAL_MPSC) += mpsc.o
+obj-$(CONFIG_SERIAL_MESON) += meson_uart.o
 obj-$(CONFIG_SERIAL_SB1250_DUART) += sb1250-duart.o
 obj-$(CONFIG_ETRAX_SERIAL) += crisv10.o
 obj-$(CONFIG_SERIAL_SCCNXP) += sccnxp.o
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
new file mode 100644
index 0000000..15c7497
--- /dev/null
+++ b/drivers/tty/serial/meson_uart.c
@@ -0,0 +1,634 @@
+/*
+ *  Based on meson_uart.c, by AMLOGIC, INC.
+ *
+ * Copyright (C) 2014 Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+/* Register offsets */
+#define AML_UART_WFIFO			0x00
+#define AML_UART_RFIFO			0x04
+#define AML_UART_CONTROL		0x08
+#define AML_UART_STATUS			0x0c
+#define AML_UART_MISC			0x10
+#define AML_UART_REG5			0x14
+
+/* AML_UART_CONTROL bits */
+#define AML_UART_TX_EN			BIT(12)
+#define AML_UART_RX_EN			BIT(13)
+#define AML_UART_TX_RST			BIT(22)
+#define AML_UART_RX_RST			BIT(23)
+#define AML_UART_CLR_ERR		BIT(24)
+#define AML_UART_RX_INT_EN		BIT(27)
+#define AML_UART_TX_INT_EN		BIT(28)
+#define AML_UART_DATA_LEN_MASK		(0x03 << 20)
+#define AML_UART_DATA_LEN_8BIT		(0x00 << 20)
+#define AML_UART_DATA_LEN_7BIT		(0x01 << 20)
+#define AML_UART_DATA_LEN_6BIT		(0x02 << 20)
+#define AML_UART_DATA_LEN_5BIT		(0x03 << 20)
+
+/* AML_UART_STATUS bits */
+#define AML_UART_PARITY_ERR		BIT(16)
+#define AML_UART_FRAME_ERR		BIT(17)
+#define AML_UART_TX_FIFO_WERR		BIT(18)
+#define AML_UART_RX_EMPTY		BIT(20)
+#define AML_UART_TX_FULL		BIT(21)
+#define AML_UART_TX_EMPTY		BIT(22)
+#define AML_UART_ERR			(AML_UART_PARITY_ERR | \
+					 AML_UART_FRAME_ERR  | \
+					 AML_UART_TX_FIFO_WERR)
+
+/* AML_UART_CONTROL bits */
+#define AML_UART_TWO_WIRE_EN		BIT(15)
+#define AML_UART_PARITY_TYPE		BIT(18)
+#define AML_UART_PARITY_EN		BIT(19)
+#define AML_UART_CLEAR_ERR		BIT(24)
+#define AML_UART_STOP_BIN_LEN_MASK	(0x03 << 16)
+#define AML_UART_STOP_BIN_1SB		(0x00 << 16)
+#define AML_UART_STOP_BIN_2SB		(0x01 << 16)
+
+/* AML_UART_MISC bits */
+#define AML_UART_XMIT_IRQ(c)		(((c) & 0xff) << 8)
+#define AML_UART_RECV_IRQ(c)		((c) & 0xff)
+
+/* AML_UART_REG5 bits */
+#define AML_UART_BAUD_MASK		0x7fffff
+#define AML_UART_BAUD_USE		BIT(23)
+
+#define AML_UART_PORT_NUM		6
+#define AML_UART_DEV_NAME		"ttyAML"
+
+
+static struct uart_driver meson_uart_driver;
+
+static struct uart_port *meson_ports[AML_UART_PORT_NUM];
+
+static void meson_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+}
+
+static unsigned int meson_uart_get_mctrl(struct uart_port *port)
+{
+	return TIOCM_CTS;
+}
+
+static unsigned int meson_uart_tx_empty(struct uart_port *port)
+{
+	u32 val;
+
+	val = readl(port->membase + AML_UART_STATUS);
+	return (val & AML_UART_TX_EMPTY) ? TIOCSER_TEMT : 0;
+}
+
+static void meson_uart_stop_tx(struct uart_port *port)
+{
+	u32 val;
+
+	val = readl(port->membase + AML_UART_CONTROL);
+	val &= ~AML_UART_TX_EN;
+	writel(val, port->membase + AML_UART_CONTROL);
+}
+
+static void meson_uart_stop_rx(struct uart_port *port)
+{
+	u32 val;
+
+	val = readl(port->membase + AML_UART_CONTROL);
+	val &= ~AML_UART_RX_EN;
+	writel(val, port->membase + AML_UART_CONTROL);
+}
+
+static void meson_uart_shutdown(struct uart_port *port)
+{
+	unsigned long flags;
+	u32 val;
+
+	free_irq(port->irq, port);
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	val = readl(port->membase + AML_UART_CONTROL);
+	val &= ~(AML_UART_RX_EN | AML_UART_TX_EN);
+	val &= ~(AML_UART_RX_INT_EN | AML_UART_TX_INT_EN);
+	writel(val, port->membase + AML_UART_CONTROL);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void meson_uart_start_tx(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned int ch;
+
+	if (uart_tx_stopped(port)) {
+		meson_uart_stop_tx(port);
+		return;
+	}
+
+	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_FULL)) {
+		if (port->x_char) {
+			writel(port->x_char, port->membase + AML_UART_WFIFO);
+			port->icount.tx++;
+			port->x_char = 0;
+			continue;
+		}
+
+		if (uart_circ_empty(xmit))
+			break;
+
+		ch = xmit->buf[xmit->tail];
+		writel(ch, port->membase + AML_UART_WFIFO);
+		xmit->tail = (xmit->tail+1) & (SERIAL_XMIT_SIZE - 1);
+		port->icount.tx++;
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
+
+static void meson_receive_chars(struct uart_port *port)
+{
+	struct tty_port *tport = &port->state->port;
+	char flag;
+	u32 status, ch, mode;
+
+	do {
+		flag = TTY_NORMAL;
+		port->icount.rx++;
+		status = readl(port->membase + AML_UART_STATUS);
+
+		if (status & AML_UART_ERR) {
+			if (status & AML_UART_TX_FIFO_WERR)
+				port->icount.overrun++;
+			else if (status & AML_UART_FRAME_ERR)
+				port->icount.frame++;
+			else if (status & AML_UART_PARITY_ERR)
+				port->icount.frame++;
+
+			mode = readl(port->membase + AML_UART_CONTROL);
+			mode |= AML_UART_CLEAR_ERR;
+			writel(mode, port->membase + AML_UART_CONTROL);
+
+			/* It doesn't clear to 0 automatically */
+			mode &= ~AML_UART_CLEAR_ERR;
+			writel(mode, port->membase + AML_UART_CONTROL);
+
+			status &= port->read_status_mask;
+			if (status & AML_UART_FRAME_ERR)
+				flag = TTY_FRAME;
+			else if (status & AML_UART_PARITY_ERR)
+				flag = TTY_PARITY;
+		}
+
+		ch = readl(port->membase + AML_UART_RFIFO);
+		ch &= 0xff;
+
+		if ((status & port->ignore_status_mask) == 0)
+			tty_insert_flip_char(tport, ch, flag);
+
+		if (status & AML_UART_TX_FIFO_WERR)
+			tty_insert_flip_char(tport, 0, TTY_OVERRUN);
+
+	} while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY));
+
+	spin_unlock(&port->lock);
+	tty_flip_buffer_push(tport);
+	spin_lock(&port->lock);
+}
+
+static irqreturn_t meson_uart_interrupt(int irq, void *dev_id)
+{
+	struct uart_port *port = (struct uart_port *)dev_id;
+
+	spin_lock(&port->lock);
+
+	if (!(readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY))
+		meson_receive_chars(port);
+
+	if (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_FULL))
+		meson_uart_start_tx(port);
+
+	spin_unlock(&port->lock);
+
+	return IRQ_HANDLED;
+}
+
+static const char *meson_uart_type(struct uart_port *port)
+{
+	return (port->type == PORT_MESON) ? "meson_uart" : NULL;
+}
+
+static int meson_uart_startup(struct uart_port *port)
+{
+	u32 val;
+	int ret = 0;
+
+	val = readl(port->membase + AML_UART_CONTROL);
+	val |= (AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
+	writel(val, port->membase + AML_UART_CONTROL);
+
+	val &= ~(AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
+	writel(val, port->membase + AML_UART_CONTROL);
+
+	val |= (AML_UART_RX_EN | AML_UART_TX_EN);
+	writel(val, port->membase + AML_UART_CONTROL);
+
+	val |= (AML_UART_RX_INT_EN | AML_UART_TX_INT_EN);
+	writel(val, port->membase + AML_UART_CONTROL);
+
+	val = (AML_UART_RECV_IRQ(1) | AML_UART_XMIT_IRQ(port->fifosize / 2));
+	writel(val, port->membase + AML_UART_MISC);
+
+	ret = request_irq(port->irq, meson_uart_interrupt, 0,
+			  meson_uart_type(port), port);
+
+	return ret;
+}
+
+static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
+{
+	u32 val;
+
+	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
+		cpu_relax();
+
+	val = readl(port->membase + AML_UART_REG5);
+	val &= ~AML_UART_BAUD_MASK;
+	val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
+	val |= AML_UART_BAUD_USE;
+	writel(val, port->membase + AML_UART_REG5);
+}
+
+static void meson_uart_set_termios(struct uart_port *port,
+				   struct ktermios *termios,
+				   struct ktermios *old)
+{
+	unsigned int cflags, iflags, baud;
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	cflags = termios->c_cflag;
+	iflags = termios->c_iflag;
+
+	val = readl(port->membase + AML_UART_CONTROL);
+
+	val &= ~AML_UART_DATA_LEN_MASK;
+	switch (cflags & CSIZE) {
+	case CS8:
+		val |= AML_UART_DATA_LEN_8BIT;
+		break;
+	case CS7:
+		val |= AML_UART_DATA_LEN_7BIT;
+		break;
+	case CS6:
+		val |= AML_UART_DATA_LEN_6BIT;
+		break;
+	case CS5:
+		val |= AML_UART_DATA_LEN_5BIT;
+		break;
+	}
+
+	if (cflags & PARENB)
+		val |= AML_UART_PARITY_EN;
+	else
+		val &= ~AML_UART_PARITY_EN;
+
+	if (cflags & PARODD)
+		val |= AML_UART_PARITY_TYPE;
+	else
+		val &= ~AML_UART_PARITY_TYPE;
+
+	val &= ~AML_UART_STOP_BIN_LEN_MASK;
+	if (cflags & CSTOPB)
+		val |= AML_UART_STOP_BIN_2SB;
+	else
+		val &= ~AML_UART_STOP_BIN_1SB;
+
+	if (cflags & CRTSCTS)
+		val &= ~AML_UART_TWO_WIRE_EN;
+	else
+		val |= AML_UART_TWO_WIRE_EN;
+
+	writel(val, port->membase + AML_UART_CONTROL);
+
+	baud = uart_get_baud_rate(port, termios, old, 9600, 115200);
+	meson_uart_change_speed(port, baud);
+
+	port->read_status_mask = AML_UART_TX_FIFO_WERR;
+	if (iflags & INPCK)
+		port->read_status_mask |= AML_UART_PARITY_ERR |
+					  AML_UART_FRAME_ERR;
+
+	port->ignore_status_mask = 0;
+	if (iflags & IGNPAR)
+		port->ignore_status_mask |= AML_UART_PARITY_ERR |
+					    AML_UART_FRAME_ERR;
+
+	uart_update_timeout(port, termios->c_cflag, baud);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int meson_uart_verify_port(struct uart_port *port,
+				  struct serial_struct *ser)
+{
+	int ret = 0;
+
+	if (port->type != PORT_MESON)
+		ret = -EINVAL;
+	if (port->irq != ser->irq)
+		ret = -EINVAL;
+	if (ser->baud_base < 9600)
+		ret = -EINVAL;
+	return ret;
+}
+
+static void meson_uart_release_port(struct uart_port *port)
+{
+	if (port->flags & UPF_IOREMAP) {
+		iounmap(port->membase);
+		port->membase = NULL;
+	}
+}
+
+static int meson_uart_request_port(struct uart_port *port)
+{
+	struct platform_device *pdev = to_platform_device(port->dev);
+	struct resource *res;
+	int size;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "cannot obtain I/O memory region");
+		return -ENODEV;
+	}
+	size = resource_size(res);
+
+	if (!devm_request_mem_region(port->dev, port->mapbase, size,
+				     dev_name(port->dev))) {
+		dev_err(port->dev, "Memory region busy\n");
+		return -EBUSY;
+	}
+
+	if (port->flags & UPF_IOREMAP) {
+		port->membase = devm_ioremap_nocache(port->dev,
+						     port->mapbase,
+						     size);
+		if (port->membase == NULL)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void meson_uart_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE) {
+		port->type = PORT_MESON;
+		meson_uart_request_port(port);
+	}
+}
+
+static struct uart_ops meson_uart_ops = {
+	.set_mctrl      = meson_uart_set_mctrl,
+	.get_mctrl      = meson_uart_get_mctrl,
+	.tx_empty	= meson_uart_tx_empty,
+	.start_tx	= meson_uart_start_tx,
+	.stop_tx	= meson_uart_stop_tx,
+	.stop_rx	= meson_uart_stop_rx,
+	.startup	= meson_uart_startup,
+	.shutdown	= meson_uart_shutdown,
+	.set_termios	= meson_uart_set_termios,
+	.type		= meson_uart_type,
+	.config_port	= meson_uart_config_port,
+	.request_port	= meson_uart_request_port,
+	.release_port	= meson_uart_release_port,
+	.verify_port	= meson_uart_verify_port,
+};
+
+#ifdef CONFIG_SERIAL_MESON_CONSOLE
+
+static void meson_console_putchar(struct uart_port *port, int ch)
+{
+	if (!port->membase)
+		return;
+
+	while (readl(port->membase + AML_UART_STATUS) & AML_UART_TX_FULL)
+		cpu_relax();
+	writel(ch, port->membase + AML_UART_WFIFO);
+}
+
+static void meson_serial_console_write(struct console *co, const char *s,
+				       u_int count)
+{
+	struct uart_port *port;
+	unsigned long flags;
+	int locked;
+
+	port = meson_ports[co->index];
+	if (!port)
+		return;
+
+	local_irq_save(flags);
+	if (port->sysrq) {
+		locked = 0;
+	} else if (oops_in_progress) {
+		locked = spin_trylock(&port->lock);
+	} else {
+		spin_lock(&port->lock);
+		locked = 1;
+	}
+
+	uart_console_write(port, s, count, meson_console_putchar);
+
+	if (locked)
+		spin_unlock(&port->lock);
+	local_irq_restore(flags);
+}
+
+static int meson_serial_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	if (co->index < 0 || co->index >= AML_UART_PORT_NUM)
+		return -EINVAL;
+
+	port = meson_ports[co->index];
+	if (!port || !port->membase)
+		return -ENODEV;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct console meson_serial_console = {
+	.name		= AML_UART_DEV_NAME,
+	.write		= meson_serial_console_write,
+	.device		= uart_console_device,
+	.setup		= meson_serial_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &meson_uart_driver,
+};
+
+static int __init meson_serial_console_init(void)
+{
+	register_console(&meson_serial_console);
+	return 0;
+}
+console_initcall(meson_serial_console_init);
+
+#define MESON_SERIAL_CONSOLE	(&meson_serial_console)
+#else
+#define MESON_SERIAL_CONSOLE	NULL
+#endif
+
+static struct uart_driver meson_uart_driver = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "meson_uart",
+	.dev_name	= AML_UART_DEV_NAME,
+	.nr		= AML_UART_PORT_NUM,
+	.cons		= MESON_SERIAL_CONSOLE,
+};
+
+static int meson_uart_probe(struct platform_device *pdev)
+{
+	struct resource *res_mem, *res_irq;
+	struct uart_port *port;
+	struct clk *clk;
+	int ret = 0;
+
+	if (pdev->dev.of_node)
+		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
+
+	if (pdev->id < 0 || pdev->id >= AML_UART_PORT_NUM)
+		return -EINVAL;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_mem)
+		return -ENODEV;
+
+	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res_irq)
+		return -ENODEV;
+
+	if (meson_ports[pdev->id]) {
+		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
+		return -EBUSY;
+	}
+
+	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	port->uartclk = clk_get_rate(clk);
+	port->iotype = UPIO_MEM;
+	port->mapbase = res_mem->start;
+	port->irq = res_irq->start;
+	port->flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_LOW_LATENCY;
+	port->dev = &pdev->dev;
+	port->line = pdev->id;
+	port->type = PORT_MESON;
+	port->x_char = 0;
+	port->ops = &meson_uart_ops;
+	port->fifosize = 64;
+
+	meson_ports[pdev->id] = port;
+	platform_set_drvdata(pdev, port);
+
+	ret = uart_add_one_port(&meson_uart_driver, port);
+	if (ret)
+		meson_ports[pdev->id] = NULL;
+
+	return ret;
+}
+
+static int meson_uart_remove(struct platform_device *pdev)
+{
+	struct uart_port *port;
+
+	port = platform_get_drvdata(pdev);
+	uart_remove_one_port(&meson_uart_driver, port);
+	meson_ports[pdev->id] = NULL;
+
+	return 0;
+}
+
+
+static const struct of_device_id meson_uart_dt_match[] = {
+	{ .compatible = "amlogic,meson-uart" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
+
+static  struct platform_driver meson_uart_platform_driver = {
+	.probe		= meson_uart_probe,
+	.remove		= meson_uart_remove,
+	.driver		= {
+		.owner		= THIS_MODULE,
+		.name		= "meson_uart",
+		.of_match_table	= meson_uart_dt_match,
+	},
+};
+
+static int __init meson_uart_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&meson_uart_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&meson_uart_platform_driver);
+	if (ret)
+		uart_unregister_driver(&meson_uart_driver);
+
+	return ret;
+}
+
+static void __exit meson_uart_exit(void)
+{
+	platform_driver_unregister(&meson_uart_platform_driver);
+	uart_unregister_driver(&meson_uart_driver);
+}
+
+module_init(meson_uart_init);
+module_exit(meson_uart_exit);
+
+MODULE_AUTHOR("Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>");
+MODULE_DESCRIPTION("Amlogic Meson serial port driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 5820269..16ad852 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -244,4 +244,7 @@
 /* SC16IS74xx */
 #define PORT_SC16IS7XX   108
 
+/* MESON */
+#define PORT_MESON	109
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
