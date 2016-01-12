From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 09/11] serial: 8250_early: Use port->regshift
Date: Tue, 12 Jan 2016 11:41:10 -0800
Message-ID: <1452627672-9482-10-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
 <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Sebastian Frias <sf84@laposte.net>, Paul Burton <paul.burton@imgtec.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

earlycon initializes struct uart_port::regshift to the correct
value for UPIO_MEM32 already. Use the port field rather than
hard-coded value.

This enables broader support for various i/o access methods in
8250 earlycon (eg., omap8250 earlycon).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_early.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 307fb23..e7cdc0c 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -39,15 +39,17 @@
 
 static unsigned int __init serial8250_early_in(struct uart_port *port, int offset)
 {
+	offset <<= port->regshift;
+
 	switch (port->iotype) {
 	case UPIO_MEM:
 		return readb(port->membase + offset);
 	case UPIO_MEM16:
-		return readw(port->membase + (offset << 1));
+		return readw(port->membase + offset);
 	case UPIO_MEM32:
-		return readl(port->membase + (offset << 2));
+		return readl(port->membase + offset);
 	case UPIO_MEM32BE:
-		return ioread32be(port->membase + (offset << 2));
+		return ioread32be(port->membase + offset);
 	case UPIO_PORT:
 		return inb(port->iobase + offset);
 	default:
@@ -57,18 +59,20 @@ static unsigned int __init serial8250_early_in(struct uart_port *port, int offse
 
 static void __init serial8250_early_out(struct uart_port *port, int offset, int value)
 {
+	offset <<= port->regshift;
+
 	switch (port->iotype) {
 	case UPIO_MEM:
 		writeb(value, port->membase + offset);
 		break;
 	case UPIO_MEM16:
-		writew(value, port->membase + (offset << 1));
+		writew(value, port->membase + offset);
 		break;
 	case UPIO_MEM32:
-		writel(value, port->membase + (offset << 2));
+		writel(value, port->membase + offset);
 		break;
 	case UPIO_MEM32BE:
-		iowrite32be(value, port->membase + (offset << 2));
+		iowrite32be(value, port->membase + offset);
 		break;
 	case UPIO_PORT:
 		outb(value, port->iobase + offset);
-- 
2.7.0
