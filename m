From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] earlycon: Fix uart_parse_earlycon() if !CONFIG_SERIAL_CORE_CONSOLE
Date: Sat, 11 Apr 2015 10:42:36 -0400
Message-ID: <1428763356-29158-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alim Akhtar <alim.akhtar@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, tfiga@google.com, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Arnd Bergmann wrote:
> A configuration that enables earlycon but not the core console
> code causes a link error:
>
> drivers/built-in.o: In function `setup_earlycon':
> drivers/tty/serial/earlycon.c:70: undefined reference to `uart_parse_earlycon'

CONFIG_SERIAL_EARLYCON should not require CONFIG_SERIAL_CORE_CONSOLE.
Move uart_parse_earlycon() and compile if either CONFIG_SERIAL_CORE_CONSOLE
or CONFIG_SERIAL_EARLYCON.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---

NB: The diff moves everything else around uart_parse_earlycon() :/

 drivers/tty/serial/serial_core.c | 90 ++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index eec067d..4d42b13 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1762,50 +1762,7 @@ static const struct file_operations uart_proc_fops = {
 };
 #endif
 
-#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
-/**
- *	uart_console_write - write a console message to a serial port
- *	@port: the port to write the message
- *	@s: array of characters
- *	@count: number of characters in string to write
- *	@putchar: function to write character to port
- */
-void uart_console_write(struct uart_port *port, const char *s,
-			unsigned int count,
-			void (*putchar)(struct uart_port *, int))
-{
-	unsigned int i;
-
-	for (i = 0; i < count; i++, s++) {
-		if (*s == '\n')
-			putchar(port, '\r');
-		putchar(port, *s);
-	}
-}
-EXPORT_SYMBOL_GPL(uart_console_write);
-
-/*
- *	Check whether an invalid uart number has been specified, and
- *	if so, search for the first available port that does have
- *	console support.
- */
-struct uart_port * __init
-uart_get_console(struct uart_port *ports, int nr, struct console *co)
-{
-	int idx = co->index;
-
-	if (idx < 0 || idx >= nr || (ports[idx].iobase == 0 &&
-				     ports[idx].membase == NULL))
-		for (idx = 0; idx < nr; idx++)
-			if (ports[idx].iobase != 0 ||
-			    ports[idx].membase != NULL)
-				break;
-
-	co->index = idx;
-
-	return ports + idx;
-}
-
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_SERIAL_EARLYCON)
 /**
  *	uart_parse_earlycon - Parse earlycon options
  *	@p:	  ptr to 2nd field (ie., just beyond '<name>,')
@@ -1851,6 +1808,51 @@ int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_parse_earlycon);
+#endif
+
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
+/**
+ *	uart_console_write - write a console message to a serial port
+ *	@port: the port to write the message
+ *	@s: array of characters
+ *	@count: number of characters in string to write
+ *	@putchar: function to write character to port
+ */
+void uart_console_write(struct uart_port *port, const char *s,
+			unsigned int count,
+			void (*putchar)(struct uart_port *, int))
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++, s++) {
+		if (*s == '\n')
+			putchar(port, '\r');
+		putchar(port, *s);
+	}
+}
+EXPORT_SYMBOL_GPL(uart_console_write);
+
+/*
+ *	Check whether an invalid uart number has been specified, and
+ *	if so, search for the first available port that does have
+ *	console support.
+ */
+struct uart_port * __init
+uart_get_console(struct uart_port *ports, int nr, struct console *co)
+{
+	int idx = co->index;
+
+	if (idx < 0 || idx >= nr || (ports[idx].iobase == 0 &&
+				     ports[idx].membase == NULL))
+		for (idx = 0; idx < nr; idx++)
+			if (ports[idx].iobase != 0 ||
+			    ports[idx].membase != NULL)
+				break;
+
+	co->index = idx;
+
+	return ports + idx;
+}
 
 /**
  *	uart_parse_options - Parse serial port baud/parity/bits/flow control.
-- 
2.3.5
