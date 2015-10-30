From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 3/3] serial: 8250_early: squash wait_for_xmitr() into serial_putc()
Date: Fri, 30 Oct 2015 11:39:05 +0900
Message-ID: <1446172745-5115-4-git-send-email-yamada.masahiro@socionext.com>
References: <1446172745-5115-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446172745-5115-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Now, wait_for_xmitr() is only called from serial_putc(), and both
are short enough.  They can be merged into a single function.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_early.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 0b65a26..f9e25ed 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -76,24 +76,20 @@ static void __init serial8250_early_out(struct uart_port *port, int offset, int
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
-static void __init wait_for_xmitr(struct uart_port *port)
+static void __init serial_putc(struct uart_port *port, int c)
 {
 	unsigned int status;
 
+	serial8250_early_out(port, UART_TX, c);
+
 	for (;;) {
 		status = serial8250_early_in(port, UART_LSR);
 		if ((status & BOTH_EMPTY) == BOTH_EMPTY)
-			return;
+			break;
 		cpu_relax();
 	}
 }
 
-static void __init serial_putc(struct uart_port *port, int c)
-{
-	serial8250_early_out(port, UART_TX, c);
-	wait_for_xmitr(port);
-}
-
 static void __init early_serial8250_write(struct console *console,
 					const char *s, unsigned int count)
 {
-- 
1.9.1
