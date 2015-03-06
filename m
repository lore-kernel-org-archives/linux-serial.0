From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 13/14] serial: 8250_early: Use port->regshift
Date: Fri,  6 Mar 2015 14:25:29 -0500
Message-ID: <1425669930-22137-14-git-send-email-peter@hurleysoftware.com>
References: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
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
index a2b4e58..53db31c 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -38,11 +38,13 @@
 
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
@@ -52,12 +54,14 @@ unsigned int __weak __init serial8250_early_in(struct uart_port *port, int offse
 
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
2.3.1
