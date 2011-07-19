From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 1/2] serial:blackfin: Correct coding style in bfin serial driver.
Date: Tue, 19 Jul 2011 18:09:24 +0800
Message-ID: <1311070165-29402-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:2769
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061Ab1GSKP3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Jul 2011 06:15:29 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_5xx.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/bfin_5xx.c b/drivers/tty/serial/bfin_5xx.c
index 9b1ff2b..6981e2a 100644
--- a/drivers/tty/serial/bfin_5xx.c
+++ b/drivers/tty/serial/bfin_5xx.c
@@ -234,8 +234,8 @@ static void bfin_serial_rx_chars(struct bfin_serial_port *uart)
 	status = UART_GET_LSR(uart);
 	UART_CLEAR_LSR(uart);
 
- 	ch = UART_GET_CHAR(uart);
- 	uart->port.icount.rx++;
+	ch = UART_GET_CHAR(uart);
+	uart->port.icount.rx++;
 
 #if defined(CONFIG_KGDB_SERIAL_CONSOLE) || \
 	defined(CONFIG_KGDB_SERIAL_CONSOLE_MODULE)
@@ -739,9 +739,8 @@ static int bfin_serial_startup(struct uart_port *port)
 			pr_info("Unable to attach BlackFin UART CTS interrupt. So, disable it.\n");
 		}
 	}
-	if (uart->rts_pin >= 0) {
+	if (uart->rts_pin >= 0)
 		gpio_direction_output(uart->rts_pin, 0);
-	}
 #endif
 #ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
 	if (uart->cts_pin >= 0 && request_irq(uart->status_irq,
@@ -1091,10 +1090,18 @@ bfin_serial_console_get_options(struct bfin_serial_port *uart, int *baud,
 				*parity = 'o';
 		}
 		switch (lcr & 0x03) {
-			case 0:	*bits = 5; break;
-			case 1:	*bits = 6; break;
-			case 2:	*bits = 7; break;
-			case 3:	*bits = 8; break;
+		case 0:
+			*bits = 5;
+			break;
+		case 1:
+			*bits = 6;
+			break;
+		case 2:
+			*bits = 7;
+			break;
+		case 3:
+			*bits = 8;
+			break;
 		}
 		/* Set DLAB in LCR to Access DLL and DLH */
 		UART_SET_DLAB(uart);
@@ -1183,7 +1190,7 @@ static struct console bfin_serial_console = {
 	.index		= -1,
 	.data		= &bfin_serial_reg,
 };
-#define BFIN_SERIAL_CONSOLE	&bfin_serial_console
+#define BFIN_SERIAL_CONSOLE	(&bfin_serial_console)
 #else
 #define BFIN_SERIAL_CONSOLE	NULL
 #endif /* CONFIG_SERIAL_BFIN_CONSOLE */
-- 
1.7.0.4


