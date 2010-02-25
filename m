From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH V2 14/14] Serial: sc26xx - rename to sc2xxx
Date: Thu, 25 Feb 2010 14:35:54 +0100
Message-ID: <20100225133554.12331.14865.stgit@srv002.fuzzey.net>
References: <20100225133450.12331.94240.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f212.google.com ([209.85.219.212]:34503 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932504Ab0BYNf6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 08:35:58 -0500
Received: by mail-ew0-f212.google.com with SMTP id 4so1510191ewy.28
        for <linux-serial@vger.kernel.org>; Thu, 25 Feb 2010 05:35:57 -0800 (PST)
In-Reply-To: <20100225133450.12331.94240.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, tsbogend@alpha.franken.de

As driver now supports 28xx chips rename it.

Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 arch/mips/sni/a20r.c        |    2=20
 drivers/serial/Kconfig      |   14 -
 drivers/serial/Makefile     |    2=20
 drivers/serial/sc26xx.c     |  998 -----------------------------------=
--------
 drivers/serial/sc2xxx.c     |  998 +++++++++++++++++++++++++++++++++++=
++++++++
 include/linux/serial_core.h |    2=20
 6 files changed, 1008 insertions(+), 1008 deletions(-)
 delete mode 100644 drivers/serial/sc26xx.c
 create mode 100644 drivers/serial/sc2xxx.c

diff --git a/arch/mips/sni/a20r.c b/arch/mips/sni/a20r.c
index 2fbbb65..c2e4680 100644
--- a/arch/mips/sni/a20r.c
+++ b/arch/mips/sni/a20r.c
@@ -129,7 +129,7 @@ static struct plat_serial_sc2xxx sc26xx_data =3D {
 };
=20
 static struct platform_device sc26xx_pdev =3D {
-	.name           =3D "SC26xx",
+	.name           =3D "SC2xxx",
 	.num_resources  =3D ARRAY_SIZE(sc26xx_rsrc),
 	.resource       =3D sc26xx_rsrc,
 	.dev			=3D {
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 10bd461..a64424c 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1393,20 +1393,20 @@ config SERIAL_QE
 	  This driver supports the QE serial ports on Freescale embedded
 	  PowerPC that contain a QUICC Engine.
=20
-config SERIAL_SC26XX
-	tristate "SC2681/SC2692 serial port support"
+config SERIAL_SC2XXX
+	tristate "SC2681/SC2692/SC2892 serial port support"
 	depends on SNI_RM || EMBEDDED
 	select SERIAL_CORE
 	help
 	  This is a driver for the onboard serial ports of
-	  older RM400 machines.
+	  older RM400 machines and some embedded systems.
=20
-config SERIAL_SC26XX_CONSOLE
-	bool "Console on SC2681/SC2692 serial port"
-	depends on SERIAL_SC26XX
+config SERIAL_SC2XXX_CONSOLE
+	bool "Console on SC2681/SC2692/SC2892 serial port"
+	depends on SERIAL_SC2XXX
 	select SERIAL_CORE_CONSOLE
 	help
-	  Support for Console on SC2681/SC2692 serial ports.
+	  Support for Console on SC2681/SC2692/SC2892 serial ports.
=20
 config SERIAL_BFIN_SPORT
 	tristate "Blackfin SPORT emulate UART (EXPERIMENTAL)"
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 5548fe7..926515b 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -65,7 +65,7 @@ obj-$(CONFIG_SERIAL_M32R_SIO) +=3D m32r_sio.o
 obj-$(CONFIG_SERIAL_MPSC) +=3D mpsc.o
 obj-$(CONFIG_SERIAL_SB1250_DUART) +=3D sb1250-duart.o
 obj-$(CONFIG_ETRAX_SERIAL) +=3D crisv10.o
-obj-$(CONFIG_SERIAL_SC26XX) +=3D sc26xx.o
+obj-$(CONFIG_SERIAL_SC2XXX) +=3D sc2xxx.o
 obj-$(CONFIG_SERIAL_JSM) +=3D jsm/
 obj-$(CONFIG_SERIAL_TXX9) +=3D serial_txx9.o
 obj-$(CONFIG_SERIAL_VR41XX) +=3D vr41xx_siu.o
diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
deleted file mode 100644
index 33b21b9..0000000
--- a/drivers/serial/sc26xx.c
+++ /dev/null
@@ -1,998 +0,0 @@
-/*
- * SC26xx.c: Serial driver for Philips SC2681/SC2692/SC2892 devices.
- *
- * Copyright (C) 2006,2007 Thomas Bogend=C3=B6rfer (tsbogend@alpha.fra=
nken.de)
- * SC2892 support by Martin Fuzzey (mfuzzey@gmail.com)
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/major.h>
-#include <linux/circ_buf.h>
-#include <linux/serial.h>
-#include <linux/sysrq.h>
-#include <linux/console.h>
-#include <linux/spinlock.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/serial_sc2xxx.h>
-
-#if defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
-#include <linux/serial_core.h>
-
-#define SC26XX_MAJOR         204
-#define SC26XX_MINOR_START   205
-#define SC26XX_NR            2
-
-struct chip_def {
-	u8	has_mr0;
-	u8	init_mr0;
-	u8	init_mr1;
-	u8	max_baud_mode;
-	u8	default_baud_mode;
-	u8	default_baud_group;
-	const char *name;
-};
-
-struct uart_sc26xx_port {
-	struct uart_port      port[2];
-	u8	dsr_mask[2];
-	u8	cts_mask[2];
-	u8	dcd_mask[2];
-	u8	ri_mask[2];
-	u8	dtr_mask[2];
-	u8	rts_mask[2];
-	u8	imr;
-	u8	acr;
-	u8	mr0_baud;
-	const unsigned int *baud_rates;
-	const struct chip_def *chip;
-};
-
-/* register common to both ports */
-#define RD_ISR      0x14
-#define RD_IPR      0x34
-
-#define WR_ACR      0x10
-#define WR_IMR      0x14
-#define WR_OPCR     0x34
-#define WR_OPR_SET  0x38
-#define WR_OPR_CLR  0x3C
-
-/* access common register */
-#define READ_SC(p, r)        readb((p)->membase + RD_##r)
-#define WRITE_SC(p, r, v)    writeb((v), (p)->membase + WR_##r)
-
-/* register per port */
-#define RD_PORT_MRx 0x00
-#define RD_PORT_SR  0x04
-#define RD_PORT_RHR 0x0c
-
-#define WR_PORT_MRx 0x00
-#define WR_PORT_CSR 0x04
-#define WR_PORT_CR  0x08
-#define WR_PORT_THR 0x0c
-
-/* SR bits */
-#define SR_BREAK    (1 << 7)
-#define SR_FRAME    (1 << 6)
-#define SR_PARITY   (1 << 5)
-#define SR_OVERRUN  (1 << 4)
-#define SR_TXEMT    (1 << 3)
-#define SR_TXRDY    (1 << 2)
-#define SR_RXRDY    (1 << 0)
-
-#define CR_RES_MR   (1 << 4)
-#define CR_RES_RX   (2 << 4)
-#define CR_RES_TX   (3 << 4)
-#define CR_STRT_BRK (6 << 4)
-#define CR_STOP_BRK (7 << 4)
-#define CR_SEL_MR0  (11 << 4)
-#define CR_DIS_TX   (1 << 3)
-#define CR_ENA_TX   (1 << 2)
-#define CR_DIS_RX   (1 << 1)
-#define CR_ENA_RX   (1 << 0)
-
-/* ISR bits */
-#define ISR_RXRDYB  (1 << 5)
-#define ISR_TXRDYB  (1 << 4)
-#define ISR_RXRDYA  (1 << 1)
-#define ISR_TXRDYA  (1 << 0)
-
-/* IMR bits */
-#define IMR_RXRDY   (1 << 1)
-#define IMR_TXRDY   (1 << 0)
-
-/* MR0 bits (>=3D 28L92 only */
-#define MR0_WATCHDOG	(1 << 7)
-#define MR0_RXINT2	(1 << 6)
-#define MR0_TXINT(x)	((x) << 4)
-#define MR0_FIFO_SIZE	(1 << 3)
-#define MR0_BAUD_MODE	((1 << 2) + (1 << 0))
-
-
-#define NR_BAUD_GROUPS 2
-#define NR_BAUD_MODES 3
-#define NR_BAUDS 13
-#define DEFAULT_BAUD_INDEX 11
-static const unsigned baud_rates[NR_BAUD_MODES][NR_BAUD_GROUPS][NR_BAU=
DS] =3D {
-	{
-		/* Normal mode ACR[7] =3D 0 */
-		{50, 110, 134, 200, 300, 600, 1200, 1050,
-			2400, 4800, 7200, 9600, 38400},
-
-		/* Normal mode ACR[7] =3D 1 */
-		{75, 110, 134, 150, 300, 600, 1200, 2000,
-			2400, 4800, 1800, 9600, 19200},
-	}, {
-		/* Extended mode 1 ACR[7] =3D 0 */
-		{300, 110, 134, 1200, 1800, 3600, 7200, 1050,
-			14400, 28800, 7200, 57600, 230400},
-
-		/* Extended mode 1 ACR[7] =3D 1 */
-		{450, 110, 134, 900, 1800, 3600, 72000, 2000,
-			14400, 28800, 1800, 57600, 115200},
-	}, {
-		/* Extended mode 2 ACR[7] =3D 0 */
-		{4800, 880, 1076, 19200, 28800, 57600, 115200, 1050,
-			57600, 4800, 57600, 9600, 38400},
-
-		/* Extended mode 2 ACR[7] =3D 1 */
-		{7200, 880, 1076, 14400, 28800, 57600, 115200, 2000,
-			57600, 4800, 14400, 9600, 19200},
-	}
-};
-
-static struct chip_def chip_26xx =3D {
-	.name =3D "SC26XX",
-	.max_baud_mode =3D 0,
-	.default_baud_mode =3D 0,
-	.default_baud_group =3D 1,
-	.has_mr0 =3D 0,
-	.init_mr1 =3D 0,
-};
-
-static struct chip_def chip_2892 =3D {
-	.name =3D "SC2892",
-	.max_baud_mode =3D 2,
-	.default_baud_mode =3D 2,
-	.default_baud_group =3D 0,
-	.has_mr0 =3D 1,
-	.init_mr0 =3D  MR0_WATCHDOG | MR0_FIFO_SIZE | MR0_TXINT(1),
-	.init_mr1 =3D (1 << 6),
-};
-
-static const struct chip_def *chips[] =3D {
-	&chip_26xx,
-	&chip_2892
-};
-
-static struct uart_sc26xx_port *driver_info(struct uart_port *port)
-{
-	port -=3D port->line;
-	return container_of(port, struct uart_sc26xx_port, port[0]);
-}
-
-/* access port register */
-static inline u8 read_sc_line(struct uart_port *p, int line, u8 reg)
-{
-	return readb(p->membase + line * 0x20 + reg);
-}
-
-static inline u8 read_sc_port(struct uart_port *p, u8 reg)
-{
-	return read_sc_line(p, p->line, reg);
-}
-
-static inline void write_sc_line(struct uart_port *p, int line, u8 reg=
, u8 val)
-{
-	writeb(val, p->membase + line * 0x20 + reg);
-}
-
-static inline void write_sc_port(struct uart_port *p, u8 reg, u8 val)
-{
-	write_sc_line(p, p->line, reg, val);
-}
-
-#define READ_SC_PORT(p, r)     read_sc_port(p, RD_PORT_##r)
-#define WRITE_SC_PORT(p, r, v) write_sc_port(p, WR_PORT_##r, v)
-
-static void write_cmd_line(struct uart_port *port, int line, u8 cmd)
-{
-	int i;
-
-	write_sc_line(port, line, WR_PORT_CR, cmd);
-
-	/* According to data sheet require 3 NOPs before next command */
-	for (i =3D 0; i < 3; i++)
-		write_sc_line(port, line, WR_PORT_CR, 0);
-}
-
-static inline void write_cmd_port(struct uart_port *port, u8 cmd)
-{
-	write_cmd_line(port, port->line, cmd);
-}
-
-
-static u8 read_mr0(struct uart_port *port, int line)
-{
-	write_cmd_line(port, line, CR_SEL_MR0);
-	return read_sc_line(port, line, RD_PORT_MRx);
-}
-
-static void write_mr0(struct uart_port *port, int line, u8 val)
-{
-	write_cmd_line(port, line, CR_SEL_MR0);
-	write_sc_line(port, line, WR_PORT_MRx, val);
-}
-
-static void sc26xx_enable_irq(struct uart_port *port, int mask)
-{
-	struct uart_sc26xx_port *up =3D driver_info(port);
-
-	up->imr |=3D mask << (port->line * 4);
-	WRITE_SC(port, IMR, up->imr);
-}
-
-static void sc26xx_disable_irq(struct uart_port *port, int mask)
-{
-	struct uart_sc26xx_port *up =3D driver_info(port);
-
-	up->imr &=3D ~(mask << (port->line * 4));
-	WRITE_SC(port, IMR, up->imr);
-}
-
-static struct tty_struct *receive_chars(struct uart_port *port)
-{
-	struct tty_struct *tty =3D NULL;
-	int limit =3D 10000;
-	unsigned char ch;
-	char flag;
-	u8 status;
-
-	if (port->state !=3D NULL)		/* Unopened serial console */
-		tty =3D port->state->port.tty;
-
-	while (limit-- > 0) {
-		status =3D READ_SC_PORT(port, SR);
-		if (!(status & SR_RXRDY))
-			break;
-		ch =3D READ_SC_PORT(port, RHR);
-
-		flag =3D TTY_NORMAL;
-		port->icount.rx++;
-
-		if (unlikely(status & (SR_BREAK | SR_FRAME |
-				       SR_PARITY | SR_OVERRUN))) {
-			if (status & SR_BREAK) {
-				status &=3D ~(SR_PARITY | SR_FRAME);
-				port->icount.brk++;
-				if (uart_handle_break(port))
-					continue;
-			} else if (status & SR_PARITY)
-				port->icount.parity++;
-			else if (status & SR_FRAME)
-				port->icount.frame++;
-			if (status & SR_OVERRUN)
-				port->icount.overrun++;
-
-			status &=3D port->read_status_mask;
-			if (status & SR_BREAK)
-				flag =3D TTY_BREAK;
-			else if (status & SR_PARITY)
-				flag =3D TTY_PARITY;
-			else if (status & SR_FRAME)
-				flag =3D TTY_FRAME;
-		}
-
-		if (uart_handle_sysrq_char(port, ch))
-			continue;
-
-		if (status & port->ignore_status_mask)
-			continue;
-
-		if (tty)
-			tty_insert_flip_char(tty, ch, flag);
-	}
-	return tty;
-}
-
-static void transmit_chars(struct uart_port *port)
-{
-	struct circ_buf *xmit;
-
-	if (!port->state)
-		return;
-
-	xmit =3D &port->state->xmit;
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		sc26xx_disable_irq(port, IMR_TXRDY);
-		return;
-	}
-	while (!uart_circ_empty(xmit)) {
-		if (!(READ_SC_PORT(port, SR) & SR_TXRDY))
-			break;
-
-		WRITE_SC_PORT(port, THR, xmit->buf[xmit->tail]);
-		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-	}
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-}
-
-static irqreturn_t sc26xx_interrupt(int irq, void *dev_id)
-{
-	struct uart_sc26xx_port *up =3D dev_id;
-	struct tty_struct *tty;
-	unsigned long flags;
-	u8 isr;
-
-	spin_lock_irqsave(&up->port[0].lock, flags);
-
-	tty =3D NULL;
-	isr =3D READ_SC(&up->port[0], ISR);
-	if (isr & ISR_TXRDYA)
-	    transmit_chars(&up->port[0]);
-	if (isr & ISR_RXRDYA)
-	    tty =3D receive_chars(&up->port[0]);
-
-	spin_unlock(&up->port[0].lock);
-
-	if (tty)
-		tty_flip_buffer_push(tty);
-
-	spin_lock(&up->port[1].lock);
-
-	tty =3D NULL;
-	if (isr & ISR_TXRDYB)
-	    transmit_chars(&up->port[1]);
-	if (isr & ISR_RXRDYB)
-	    tty =3D receive_chars(&up->port[1]);
-
-	spin_unlock_irqrestore(&up->port[1].lock, flags);
-
-	if (tty)
-		tty_flip_buffer_push(tty);
-
-	return IRQ_HANDLED;
-}
-
-/* port->lock is not held.  */
-static unsigned int sc26xx_tx_empty(struct uart_port *port)
-{
-	return (READ_SC_PORT(port, SR) & SR_TXRDY) ? TIOCSER_TEMT : 0;
-}
-
-/* port->lock held by caller.  */
-static void sc26xx_set_mctrl(struct uart_port *port, unsigned int mctr=
l)
-{
-	struct uart_sc26xx_port *up =3D driver_info(port);
-	int line =3D port->line;
-
-	if (up->dtr_mask[line]) {
-		if (mctrl & TIOCM_DTR)
-			WRITE_SC(port, OPR_SET, up->dtr_mask[line]);
-		else
-			WRITE_SC(port, OPR_CLR, up->dtr_mask[line]);
-	}
-	if (up->rts_mask[line]) {
-		if (mctrl & TIOCM_RTS)
-			WRITE_SC(port, OPR_SET, up->rts_mask[line]);
-		else
-			WRITE_SC(port, OPR_CLR, up->rts_mask[line]);
-	}
-}
-
-/* port->lock is held by caller and interrupts are disabled.  */
-static unsigned int sc26xx_get_mctrl(struct uart_port *port)
-{
-	struct uart_sc26xx_port *up =3D driver_info(port);
-	int line =3D port->line;
-	unsigned int mctrl =3D TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
-	u8 ipr;
-
-	ipr =3D READ_SC(port, IPR) ^ 0xff;
-
-	if (up->dsr_mask[line]) {
-		mctrl &=3D ~TIOCM_DSR;
-		mctrl |=3D ipr & up->dsr_mask[line] ? TIOCM_DSR : 0;
-	}
-	if (up->cts_mask[line]) {
-		mctrl &=3D ~TIOCM_CTS;
-		mctrl |=3D ipr & up->cts_mask[line] ? TIOCM_CTS : 0;
-	}
-	if (up->dcd_mask[line]) {
-		mctrl &=3D ~TIOCM_CAR;
-		mctrl |=3D ipr & up->dcd_mask[line] ? TIOCM_CAR : 0;
-	}
-	if (up->ri_mask[line]) {
-		mctrl &=3D ~TIOCM_RNG;
-		mctrl |=3D ipr & up->ri_mask[line] ? TIOCM_RNG : 0;
-	}
-	return mctrl;
-}
-
-/* port->lock held by caller.  */
-static void sc26xx_stop_tx(struct uart_port *port)
-{
-	return;
-}
-
-/* port->lock held by caller.  */
-static void sc26xx_start_tx(struct uart_port *port)
-{
-	struct circ_buf *xmit =3D &port->state->xmit;
-
-	while (!uart_circ_empty(xmit)) {
-		if (!(READ_SC_PORT(port, SR) & SR_TXRDY)) {
-			sc26xx_enable_irq(port, IMR_TXRDY);
-			break;
-		}
-		WRITE_SC_PORT(port, THR, xmit->buf[xmit->tail]);
-		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-	}
-}
-
-/* port->lock held by caller.  */
-static void sc26xx_stop_rx(struct uart_port *port)
-{
-}
-
-/* port->lock held by caller.  */
-static void sc26xx_enable_ms(struct uart_port *port)
-{
-}
-
-/* port->lock is not held.  */
-static void sc26xx_break_ctl(struct uart_port *port, int break_state)
-{
-	if (break_state =3D=3D -1)
-		write_cmd_port(port, CR_STRT_BRK);
-	else
-		write_cmd_port(port, CR_STOP_BRK);
-}
-
-/* port->lock is not held.  */
-static int sc26xx_startup(struct uart_port *port)
-{
-	struct uart_sc26xx_port *up =3D driver_info(port);
-
-	sc26xx_disable_irq(port, IMR_TXRDY | IMR_RXRDY);
-	WRITE_SC(port, OPCR, 0);
-
-	/* reset tx and rx */
-	write_cmd_port(port, CR_RES_RX);
-	write_cmd_port(port, CR_RES_TX);
-
-	if (up->chip->has_mr0)
-		write_mr0(port, port->line, up->chip->init_mr0);
-
-	/* start rx/tx */
-	WRITE_SC_PORT(port, CR, CR_ENA_TX | CR_ENA_RX);
-
-	/* enable irqs */
-	sc26xx_enable_irq(port, IMR_RXRDY);
-	return 0;
-}
-
-/* port->lock is not held.  */
-static void sc26xx_shutdown(struct uart_port *port)
-{
-	/* disable interrupst */
-	sc26xx_disable_irq(port, IMR_TXRDY | IMR_RXRDY);
-
-	/* stop tx/rx */
-	WRITE_SC_PORT(port, CR, CR_DIS_TX | CR_DIS_RX);
-}
-
-static int wait_tx_empty(struct uart_port *port)
-{
-	int i;
-	u8 sr;
-	u8 bits =3D SR_TXEMT | SR_TXRDY;
-
-	for (i =3D 0; i < 10000; i++) {
-		sr =3D READ_SC_PORT(port, SR);
-		if  ((sr & bits) =3D=3D bits)
-			return 0;
-		udelay(2);
-	}
-	dev_warn(port->dev, "Timed out waiting for TX Empty sr=3D%02X\n", sr)=
;
-	return -1;
-}
-
-static u8 find_csr(struct uart_sc26xx_port *up, unsigned int baud)
-{
-	int i, found =3D -1;
-
-	for (i =3D 0; i < NR_BAUDS; i++) {
-		if (up->baud_rates[i] =3D=3D baud) {
-			found =3D i;
-			break;
-		}
-	}
-
-	if (found =3D=3D -1) {
-		found =3D DEFAULT_BAUD_INDEX;
-		dev_warn(up->port[0].dev,
-			"%d baud not available using %d\n",
-			baud, up->baud_rates[found]);
-	}
-
-	return (u8)found | ((u8)found << 4);
-}
-
-/* port->lock is not held.  */
-static void sc26xx_set_termios(struct uart_port *port, struct ktermios=
 *termios,
-			      struct ktermios *old)
-{
-	struct uart_sc26xx_port *up =3D driver_info(port);
-	unsigned int baud =3D uart_get_baud_rate(port, termios, old, 0, 40000=
00);
-	unsigned int iflag, cflag;
-	unsigned long flags;
-	u8 mr1, mr2, csr;
-
-	spin_lock_irqsave(&port->lock, flags);
-
-	if (wait_tx_empty(port))
-		goto out;
-
-	WRITE_SC_PORT(port, CR, CR_DIS_TX | CR_DIS_RX);
-
-	iflag =3D termios->c_iflag;
-	cflag =3D termios->c_cflag;
-
-	port->read_status_mask =3D SR_OVERRUN;
-	if (iflag & INPCK)
-		port->read_status_mask |=3D SR_PARITY | SR_FRAME;
-	if (iflag & (BRKINT | PARMRK))
-		port->read_status_mask |=3D SR_BREAK;
-
-	port->ignore_status_mask =3D 0;
-	if (iflag & IGNBRK)
-		port->ignore_status_mask |=3D SR_BREAK;
-	if ((cflag & CREAD) =3D=3D 0)
-		port->ignore_status_mask |=3D SR_BREAK | SR_FRAME |
-					    SR_PARITY | SR_OVERRUN;
-
-	switch (cflag & CSIZE) {
-	case CS5:
-		mr1 =3D 0x00;
-		break;
-	case CS6:
-		mr1 =3D 0x01;
-		break;
-	case CS7:
-		mr1 =3D 0x02;
-		break;
-	default:
-	case CS8:
-		mr1 =3D 0x03;
-		break;
-	}
-	mr2 =3D 0x07;
-	if (cflag & CSTOPB)
-		mr2 =3D 0x0f;
-	if (cflag & PARENB) {
-		if (cflag & PARODD)
-			mr1 |=3D (1 << 2);
-	} else
-		mr1 |=3D (2 << 3);
-
-	mr1 |=3D up->chip->init_mr1;
-	csr =3D find_csr(up, baud);
-
-	if (up->chip->has_mr0) {
-		u8 mr0a =3D read_mr0(port, 0);
-		mr0a &=3D ~MR0_BAUD_MODE;
-		mr0a |=3D up->mr0_baud;
-		write_mr0(port, 0, mr0a);
-	}
-
-	write_cmd_port(port, CR_RES_MR);
-	WRITE_SC_PORT(port, MRx, mr1);
-	WRITE_SC_PORT(port, MRx, mr2);
-
-	WRITE_SC(port, ACR, up->acr);
-	WRITE_SC_PORT(port, CSR, csr);
-
-	/* reset tx and rx */
-	write_cmd_port(port, CR_RES_RX);
-	write_cmd_port(port, CR_RES_TX);
-
-	WRITE_SC_PORT(port, CR, CR_ENA_TX | CR_ENA_RX);
-	if (wait_tx_empty(port))
-		goto out;
-
-	uart_update_timeout(port, cflag, baud);
-out:
-	spin_unlock_irqrestore(&port->lock, flags);
-}
-
-static const char *sc26xx_type(struct uart_port *port)
-{
-	return driver_info(port)->chip->name;
-}
-
-static void sc26xx_release_port(struct uart_port *port)
-{
-}
-
-static int sc26xx_request_port(struct uart_port *port)
-{
-	return 0;
-}
-
-static void sc26xx_config_port(struct uart_port *port, int flags)
-{
-}
-
-static int sc26xx_verify_port(struct uart_port *port, struct serial_st=
ruct *ser)
-{
-	return -EINVAL;
-}
-
-static struct uart_ops sc26xx_ops =3D {
-	.tx_empty	=3D sc26xx_tx_empty,
-	.set_mctrl	=3D sc26xx_set_mctrl,
-	.get_mctrl	=3D sc26xx_get_mctrl,
-	.stop_tx	=3D sc26xx_stop_tx,
-	.start_tx	=3D sc26xx_start_tx,
-	.stop_rx	=3D sc26xx_stop_rx,
-	.enable_ms	=3D sc26xx_enable_ms,
-	.break_ctl	=3D sc26xx_break_ctl,
-	.startup	=3D sc26xx_startup,
-	.shutdown	=3D sc26xx_shutdown,
-	.set_termios	=3D sc26xx_set_termios,
-	.type		=3D sc26xx_type,
-	.release_port	=3D sc26xx_release_port,
-	.request_port	=3D sc26xx_request_port,
-	.config_port	=3D sc26xx_config_port,
-	.verify_port	=3D sc26xx_verify_port,
-};
-
-static struct uart_port *sc26xx_port;
-
-#ifdef CONFIG_SERIAL_SC26XX_CONSOLE
-static void sc26xx_console_putchar(struct uart_port *port, char c)
-{
-	unsigned long flags;
-	int limit =3D 1000000;
-
-	spin_lock_irqsave(&port->lock, flags);
-
-	while (limit-- > 0) {
-		if (READ_SC_PORT(port, SR) & SR_TXRDY) {
-			WRITE_SC_PORT(port, THR, c);
-			break;
-		}
-		udelay(2);
-	}
-
-	spin_unlock_irqrestore(&port->lock, flags);
-}
-
-static void sc26xx_console_write(struct console *con, const char *s, u=
nsigned n)
-{
-	struct uart_port *port =3D sc26xx_port;
-	int i;
-
-	for (i =3D 0; i < n; i++) {
-		if (*s =3D=3D '\n')
-			sc26xx_console_putchar(port, '\r');
-		sc26xx_console_putchar(port, *s++);
-	}
-}
-
-static int __init sc26xx_console_setup(struct console *con, char *opti=
ons)
-{
-	struct uart_port *port =3D sc26xx_port;
-	int baud =3D 9600;
-	int bits =3D 8;
-	int parity =3D 'n';
-	int flow =3D 'n';
-
-	if (port->type !=3D PORT_SC26XX)
-		return -1;
-
-	printk(KERN_INFO "Console: ttySC%d (SC26XX)\n", con->index);
-	if (options)
-		uart_parse_options(options, &baud, &parity, &bits, &flow);
-
-	return uart_set_options(port, con, baud, parity, bits, flow);
-}
-
-static struct uart_driver sc26xx_reg;
-static struct console sc26xx_console =3D {
-	.name	=3D	"ttySC",
-	.write	=3D	sc26xx_console_write,
-	.device	=3D	uart_console_device,
-	.setup  =3D       sc26xx_console_setup,
-	.flags	=3D	CON_PRINTBUFFER,
-	.index	=3D	-1,
-	.data	=3D	&sc26xx_reg,
-};
-#define SC26XX_CONSOLE   &sc26xx_console
-#else
-#define SC26XX_CONSOLE   NULL
-#endif
-
-static struct uart_driver sc26xx_reg =3D {
-	.owner			=3D THIS_MODULE,
-	.driver_name		=3D "SC26xx",
-	.dev_name		=3D "ttySC",
-	.major			=3D SC26XX_MAJOR,
-	.minor			=3D SC26XX_MINOR_START,
-	.nr			=3D SC26XX_NR,
-	.cons                   =3D SC26XX_CONSOLE,
-};
-
-static u8 sc26xx_flags2mask(unsigned int flags, unsigned int bitpos)
-{
-	unsigned int bit =3D (flags >> bitpos) & 15;
-
-	return bit ? (1 << (bit - 1)) : 0;
-}
-
-static void __devinit sc26xx_init_masks(struct uart_sc26xx_port *up,
-					int line, unsigned int data)
-{
-	up->dtr_mask[line] =3D sc26xx_flags2mask(data,  0);
-	up->rts_mask[line] =3D sc26xx_flags2mask(data,  4);
-	up->dsr_mask[line] =3D sc26xx_flags2mask(data,  8);
-	up->cts_mask[line] =3D sc26xx_flags2mask(data, 12);
-	up->dcd_mask[line] =3D sc26xx_flags2mask(data, 16);
-	up->ri_mask[line]  =3D sc26xx_flags2mask(data, 20);
-}
-
-static int __devinit init_baudgroup(struct uart_sc26xx_port *up)
-{
-	struct plat_serial_sc2xxx *pdata =3D up->port[0].dev->platform_data;
-
-	u8 baud_mode =3D up->chip->default_baud_mode;
-	u8 baud_group =3D up->chip->default_baud_group;
-
-	if (pdata->baud_mode > 0)
-		baud_mode =3D pdata->baud_mode - 1;
-
-	if (pdata->baud_group > 0)
-		baud_group =3D pdata->baud_group - 1;
-
-	if (baud_mode > up->chip->max_baud_mode) {
-		printk(KERN_ERR "Baud mode %d not supported for %s\n",
-			baud_mode, up->chip->name);
-		return -EINVAL;
-	}
-
-	up->acr =3D baud_group ? 0x80 : 0;
-	up->baud_rates =3D baud_rates[baud_mode][baud_group];
-
-	switch (baud_mode) {
-	case 0:
-		up->mr0_baud =3D 0;
-		break;
-	case 1:
-		up->mr0_baud =3D 1;
-		break;
-	case 2:
-		up->mr0_baud =3D 4;
-		break;
-	}
-	return 0;
-}
-
-static const struct chip_def * __devinit chip_by_name(const char *name=
)
-{
-	int i;
-	const struct chip_def *chip;
-
-	for (i =3D 0; i < ARRAY_SIZE(chips); i++) {
-		chip =3D chips[i];
-		if (!strcmp(chip->name, name))
-			return chip;
-	}
-
-	return NULL;
-}
-
-static const struct chip_def * __devinit detect_chip_type(
-	struct uart_sc26xx_port *up)
-{
-	struct uart_port *port =3D &up->port[0];
-	struct chip_def *chip;
-	int i;
-	u8 mrx[3];
-
-	/* Code below needs to be tested on 26xx hardware
-	 * Idea is that 26xx will ignore SEL_MR0 so 2nd and 3rd reads
-	 * will return same data.*/
-	write_cmd_port(port, CR_RES_MR); /* MR1 */
-	write_cmd_port(port, CR_SEL_MR0); /* Ignored on 26xx */
-
-	for (i =3D 0; i < 3; i++)
-		mrx[i] =3D READ_SC_PORT(port, MRx);
-
-	if (mrx[1] =3D=3D mrx[2])
-		chip =3D &chip_26xx;
-	else
-		chip =3D &chip_2892;
-
-	dev_info(port->dev, "Autodetected %s\n", chip->name);
-	return chip;
-}
-
-static void __devinit hw_init(struct uart_port *port)
-{
-	u8 mr;
-
-	/* Sometimes on cold boot MR1,MR2 are 0xFF (reset problem?)
-	 * Initialise if channel mode in MR2 is not normal otherwise
-	 * assume bootloader has done the init.
-	 */
-	write_cmd_port(port, CR_RES_MR); /* MR1 */
-	READ_SC_PORT(port, MRx); /* skip MR1 */
-	mr =3D READ_SC_PORT(port, MRx);
-	if (mr & 0xC0) {
-		write_cmd_port(port, CR_RES_MR);
-
-		/* Values below are arbitary (will be changed by set_termios)
-		 * but must be different so that chip detection works */
-		WRITE_SC_PORT(port, MRx, 0x10);
-		WRITE_SC_PORT(port, MRx, 0x00);
-	}
-}
-
-static int __devinit sc26xx_probe(struct platform_device *dev)
-{
-	struct resource *res, *irq_res;
-	struct uart_sc26xx_port *up;
-	struct plat_serial_sc2xxx *pdata =3D dev->dev.platform_data;
-	int err;
-
-	if (!pdata) {
-		dev_err(&dev->dev, "No platform data\n");
-		return -EINVAL;
-	}
-
-	res =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	irq_res =3D platform_get_resource(dev, IORESOURCE_IRQ, 0);
-	if (!irq_res)
-		return -ENXIO;
-
-	up =3D kzalloc(sizeof *up, GFP_KERNEL);
-	if (unlikely(!up))
-		return -ENOMEM;
-
-	up->port[0].line =3D 0;
-	up->port[0].ops =3D &sc26xx_ops;
-	up->port[0].type =3D PORT_SC26XX;
-	up->port[0].uartclk =3D (29491200 / 16); /* arbitrary */
-
-	up->port[0].mapbase =3D res->start;
-	up->port[0].membase =3D ioremap_nocache(up->port[0].mapbase, 0x40);
-	up->port[0].iotype =3D UPIO_MEM;
-	up->port[0].irq =3D irq_res->start;
-
-	up->port[0].dev =3D &dev->dev;
-
-	sc26xx_init_masks(up, 0, pdata->signal_map[0]);
-	hw_init(&up->port[0]);
-
-	sc26xx_port =3D &up->port[0];
-
-	memcpy(&up->port[1], &up->port[0], sizeof(up->port[0]));
-	up->port[1].line =3D 1;
-
-	sc26xx_init_masks(up, 1, pdata->signal_map[1]);
-	hw_init(&up->port[1]);
-
-	if (pdata->chip_name)
-		up->chip =3D chip_by_name(pdata->chip_name);
-	if (!up->chip) {
-		if (pdata->chip_name)
-			dev_warn(&dev->dev,
-				"Unknown chip %s requested - use autodetect\n",
-				pdata->chip_name);
-		up->chip =3D detect_chip_type(up);
-	}
-
-	err =3D init_baudgroup(up);
-	if (err)
-		goto out_free_port;
-
-	err =3D uart_register_driver(&sc26xx_reg);
-	if (err)
-		goto out_free_port;
-
-	err =3D uart_add_one_port(&sc26xx_reg, &up->port[0]);
-	if (err)
-		goto out_unregister_driver;
-
-	err =3D uart_add_one_port(&sc26xx_reg, &up->port[1]);
-	if (err)
-		goto out_remove_port0;
-
-	err =3D request_irq(up->port[0].irq, sc26xx_interrupt,
-		irq_res->flags & IRQF_TRIGGER_MASK, "sc26xx", up);
-	if (err)
-		goto out_remove_ports;
-
-	dev_set_drvdata(&dev->dev, up);
-	return 0;
-
-out_remove_ports:
-	uart_remove_one_port(&sc26xx_reg, &up->port[1]);
-out_remove_port0:
-	uart_remove_one_port(&sc26xx_reg, &up->port[0]);
-
-out_unregister_driver:
-	uart_unregister_driver(&sc26xx_reg);
-
-out_free_port:
-	kfree(up);
-	sc26xx_port =3D NULL;
-	return err;
-}
-
-
-static int __devexit sc26xx_driver_remove(struct platform_device *dev)
-{
-	struct uart_sc26xx_port *up =3D dev_get_drvdata(&dev->dev);
-
-	free_irq(up->port[0].irq, up);
-
-	uart_remove_one_port(&sc26xx_reg, &up->port[0]);
-	uart_remove_one_port(&sc26xx_reg, &up->port[1]);
-
-	uart_unregister_driver(&sc26xx_reg);
-
-	kfree(up);
-	sc26xx_port =3D NULL;
-
-	dev_set_drvdata(&dev->dev, NULL);
-	return 0;
-}
-
-static struct platform_driver sc26xx_driver =3D {
-	.probe	=3D sc26xx_probe,
-	.remove	=3D __devexit_p(sc26xx_driver_remove),
-	.driver	=3D {
-		.name	=3D "SC26xx",
-		.owner	=3D THIS_MODULE,
-	},
-};
-
-static int __init sc26xx_init(void)
-{
-	return platform_driver_register(&sc26xx_driver);
-}
-
-static void __exit sc26xx_exit(void)
-{
-	platform_driver_unregister(&sc26xx_driver);
-}
-
-module_init(sc26xx_init);
-module_exit(sc26xx_exit);
-
-
-MODULE_AUTHOR("Thomas Bogend=C3=B6rfer");
-MODULE_DESCRIPTION("SC681/SC2692 serial driver");
-MODULE_VERSION("1.0");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:SC26xx");
diff --git a/drivers/serial/sc2xxx.c b/drivers/serial/sc2xxx.c
new file mode 100644
index 0000000..3e87c37
--- /dev/null
+++ b/drivers/serial/sc2xxx.c
@@ -0,0 +1,998 @@
+/*
+ * SC2xxx.c: Serial driver for Philips SC2X81/SC2X92/SC2892 devices.
+ *
+ * Copyright (C) 2006,2007 Thomas Bogend=C3=B6rfer (tsbogend@alpha.fra=
nken.de)
+ * SC2892 support by Martin Fuzzey (mfuzzey@gmail.com)
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/major.h>
+#include <linux/circ_buf.h>
+#include <linux/serial.h>
+#include <linux/sysrq.h>
+#include <linux/console.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/serial_sc2xxx.h>
+
+#if defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/serial_core.h>
+
+#define SC2XXX_MAJOR         204
+#define SC2XXX_MINOR_START   205
+#define SC2XXX_NR            2
+
+struct chip_def {
+	u8	has_mr0;
+	u8	init_mr0;
+	u8	init_mr1;
+	u8	max_baud_mode;
+	u8	default_baud_mode;
+	u8	default_baud_group;
+	const char *name;
+};
+
+struct uart_sc2xxx_port {
+	struct uart_port      port[2];
+	u8	dsr_mask[2];
+	u8	cts_mask[2];
+	u8	dcd_mask[2];
+	u8	ri_mask[2];
+	u8	dtr_mask[2];
+	u8	rts_mask[2];
+	u8	imr;
+	u8	acr;
+	u8	mr0_baud;
+	const unsigned int *baud_rates;
+	const struct chip_def *chip;
+};
+
+/* register common to both ports */
+#define RD_ISR      0x14
+#define RD_IPR      0x34
+
+#define WR_ACR      0x10
+#define WR_IMR      0x14
+#define WR_OPCR     0x34
+#define WR_OPR_SET  0x38
+#define WR_OPR_CLR  0x3C
+
+/* access common register */
+#define READ_SC(p, r)        readb((p)->membase + RD_##r)
+#define WRITE_SC(p, r, v)    writeb((v), (p)->membase + WR_##r)
+
+/* register per port */
+#define RD_PORT_MRx 0x00
+#define RD_PORT_SR  0x04
+#define RD_PORT_RHR 0x0c
+
+#define WR_PORT_MRx 0x00
+#define WR_PORT_CSR 0x04
+#define WR_PORT_CR  0x08
+#define WR_PORT_THR 0x0c
+
+/* SR bits */
+#define SR_BREAK    (1 << 7)
+#define SR_FRAME    (1 << 6)
+#define SR_PARITY   (1 << 5)
+#define SR_OVERRUN  (1 << 4)
+#define SR_TXEMT    (1 << 3)
+#define SR_TXRDY    (1 << 2)
+#define SR_RXRDY    (1 << 0)
+
+#define CR_RES_MR   (1 << 4)
+#define CR_RES_RX   (2 << 4)
+#define CR_RES_TX   (3 << 4)
+#define CR_STRT_BRK (6 << 4)
+#define CR_STOP_BRK (7 << 4)
+#define CR_SEL_MR0  (11 << 4)
+#define CR_DIS_TX   (1 << 3)
+#define CR_ENA_TX   (1 << 2)
+#define CR_DIS_RX   (1 << 1)
+#define CR_ENA_RX   (1 << 0)
+
+/* ISR bits */
+#define ISR_RXRDYB  (1 << 5)
+#define ISR_TXRDYB  (1 << 4)
+#define ISR_RXRDYA  (1 << 1)
+#define ISR_TXRDYA  (1 << 0)
+
+/* IMR bits */
+#define IMR_RXRDY   (1 << 1)
+#define IMR_TXRDY   (1 << 0)
+
+/* MR0 bits (>=3D 28L92 only */
+#define MR0_WATCHDOG	(1 << 7)
+#define MR0_RXINT2	(1 << 6)
+#define MR0_TXINT(x)	((x) << 4)
+#define MR0_FIFO_SIZE	(1 << 3)
+#define MR0_BAUD_MODE	((1 << 2) + (1 << 0))
+
+
+#define NR_BAUD_GROUPS 2
+#define NR_BAUD_MODES 3
+#define NR_BAUDS 13
+#define DEFAULT_BAUD_INDEX 11
+static const unsigned baud_rates[NR_BAUD_MODES][NR_BAUD_GROUPS][NR_BAU=
DS] =3D {
+	{
+		/* Normal mode ACR[7] =3D 0 */
+		{50, 110, 134, 200, 300, 600, 1200, 1050,
+			2400, 4800, 7200, 9600, 38400},
+
+		/* Normal mode ACR[7] =3D 1 */
+		{75, 110, 134, 150, 300, 600, 1200, 2000,
+			2400, 4800, 1800, 9600, 19200},
+	}, {
+		/* Extended mode 1 ACR[7] =3D 0 */
+		{300, 110, 134, 1200, 1800, 3600, 7200, 1050,
+			14400, 28800, 7200, 57600, 230400},
+
+		/* Extended mode 1 ACR[7] =3D 1 */
+		{450, 110, 134, 900, 1800, 3600, 72000, 2000,
+			14400, 28800, 1800, 57600, 115200},
+	}, {
+		/* Extended mode 2 ACR[7] =3D 0 */
+		{4800, 880, 1076, 19200, 28800, 57600, 115200, 1050,
+			57600, 4800, 57600, 9600, 38400},
+
+		/* Extended mode 2 ACR[7] =3D 1 */
+		{7200, 880, 1076, 14400, 28800, 57600, 115200, 2000,
+			57600, 4800, 14400, 9600, 19200},
+	}
+};
+
+static struct chip_def chip_2xxx =3D {
+	.name =3D "SC2XXX",
+	.max_baud_mode =3D 0,
+	.default_baud_mode =3D 0,
+	.default_baud_group =3D 1,
+	.has_mr0 =3D 0,
+	.init_mr1 =3D 0,
+};
+
+static struct chip_def chip_2892 =3D {
+	.name =3D "SC2892",
+	.max_baud_mode =3D 2,
+	.default_baud_mode =3D 2,
+	.default_baud_group =3D 0,
+	.has_mr0 =3D 1,
+	.init_mr0 =3D  MR0_WATCHDOG | MR0_FIFO_SIZE | MR0_TXINT(1),
+	.init_mr1 =3D (1 << 6),
+};
+
+static const struct chip_def *chips[] =3D {
+	&chip_2xxx,
+	&chip_2892
+};
+
+static struct uart_sc2xxx_port *driver_info(struct uart_port *port)
+{
+	port -=3D port->line;
+	return container_of(port, struct uart_sc2xxx_port, port[0]);
+}
+
+/* access port register */
+static inline u8 read_sc_line(struct uart_port *p, int line, u8 reg)
+{
+	return readb(p->membase + line * 0x20 + reg);
+}
+
+static inline u8 read_sc_port(struct uart_port *p, u8 reg)
+{
+	return read_sc_line(p, p->line, reg);
+}
+
+static inline void write_sc_line(struct uart_port *p, int line, u8 reg=
, u8 val)
+{
+	writeb(val, p->membase + line * 0x20 + reg);
+}
+
+static inline void write_sc_port(struct uart_port *p, u8 reg, u8 val)
+{
+	write_sc_line(p, p->line, reg, val);
+}
+
+#define READ_SC_PORT(p, r)     read_sc_port(p, RD_PORT_##r)
+#define WRITE_SC_PORT(p, r, v) write_sc_port(p, WR_PORT_##r, v)
+
+static void write_cmd_line(struct uart_port *port, int line, u8 cmd)
+{
+	int i;
+
+	write_sc_line(port, line, WR_PORT_CR, cmd);
+
+	/* According to data sheet require 3 NOPs before next command */
+	for (i =3D 0; i < 3; i++)
+		write_sc_line(port, line, WR_PORT_CR, 0);
+}
+
+static inline void write_cmd_port(struct uart_port *port, u8 cmd)
+{
+	write_cmd_line(port, port->line, cmd);
+}
+
+
+static u8 read_mr0(struct uart_port *port, int line)
+{
+	write_cmd_line(port, line, CR_SEL_MR0);
+	return read_sc_line(port, line, RD_PORT_MRx);
+}
+
+static void write_mr0(struct uart_port *port, int line, u8 val)
+{
+	write_cmd_line(port, line, CR_SEL_MR0);
+	write_sc_line(port, line, WR_PORT_MRx, val);
+}
+
+static void sc2xxx_enable_irq(struct uart_port *port, int mask)
+{
+	struct uart_sc2xxx_port *up =3D driver_info(port);
+
+	up->imr |=3D mask << (port->line * 4);
+	WRITE_SC(port, IMR, up->imr);
+}
+
+static void sc2xxx_disable_irq(struct uart_port *port, int mask)
+{
+	struct uart_sc2xxx_port *up =3D driver_info(port);
+
+	up->imr &=3D ~(mask << (port->line * 4));
+	WRITE_SC(port, IMR, up->imr);
+}
+
+static struct tty_struct *receive_chars(struct uart_port *port)
+{
+	struct tty_struct *tty =3D NULL;
+	int limit =3D 10000;
+	unsigned char ch;
+	char flag;
+	u8 status;
+
+	if (port->state !=3D NULL)		/* Unopened serial console */
+		tty =3D port->state->port.tty;
+
+	while (limit-- > 0) {
+		status =3D READ_SC_PORT(port, SR);
+		if (!(status & SR_RXRDY))
+			break;
+		ch =3D READ_SC_PORT(port, RHR);
+
+		flag =3D TTY_NORMAL;
+		port->icount.rx++;
+
+		if (unlikely(status & (SR_BREAK | SR_FRAME |
+				       SR_PARITY | SR_OVERRUN))) {
+			if (status & SR_BREAK) {
+				status &=3D ~(SR_PARITY | SR_FRAME);
+				port->icount.brk++;
+				if (uart_handle_break(port))
+					continue;
+			} else if (status & SR_PARITY)
+				port->icount.parity++;
+			else if (status & SR_FRAME)
+				port->icount.frame++;
+			if (status & SR_OVERRUN)
+				port->icount.overrun++;
+
+			status &=3D port->read_status_mask;
+			if (status & SR_BREAK)
+				flag =3D TTY_BREAK;
+			else if (status & SR_PARITY)
+				flag =3D TTY_PARITY;
+			else if (status & SR_FRAME)
+				flag =3D TTY_FRAME;
+		}
+
+		if (uart_handle_sysrq_char(port, ch))
+			continue;
+
+		if (status & port->ignore_status_mask)
+			continue;
+
+		if (tty)
+			tty_insert_flip_char(tty, ch, flag);
+	}
+	return tty;
+}
+
+static void transmit_chars(struct uart_port *port)
+{
+	struct circ_buf *xmit;
+
+	if (!port->state)
+		return;
+
+	xmit =3D &port->state->xmit;
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		sc2xxx_disable_irq(port, IMR_TXRDY);
+		return;
+	}
+	while (!uart_circ_empty(xmit)) {
+		if (!(READ_SC_PORT(port, SR) & SR_TXRDY))
+			break;
+
+		WRITE_SC_PORT(port, THR, xmit->buf[xmit->tail]);
+		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+	}
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
+
+static irqreturn_t sc2xxx_interrupt(int irq, void *dev_id)
+{
+	struct uart_sc2xxx_port *up =3D dev_id;
+	struct tty_struct *tty;
+	unsigned long flags;
+	u8 isr;
+
+	spin_lock_irqsave(&up->port[0].lock, flags);
+
+	tty =3D NULL;
+	isr =3D READ_SC(&up->port[0], ISR);
+	if (isr & ISR_TXRDYA)
+	    transmit_chars(&up->port[0]);
+	if (isr & ISR_RXRDYA)
+	    tty =3D receive_chars(&up->port[0]);
+
+	spin_unlock(&up->port[0].lock);
+
+	if (tty)
+		tty_flip_buffer_push(tty);
+
+	spin_lock(&up->port[1].lock);
+
+	tty =3D NULL;
+	if (isr & ISR_TXRDYB)
+	    transmit_chars(&up->port[1]);
+	if (isr & ISR_RXRDYB)
+	    tty =3D receive_chars(&up->port[1]);
+
+	spin_unlock_irqrestore(&up->port[1].lock, flags);
+
+	if (tty)
+		tty_flip_buffer_push(tty);
+
+	return IRQ_HANDLED;
+}
+
+/* port->lock is not held.  */
+static unsigned int sc2xxx_tx_empty(struct uart_port *port)
+{
+	return (READ_SC_PORT(port, SR) & SR_TXRDY) ? TIOCSER_TEMT : 0;
+}
+
+/* port->lock held by caller.  */
+static void sc2xxx_set_mctrl(struct uart_port *port, unsigned int mctr=
l)
+{
+	struct uart_sc2xxx_port *up =3D driver_info(port);
+	int line =3D port->line;
+
+	if (up->dtr_mask[line]) {
+		if (mctrl & TIOCM_DTR)
+			WRITE_SC(port, OPR_SET, up->dtr_mask[line]);
+		else
+			WRITE_SC(port, OPR_CLR, up->dtr_mask[line]);
+	}
+	if (up->rts_mask[line]) {
+		if (mctrl & TIOCM_RTS)
+			WRITE_SC(port, OPR_SET, up->rts_mask[line]);
+		else
+			WRITE_SC(port, OPR_CLR, up->rts_mask[line]);
+	}
+}
+
+/* port->lock is held by caller and interrupts are disabled.  */
+static unsigned int sc2xxx_get_mctrl(struct uart_port *port)
+{
+	struct uart_sc2xxx_port *up =3D driver_info(port);
+	int line =3D port->line;
+	unsigned int mctrl =3D TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
+	u8 ipr;
+
+	ipr =3D READ_SC(port, IPR) ^ 0xff;
+
+	if (up->dsr_mask[line]) {
+		mctrl &=3D ~TIOCM_DSR;
+		mctrl |=3D ipr & up->dsr_mask[line] ? TIOCM_DSR : 0;
+	}
+	if (up->cts_mask[line]) {
+		mctrl &=3D ~TIOCM_CTS;
+		mctrl |=3D ipr & up->cts_mask[line] ? TIOCM_CTS : 0;
+	}
+	if (up->dcd_mask[line]) {
+		mctrl &=3D ~TIOCM_CAR;
+		mctrl |=3D ipr & up->dcd_mask[line] ? TIOCM_CAR : 0;
+	}
+	if (up->ri_mask[line]) {
+		mctrl &=3D ~TIOCM_RNG;
+		mctrl |=3D ipr & up->ri_mask[line] ? TIOCM_RNG : 0;
+	}
+	return mctrl;
+}
+
+/* port->lock held by caller.  */
+static void sc2xxx_stop_tx(struct uart_port *port)
+{
+	return;
+}
+
+/* port->lock held by caller.  */
+static void sc2xxx_start_tx(struct uart_port *port)
+{
+	struct circ_buf *xmit =3D &port->state->xmit;
+
+	while (!uart_circ_empty(xmit)) {
+		if (!(READ_SC_PORT(port, SR) & SR_TXRDY)) {
+			sc2xxx_enable_irq(port, IMR_TXRDY);
+			break;
+		}
+		WRITE_SC_PORT(port, THR, xmit->buf[xmit->tail]);
+		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+	}
+}
+
+/* port->lock held by caller.  */
+static void sc2xxx_stop_rx(struct uart_port *port)
+{
+}
+
+/* port->lock held by caller.  */
+static void sc2xxx_enable_ms(struct uart_port *port)
+{
+}
+
+/* port->lock is not held.  */
+static void sc2xxx_break_ctl(struct uart_port *port, int break_state)
+{
+	if (break_state =3D=3D -1)
+		write_cmd_port(port, CR_STRT_BRK);
+	else
+		write_cmd_port(port, CR_STOP_BRK);
+}
+
+/* port->lock is not held.  */
+static int sc2xxx_startup(struct uart_port *port)
+{
+	struct uart_sc2xxx_port *up =3D driver_info(port);
+
+	sc2xxx_disable_irq(port, IMR_TXRDY | IMR_RXRDY);
+	WRITE_SC(port, OPCR, 0);
+
+	/* reset tx and rx */
+	write_cmd_port(port, CR_RES_RX);
+	write_cmd_port(port, CR_RES_TX);
+
+	if (up->chip->has_mr0)
+		write_mr0(port, port->line, up->chip->init_mr0);
+
+	/* start rx/tx */
+	WRITE_SC_PORT(port, CR, CR_ENA_TX | CR_ENA_RX);
+
+	/* enable irqs */
+	sc2xxx_enable_irq(port, IMR_RXRDY);
+	return 0;
+}
+
+/* port->lock is not held.  */
+static void sc2xxx_shutdown(struct uart_port *port)
+{
+	/* disable interrupst */
+	sc2xxx_disable_irq(port, IMR_TXRDY | IMR_RXRDY);
+
+	/* stop tx/rx */
+	WRITE_SC_PORT(port, CR, CR_DIS_TX | CR_DIS_RX);
+}
+
+static int wait_tx_empty(struct uart_port *port)
+{
+	int i;
+	u8 sr;
+	u8 bits =3D SR_TXEMT | SR_TXRDY;
+
+	for (i =3D 0; i < 10000; i++) {
+		sr =3D READ_SC_PORT(port, SR);
+		if  ((sr & bits) =3D=3D bits)
+			return 0;
+		udelay(2);
+	}
+	dev_warn(port->dev, "Timed out waiting for TX Empty sr=3D%02X\n", sr)=
;
+	return -1;
+}
+
+static u8 find_csr(struct uart_sc2xxx_port *up, unsigned int baud)
+{
+	int i, found =3D -1;
+
+	for (i =3D 0; i < NR_BAUDS; i++) {
+		if (up->baud_rates[i] =3D=3D baud) {
+			found =3D i;
+			break;
+		}
+	}
+
+	if (found =3D=3D -1) {
+		found =3D DEFAULT_BAUD_INDEX;
+		dev_warn(up->port[0].dev,
+			"%d baud not available using %d\n",
+			baud, up->baud_rates[found]);
+	}
+
+	return (u8)found | ((u8)found << 4);
+}
+
+/* port->lock is not held.  */
+static void sc2xxx_set_termios(struct uart_port *port, struct ktermios=
 *termios,
+			      struct ktermios *old)
+{
+	struct uart_sc2xxx_port *up =3D driver_info(port);
+	unsigned int baud =3D uart_get_baud_rate(port, termios, old, 0, 40000=
00);
+	unsigned int iflag, cflag;
+	unsigned long flags;
+	u8 mr1, mr2, csr;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (wait_tx_empty(port))
+		goto out;
+
+	WRITE_SC_PORT(port, CR, CR_DIS_TX | CR_DIS_RX);
+
+	iflag =3D termios->c_iflag;
+	cflag =3D termios->c_cflag;
+
+	port->read_status_mask =3D SR_OVERRUN;
+	if (iflag & INPCK)
+		port->read_status_mask |=3D SR_PARITY | SR_FRAME;
+	if (iflag & (BRKINT | PARMRK))
+		port->read_status_mask |=3D SR_BREAK;
+
+	port->ignore_status_mask =3D 0;
+	if (iflag & IGNBRK)
+		port->ignore_status_mask |=3D SR_BREAK;
+	if ((cflag & CREAD) =3D=3D 0)
+		port->ignore_status_mask |=3D SR_BREAK | SR_FRAME |
+					    SR_PARITY | SR_OVERRUN;
+
+	switch (cflag & CSIZE) {
+	case CS5:
+		mr1 =3D 0x00;
+		break;
+	case CS6:
+		mr1 =3D 0x01;
+		break;
+	case CS7:
+		mr1 =3D 0x02;
+		break;
+	default:
+	case CS8:
+		mr1 =3D 0x03;
+		break;
+	}
+	mr2 =3D 0x07;
+	if (cflag & CSTOPB)
+		mr2 =3D 0x0f;
+	if (cflag & PARENB) {
+		if (cflag & PARODD)
+			mr1 |=3D (1 << 2);
+	} else
+		mr1 |=3D (2 << 3);
+
+	mr1 |=3D up->chip->init_mr1;
+	csr =3D find_csr(up, baud);
+
+	if (up->chip->has_mr0) {
+		u8 mr0a =3D read_mr0(port, 0);
+		mr0a &=3D ~MR0_BAUD_MODE;
+		mr0a |=3D up->mr0_baud;
+		write_mr0(port, 0, mr0a);
+	}
+
+	write_cmd_port(port, CR_RES_MR);
+	WRITE_SC_PORT(port, MRx, mr1);
+	WRITE_SC_PORT(port, MRx, mr2);
+
+	WRITE_SC(port, ACR, up->acr);
+	WRITE_SC_PORT(port, CSR, csr);
+
+	/* reset tx and rx */
+	write_cmd_port(port, CR_RES_RX);
+	write_cmd_port(port, CR_RES_TX);
+
+	WRITE_SC_PORT(port, CR, CR_ENA_TX | CR_ENA_RX);
+	if (wait_tx_empty(port))
+		goto out;
+
+	uart_update_timeout(port, cflag, baud);
+out:
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *sc2xxx_type(struct uart_port *port)
+{
+	return driver_info(port)->chip->name;
+}
+
+static void sc2xxx_release_port(struct uart_port *port)
+{
+}
+
+static int sc2xxx_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+static void sc2xxx_config_port(struct uart_port *port, int flags)
+{
+}
+
+static int sc2xxx_verify_port(struct uart_port *port, struct serial_st=
ruct *ser)
+{
+	return -EINVAL;
+}
+
+static struct uart_ops sc2xxx_ops =3D {
+	.tx_empty	=3D sc2xxx_tx_empty,
+	.set_mctrl	=3D sc2xxx_set_mctrl,
+	.get_mctrl	=3D sc2xxx_get_mctrl,
+	.stop_tx	=3D sc2xxx_stop_tx,
+	.start_tx	=3D sc2xxx_start_tx,
+	.stop_rx	=3D sc2xxx_stop_rx,
+	.enable_ms	=3D sc2xxx_enable_ms,
+	.break_ctl	=3D sc2xxx_break_ctl,
+	.startup	=3D sc2xxx_startup,
+	.shutdown	=3D sc2xxx_shutdown,
+	.set_termios	=3D sc2xxx_set_termios,
+	.type		=3D sc2xxx_type,
+	.release_port	=3D sc2xxx_release_port,
+	.request_port	=3D sc2xxx_request_port,
+	.config_port	=3D sc2xxx_config_port,
+	.verify_port	=3D sc2xxx_verify_port,
+};
+
+static struct uart_port *sc2xxx_port;
+
+#ifdef CONFIG_SERIAL_SC2XXX_CONSOLE
+static void sc2xxx_console_putchar(struct uart_port *port, char c)
+{
+	unsigned long flags;
+	int limit =3D 1000000;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	while (limit-- > 0) {
+		if (READ_SC_PORT(port, SR) & SR_TXRDY) {
+			WRITE_SC_PORT(port, THR, c);
+			break;
+		}
+		udelay(2);
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void sc2xxx_console_write(struct console *con, const char *s, u=
nsigned n)
+{
+	struct uart_port *port =3D sc2xxx_port;
+	int i;
+
+	for (i =3D 0; i < n; i++) {
+		if (*s =3D=3D '\n')
+			sc2xxx_console_putchar(port, '\r');
+		sc2xxx_console_putchar(port, *s++);
+	}
+}
+
+static int __init sc2xxx_console_setup(struct console *con, char *opti=
ons)
+{
+	struct uart_port *port =3D sc2xxx_port;
+	int baud =3D 9600;
+	int bits =3D 8;
+	int parity =3D 'n';
+	int flow =3D 'n';
+
+	if (port->type !=3D PORT_SC2XXX)
+		return -1;
+
+	printk(KERN_INFO "Console: ttySC%d (SC2XXX)\n", con->index);
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(port, con, baud, parity, bits, flow);
+}
+
+static struct uart_driver sc2xxx_reg;
+static struct console sc2xxx_console =3D {
+	.name	=3D	"ttySC",
+	.write	=3D	sc2xxx_console_write,
+	.device	=3D	uart_console_device,
+	.setup  =3D       sc2xxx_console_setup,
+	.flags	=3D	CON_PRINTBUFFER,
+	.index	=3D	-1,
+	.data	=3D	&sc2xxx_reg,
+};
+#define SC2XXX_CONSOLE   &sc2xxx_console
+#else
+#define SC2XXX_CONSOLE   NULL
+#endif
+
+static struct uart_driver sc2xxx_reg =3D {
+	.owner			=3D THIS_MODULE,
+	.driver_name		=3D "SC2xxx",
+	.dev_name		=3D "ttySC",
+	.major			=3D SC2XXX_MAJOR,
+	.minor			=3D SC2XXX_MINOR_START,
+	.nr			=3D SC2XXX_NR,
+	.cons                   =3D SC2XXX_CONSOLE,
+};
+
+static u8 sc2xxx_flags2mask(unsigned int flags, unsigned int bitpos)
+{
+	unsigned int bit =3D (flags >> bitpos) & 15;
+
+	return bit ? (1 << (bit - 1)) : 0;
+}
+
+static void __devinit sc2xxx_init_masks(struct uart_sc2xxx_port *up,
+					int line, unsigned int data)
+{
+	up->dtr_mask[line] =3D sc2xxx_flags2mask(data,  0);
+	up->rts_mask[line] =3D sc2xxx_flags2mask(data,  4);
+	up->dsr_mask[line] =3D sc2xxx_flags2mask(data,  8);
+	up->cts_mask[line] =3D sc2xxx_flags2mask(data, 12);
+	up->dcd_mask[line] =3D sc2xxx_flags2mask(data, 16);
+	up->ri_mask[line]  =3D sc2xxx_flags2mask(data, 20);
+}
+
+static int __devinit init_baudgroup(struct uart_sc2xxx_port *up)
+{
+	struct plat_serial_sc2xxx *pdata =3D up->port[0].dev->platform_data;
+
+	u8 baud_mode =3D up->chip->default_baud_mode;
+	u8 baud_group =3D up->chip->default_baud_group;
+
+	if (pdata->baud_mode > 0)
+		baud_mode =3D pdata->baud_mode - 1;
+
+	if (pdata->baud_group > 0)
+		baud_group =3D pdata->baud_group - 1;
+
+	if (baud_mode > up->chip->max_baud_mode) {
+		printk(KERN_ERR "Baud mode %d not supported for %s\n",
+			baud_mode, up->chip->name);
+		return -EINVAL;
+	}
+
+	up->acr =3D baud_group ? 0x80 : 0;
+	up->baud_rates =3D baud_rates[baud_mode][baud_group];
+
+	switch (baud_mode) {
+	case 0:
+		up->mr0_baud =3D 0;
+		break;
+	case 1:
+		up->mr0_baud =3D 1;
+		break;
+	case 2:
+		up->mr0_baud =3D 4;
+		break;
+	}
+	return 0;
+}
+
+static const struct chip_def * __devinit chip_by_name(const char *name=
)
+{
+	int i;
+	const struct chip_def *chip;
+
+	for (i =3D 0; i < ARRAY_SIZE(chips); i++) {
+		chip =3D chips[i];
+		if (!strcmp(chip->name, name))
+			return chip;
+	}
+
+	return NULL;
+}
+
+static const struct chip_def * __devinit detect_chip_type(
+	struct uart_sc2xxx_port *up)
+{
+	struct uart_port *port =3D &up->port[0];
+	struct chip_def *chip;
+	int i;
+	u8 mrx[3];
+
+	/* Code below needs to be tested on 2xxx hardware
+	 * Idea is that 2xxx will ignore SEL_MR0 so 2nd and 3rd reads
+	 * will return same data.*/
+	write_cmd_port(port, CR_RES_MR); /* MR1 */
+	write_cmd_port(port, CR_SEL_MR0); /* Ignored on 2xxx */
+
+	for (i =3D 0; i < 3; i++)
+		mrx[i] =3D READ_SC_PORT(port, MRx);
+
+	if (mrx[1] =3D=3D mrx[2])
+		chip =3D &chip_2xxx;
+	else
+		chip =3D &chip_2892;
+
+	dev_info(port->dev, "Autodetected %s\n", chip->name);
+	return chip;
+}
+
+static void __devinit hw_init(struct uart_port *port)
+{
+	u8 mr;
+
+	/* Sometimes on cold boot MR1,MR2 are 0xFF (reset problem?)
+	 * Initialise if channel mode in MR2 is not normal otherwise
+	 * assume bootloader has done the init.
+	 */
+	write_cmd_port(port, CR_RES_MR); /* MR1 */
+	READ_SC_PORT(port, MRx); /* skip MR1 */
+	mr =3D READ_SC_PORT(port, MRx);
+	if (mr & 0xC0) {
+		write_cmd_port(port, CR_RES_MR);
+
+		/* Values below are arbitary (will be changed by set_termios)
+		 * but must be different so that chip detection works */
+		WRITE_SC_PORT(port, MRx, 0x10);
+		WRITE_SC_PORT(port, MRx, 0x00);
+	}
+}
+
+static int __devinit sc2xxx_probe(struct platform_device *dev)
+{
+	struct resource *res, *irq_res;
+	struct uart_sc2xxx_port *up;
+	struct plat_serial_sc2xxx *pdata =3D dev->dev.platform_data;
+	int err;
+
+	if (!pdata) {
+		dev_err(&dev->dev, "No platform data\n");
+		return -EINVAL;
+	}
+
+	res =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	irq_res =3D platform_get_resource(dev, IORESOURCE_IRQ, 0);
+	if (!irq_res)
+		return -ENXIO;
+
+	up =3D kzalloc(sizeof *up, GFP_KERNEL);
+	if (unlikely(!up))
+		return -ENOMEM;
+
+	up->port[0].line =3D 0;
+	up->port[0].ops =3D &sc2xxx_ops;
+	up->port[0].type =3D PORT_SC2XXX;
+	up->port[0].uartclk =3D (29491200 / 16); /* arbitrary */
+
+	up->port[0].mapbase =3D res->start;
+	up->port[0].membase =3D ioremap_nocache(up->port[0].mapbase, 0x40);
+	up->port[0].iotype =3D UPIO_MEM;
+	up->port[0].irq =3D irq_res->start;
+
+	up->port[0].dev =3D &dev->dev;
+
+	sc2xxx_init_masks(up, 0, pdata->signal_map[0]);
+	hw_init(&up->port[0]);
+
+	sc2xxx_port =3D &up->port[0];
+
+	memcpy(&up->port[1], &up->port[0], sizeof(up->port[0]));
+	up->port[1].line =3D 1;
+
+	sc2xxx_init_masks(up, 1, pdata->signal_map[1]);
+	hw_init(&up->port[1]);
+
+	if (pdata->chip_name)
+		up->chip =3D chip_by_name(pdata->chip_name);
+	if (!up->chip) {
+		if (pdata->chip_name)
+			dev_warn(&dev->dev,
+				"Unknown chip %s requested - use autodetect\n",
+				pdata->chip_name);
+		up->chip =3D detect_chip_type(up);
+	}
+
+	err =3D init_baudgroup(up);
+	if (err)
+		goto out_free_port;
+
+	err =3D uart_register_driver(&sc2xxx_reg);
+	if (err)
+		goto out_free_port;
+
+	err =3D uart_add_one_port(&sc2xxx_reg, &up->port[0]);
+	if (err)
+		goto out_unregister_driver;
+
+	err =3D uart_add_one_port(&sc2xxx_reg, &up->port[1]);
+	if (err)
+		goto out_remove_port0;
+
+	err =3D request_irq(up->port[0].irq, sc2xxx_interrupt,
+		irq_res->flags & IRQF_TRIGGER_MASK, "sc2xxx", up);
+	if (err)
+		goto out_remove_ports;
+
+	dev_set_drvdata(&dev->dev, up);
+	return 0;
+
+out_remove_ports:
+	uart_remove_one_port(&sc2xxx_reg, &up->port[1]);
+out_remove_port0:
+	uart_remove_one_port(&sc2xxx_reg, &up->port[0]);
+
+out_unregister_driver:
+	uart_unregister_driver(&sc2xxx_reg);
+
+out_free_port:
+	kfree(up);
+	sc2xxx_port =3D NULL;
+	return err;
+}
+
+
+static int __devexit sc2xxx_driver_remove(struct platform_device *dev)
+{
+	struct uart_sc2xxx_port *up =3D dev_get_drvdata(&dev->dev);
+
+	free_irq(up->port[0].irq, up);
+
+	uart_remove_one_port(&sc2xxx_reg, &up->port[0]);
+	uart_remove_one_port(&sc2xxx_reg, &up->port[1]);
+
+	uart_unregister_driver(&sc2xxx_reg);
+
+	kfree(up);
+	sc2xxx_port =3D NULL;
+
+	dev_set_drvdata(&dev->dev, NULL);
+	return 0;
+}
+
+static struct platform_driver sc2xxx_driver =3D {
+	.probe	=3D sc2xxx_probe,
+	.remove	=3D __devexit_p(sc2xxx_driver_remove),
+	.driver	=3D {
+		.name	=3D "SC2xxx",
+		.owner	=3D THIS_MODULE,
+	},
+};
+
+static int __init sc2xxx_init(void)
+{
+	return platform_driver_register(&sc2xxx_driver);
+}
+
+static void __exit sc2xxx_exit(void)
+{
+	platform_driver_unregister(&sc2xxx_driver);
+}
+
+module_init(sc2xxx_init);
+module_exit(sc2xxx_exit);
+
+
+MODULE_AUTHOR("Thomas Bogend=C3=B6rfer");
+MODULE_DESCRIPTION("SC681/SC2XXX serial driver");
+MODULE_VERSION("1.0");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:SC2xxx");
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 8c3dd36..768984e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -157,7 +157,7 @@
 #define PORT_MN10300		80
 #define PORT_MN10300_CTS	81
=20
-#define PORT_SC26XX	82
+#define PORT_SC2XXX	82
=20
 /* SH-SCI */
 #define PORT_SCIFA	83

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
