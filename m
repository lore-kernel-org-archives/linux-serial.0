From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 2/3] serial: 8250_early: confirm empty transmitter after sending characters
Date: Fri, 30 Oct 2015 11:39:04 +0900
Message-ID: <1446172745-5115-3-git-send-email-yamada.masahiro@socionext.com>
References: <1446172745-5115-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446172745-5115-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

The current code waits until the transmitter becomes empty,
before sending each character, and after finishing the whole string.
This seems a bit redundant.

It can be more efficient by checking the transmitter only after sending
each character.  This should be safe because the transmitter is already
empty at the first entry of serial_putc().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_early.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 23c322f..0b65a26 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -90,8 +90,8 @@ static void __init wait_for_xmitr(struct uart_port *port)
 
 static void __init serial_putc(struct uart_port *port, int c)
 {
-	wait_for_xmitr(port);
 	serial8250_early_out(port, UART_TX, c);
+	wait_for_xmitr(port);
 }
 
 static void __init early_serial8250_write(struct console *console,
@@ -101,9 +101,6 @@ static void __init early_serial8250_write(struct console *console,
 	struct uart_port *port = &device->port;
 
 	uart_console_write(port, s, count, serial_putc);
-
-	/* Wait for transmitter to become empty */
-	wait_for_xmitr(port);
 }
 
 static void __init init_port(struct earlycon_device *device)
-- 
1.9.1
