From: =?ISO-8859-15?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: [PATCH 8/9] SERIAL: Added Timberdale UART driver
Date: Fri, 05 Jun 2009 15:41:53 +0200
Message-ID: <4A2920A1.40906@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756080AbZFENml@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Driver for the UART found in the Timberdale FPGA

Signed-off-by: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com>
---
Index: linux-2.6.30-rc7/drivers/serial/timbuart.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7/drivers/serial/timbuart.c	(revision 0)
+++ linux-2.6.30-rc7/drivers/serial/timbuart.c	(revision 864)
@@ -0,0 +1,520 @@
+/*
+ * timbuart.c timberdale FPGA UART driver
+ * Copyright (c) 2009 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* Supports:
+ * Timberdale FPGA UART
+ */
+
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/serial_core.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/ioport.h>
+
+#include "timbuart.h"
+
+struct timbuart_port {
+	struct uart_port	port;
+	struct tasklet_struct	tasklet;
+	int			usedma;
+	u8			last_ier;
+	struct platform_device  *dev;
+};
+
+static int baudrates[] =3D {9600, 19200, 38400, 57600, 115200, 230400,=
 460800,
+	921600, 1843200, 3250000};
+
+static void timbuart_mctrl_check(struct uart_port *port, u8 isr, u8 *i=
er);
+
+static irqreturn_t timbuart_handleinterrupt(int irq, void *devid);
+
+static void timbuart_stop_rx(struct uart_port *port)
+{
+	/* spin lock held by upper layer, disable all RX interrupts */
+	u8 ier =3D ioread8(port->membase + TIMBUART_IER) & ~RXFLAGS;
+	iowrite8(ier, port->membase + TIMBUART_IER);
+}
+
+static void timbuart_stop_tx(struct uart_port *port)
+{
+	/* spinlock held by upper layer, disable TX interrupt */
+	u8 ier =3D ioread8(port->membase + TIMBUART_IER) & ~TXBAE;
+	iowrite8(ier, port->membase + TIMBUART_IER);
+}
+
+static void timbuart_start_tx(struct uart_port *port)
+{
+	struct timbuart_port *uart =3D
+		container_of(port, struct timbuart_port, port);
+
+	/* do not transfer anything here -> fire off the tasklet */
+	tasklet_schedule(&uart->tasklet);
+}
+
+static void timbuart_flush_buffer(struct uart_port *port)
+{
+	u8 ctl =3D ioread8(port->membase + TIMBUART_CTRL) | TIMBUART_CTRL_FLS=
HTX;
+
+	iowrite8(ctl, port->membase + TIMBUART_CTRL);
+	iowrite8(TXBF, port->membase + TIMBUART_ISR);
+}
+
+static void timbuart_rx_chars(struct uart_port *port)
+{
+	struct tty_struct *tty =3D port->info->port.tty;
+
+	while (ioread8(port->membase + TIMBUART_ISR) & RXDP) {
+		u8 ch =3D ioread8(port->membase + TIMBUART_RXFIFO);
+		port->icount.rx++;
+		tty_insert_flip_char(tty, ch, TTY_NORMAL);
+	}
+
+	spin_unlock(&port->lock);
+	tty_flip_buffer_push(port->info->port.tty);
+	spin_lock(&port->lock);
+
+	dev_dbg(port->dev, "%s - total read %d bytes\n",
+		__func__, port->icount.rx);
+}
+
+static void timbuart_tx_chars(struct uart_port *port)
+{
+	struct circ_buf *xmit =3D &port->info->xmit;
+
+	while (!(ioread8(port->membase + TIMBUART_ISR) & TXBF) &&
+		!uart_circ_empty(xmit)) {
+		iowrite8(xmit->buf[xmit->tail],
+			port->membase + TIMBUART_TXFIFO);
+		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+	}
+
+	dev_dbg(port->dev,
+		"%s - total written %d bytes, CTL: %x, RTS: %x, baud: %x\n",
+		 __func__,
+		port->icount.tx,
+		ioread8(port->membase + TIMBUART_CTRL),
+		port->mctrl & TIOCM_RTS,
+		ioread8(port->membase + TIMBUART_BAUDRATE));
+}
+
+static void timbuart_handle_tx_port(struct uart_port *port, u8 isr, u8=
 *ier)
+{
+	struct timbuart_port *uart =3D
+		container_of(port, struct timbuart_port, port);
+	struct circ_buf *xmit =3D &port->info->xmit;
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+		return;
+
+	if (port->x_char)
+		return;
+
+	if (isr & TXFLAGS) {
+		timbuart_tx_chars(port);
+		/* clear all TX interrupts */
+		iowrite8(TXFLAGS, port->membase + TIMBUART_ISR);
+
+		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+			uart_write_wakeup(port);
+	} else
+		/* Re-enable any tx interrupt */
+		*ier |=3D uart->last_ier & TXFLAGS;
+
+	/* enable interrupts if there are chars in the transmit buffer,
+	 * Or if we delivered some bytes and want the almost empty interrupt
+	 * we wake up the upper layer later when we got the interrupt
+	 * to give it some time to go out...
+	 */
+	if (!uart_circ_empty(xmit))
+		*ier |=3D TXBAE;
+
+	dev_dbg(port->dev, "%s - leaving\n", __func__);
+}
+
+void timbuart_handle_rx_port(struct uart_port *port, u8 isr, u8 *ier)
+{
+	if (isr & RXFLAGS) {
+		/* Some RX status is set */
+		if (isr & RXBF) {
+			u8 ctl =3D ioread8(port->membase + TIMBUART_CTRL) |
+				TIMBUART_CTRL_FLSHRX;
+			iowrite8(ctl, port->membase + TIMBUART_CTRL);
+			port->icount.overrun++;
+		} else if (isr & (RXDP))
+			timbuart_rx_chars(port);
+
+		/* ack all RX interrupts */
+		iowrite8(RXFLAGS, port->membase + TIMBUART_ISR);
+	}
+
+	/* always have the RX interrupts enabled */
+	*ier |=3D RXBAF | RXBF | RXTT;
+
+	dev_dbg(port->dev, "%s - leaving\n", __func__);
+}
+
+void timbuart_tasklet(unsigned long arg)
+{
+	struct timbuart_port *uart =3D (struct timbuart_port *)arg;
+	u8 isr, ier =3D 0;
+
+	spin_lock(&uart->port.lock);
+
+	isr =3D ioread8(uart->port.membase + TIMBUART_ISR);
+	dev_dbg(uart->port.dev, "%s ISR: %x\n", __func__, isr);
+
+	if (!uart->usedma)
+		timbuart_handle_tx_port(&uart->port, isr, &ier);
+
+	timbuart_mctrl_check(&uart->port, isr, &ier);
+
+	if (!uart->usedma)
+		timbuart_handle_rx_port(&uart->port, isr, &ier);
+
+	iowrite8(ier, uart->port.membase + TIMBUART_IER);
+
+	spin_unlock(&uart->port.lock);
+	dev_dbg(uart->port.dev, "%s leaving\n", __func__);
+}
+
+static unsigned int timbuart_tx_empty(struct uart_port *port)
+{
+	u8 isr =3D ioread8(port->membase + TIMBUART_ISR);
+
+	return (isr & TXBAE) ? TIOCSER_TEMT : 0;
+}
+
+static unsigned int timbuart_get_mctrl(struct uart_port *port)
+{
+	u8 cts =3D ioread8(port->membase + TIMBUART_CTRL);
+	dev_dbg(port->dev, "%s - cts %x\n", __func__, cts);
+
+	if (cts & TIMBUART_CTRL_CTS)
+		return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+	else
+		return TIOCM_DSR | TIOCM_CAR;
+}
+
+static void timbuart_set_mctrl(struct uart_port *port, unsigned int mc=
trl)
+{
+	dev_dbg(port->dev, "%s - %x\n", __func__, mctrl);
+
+	if (mctrl & TIOCM_RTS)
+		iowrite8(TIMBUART_CTRL_RTS, port->membase + TIMBUART_CTRL);
+	else
+		iowrite8(TIMBUART_CTRL_RTS, port->membase + TIMBUART_CTRL);
+}
+
+static void timbuart_mctrl_check(struct uart_port *port, u8 isr, u8 *i=
er)
+{
+	unsigned int cts;
+
+	if (isr & CTS_DELTA) {
+		/* ack */
+		iowrite8(CTS_DELTA, port->membase + TIMBUART_ISR);
+		cts =3D timbuart_get_mctrl(port);
+		uart_handle_cts_change(port, cts & TIOCM_CTS);
+		wake_up_interruptible(&port->info->delta_msr_wait);
+	}
+
+	*ier |=3D CTS_DELTA;
+}
+
+static void timbuart_enable_ms(struct uart_port *port)
+{
+	/* N/A */
+}
+
+static void timbuart_break_ctl(struct uart_port *port, int ctl)
+{
+	/* N/A */
+}
+
+static int timbuart_startup(struct uart_port *port)
+{
+	struct timbuart_port *uart =3D
+		container_of(port, struct timbuart_port, port);
+
+	dev_dbg(port->dev, "%s\n", __func__);
+
+	iowrite8(TIMBUART_CTRL_FLSHRX, port->membase + TIMBUART_CTRL);
+	iowrite8(0xff, port->membase + TIMBUART_ISR);
+	/* Enable all but TX interrupts */
+	iowrite8(RXBAF | RXBF | RXTT | CTS_DELTA,
+		port->membase + TIMBUART_IER);
+
+	return request_irq(port->irq, timbuart_handleinterrupt, IRQF_SHARED,
+		"timb-uart", uart);
+}
+
+static void timbuart_shutdown(struct uart_port *port)
+{
+	struct timbuart_port *uart =3D
+		container_of(port, struct timbuart_port, port);
+	dev_dbg(port->dev, "%s\n", __func__);
+	free_irq(port->irq, uart);
+	iowrite8(0, port->membase + TIMBUART_IER);
+}
+
+static int get_bindex(int baud)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(baudrates); i++)
+		if (baud =3D=3D baudrates[i])
+			return i;
+
+	return -1;
+}
+
+static void timbuart_set_termios(struct uart_port *port,
+	struct ktermios *termios,
+	struct ktermios *old)
+{
+	unsigned int baud;
+	short bindex;
+	unsigned long flags;
+
+	baud =3D uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16=
);
+	bindex =3D get_bindex(baud);
+	dev_dbg(port->dev, "%s - bindex %d\n", __func__, bindex);
+
+	if (bindex < 0) {
+		printk(KERN_ALERT "timbuart: Unsupported baud rate\n");
+	} else {
+		spin_lock_irqsave(&port->lock, flags);
+		iowrite8((u8)bindex, port->membase + TIMBUART_BAUDRATE);
+		uart_update_timeout(port, termios->c_cflag, baud);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+}
+
+static const char *timbuart_type(struct uart_port *port)
+{
+	return port->type =3D=3D PORT_UNKNOWN ? "timbuart" : NULL;
+}
+
+/* We do not request/release mappings of the registers here,
+ * currently it's done in the proble function.
+ */
+static void timbuart_release_port(struct uart_port *port)
+{
+	struct platform_device *pdev =3D to_platform_device(port->dev);
+	int size =3D
+		resource_size(platform_get_resource(pdev, IORESOURCE_MEM, 0));
+
+	if (port->flags & UPF_IOREMAP) {
+		iounmap(port->membase);
+		port->membase =3D NULL;
+	}
+
+	release_mem_region(port->mapbase, size);
+}
+
+static int timbuart_request_port(struct uart_port *port)
+{
+	struct platform_device *pdev =3D to_platform_device(port->dev);
+	int size =3D
+		resource_size(platform_get_resource(pdev, IORESOURCE_MEM, 0));
+
+	if (!request_mem_region(port->mapbase, size, "timb-uart"))
+		return -EBUSY;
+
+	if (port->flags & UPF_IOREMAP) {
+		port->membase =3D ioremap(port->mapbase, size);
+		if (port->membase =3D=3D NULL) {
+			release_mem_region(port->mapbase, size);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t timbuart_handleinterrupt(int irq, void *devid)
+{
+	struct timbuart_port *uart =3D (struct timbuart_port *)devid;
+
+	if (ioread8(uart->port.membase + TIMBUART_IPR)) {
+		uart->last_ier =3D ioread8(uart->port.membase + TIMBUART_IER);
+
+		/* disable interrupts, the tasklet enables them again */
+		iowrite8(0, uart->port.membase + TIMBUART_IER);
+
+		/* fire off bottom half */
+		tasklet_schedule(&uart->tasklet);
+
+		return IRQ_HANDLED;
+	} else
+		return IRQ_NONE;
+}
+
+/*
+ * Configure/autoconfigure the port.
+ */
+static void timbuart_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE) {
+		port->type =3D PORT_TIMBUART;
+		timbuart_request_port(port);
+	}
+}
+
+static int timbuart_verify_port(struct uart_port *port,
+	struct serial_struct *ser)
+{
+	/* we don't want the core code to modify any port params */
+	return -EINVAL;
+}
+
+static struct uart_ops timbuart_ops =3D {
+	.tx_empty =3D timbuart_tx_empty,
+	.set_mctrl =3D timbuart_set_mctrl,
+	.get_mctrl =3D timbuart_get_mctrl,
+	.stop_tx =3D timbuart_stop_tx,
+	.start_tx =3D timbuart_start_tx,
+	.flush_buffer =3D timbuart_flush_buffer,
+	.stop_rx =3D timbuart_stop_rx,
+	.enable_ms =3D timbuart_enable_ms,
+	.break_ctl =3D timbuart_break_ctl,
+	.startup =3D timbuart_startup,
+	.shutdown =3D timbuart_shutdown,
+	.set_termios =3D timbuart_set_termios,
+	.type =3D timbuart_type,
+	.release_port =3D timbuart_release_port,
+	.request_port =3D timbuart_request_port,
+	.config_port =3D timbuart_config_port,
+	.verify_port =3D timbuart_verify_port
+};
+
+static struct uart_driver timbuart_driver =3D {
+	.owner =3D THIS_MODULE,
+	.driver_name =3D "timberdale_uart",
+	.dev_name =3D "ttyTU",
+	.major =3D TIMBUART_MAJOR,
+	.minor =3D TIMBUART_MINOR,
+	.nr =3D 1
+};
+
+static int timbuart_probe(struct platform_device *dev)
+{
+	int err;
+	struct timbuart_port *uart;
+	struct resource *iomem;
+
+	dev_dbg(&dev->dev, "%s\n", __func__);
+
+	uart =3D kzalloc(sizeof(*uart), GFP_KERNEL);
+	if (!uart) {
+		err =3D -EINVAL;
+		goto err_mem;
+	}
+
+	uart->usedma =3D 0;
+
+	uart->port.uartclk =3D 3250000 * 16;
+	uart->port.fifosize  =3D TIMBUART_FIFO_SIZE;
+	uart->port.regshift  =3D 2;
+	uart->port.iotype  =3D UPIO_MEM;
+	uart->port.ops =3D &timbuart_ops;
+	uart->port.irq =3D 0;
+	uart->port.flags =3D UPF_BOOT_AUTOCONF | UPF_IOREMAP;
+	uart->port.line  =3D 0;
+	uart->port.dev	=3D &dev->dev;
+
+	iomem =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!iomem) {
+		err =3D -ENOMEM;
+		goto err_register;
+	}
+	uart->port.mapbase =3D iomem->start;
+	uart->port.membase =3D NULL;
+
+	uart->port.irq =3D platform_get_irq(dev, 0);
+	if (uart->port.irq < 0) {
+		err =3D -EINVAL;
+		goto err_register;
+	}
+
+	tasklet_init(&uart->tasklet, timbuart_tasklet, (unsigned long)uart);
+
+	err =3D uart_register_driver(&timbuart_driver);
+	if (err)
+		goto err_register;
+
+	err =3D uart_add_one_port(&timbuart_driver, &uart->port);
+	if (err)
+		goto err_add_port;
+
+	platform_set_drvdata(dev, uart);
+
+	return 0;
+
+err_add_port:
+	uart_unregister_driver(&timbuart_driver);
+err_register:
+	kfree(uart);
+err_mem:
+	printk(KERN_ERR "timberdale: Failed to register Timberdale UART: %d\n=
",
+		err);
+
+	return err;
+}
+
+static int timbuart_remove(struct platform_device *dev)
+{
+	struct timbuart_port *uart =3D platform_get_drvdata(dev);
+
+	tasklet_kill(&uart->tasklet);
+	uart_remove_one_port(&timbuart_driver, &uart->port);
+	uart_unregister_driver(&timbuart_driver);
+	kfree(uart);
+
+	return 0;
+}
+
+static struct platform_driver timbuart_platform_driver =3D {
+	.driver =3D {
+		.name	=3D "timb-uart",
+		.owner	=3D THIS_MODULE,
+	},
+	.probe		=3D timbuart_probe,
+	.remove		=3D timbuart_remove,
+};
+
+/*--------------------------------------------------------------------=
------*/
+
+static int __init timbuart_init(void)
+{
+	return platform_driver_register(&timbuart_platform_driver);
+}
+
+static void __exit timbuart_exit(void)
+{
+	platform_driver_unregister(&timbuart_platform_driver);
+}
+
+module_init(timbuart_init);
+module_exit(timbuart_exit);
+
+MODULE_DESCRIPTION("Timberdale UART driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:timb-uart");
+
Index: linux-2.6.30-rc7/drivers/serial/timbuart.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7/drivers/serial/timbuart.h	(revision 0)
+++ linux-2.6.30-rc7/drivers/serial/timbuart.h	(revision 864)
@@ -0,0 +1,58 @@
+/*
+ * timbuart.c timberdale FPGA GPIO driver
+ * Copyright (c) 2009 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* Supports:
+ * Timberdale FPGA UART
+ */
+
+#ifndef _TIMBUART_H
+#define _TIMBUART_H
+
+#define TIMBUART_FIFO_SIZE	2048
+
+#define TIMBUART_RXFIFO		0x08
+#define TIMBUART_TXFIFO		0x0c
+#define TIMBUART_IER		0x10
+#define TIMBUART_IPR		0x14
+#define TIMBUART_ISR		0x18
+#define TIMBUART_CTRL		0x1c
+#define TIMBUART_BAUDRATE	0x20
+
+#define TIMBUART_CTRL_RTS	0x01
+#define TIMBUART_CTRL_CTS	0x02
+#define TIMBUART_CTRL_FLSHTX	0x40
+#define TIMBUART_CTRL_FLSHRX	0x80
+
+#define TXBF		0x01
+#define TXBAE		0x02
+#define CTS_DELTA	0x04
+#define RXDP		0x08
+#define RXBAF		0x10
+#define RXBF		0x20
+#define RXTT		0x40
+#define RXBNAE		0x80
+#define TXBE		0x100
+
+#define RXFLAGS (RXDP | RXBAF | RXBF | RXTT | RXBNAE)
+#define TXFLAGS (TXBF | TXBAE)
+
+#define TIMBUART_MAJOR 204
+#define TIMBUART_MINOR 192
+
+#endif /* _TIMBUART_H */
+
Index: linux-2.6.30-rc7/drivers/serial/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7/drivers/serial/Makefile	(revision 861)
+++ linux-2.6.30-rc7/drivers/serial/Makefile	(working copy)
@@ -77,3 +77,4 @@
 obj-$(CONFIG_SERIAL_KS8695) +=3D serial_ks8695.o
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) +=3D kgdboc.o
 obj-$(CONFIG_SERIAL_QE) +=3D ucc_uart.o
+obj-$(CONFIG_SERIAL_TIMBERDALE)	+=3D timbuart.o
Index: linux-2.6.30-rc7/drivers/serial/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7/drivers/serial/Kconfig	(revision 861)
+++ linux-2.6.30-rc7/drivers/serial/Kconfig	(working copy)
@@ -1433,4 +1433,11 @@
 	default 19200 if (SERIAL_SPORT_BAUD_RATE_19200)
 	default 9600 if (SERIAL_SPORT_BAUD_RATE_9600)

+config SERIAL_TIMBERDALE
+	tristate "Support for timberdale UART"
+	depends on MFD_TIMBERDALE
+	select SERIAL_CORE
+	---help---
+	Add support for UART controller on timberdale.
+
 endmenu
Index: linux-2.6.30-rc7/include/linux/serial_core.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7/include/linux/serial_core.h	(revision 861)
+++ linux-2.6.30-rc7/include/linux/serial_core.h	(working copy)
@@ -167,6 +167,9 @@
 /* MAX3100 */
 #define PORT_MAX3100    86

+/* Timberdale UART */
+#define PORT_TIMBUART	87
+
 #ifdef __KERNEL__

 #include <linux/compiler.h>
