From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: clps711x: Give a chance to perform useful tasks during wait loop
Date: Tue, 11 Mar 2014 15:30:01 +0400
Message-ID: <1394537401-10069-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback1.mail.ru ([94.100.176.18]:55377 "EHLO
	fallback1.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbaCKLbI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Mar 2014 07:31:08 -0400
Received: from smtp3.mail.ru (smtp3.mail.ru [94.100.176.131])
	by fallback1.mail.ru (mPOP.Fallback_MX) with ESMTP id D9D8634F6F3A
	for <linux-serial@vger.kernel.org>; Tue, 11 Mar 2014 15:30:33 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch adds cond_sched() calls during wait loop to perform
other tasks.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index b0eacb8..5e6fdb1 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -368,11 +368,16 @@ static const struct uart_ops uart_clps711x_ops = {
 static void uart_clps711x_console_putchar(struct uart_port *port, int ch)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
-	u32 sysflg = 0;
 
-	do {
+	/* Wait for FIFO is not full */
+	while (1) {
+		u32 sysflg = 0;
+
 		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
-	} while (sysflg & SYSFLG_UTXFF);
+		if (!(sysflg & SYSFLG_UTXFF))
+			break;
+		cond_resched();
+	}
 
 	writew(ch, port->membase + UARTDR_OFFSET);
 }
@@ -382,14 +387,18 @@ static void uart_clps711x_console_write(struct console *co, const char *c,
 {
 	struct uart_port *port = clps711x_uart.state[co->index].uart_port;
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
-	u32 sysflg = 0;
 
 	uart_console_write(port, c, n, uart_clps711x_console_putchar);
 
 	/* Wait for transmitter to become empty */
-	do {
+	while (1) {
+		u32 sysflg = 0;
+
 		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
-	} while (sysflg & SYSFLG_UBUSY);
+		if (!(sysflg & SYSFLG_UBUSY))
+			break;
+		cond_resched();
+	}
 }
 
 static int uart_clps711x_console_setup(struct console *co, char *options)
-- 
1.8.3.2

