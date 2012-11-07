From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] serial: bfin_uart: Don't switch baud rate untill the transfer buffer is empty.
Date: Wed, 7 Nov 2012 12:55:42 +0800
Message-ID: <1352264142-30771-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:46660
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750747Ab2KGE4m (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Nov 2012 23:56:42 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

set_termios may be invoked before the former data transfer is completed. Block until the
tranfer is done.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_uart.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 9242d56..71c0c09 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -869,6 +869,10 @@ bfin_serial_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	UART_SET_ANOMALY_THRESHOLD(uart, USEC_PER_SEC / baud * 15);
 
+	/* Wait till the transfer buffer is empty */
+	while (UART_GET_GCTL(uart) & UCEN && !(UART_GET_LSR(uart) & TEMT))
+		barrier();
+
 	/* Disable UART */
 	ier = UART_GET_IER(uart);
 	UART_PUT_GCTL(uart, UART_GET_GCTL(uart) & ~UCEN);
-- 
1.7.0.4


