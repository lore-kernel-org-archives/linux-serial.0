From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 1/2 v2] serial: bfin_uart: Don't switch baud rate untill the transfer buffer is empty.
Date: Mon, 19 Nov 2012 14:40:56 +0800
Message-ID: <1353307256-25676-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:14836
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751365Ab2KSGmW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Nov 2012 01:42:22 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

set_termios may be invoked before the former data transfer is completed. Block until the
tranfer is done.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_uart.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 9242d56..f8dc8f1 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -800,6 +800,7 @@ bfin_serial_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long flags;
 	unsigned int baud, quot;
 	unsigned int ier, lcr = 0;
+	unsigned long timeout;
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS8:
@@ -869,6 +870,14 @@ bfin_serial_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	UART_SET_ANOMALY_THRESHOLD(uart, USEC_PER_SEC / baud * 15);
 
+	/* Wait till the transfer buffer is empty */
+	timeout = jiffies + msecs_to_jiffies(10);
+	while (UART_GET_GCTL(uart) & UCEN && !(UART_GET_LSR(uart) & TEMT))
+		if (time_after(jiffies, timeout)) {
+			dev_warn(port->dev, "timeout waiting for TX buffer empty\n");
+			break;
+		}
+
 	/* Disable UART */
 	ier = UART_GET_IER(uart);
 	UART_PUT_GCTL(uart, UART_GET_GCTL(uart) & ~UCEN);
-- 
1.7.0.4


