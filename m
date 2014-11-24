From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 7/7] serial: 8250: Add support for big-endian MMIO accesses
Date: Mon, 24 Nov 2014 15:36:22 -0800
Message-ID: <1416872182-6440-8-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53105 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaKXXgj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2014 18:36:39 -0500
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org

Add cases for UPIO_MEM32BE wherever there are currently cases handling
UPIO_MEM32.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c  | 20 ++++++++++++++++++++
 drivers/tty/serial/8250/8250_early.c |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ca5cfdc..53982f0 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -428,6 +428,18 @@ static unsigned int mem32_serial_in(struct uart_port *p, int offset)
 	return readl(p->membase + offset);
 }
 
+static void mem32be_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset = offset << p->regshift;
+	iowrite32be(value, p->membase + offset);
+}
+
+static unsigned int mem32be_serial_in(struct uart_port *p, int offset)
+{
+	offset = offset << p->regshift;
+	return ioread32be(p->membase + offset);
+}
+
 static unsigned int io_serial_in(struct uart_port *p, int offset)
 {
 	offset = offset << p->regshift;
@@ -466,6 +478,11 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_out = mem32_serial_out;
 		break;
 
+	case UPIO_MEM32BE:
+		p->serial_in = mem32be_serial_in;
+		p->serial_out = mem32be_serial_out;
+		break;
+
 #if defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_SERIAL_8250_RT288X)
 	case UPIO_AU:
 		p->serial_in = au_serial_in;
@@ -491,6 +508,7 @@ serial_port_out_sync(struct uart_port *p, int offset, int value)
 	switch (p->iotype) {
 	case UPIO_MEM:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_AU:
 		p->serial_out(p, offset, value);
 		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
@@ -2655,6 +2673,7 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_MEM:
 		if (!port->mapbase)
 			break;
@@ -2691,6 +2710,7 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_MEM:
 		if (!port->mapbase)
 			break;
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 4858b8a..33a0fb6 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -45,6 +45,8 @@ unsigned int __weak __init serial8250_early_in(struct uart_port *port, int offse
 		return readb(port->membase + offset);
 	case UPIO_MEM32:
 		return readl(port->membase + (offset << 2));
+	case UPIO_MEM32BE:
+		return ioread32be(port->membase + (offset << 2));
 	case UPIO_PORT:
 		return inb(port->iobase + offset);
 	default:
@@ -61,6 +63,9 @@ void __weak __init serial8250_early_out(struct uart_port *port, int offset, int
 	case UPIO_MEM32:
 		writel(value, port->membase + (offset << 2));
 		break;
+	case UPIO_MEM32BE:
+		iowrite32be(value, port->membase + (offset << 2));
+		break;
 	case UPIO_PORT:
 		outb(value, port->iobase + offset);
 		break;
-- 
2.1.0

