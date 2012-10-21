From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH] tty: serial: KGDB support for PXA
Date: Sun, 21 Oct 2012 12:00:30 +0800
Message-ID: <1350792031-7189-1-git-send-email-haojian.zhuang@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51564 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab2JUD7Y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Oct 2012 23:59:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1274915pbb.19
        for <linux-serial@vger.kernel.org>; Sat, 20 Oct 2012 20:59:23 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: "Denis V. Lunev" <den@openvz.org>, Marko Katic <dromede@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>

From: "Denis V. Lunev" <den@openvz.org>

Actually, in order to support KGDB over serial console one must
implement two callbacks for character polling. Clone them from
8250 driver with a bit of tuning.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Marko Katic <dromede@gmail.com>
CC: Eric Miao <eric.y.miao@gmail.com>
CC: Russell King <linux@arm.linux.org.uk>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

 drivers/tty/serial/pxa.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)
---
 drivers/tty/serial/pxa.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 9033fc6..2764828 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -705,6 +705,57 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	clk_disable_unprepare(up->clk);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+/*
+ * Console polling routines for writing and reading from the uart while
+ * in an interrupt or debug context.
+ */
+
+static int serial_pxa_get_poll_char(struct uart_port *port)
+{
+	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
+	unsigned char lsr = serial_in(up, UART_LSR);
+
+	while (!(lsr & UART_LSR_DR))
+		lsr = serial_in(up, UART_LSR);
+
+	return serial_in(up, UART_RX);
+}
+
+
+static void serial_pxa_put_poll_char(struct uart_port *port,
+			 unsigned char c)
+{
+	unsigned int ier;
+	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
+
+	/*
+	 *	First save the IER then disable the interrupts
+	 */
+	ier = serial_in(up, UART_IER);
+	serial_out(up, UART_IER, UART_IER_UUE);
+
+	wait_for_xmitr(up);
+	/*
+	 *	Send the character out.
+	 *	If a LF, also do CR...
+	 */
+	serial_out(up, UART_TX, c);
+	if (c == 10) {
+		wait_for_xmitr(up);
+		serial_out(up, UART_TX, 13);
+	}
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore the IER
+	 */
+	wait_for_xmitr(up);
+	serial_out(up, UART_IER, ier);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static int __init
 serial_pxa_console_setup(struct console *co, char *options)
 {
@@ -759,6 +810,10 @@ struct uart_ops serial_pxa_pops = {
 	.request_port	= serial_pxa_request_port,
 	.config_port	= serial_pxa_config_port,
 	.verify_port	= serial_pxa_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char = serial_pxa_get_poll_char,
+	.poll_put_char = serial_pxa_put_poll_char,
+#endif
 };
 
 static struct uart_driver serial_pxa_reg = {
-- 
1.7.9.5

