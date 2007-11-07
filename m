From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH 09/12] ns9xxx: serial driver for ns921x SoC
Date: Wed,  7 Nov 2007 08:39:49 +0100
Message-ID: <1194421189-15881-1-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:62267 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757865AbXKGITB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Nov 2007 03:19:01 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>

=46rom: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
---
Hello,

[I tried to send this patch already yesterday from my work's address,
but it seems to have problems to send to vger.  So I resend from my
private address in the hope that I don't annoy to much if the first pos=
t
will make it through sometime later.]

This driver is not yet completly finished, I still have an issue loosin=
g
characters.

By tracking TXIRQPENDING made all characters appear as expected, but
still I'm not sure if this is the problem because I have no explanation
why this should change anything.  The idea came after seeing that
ns921x_uart_tx_chars is called most of the time from
ns921x_uart_start_tx and not as I expected from ns921x_uart_int.  Is
this an expected behaviour or do I have specified some values wrong?

Moreover I have a few open questions and some suggestions, some of them
are marked with XXX in the code:

 - NS912X_TTY_MAJOR and NS912X_TTY_MINOR_START are stolen from
   serial_txx9.  Before this patch can go in, I still need to reserve
   some numbers for ns921x.  I didn't want to do that before the driver
   got some review.

 - should I call ns921x_uart_check_msr only if I got a modem status irq=
?

 - release_mem_region is marked as "Compatibility cruft" in
   include/linux/ioport.h.  Is that correct, do I use it in the right
   way?  (Same for amba-pl011.c)

 - The clk API states that clk_get_rate is only to be called if the
   clock is enabled.  I think (read, I didn't check) that
   ns921x_uart_console_setup calls clk_get_rate without asserting that
   the clock is enabled.  (Same for amba-pl011.c)

 - About fifosize:  The device allows to write 16 times up to four
   characters to the fifo.  I don't understand what port.fifosize is
   used for, so I don't know if I should use 16 or 64.

 - Documentation/serial/driver, get_mctrl(...)
     s/TIOCM_DCD/TIOCM_CAR/
     s/TIOCM_RI/TIOCM_RNG/

 - Documentation/serial/driver uses port_sem and port->lock to describe
   locking of several functions.  Are both terms supposed to mean the
   same?  If so, I suggest to use only one.  If not I might want to
   rethink locking in the driver.

 - Looking at break_ctl, Documentation states to test ctl for !=3D 0,
   drivers/serial/amba-pl011.c tests for =3D=3D -1

 - sparse reports

 	warning: context imbalance in 'ns921x_uart_rx_chars' - unexpected unl=
ock

   that's something amba-pl011.c suffers from, too.

 - Is it correct to use include/linux/ns921x-serial.h?  I still need to
   check if I need some #ifdef KERNEL or something.

I'm looking forward to any comments, best regards
Uwe

 drivers/serial/Kconfig         |   15 +
 drivers/serial/Makefile        |    1 +
 drivers/serial/ns921x-serial.c | 1038 ++++++++++++++++++++++++++++++++=
++++++++
 include/linux/ns921x-serial.h  |   23 +
 include/linux/serial_core.h    |    2 +
 5 files changed, 1079 insertions(+), 0 deletions(-)
 create mode 100644 drivers/serial/ns921x-serial.c
 create mode 100644 include/linux/ns921x-serial.h

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index ed438bc..1f89ba7 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1284,4 +1284,19 @@ config SERIAL_OF_PLATFORM
 	  Currently, only 8250 compatible ports are supported, but
 	  others can easily be added.
=20
+config SERIAL_NS921X
+	tristate "NetSilicon 921x serial port support"
+	depends on ARM && ARCH_NS9XXX && PROCESSOR_NS921X
+	select SERIAL_CORE
+	help
+	  If you have a Digi NS921x based system and wish to use its serial
+	  ports, say Y or M here
+
+config SERIAL_NS921X_CONSOLE
+	bool "Console on NetSilicon 921x serial
+	depends on SERIAL_NS921X
+	select SERIAL_CORE_CONSOLE
+	help
+	  Console support for serial ports of Digi NS921x based systems
+
 endmenu
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index af6377d..bb732b9 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -64,3 +64,4 @@ obj-$(CONFIG_SERIAL_UARTLITE) +=3D uartlite.o
 obj-$(CONFIG_SERIAL_NETX) +=3D netx-serial.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM) +=3D of_serial.o
 obj-$(CONFIG_SERIAL_KS8695) +=3D serial_ks8695.o
+obj-$(CONFIG_SERIAL_NS921X) +=3D ns921x-serial.o
diff --git a/drivers/serial/ns921x-serial.c b/drivers/serial/ns921x-ser=
ial.c
new file mode 100644
index 0000000..cfad6f2
--- /dev/null
+++ b/drivers/serial/ns921x-serial.c
@@ -0,0 +1,1038 @@
+/*
+ * drivers/serial/ns921x-serial.c
+ *
+ * Copyright (C) 2007 by Digi International Inc.
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished by
+ * the Free Software Foundation.
+ */
+#if defined(CONFIG_SERIAL_NS921X_CONSOLE) && defined(CONFIG_MAGIC_SYSR=
Q)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/io.h>
+#include <linux/ns921x-serial.h>
+#include <linux/platform_device.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+
+#define HUB_IFS		0x0000
+#define HUB_IFS_MODIP		(1 << 18)
+#define HUB_IFS_RXFE		(1 << 13)
+#define HUB_IFS_TXFF		(1 << 11)
+#define HUB_IFS_TXFE		(1 << 10)
+
+#define HUB_DMARXCTRL	0x0004
+#define HUB_DMARXCTRL_DIRECT	(1 << 28)
+
+#define HUB_DMRXSF	0x0010
+#define HUB_DMRXSF_BYTE		(7 << 9)
+#define HUB_DMRXSF_FULL		(1 << 7)
+
+#define HUB_DMRXDF	0x0014
+
+#define HUB_DMATXCTRL	0x0018
+#define HUB_DMATXCTRL_DIRECT	(1 << 28)
+
+#define HUB_TXIC	0x0020
+#define HUB_TXIC_TXFUFIE	(1 << 26)
+
+#define HUB_DMTXDF	0x0028
+
+#define UART_WC		0x1000
+#define UART_WC_RXEN		(1 << 30)
+#define UART_WC_TXEN		(1 << 29)
+#define UART_WC_RXFLUSH		(1 << 17)
+#define UART_WC_TXFLUSH		(1 << 16)
+
+#define UART_IE		0x1004
+#define UART_IE_OFLOW		(1 << 19)
+#define UART_IE_PARITY		(1 << 18)
+#define UART_IE_FRAME		(1 << 17)
+#define UART_IE_BREAK		(1 << 16)
+#define UART_IE_DSR		(1 <<  7)
+#define UART_IE_DCD		(1 <<  6)
+#define UART_IE_CTS		(1 <<  5)
+#define UART_IE_RI		(1 <<  4)
+#define UART_IE_TBC		(1 <<  3)
+#define UART_IE_RBC		(1 <<  2)
+#define UART_IE_TXIDLE		(1 <<  1)
+
+#define UART_IS		0x1008
+#define UART_IS_OFLOW		(1 << 19)
+#define UART_IS_PARITY		(1 << 18)
+#define UART_IS_FRAME		(1 << 17)
+#define UART_IS_BREAK		(1 << 16)
+#define UART_IS_DSR		(1 <<  7)
+#define UART_IS_DCD		(1 <<  6)
+#define UART_IS_CTS		(1 <<  5)
+#define UART_IS_RI		(1 <<  4)
+#define UART_IS_TBC		(1 <<  3)
+#define UART_IS_RBC		(1 <<  2)
+#define UART_IS_TXIDLE		(1 <<  1)
+
+#define UIE_RX (UART_IE_OFLOW | UART_IE_PARITY | UART_IE_FRAME | \
+		UART_IE_BREAK | UART_IE_RBC)
+#define UIS_RX (UART_IS_OFLOW | UART_IS_PARITY | UART_IS_FRAME | \
+		UART_IS_BREAK | UART_IS_RBC)
+#define UIE_MS (UART_IE_DSR | UART_IE_DCD | UART_IE_CTS | UART_IE_RI)
+#define UIS_MS (UART_IS_DSR | UART_IS_DCD | UART_IS_CTS | UART_IS_RI)
+
+#define UART_CGAPCTRL	0x100c
+#define UART_CGAPCTRL_EN	(1 << 31)
+
+#define UART_BGAPCTRL	0x1010
+#define UART_BGAPCTRL_EN	(1 << 31)
+
+#define UART_BRDL       0x1100	/* DLAB =3D 1 */
+
+#define UART_UIE	0x1104	/* DLAB =3D 0 */
+#define UART_UIE_ETBEI		(1 << 1)
+
+#define UART_BRDM	0x1104	/* DLAB =3D 1 */
+
+#define UART_FCR	0x1108
+#define UART_FCR_FIFOEN		(1 << 1)
+
+#define UART_LCR	0x110c
+#define UART_LCR_DLAB		(1 << 7)
+#define UART_LCR_SBC		(1 << 6)
+#define UART_LCR_SPAR		(1 << 5)
+#define UART_LCR_EPAR		(1 << 4)
+#define UART_LCR_PARITY		(1 << 3)
+#define UART_LCR_STOP		(1 << 2)
+#define UART_LCR_WLEN		0x0003
+#define UART_LCR_WLEN_5		0x0000
+#define UART_LCR_WLEN_6		0x0001
+#define UART_LCR_WLEN_7		0x0002
+#define UART_LCR_WLEN_8		0x0003
+
+#define UART_MCR	0x1110
+#define UART_MCR_LOOP		(1 << 4)
+#define UART_MCR_RTS		(1 << 1)
+#define UART_MCR_DTR		(1 << 0)
+
+#define UART_LSR	0x1114
+#define UART_LSR_TEMT		(1 << 6)
+
+#define UART_MSR	0x1118
+#define UART_MSR_DCD		(1 << 7)
+#define UART_MSR_RI		(1 << 6)
+#define UART_MSR_DSR		(1 << 5)
+#define UART_MSR_CTS		(1 << 4)
+#define UART_MSR_DDCD		(1 << 3)
+#define UART_MSR_TERI		(1 << 2)
+#define UART_MSR_DDSR		(1 << 1)
+#define UART_MSR_DCTS		(1 << 0)
+
+#define UMSR_ANYDELTA		(UART_MSR_DDCD | UART_MSR_TERI | \
+		UART_MSR_DDSR | UART_MSR_DCTS)
+
+#define DRIVER_NAME "ns921x-uart"
+#define NS912X_TTY_NAME "ttyNS"
+#define NS912X_TTY_MAJOR 204 /* XXX */
+#define NS912X_TTY_MINOR_START 196 /* XXX */
+
+#define NS921X_UART_NR 4
+
+#define up2unp(up) container_of(up, struct uart_ns921x_port, port)
+struct uart_ns921x_port {
+	struct uart_port port;
+	struct clk *clk;
+	int (*gpio_request)(void *data);
+	void (*gpio_configure)(void *data);
+	void (*gpio_free)(void *data);
+	void *gpio_data;
+#define TXIRQPENDING 1
+	unsigned int flags;
+	unsigned int ifs2ack;
+	unsigned int is2ack;
+};
+
+/*
+ * bits 19 to 31 of HUB_IFS need to be cleard by writing a 1 to it.
+ * ns921x_uart_read_ifs and ns921x_uart_clear_ifs help debugging misse=
d clears
+ * by tracking the bits set
+ */
+#define IFS_BITSTOACK 0xfff80000
+static inline unsigned long ns921x_uart_read_ifs(struct uart_ns921x_po=
rt *unp)
+{
+	unsigned long ret =3D readl(unp->port.membase + HUB_IFS);
+	unp->ifs2ack |=3D ret & IFS_BITSTOACK;
+	return ret;
+}
+
+static inline void ns921x_uart_clear_ifs(struct uart_ns921x_port *unp,
+		unsigned int mask)
+{
+	BUG_ON((unp->ifs2ack & mask) !=3D mask);
+	BUG_ON(mask & ~IFS_BITSTOACK);
+	unp->ifs2ack &=3D ~mask;
+	writel(mask, unp->port.membase + HUB_IFS);
+}
+
+/*
+ * all bits of UART_IS need to be cleard by writing a 1 to it.
+ * ns921x_uart_read_is and ns921x_uart_clear_is help debugging missed =
clears by
+ * tracking the bits set
+ */
+static inline unsigned long ns921x_uart_read_is(struct uart_ns921x_por=
t *unp)
+{
+	unsigned long ret =3D readl(unp->port.membase + UART_IS);
+	unp->is2ack |=3D ret;
+	return ret;
+}
+
+static inline void ns921x_uart_clear_is(struct uart_ns921x_port *unp,
+		unsigned int mask)
+{
+	BUG_ON((unp->is2ack & mask) !=3D mask);
+	unp->is2ack &=3D ~mask;
+	writel(mask, unp->port.membase + UART_IS);
+}
+
+static unsigned int ns921x_uart_tx_empty(struct uart_port *port)
+{
+	struct uart_ns921x_port *unp =3D up2unp(port);
+	if (!(ns921x_uart_read_ifs(unp) & HUB_IFS_TXFE))
+		return 0;
+
+	if (ns921x_uart_read_is(unp) & UART_IS_TXIDLE)
+		return TIOCSER_TEMT;
+	else
+		return 0;
+}
+
+static void ns921x_uart_set_mctrl(struct uart_port *port, unsigned int=
 mctrl)
+{
+	unsigned long mcr =3D 0;
+
+	if (mctrl & TIOCM_RTS)
+		mcr |=3D UART_MCR_RTS;
+
+	if (mctrl & TIOCM_DTR)
+		mcr |=3D UART_MCR_DTR;
+
+	if (mctrl & TIOCM_LOOP)
+		mcr |=3D UART_MCR_LOOP;
+
+	writel(mcr, port->membase + UART_MCR);
+}
+
+static unsigned int ns921x_uart_check_msr(struct uart_port *port)
+{
+	unsigned int status =3D readl(port->membase + UART_MSR);
+
+	if (status & UMSR_ANYDELTA /* && IER_MSI */ && port->info !=3D NULL) =
{
+		if (status & UART_MSR_TERI)
+			port->icount.rng++;
+		if (status & UART_MSR_DDSR)
+			port->icount.dsr++;
+		if (status & UART_MSR_DDCD)
+			uart_handle_dcd_change(port, status & UART_MSR_DCD);
+		if (status & UART_MSR_DCTS)
+			uart_handle_cts_change(port, status & UART_MSR_CTS);
+
+		wake_up_interruptible(&port->info->delta_msr_wait);
+	}
+
+	return status;
+}
+
+static unsigned int ns921x_uart_get_mctrl(struct uart_port *port)
+{
+	unsigned int status;
+	unsigned int ret =3D 0;
+
+	status =3D ns921x_uart_check_msr(port);
+
+	if (status & UART_MSR_DCD)
+		ret |=3D TIOCM_CAR;
+	if (status & UART_MSR_RI)
+		ret |=3D TIOCM_RNG;
+	if (status & UART_MSR_DSR)
+		ret |=3D TIOCM_DSR;
+	if (status & UART_MSR_CTS)
+		ret |=3D TIOCM_CTS;
+
+	return ret;
+}
+
+/* called with port->lock taken */
+static void ns921x_uart_stop_tx(struct uart_port *port)
+{
+	struct uart_ns921x_port *unp =3D up2unp(port);
+
+	unsigned long ie =3D readl(unp->port.membase + UART_IE);
+
+	writel(ie & ~UART_IE_TXIDLE, unp->port.membase + UART_IE);
+
+	unp->flags &=3D ~TXIRQPENDING;
+}
+
+/* send out chars in xmit buffer.  This is called with port->lock take=
n */
+static void ns921x_uart_tx_chars(struct uart_ns921x_port *unp,
+		unsigned int freebuffers)
+{
+	struct circ_buf *xmit =3D &unp->port.info->xmit;
+
+	BUG_ON(!freebuffers);
+
+	if (unp->port.x_char) {
+		dev_dbg(unp->port.dev, "%s: send x_char %hu\n",
+				__func__, unp->port.x_char);
+		writeb(unp->port.x_char, unp->port.membase + HUB_DMTXDF);
+		unp->port.icount.tx++;
+		unp->port.x_char =3D 0;
+		freebuffers--;
+		unp->flags |=3D TXIRQPENDING;
+	}
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&unp->port)) {
+		ns921x_uart_stop_tx(&unp->port);
+		return;
+	}
+
+	while (freebuffers-- && uart_circ_chars_pending(xmit)) {
+		if (uart_circ_chars_pending(xmit) >=3D 4) {
+			unsigned long fourchars =3D xmit->buf[xmit->tail];
+			xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+			fourchars |=3D xmit->buf[xmit->tail] << 8;
+			xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+			fourchars |=3D xmit->buf[xmit->tail] << 16;
+			xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+			fourchars |=3D xmit->buf[xmit->tail] << 24;
+			xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+
+			writel(fourchars, unp->port.membase + HUB_DMTXDF);
+			unp->port.icount.tx +=3D 4;
+		} else {
+			writeb(xmit->buf[xmit->tail],
+					unp->port.membase + HUB_DMTXDF);
+			xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+			unp->port.icount.tx++;
+		}
+		unp->flags |=3D TXIRQPENDING;
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&unp->port);
+
+	if (uart_circ_empty(xmit))
+		ns921x_uart_stop_tx(&unp->port);
+}
+
+/* called with port->lock taken */
+static void ns921x_uart_start_tx(struct uart_port *port)
+{
+	struct uart_ns921x_port *unp =3D up2unp(port);
+
+	unsigned long ie =3D readl(port->membase + UART_IE);
+	dev_dbg(port->dev, "%s: flags =3D %u\n", __func__, unp->flags);
+
+	writel(ie | UART_IE_TXIDLE, port->membase + UART_IE);
+
+	if (!(unp->flags & TXIRQPENDING) &&=20
+			!(ns921x_uart_read_ifs(unp) & HUB_IFS_TXFF))
+		ns921x_uart_tx_chars(up2unp(port), 1);
+}
+
+static void ns921x_uart_stop_rx(struct uart_port *port)
+{
+	unsigned long ie =3D readl(port->membase + UART_IE);
+
+	writel(ie & ~UIE_RX, port->membase + UART_IE);
+}
+
+static void ns921x_uart_enable_ms(struct uart_port *port)
+{
+	unsigned long ie =3D readl(port->membase + UART_IE);
+
+	writel(ie | UIE_MS, port->membase + UART_IE);
+}
+
+static void ns921x_uart_break_ctl(struct uart_port *port, int break_st=
ate)
+{
+	unsigned long flags;
+	unsigned long lcr;
+
+	/* XXX: amba_pl011_break_ctl tests for break_state being -1,
+	 * Documentation/serial/driver tells to tests for !=3D 0 */
+	spin_lock_irqsave(&port->lock, flags);
+
+	lcr =3D readl(port->membase + UART_LCR);
+
+	if (break_state)
+		lcr |=3D UART_LCR_SBC;
+	else
+		lcr &=3D ~UART_LCR_SBC;
+
+	writel(lcr, port->membase + UART_LCR);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void ns921x_uart_rx_char(struct uart_ns921x_port *unp,
+		unsigned int ch, unsigned long is)
+{
+	unsigned int flag =3D TTY_NORMAL;
+
+	unp->port.icount.rx++;
+#define ISERR	(UART_IS_BREAK | UART_IS_PARITY | UART_IS_FRAME | UART_I=
S_OFLOW)
+
+	dev_dbg(unp->port.dev, "%s: IS=3D%lx\n", __func__, is);
+	if (unlikely(is & ISERR)) {
+		if (is & UART_IS_BREAK) {
+			dev_dbg(unp->port.dev, "break, IS=3D%lx\n", is);
+			unp->port.icount.brk++;
+			if (uart_handle_break(&unp->port))
+				return;
+		} else if (is & UART_IS_PARITY)
+			unp->port.icount.parity++;
+		else if (is & UART_IS_FRAME)
+			unp->port.icount.frame++;
+
+		if (is & UART_IS_OFLOW)
+			unp->port.icount.overrun++;
+
+		is &=3D unp->port.read_status_mask;
+
+		if (is & UART_IS_BREAK)
+			flag =3D TTY_BREAK;
+		else if (is & UART_IS_PARITY)
+			flag =3D TTY_PARITY;
+		else if (is & UART_IS_FRAME)
+			flag =3D TTY_FRAME;
+	}
+
+	if (uart_handle_sysrq_char(&unp->port, ch))
+		return;
+
+	dev_dbg(unp->port.dev, "%s: insert %x (IS=3D%lx, ism=3D%x, flag=3D%x)=
\n",
+			__func__, ch, is, unp->port.ignore_status_mask, flag);
+	uart_insert_char(&unp->port, is, UART_IS_OFLOW, ch, flag);
+}
+
+/* This is called with port->lock taken */
+static void ns921x_uart_rx_chars(struct uart_ns921x_port *unp,
+		unsigned long ifs, unsigned long is)
+{
+	struct tty_struct *tty =3D unp->port.info->tty;
+
+	if (ifs & HUB_IFS_RXFE) {
+		BUG_ON(!(is & UART_IS_BREAK)); /* maybe overflow? */
+		ns921x_uart_rx_char(unp, 0, is);
+	}
+
+	while (!(ifs & HUB_IFS_RXFE)) {
+		unsigned long dmrxsf =3D readl(unp->port.membase + HUB_DMRXSF);
+		unsigned long dmrxdf =3D readl(unp->port.membase + HUB_DMRXDF);
+		/* XXX: better put this into a macro */
+		unsigned int bytes =3D (dmrxsf & HUB_DMRXSF_BYTE) >> 9;
+		int i;
+
+		dev_dbg(unp->port.dev, "%s: DMRXSF =3D %lx, DMRXDF =3D %lx\n",
+				__func__, dmrxsf, dmrxdf);
+
+		BUG_ON(bytes > 4);
+
+		for (i =3D 0; i < bytes; ++i) {
+			unsigned int ch =3D (dmrxdf >> (8 * i)) & 0xff;
+
+			/*
+			 * assume break and errors only apply to the last
+			 * character.
+			 */
+			ns921x_uart_rx_char(unp, ch, i =3D=3D bytes - 1 ? is : 0);
+		}
+		ifs =3D ns921x_uart_read_ifs(unp);
+	}
+	spin_unlock(&unp->port.lock);
+	/* don't call tty_flip_buffer_push with low_latency set */
+	BUG_ON(tty->low_latency);
+	tty_flip_buffer_push(tty);
+	spin_lock(&unp->port.lock);
+}
+
+static irqreturn_t ns921x_uart_int(int irq, void *dev_id)
+{
+	struct uart_ns921x_port *unp =3D dev_id;
+	unsigned long ifs;
+	int handled =3D 0;
+
+	spin_lock(&unp->port.lock);
+
+	ifs =3D ns921x_uart_read_ifs(unp);
+	dev_dbg(unp->port.dev, "%s: IFS=3D%lx\n", __func__, ifs);
+
+	if (ifs & HUB_IFS_MODIP) {
+		unsigned long is;
+		unsigned long clear_is =3D 0;
+
+		is =3D ns921x_uart_read_is(unp);
+		dev_dbg(unp->port.dev, "%s: IS=3D%lx\n", __func__, is);
+
+		if (is & UIS_RX) {
+			ns921x_uart_rx_chars(unp, ifs, is);
+
+			clear_is |=3D is & UIS_RX;
+
+			handled =3D 1;
+		}
+
+		if (is & UIS_MS) {
+			clear_is |=3D is & UIS_MS;
+
+			handled =3D 1;
+		}
+		/* XXX: call this only after an MS irq? */
+		ns921x_uart_check_msr(&unp->port);
+
+		if (is & UART_IS_TXIDLE) {
+			BUG_ON(!(unp->flags & TXIRQPENDING));
+			unp->flags &=3D ~TXIRQPENDING;
+
+			ns921x_uart_tx_chars(unp, 1);
+			clear_is |=3D UART_IS_TXIDLE;
+			handled =3D 1;
+		}
+
+		/* ack the handled irq */
+		ns921x_uart_clear_is(unp, clear_is);
+	}
+
+	spin_unlock(&unp->port.lock);
+
+	if (!handled)
+		dev_dbg(unp->port.dev, "%s: unhandled\n", __func__);
+	return IRQ_RETVAL(handled);
+}
+
+static int ns921x_uart_startup(struct uart_port *port)
+{
+	struct uart_ns921x_port *unp =3D up2unp(port);
+	int ret;
+	u32 ie;
+
+	dev_dbg(port->dev, "%s\n", __func__);
+
+	ret =3D clk_enable(unp->clk);
+	if (ret)
+		goto err_clkenable;
+
+	ret =3D request_irq(unp->port.irq, ns921x_uart_int, 0, DRIVER_NAME, u=
np);
+	if (ret) {
+
+		clk_disable(unp->clk);
+
+err_clkenable:
+		return ret;
+	}
+
+	ie =3D readl(port->membase + UART_IE);
+	writel(ie | UIE_RX, port->membase + UART_IE);
+
+	writel(UART_WC_RXEN | UART_WC_TXEN, port->membase + UART_WC);
+
+	return 0;
+}
+
+static void ns921x_uart_shutdown(struct uart_port *port)
+{
+	struct uart_ns921x_port *unp =3D up2unp(port);
+
+	writel(0, port->membase + UART_IE);
+	writel(0, port->membase + UART_WC);
+
+	ns921x_uart_break_ctl(port, 0);
+
+	free_irq(port->irq, unp);
+
+	clk_disable(unp->clk);
+}
+
+static void ns921x_uart_set_termios(struct uart_port *port,
+		struct ktermios *termios, struct ktermios *old)
+{
+	unsigned long flags;
+	unsigned long cval =3D 0;
+
+	unsigned int baud, quot;
+	unsigned int saved_wc;
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		cval =3D UART_LCR_WLEN_5;
+		break;
+	case CS6:
+		cval =3D UART_LCR_WLEN_6;
+		break;
+	case CS7:
+		cval =3D UART_LCR_WLEN_7;
+		break;
+	default:
+	case CS8:
+		cval =3D UART_LCR_WLEN_8;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		cval |=3D UART_LCR_STOP;
+
+	if (termios->c_cflag & PARENB) {
+		cval |=3D UART_LCR_PARITY;
+
+		if (!(termios->c_cflag & PARODD))
+			cval |=3D UART_LCR_EPAR;
+	}
+
+	/* XXX: handle SPAR? */
+
+	baud =3D uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16=
);
+	quot =3D uart_get_divisor(port, baud);
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	port->read_status_mask =3D UART_IS_OFLOW;
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |=3D UART_IS_FRAME | UART_IS_PARITY;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		port->read_status_mask |=3D UART_IS_BREAK;
+
+	port->ignore_status_mask =3D 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |=3D UART_IS_FRAME | UART_IS_PARITY;
+	if (termios->c_iflag & IGNBRK) {
+		port->ignore_status_mask |=3D UART_IS_BREAK;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |=3D UART_IS_OFLOW;
+	}
+
+	dev_dbg(port->dev, "read_status_mask =3D %x, ignore_status_mask =3D %=
x\n",
+			port->read_status_mask, port->ignore_status_mask);
+
+	/* disable everything, prepare fifo flushing */
+	saved_wc =3D readl(port->membase + UART_WC);
+	writel(UART_WC_RXFLUSH | UART_WC_TXFLUSH, port->membase + UART_WC);
+
+	if (UART_ENABLE_MS(port, termios->c_cflag))
+		ns921x_uart_enable_ms(port);
+
+	/* set character gap period */
+	writel(UART_CGAPCTRL_EN | (10 * (port->uartclk / baud) - 1),
+			port->membase + UART_CGAPCTRL);
+
+	/* set buffer gap period */
+	writel(UART_BGAPCTRL_EN | (640 * (port->uartclk / baud) - 1),
+			port->membase + UART_BGAPCTRL);
+
+	/* prepare to access baud rate registers */
+	writel(UART_LCR_DLAB, port->membase + UART_LCR);
+
+	/* set baud rate */
+	writel(quot & 0xff, port->membase + UART_BRDL);
+	writel((quot >> 8) & 0xff, port->membase + UART_BRDM);
+
+	dev_dbg(port->dev, "%s: LCR <- %lx\n", __func__, cval);
+	writel(cval, port->membase + UART_LCR);
+
+	/* flush fifos and restore state */
+	writel(saved_wc, port->membase + UART_WC);
+	writel(UART_UIE_ETBEI, port->membase + UART_UIE);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *ns921x_uart_type(struct uart_port *port)
+{
+	return port->type =3D=3D PORT_NS921X ? "NS921X" : NULL;
+}
+
+static void ns921x_uart_release_port(struct uart_port *port)
+{
+	/* XXX: release_mem_region is marked as Compatibility cruft ??? */
+	release_mem_region(port->mapbase, 0x8000);
+}
+
+static int ns921x_uart_request_port(struct uart_port *port)
+{
+	return request_mem_region(port->mapbase,
+			0x8000, DRIVER_NAME) ? 0 : -EBUSY;
+}
+
+static void ns921x_uart_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE) {
+		port->type =3D PORT_NS921X;
+		ns921x_uart_request_port(port);
+	}
+}
+
+static int ns921x_uart_verify_port(struct uart_port *port,
+		struct serial_struct *ser)
+{
+	int ret =3D 0;
+	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_NS921X)
+		ret =3D -EINVAL;
+	if (ser->irq < 0 || ser->irq >=3D NR_IRQS)
+		ret =3D -EINVAL;
+	if (ser->baud_base < 9600)
+		ret =3D -EINVAL;
+	return ret;
+}
+
+static struct uart_ops ns921x_uart_pops =3D {
+	.tx_empty =3D ns921x_uart_tx_empty,
+	.set_mctrl =3D ns921x_uart_set_mctrl,
+	.get_mctrl =3D ns921x_uart_get_mctrl,
+	.stop_tx =3D ns921x_uart_stop_tx,
+	.start_tx =3D ns921x_uart_start_tx,
+	.stop_rx =3D ns921x_uart_stop_rx,
+	.enable_ms =3D ns921x_uart_enable_ms,
+	.break_ctl =3D ns921x_uart_break_ctl,
+	.startup =3D ns921x_uart_startup,
+	.shutdown =3D ns921x_uart_shutdown,
+	.set_termios =3D ns921x_uart_set_termios,
+	/* .pm =3D ns921x_uart_pm, */
+	/* .set_wake =3D ns921x_uart_set_wake, */
+	.type =3D ns921x_uart_type,
+	.release_port =3D ns921x_uart_release_port,
+	.request_port =3D ns921x_uart_request_port,
+	.config_port =3D ns921x_uart_config_port,
+	.verify_port =3D ns921x_uart_verify_port,
+	/* .ioctl */
+};
+
+static struct uart_ns921x_port *ns921x_uart_ports[NS921X_UART_NR];
+
+#if defined(CONFIG_SERIAL_NS921X_CONSOLE)
+
+static void ns921x_uart_console_putchar(struct uart_port *port, int ch=
)
+{
+	struct uart_ns921x_port *unp =3D up2unp(port);
+
+	while (ns921x_uart_read_ifs(unp) & HUB_IFS_TXFF)
+		barrier();
+
+	writeb(ch, unp->port.membase + HUB_DMTXDF);
+}
+
+/* called with console_sem hold.  irqs locally disabled */
+static void ns921x_uart_console_write(struct console *co,
+		const char *s, unsigned int count)
+{
+	struct uart_ns921x_port *unp =3D ns921x_uart_ports[co->index];
+	unsigned long saved_ie =3D readl(unp->port.membase + UART_IE);
+	unsigned long saved_fcr =3D readl(unp->port.membase + UART_FCR);
+	unsigned long saved_wc =3D readl(unp->port.membase + UART_WC);
+	unsigned long saved_uie =3D readl(unp->port.membase + UART_UIE);
+	unsigned long new_wc;
+	int ret;
+
+	BUG_ON(!irqs_disabled());
+
+	ret =3D clk_enable(unp->clk);
+	if (ret)
+		return;
+
+	new_wc =3D saved_wc | UART_WC_RXEN | UART_WC_TXEN;
+	new_wc &=3D ~(UART_WC_RXFLUSH | UART_WC_TXFLUSH);
+
+	writel(saved_ie & ~(UART_IE_TXIDLE | UIE_RX),
+			unp->port.membase + UART_IE);
+	writel(saved_fcr | UART_FCR_FIFOEN, unp->port.membase + UART_FCR);
+	writel(UART_UIE_ETBEI, unp->port.membase + UART_UIE);
+	writel(new_wc, unp->port.membase + UART_WC);
+
+	uart_console_write(&unp->port, s, count, ns921x_uart_console_putchar)=
;
+
+	/* wait for HUB fifo to become empty */
+	while (!(ns921x_uart_read_ifs(unp) & HUB_IFS_TXFE))
+		barrier();
+
+	/* wait for the transmitter to become empty */
+	while (!(readl(unp->port.membase + UART_LSR) & UART_LSR_TEMT))
+		barrier();
+
+	writel(saved_wc, unp->port.membase + UART_WC);
+	writel(saved_uie, unp->port.membase + UART_UIE);
+	writel(saved_fcr, unp->port.membase + UART_FCR);
+	writel(saved_ie, unp->port.membase + UART_IE);
+
+	clk_disable(unp->clk);
+}
+
+static void __init ns921x_uart_console_get_options(struct uart_ns921x_=
port *unp,
+		int *baud, int *bits, int *parity, int *flow)
+{
+	if (readl(unp->port.membase + UART_WC) & UART_WC_TXEN) {
+		unsigned long cval =3D readl(unp->port.membase + UART_LCR);
+		unsigned int quot =3D 0;
+
+		writel(UART_LCR_DLAB, unp->port.membase + UART_LCR);
+
+		quot =3D (readl(unp->port.membase + UART_BRDM) & 0xff) << 8;
+		quot |=3D readl(unp->port.membase + UART_BRDL) & 0xff;
+
+		writel(cval, unp->port.membase + UART_LCR);
+
+		*baud =3D unp->port.uartclk / (16 * quot);
+
+		*parity =3D 'n';
+		if (cval & UART_LCR_PARITY) {
+			if (cval & UART_LCR_EPAR)
+				*parity =3D 'e';
+			else
+				*parity =3D 'o';
+		}
+
+		switch (cval & UART_LCR_WLEN) {
+		case UART_LCR_WLEN_5:
+			*bits =3D 5;
+			break;
+		case UART_LCR_WLEN_6:
+			*bits =3D 6;
+			break;
+		case UART_LCR_WLEN_7:
+			*bits =3D 7;
+			break;
+		case UART_LCR_WLEN_8:
+			*bits =3D 8;
+			break;
+		}
+
+		/* XXX: *flow =3D ... */
+	}
+}
+
+static int __init ns921x_uart_console_setup(struct console *co, char *=
options)
+{
+	struct uart_ns921x_port *unp;
+	int baud =3D 38400;
+	int bits =3D 8;
+	int parity =3D 'n';
+	int flow =3D 'n';
+
+	if (co->index >=3D NS921X_UART_NR)
+		co->index =3D 0;
+	unp =3D ns921x_uart_ports[co->index];
+	if (!unp)
+		return -ENODEV;
+
+	/* XXX: assert unp->clk is enabled */
+	unp->port.uartclk =3D clk_get_rate(unp->clk);
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	else
+		ns921x_uart_console_get_options(unp,
+				&baud, &parity, &bits, &flow);
+
+	return uart_set_options(&unp->port, co, baud, parity, bits, flow);
+}
+
+static struct uart_driver ns921x_uart_reg;
+static struct console ns921x_uart_console =3D {
+	.name =3D NS912X_TTY_NAME,
+	.write =3D ns921x_uart_console_write,
+	/* .read */
+	.device =3D uart_console_device,
+	/* .unblank */
+	.setup =3D ns921x_uart_console_setup,
+	/* .early_setup */
+	.flags =3D CON_PRINTBUFFER,
+	.index =3D -1,
+	/* .cflag */
+	.data =3D &ns921x_uart_reg,
+	/* .next */
+};
+
+#define NS921X_UART_CONSOLE (&ns921x_uart_console)
+#else
+#define NS921X_UART_CONSOLE NULL
+#endif
+
+static struct uart_driver ns921x_uart_reg =3D {
+	.owner =3D THIS_MODULE,
+	.driver_name =3D DRIVER_NAME,
+	.dev_name =3D NS912X_TTY_NAME,
+	.major =3D NS912X_TTY_MAJOR,
+	.minor =3D NS912X_TTY_MINOR_START,
+	.nr =3D NS921X_UART_NR,
+	.cons =3D NS921X_UART_CONSOLE,
+};
+
+static int __init ns921x_uart_pdrv_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct uart_ns921x_port *unp;
+	struct resource *mem;
+	void __iomem *base;
+	struct plat_ns921x_serial *pdata =3D pdev->dev.platform_data;
+	int line;
+
+	if (!pdata) {
+		ret =3D -ENODEV;
+		goto err_pdata;
+	}
+
+	line =3D pdata->line;
+
+	if (ns921x_uart_ports[line] !=3D NULL) {
+		ret =3D -EBUSY;
+		goto err_line;
+	}
+
+	unp =3D kzalloc(sizeof(struct uart_ns921x_port), GFP_KERNEL);
+	ns921x_uart_ports[line] =3D unp;
+
+	if (unp =3D=3D NULL) {
+		ret =3D -ENOMEM;
+		goto err_alloc;
+	}
+
+	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		ret =3D -ENODEV;
+		goto err_get_mem;
+	}
+
+	base =3D ioremap(mem->start, 0x8000);
+	if (!base) {
+		ret =3D -ENOMEM;
+		goto err_ioremap;
+	}
+	dev_dbg(&pdev->dev, "base =3D %p\n", base);
+
+	unp->clk =3D clk_get(&pdev->dev, "UART");
+	if (IS_ERR(unp->clk)) {
+		ret =3D PTR_ERR(unp->clk);
+		dev_dbg(&pdev->dev, "clk ret =3D %d\n", ret);
+		goto err_clk_get;
+	}
+
+	unp->port.dev =3D &pdev->dev;
+	unp->port.mapbase =3D mem->start;
+	unp->port.membase =3D base;
+	unp->port.iotype =3D UPIO_MEM;
+	unp->port.irq =3D pdata->irq;
+	unp->port.fifosize =3D 64; /* XXX */
+	unp->port.ops =3D &ns921x_uart_pops;
+	unp->port.flags =3D UPF_BOOT_AUTOCONF;
+	unp->port.line =3D line;
+
+	unp->gpio_request =3D pdata->gpio_request;
+	unp->gpio_configure =3D pdata->gpio_configure;
+	unp->gpio_free =3D pdata->gpio_free;
+	unp->gpio_data =3D pdata->gpio_data;
+
+	ret =3D unp->gpio_request(unp->gpio_data);
+	if (ret)
+		goto err_gpio_request;
+
+	unp->gpio_configure(unp->gpio_data);
+
+	/* no DMA */
+	writel(HUB_DMARXCTRL_DIRECT, unp->port.membase + HUB_DMARXCTRL);
+	writel(HUB_DMATXCTRL_DIRECT, unp->port.membase + HUB_DMATXCTRL);
+
+	ret =3D uart_add_one_port(&ns921x_uart_reg, &unp->port);
+	if (ret) {
+
+		unp->gpio_free(unp->gpio_data);
+err_gpio_request:
+
+		clk_put(unp->clk);
+err_clk_get:
+
+		iounmap(base);
+err_ioremap:
+err_get_mem:
+
+		kfree(unp);
+		ns921x_uart_ports[line] =3D NULL;
+err_alloc:
+
+err_line:
+err_pdata:
+
+		return ret;
+	}
+	platform_set_drvdata(pdev, unp);
+
+	return 0;
+}
+
+static int ns921x_uart_pdrv_remove(struct platform_device *pdev)
+{
+	int line;
+	struct uart_ns921x_port *unp =3D platform_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	line =3D unp->port.line;
+
+	unp->gpio_free(unp->gpio_data);
+	clk_put(unp->clk);
+	iounmap(unp->port.membase);
+	kfree(unp);
+	ns921x_uart_ports[line] =3D NULL;
+
+	return 0;
+}
+
+static struct platform_driver ns921x_uart_pdrv =3D {
+	.remove =3D ns921x_uart_pdrv_remove,
+	/* .shutdown =3D ns921x_uart_pdrv_shutdown, */
+	/* .suspend =3D ns921x_uart_pdrv_suspend, */
+	/* .suspend_late =3D ns921x_uart_pdrv_suspend_late, */
+	/* .resume_early =3D ns921x_uart_pdrv_resume_early, */
+	/* .resume =3D ns921x_uart_pdrv_resume, */
+	.driver =3D {
+		.name =3D DRIVER_NAME,
+		.owner =3D THIS_MODULE,
+	},
+};
+
+static int __init ns921x_uart_init(void)
+{
+	int ret;
+	printk(KERN_INFO "Serial: Digi NS921x UART driver\n");
+
+	ret =3D uart_register_driver(&ns921x_uart_reg);
+	if (ret)
+		goto err_uart_register_driver;
+
+	ret =3D platform_driver_probe(&ns921x_uart_pdrv, ns921x_uart_pdrv_pro=
be);
+
+	if (ret) {
+
+		uart_unregister_driver(&ns921x_uart_reg);
+err_uart_register_driver:
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit ns921x_uart_exit(void)
+{
+	platform_driver_unregister(&ns921x_uart_pdrv);
+	uart_unregister_driver(&ns921x_uart_reg);
+}
+
+module_init(ns921x_uart_init);
+module_exit(ns921x_uart_exit);
+
+MODULE_AUTHOR("Uwe Kleine-Koenig");
+MODULE_DESCRIPTION("Digi NS921x UART driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/ns921x-serial.h b/include/linux/ns921x-seria=
l.h
new file mode 100644
index 0000000..b6305cc
--- /dev/null
+++ b/include/linux/ns921x-serial.h
@@ -0,0 +1,23 @@
+/*
+ * include/linux/ns921x-serial.h
+ *
+ * Copyright (C) 2007 by Digi International Inc.
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished by
+ * the Free Software Foundation.
+ */
+#ifndef _LINUX_NS921X_SERIAL_H
+#define _LINUX_NS921X_SERIAL_H
+
+struct plat_ns921x_serial {
+	unsigned int line;
+	unsigned int irq;
+	int (*gpio_request)(void *data);
+	void (*gpio_configure)(void *data);
+	void (*gpio_free)(void *data);
+	void *gpio_data;
+};
+
+#endif /* ifndef _LINUX_NS921X_SERIAL_H */
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 6a5203f..bc73988 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -149,6 +149,8 @@
 /* Freescale ColdFire */
 #define PORT_MCF	78
=20
+/* NetSilicon 921x */
+#define PORT_NS921X	79
=20
 #ifdef __KERNEL__
=20
--=20
1.5.3.4

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
