From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [PATCH v2] serial: 8250_early: Add earlycon support for Palmchip UART
Date: Mon, 10 Apr 2017 11:47:09 +0200
Message-ID: <7a016ff6-08fc-2811-92e0-7c4603fa8586@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, Andreas Farber <afaerber@suse.de>, Jean Delvare <jdelvare@suse.de>, Rob Herring <robh@kernel.org>, Mans Rullgard <mans@mansr.com>, Jiri Slaby <jslaby@suse.cz>, Masahiro Yamada <yamada.masahiro@socionext.com>, Vineet Gupta <vgupta@synopsys.com>, Scott Wood <scottwood@freescale.com>, Robin Murphy <robin.murphy@arm.com>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Define an OF early console for Palmchip UART, which can be enabled
by passing "earlycon" on the boot command line.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/tty/serial/8250/8250_early.c | 24 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c  |  4 ++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 85a12f032402..82fc48eca1df 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -39,6 +39,7 @@
 
 static unsigned int __init serial8250_early_in(struct uart_port *port, int offset)
 {
+	int reg_offset = offset;
 	offset <<= port->regshift;
 
 	switch (port->iotype) {
@@ -52,6 +53,8 @@ static unsigned int __init serial8250_early_in(struct uart_port *port, int offse
 		return ioread32be(port->membase + offset);
 	case UPIO_PORT:
 		return inb(port->iobase + offset);
+	case UPIO_AU:
+		return port->serial_in(port, reg_offset);
 	default:
 		return 0;
 	}
@@ -59,6 +62,7 @@ static unsigned int __init serial8250_early_in(struct uart_port *port, int offse
 
 static void __init serial8250_early_out(struct uart_port *port, int offset, int value)
 {
+	int reg_offset = offset;
 	offset <<= port->regshift;
 
 	switch (port->iotype) {
@@ -77,6 +81,9 @@ static void __init serial8250_early_out(struct uart_port *port, int offset, int
 	case UPIO_PORT:
 		outb(value, port->iobase + offset);
 		break;
+	case UPIO_AU:
+		port->serial_out(port, reg_offset, value);
+		break;
 	}
 }
 
@@ -172,3 +179,20 @@ OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
 
 #endif
+
+#ifdef CONFIG_SERIAL_8250_RT288X
+
+unsigned int au_serial_in(struct uart_port *p, int offset);
+void au_serial_out(struct uart_port *p, int offset, int value);
+
+static int __init early_au_setup(struct earlycon_device *dev, const char *opt)
+{
+	dev->port.serial_in = au_serial_in;
+	dev->port.serial_out = au_serial_out;
+	dev->port.iotype = UPIO_AU;
+	dev->con->write = early_serial8250_write;
+	return 0;
+}
+OF_EARLYCON_DECLARE(palmchip, "ralink,rt2880-uart", early_au_setup);
+
+#endif
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 080d5a59d0a7..1f08d22d1a80 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -313,7 +313,7 @@ static const s8 au_io_out_map[8] = {
 	-1,	/* UART_SCR (unmapped) */
 };
 
-static unsigned int au_serial_in(struct uart_port *p, int offset)
+unsigned int au_serial_in(struct uart_port *p, int offset)
 {
 	if (offset >= ARRAY_SIZE(au_io_in_map))
 		return UINT_MAX;
@@ -323,7 +323,7 @@ static unsigned int au_serial_in(struct uart_port *p, int offset)
 	return __raw_readl(p->membase + (offset << p->regshift));
 }
 
-static void au_serial_out(struct uart_port *p, int offset, int value)
+void au_serial_out(struct uart_port *p, int offset, int value)
 {
 	if (offset >= ARRAY_SIZE(au_io_out_map))
 		return;
-- 
2.11.0
