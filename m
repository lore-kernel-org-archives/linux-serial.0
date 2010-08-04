From: Pavel Machek <pma@sysgo.com>
Subject: Driver for kontron PMC-6L interface card
Date: Wed, 4 Aug 2010 14:49:07 +0200
Message-ID: <20100804124907.GA18820@pma.sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.sysgo.com ([195.145.229.155]:48227 "EHLO mail.sysgo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932815Ab0HDM6P (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Aug 2010 08:58:15 -0400
Received: from donald.sysgo.com (unknown [172.22.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id CE7591413B
	for <linux-serial@vger.kernel.org>; Wed,  4 Aug 2010 14:49:05 +0200 (CEST)
Received: from dagobert.sysgo.com (dagobert.sysgo.com [172.22.1.2])
	by donald.sysgo.com (Postfix) with ESMTP id B07F5344077
	for <linux-serial@vger.kernel.org>; Wed,  4 Aug 2010 14:49:05 +0200 (CEST)
Received: from dagobert.sysgo.com (localhost [127.0.0.1])
	by dagobert.sysgo.com (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id o74Cn5Eo004830
	for <linux-serial@vger.kernel.org>; Wed, 4 Aug 2010 14:49:05 +0200
Received: from localhost (localhost [[UNIX: localhost]])
	by dagobert.sysgo.com (8.12.7/8.12.7/Submit) id o74Cn5dZ004825
	for linux-serial@vger.kernel.org; Wed, 4 Aug 2010 14:49:05 +0200
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi!

Here's driver for PMC-6L interface card. It is against 2.6.27
(sorry). It seems to mostly work. It is quite an interesting card, for
example it timestamps incoming characters.

Problems remaining:

1) Due to ringbuffer design, I don't know how to handle input buffer
overrun.

2) stop_rx is currently a nop. I'm not sure if it is required? I guess
I could set RX buffer size to zero....?

I hope I did get the locking right.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff -ur clean-27//drivers/serial/Kconfig linux-27//drivers/serial/Kconfig
--- clean-27//drivers/serial/Kconfig	2008-10-10 00:13:53.000000000 +0200
+++ linux-27//drivers/serial/Kconfig	2010-08-04 14:21:53.000000000 +0200
@@ -1343,6 +1343,14 @@
 	  If you have enabled the serial port on the Hilscher NetX SoC
 	  you can make it the console by answering Y to this option.
 
+config SERIAL_PMC6L
+        tristate "Serial ports on PMC-6L interface board"
+	select SERIAL_CORE
+	depends on PCI
+	help
+	  Select this if you have PMC-6L interface board. Up-to 6
+	  serial ports are provided there, based on configuration.
+
 config SERIAL_OF_PLATFORM
 	tristate "Serial port on Open Firmware platform bus"
 	depends on PPC_OF
diff -ur clean-27//drivers/serial/Makefile linux-27//drivers/serial/Makefile
--- clean-27//drivers/serial/Makefile	2008-10-10 00:13:53.000000000 +0200
+++ linux-27//drivers/serial/Makefile	2010-08-04 14:19:31.000000000 +0200
@@ -67,5 +67,6 @@
 obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM) += of_serial.o
 obj-$(CONFIG_SERIAL_KS8695) += serial_ks8695.o
+obj-$(CONFIG_SERIAL_PMC6L) += pmc6l.o
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
 obj-$(CONFIG_SERIAL_QE) += ucc_uart.o
diff -ur clean-27//drivers/serial/pmc6l.c linux-27//drivers/serial/pmc6l.c
--- clean-27//drivers/serial/pmc6l.c	2010-08-04 14:08:35.000000000 +0200
+++ linux-27//drivers/serial/pmc6l.c	2010-08-04 14:08:24.000000000 +0200
@@ -0,0 +1,936 @@
+/*
+
+    Serial driver for PMC-6L.
+
+    Copyright (C) 2008 Michael Buesch <mb@bu3sch.de>
+    Copyright (C) 2010 Pavel Machek <pma@sysgo.com>
+    Copyright (C) 2003 Monta Vista Software, Inc.
+    Copyright (C) 2001 Russell King.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/moduleparam.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/serial_reg.h>
+#include <linux/circ_buf.h>
+#include <linux/interrupt.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial_core.h>
+#include <linux/clk.h>
+
+struct pmc_card {
+	void __iomem *mem;
+	void __iomem *io;
+
+	int	nr_active;	/* FIXME: locking of this one is not correct */
+
+	struct uart_pmc_port	*ports[6];
+};
+
+struct uart_pmc_port {
+	struct uart_port        port;
+	struct pmc_card 	*card;
+
+	int	last_rx;	/* Points to place where *last* character was
+				   in the ringbuffer. So we should expect one
+				   at the *next* position. */
+	u32	last_rx_time;
+	int	active;
+	int	rx_enabled, tx_enabled;
+	int	tx_active;
+
+	struct clk		*clk;
+	char			*name;
+};
+
+static void __iomem *reg_conf(struct uart_pmc_port *up)
+{ return up->card->io + 0x84 + 2*up->port.line; }
+static void __iomem *reg_selection(struct uart_pmc_port *up)
+{ return up->card->io + 0x96 + 2*up->port.line; }
+static void __iomem *reg_irq(struct uart_pmc_port *up)
+{ return up->card->io + 0x26; }
+static void __iomem *reg_uart0(struct uart_pmc_port *up)
+{ return up->card->mem + 0x28000; }
+static void __iomem *reg_uart(struct uart_pmc_port *up)
+{ return reg_uart0(up) + 0x320*up->port.line; }
+static void __iomem *reg_rx(struct uart_pmc_port *up)
+{ return reg_uart(up) + 0x0020; }
+static void __iomem *reg_tx(struct uart_pmc_port *up)
+{ return reg_uart(up) + 0x01a0; }
+
+#define RX_BUF_SIZE 0x100
+#define RX_BUF_CHARS (RX_BUF_SIZE/8)
+#define TX_BUF_SIZE 0x100
+#define TX_BUF_POS 0x2000
+#define RX_BUF_POS 0x2110
+void __iomem *reg_tx_buf(struct uart_pmc_port *up)
+{ return reg_uart(up) + TX_BUF_POS; }
+void __iomem *reg_rx_buf(struct uart_pmc_port *up)
+{ return reg_uart(up) + RX_BUF_POS; }
+
+
+/* Yes, all registers seem to be in big-endian. */
+
+#define iowrite(bits, val, adr) iowrite##bits(cpu_to_be##bits(val), adr)
+#define ioread(bits, adr) be##bits##_to_cpu(ioread##bits(adr))
+
+/* Make sure we don't use wrong macros by mistake. */
+
+#undef ioread16
+#undef ioread32
+#undef iowrite16
+#undef iowrite32
+
+//#define dprintk printk
+#define dprintk(a...)
+
+#define SHARED_IRQ	/* FIXME: why do these trigger? */
+
+static unsigned int port_config; 
+module_param(port_config, int, 0644);
+
+static void pmc_enable_ms(struct uart_port *port)
+{
+	/* We only support 3-wire serial with this driver */
+}
+
+static inline void pmc_needs_lock(struct uart_pmc_port *up, char *msg)
+{
+	unsigned long flags;
+	if (spin_trylock_irqsave(&up->port.lock, flags)) {
+		printk("pmc6l: locking problem (%s)\n", msg);
+		panic("pmc6l: code was not called with port.lock held");
+	}
+}
+
+static void dump_status(struct uart_pmc_port *up)
+{
+	int i;
+	printk("pmc6l status (time is %x, watchdog %x) number %d\n", 
+	       ioread(32, up->card->io+0x30), ioread(16, up->card->io+0x10), up->port.line);
+
+	printk("  port config is %x, selection is %x\n",
+	       ioread(16, reg_conf(up)), ioread(16, reg_selection(up)));
+
+	printk("  uart interrupt enable %x, interrupt ident %x, fifo %x\n",
+	       ioread8(reg_uart(up)+0), ioread8(reg_uart(up)+1), 
+	       ioread8(reg_uart(up)+2));	/* FIXME: wtf? reg_uart(up)+2 is 1 when it breaks? */
+	printk("  line ctrl %x, modem ctrl %x, line status %x, modem status %x\n",
+	       ioread8(reg_uart(up)+3), ioread8(reg_uart(up)+4), 
+	       ioread8(reg_uart(up)+5), ioread8(reg_uart(up)+6));
+	       
+	printk("  divisor hi %x, divisor low %x\n",
+	       ioread8(reg_uart(up)+8), ioread8(reg_uart(up)+9));
+	printk("  rx it %x, data @ %x size %x\n",
+	       ioread(16, reg_rx(up) + 2), ioread(32, reg_rx(up) + 4), ioread(16, reg_rx(up)));
+	printk("  tx status %x, data @ %x size %x, tag %x\n",
+	       ioread(16, reg_tx(up)), ioread(32, reg_tx(up) + 8), ioread(16, reg_tx(up) + 2), ioread(32, reg_tx(up) + 4));
+
+
+	printk("  irq config %x, arinc %x, uart %x, hdlc %x, gpio %x\n",
+	       ioread(16, up->card->io+0x20), 
+	       ioread(16, up->card->io+0x24), ioread(16, up->card->io+0x26),
+	       ioread(16, up->card->io+0x28), ioread(16, up->card->io+0x2a));
+
+	printk("  gpio config l %x h %x in %x out %x\n",
+	       ioread(16, up->card->io+0xb0), ioread(16, up->card->io+0xb2),
+	       ioread(16, up->card->io+0xb4), ioread(16, up->card->io+0xb6));
+
+	printk("  sw status: active %d rx_enabled %d last_rx %d tx_enabled %d tx_active %d\n",
+	       up->active, up->rx_enabled, up->last_rx, up->tx_enabled, up->tx_active);
+
+#if 1
+	printk("  rx: ");
+	for (i=0; i<RX_BUF_CHARS; i++) {
+		printk("char %x '%c' line %x time %x, ",
+		       ioread8(reg_rx_buf(up) + 1 + 8*i),
+		       ioread8(reg_rx_buf(up) + 1 + 8*i),
+		       ioread8(reg_rx_buf(up) + 2 + 8*i),
+		       ioread(32, reg_rx_buf(up) + 4 + 8*i));
+	}
+	printk("\n");
+#endif
+}
+
+static unsigned int __pmc_tx_empty(struct uart_pmc_port *up)
+{
+	pmc_needs_lock(up, "__pmc_tx_empty");
+	return !(ioread(16, reg_tx(up)) & 1);
+}
+
+static unsigned int pmc_tx_empty(struct uart_port *port)
+{
+	struct uart_pmc_port *up = (struct uart_pmc_port *)port;
+	unsigned long flags;
+        unsigned int ret;
+
+        spin_lock_irqsave(&up->port.lock, flags);
+        ret = __pmc_tx_empty(up) * TIOCSER_TEMT;
+	spin_unlock_irqrestore(&up->port.lock, flags);
+        return ret;
+}
+
+static void pmc_stop_tx(struct uart_port *port)
+{
+	int i;
+	struct uart_pmc_port *up = (struct uart_pmc_port *)port;
+
+	pmc_needs_lock(up, "core should take it");
+
+	dprintk("pmc6l: stop tx\n");
+
+	if (!__pmc_tx_empty(up)) {
+		printk("  tx status %x, data @ %x size %x, tag %x\n",
+		       ioread(16, reg_tx(up)), ioread(32, reg_tx(up) + 8), ioread(16, reg_tx(up) + 2), ioread(32, reg_tx(up) + 4));
+		printk("pmc6l: stop tx nonempty\n");
+	}
+	for (i=0; i<100; i++) {
+		if (__pmc_tx_empty(up))
+			break;
+		dprintk("wait");
+		mdelay(1000);
+	}
+	if (!__pmc_tx_empty(up)) {
+		printk("  tx status %x, data @ %x size %x, tag %x\n",
+		       ioread(16, reg_tx(up)), ioread(32, reg_tx(up) + 8), ioread(16, reg_tx(up) + 2), ioread(32, reg_tx(up) + 4));
+		panic("pmc6l: stop tx timeout\n");
+	}
+	
+	up->tx_enabled = 0;
+}
+
+static void pmc_stop_rx(struct uart_port *port)
+{
+	struct uart_pmc_port *up = (struct uart_pmc_port *)port;
+
+	pmc_needs_lock(up, "stop_rx: core should take it");
+	/* How do we stop the receive? */
+
+	dprintk("pmc6l: stop rx\n");
+}
+
+static void pmc_flush_buffer(struct uart_port *port)
+{
+	struct uart_pmc_port *up = (struct uart_pmc_port *)port;
+
+	pmc_needs_lock(up, "core should take it");
+
+	dprintk("pmc6l: flush buffer\n");
+	while (!__pmc_tx_empty(up)) {
+		printk("pmc6l: waiting\n"); /* FIXME? neccessary ? */
+		dump_status(up);
+		mdelay(1000);
+	}
+}
+
+static void card_status(struct pmc_card *card)
+{
+	int i;
+	printk("pmc6l card status\n");
+	for (i=0; i<6; i++) {
+		if (card->ports[i]) {
+			printk("  port %d (== %d), active %d\n",
+			       i, card->ports[i]->port.line, card->ports[i]->active);
+		} else  printk("  port %d NULL\n", i);
+	}
+}
+
+static void transmit_chars(struct uart_pmc_port *up)
+{
+	struct circ_buf *xmit = &up->port.info->xmit;
+	int pos, count;
+
+	pmc_needs_lock(up, "transmit_chars");
+	dprintk("pmc6l: transmit chars\n");
+	up->tx_active = 0;
+
+        if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+                pmc_stop_tx(&up->port);
+                return;
+        }
+
+	BUG_ON(up->active != 1);
+	BUG_ON(up->tx_enabled != 1);
+	BUG_ON(!__pmc_tx_empty(up));
+
+	pos = 0;
+        count = TX_BUF_SIZE;
+        do {
+		iowrite8(xmit->buf[xmit->tail], reg_tx_buf(up) + pos);
+		pos++;
+                xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+                up->port.icount.tx++;
+
+                if (uart_circ_empty(xmit))
+                        break;
+        } while (--count > 0);
+
+	BUG_ON(!pos);
+
+	up->tx_active = 1;
+
+	dprintk("pmc6l: wrote %d bytes to the txbuf\n", pos);
+	if (ioread(16, reg_tx(up)) != 0x6)
+		panic("pmc6l: unexpected Tx Status");
+	if (ioread(32, reg_tx(up) + 8) != reg_tx_buf(up) - reg_uart0(up))
+		panic("pmc6l: unexpected write data ptr");
+	iowrite(32, 0, reg_tx(up) + 4); /* Time tag; hw should fill it */
+	iowrite(16, pos, reg_tx(up) + 2); /* Tx Data Length */
+	iowrite(16, 0x7, reg_tx(up)); /* Tx Status */
+
+	if (__pmc_tx_empty(up)) {
+		printk("pmc6l: UHUH, TRANSMIT WAY TOO FAST?\n");
+		printk("  tx status %x, data @ %x size %x, tag %x\n",
+		       ioread(16, reg_tx(up)), ioread(32, reg_tx(up) + 8), ioread(16, reg_tx(up) + 2), ioread(32, reg_tx(up) + 4));
+		panic("pmc6l: too fast transmit\n");
+	}
+
+	dprintk("  tx done? status %x, data @ %x size %x, tag %x\n",
+	       ioread(16, reg_tx(up)), ioread(32, reg_tx(up) + 8), ioread(16, reg_tx(up) + 2), ioread(32, reg_tx(up) + 4));
+
+        if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+                uart_write_wakeup(&up->port);
+}
+
+static void pmc_start_tx(struct uart_port *port)
+{
+	struct uart_pmc_port *up = (struct uart_pmc_port *)port;
+
+	dprintk("pmc6l: start tx\n");
+	pmc_needs_lock(up, "core should take it");
+
+	up->tx_enabled = 1;
+	if (!up->tx_active) {
+		up->tx_active = 1;
+		transmit_chars(up);
+	}
+}
+
+static unsigned int pmc_get_mctrl(struct uart_port *port)
+{
+	/* We only support 3-wire serial with this driver */
+	return 0;
+}
+
+static void pmc_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* We only support 3-wire serial with this driver */
+}
+
+static void pmc_break_ctl(struct uart_port *port, int break_state)
+{
+	struct uart_pmc_port *up = (struct uart_pmc_port *)port;
+	unsigned long flags;
+
+	printk("pmc6l: break ctl\n");
+	spin_lock_irqsave(&up->port.lock, flags);
+	/* FIXME: implement break? */
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static int check_rx(struct uart_pmc_port *up)
+{
+	struct tty_struct *tty = up->port.info->port.tty;
+	int num = 0;
+	void *last_pos = reg_rx_buf(up) + 8*up->last_rx;
+
+	pmc_needs_lock(up, "check_rx");
+	dprintk("pmc6l: check rx\n");
+
+	while (1) {
+		unsigned int c, flag;
+		void *pos;
+		int rx;
+		u32 time;
+
+		rx = up->last_rx + 1;
+		if (rx == RX_BUF_CHARS)
+			rx = 0;
+		pos = reg_rx_buf(up) + 8*rx;
+
+		if ((ioread(32, last_pos + 0)) ||
+		    (ioread(32, last_pos + 4))) {
+			// dump_status(up);
+			panic("pmc6l: receive ringbuffer overrun\n");
+		}
+
+		if (!(ioread(32, pos + 0) ||
+		      ioread(32, pos + 4)))
+			break;
+
+		dprintk("pmc6l: character received\n");
+		up->last_rx = rx;
+
+		time = ioread(32, pos+4);
+		if (time <= up->last_rx_time)
+			printk("pmc6l: characters in wrong order (%x, %x)\n",
+			       time, up->last_rx_time);
+		up->last_rx_time = time;
+
+		c = ioread8(pos + 1);
+
+		flag = TTY_NORMAL;
+		up->port.icount.rx++;
+		num++;
+
+		uart_insert_char(&up->port, 0, UART_LSR_OE, c, flag);
+
+		iowrite(32, 0, pos + 0);
+		iowrite(32, 0, pos + 4);
+
+		dprintk("pmc6l: CHAR %d '%c'\n", c, c);
+	}
+	if (num > RX_BUF_CHARS/2)
+		printk("pmc6l: received %d characters\n", num);
+
+	tty_flip_buffer_push(tty);
+	return num;
+}
+
+static void __pmc_irq(struct uart_pmc_port *up, int in_irq)
+{
+	int irq_id, my_rx, my_tx, todo;
+
+	pmc_needs_lock(up, "__pmc_irq");
+	dprintk("pmc6l: irq");
+
+	my_rx = 1 << up->port.line*2;
+	my_tx = my_rx << 1;
+
+	irq_id = ioread(16, reg_irq(up));
+	todo = irq_id & (my_rx | my_tx);
+	iowrite(16, 0xffff & ~todo, reg_irq(up));
+
+#ifndef SHARED_IRQ
+	if (in_irq && !todo) {
+		if (up->card->nr_active == 1) {
+			printk("pmc6l: interrupt for other uart? -- %x, me %x\n", 
+			       irq_id, my_rx | my_tx); 
+			card_status(up->card);
+		}
+	}
+#endif
+
+	dprintk(" id %x (%x)\n", todo, ioread(16, reg_irq(up)));
+
+	if (todo & my_rx){
+		int num = 0;
+
+		BUG_ON(!up->rx_enabled);
+		num = check_rx(up);
+		if (!num) {
+			dprintk("pmc6l: receive irq but got nothing\n");
+		}
+	}
+	wake_up_interruptible(&up->port.info->delta_msr_wait);
+	if (todo & my_tx)  {
+		BUG_ON(!__pmc_tx_empty(up));
+		BUG_ON(!up->tx_enabled);
+		transmit_chars(up);
+	}
+}
+
+/*
+ * This handles the interrupt from one port.
+ */
+static inline irqreturn_t pmc_irq(int irq, void *dev_id)
+{
+	struct uart_pmc_port *up = dev_id;
+	int irq_id;
+	unsigned long flags;
+
+	dprintk("pmc_irq\n");
+	spin_lock_irqsave(&up->port.lock, flags);
+	irq_id = ioread(16, reg_irq(up));
+#ifndef SHARED_IRQ
+	if (!irq_id) {
+		if (up->card->nr_active == 1)
+			printk("pmc6l: nothing to do in irq -- shared irq?!\n");
+	}
+#endif
+
+	__pmc_irq(up, 1);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static void __pmc_startup(struct uart_pmc_port *up)
+{
+	unsigned int mode;
+
+	dprintk("__pmc_startup\n");
+	pmc_needs_lock(up, "__pmc_startup");
+
+	iowrite(16, 0x00, reg_conf(up));
+	iowrite(16, ((up->port.line+1) << 4) + (up->port.line+1), reg_selection(up));
+
+	dprintk("pmc6l: Setting up ring buffers\n");
+	iowrite(16, 0x001, reg_rx(up) + 2); /* Rx It Param */
+	iowrite(32, reg_rx_buf(up) - reg_uart0(up), reg_rx(up) + 4); /* Rx Data Pointer */
+	iowrite(16, RX_BUF_SIZE, reg_rx(up)); /* Rx Buffer Size */
+
+	BUG_ON(!__pmc_tx_empty(up));
+
+	iowrite(16, 0x6, reg_tx(up)); /* Tx Status */
+	iowrite(16, 0, reg_tx(up) + 2); /* Tx Data Length */
+	iowrite(32, 0, reg_tx(up) + 4); /* Time tag; hw should fill it */
+	iowrite(32, reg_tx_buf(up) - reg_uart0(up), reg_tx(up) + 8); /* Tx Data Pointer */
+
+	dprintk("pmc6l: Powering up transmitters: ");
+	/* EIA-232/423/485 setup goes here */
+
+	mode = ((port_config >> (2*up->port.line)) & 3) << 1;
+	switch (mode) {
+	case 0: dprintk("EIA-232 mode\n"); break;
+	case 2: dprintk("EIA-423 mode\n"); break;
+	case 4: dprintk("EIA-485 mode\n"); break;
+	case 6: dprintk("??? mode\n"); break;
+	}
+	iowrite(16, 0x61 | mode, reg_conf(up));
+	iowrite(16, ((up->port.line+1) << 4) + (up->port.line+1), reg_selection(up));
+
+	/* Wait for voltages to ramp up. 
+	   The delay here is actually neccessary. It works with 10msec wait,
+	   and breaks with no delay; seems to work with 100usec. */
+	udelay(500);
+
+}
+
+static int pmc_startup(struct uart_port *port)
+{
+	struct uart_pmc_port *up = (struct uart_pmc_port *)port;
+	unsigned long flags;
+	int retval;
+	int i;
+
+	dprintk("pmc6l: startup\n");
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	up->active = 2;
+	iowrite8(0, reg_uart(up) + 8);	/* Divisor high */
+	iowrite8(11, reg_uart(up) + 9);  /* Divisor low */
+
+	iowrite8(0x00, reg_uart(up) + 0); /* Interrupt enable */
+	iowrite8(0x00, reg_uart(up) + 1);
+	iowrite8(0x00, reg_uart(up) + 2);
+	iowrite8(0x03, reg_uart(up) + 3); /* Line control: select 8-bit words */
+	iowrite8(0x00, reg_uart(up) + 4);
+	iowrite8(0x00, reg_uart(up) + 5);
+	iowrite8(0x00, reg_uart(up) + 6);
+	iowrite8(0x00, reg_uart(up) + 7);
+	iowrite8(0x00, reg_uart(up) + 0x0a);
+
+	__pmc_startup(up);
+
+	up->tx_enabled = 1;	/* FIXME: should not be neccessary? */
+	up->rx_enabled = 1;
+	up->last_rx = RX_BUF_CHARS-1;
+
+	for (i=0; i<TX_BUF_SIZE; i+=8) {
+		iowrite(32, 0xdeadbeef, reg_tx_buf(up)+i);
+		iowrite(32, 0x11ebabe, reg_tx_buf(up)+i+4);
+	}
+
+	for (i=0; i<RX_BUF_SIZE; i+=8) {
+		iowrite(32, 0, reg_rx_buf(up)+i);
+		iowrite(32, 0, reg_rx_buf(up)+i+4);
+	}
+
+	dprintk("pmc6l: Ring buffers ok\n");
+
+	/*
+	 * Allocate the IRQ
+	 */
+	retval = request_irq(up->port.irq, pmc_irq, IRQF_SHARED, up->name, up);
+	if (retval) {
+		printk("pmc6l: interrupt registration failed\n");
+		return retval;
+	}
+	dprintk("pmc6l: interrupt ok\n");
+
+	up->active = 1;
+	up->card->nr_active++;
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	return 0;
+}
+
+static void pmc_shutdown(struct uart_port *port)
+{
+	struct uart_pmc_port *up = (struct uart_pmc_port *)port;
+	unsigned long flags;
+
+	dprintk("pmc6l: shutdown\n");
+
+	while (1) {
+		spin_lock_irqsave(&up->port.lock, flags);
+		if (!up->tx_active) {
+			break;
+		}
+		spin_unlock_irqrestore(&up->port.lock, flags);
+		printk("pmc6l: waiting for tx to finish\n");
+		mdelay(1000);
+	}
+
+	pmc_stop_tx(port);	/* FIXME: Should we do this here?! */
+	pmc_stop_rx(port);
+
+	if (!up->active) {
+		panic("pmc6l: shutdown of inactive port?\n");
+	}
+	up->active = 3;
+
+	while (!__pmc_tx_empty(up)) {
+		printk("pmc6l: waiting for port to shutdown\n");
+	}
+
+	/* No transmit interrupts */
+	iowrite(16, 0x2, reg_tx(up));
+	/* No receive interrupts */
+	iowrite(16, 0x0, reg_rx(up) + 2); /* Rx It Param */
+	dprintk("pmc6l: port shutdown -- picking up any interrupts\n");
+	__pmc_irq(up, 0);
+	up->rx_enabled = 0;		/* FIXME? */
+
+	iowrite(16, 0x00, reg_conf(up));	/* Turn off interrupt from this channel */
+	up->active = 0;
+	up->card->nr_active--;
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	free_irq(up->port.irq, up);
+	dprintk("pmc6l: port shutdown done\n");
+}
+
+static void
+pmc_set_termios(struct uart_port *port, struct ktermios *termios,
+		       struct ktermios *old)
+{
+	struct uart_pmc_port *up = (struct uart_pmc_port *)port;
+        unsigned char cval, fcr = 0;
+        unsigned long flags;
+        unsigned int baud, quot;
+
+	dprintk("pmc6l: set termios\n");
+
+        switch (termios->c_cflag & CSIZE) {
+        case CS5:
+		cval = UART_LCR_WLEN5;
+		break;
+        case CS6:
+		cval = UART_LCR_WLEN6;
+		break;
+        case CS7:
+		cval = UART_LCR_WLEN7;
+		break;
+        default:
+        case CS8:
+		cval = UART_LCR_WLEN8;
+		break;
+        }
+
+        if (termios->c_cflag & CSTOPB)
+                cval |= UART_LCR_STOP;
+        if (termios->c_cflag & PARENB)
+                cval |= UART_LCR_PARITY;
+        if (!(termios->c_cflag & PARODD))
+                cval |= UART_LCR_EPAR;
+#ifdef CMSPAR
+        if (termios->c_cflag & CMSPAR)
+                cval |= UART_LCR_SPAR;
+#endif
+
+        /*
+         * Ask the core to calculate the divisor for us.
+         */
+        baud = uart_get_baud_rate(port, termios, old, 50, 115200);
+        quot = uart_get_divisor(port, baud);
+
+	fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
+
+	while (!pmc_tx_empty(port)) {
+		printk("pmc6l: changing parameters while transmitting?! -- WAIT\n");
+		mdelay(1000);
+	}
+
+        /*
+         * Ok, we're now changing the port state.  Do it with
+         * interrupts disabled.
+         */
+        spin_lock_irqsave(&up->port.lock, flags);
+
+	BUG_ON(!__pmc_tx_empty(up));
+
+	/* FIXME: but we may be receiving, too... */
+
+        /*
+         * Update the per-port timeout.
+         */
+        uart_update_timeout(port, termios->c_cflag, baud);
+
+	iowrite8(0, reg_uart(up)); /* Interrupt enable register */
+
+	dprintk("pmc6l: quot should be %x for baud rate %d\n", quot, baud);
+
+        iowrite8(quot & 0xff, reg_uart(up) + 9);
+        iowrite8((quot >> 8) & 0xff, reg_uart(up) + 8);
+
+	iowrite8(cval, reg_uart(up) + 3);	/* Line control register */
+	/* FIXME: wtf? we are enabling FIFO? */
+	iowrite8(fcr, reg_uart(up) + 2);	/* FIFO control register */
+
+	__pmc_startup(up);	/* FIXME: neccessary? */
+
+	pmc_set_mctrl(&up->port, up->port.mctrl);
+
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static void
+pmc_pm(struct uart_port *port, unsigned int state,
+	      unsigned int oldstate)
+{
+	/* FIXME: should we include some kind of power management? */
+	dprintk("pmc6l: pm %d\n", state);
+}
+
+static void pmc_release_port(struct uart_port *port)
+{
+	dprintk("pmc6l: release port\n");
+}
+
+static int pmc_request_port(struct uart_port *port)
+{
+	dprintk("pmc6l: request port\n");
+	return 0;
+}
+
+static void pmc_config_port(struct uart_port *port, int flags)
+{
+	struct uart_pmc_port *up = (struct uart_pmc_port *)port;
+
+	dprintk("pmc6l: config port\n");
+	up->port.type = PORT_PXA;
+}
+
+static int
+pmc_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	dprintk("pmc6l: verify port\n");
+	/* we don't want the core code to modify any port params */
+	return -EINVAL;
+}
+
+static const char *
+pmc_type(struct uart_port *port)
+{
+	struct uart_pmc_port *up = (struct uart_pmc_port *)port;
+	dprintk("pmc6l: type\n");
+	return up->name;
+}
+
+static struct uart_driver pmc_reg;
+struct uart_ops pmc_pops = {
+	.tx_empty	= pmc_tx_empty,
+	.set_mctrl	= pmc_set_mctrl,
+	.get_mctrl	= pmc_get_mctrl,
+	.stop_tx	= pmc_stop_tx,
+	.start_tx	= pmc_start_tx,
+	.stop_rx	= pmc_stop_rx,
+	.enable_ms	= pmc_enable_ms,
+	.break_ctl	= pmc_break_ctl,
+	.startup	= pmc_startup,
+	.shutdown	= pmc_shutdown,
+	.set_termios	= pmc_set_termios,
+	.pm		= pmc_pm,
+	.type		= pmc_type,
+	.release_port	= pmc_release_port,
+	.request_port	= pmc_request_port,
+	.config_port	= pmc_config_port,
+	.verify_port	= pmc_verify_port,
+	.flush_buffer	= pmc_flush_buffer,
+};
+
+static struct uart_driver pmc_reg = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "PMCserial",
+	.dev_name	= "ttyPMC",
+	.major		= TTY_MAJOR,
+	.minor		= 70,	/* FIXME: not quite traditional */
+	.nr		= 6,
+};
+
+static int pmc_init_port(struct uart_pmc_port *sport)
+{
+	sport->port.type = 0;
+	sport->port.iotype = UPIO_MEM;
+	sport->port.mapbase = (long) reg_uart(sport);
+	sport->port.fifosize = 1; /* FIXME min(TX_BUF_SIZE, RX_BUF_CHARS); */
+	sport->port.ops = &pmc_pops;
+	sport->port.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
+	sport->port.uartclk = 20000000;
+	sport->name = "PMC-6L";
+	return 0;
+}
+
+static int pmc6l_probe(struct pci_dev *dev,
+			const struct pci_device_id *pci_id)
+{
+	struct uart_pmc_port *sport;
+	struct pmc_card *card;
+	int err;
+	int i;
+
+	/* FIXME: check error paths. */
+
+	card = kzalloc(sizeof(struct pmc_card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	err = pci_enable_device(dev);
+	if (err) {
+		printk(KERN_ERR "pmc6l: Can't enable device.\n");
+		goto err_freebg;
+	}
+
+	pci_set_master(dev);
+
+	card->mem = pci_iomap(dev, 0, 0);
+	card->io = pci_iomap(dev, 1, 0);
+
+	for (i=0; i<0x7ffff; i++) {
+		iowrite8(0, card->mem+i);
+		if (ioread8(card->mem+i) != 0x0)
+			printk("pml6l: strange memory at %x (not 0)", i);
+	}
+
+	/* Reset the card */
+	iowrite(16, 0xffff, card->io+4);
+
+	/* Verify that release is read-only */
+	iowrite(16, 0, card->io);
+	printk("pmc6l: reset, time is %x, FPGA release is %x\n", 
+	       ioread(32, card->io+0x30), ioread(16, card->io+0));
+	printk("pmc6l: mapped memory at %lx, io at %lx\n",
+	       (long) card->mem, (long) card->io);
+
+	/* Enable interrupts */
+	iowrite(16, 0x01, card->io+0x20); /* Interrupt configuration reg */
+
+	pci_set_drvdata(dev, card);
+
+	for (i=0; i<6; i++) {
+		dprintk("pmc6l: allocating port ttyPMC%d\n", i);
+
+		sport = kzalloc(sizeof(struct uart_pmc_port), GFP_KERNEL);
+		if (!sport)
+			return -ENOMEM;
+		sport->card = card;
+		sport->port.dev = &dev->dev;
+		sport->port.line = i;
+		sport->port.irq = dev->irq;
+
+		pmc_init_port(sport);
+
+		sport->port.membase = card->mem;
+		if (!sport->port.membase) {
+			err = -ENOMEM;
+			goto err_disable;
+		}
+
+		err = uart_add_one_port(&pmc_reg, &sport->port);
+		if (err) {
+			printk("pmc6l: Could not add port, got %d\n", err);
+			goto err_disable;
+		}
+		card->ports[i] = sport;
+	}
+
+	return 0;
+
+err_disable:
+	pci_disable_device(dev);
+err_freebg:
+	kfree(card);
+	return err;
+}
+
+static void pmc6l_remove(struct pci_dev *pdev)
+{
+	int i;
+	struct pmc_card *card = pci_get_drvdata(pdev);
+
+	dprintk("pmc6l: remove\n");
+	for (i=0; i<6; i++) {
+		if (card->ports[i])
+			uart_remove_one_port(&pmc_reg, &card->ports[i]->port);
+		card->ports[i] = NULL;
+		kfree(card->ports[i]);
+	}
+	iounmap(card->mem);
+	iounmap(card->io);
+	pci_disable_device(pdev);
+
+	pci_set_drvdata(pdev, NULL);
+	kfree(card);
+}
+
+static struct pci_device_id pmc6l_pci_tbl[] = {
+	{ PCI_DEVICE(0x1269, 0x0200) },
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, pmc6l_pci_tbl);
+
+static struct pci_driver pmc6l_pci_driver = {
+	.name		= "pmc6l",
+	.id_table	= pmc6l_pci_tbl,
+	.probe		= pmc6l_probe,
+	.remove		= pmc6l_remove,
+};
+
+static int pmc6l_init(void)
+{
+	int err;
+
+	dprintk("pmc6l: init\n");
+	err = uart_register_driver(&pmc_reg);
+	if (err) {
+		printk("pmc6l: uart_register returned %d\n", err);
+		return err;
+	}
+
+	/* FIXME: leaks serial structure */
+	return pci_register_driver(&pmc6l_pci_driver);
+}
+module_init(pmc6l_init)
+
+static void pmc6l_exit(void)
+{
+	pci_unregister_driver(&pmc6l_pci_driver);
+	uart_unregister_driver(&pmc_reg);
+}
+module_exit(pmc6l_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pavel Machek");
+MODULE_DESCRIPTION("Driver for pmc6l serial card.");
