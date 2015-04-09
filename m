From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V4 4/5] serial: 8250: Add support for big-endian MMIO accesses
Date: Thu,  9 Apr 2015 13:05:17 -0700
Message-ID: <1428609918-10290-5-git-send-email-cernekee@gmail.com>
References: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: arnd@arndb.de, peter@hurleysoftware.com, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add cases for UPIO_MEM32BE wherever there are currently cases handling
UPIO_MEM32.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c  | 20 ++++++++++++++++++++
 drivers/tty/serial/8250/8250_early.c |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index deae122c9c4b..0bffa735eaa1 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -439,6 +439,18 @@ static unsigned int mem32_serial_in(struct uart_port *p, int offset)
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
@@ -477,6 +489,11 @@ static void set_io_from_upio(struct uart_port *p)
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
@@ -502,6 +519,7 @@ serial_port_out_sync(struct uart_port *p, int offset, int value)
 	switch (p->iotype) {
 	case UPIO_MEM:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_AU:
 		p->serial_out(p, offset, value);
 		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
@@ -2743,6 +2761,7 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_MEM:
 		if (!port->mapbase)
 			break;
@@ -2779,6 +2798,7 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_MEM:
 		if (!port->mapbase)
 			break;
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index c31a22b4f845..84f6d11bbeed 100644
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
2.2.2
