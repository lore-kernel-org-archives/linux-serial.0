From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 12/13] serial: 8250_early: Use port->regshift
Date: Wed,  8 Apr 2015 13:45:18 -0400
Message-ID: <1428515119-25248-13-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

earlycon initializes struct uart_port::regshift to the correct
value for UPIO_MEM32 already. Use the port field rather than
hard-coded value.

This enables broader support for various i/o access methods in
8250 earlycon (eg., omap8250 earlycon).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_early.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 8e11968..1b5aca3 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -37,11 +37,13 @@
 
 unsigned int __weak __init serial8250_early_in(struct uart_port *port, int offset)
 {
+	offset <<= port->regshift;
+
 	switch (port->iotype) {
 	case UPIO_MEM:
 		return readb(port->membase + offset);
 	case UPIO_MEM32:
-		return readl(port->membase + (offset << 2));
+		return readl(port->membase + offset);
 	case UPIO_PORT:
 		return inb(port->iobase + offset);
 	default:
@@ -51,12 +53,14 @@ unsigned int __weak __init serial8250_early_in(struct uart_port *port, int offse
 
 void __weak __init serial8250_early_out(struct uart_port *port, int offset, int value)
 {
+	offset <<= port->regshift;
+
 	switch (port->iotype) {
 	case UPIO_MEM:
 		writeb(value, port->membase + offset);
 		break;
 	case UPIO_MEM32:
-		writel(value, port->membase + (offset << 2));
+		writel(value, port->membase + offset);
 		break;
 	case UPIO_PORT:
 		outb(value, port->iobase + offset);
-- 
2.3.5
