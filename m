From: jon@ringle.org
Subject: [PATCH] RFC: WIP: sc16is7xx [v0.4]
Date: Mon, 10 Mar 2014 02:26:17 -0400
Message-ID: <1394432777-13005-1-git-send-email-jon@ringle.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:49690 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaCJG0b (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Mar 2014 02:26:31 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>

=46rom: Jon Ringle <jringle@gridpoint.com>

I started over and rewrote this driver patternized on sccnxp.c

However, I am still experiencing major latency problems with this drive=
r at
19200 speeds.

The method that I'm testing is simply transferring a small file just ov=
er
4k in size.

On the target platform I do:
$ socat /dev/ttySC0,raw,echo=3D0,b19200 - > rx-file

On my development machine, I do:
$ socat /dev/ttyUSB1,echo=3D0,raw,time=3D1,min=3D255,b19200 FILE:./tx-f=
ile

When the socat running on the development machine returns to the prompt=
,
it has transmitted all the bytes in tx-file. I then kill the socat runn=
ing
on the target platform. Success is defined as rx-file being identical t=
o
tx-file. However, I find that even at only 19200, this driver fails to
receive all bytes sent.

I welcome any and all comments.

Thank you,
Jon

Signed-off-by: Jon Ringle <jringle@gridpoint.com>
---
 drivers/tty/serial/Kconfig       |   7 +
 drivers/tty/serial/Makefile      |   1 +
 drivers/tty/serial/sc16is7xx.c   | 730 +++++++++++++++++++++++++++++++=
++++++++
 include/uapi/linux/serial_core.h |   3 +
 4 files changed, 741 insertions(+)
 create mode 100644 drivers/tty/serial/sc16is7xx.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index febd45c..1dfaeec 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1179,6 +1179,13 @@ config SERIAL_SCCNXP_CONSOLE
 	help
 	  Support for console on SCCNXP serial ports.
=20
+config SERIAL_SC16IS7XX
+	tristate "SC16IS7xx RS485 serial support"
+	  select SERIAL_CORE
+	  default n
+	  help
+	  This selects support for SC16IS7xx for use as a RS485 serial port
+
 config SERIAL_BFIN_SPORT
 	tristate "Blackfin SPORT emulate UART"
 	depends on BLACKFIN
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 3068c77..c3bac45 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_SERIAL_SB1250_DUART) +=3D sb1250-duart.o
 obj-$(CONFIG_ETRAX_SERIAL) +=3D crisv10.o
 obj-$(CONFIG_SERIAL_SC26XX) +=3D sc26xx.o
 obj-$(CONFIG_SERIAL_SCCNXP) +=3D sccnxp.o
+obj-$(CONFIG_SERIAL_SC16IS7XX) +=3D sc16is7xx.o
 obj-$(CONFIG_SERIAL_JSM) +=3D jsm/
 obj-$(CONFIG_SERIAL_TXX9) +=3D serial_txx9.o
 obj-$(CONFIG_SERIAL_VR41XX) +=3D vr41xx_siu.o
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
new file mode 100644
index 0000000..26268fa7
--- /dev/null
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -0,0 +1,730 @@
+/*
+ * SC16IS740/750/760 tty serial driver - Copyright (C) 2014 GridPoint
+ *
+ *  Based on sccnxp.c, by Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * The SC16IS740/750/760 is a slave I2C-bus/SPI interface to a single-=
channel
+ * high performance UART. The SC16IS740/750/760=E2=80=99s internal reg=
ister set is
+ * backward-compatible with the widely used and widely popular 16C450.
+ *
+ * The SC16IS740/750/760 also provides additional advanced features su=
ch as
+ * auto hardware and software flow control, automatic RS-485 support, =
and
+ * software reset.
+ *
+ * Notes:
+ *
+ * The sc16is740 driver is used for the GPEC RS485 Half duplex communi=
cation.
+ *
+ * In the EC1K board the sc16is740 RTS line is connected to a SN65HVD1=
780DR
+ * chip which is used to signal the RS485 direction.
+ * When RTS is low, the RS485 direction is set to output from the CPU.
+ *
+ * To set the RS485 direction we use the sc16is740 internal RS485 feat=
ure
+ * where the chip drives the RTS line when the data is written to the =
TX FIFO
+ * (see the spec note for the EFCR[4] bit configuration).
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/console.h>
+#include <linux/gpio.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/serial_reg.h>
+#include <linux/io.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/serial-sc16is7xx.h>
+#include <linux/i2c.h>
+
+#define DRV_NAME	"sc16is7xx"
+#define DRV_VERSION	"0.4"
+#define SC16IS7XX_MAJOR	204
+#define SC16IS7XX_MINOR	8
+
+#define SC16IS7XX_HAVE_IO		0x00000001
+
+/* General registers set */
+#define SC16IS7XX_TCR		0x06
+#define SC16IS7XX_TLR		0x07
+#define SC16IS7XX_TXLVL		0x08
+#define SC16IS7XX_RXLVL		0x09
+#define SC16IS7XX_EFCR		0x0F
+
+struct sc16is7xx_chip {
+	const char		*name;
+	unsigned int		nr;
+	unsigned int		flags;
+	unsigned int		fifosize;
+};
+
+struct sc16is7xx_port {
+	struct uart_driver	uart;
+	struct uart_port	port[SC16IS7XX_MAX_UARTS];
+	bool			opened[SC16IS7XX_MAX_UARTS];
+
+	struct i2c_client	*client;
+
+	int			irq;
+	u8			ier;
+
+	struct sc16is7xx_chip	*chip;
+
+	spinlock_t		lock;
+
+	struct sc16is7xx_pdata	pdata;
+};
+
+static const struct sc16is7xx_chip sc16is740 =3D {
+	.name		=3D "SC16IS740",
+	.nr		=3D 1,
+	.flags		=3D 0,
+	.fifosize	=3D 64,
+};
+
+static const struct sc16is7xx_chip sc16is750 =3D {
+	.name		=3D "SC16IS750",
+	.nr		=3D 1,
+	.flags		=3D SC16IS7XX_HAVE_IO,
+	.fifosize	=3D 64,
+};
+
+static const struct sc16is7xx_chip sc16is760 =3D {
+	.name		=3D "SC16IS760",
+	.nr		=3D 1,
+	.flags		=3D SC16IS7XX_HAVE_IO,
+	.fifosize	=3D 64,
+};
+
+static inline u8 sc16is7xx_read(struct uart_port *port, u8 reg)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+	int rc;
+	u8 val =3D 0;
+	u8 sc_reg =3D ((reg & 0x0f) << port->regshift);
+
+	rc =3D i2c_master_send(s->client, &sc_reg, 1);
+	if (rc < 0) {
+		dev_err(&s->client->dev,
+			"%s I2C error writing the i2c client rc =3D %d\n",
+			__func__, rc);
+		goto out;
+	}
+
+	rc =3D i2c_master_recv(s->client, &val, 1);
+	if (rc < 0)
+		dev_err(&s->client->dev,
+			"%s I2C error reading from the i2c client rc =3D %d\n",
+			__func__, rc);
+
+out:
+	return val;
+}
+
+static inline void sc16is7xx_write(struct uart_port *port, u8 reg, u8 =
v)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+	int rc;
+	u8 msg[2];
+
+	msg[0] =3D ((reg & 0x0f) << port->regshift);
+	msg[1] =3D v;
+
+	rc =3D i2c_master_send(s->client, msg, 2);
+	if (rc < 0)
+		dev_err(&s->client->dev,
+			"%s I2C error writing the i2c client rc =3D %d\n",
+			__func__, rc);
+}
+
+static void sc16is7xx_set_baud(struct uart_port *port, int baud)
+{
+	u8 lcr;
+	u32 divisor;
+
+	lcr =3D sc16is7xx_read(port, UART_LCR);
+
+	/* Disable TX/RX */
+	sc16is7xx_write(port, SC16IS7XX_EFCR, 0x06);
+
+	/* Open the LCR divisors for configuration */
+	sc16is7xx_write(port, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	/* Enable enhanced features and internal clock divider */
+	sc16is7xx_write(port, UART_EFR, 0x10);
+
+	/* Set the input clock divisor to 1 */
+	sc16is7xx_write(port, UART_MCR, UART_MCR_CLKSEL|4);
+
+	/* Get the baudrate divisor from the upper port layer */
+	divisor =3D uart_get_divisor(port, baud);
+
+	/* Write the new divisor */
+	sc16is7xx_write(port, UART_DLL, divisor & 0xff);
+	sc16is7xx_write(port, UART_DLM, (divisor >> 8) & 0xff);
+
+	/* Put LCR back to the normal mode */
+	sc16is7xx_write(port, UART_LCR, lcr);
+
+	sc16is7xx_write(port, SC16IS7XX_TLR, 0x0f);
+
+	/* Enable the FIFOs */
+	sc16is7xx_write(port, UART_FCR, UART_FCR_ENABLE_FIFO);
+
+	/* Enable the Rx and Tx and  control the RTS (RS485_DIR) line */
+	sc16is7xx_write(port, SC16IS7XX_EFCR, 0x10);
+}
+
+static void sc16is7xx_enable_irq(struct uart_port *port, int mask)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+
+	s->ier |=3D mask;
+	sc16is7xx_write(port, UART_IER, s->ier);
+}
+
+static void sc16is7xx_disable_irq(struct uart_port *port, int mask)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+
+	s->ier &=3D ~mask;
+	sc16is7xx_write(port, UART_IER, s->ier);
+}
+
+static void sc16is7xx_handle_rx(struct uart_port *port)
+{
+	u8 lsr;
+	unsigned int ch, flag;
+
+	for (;;) {
+		lsr =3D sc16is7xx_read(port, UART_LSR);
+		if (!(lsr & (UART_LSR_DR | UART_LSR_BI)))
+			break;
+		lsr &=3D UART_LSR_BRK_ERROR_BITS;
+
+		ch =3D sc16is7xx_read(port, UART_RX);
+
+		port->icount.rx++;
+		flag =3D TTY_NORMAL;
+
+		if (unlikely(lsr)) {
+			if (lsr & UART_LSR_BI) {
+				port->icount.brk++;
+				lsr &=3D ~(UART_LSR_FE | UART_LSR_PE);
+
+				if (uart_handle_break(port))
+					continue;
+			} else if (lsr & UART_LSR_PE)
+				port->icount.parity++;
+			else if (lsr & UART_LSR_FE)
+				port->icount.frame++;
+			else if (lsr & UART_LSR_OE) {
+				port->icount.overrun++;
+			}
+
+			lsr &=3D port->read_status_mask;
+			if (lsr & UART_LSR_BI)
+				flag =3D TTY_BREAK;
+			else if (lsr & UART_LSR_PE)
+				flag =3D TTY_PARITY;
+			else if (lsr & UART_LSR_FE)
+				flag =3D TTY_FRAME;
+			else if (lsr & UART_LSR_OE)
+				flag =3D TTY_OVERRUN;
+		}
+
+		if (uart_handle_sysrq_char(port, ch))
+			continue;
+
+		if (lsr & port->ignore_status_mask)
+			continue;
+
+		uart_insert_char(port, lsr, UART_LSR_OE, ch, flag);
+	}
+
+	tty_flip_buffer_push(&port->state->port);
+}
+
+static void sc16is7xx_handle_tx(struct uart_port *port)
+{
+	u8 lsr;
+	struct circ_buf *xmit =3D &port->state->xmit;
+
+	if (unlikely(port->x_char)) {
+		sc16is7xx_write(port, UART_TX, port->x_char);
+		port->icount.tx++;
+		port->x_char =3D 0;
+		return;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		/* Disable TX if FIFO is empty */
+		if (sc16is7xx_read(port, UART_LSR) & UART_LSR_THRE)
+			sc16is7xx_disable_irq(port, UART_IER_THRI);
+		return;
+	}
+
+	while (!uart_circ_empty(xmit)) {
+		lsr =3D sc16is7xx_read(port, UART_LSR);
+		if (!(lsr & UART_LSR_THRE))
+			break;
+
+		sc16is7xx_write(port, UART_TX, xmit->buf[xmit->tail]);
+		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
+
+static void sc16is7xx_handle_events(struct sc16is7xx_port *s)
+{
+	int i;
+	u8 iir;
+
+	do {
+		iir =3D sc16is7xx_read(&s->port[0], UART_IIR);
+		if (!(((iir & UART_IIR_THRI) && (s->ier & UART_IER_THRI))
+		    ||((iir & UART_IIR_RDI) && (s->ier & UART_IER_RDI))))
+			break;
+
+		for (i =3D 0; i < s->uart.nr; i++) {
+			if (s->opened[i] && (iir & UART_IIR_RDI))
+				sc16is7xx_handle_rx(&s->port[i]);
+			if (s->opened[i] && (iir & UART_IIR_THRI))
+				sc16is7xx_handle_tx(&s->port[i]);
+		}
+	} while (1);
+}
+
+static irqreturn_t sc16is7xx_ist(int irq, void *dev_id)
+{
+	struct sc16is7xx_port *s =3D (struct sc16is7xx_port *)dev_id;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+	sc16is7xx_handle_events(s);
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static void sc16is7xx_start_tx(struct uart_port *port)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+	sc16is7xx_enable_irq(port, UART_IER_THRI);
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static void sc16is7xx_stop_tx(struct uart_port *port)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+	sc16is7xx_disable_irq(port, UART_IER_THRI);
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static void sc16is7xx_stop_rx(struct uart_port *port)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+	sc16is7xx_disable_irq(port, UART_IER_RDI);
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static unsigned int sc16is7xx_tx_empty(struct uart_port *port)
+{
+	u8 val;
+	unsigned long flags;
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+
+	spin_lock_irqsave(&s->lock, flags);
+	val =3D sc16is7xx_read(port, UART_LSR);
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	return (val & UART_LSR_THRE) ? TIOCSER_TEMT : 0;
+}
+
+static void sc16is7xx_enable_ms(struct uart_port *port)
+{
+	/* Do nothing */
+}
+
+static void sc16is7xx_set_mctrl(struct uart_port *port, unsigned int m=
ctrl)
+{
+	/* Do nothing */
+}
+
+static unsigned int sc16is7xx_get_mctrl(struct uart_port *port)
+{
+	/*
+	 * We do not have modem control lines in our RS485 port
+	 */
+	return TIOCM_DSR | TIOCM_CTS | TIOCM_CAR | TIOCM_RNG;
+}
+
+static void sc16is7xx_break_ctl(struct uart_port *port, int break_stat=
e)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+	unsigned long flags;
+	u8 lcr;
+
+	spin_lock_irqsave(&s->lock, flags);
+	lcr =3D sc16is7xx_read(port, UART_LCR);
+	lcr =3D (break_state ? (lcr | UART_LCR_SBC) : (lcr & ~UART_LCR_SBC));
+	sc16is7xx_write(port, UART_LCR, lcr);
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static void sc16is7xx_set_termios(struct uart_port *port,
+				  struct ktermios *termios, struct ktermios *old)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+	unsigned long flags;
+	u8 cval;
+	u8 fcr;
+	int baud;
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	/* Mask termios capabilities we don't support */
+	termios->c_cflag &=3D ~CMSPAR;
+
+	/* Disable RX & TX, reset break condition, status and FIFOs */
+	fcr =3D sc16is7xx_read(port, UART_FCR);
+	fcr |=3D UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
+	fcr &=3D ~UART_FCR_ENABLE_FIFO;
+	sc16is7xx_write(port, UART_FCR, fcr);
+
+	/* Word size */
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		cval =3D UART_LCR_WLEN5;
+		break;
+	case CS6:
+		cval =3D UART_LCR_WLEN6;
+		break;
+	case CS7:
+		cval =3D UART_LCR_WLEN7;
+		break;
+	case CS8:
+	default:
+		cval =3D UART_LCR_WLEN8;
+		break;
+	}
+
+	/* Parity */
+	if (termios->c_cflag & PARENB)
+		cval |=3D UART_LCR_PARITY;
+	if (!(termios->c_cflag & PARODD))
+		cval |=3D UART_LCR_EPAR;
+
+	/* Stop bits */
+	if (termios->c_cflag & CSTOPB)
+		cval |=3D UART_LCR_STOP;
+
+	/* Update desired format */
+	sc16is7xx_write(port, UART_LCR, cval);
+
+	/* Set read status mask */
+	port->read_status_mask =3D UART_LSR_OE;
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |=3D UART_LSR_PE | UART_LSR_FE;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		port->read_status_mask |=3D UART_LSR_BI;
+
+	/* Set status ignore mask */
+	port->ignore_status_mask =3D 0;
+	if (termios->c_iflag & IGNBRK)
+		port->ignore_status_mask |=3D UART_LSR_BI;
+	if (!(termios->c_cflag & CREAD))
+		port->ignore_status_mask |=3D UART_LSR_BRK_ERROR_BITS;
+
+	/* Setup baudrate */
+	baud =3D uart_get_baud_rate(port, termios, old, 50, 115200);
+	sc16is7xx_set_baud(port, baud);
+
+	/* Low latency since we Tx from the work queue */
+	port->state->port.low_latency =3D 1;
+
+	/* Update timeout according to new baud rate */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	/* Report actual baudrate back to core */
+	if (tty_termios_baud_rate(termios))
+		tty_termios_encode_baud_rate(termios, baud, baud);
+
+	/* Enable RX & TX */
+	sc16is7xx_write(port, UART_FCR, fcr | UART_FCR_ENABLE_FIFO);
+
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static int sc16is7xx_startup(struct uart_port *port)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	/* Disable IRQs to configure */
+	sc16is7xx_write(port, UART_IER, 0);
+
+	/* Now, initialize the UART */
+	sc16is7xx_write(port, UART_LCR, UART_LCR_WLEN8);
+
+	/*
+	 * Clear the FIFO buffers and disable them
+	 * (they will be reenabled in set_termios())
+	 */
+	while (sc16is7xx_read(port, UART_LSR) & (UART_LSR_DR | UART_LSR_BI)) =
{
+		/*
+		 * Empty the RX holding register to prevent printing
+		 * stale characters on the screen
+		 */
+		sc16is7xx_read(port, UART_RX);
+	}
+
+	/* Finally, enable interrupts */
+	sc16is7xx_enable_irq(port, UART_IER_RDI);
+
+	s->opened[port->line] =3D 1;
+
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	return 0;
+}
+
+static void sc16is7xx_shutdown(struct uart_port *port)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	s->opened[port->line] =3D 0;
+
+	/* Disable interrupts */
+	sc16is7xx_disable_irq(port, UART_IER_THRI | UART_IER_RDI);
+
+	/* Disable break condition and FIFOs */
+	sc16is7xx_write(port, UART_LCR,
+			    sc16is7xx_read(port, UART_LCR) & ~UART_LCR_SBC);
+	sc16is7xx_write(port, UART_FCR,
+			    (UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
+			     UART_FCR_CLEAR_XMIT));
+	sc16is7xx_write(port, UART_FCR, 0);
+
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static const char *sc16is7xx_type(struct uart_port *port)
+{
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+
+	return (port->type =3D=3D PORT_SC16IS7XX) ? s->chip->name : NULL;
+}
+
+static void sc16is7xx_release_port(struct uart_port *port)
+{
+	/* Do nothing */
+}
+
+static int sc16is7xx_request_port(struct uart_port *port)
+{
+	/* Do nothing */
+	return 0;
+}
+
+static void sc16is7xx_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE)
+		port->type =3D PORT_SC16IS7XX;
+}
+
+static int sc16is7xx_verify_port(struct uart_port *port, struct serial=
_struct *s)
+{
+	if ((s->type =3D=3D PORT_UNKNOWN) || (s->type =3D=3D PORT_SC16IS7XX))
+		return 0;
+	if (s->irq =3D=3D port->irq)
+		return 0;
+
+	return -EINVAL;
+}
+
+static const struct uart_ops sc16is7xx_ops =3D {
+	.tx_empty	=3D sc16is7xx_tx_empty,
+	.set_mctrl	=3D sc16is7xx_set_mctrl,
+	.get_mctrl	=3D sc16is7xx_get_mctrl,
+	.stop_tx	=3D sc16is7xx_stop_tx,
+	.start_tx	=3D sc16is7xx_start_tx,
+	.stop_rx	=3D sc16is7xx_stop_rx,
+	.enable_ms	=3D sc16is7xx_enable_ms,
+	.break_ctl	=3D sc16is7xx_break_ctl,
+	.startup	=3D sc16is7xx_startup,
+	.shutdown	=3D sc16is7xx_shutdown,
+	.set_termios	=3D sc16is7xx_set_termios,
+	.type		=3D sc16is7xx_type,
+	.release_port	=3D sc16is7xx_release_port,
+	.request_port	=3D sc16is7xx_request_port,
+	.config_port	=3D sc16is7xx_config_port,
+	.verify_port	=3D sc16is7xx_verify_port,
+};
+
+static const struct i2c_device_id sc16is7xx_id_table[] =3D {
+	{ .name =3D "sc16is740",	.driver_data =3D (kernel_ulong_t)&sc16is740,=
 },
+	{ .name =3D "sc16is750",	.driver_data =3D (kernel_ulong_t)&sc16is750,=
 },
+	{ .name =3D "sc16is760",	.driver_data =3D (kernel_ulong_t)&sc16is760,=
 },
+	{ }
+};
+
+static int sc16is7xx_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	struct sc16is7xx_pdata *pdata =3D dev_get_platdata(&client->dev);
+	int i, ret;
+	struct sc16is7xx_port *s;
+
+	if (!pdata)
+		return -ENODEV;
+
+	s =3D devm_kzalloc(&client->dev, sizeof(struct sc16is7xx_port), GFP_K=
ERNEL);
+	if (!s) {
+		dev_err(&client->dev, "Error allocating port structure\n");
+		return -ENOMEM;
+	}
+
+	/* First check if adaptor is OK and it supports our I2C functionality=
 */
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "Can't find the sc16is7xx chip\n");
+		ret =3D -ENODEV;
+		goto err_out;
+	}
+
+	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n"=
);
+
+	spin_lock_init(&s->lock);
+
+	s->chip =3D (struct sc16is7xx_chip *)id->driver_data;
+
+	memcpy(&s->pdata, pdata, sizeof(struct sc16is7xx_pdata));
+
+	/* Configure the GPIO IRQ line */
+	ret =3D gpio_request(pdata->irq_pin, "SC16IS7xx INT");
+	if (ret) {
+		dev_err(&client->dev, "Can't request gpio interrupt pin\n");
+		ret =3D -EIO;
+		goto err_out;
+	}
+
+	/* Set GPIO IRQ pin to be input */
+	gpio_direction_input(pdata->irq_pin);
+
+	s->irq =3D gpio_to_irq(pdata->irq_pin);
+	if (s->irq < 0) {
+		dev_err(&client->dev, "Missing irq_pin data\n");
+		ret =3D -ENXIO;
+		goto err_out;
+	}
+
+	s->uart.owner		=3D THIS_MODULE;
+	s->uart.dev_name	=3D "ttySC";
+	s->uart.major		=3D SC16IS7XX_MAJOR;
+	s->uart.minor		=3D SC16IS7XX_MINOR;
+	s->uart.nr		=3D s->chip->nr;
+
+	ret =3D uart_register_driver(&s->uart);
+	if (ret) {
+		dev_err(&client->dev, "Registering UART driver failed\n");
+		goto err_out;
+	}
+
+	for (i =3D 0; i < s->uart.nr; i++) {
+		s->port[i].line		=3D i;
+		s->port[i].dev		=3D &client->dev;
+		s->port[i].irq		=3D s->irq;
+		s->port[i].type		=3D PORT_SC16IS7XX;
+		s->port[i].fifosize	=3D s->chip->fifosize;
+		s->port[i].flags	=3D UPF_SKIP_TEST | UPF_FIXED_TYPE;
+		s->port[i].regshift	=3D s->pdata.reg_shift;
+		s->port[i].uartclk	=3D s->pdata.uartclk;
+		s->port[i].ops		=3D &sc16is7xx_ops;
+		s->port[i].iotype	=3D UPIO_PORT;
+
+		uart_add_one_port(&s->uart, &s->port[i]);
+	}
+
+	s->client =3D client;
+	i2c_set_clientdata(client, s);
+
+	/* Disable interrupts */
+	s->ier =3D 0;
+	sc16is7xx_write(&s->port[0], UART_IER, 0);
+
+	ret =3D devm_request_threaded_irq(&client->dev, s->irq, NULL,
+					sc16is7xx_ist,
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT,
+					dev_name(&client->dev), s);
+	if (!ret)
+		return 0;
+
+	dev_err(&client->dev, "Unable to request IRQ %i\n", s->irq);
+
+err_out:
+	kfree(s);
+	return ret;
+}
+
+static int sc16is7xx_remove(struct i2c_client *client)
+{
+	int i;
+	struct sc16is7xx_port *s =3D i2c_get_clientdata(client);
+
+	devm_free_irq(&client->dev, s->irq, s);
+
+	for (i =3D 0; i < s->uart.nr; i++)
+		uart_remove_one_port(&s->uart, &s->port[i]);
+
+	kfree(s);
+	uart_unregister_driver(&s->uart);
+
+	return 0;
+}
+
+static struct i2c_driver sc16is7xx_driver =3D {
+	.driver =3D {
+		.name	=3D DRV_NAME,
+		.owner	=3D THIS_MODULE,
+	},
+	.probe		=3D sc16is7xx_probe,
+	.remove		=3D sc16is7xx_remove,
+	.id_table	=3D sc16is7xx_id_table,
+};
+
+module_i2c_driver(sc16is7xx_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Jon Ringle <jringle@gridpoint.com>");
+MODULE_DESCRIPTION("SC16IS7xx RS485 Port Driver");
+MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS("i2c:sc16is7xx");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/seri=
al_core.h
index b47dba2..a37c79a 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -238,4 +238,7 @@
 /* Tilera TILE-Gx UART */
 #define PORT_TILEGX	106
=20
+/* SC16IS74xx */
+#define PORT_SC16IS7XX   107
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
--=20
1.8.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
