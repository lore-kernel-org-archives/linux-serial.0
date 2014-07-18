From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] serial: altera_jtaguart: Fix putchar function passed to uart_console_write()
Date: Fri, 18 Jul 2014 08:50:43 +0200
Message-ID: <1405666243-483-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:45053 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756409AbaGRGuq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jul 2014 02:50:46 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org

Commit 3d1c90d48cbe335a ("serial: altera_jtaguart: Adpot
uart_console_write()") introduced the usage of uart_console_write() but
didn't change the signature of altera_jtaguart_console_putc() to take a
pointer to struct uart_port instead of struct console, breaking the
driver's console support and leading to the following warning:

>    drivers/tty/serial/altera_jtaguart.c: In function 'altera_jtaguart_console_write':
> >> drivers/tty/serial/altera_jtaguart.c:350:2: warning: passing argument 4 of 'uart_console_write' from incompatible pointer type [enabled by default]
>      uart_console_write(port, s, count, altera_jtaguart_console_putc);
>      ^
>    In file included from drivers/tty/serial/altera_jtaguart.c:25:0:
>    include/linux/serial_core.h:317:6: note: expected 'void (*)(struct uart_port *, int)' but argument is of type 'void (*)(struct console *, int)'
>     void uart_console_write(struct uart_port *port, const char *s,

Fix this by adjusting the signature of altera_jtaguart_console_putc()
accordingly.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_jtaguart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index afe2e75..d22e3d9 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -304,9 +304,8 @@ static struct altera_jtaguart altera_jtaguart_ports[ALTERA_JTAGUART_MAXPORTS];
 #if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE)
 
 #if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS)
-static void altera_jtaguart_console_putc(struct console *co, int c)
+static void altera_jtaguart_console_putc(struct uart_port *port, int c)
 {
-	struct uart_port *port = &(altera_jtaguart_ports + co->index)->port;
 	unsigned long status;
 	unsigned long flags;
 
@@ -325,9 +324,8 @@ static void altera_jtaguart_console_putc(struct console *co, int c)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 #else
-static void altera_jtaguart_console_putc(struct console *co, int c)
+static void altera_jtaguart_console_putc(struct uart_port *port, int c)
 {
-	struct uart_port *port = &(altera_jtaguart_ports + co->index)->port;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-- 
2.0.1


