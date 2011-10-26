From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 09/79] serial:blackfin: Correct coding style in bfin serial driver.
Date: Wed, 26 Oct 2011 14:12:14 +0200
Message-ID: <1319631204-23262-9-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60930 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab1JZMNb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:31 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Sonic Zhang <sonic.zhang@analog.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Sonic Zhang <sonic.zhang@analog.com>

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/bfin_5xx.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/bfin_5xx.c b/drivers/tty/serial/bfin_5xx.c
index ff69791..e08bc04 100644
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
1.7.7

