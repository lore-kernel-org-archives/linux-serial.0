From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] serial: 8250_early: do not save and restore IER in write callback
Date: Thu, 22 Oct 2015 17:21:40 +0900
Message-ID: <1445502100-10860-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, linux-kernel@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

The IER has already been masked in early_serial8250_setup(), there is
no reason to save and restore it every time early_serial8250_write()
is called.

Let wait_for_xmitr() melt into serial_putc().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_early.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 7aff3d8..19aca19 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -76,21 +76,17 @@ static void __init serial8250_early_out(struct uart_port *port, int offset, int
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
-static void __init wait_for_xmitr(struct uart_port *port)
+static void __init serial_putc(struct uart_port *port, int c)
 {
 	unsigned int status;
 
 	for (;;) {
 		status = serial8250_early_in(port, UART_LSR);
 		if ((status & BOTH_EMPTY) == BOTH_EMPTY)
-			return;
+			break;
 		cpu_relax();
 	}
-}
 
-static void __init serial_putc(struct uart_port *port, int c)
-{
-	wait_for_xmitr(port);
 	serial8250_early_out(port, UART_TX, c);
 }
 
@@ -99,20 +95,8 @@ static void __init early_serial8250_write(struct console *console,
 {
 	struct earlycon_device *device = console->data;
 	struct uart_port *port = &device->port;
-	unsigned int ier;
-
-	/* Save the IER and disable interrupts preserving the UUE bit */
-	ier = serial8250_early_in(port, UART_IER);
-	if (ier)
-		serial8250_early_out(port, UART_IER, ier & UART_IER_UUE);
 
 	uart_console_write(port, s, count, serial_putc);
-
-	/* Wait for transmitter to become empty and restore the IER */
-	wait_for_xmitr(port);
-
-	if (ier)
-		serial8250_early_out(port, UART_IER, ier);
 }
 
 static void __init init_port(struct earlycon_device *device)
-- 
1.9.1
