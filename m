From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 1/2] tty: serial8250: add helpers for the DesignWare 8250
Date: Tue, 16 Aug 2011 17:47:46 +0100
Message-ID: <1313513267-25955-2-git-send-email-jamie@jamieiles.com>
References: <1313513267-25955-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52550 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab1HPQsN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Aug 2011 12:48:13 -0400
Received: by wyg24 with SMTP id 24so57420wyg.19
        for <linux-serial@vger.kernel.org>; Tue, 16 Aug 2011 09:48:12 -0700 (PDT)
In-Reply-To: <1313513267-25955-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: arnd@arndb.de, alan@lxorguk.ukuu.org.uk, Jamie Iles <jamie@jamieiles.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

The Synopsys DesignWare 8250 is an 8250 that has an extra interrupt that
gets raised when writing to the LCR when busy.  To handle this we need
special serial_out, serial_in and handle_irq methods.  Add a new
function serial8250_use_designware_io() that configures a uart_port with
these accessors.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/tty/serial/8250_dw.c |   99 ++++++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/Kconfig   |    7 +++
 drivers/tty/serial/Makefile  |    1 +
 include/linux/serial_8250.h  |    8 +++
 4 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 drivers/tty/serial/8250_dw.c

diff --git a/drivers/tty/serial/8250_dw.c b/drivers/tty/serial/8250_dw.c
new file mode 100644
index 0000000..e25782a
--- /dev/null
+++ b/drivers/tty/serial/8250_dw.c
@@ -0,0 +1,99 @@
+/*
+ * Synopsys DesignWare specific 8250 operations.
+ *
+ * Copyright 2011 Picochip, Jamie Iles.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * The Synopsys DesignWare 8250 has an extra feature whereby it detects if the
+ * LCR is written whilst busy.  If it is, then a busy detect interrupt is
+ * raised, the LCR needs to be rewritten and the uart status register read.
+ */
+#include <linux/io.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/slab.h>
+
+struct dw8250_data {
+	int	last_lcr;
+};
+
+static void dw8250_serial_out(struct uart_port *p, int offset, int value)
+{
+	struct dw8250_data *d = p->private_data;
+
+	if (offset == UART_LCR)
+		d->last_lcr = value;
+
+	offset <<= p->regshift;
+	writeb(value, p->membase + offset);
+}
+
+static unsigned int dw8250_serial_in(struct uart_port *p, int offset)
+{
+	offset <<= p->regshift;
+
+	return readb(p->membase + offset);
+}
+
+static void dw8250_serial_out32(struct uart_port *p, int offset,
+				int value)
+{
+	struct dw8250_data *d = p->private_data;
+
+	if (offset == UART_LCR)
+		d->last_lcr = value;
+
+	offset <<= p->regshift;
+	writel(value, p->membase + offset);
+}
+
+static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
+{
+	offset <<= p->regshift;
+
+	return readl(p->membase + offset);
+}
+
+/* Offset for the DesignWare's UART Status Register. */
+#define UART_USR	0x1f
+
+static int dw8250_handle_irq(struct uart_port *p)
+{
+	struct dw8250_data *d = p->private_data;
+	unsigned int iir = p->serial_in(p, UART_IIR);
+
+	if (serial8250_handle_irq(p, iir)) {
+		return 1;
+	} else if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
+		/* Clear the USR and write the LCR again. */
+		(void)p->serial_in(p, UART_USR);
+		p->serial_out(p, d->last_lcr, UART_LCR);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+int serial8250_use_designware_io(struct uart_port *up)
+{
+	up->private_data = kzalloc(sizeof(struct dw8250_data), GFP_KERNEL);
+	if (!up->private_data)
+		return -ENOMEM;
+
+	if (up->iotype == UPIO_MEM32) {
+		up->serial_out = dw8250_serial_out32;
+		up->serial_in = dw8250_serial_in32;
+	} else {
+		up->serial_out = dw8250_serial_out;
+		up->serial_in = dw8250_serial_in;
+	}
+	up->handle_irq = dw8250_handle_irq;
+
+	return 0;
+}
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4dcb37bb..f314acc 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -267,6 +267,13 @@ config SERIAL_8250_RM9K
 	  port hardware found on MIPS RM9122 and similar processors.
 	  If unsure, say N.
 
+config SERIAL_8250_DW
+	bool "Support for Synopsys DesignWare 8250 quirks"
+	depends on SERIAL_8250
+	help
+	  Selecting this option will enable handling of the extra features
+	  present in the Synopsys DesignWare APB UART.
+
 comment "Non-8250 serial port support"
 
 config SERIAL_AMBA_PL010
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 83b4da6..06c9808 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_SERIAL_8250_BOCA) += 8250_boca.o
 obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554) += 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_HUB6) += 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_MCA) += 8250_mca.o
+obj-$(CONFIG_SERIAL_8250_DW) += 8250_dw.o
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 1f05bbe..09e2dbc 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -86,5 +86,13 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 extern void serial8250_set_isa_configurator(void (*v)
 					(int port, struct uart_port *up,
 						unsigned short *capabilities));
+#ifndef SERIAL_8250_DW
+extern int serial8250_use_designware_io(struct uart_port *up);
+#else
+static inline int serial8250_use_designware_io(struct uart_port *up)
+{
+	return -EIO;
+}
+#endif
 
 #endif
-- 
1.7.4.1

