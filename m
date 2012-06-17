From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/2] serial/amba-pl011: fix ages old copy-paste errors
Date: Sun, 17 Jun 2012 15:44:19 +0200
Message-ID: <1339940659-6882-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:58085 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757204Ab2FQNol (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Jun 2012 09:44:41 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

From: Linus Walleij <linus.walleij@linaro.org>

The PL011 driver has a number of symbols referring to "pl01x"
(probably once shared with the pl010 driver) and some even named
"pl010" (probably a pure copy-paste artifact). Lets name all
local static functions with the prefix pl011_* for clarity.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3ce984f..5aa080a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1215,14 +1215,14 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
-static unsigned int pl01x_tx_empty(struct uart_port *port)
+static unsigned int pl011_tx_empty(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int status = readw(uap->port.membase + UART01x_FR);
 	return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
 }
 
-static unsigned int pl01x_get_mctrl(struct uart_port *port)
+static unsigned int pl011_get_mctrl(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int result = 0;
@@ -1285,7 +1285,7 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
-static int pl010_get_poll_char(struct uart_port *port)
+static int pl011_get_poll_char(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int status;
@@ -1297,7 +1297,7 @@ static int pl010_get_poll_char(struct uart_port *port)
 	return readw(uap->port.membase + UART01x_DR);
 }
 
-static void pl010_put_poll_char(struct uart_port *port,
+static void pl011_put_poll_char(struct uart_port *port,
 			 unsigned char ch)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
@@ -1637,7 +1637,7 @@ static const char *pl011_type(struct uart_port *port)
 /*
  * Release the memory region(s) being used by 'port'
  */
-static void pl010_release_port(struct uart_port *port)
+static void pl011_release_port(struct uart_port *port)
 {
 	release_mem_region(port->mapbase, SZ_4K);
 }
@@ -1645,7 +1645,7 @@ static void pl010_release_port(struct uart_port *port)
 /*
  * Request the memory region(s) being used by 'port'
  */
-static int pl010_request_port(struct uart_port *port)
+static int pl011_request_port(struct uart_port *port)
 {
 	return request_mem_region(port->mapbase, SZ_4K, "uart-pl011")
 			!= NULL ? 0 : -EBUSY;
@@ -1654,18 +1654,18 @@ static int pl010_request_port(struct uart_port *port)
 /*
  * Configure/autoconfigure the port.
  */
-static void pl010_config_port(struct uart_port *port, int flags)
+static void pl011_config_port(struct uart_port *port, int flags)
 {
 	if (flags & UART_CONFIG_TYPE) {
 		port->type = PORT_AMBA;
-		pl010_request_port(port);
+		pl011_request_port(port);
 	}
 }
 
 /*
  * verify the new serial_struct (for TIOCSSERIAL).
  */
-static int pl010_verify_port(struct uart_port *port, struct serial_struct *ser)
+static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	int ret = 0;
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_AMBA)
@@ -1678,9 +1678,9 @@ static int pl010_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 static struct uart_ops amba_pl011_pops = {
-	.tx_empty	= pl01x_tx_empty,
+	.tx_empty	= pl011_tx_empty,
 	.set_mctrl	= pl011_set_mctrl,
-	.get_mctrl	= pl01x_get_mctrl,
+	.get_mctrl	= pl011_get_mctrl,
 	.stop_tx	= pl011_stop_tx,
 	.start_tx	= pl011_start_tx,
 	.stop_rx	= pl011_stop_rx,
@@ -1691,13 +1691,13 @@ static struct uart_ops amba_pl011_pops = {
 	.flush_buffer	= pl011_dma_flush_buffer,
 	.set_termios	= pl011_set_termios,
 	.type		= pl011_type,
-	.release_port	= pl010_release_port,
-	.request_port	= pl010_request_port,
-	.config_port	= pl010_config_port,
-	.verify_port	= pl010_verify_port,
+	.release_port	= pl011_release_port,
+	.request_port	= pl011_request_port,
+	.config_port	= pl011_config_port,
+	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
-	.poll_get_char = pl010_get_poll_char,
-	.poll_put_char = pl010_put_poll_char,
+	.poll_get_char = pl011_get_poll_char,
+	.poll_put_char = pl011_put_poll_char,
 #endif
 };
 
-- 
1.7.9.2

