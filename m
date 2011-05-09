From: Vijayaraghavan <vijayas@cisco.com>
Subject: Add Cisco PowerTV serial support to 8250/PC16550D serial
	implementation
Date: Mon, 9 May 2011 08:46:40 -0400
Message-ID: <20110509124640.GA14734@vijayas-lnx01.corp.sa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ams-iport-2.cisco.com ([144.254.224.141]:37460 "EHLO
	ams-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab1EIMqp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2011 08:46:45 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@suse.de, alan@linux.intel.com, dvomlehn@cisco.com, vijayas@cisco.com

Add Cisco PowerTV serial support to 8250/PC16550 serial driver implementation

The Cisco PowerTV UART is a non-standard implementation of the PC16550D standard.
The sequence of events for Cisco UART is pretty standard, while the following are non standard
registers spacing and locations, register bits and masks.

An additional level of indirection was introduced, for mapping of register offsets

Signed-off-by: Sudharsan Vijayaraghavan <vijayas@cisco.com>
---
 arch/mips/include/asm/mach-powertv/asic.h      |    3 +
 arch/mips/include/asm/mach-powertv/asic_regs.h |    9 +
 arch/mips/include/asm/mach-powertv/serial.h    |   45 +++++
 arch/mips/include/asm/serial.h                 |    3 +
 arch/mips/powertv/Makefile                     |    1 +
 arch/mips/powertv/early_printk.c               |  143 ++++++++++++++
 arch/mips/powertv/init.c                       |    4 +
 drivers/tty/serial/8250.c                      |  247 +++++++++++++++++++++---
 drivers/tty/serial/8250.h                      |   13 ++
 drivers/tty/serial/Kconfig                     |    6 +
 include/linux/serial_core.h                    |    3 +-
 include/linux/serial_reg.h                     |   96 +++++++++
 12 files changed, 545 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/mach-powertv/asic.h b/arch/mips/include/asm/mach-powertv/asic.h
index c7077a6..6482356 100644
--- a/arch/mips/include/asm/mach-powertv/asic.h
+++ b/arch/mips/include/asm/mach-powertv/asic.h
@@ -73,6 +73,9 @@ extern int platform_supports_pcie(void);
 extern int platform_supports_display(void);
 extern void configure_platform(void);
 
+#ifdef CONFIG_EARLY_PRINTK
+	extern void prom_init_early_printk(void);
+#endif
 /* Platform Resources */
 #define ASIC_RESOURCE_GET_EXISTS 1
 extern struct resource *asic_resource_get(const char *name);
diff --git a/arch/mips/include/asm/mach-powertv/asic_regs.h b/arch/mips/include/asm/mach-powertv/asic_regs.h
index deecb26..b345cd8 100644
--- a/arch/mips/include/asm/mach-powertv/asic_regs.h
+++ b/arch/mips/include/asm/mach-powertv/asic_regs.h
@@ -113,6 +113,15 @@ extern unsigned long asic_phy_base;
 #define asic_reg_phys_addr(x)	(virt_to_phys((void *) CAC_ADDR(	\
 					(unsigned long) asic_reg_addr(x))))
 
+/**
+ * asic_serial_membase - obtain serial uart base address
+ *
+ * Returns the serial uart base address
+ */
+static inline unsigned char *asic_serial_membase(void)
+{
+	return (unsigned char *)asic_reg_addr(uart1_intstat);
+}
 /*
  * The asic_reg macro is gone. It should be replaced by either asic_read or
  * asic_write, as appropriate.
diff --git a/arch/mips/include/asm/mach-powertv/serial.h b/arch/mips/include/asm/mach-powertv/serial.h
new file mode 100644
index 0000000..a83377f
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/serial.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2010 Cisco Sysems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Sudharsan Vijayaraghavan <vijayas@cisco.com>
+ *
+ * Description:  Defines the default UART configs for the Cisco settop.
+ */
+
+#ifndef _ASM_MACH_POWERTV_SERIAL_H_
+#define _ASM_MACH_POWERTV_SERIAL_H_
+#ifdef CONFIG_SERIAL_8250_IRBLASTER
+#include <asm/mach-powertv/asic_regs.h>
+#include <asm/mach-powertv/interrupts.h>
+#define IRBLASTER_UART_CLK_FREQ (13500000 / 16)
+#define IRBLASTER_STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | \
+				 UPF_BUGGY_UART | UPF_NO_TXEN_TEST | \
+				 UPF_MAGIC_MULTIPLIER)
+
+#define STD_UART_PORT(num) { \
+			.baud_base = IRBLASTER_UART_CLK_FREQ, \
+			.port = num, \
+			.irq = irq_uart1, \
+			.flags = IRBLASTER_STD_COM_FLAGS, \
+			.io_type = UPIO_MEM32, \
+			.serial_membase = asic_serial_membase, \
+			.type = PORT_IRBLASTER, \
+			}
+
+#define SERIAL_PORT_DFNS STD_UART_PORT(0)
+#endif /* CONFIG_SERIAL_8250_IRBLASTER */
+#endif /* _ASM_MACH_POWERTV_SERIAL_H_ */
diff --git a/arch/mips/include/asm/serial.h b/arch/mips/include/asm/serial.h
index a0cb0ca..bb7f397 100644
--- a/arch/mips/include/asm/serial.h
+++ b/arch/mips/include/asm/serial.h
@@ -1 +1,4 @@
 #include <asm-generic/serial.h>
+#ifdef CONFIG_SERIAL_8250_IRBLASTER
+#include <asm/mach-powertv/serial.h>
+#endif /* CONFIG_SERIAL_8250_IRBLASTER */
diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
index 348d2e8..fd17e90 100644
--- a/arch/mips/powertv/Makefile
+++ b/arch/mips/powertv/Makefile
@@ -27,5 +27,6 @@ obj-y += init.o ioremap.o memory.o powertv_setup.o reset.o time.o \
 	asic/ pci/
 
 obj-$(CONFIG_USB) += powertv-usb.o
+obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
 ccflags-y := -Wall
diff --git a/arch/mips/powertv/early_printk.c b/arch/mips/powertv/early_printk.c
new file mode 100644
index 0000000..d2900b7
--- /dev/null
+++ b/arch/mips/powertv/early_printk.c
@@ -0,0 +1,143 @@
+/*
+ * Copyright (C) 2010 Cisco Sysems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Sudharsan Vijayaraghavan <vijayas@cisco.com>
+ *
+ * Description:  Early printk implementation for the Cisco settop.
+ */
+
+#include <asm/mach-powertv/asic_regs.h>
+/**
+ * serial_in - read UART settings/data
+ * @membase:    Pointer to base address of UART registry
+ * @offset:     Register offset of interest
+ *
+ * Returns the value from the specified UART register
+ */
+static inline unsigned int serial_in(unsigned char *membase, int offset)
+{
+	return readl(membase + offset);
+}
+
+/**
+ * serial_out - write/program UART
+ * @membase:    Pointer to base address of UART registry
+ * @offset:     Register offset of interest
+ * @value:      Data to be programmed
+ */
+static inline void serial_out(unsigned char *membase, int offset, int value)
+{
+	writel(value, membase + offset);
+}
+
+/* defines for UART initialization */
+#define UART_DLL 0x14
+#define UART_DLM 0x10
+#define UART_LCR 0x08
+#define UART_FCR 0x0c
+
+#define UART_FCR_RCVR_EN 0x02
+#define UART_FCR_XMIT_EN 0x01
+
+/**
+ * prom_init_early_printk - initialize the UART
+ */
+void  prom_init_early_printk(void)
+{
+	unsigned char *membase;
+	unsigned int baud, quot;
+	unsigned int clk_freq, lcr, fcr;
+
+	membase  = (unsigned char *) asic_reg_addr(uart1_intstat);
+	clk_freq = 13500000;
+	baud     = 9600;
+	quot     = clk_freq / (9 * baud);
+	lcr      = 0x3;				/* Wordlength: 8 bits */
+	fcr      = UART_FCR_RCVR_EN | UART_FCR_XMIT_EN;
+
+	serial_out(membase, UART_DLL, quot & 0xff);
+	serial_out(membase, UART_DLM, quot >> 8 & 0xff);
+	serial_out(membase, UART_LCR, lcr);
+	serial_out(membase, UART_FCR, fcr);
+}
+
+/* defines for TX data transmission and timeout  */
+#define UART_TX  0x18
+#define UART_LSR 0x1c
+#define UART_LSR_TEMT 0x40
+
+/**
+ * prom_putchar - dumps given character to serial console
+ * @c:      Character to be dumped on serial console
+ */
+void prom_putchar(char c)
+{
+	int timeout;
+	unsigned char *mem_base;
+
+	mem_base = (unsigned char *) asic_reg_addr(uart1_intstat);
+	timeout = 10000;
+
+	while (((serial_in(mem_base, UART_LSR) & UART_LSR_TEMT) == 0) &&
+		(timeout-- > 0))
+		;
+	if (timeout)
+		serial_out(mem_base, UART_TX, c);
+}
+
+/**
+ * early_vprintk - early print implementation to dump data to console
+ * @fmt:        Pointer to format specifiers
+ * @ap:         Var list pointing to data
+ *
+ * Returns the number of characters dumped to console
+ */
+static int early_vprintk(const char *fmt, va_list ap)
+{
+	char buf[512];
+	const char *p;
+	int     n;
+
+	vscnprintf(buf, sizeof(buf), fmt, ap);
+
+	n = 0;
+
+	for (p = buf; *p != '\0'; p++) {
+		if (*p == '\n') {
+			prom_putchar('\r');
+			n++;
+		}
+		prom_putchar(*p);
+		n++;
+	}
+
+	return n;
+}
+
+/**
+ * early_printk - early printk implementation to dump data to console
+ * @fmt:        Pointer to format specifiers
+ * @.:		Arguments one per format item
+ */
+void early_printk(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	early_vprintk(fmt, ap);
+	va_end(ap);
+}
diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
index 8355228..81884a4 100644
--- a/arch/mips/powertv/init.c
+++ b/arch/mips/powertv/init.c
@@ -125,6 +125,10 @@ void __init prom_init(void)
 	configure_platform();
 	prom_meminit();
 
+#ifdef CONFIG_EARLY_PRINTK
+	prom_init_early_printk();
+#endif
+
 #ifndef CONFIG_BOOTLOADER_DRIVER
 	pr_info("\nBootloader driver isn't loaded...\n");
 #endif
diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index b3b881b..c0a332a 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -85,7 +85,7 @@ static unsigned int skip_txen_test; /* force skip of txen test at init time */
 
 #define PASS_LIMIT	256
 
-#define BOTH_EMPTY 	(UART_LSR_TEMT | UART_LSR_THRE)
+#define BOTH_EMPTY(up)	both_empty(up)
 
 
 /*
@@ -303,6 +303,13 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	[PORT_IRBLASTER] = {
+		.name		= "IRBLASTER",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_ACR_ASREN,
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 #if defined(CONFIG_MIPS_ALCHEMY)
@@ -379,6 +386,57 @@ static inline int map_8250_out_reg(struct uart_port *p, int offset)
 	return regmap_out[offset];
 }
 
+#elif defined(CONFIG_SERIAL_8250_IRBLASTER)
+/**
+ * regmap_in - input register mapper, specific for Cisco PowerTV UARTS
+ */
+static const u8
+	regmap_in[8] = {
+		[UART_RX]	= 0x18,
+		[UART_IER]	= 0x04,
+		[UART_IIR]	= 0x00,
+		[UART_LCR]	= 0x08,
+		[UART_FCR]	= 0x0c,
+		[UART_LSR]	= 0x1c,
+	},
+/**
+ * regmap_out - output register mapper, specific for Cisco PowerTV UARTS
+ */
+	regmap_out[8] = {
+		[UART_TX]	= 0x18,
+		[UART_IER]	= 0x04,
+		[UART_IIR]	= 0x00,
+		[UART_LCR]	= 0x08,
+		[UART_FCR]	= 0x0c,
+		[UART_DLM]	= 0x10,
+		[UART_DLL]	= 0x14,
+	};
+
+/**
+ * map_8250_in_reg - input register offset mapping function
+ * @p:          Pointer to &struct uart_port corresponding to serial port in use
+ * @offset:     Register offset of interest
+ *
+ * Returns the actual mapped register offset
+ */
+static inline int map_8250_in_reg(struct uart_port *p, int offset)
+{
+	if (p->type != PORT_IRBLASTER)
+		return offset;
+	return regmap_in[offset];
+}
+
+/**
+ * map_8250_out_reg - output register offset mapping function
+ * @p:          Pointer to &struct uart_port corresponding to serial port in use
+ * @offset:     Register offset of interest
+ */
+static inline int map_8250_out_reg(struct uart_port *p, int offset)
+{
+	if (p->type != PORT_IRBLASTER)
+		return offset;
+	return regmap_out[offset];
+}
 #else
 
 /* sane hardware needs no mapping */
@@ -637,6 +695,19 @@ static void serial_dl_write(struct uart_8250_port *up, int value)
 #define serial_dl_write(up, value) _serial_dl_write(up, value)
 #endif
 
+/**
+ * both_empty - input register offset mapping function
+ * @up:		Pointer to &struct uart_port corresponding to serial
+ *		port in use
+ *
+ * Returns transmit fifo empty status indicators
+ */
+static int both_empty(struct uart_8250_port *up)
+{
+	if (up->bugs & UART_BUG_STC)
+		return UART_LSR_TEMT;
+	return UART_LSR_TEMT | UART_LSR_THRE;
+}
 /*
  * For the 16C950
  */
@@ -1123,6 +1194,27 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	}
 }
 
+/**
+ * early_autoconfig - detect UART bugs based on simple IER test
+ * @up:		Pointer to &struct uart_8250_port corresponding
+ *		to serial port in use
+ */
+static void early_autoconfig(struct uart_8250_port *up)
+{
+	unsigned char scratch, scratch2;
+	unsigned char save_lcr;
+
+	save_lcr = serial_in(up, UART_LCR);
+	scratch = serial_in(up, UART_IER);
+	serial_outp(up, UART_LCR, 0x0);
+	serial_outp(up, UART_IER, 0xff);
+	udelay(1);
+	scratch2 = serial_inp(up, UART_IER);
+	serial_outp(up, UART_LCR, save_lcr);
+	serial_outp(up, UART_IER, scratch);
+	if (!scratch2)
+		up->bugs = UART_BUG_STC;
+}
 /*
  * This routine is called by rs_init() to initialize a specific serial
  * port.  It determines what type of UART chip this serial port is
@@ -1151,6 +1243,29 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	up->capabilities = 0;
 	up->bugs = 0;
 
+	/**
+	 * Do a simple IER test first using standard/default register spacing,
+	 * if this returns non-zero take the normal path, otherwise we found
+	 * Cisco PowerTV UART
+	 *
+	 * Note: This test is relying on non-standard register spacing of Cisco
+	 * PowerTV UARTS
+	 */
+	save_lcr = serial_in(up, UART_LCR);
+	scratch = serial_in(up, UART_IER);
+	serial_outp(up, UART_LCR, 0x0);
+	serial_outp(up, UART_IER, 0xff);
+	udelay(1);
+	scratch2 = serial_inp(up, UART_IER);
+	serial_outp(up, UART_LCR, save_lcr);
+	serial_outp(up, UART_IER, scratch);
+	if (!scratch2) {
+		up->bugs = UART_BUG_NOMSR | UART_BUG_RRTI | UART_BUG_SIC |
+				UART_BUG_SBC | UART_BUG_PAR | UART_BUG_OE |
+				UART_BUG_STC;
+		up->port.type = PORT_IRBLASTER;
+		goto out;
+	}
 	if (!(up->port.flags & UPF_BUGGY_UART)) {
 		/*
 		 * Do a simple existence test first; if we fail this,
@@ -1436,6 +1551,12 @@ receive_chars(struct uart_8250_port *up, unsigned int *status)
 	char flag;
 
 	do {
+		if (up->bugs & UART_BUG_OE) {
+			unsigned char int_status;
+			int_status = serial_inp(up, UART_IIR);
+			if (int_status & UART_ACR_DSRFC)
+				lsr |= UART_LSR_OE;
+		}
 		if (likely(lsr & UART_LSR_DR))
 			ch = serial_inp(up, UART_RX);
 		else
@@ -1501,6 +1622,14 @@ ignore_char:
 	tty_flip_buffer_push(tty);
 	spin_lock(&up->port.lock);
 	*status = lsr;
+	/* reset RX int status */
+	if (up->bugs & UART_BUG_RRTI) {
+		unsigned char int_status;
+		int_status = serial_inp(up, UART_IIR);
+		int_status &= UART_IER_RLSI;
+		if (int_status)
+			serial_outp(up, UART_IIR, int_status);
+	}
 }
 
 static void transmit_chars(struct uart_8250_port *up)
@@ -1539,6 +1668,14 @@ static void transmit_chars(struct uart_8250_port *up)
 
 	if (uart_circ_empty(xmit))
 		__stop_tx(up);
+	/* reset TX int status */
+	if (up->bugs & UART_BUG_RRTI) {
+		unsigned char int_status;
+		int_status = serial_inp(up, UART_IIR);
+		int_status &= UART_IER_THRI;
+		if (int_status)
+			serial_outp(up, UART_IIR, int_status);
+	}
 }
 
 static unsigned int check_modem_status(struct uart_8250_port *up)
@@ -1569,7 +1706,7 @@ static unsigned int check_modem_status(struct uart_8250_port *up)
  */
 static void serial8250_handle_port(struct uart_8250_port *up)
 {
-	unsigned int status;
+	unsigned int status, status1;
 	unsigned long flags;
 
 	spin_lock_irqsave(&up->port.lock, flags);
@@ -1578,10 +1715,17 @@ static void serial8250_handle_port(struct uart_8250_port *up)
 
 	DEBUG_INTR("status = %x...", status);
 
-	if (status & (UART_LSR_DR | UART_LSR_BI))
+	if (up->bugs & UART_BUG_SBC)
+		status1 = status & UART_LSR_DR;
+	else
+		status1 = status & (UART_LSR_DR | UART_LSR_BI);
+	if (status1)
 		receive_chars(up, &status);
-	check_modem_status(up);
-	if (status & UART_LSR_THRE)
+	if (!(up->bugs & UART_BUG_NOMSR))
+		check_modem_status(up);
+	status &= UART_LSR_THRE;
+	status = (up->bugs & UART_BUG_STC) ? (!status) : status;
+	if (status)
 		transmit_chars(up);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
@@ -1614,12 +1758,19 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 	l = i->head;
 	do {
 		struct uart_8250_port *up;
-		unsigned int iir;
+		unsigned int iir, ier;
+		unsigned int status;
 
 		up = list_entry(l, struct uart_8250_port, list);
 
 		iir = serial_in(up, UART_IIR);
-		if (!(iir & UART_IIR_NO_INT)) {
+		/* check added to detect spurious interrupts */
+		if (up->bugs & UART_BUG_SIC) {
+			ier = serial_in(up, UART_IER);
+			status = ier & iir;
+		} else
+			status = !(iir & UART_IIR_NO_INT);
+		if (status) {
 			serial8250_handle_port(up);
 
 			handled = 1;
@@ -1738,7 +1889,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 
 static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
-	struct irq_info *i;
+	struct irq_info *i = NULL;
 	struct hlist_node *n;
 	struct hlist_head *h;
 
@@ -1829,14 +1980,15 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 	struct uart_8250_port *up =
 		container_of(port, struct uart_8250_port, port);
 	unsigned long flags;
-	unsigned int lsr;
+	unsigned int lsr, empty;
 
 	spin_lock_irqsave(&up->port.lock, flags);
 	lsr = serial_in(up, UART_LSR);
 	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
 	spin_unlock_irqrestore(&up->port.lock, flags);
+	empty = BOTH_EMPTY(up);
 
-	return (lsr & BOTH_EMPTY) == BOTH_EMPTY ? TIOCSER_TEMT : 0;
+	return (lsr & empty) == empty ? TIOCSER_TEMT : 0;
 }
 
 static unsigned int serial8250_get_mctrl(struct uart_port *port)
@@ -1846,6 +1998,9 @@ static unsigned int serial8250_get_mctrl(struct uart_port *port)
 	unsigned int status;
 	unsigned int ret;
 
+	if (up->bugs & UART_BUG_NOMSR)
+		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
+
 	status = check_modem_status(up);
 
 	ret = 0;
@@ -1866,6 +2021,9 @@ static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		container_of(port, struct uart_8250_port, port);
 	unsigned char mcr = 0;
 
+	if (up->bugs & UART_BUG_NOMSR)
+		return;
+
 	if (mctrl & TIOCM_RTS)
 		mcr |= UART_MCR_RTS;
 	if (mctrl & TIOCM_DTR)
@@ -1893,7 +2051,10 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 		up->lcr |= UART_LCR_SBC;
 	else
 		up->lcr &= ~UART_LCR_SBC;
-	serial_out(up, UART_LCR, up->lcr);
+	if (up->bugs & UART_BUG_SBC)
+		serial_out(up, UART_FCR, up->lcr);
+	else
+		serial_out(up, UART_LCR, up->lcr);
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
@@ -1966,14 +2127,14 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	else
 		serial_out(up, UART_IER, 0);
 
-	wait_for_xmitr(up, BOTH_EMPTY);
+	wait_for_xmitr(up, BOTH_EMPTY(up));
 	/*
 	 *	Send the character out.
 	 *	If a LF, also do CR...
 	 */
 	serial_out(up, UART_TX, c);
 	if (c == 10) {
-		wait_for_xmitr(up, BOTH_EMPTY);
+		wait_for_xmitr(up, BOTH_EMPTY(up));
 		serial_out(up, UART_TX, 13);
 	}
 
@@ -1981,7 +2142,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the IER
 	 */
-	wait_for_xmitr(up, BOTH_EMPTY);
+	wait_for_xmitr(up, BOTH_EMPTY(up));
 	serial_out(up, UART_IER, ier);
 }
 
@@ -2035,8 +2196,12 @@ static int serial8250_startup(struct uart_port *port)
 	 */
 	(void) serial_inp(up, UART_LSR);
 	(void) serial_inp(up, UART_RX);
-	(void) serial_inp(up, UART_IIR);
-	(void) serial_inp(up, UART_MSR);
+	if (!(up->bugs & UART_BUG_RRTI)) {
+		(void) serial_inp(up, UART_IIR);
+		(void) serial_inp(up, UART_MSR);
+	} else {
+		serial_outp(up, UART_IIR, 0xff);
+	}
 
 	/*
 	 * At this point, there's no way the LSR could still be 0xff;
@@ -2067,7 +2232,8 @@ static int serial8250_startup(struct uart_port *port)
 		serial_outp(up, UART_LCR, 0);
 	}
 
-	if (is_real_interrupt(up->port.irq)) {
+	if ((!(up->port.flags & UPF_SKIP_TEST)) &&
+	    (is_real_interrupt(up->port.irq))) {
 		unsigned char iir1;
 		/*
 		 * Test for UARTs that do not reassert THRE when the
@@ -2192,8 +2358,12 @@ dont_test_tx_en:
 	 */
 	serial_inp(up, UART_LSR);
 	serial_inp(up, UART_RX);
-	serial_inp(up, UART_IIR);
-	serial_inp(up, UART_MSR);
+	if (!(up->bugs & UART_BUG_RRTI)) {
+		(void) serial_inp(up, UART_IIR);
+		(void) serial_inp(up, UART_MSR);
+	} else {
+		serial_outp(up, UART_IIR, 0xff);
+	}
 	up->lsr_saved_flags = 0;
 	up->msr_saved_flags = 0;
 
@@ -2280,6 +2450,8 @@ static unsigned int serial8250_get_divisor(struct uart_port *port, unsigned int
 	else if ((port->flags & UPF_MAGIC_MULTIPLIER) &&
 		 baud == (port->uartclk/8))
 		quot = 0x8002;
+	else if (port->flags & UPF_MAGIC_MULTIPLIER)
+		quot = port->uartclk / (9 * baud);
 	else
 		quot = uart_get_divisor(port, baud);
 
@@ -2296,6 +2468,10 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long flags;
 	unsigned int baud, quot;
 
+	if (up->bugs & UART_BUG_NOMSR) {
+		termios->c_cflag &= ~(HUPCL | CRTSCTS | CMSPAR);
+		termios->c_cflag |= CLOCAL;
+	}
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
 		cval = UART_LCR_WLEN5;
@@ -2314,10 +2490,17 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (termios->c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
-	if (termios->c_cflag & PARENB)
-		cval |= UART_LCR_PARITY;
-	if (!(termios->c_cflag & PARODD))
-		cval |= UART_LCR_EPAR;
+	if (!(up->bugs & UART_BUG_PAR)) {
+		if (termios->c_cflag & PARENB)
+			cval |= UART_LCR_PARITY;
+		if (!(termios->c_cflag & PARODD))
+			cval |= UART_LCR_EPAR;
+	} else if (termios->c_cflag & PARENB) {
+		if (termios->c_cflag & PARODD)
+			cval |= UART_LCR_PARITY;
+		else
+			cval |= UART_LCR_EPAR;
+	}
 #ifdef CMSPAR
 	if (termios->c_cflag & CMSPAR)
 		cval |= UART_LCR_SPAR;
@@ -2451,7 +2634,10 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_outp(up, UART_FCR, fcr);
 
 	serial_outp(up, UART_LCR, cval);		/* reset DLAB */
-	up->lcr = cval;					/* Save LCR */
+	if (!(up->bugs & UART_BUG_SBC))
+		up->lcr = cval;					/* Save LCR */
+	else
+		up->lcr = fcr;
 	if (up->port.type != PORT_16750) {
 		if (fcr & UART_FCR_ENABLE_FIFO) {
 			/* emulated UARTs (Lucent Venus 167x) need two steps */
@@ -2785,11 +2971,15 @@ static void __init serial8250_isa_init_ports(void)
 		up->port.uartclk  = old_serial_port[i].baud_base * 16;
 		up->port.flags    = old_serial_port[i].flags;
 		up->port.hub6     = old_serial_port[i].hub6;
-		up->port.membase  = old_serial_port[i].iomem_base;
+		up->port.membase  = old_serial_port[i].serial_membase ? \
+				    old_serial_port[i].serial_membase() : \
+				    old_serial_port[i].iomem_base;
 		up->port.iotype   = old_serial_port[i].io_type;
 		up->port.regshift = old_serial_port[i].iomem_reg_shift;
 		set_io_from_upio(&up->port);
 		up->port.irqflags |= irqflag;
+		early_autoconfig(up);
+		up->port.type = old_serial_port[i].type;
 		if (serial8250_isa_config != NULL)
 			serial8250_isa_config(i, &up->port, &up->capabilities);
 
@@ -2836,7 +3026,10 @@ static void serial8250_console_putchar(struct uart_port *port, int ch)
 	struct uart_8250_port *up =
 		container_of(port, struct uart_8250_port, port);
 
-	wait_for_xmitr(up, UART_LSR_THRE);
+	if (!(up->bugs & UART_BUG_STC))
+		wait_for_xmitr(up, UART_LSR_THRE);
+	else
+		wait_for_xmitr(up, BOTH_EMPTY(up));
 	serial_out(up, UART_TX, ch);
 }
 
@@ -2881,7 +3074,7 @@ serial8250_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the IER
 	 */
-	wait_for_xmitr(up, BOTH_EMPTY);
+	wait_for_xmitr(up, BOTH_EMPTY(up));
 	serial_out(up, UART_IER, ier);
 
 	/*
diff --git a/drivers/tty/serial/8250.h b/drivers/tty/serial/8250.h
index 6e19ea3..b474380 100644
--- a/drivers/tty/serial/8250.h
+++ b/drivers/tty/serial/8250.h
@@ -26,6 +26,8 @@ struct old_serial_port {
 	unsigned char *iomem_base;
 	unsigned short iomem_reg_shift;
 	unsigned long irqflags;
+	unsigned char	*(*serial_membase)(void);
+	unsigned int type;
 };
 
 /*
@@ -49,6 +51,17 @@ struct serial8250_config {
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
 #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
+#define UART_BUG_STC	(1 << 4)	/* UART has bug, skip THRE check */
+#define UART_BUG_RRTI	(1 << 5)	/* UART has bug, always reset receive
+					and transmit interrupt indication */
+#define UART_BUG_SIC	(1 << 6)	/* UART has bug, always check for
+					spurious interrupts */
+#define UART_BUG_SBC	(1 << 7)	/* UART has bug, break indicator in flow
+					control and not in line control */
+#define UART_BUG_PAR	(1 << 8)	/* UART has bug, parity settings
+					non standard */
+#define UART_BUG_OE	(1 << 9)	/* UART has bug, software synthesized
+					overrun error */
 
 #define PROBE_RSA	(1 << 0)
 #define PROBE_ANY	(~0)
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 80484af..a01ea3c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1612,4 +1612,10 @@ config SERIAL_MXS_AUART_CONSOLE
 	help
 	  Enable a MXS AUART port to be the system console.
 
+config SERIAL_8250_IRBLASTER
+	bool "IRBlaster serial support"
+	depends on POWERTV=y && SERIAL_8250
+	default y
+	help
+	  This enables the Cisco PowerTV serial interface.
 endmenu
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 758c5b0..0d87cbc 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -45,7 +45,8 @@
 #define PORT_OCTEON	17	/* Cavium OCTEON internal UART */
 #define PORT_AR7	18	/* Texas Instruments AR7 internal UART */
 #define PORT_U6_16550A	19	/* ST-Ericsson U6xxx internal UART */
-#define PORT_MAX_8250	19	/* max port ID */
+#define PORT_IRBLASTER	20	/* Cisco PowerTV UART */
+#define PORT_MAX_8250	20	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 3ecb71a..938f502 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -360,5 +360,101 @@
 #define UART_OMAP_MDR1_CIR_MODE		0x06	/* CIR mode */
 #define UART_OMAP_MDR1_DISABLE		0x07	/* Disable (default state) */
 
+#ifdef CONFIG_SERIAL_8250_IRBLASTER
+/**
+ * IRBLASTER register / bit mask definitions
+ * The following are a hack due to incompatibility
+ * register, bit mask definitions between Cisco PowerTV
+ * and PC16550 industrial UART
+ */
+#undef UART_FCR
+#define UART_FCR	4		/* Fifo control register */
+
+#undef UART_FCR_CLEAR_RCVR
+#define UART_FCR_CLEAR_RCVR	0x10	/* Clear the RCVR FIFO */
+
+#undef UART_FCR_CLEAR_XMIT
+#define UART_FCR_CLEAR_XMIT	0x08	/* Clear the XMIT FIFO */
+
+#define UART_FCR_RCVR_EN	0x02	/* Receiver enable */
+#define UART_FCR_XMIT_EN	0x01	/* Transmitter enable */
+#undef UART_ACR_ASREN
+#define UART_ACR_ASREN	(UART_FCR_RCVR_EN | UART_FCR_XMIT_EN)
+
+#undef UART_DLL
+#undef UART_DLM
+
+#define UART_DL_BASE	5		/* Divisor latch base */
+#define UART_DLM	UART_DL_BASE	/* Divisor latch MSB and LSB */
+#define UART_DLL	(UART_DL_BASE + 1)
+
+#undef UART_IER_THRI
+#define UART_IER_THRI		0x01	/* Transmitter empty int enable */
+
+#undef UART_IER_RLSI
+#define UART_INT_RX_READY	0x02	/* Receiver ready int enable */
+#undef UART_ACR_DSRFC
+#define UART_ACR_DSRFC		0x08	/* Receiver overrun int enable */
+#define UART_INT_RX_FIFO_FULL	0x80	/* Receiver fifo full int enable */
+#define UART_IER_RLSI		(UART_INT_RX_READY | UART_INT_RX_FIFO_FULL | \
+				UART_ACR_DSRFC)
+
+#undef UART_IER_RDI
+#define UART_IER_RDI		0x0	/* No receiver data interrupt */
+
+#undef UART_IER_MSI
+#define UART_IER_MSI		0x0	/* No Modem status interrupt */
+
+#undef UART_LSR_DR
+#define UART_LSR_DR		0x80	/* Data ready indicator */
+
+#undef UART_LSR_BI
+#define UART_LSR_BI		0x08	/* Break interrupt indicator */
+
+#undef UART_LSR_FE
+#define UART_LSR_FE		0x04	/* Frame error indicator */
+
+#undef UART_LSR_PE
+#define UART_LSR_PE		0x02	/* Parity error indicator */
+
+#undef UART_LSR_OE
+					/* Software synthesized overrun error */
+#define UART_LSR_OE		0x80000000
+
+#undef UART_LSR_BRK_ERROR_BITS
+#define UART_LSR_BRK_ERROR_BITS	(UART_LSR_BI | UART_LSR_FE | UART_LSR_PE | \
+				UART_LSR_OE)
+
+#undef UART_LSR_THRE
+#define UART_LSR_THRE		0x10	/* Transmit full indicator */
+
+#undef UART_LCR_SBC
+#define UART_LCR_SBC		0x04	/* Set breal control */
+
+#undef UART_LCR_WLEN5
+#define UART_LCR_WLEN5		0x00	/* Wordlength: 5 bits */
+
+#undef UART_LCR_WLEN6
+#define UART_LCR_WLEN6		0x01	/* Wordlength: 6 bits */
+
+#undef UART_LCR_WLEN7
+#define UART_LCR_WLEN7		0x02	/* Wordlength: 7 bits */
+
+#undef UART_LCR_WLEN8
+#define UART_LCR_WLEN8		0x03	/* Wordlength: 8 bits */
+
+#undef UART_LCR_STOP
+#define UART_LCR_STOP		0x08	/* Stop bits: 0=1 bit, 1=2 bits */
+
+#undef UART_LCR_PARITY
+#define UART_LCR_PARITY		0x20	/* Parity Enable odd */
+
+#undef UART_LCR_EPAR
+#define UART_LCR_EPAR		0x40	/* Parity Enable even */
+
+#undef UART_LCR_DLAB
+#define UART_LCR_DLAB		0x0	/* No specific divisor latch
+					access bit */
+#endif  /* CONFIG_SERIAL_8250_IRBLASTER */
 #endif /* _LINUX_SERIAL_REG_H */
 
