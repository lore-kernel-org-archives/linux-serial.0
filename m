From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 1/2 v2] serial: bfin-uart: Enable hardware automatic CTS only when CTS pin is available.
Date: Mon, 12 Dec 2011 14:59:50 +0800
Message-ID: <1323673191-9210-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:9950 "EHLO
	VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab1LLHHL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Dec 2011 02:07:11 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_uart.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index abac237..a6c1c08 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -726,16 +726,17 @@ static int bfin_serial_startup(struct uart_port *port)
 	}
 #endif
 #ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
-	if (uart->cts_pin >= 0 && request_irq(uart->status_irq,
-		bfin_serial_mctrl_cts_int,
-		0, "BFIN_UART_MODEM_STATUS", uart)) {
-		uart->cts_pin = -1;
-		pr_info("Unable to attach BlackFin UART Modem Status interrupt.\n");
-	}
+	if (uart->cts_pin >= 0) {
+		if (request_irq(uart->status_irq, bfin_serial_mctrl_cts_int,
+			IRQF_DISABLED, "BFIN_UART_MODEM_STATUS", uart)) {
+			uart->cts_pin = -1;
+			pr_info("Unable to attach BlackFin UART Modem Status interrupt.\n");
+		}
 
-	/* CTS RTS PINs are negative assertive. */
-	UART_PUT_MCR(uart, ACTS);
-	UART_SET_IER(uart, EDSSI);
+		/* CTS RTS PINs are negative assertive. */
+		UART_PUT_MCR(uart, ACTS);
+		UART_SET_IER(uart, EDSSI);
+	}
 #endif
 
 	UART_SET_IER(uart, ERBFI);
-- 
1.7.0.4


