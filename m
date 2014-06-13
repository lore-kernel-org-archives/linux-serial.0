From: Johannes Thumshirn <johannes.thumshirn@men.de>
Subject: [PATCH] tty: serial: men_z135_uart: Wakeup UART after transmitting
Date: Fri, 13 Jun 2014 08:06:06 +0200
Message-ID: <1402639566-15493-1-git-send-email-johannes.thumshirn@men.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.153]:10389 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751653AbaFMGLP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 Jun 2014 02:11:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Jun Shih <Jun.Shih@pason.com>, Johannes Thumshirn <johanes.thumshirn@men.de>, Johannes Thumshirn <johannes.thumshirn@men.de>

From: Johannes Thumshirn <johanes.thumshirn@men.de>

Call uart_write_wakeup() after writing the hardware FIFO and updateing the FIFO
pointers.

This fixes high latency and jitter on PPP over Serial links.

Reported-by: Jun Shih <Jun.Shih@pason.com>
Tested-by: Jun Shih <Jun.Shih@pason.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>
---
 drivers/tty/serial/men_z135_uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index c9d1854..30e9e60 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -308,9 +308,6 @@ static void men_z135_handle_tx(struct men_z135_port *uart)
 	if (port->x_char)
 		goto out;

-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
 	/* calculate bytes to copy */
 	qlen = uart_circ_chars_pending(xmit);
 	if (qlen <= 0)
@@ -357,6 +354,9 @@ static void men_z135_handle_tx(struct men_z135_port *uart)

 	port->icount.tx += n;

+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
 irq_en:
 	if (!uart_circ_empty(xmit))
 		men_z135_reg_set(uart, MEN_Z135_CONF_REG, MEN_Z135_IER_TXCIEN);
--
1.9.1
