From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 1/2 v3] serial: bfin-uart: Enable hardware automatic CTS only when CTS pin is available.
Date: Tue, 13 Dec 2011 12:22:01 +0800
Message-ID: <1323750122-17698-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:15955
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752551Ab1LME3S (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Dec 2011 23:29:18 -0500
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
index abac237..dedd9ab 100644
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
+			dev_info(port->dev, "Unable to attach BlackFin UART Modem Status interrupt.\n");
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


