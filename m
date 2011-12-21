From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial/efm32: add new driver
Date: Wed, 21 Dec 2011 16:05:59 +0100
Message-ID: <1324479959-7343-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57560 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab1LUPGV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Dec 2011 10:06:21 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, kernel@pengutronix.de

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

note that ARCH_EFM32 isn't in mainline yet, so to be actually usable
some arch patches are needed.

Best regards
Uwe

 .../devicetree/bindings/tty/serial/efm32-usart.txt |   14 +
 drivers/tty/serial/Kconfig                         |   10 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/efm32-usart.c                   |  714 ++++++++++++=
++++++++
 include/linux/serial_core.h                        |    2 +
 5 files changed, 741 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/efm32-=
usart.txt
 create mode 100644 drivers/tty/serial/efm32-usart.c

diff --git a/Documentation/devicetree/bindings/tty/serial/efm32-usart.t=
xt b/Documentation/devicetree/bindings/tty/serial/efm32-usart.txt
new file mode 100644
index 0000000..eef2721
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/efm32-usart.txt
@@ -0,0 +1,14 @@
+* Energymicro efm32 UART
+
+Required properties:
+- compatible : Should be "efm32,usart"
+- reg : Address and length of the register set
+- interrupts : Should contain uart interrupt
+
+Example:
+
+uart@0x4000c400 {
+	compatible =3D "efm32,usart";
+	reg =3D <0x4000c400 0x400>;
+	interrupts =3D <15>;
+};
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 925a1e5..cfeb0f3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1610,4 +1610,14 @@ config SERIAL_XILINX_PS_UART_CONSOLE
 	help
 	  Enable a Xilinx PS UART port to be the system console.
=20
+config SERIAL_EFM32_USART
+	bool "EFM32 USART port."
+	depends on ARCH_EFM32
+	select SERIAL_CORE
+
+config SERIAL_EFM32_USART_CONSOLE
+	bool "EFM32 USART console support"
+	depends on SERIAL_EFM32_USART=3Dy
+	select SERIAL_CORE_CONSOLE
+
 endmenu
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index e10cf5b..d3ab42b 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -94,3 +94,4 @@ obj-$(CONFIG_SERIAL_MSM_SMD)	+=3D msm_smd_tty.o
 obj-$(CONFIG_SERIAL_MXS_AUART) +=3D mxs-auart.o
 obj-$(CONFIG_SERIAL_LANTIQ)	+=3D lantiq.o
 obj-$(CONFIG_SERIAL_XILINX_PS_UART) +=3D xilinx_uartps.o
+obj-$(CONFIG_SERIAL_EFM32_USART) +=3D efm32-usart.o
diff --git a/drivers/tty/serial/efm32-usart.c b/drivers/tty/serial/efm3=
2-usart.c
new file mode 100644
index 0000000..4d0b636
--- /dev/null
+++ b/drivers/tty/serial/efm32-usart.c
@@ -0,0 +1,714 @@
+#include <linux/kernel.h>
+#include <linux/serial_core.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/console.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#define DRIVER_NAME "efm32-usart"
+#define DEV_NAME "ttyefm"
+
+#define USARTn_CTRL		0x00
+#define USARTn_CTRL_SYNC		0x0001
+
+#define USARTn_FRAME		0x04
+#define USARTn_FRAME_DATABITS(n)	((n) - 3)
+#define USARTn_FRAME_PARITY_NONE	0x0000
+#define USARTn_FRAME_STOPBITS_HALF	0x0000
+#define USARTn_FRAME_STOPBITS_ONE	0x1000
+#define USARTn_FRAME_STOPBITS_TWO	0x3000
+
+#define USARTn_CMD		0x0c
+#define USARTn_CMD_RXEN			0x0001
+#define USARTn_CMD_RXDIS		0x0002
+#define USARTn_CMD_TXEN			0x0004
+#define USARTn_CMD_TXDIS		0x0008
+
+#define USARTn_STATUS		0x10
+#define USARTn_STATUS_TXENS		0x0002
+#define USARTn_STATUS_TXC		0x0020
+#define USARTn_STATUS_TXBL		0x0040
+#define USARTn_STATUS_RXDATAV		0x0080
+
+#define USARTn_CLKDIV		0x14
+
+#define USARTn_RXDATAX		0x18
+#define USARTn_RXDATAX_PERR		0x4000
+#define USARTn_RXDATAX_FERR		0x8000
+
+#define USARTn_TXDATA		0x34
+
+#define USARTn_IF		0x40
+#define USARTn_IF_TXBL			0x0002
+#define USARTn_IF_RXDATAV		0x0004
+
+#define USARTn_IFS		0x44
+#define USARTn_IFC		0x48
+#define USARTn_IEN		0x4c
+
+#define USARTn_ROUTE		0x54
+#define USARTn_ROUTE_RXPEN		0x0001
+#define USARTn_ROUTE_TXPEN		0x0002
+
+struct efm32_usart_port {
+	struct uart_port port;
+	unsigned int txirq;
+	struct clk *clk;
+};
+#define to_efm_port(_port) container_of(_port, struct efm32_usart_port=
, port)
+#define efm_debug(efm_port, format, arg...)			\
+	dev_dbg(efm_port->port.dev, format, ##arg)
+
+static void efm32_usart_write32(struct efm32_usart_port *efm_port,
+		u32 value, unsigned offset)
+{
+	__raw_writel(value, efm_port->port.membase + offset);
+}
+
+static u32 efm32_usart_read32(struct efm32_usart_port *efm_port,
+		unsigned offset)
+{
+	return __raw_readl(efm_port->port.membase + offset);
+}
+
+static unsigned int efm32_usart_tx_empty(struct uart_port *port)
+{
+	struct efm32_usart_port *efm_port =3D to_efm_port(port);
+	u32 status =3D efm32_usart_read32(efm_port, USARTn_STATUS);
+
+	/* XXX: does TXBL also mean that the shifter is done? */
+	if (status & USARTn_STATUS_TXBL)
+		return TIOCSER_TEMT;
+	else
+		return 0;
+}
+
+static void efm32_usart_set_mctrl(struct uart_port *port, unsigned int=
 mctrl)
+{
+	/* sorry, neither handshaking lines nor loop functionallity */
+}
+
+static unsigned int efm32_usart_get_mctrl(struct uart_port *port)
+{
+	/* sorry, no handshaking lines available */
+	return TIOCM_CAR | TIOCM_CTS | TIOCM_DSR;
+}
+
+static void efm32_usart_stop_tx(struct uart_port *port)
+{
+	struct efm32_usart_port *efm_port =3D to_efm_port(port);
+	u32 ien =3D efm32_usart_read32(efm_port,  USARTn_IEN);
+
+	//efm32_usart_write32(efm_port, USARTn_CMD_TXDIS, USARTn_CMD);
+	efm32_usart_write32(efm_port, ien & ~USARTn_IF_TXBL, USARTn_IEN);
+}
+
+static void efm32_usart_tx_chars(struct efm32_usart_port *efm_port)
+{
+	struct uart_port *port =3D &efm_port->port;
+	struct circ_buf *xmit =3D &port->state->xmit;
+
+	while (efm32_usart_read32(efm_port, USARTn_STATUS) &
+			USARTn_STATUS_TXBL) {
+		if (port->x_char) {
+			port->icount.tx++;
+			efm32_usart_write32(efm_port, port->x_char,
+					USARTn_TXDATA);
+			port->x_char =3D 0;
+			continue;
+		}
+		if (!uart_circ_empty(xmit) && !uart_tx_stopped(port)) {
+			port->icount.tx++;
+			efm32_usart_write32(efm_port, xmit->buf[xmit->tail],
+					USARTn_TXDATA);
+			xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		} else
+			break;
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (!port->x_char && uart_circ_empty(xmit))
+		efm32_usart_stop_tx(port);
+}
+
+static void efm32_usart_start_tx(struct uart_port *port)
+{
+	struct efm32_usart_port *efm_port =3D to_efm_port(port);
+	u32 ien;
+
+	efm32_usart_write32(efm_port, USARTn_IF_TXBL, USARTn_IFC);
+	ien =3D efm32_usart_read32(efm_port,  USARTn_IEN);
+	efm32_usart_write32(efm_port, ien | USARTn_IF_TXBL, USARTn_IEN);
+	efm32_usart_write32(efm_port, USARTn_CMD_TXEN, USARTn_CMD);
+
+	efm32_usart_tx_chars(efm_port);
+}
+
+static void efm32_usart_stop_rx(struct uart_port *port)
+{
+	struct efm32_usart_port *efm_port =3D to_efm_port(port);
+
+	efm32_usart_write32(efm_port, USARTn_CMD_RXDIS, USARTn_CMD);
+}
+
+static void efm32_usart_enable_ms(struct uart_port *port)
+{
+	/* no handshake lines, no modem status interrupts */
+}
+
+static void efm32_usart_break_ctl(struct uart_port *port, int ctl)
+{
+	/* not possible without fiddling with gpios */
+}
+
+static void efm32_usart_rx_chars(struct efm32_usart_port *efm_port)
+{
+	struct uart_port *port =3D &efm_port->port;
+	struct tty_struct *tty =3D port->state->port.tty;
+
+	spin_lock(&port->lock);
+
+	while (efm32_usart_read32(efm_port, USARTn_STATUS) &
+			USARTn_STATUS_RXDATAV) {
+		u32 rxdata =3D efm32_usart_read32(efm_port, USARTn_RXDATAX);
+		int flag =3D 0;
+
+		port->icount.rx++;
+
+		/* XXX detect BREAK and overrun */
+
+		if (rxdata & USARTn_RXDATAX_PERR) {
+			port->icount.parity++;
+			if (port->read_status_mask & USARTn_RXDATAX_PERR)
+				flag =3D TTY_PARITY;
+		} else if (rxdata & USARTn_RXDATAX_FERR) {
+			port->icount.frame++;
+			if (port->read_status_mask & USARTn_RXDATAX_FERR)
+				flag =3D TTY_FRAME;
+		}
+
+		if (rxdata & port->ignore_status_mask)
+			continue;
+
+		tty_insert_flip_char(tty, rxdata, flag);
+	}
+	spin_unlock(&port->lock);
+
+	tty_flip_buffer_push(tty);
+}
+
+static irqreturn_t efm32_usart_rxirq(int irq, void *data)
+{
+	struct efm32_usart_port *efm_port =3D data;
+	u32 irqflag =3D efm32_usart_read32(efm_port, USARTn_IF);
+
+	if (irqflag & USARTn_IF_RXDATAV) {
+		efm32_usart_write32(efm_port, USARTn_IF_RXDATAV, USARTn_IFC);
+		efm32_usart_rx_chars(efm_port);
+
+		return IRQ_HANDLED;
+	} else
+		return IRQ_NONE;
+}
+
+static irqreturn_t efm32_usart_txirq(int irq, void *data)
+{
+	struct efm32_usart_port *efm_port =3D data;
+	u32 irqflag =3D efm32_usart_read32(efm_port, USARTn_IF);
+
+	if (irqflag & USARTn_IF_TXBL) {
+		efm32_usart_write32(efm_port, USARTn_IF_TXBL, USARTn_IFC);
+		efm32_usart_tx_chars(efm_port);
+		return IRQ_HANDLED;
+	} else
+		return IRQ_NONE;
+}
+
+static int efm32_usart_startup(struct uart_port *port)
+{
+	struct efm32_usart_port *efm_port =3D to_efm_port(port);
+	int ret;
+
+	ret =3D clk_enable(efm_port->clk);
+	if (ret) {
+		efm_debug(efm_port, "failed to enable clk\n");
+		goto err_clk_enable;
+	}
+	port->uartclk =3D clk_get_rate(efm_port->clk);
+
+	/* Enable pins at default location */
+	efm32_usart_write32(efm_port, USARTn_ROUTE_RXPEN | USARTn_ROUTE_TXPEN=
,
+			USARTn_ROUTE);
+
+	ret =3D request_irq(port->irq, efm32_usart_rxirq, 0,
+			DRIVER_NAME, efm_port);
+	if (ret) {
+		efm_debug(efm_port, "failed to register rxirq\n");
+		goto err_request_irq_rx;
+	}
+
+	/* disable all irqs */
+	efm32_usart_write32(efm_port, 0, USARTn_IEN);
+
+	ret =3D request_irq(efm_port->txirq, efm32_usart_txirq, 0,
+			DRIVER_NAME, efm_port);
+	if (ret) {
+		efm_debug(efm_port, "failed to register txirq\n");
+		free_irq(port->irq, efm_port);
+err_request_irq_rx:
+
+		clk_disable(efm_port->clk);
+	} else {
+		efm32_usart_write32(efm_port, USARTn_IF_RXDATAV, USARTn_IEN);
+		efm32_usart_write32(efm_port, USARTn_CMD_RXEN, USARTn_CMD);
+	}
+
+err_clk_enable:
+	return ret;
+}
+
+static void efm32_usart_shutdown(struct uart_port *port)
+{
+	struct efm32_usart_port *efm_port =3D to_efm_port(port);
+
+	efm32_usart_write32(efm_port, 0, USARTn_IEN);
+	free_irq(port->irq, efm_port);
+
+	clk_disable(efm_port->clk);
+}
+
+static void efm32_usart_set_termios(struct uart_port *port,
+		struct ktermios *new, struct ktermios *old)
+{
+	struct efm32_usart_port *efm_port =3D to_efm_port(port);
+	unsigned long flags;
+	unsigned baud;
+	u32 clkdiv;
+
+	/* no modem control lines */
+	new->c_cflag &=3D ~(HUPCL | CRTSCTS | CMSPAR);
+
+	/* currently only some features are implemented */
+	new->c_cflag &=3D ~CSIZE;
+	new->c_cflag |=3D CS8;
+	new->c_cflag |=3D CSTOPB;
+	new->c_cflag &=3D ~PARENB;
+	new->c_iflag =3D 0;
+
+	baud =3D uart_get_baud_rate(port, new, old,
+			DIV_ROUND_CLOSEST(port->uartclk, 16 * 8192),
+			DIV_ROUND_CLOSEST(port->uartclk, 16));
+
+	/*
+	 * the 6 lowest bits of CLKDIV are dc, bit 6 has value 0.25.
+	 * port->uartclk <=3D 14e6, so 4 * port->uartclk doesn't overflow.
+	 */
+	clkdiv =3D (DIV_ROUND_CLOSEST(4 * port->uartclk, 16 * baud) - 4) << 6=
;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	efm32_usart_write32(efm_port,
+			USARTn_CMD_TXDIS | USARTn_CMD_RXDIS, USARTn_CMD);
+
+	port->read_status_mask =3D 0;
+	port->ignore_status_mask =3D 0;
+
+	uart_update_timeout(port, new->c_cflag, baud);
+
+	efm32_usart_write32(efm_port, 0, USARTn_CTRL);
+	efm32_usart_write32(efm_port, USARTn_FRAME_STOPBITS_ONE |
+			USARTn_FRAME_PARITY_NONE | USARTn_FRAME_DATABITS(8),
+			USARTn_FRAME);
+	efm32_usart_write32(efm_port, clkdiv, USARTn_CLKDIV);
+
+	efm32_usart_write32(efm_port, USARTn_CMD_TXEN | USARTn_CMD_RXEN, USAR=
Tn_CMD);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *efm32_usart_type(struct uart_port *port)
+{
+	return port->type =3D=3D PORT_EFMUSART ? "efm32-usart" : NULL;
+}
+
+static void efm32_usart_release_port(struct uart_port *port)
+{
+	struct efm32_usart_port *efm_port =3D to_efm_port(port);
+
+	clk_unprepare(efm_port->clk);
+	clk_put(efm_port->clk);
+	iounmap(port->membase);
+}
+
+static int efm32_usart_request_port(struct uart_port *port)
+{
+	struct efm32_usart_port *efm_port =3D to_efm_port(port);
+	int ret;
+
+	port->membase =3D ioremap(port->mapbase, 60);
+	if (!efm_port->port.membase) {
+		ret =3D -ENOMEM;
+		efm_debug(efm_port, "failed to remap\n");
+		goto err_ioremap;
+	}
+
+	efm_port->clk =3D clk_get(port->dev, NULL);
+	if (IS_ERR(efm_port->clk)) {
+		ret =3D PTR_ERR(efm_port->clk);
+		efm_debug(efm_port, "failed to get clock\n");
+		goto err_clk_get;
+	}
+
+	ret =3D clk_prepare(efm_port->clk);
+	if (ret) {
+		clk_put(efm_port->clk);
+err_clk_get:
+
+		iounmap(port->membase);
+err_ioremap:
+		return ret;
+	}
+	return 0;
+}
+
+static void efm32_usart_config_port(struct uart_port *port, int type)
+{
+	if (type & UART_CONFIG_TYPE &&
+			!efm32_usart_request_port(port))
+		port->type =3D PORT_EFMUSART;
+}
+
+static int efm32_usart_verify_port(struct uart_port *port,
+		struct serial_struct *serinfo)
+{
+	int ret =3D 0;
+
+	if (serinfo->type !=3D PORT_UNKNOWN && serinfo->type !=3D PORT_EFMUSA=
RT)
+		ret =3D -EINVAL;
+
+	return ret;
+}
+
+static struct uart_ops efm32_usart_pops =3D {
+	.tx_empty =3D efm32_usart_tx_empty,
+	.set_mctrl =3D efm32_usart_set_mctrl,
+	.get_mctrl =3D efm32_usart_get_mctrl,
+	.stop_tx =3D efm32_usart_stop_tx,
+	.start_tx =3D efm32_usart_start_tx,
+	.stop_rx =3D efm32_usart_stop_rx,
+	.enable_ms =3D efm32_usart_enable_ms,
+	.break_ctl =3D efm32_usart_break_ctl,
+	.startup =3D efm32_usart_startup,
+	.shutdown =3D efm32_usart_shutdown,
+	.set_termios =3D efm32_usart_set_termios,
+	.type =3D efm32_usart_type,
+	.release_port =3D efm32_usart_release_port,
+	.request_port =3D efm32_usart_request_port,
+	.config_port =3D efm32_usart_config_port,
+	.verify_port =3D efm32_usart_verify_port,
+};
+
+static struct efm32_usart_port *efm32_usart_ports[3];
+
+#ifdef CONFIG_SERIAL_EFM32_USART_CONSOLE
+static void efm32_usart_console_putchar(struct uart_port *port, int ch=
)
+{
+	struct efm32_usart_port *efm_port =3D to_efm_port(port);
+	unsigned int timeout =3D 0x400;
+	u32 status;
+
+	while (1) {
+		status =3D efm32_usart_read32(efm_port, USARTn_STATUS);
+
+		if (status & USARTn_STATUS_TXBL)
+			break;
+		if (!timeout--)
+			return;
+	}
+	efm32_usart_write32(efm_port, ch, USARTn_TXDATA);
+}
+
+static void efm32_usart_console_write(struct console *co, const char *=
s,
+		unsigned int count)
+{
+	struct efm32_usart_port *efm_port =3D efm32_usart_ports[co->index];
+	u32 status =3D efm32_usart_read32(efm_port, USARTn_STATUS);
+	unsigned int timeout =3D 0x400;
+
+	if (!(status & USARTn_STATUS_TXENS))
+		efm32_usart_write32(efm_port, USARTn_CMD_TXEN, USARTn_CMD);
+
+	uart_console_write(&efm_port->port, s, count,
+			efm32_usart_console_putchar);
+
+	/* Wait for the transmitter to become empty */
+	while (1) {
+		u32 status =3D efm32_usart_read32(efm_port, USARTn_STATUS);
+		if (status & USARTn_STATUS_TXC)
+			break;
+		if (!timeout--)
+			break;
+	}
+
+	if (!(status & USARTn_STATUS_TXENS))
+		efm32_usart_write32(efm_port, USARTn_CMD_TXDIS, USARTn_CMD);
+}
+
+static void efm32_usart_console_get_options(struct efm32_usart_port *e=
fm_port,
+		int *baud, int *parity, int *bits)
+{
+	u32 ctrl =3D efm32_usart_read32(efm_port, USARTn_CTRL);
+	u32 route, clkdiv;
+
+	if (ctrl & USARTn_CTRL_SYNC)
+		/* not operating in async mode */
+		return;
+
+	route =3D efm32_usart_read32(efm_port, USARTn_ROUTE);
+	if (!(route & USARTn_ROUTE_TXPEN))
+		/* tx pin not routed */
+		return;
+
+	clkdiv =3D efm32_usart_read32(efm_port, USARTn_CLKDIV);
+
+	*baud =3D DIV_ROUND_CLOSEST(4 * efm_port->port.uartclk,
+			16 * (4 + (clkdiv >> 6)));
+	*parity =3D 'n';
+	*bits =3D 8;
+
+	efm_debug(efm_port, "get_opts: baud=3D%d\n", *baud);
+}
+
+static int efm32_usart_console_setup(struct console *co, char *options=
)
+{
+	struct efm32_usart_port *efm_port;
+	int baud =3D 115200;
+	int bits =3D 8;
+	int parity =3D 'n';
+	int flow =3D 'n';
+	int ret;
+
+	if (co->index < 0 || co->index >=3D ARRAY_SIZE(efm32_usart_ports)) {
+		unsigned i;
+		for (i =3D 0; i < ARRAY_SIZE(efm32_usart_ports); ++i) {
+			if (efm32_usart_ports[i]) {
+				pr_warn("efm32-console: fall back to console index %u (from %hhi)\=
n",
+						i, co->index);
+				co->index =3D i;
+				break;
+			}
+		}
+	}
+
+	efm_port =3D efm32_usart_ports[co->index];
+	if (!efm_port) {
+		pr_warn("efm32-console: No port at %d\n", co->index);
+		return -ENODEV;
+	}
+
+	ret =3D clk_prepare(efm_port->clk);
+	if (ret) {
+		dev_warn(efm_port->port.dev,
+				"console: clk_prepare failed: %d\n", ret);
+		return ret;
+	}
+
+	efm_port->port.uartclk =3D clk_get_rate(efm_port->clk);
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	else
+		efm32_usart_console_get_options(efm_port,
+				&baud, &parity, &bits);
+
+	return uart_set_options(&efm_port->port, co, baud, parity, bits, flow=
);
+}
+
+static struct uart_driver efm32_usart_reg;
+
+static struct console efm32_usart_console =3D {
+	.name =3D DEV_NAME,
+	.write =3D efm32_usart_console_write,
+	.device =3D uart_console_device,
+	.setup =3D efm32_usart_console_setup,
+	.flags =3D CON_PRINTBUFFER,
+	.index =3D -1,
+	.data =3D &efm32_usart_reg,
+};
+
+#else
+#define efm32_usart_console (*(struct console *)NULL)
+#endif /* ifdef CONFIG_SERIAL_EFM32_USART_CONSOLE / else */
+
+static struct uart_driver efm32_usart_reg =3D {
+	.owner =3D THIS_MODULE,
+	.driver_name =3D DRIVER_NAME,
+	.dev_name =3D DEV_NAME,
+	.nr =3D ARRAY_SIZE(efm32_usart_ports),
+	.cons =3D &efm32_usart_console,
+};
+
+static int efm32_usart_probe_dt(struct platform_device *pdev,
+		struct efm32_usart_port *efm_port)
+{
+	struct device_node *np =3D pdev->dev.of_node;
+	int ret;
+
+	if (!np)
+		return 1;
+
+	ret =3D of_alias_get_id(np, "serial");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias id: %d\n", ret);
+		return ret;
+	} else {
+		efm_port->port.line =3D ret;
+		return 0;
+	}
+
+}
+
+static int __devinit efm32_usart_probe(struct platform_device *pdev)
+{
+	struct efm32_usart_port *efm_port;
+	struct resource *res;
+	int ret;
+
+	efm_port =3D kzalloc(sizeof(*efm_port), GFP_KERNEL);
+	if (!efm_port) {
+		dev_dbg(&pdev->dev, "failed to allocate private data\n");
+		return -ENOMEM;
+	}
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret =3D -ENODEV;
+		dev_dbg(&pdev->dev, "failed to determine base address\n");
+		goto err_get_base;
+	}
+
+	if (resource_size(res) < 60) {
+		ret =3D -EINVAL;
+		dev_dbg(&pdev->dev, "memory resource too small\n");
+		goto err_too_small;
+	}
+
+	ret =3D platform_get_irq(pdev, 0);
+	if (ret <=3D 0) {
+		dev_dbg(&pdev->dev, "failed to get rx irq\n");
+		goto err_get_rxirq;
+	}
+
+	efm_port->port.irq =3D ret;
+
+	ret =3D platform_get_irq(pdev, 1);
+	if (ret <=3D 0)
+		ret =3D efm_port->port.irq + 1;
+
+	efm_port->txirq =3D ret;
+
+	efm_port->port.dev =3D &pdev->dev;
+	efm_port->port.mapbase =3D res->start;
+	efm_port->port.type =3D PORT_EFMUSART;
+	efm_port->port.iotype =3D UPIO_MEM32;
+	efm_port->port.fifosize =3D 2;
+	efm_port->port.ops =3D &efm32_usart_pops;
+	efm_port->port.flags =3D UPF_BOOT_AUTOCONF;
+
+	ret =3D efm32_usart_probe_dt(pdev, efm_port);
+	if (ret > 0)
+		/* not created by device tree */
+		efm_port->port.line =3D pdev->id;
+
+	if (efm_port->port.line >=3D 0 &&
+			efm_port->port.line < ARRAY_SIZE(efm32_usart_ports))
+		efm32_usart_ports[efm_port->port.line] =3D efm_port;
+
+	ret =3D uart_add_one_port(&efm32_usart_reg, &efm_port->port);
+	if (ret) {
+		dev_dbg(&pdev->dev, "failed to add port: %d\n", ret);
+
+		if (pdev->id >=3D 0 && pdev->id < ARRAY_SIZE(efm32_usart_ports))
+			efm32_usart_ports[pdev->id] =3D NULL;
+err_get_rxirq:
+err_too_small:
+err_get_base:
+		kfree(efm_port);
+	} else {
+		platform_set_drvdata(pdev, efm_port);
+		dev_dbg(&pdev->dev, "\\o/\n");
+	}
+
+	return ret;
+}
+
+static int __devexit efm32_usart_remove(struct platform_device *pdev)
+{
+	struct efm32_usart_port *efm_port =3D platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	uart_remove_one_port(&efm32_usart_reg, &efm_port->port);
+
+	if (pdev->id >=3D 0 && pdev->id < ARRAY_SIZE(efm32_usart_ports))
+		efm32_usart_ports[pdev->id] =3D NULL;
+
+	kfree(efm_port);
+
+	return 0;
+}
+
+static struct of_device_id efm32_usart_dt_ids[] =3D {
+	{
+		.compatible =3D "efm32,usart",
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, efm32_usart_dt_ids);
+
+static struct platform_driver efm32_usart_driver =3D {
+	.probe =3D efm32_usart_probe,
+	.remove =3D __devexit_p(efm32_usart_remove),
+
+	.driver =3D {
+		.name =3D DRIVER_NAME,
+		.owner =3D THIS_MODULE,
+		.of_match_table =3D efm32_usart_dt_ids,
+	},
+};
+
+static int __init efm32_usart_init(void)
+{
+	int ret;
+
+	ret =3D uart_register_driver(&efm32_usart_reg);
+	if (ret)
+		return ret;
+
+	ret =3D platform_driver_register(&efm32_usart_driver);
+	if (ret)
+		uart_unregister_driver(&efm32_usart_reg);
+
+	pr_info("EFM32 USART driver\n");
+
+	return ret;
+}
+module_init(efm32_usart_init);
+
+static void __exit efm32_usart_exit(void)
+{
+	platform_driver_unregister(&efm32_usart_driver);
+	uart_unregister_driver(&efm32_usart_reg);
+}
+
+MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>");
+MODULE_DESCRIPTION("EFM32 USART driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index eadf33d..eb45d4d 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -207,6 +207,8 @@
 /* Xilinx PSS UART */
 #define PORT_XUARTPS	98
=20
+#define PORT_EFMUSART   99
+
 #ifdef __KERNEL__
=20
 #include <linux/compiler.h>
--=20
1.7.7.3

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
