From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC 5/5] 8250: extract out the "odd" port types
Date: Fri, 18 Mar 2011 15:26:21 +0000
Message-ID: <20110318152607.10657.62502.stgit@bob.linux.org.uk>
References: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44129 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab1CRPqN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Mar 2011 11:46:13 -0400
Received: from bob.linux.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id p2IFn2QM018131
	for <linux-serial@vger.kernel.org>; Fri, 18 Mar 2011 15:49:07 GMT
In-Reply-To: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Possibly these want to end up in arch code but for the moment make them
little separate files in the serial layer

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/8250.c       |  207 ++-------------------------------------
 drivers/tty/serial/8250_au.c    |   90 +++++++++++++++++
 drivers/tty/serial/8250_dwapb.c |  120 +++++++++++++++++++++++
 drivers/tty/serial/8250_rm9k.c  |   95 ++++++++++++++++++
 drivers/tty/serial/Kconfig      |    9 ++
 drivers/tty/serial/Makefile     |    3 +
 6 files changed, 329 insertions(+), 195 deletions(-)
 create mode 100644 drivers/tty/serial/8250_au.c
 create mode 100644 drivers/tty/serial/8250_dwapb.c
 create mode 100644 drivers/tty/serial/8250_rm9k.c


diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index a5867da..21cfa66 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -280,88 +280,6 @@ static const struct serial8250_config uart_config[] = {
 	},
 };
 
-#if defined(CONFIG_MIPS_ALCHEMY)
-
-/* Au1x00 UART hardware has a weird register layout */
-static const u8 au_io_in_map[] = {
-	[UART_RX]  = 0,
-	[UART_IER] = 2,
-	[UART_IIR] = 3,
-	[UART_LCR] = 5,
-	[UART_MCR] = 6,
-	[UART_LSR] = 7,
-	[UART_MSR] = 8,
-};
-
-static const u8 au_io_out_map[] = {
-	[UART_TX]  = 1,
-	[UART_IER] = 2,
-	[UART_FCR] = 4,
-	[UART_LCR] = 5,
-	[UART_MCR] = 6,
-};
-
-/* sane hardware needs no mapping */
-static inline int map_8250_in_reg(struct uart_port *p, int offset)
-{
-	if (p->iotype != UPIO_AU)
-		return offset;
-	return au_io_in_map[offset];
-}
-
-static inline int map_8250_out_reg(struct uart_port *p, int offset)
-{
-	if (p->iotype != UPIO_AU)
-		return offset;
-	return au_io_out_map[offset];
-}
-
-#elif defined(CONFIG_SERIAL_8250_RM9K)
-
-static const u8
-	regmap_in[8] = {
-		[UART_RX]	= 0x00,
-		[UART_IER]	= 0x0c,
-		[UART_IIR]	= 0x14,
-		[UART_LCR]	= 0x1c,
-		[UART_MCR]	= 0x20,
-		[UART_LSR]	= 0x24,
-		[UART_MSR]	= 0x28,
-		[UART_SCR]	= 0x2c
-	},
-	regmap_out[8] = {
-		[UART_TX] 	= 0x04,
-		[UART_IER]	= 0x0c,
-		[UART_FCR]	= 0x18,
-		[UART_LCR]	= 0x1c,
-		[UART_MCR]	= 0x20,
-		[UART_LSR]	= 0x24,
-		[UART_MSR]	= 0x28,
-		[UART_SCR]	= 0x2c
-	};
-
-static inline int map_8250_in_reg(struct uart_port *p, int offset)
-{
-	if (p->iotype != UPIO_RM9000)
-		return offset;
-	return regmap_in[offset];
-}
-
-static inline int map_8250_out_reg(struct uart_port *p, int offset)
-{
-	if (p->iotype != UPIO_RM9000)
-		return offset;
-	return regmap_out[offset];
-}
-
-#else
-
-/* sane hardware needs no mapping */
-#define map_8250_in_reg(up, offset) (offset)
-#define map_8250_out_reg(up, offset) (offset)
-
-#endif
-
 /* Uart divisor latch read */
 static unsigned int std_serial_dl_read(struct uart_port *p)
 {
@@ -382,13 +300,13 @@ static void std_serial_dl_write(struct uart_port *p, unsigned int value)
 
 static unsigned int mem_serial_in(struct uart_port *p, int offset)
 {
-	offset = map_8250_in_reg(p, offset) << p->regshift;
+	offset <<= p->regshift;
 	return readb(p->membase + offset);
 }
 
 static void mem_serial_out(struct uart_port *p, int offset, int value)
 {
-	offset = map_8250_out_reg(p, offset) << p->regshift;
+	offset <<= p->regshift;
 	writeb(value, p->membase + offset);
 }
 
@@ -401,13 +319,13 @@ static const struct serial8250_ops mem_ops = {
 
 static void mem32_serial_out(struct uart_port *p, int offset, int value)
 {
-	offset = map_8250_out_reg(p, offset) << p->regshift;
+	offset <<= p->regshift;
 	writel(value, p->membase + offset);
 }
 
 static unsigned int mem32_serial_in(struct uart_port *p, int offset)
 {
-	offset = map_8250_in_reg(p, offset) << p->regshift;
+	offset <<= p->regshift;
 	return readl(p->membase + offset);
 }
 
@@ -421,7 +339,7 @@ static const struct serial8250_ops mem32_ops = {
 static unsigned int tsi_serial_in(struct uart_port *p, int offset)
 {
 	unsigned int tmp;
-	offset = map_8250_in_reg(p, offset) << p->regshift;
+	offset <<= p->regshift;
 	if (offset == UART_IIR) {
 		tmp = readl(p->membase + (UART_IIR & ~3));
 		return (tmp >> 16) & 0xff; /* UART_IIR % 4 == 2 */
@@ -431,7 +349,7 @@ static unsigned int tsi_serial_in(struct uart_port *p, int offset)
 
 static void tsi_serial_out(struct uart_port *p, int offset, int value)
 {
-	offset = map_8250_out_reg(p, offset) << p->regshift;
+	offset <<= p->regshift;
 	if (!((offset == UART_IER) && (value & UART_IER_UUE)))
 		writeb(value, p->membase + offset);
 }
@@ -443,67 +361,16 @@ static const struct serial8250_ops tsi_ops = {
 	.serial_dl_write = std_serial_dl_write
 };
 
-/* Save the LCR value so it can be re-written when a Busy Detect IRQ occurs. */
-static inline void dwapb_save_out_value(struct uart_port *p, int offset,
-					int value)
-{
-	struct uart_8250_port *up =
-		container_of(p, struct uart_8250_port, port);
-
-	if (offset == UART_LCR)
-		up->lcr = value;
-}
-
-/* Read the IER to ensure any interrupt is cleared before returning from ISR. */
-static inline void dwapb_check_clear_ier(struct uart_port *p, int offset)
-{
-	struct uart_8250_port *up =
-		container_of(p, struct uart_8250_port, port);
-	if (offset == UART_TX || offset == UART_IER)
-		up->ops->serial_in(p, UART_IER);
-}
-
-static void dwapb_serial_out(struct uart_port *p, int offset, int value)
-{
-	int save_offset = offset;
-	offset = map_8250_out_reg(p, offset) << p->regshift;
-	dwapb_save_out_value(p, save_offset, value);
-	writeb(value, p->membase + offset);
-	dwapb_check_clear_ier(p, save_offset);
-}
-
-static const struct serial8250_ops dwapb_ops = {
-	.serial_in = mem_serial_in,
-	.serial_out = dwapb_serial_out,
-	.serial_dl_read = std_serial_dl_read,
-	.serial_dl_write = std_serial_dl_write
-};
-
-static void dwapb32_serial_out(struct uart_port *p, int offset, int value)
-{
-	int save_offset = offset;
-	offset = map_8250_out_reg(p, offset) << p->regshift;
-	dwapb_save_out_value(p, save_offset, value);
-	writel(value, p->membase + offset);
-	dwapb_check_clear_ier(p, save_offset);
-}
-
-static const struct serial8250_ops dwapb32_ops = {
-	.serial_in = mem32_serial_in,
-	.serial_out = dwapb32_serial_out,
-	.serial_dl_read = std_serial_dl_read,
-	.serial_dl_write = std_serial_dl_write
-};
 
 static unsigned int io_serial_in(struct uart_port *p, int offset)
 {
-	offset = map_8250_in_reg(p, offset) << p->regshift;
+	offset <<= p->regshift;
 	return inb(p->iobase + offset);
 }
 
 static void io_serial_out(struct uart_port *p, int offset, int value)
 {
-	offset = map_8250_out_reg(p, offset) << p->regshift;
+	offset <<= p->regshift;
 	outb(value, p->iobase + offset);
 }
 
@@ -515,67 +382,17 @@ static const struct serial8250_ops pio_ops = {
 	.serial_dl_write = std_serial_dl_write
 };
 
-static unsigned int au_serial_in(struct uart_port *p, int offset)
-{
-	offset = map_8250_in_reg(p, offset) << p->regshift;
-	return __raw_readl(p->membase + offset);
-}
-
-static void au_serial_out(struct uart_port *p, int offset, int value)
-{
-	offset = map_8250_out_reg(p, offset) << p->regshift;
-	__raw_writel(value, p->membase + offset);
-}
-
-/* Au1x00 haven't got a standard divisor latch */
-static unsigned int au_serial_dl_read(struct uart_port *p)
-{
-	return __raw_readl(p->membase + 0x28);
-}
-
-static void au_serial_dl_write(struct uart_port *p, unsigned int value)
-{
-	__raw_writel(value, p->membase + 0x28);
-}
-
-static const struct serial8250_ops au_ops = {
-	.serial_in = au_serial_in,
-	.serial_out = au_serial_out,
-	.serial_dl_read = au_serial_dl_read,
-	.serial_dl_write = au_serial_dl_write
-};
-
-static unsigned int rm9k_serial_dl_read(struct uart_port *p)
-{
-	return	(((__raw_readl(p->membase + 0x10) << 8) |
-		(__raw_readl(p->membase + 0x08) & 0xff)) & 0xffff);
-}
-
-static void rm9k_serial_dl_write(struct uart_port *p, unsigned int value)
-{
-	__raw_writel(value, p->membase + 0x08);
-	__raw_writel(value >> 8, p->membase + 0x10);
-}
-
-static const struct serial8250_ops rm9k_ops = {
-	.serial_in = mem32_serial_in,
-	.serial_out = mem32_serial_out,
-	.serial_dl_read = rm9k_serial_dl_read,
-	.serial_dl_write = rm9k_serial_dl_write
-};
-
-	
 static const struct serial8250_ops *upio_ops[UPIO_MAX + 1] = {
 	/* We rely upon pio_ops being built in */
 	&pio_ops,	/* UPIO_PORT */
 	NULL,		/* UPIO_HUB6 */
 	&mem_ops,	/* UPIO_MEM */
 	&mem32_ops,	/* UPIO_MEM32 */
-	&au_ops,	/* UPIO_AU */
+	NULL,		/* UPIO_AU */
 	&tsi_ops,	/* UPIO_TSI */
-	&dwapb_ops,	/* UPIO_DWAPB */
-	&rm9k_ops,	/* UPIO_RM9000 */
-	&dwapb32_ops	/* UPIO_DWAPB32 */
+	NULL,		/* UPIO_DWAPB */
+	NULL,		/* UPIO_RM9000 */
+	NULL,		/* UPIO_DWAPB32 */
 };
 
 static DEFINE_MUTEX(upio_mutex);
diff --git a/drivers/tty/serial/8250_au.c b/drivers/tty/serial/8250_au.c
new file mode 100644
index 0000000..bb5b2b2
--- /dev/null
+++ b/drivers/tty/serial/8250_au.c
@@ -0,0 +1,90 @@
+/*
+ *  linux/drivers/serial/8250_au.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+#include "8250.h"
+
+static const u8 au_io_in_map[] = {
+	[UART_RX]  = 0,
+	[UART_IER] = 2,
+	[UART_IIR] = 3,
+	[UART_LCR] = 5,
+	[UART_MCR] = 6,
+	[UART_LSR] = 7,
+	[UART_MSR] = 8,
+};
+
+static const u8 au_io_out_map[] = {
+	[UART_TX]  = 1,
+	[UART_IER] = 2,
+	[UART_FCR] = 4,
+	[UART_LCR] = 5,
+	[UART_MCR] = 6,
+};
+
+static inline int map_8250_in_reg(struct uart_port *p, int offset)
+{
+	return au_io_in_map[offset];
+}
+
+static inline int map_8250_out_reg(struct uart_port *p, int offset)
+{
+	return au_io_out_map[offset];
+}
+
+static unsigned int au_serial_in(struct uart_port *p, int offset)
+{
+	offset = map_8250_in_reg(p, offset) << p->regshift;
+	return __raw_readl(p->membase + offset);
+}
+
+static void au_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset = map_8250_out_reg(p, offset) << p->regshift;
+	__raw_writel(value, p->membase + offset);
+}
+
+/* Au1x00 hasn't got a standard divisor latch */
+static unsigned int au_serial_dl_read(struct uart_port *p)
+{
+	return __raw_readl(p->membase + 0x28);
+}
+
+static void au_serial_dl_write(struct uart_port *p, unsigned int value)
+{
+	__raw_writel(value, p->membase + 0x28);
+}
+
+static const struct serial8250_ops au_ops = {
+	.serial_in = au_serial_in,
+	.serial_out = au_serial_out,
+	.serial_dl_read = au_serial_dl_read,
+	.serial_dl_write = au_serial_dl_write,
+	.owner = THIS_MODULE
+};
+
+static int __init au8250_init(void)
+{
+	return serial8250_upio_register(UPIO_AU, &au_ops);
+}
+
+static void __exit au8250_exit(void)
+{
+	serial8250_upio_unregister(UPIO_AU);
+}
+
+module_init(au8250_init);
+module_exit(au8250_exit);
+
+
+MODULE_DESCRIPTION("8250 serial I/O methods for Au1x00 UART");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250_dwapb.c b/drivers/tty/serial/8250_dwapb.c
new file mode 100644
index 0000000..8863baa
--- /dev/null
+++ b/drivers/tty/serial/8250_dwapb.c
@@ -0,0 +1,120 @@
+/*
+ *  linux/drivers/serial/8250_dwapb.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+#include "8250.h"
+
+/* Save the LCR value so it can be re-written when a Busy Detect IRQ occurs. */
+static inline void dwapb_save_out_value(struct uart_port *p, int offset,
+					int value)
+{
+	struct uart_8250_port *up =
+		container_of(p, struct uart_8250_port, port);
+
+	if (offset == UART_LCR)
+		up->lcr = value;
+}
+
+/* Read the IER to ensure any interrupt is cleared before returning from ISR. */
+static inline void dwapb_check_clear_ier(struct uart_port *p, int offset)
+{
+	struct uart_8250_port *up =
+		container_of(p, struct uart_8250_port, port);
+	if (offset == UART_TX || offset == UART_IER)
+		up->ops->serial_in(p, UART_IER);
+}
+
+static void dwapb_serial_out(struct uart_port *p, int offset, int value)
+{
+	int save_offset = offset;
+	offset <<= p->regshift;
+	dwapb_save_out_value(p, save_offset, value);
+	writeb(value, p->membase + offset);
+	dwapb_check_clear_ier(p, save_offset);
+}
+
+static unsigned int dwapb_serial_in(struct uart_port *p, int offset)
+{
+	offset <<= p->regshift;
+	return readb(p->membase + offset);
+}
+
+static unsigned int dwapb32_serial_in(struct uart_port *p, int offset)
+{
+	offset <<= p->regshift;
+	return readl(p->membase + offset);
+}
+
+/* Uart divisor latch read */
+static unsigned int dwapb_serial_dl_read(struct uart_port *p)
+{
+	struct uart_8250_port *up =
+		container_of(p, struct uart_8250_port, port);
+	return up->ops->serial_in(p, UART_DLL) |
+			up->ops->serial_in(p, UART_DLM) << 8;
+}
+
+/* Uart divisor latch write */
+static void dwapb_serial_dl_write(struct uart_port *p, unsigned int value)
+{
+	struct uart_8250_port *up =
+		container_of(p, struct uart_8250_port, port);
+	up->ops->serial_out(p, UART_DLL, value & 0xff);
+	up->ops->serial_out(p, UART_DLM, value >> 8 & 0xff);
+}
+
+static const struct serial8250_ops dwapb_ops = {
+	.serial_in = dwapb_serial_in,
+	.serial_out = dwapb_serial_out,
+	.serial_dl_read = dwapb_serial_dl_read,
+	.serial_dl_write = dwapb_serial_dl_write
+};
+
+static void dwapb32_serial_out(struct uart_port *p, int offset, int value)
+{
+	int save_offset = offset;
+	offset <<= p->regshift;
+	dwapb_save_out_value(p, save_offset, value);
+	writel(value, p->membase + offset);
+	dwapb_check_clear_ier(p, save_offset);
+}
+
+static const struct serial8250_ops dwapb32_ops = {
+	.serial_in = dwapb32_serial_in,
+	.serial_out = dwapb32_serial_out,
+	.serial_dl_read = dwapb_serial_dl_read,
+	.serial_dl_write = dwapb_serial_dl_write
+};
+
+static int __init dwapb8250_init(void)
+{
+	int ret = serial8250_upio_register(UPIO_DWAPB, &dwapb_ops);
+	if (ret == 0) {
+		ret = serial8250_upio_register(UPIO_DWAPB32, &dwapb32_ops);
+		if (ret)
+			serial8250_upio_unregister(UPIO_DWAPB);
+	}
+	return ret;
+}
+
+static void __exit dwapb8250_exit(void)
+{
+	serial8250_upio_unregister(UPIO_DWAPB);
+	serial8250_upio_unregister(UPIO_DWAPB32);
+}
+
+module_init(dwapb8250_init);
+module_exit(dwapb8250_exit);
+
+
+MODULE_DESCRIPTION("8250 serial I/O methods for DWAPB UARTs");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250_rm9k.c b/drivers/tty/serial/8250_rm9k.c
new file mode 100644
index 0000000..91cf97e
--- /dev/null
+++ b/drivers/tty/serial/8250_rm9k.c
@@ -0,0 +1,95 @@
+/*
+ *  linux/drivers/serial/8250_rm9k.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+#include "8250.h"
+
+static const u8
+	regmap_in[8] = {
+		[UART_RX]	= 0x00,
+		[UART_IER]	= 0x0c,
+		[UART_IIR]	= 0x14,
+		[UART_LCR]	= 0x1c,
+		[UART_MCR]	= 0x20,
+		[UART_LSR]	= 0x24,
+		[UART_MSR]	= 0x28,
+		[UART_SCR]	= 0x2c
+	},
+	regmap_out[8] = {
+		[UART_TX] 	= 0x04,
+		[UART_IER]	= 0x0c,
+		[UART_FCR]	= 0x18,
+		[UART_LCR]	= 0x1c,
+		[UART_MCR]	= 0x20,
+		[UART_LSR]	= 0x24,
+		[UART_MSR]	= 0x28,
+		[UART_SCR]	= 0x2c
+	};
+
+static inline int map_8250_in_reg(struct uart_port *p, int offset)
+{
+	return regmap_in[offset];
+}
+
+static inline int map_8250_out_reg(struct uart_port *p, int offset)
+{
+	return regmap_out[offset];
+}
+
+static void rm9k_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset = map_8250_out_reg(p, offset) << p->regshift;
+	writel(value, p->membase + offset);
+}
+
+static unsigned int rm9k_serial_in(struct uart_port *p, int offset)
+{
+	offset = map_8250_in_reg(p, offset) << p->regshift;
+	return readl(p->membase + offset);
+}
+
+static unsigned int rm9k_serial_dl_read(struct uart_port *p)
+{
+	return	(((__raw_readl(p->membase + 0x10) << 8) |
+		(__raw_readl(p->membase + 0x08) & 0xff)) & 0xffff);
+}
+
+static void rm9k_serial_dl_write(struct uart_port *p, unsigned int value)
+{
+	__raw_writel(value, p->membase + 0x08);
+	__raw_writel(value >> 8, p->membase + 0x10);
+}
+
+static const struct serial8250_ops rm9k_ops = {
+	.serial_in = rm9k_serial_in,
+	.serial_out = rm9k_serial_out,
+	.serial_dl_read = rm9k_serial_dl_read,
+	.serial_dl_write = rm9k_serial_dl_write,
+	.owner = THIS_MODULE,
+};
+
+static int __init rm9k8250_init(void)
+{
+	return serial8250_upio_register(UPIO_RM9000, &rm9k_ops);
+}
+
+static void __exit rm9k8250_exit(void)
+{
+	serial8250_upio_unregister(UPIO_RM9000);
+}
+
+module_init(rm9k8250_init);
+module_exit(rm9k8250_exit);
+
+
+MODULE_DESCRIPTION("8250 serial I/O methods for the RM9000 UART");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e1aee37..fc8d7a8 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -80,6 +80,12 @@ config SERIAL_8250_GSC
 	depends on SERIAL_8250 && GSC
 	default SERIAL_8250
 
+config SERIAL_8250_AU
+	tristate "8250 support for AU1000 serial I/O methods"
+
+config SERIAL_8250_DWAPB
+	tristate "8250 support for DWAPB serial I/O methods"
+
 config SERIAL_8250_PCI
 	tristate "8250/16550 PCI device support" if EXPERT
 	depends on SERIAL_8250 && PCI
@@ -267,6 +273,9 @@ config SERIAL_8250_RM9K
 	  port hardware found on MIPS RM9122 and similar processors.
 	  If unsure, say N.
 
+config SERIAL_8250_RM9K_OPS
+	tristate "8250 support for RM9000 serial I/O methods"
+
 comment "Non-8250 serial port support"
 
 config SERIAL_AMBA_PL010
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index fee0690..af96402 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -15,6 +15,9 @@ obj-$(CONFIG_SERIAL_SUNSU) += sunsu.o
 obj-$(CONFIG_SERIAL_SUNSAB) += sunsab.o
 
 obj-$(CONFIG_SERIAL_8250) += 8250.o
+obj-$(CONFIG_SERIAL_8250_AU) += 8250_au.o
+obj-$(CONFIG_SERIAL_8250_RM9K_OPS) += 8250_rm9k.o
+obj-$(CONFIG_SERIAL_8250_DWAPB) += 8250_dwapb.o
 obj-$(CONFIG_SERIAL_8250_PNP) += 8250_pnp.o
 obj-$(CONFIG_SERIAL_8250_GSC) += 8250_gsc.o
 obj-$(CONFIG_SERIAL_8250_PCI) += 8250_pci.o

