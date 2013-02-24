From: Jonas Gorski <jogo@openwrt.org>
Subject: [PATCH] serial: bcm63xx_uart: fix compilation after "TTY: switch tty_insert_flip_char"
Date: Sun, 24 Feb 2013 14:08:39 +0100
Message-ID: <1361711319-15825-1-git-send-email-jogo@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:47905 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755868Ab3BXNJT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 24 Feb 2013 08:09:19 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Maxime Bizon <mbizon@freebox.fr>, Florian Fainelli <florian@openwrt.org>, Kevin Cernekee <cernekee@gmail.com>

92a19f9cec9a80ad93c06e115822deb729e2c6ad introduced a local variable
with the same name as the argument to bcm_uart_do_rx, breaking
compilation. Fix this by renaming the new variable and its uses where
expected.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
Based on git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

 drivers/tty/serial/bcm63xx_uart.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 719594e..52a3ecd 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -235,7 +235,7 @@ static const char *bcm_uart_type(struct uart_port *port)
  */
 static void bcm_uart_do_rx(struct uart_port *port)
 {
-	struct tty_port *port = &port->state->port;
+	struct tty_port *tty_port = &port->state->port;
 	unsigned int max_count;
 
 	/* limit number of char read in interrupt, should not be
@@ -260,7 +260,7 @@ static void bcm_uart_do_rx(struct uart_port *port)
 			bcm_uart_writel(port, val, UART_CTL_REG);
 
 			port->icount.overrun++;
-			tty_insert_flip_char(port, 0, TTY_OVERRUN);
+			tty_insert_flip_char(tty_port, 0, TTY_OVERRUN);
 		}
 
 		if (!(iestat & UART_IR_STAT(UART_IR_RXNOTEMPTY)))
@@ -299,11 +299,11 @@ static void bcm_uart_do_rx(struct uart_port *port)
 
 
 		if ((cstat & port->ignore_status_mask) == 0)
-			tty_insert_flip_char(port, c, flag);
+			tty_insert_flip_char(tty_port, c, flag);
 
 	} while (--max_count);
 
-	tty_flip_buffer_push(port);
+	tty_flip_buffer_push(tty_port);
 }
 
 /*
-- 
1.7.10.4

