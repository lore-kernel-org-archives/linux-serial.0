From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] serial/arc: Fix warning with CONSOLE_POLL
Date: Fri, 11 Jul 2014 18:31:37 +0530
Message-ID: <1405083697-10719-1-git-send-email-vgupta@synopsys.com>
References: <53bf1d9a.l51qTAII/GCO14wJ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.44.111]:36760 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbaGKNDz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jul 2014 09:03:55 -0400
In-Reply-To: <53bf1d9a.l51qTAII/GCO14wJ%fengguang.wu@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>

| drivers/tty/serial/arc_uart.c:516:2: warning: (near initialization for 'arc_serial_pops.poll_put_char') [enabled by default]

This partially undoes "serial/arc: use uart_console_write() helper" by
restoring the prototpye of poll helper and use a different one in
uart_console_write()

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 drivers/tty/serial/arc_uart.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index d9900cb3e7b6..750638fc8a4a 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -449,18 +449,16 @@ static void arc_serial_config_port(struct uart_port *port, int flags)
 		port->type = PORT_ARC;
 }
 
-#if defined(CONFIG_CONSOLE_POLL) || defined(CONFIG_SERIAL_ARC_CONSOLE)
+#ifdef CONFIG_CONSOLE_POLL
 
-static void arc_serial_poll_putchar(struct uart_port *port, int chr)
+static void arc_serial_poll_putchar(struct uart_port *port, unsigned char chr)
 {
 	while (!(UART_GET_STATUS(port) & TXEMPTY))
 		cpu_relax();
 
-	UART_SET_DATA(port, (unsigned char)chr);
+	UART_SET_DATA(port, chr);
 }
-#endif
 
-#ifdef CONFIG_CONSOLE_POLL
 static int arc_serial_poll_getchar(struct uart_port *port)
 {
 	unsigned char chr;
@@ -527,6 +525,14 @@ static int arc_serial_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
+static void arc_serial_console_putchar(struct uart_port *port, int ch)
+{
+	while (!(UART_GET_STATUS(port) & TXEMPTY))
+		cpu_relax();
+
+	UART_SET_DATA(port, (unsigned char)ch);
+}
+
 /*
  * Interrupts are disabled on entering
  */
@@ -537,7 +543,7 @@ static void arc_serial_console_write(struct console *co, const char *s,
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	uart_console_write(port, s, count, arc_serial_poll_putchar);
+	uart_console_write(port, s, count, arc_serial_console_putchar);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -556,7 +562,7 @@ static __init void arc_early_serial_write(struct console *con, const char *s,
 {
 	struct earlycon_device *dev = con->data;
 
-	uart_console_write(&dev->port, s, n, arc_serial_poll_putchar);
+	uart_console_write(&dev->port, s, n, arc_serial_console_putchar);
 }
 
 static int __init arc_early_console_setup(struct earlycon_device *dev,
-- 
1.8.3.2

