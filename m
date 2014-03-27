From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] Revert "serial: clps711x: Give a chance to perform useful tasks during wait loop"
Date: Thu, 27 Mar 2014 13:38:19 +0400
Message-ID: <1395913099-30131-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:36519 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbaC0Jkf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Mar 2014 05:40:35 -0400
Received: from smtp2.mail.ru (smtp2.mail.ru [94.100.176.130])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id EFAFD111D79DE
	for <linux-serial@vger.kernel.org>; Thu, 27 Mar 2014 13:38:48 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This reverts commit 63e3ad3252695a2b8c01b6f6c225e4537af08b85,
since this not works as expected and produce runtime error:

BUG: sleeping function called from invalid context at drivers/tty/serial/clps711x.c:379
in_atomic(): 0, irqs_disabled(): 128, pid: 287, name: mount

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 5e6fdb1..14aaea0 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -368,16 +368,12 @@ static const struct uart_ops uart_clps711x_ops = {
 static void uart_clps711x_console_putchar(struct uart_port *port, int ch)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
+	u32 sysflg = 0;
 
 	/* Wait for FIFO is not full */
-	while (1) {
-		u32 sysflg = 0;
-
+	do {
 		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
-		if (!(sysflg & SYSFLG_UTXFF))
-			break;
-		cond_resched();
-	}
+	} while (sysflg & SYSFLG_UTXFF);
 
 	writew(ch, port->membase + UARTDR_OFFSET);
 }
@@ -387,18 +383,14 @@ static void uart_clps711x_console_write(struct console *co, const char *c,
 {
 	struct uart_port *port = clps711x_uart.state[co->index].uart_port;
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
+	u32 sysflg = 0;
 
 	uart_console_write(port, c, n, uart_clps711x_console_putchar);
 
 	/* Wait for transmitter to become empty */
-	while (1) {
-		u32 sysflg = 0;
-
+	do {
 		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
-		if (!(sysflg & SYSFLG_UBUSY))
-			break;
-		cond_resched();
-	}
+	} while (sysflg & SYSFLG_UBUSY);
 }
 
 static int uart_clps711x_console_setup(struct console *co, char *options)
-- 
1.8.3.2

