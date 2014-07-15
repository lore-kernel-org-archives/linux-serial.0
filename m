From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] serial: altera_jtaguart: Adpot uart_console_write()
Date: Tue, 15 Jul 2014 17:26:48 +0200
Message-ID: <1405438008-27020-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:43349 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755931AbaGOP0y (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jul 2014 11:26:54 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org, Daniel Thompson <daniel.thompson@linaro.org>

Follow commit 2970b7f5ea3c ("serial: altera: Adopt
uart_console_write()") and don't open code the LF to LFCR conversion in
altera_jtaguart either. Use uart_console_write() instead.

Cc: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_jtaguart.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index e7d1aaf..afe2e75 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -304,7 +304,7 @@ static struct altera_jtaguart altera_jtaguart_ports[ALTERA_JTAGUART_MAXPORTS];
 #if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE)
 
 #if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS)
-static void altera_jtaguart_console_putc(struct console *co, const char c)
+static void altera_jtaguart_console_putc(struct console *co, int c)
 {
 	struct uart_port *port = &(altera_jtaguart_ports + co->index)->port;
 	unsigned long status;
@@ -325,7 +325,7 @@ static void altera_jtaguart_console_putc(struct console *co, const char c)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 #else
-static void altera_jtaguart_console_putc(struct console *co, const char c)
+static void altera_jtaguart_console_putc(struct console *co, int c)
 {
 	struct uart_port *port = &(altera_jtaguart_ports + co->index)->port;
 	unsigned long flags;
@@ -345,11 +345,9 @@ static void altera_jtaguart_console_putc(struct console *co, const char c)
 static void altera_jtaguart_console_write(struct console *co, const char *s,
 					  unsigned int count)
 {
-	for (; count; count--, s++) {
-		altera_jtaguart_console_putc(co, *s);
-		if (*s == '\n')
-			altera_jtaguart_console_putc(co, '\r');
-	}
+	struct uart_port *port = &(altera_jtaguart_ports + co->index)->port;
+
+	uart_console_write(port, s, count, altera_jtaguart_console_putc);
 }
 
 static int __init altera_jtaguart_console_setup(struct console *co,
-- 
2.0.1


