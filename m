From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 1/2] serial: 8250_early: do not save and restore IER in write callback
Date: Sat, 24 Oct 2015 13:17:44 +0900
Message-ID: <1445660265-13668-2-git-send-email-yamada.masahiro@socionext.com>
References: <1445660265-13668-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445660265-13668-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

The IER has already been masked in early_serial8250_setup(), there is
no reason to save and restore it every time early_serial8250_write()
is called.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_early.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 7aff3d8..559b681 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -99,20 +99,8 @@ static void __init early_serial8250_write(struct console *console,
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
