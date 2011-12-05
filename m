From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] serial: bfin-uart: Request CTS GPIO PIN when the serial device starts up.
Date: Mon, 5 Dec 2011 15:12:50 +0800
Message-ID: <1323069170-5881-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:51044
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751661Ab1LEHUA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Dec 2011 02:20:00 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Serial device may be probed earlier before GPIOLIB is initialized. Requesting and
configuring CTS GPIO PIN fails in that early stage. Do it when the serial device
really starts up.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_uart.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index c7e592d..61af5ae 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -739,8 +739,13 @@ static int bfin_serial_startup(struct uart_port *port)
 			pr_info("Unable to attach BlackFin UART CTS interrupt. So, disable it.\n");
 		}
 	}
-	if (uart->rts_pin >= 0)
-		gpio_direction_output(uart->rts_pin, 0);
+	if (uart->rts_pin >= 0) {
+		if (gpio_request(uart->rts_pin, DRIVER_NAME)) {
+			pr_info("fail to request RTS PIN at GPIO_%d\n", uart->rts_pin);
+			uart->rts_pin = -1;
+		} else
+			gpio_direction_output(uart->rts_pin, 0);
+	}
 #endif
 #ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
 	if (uart->cts_pin >= 0 && request_irq(uart->status_irq,
@@ -792,6 +797,8 @@ static void bfin_serial_shutdown(struct uart_port *port)
 #ifdef CONFIG_SERIAL_BFIN_CTSRTS
 	if (uart->cts_pin >= 0)
 		free_irq(gpio_to_irq(uart->cts_pin), uart);
+	if (uart->rts_pin >= 0)
+		gpio_free(uart->rts_pin);
 #endif
 #ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
 	if (uart->cts_pin >= 0)
@@ -1378,10 +1385,6 @@ static int bfin_serial_probe(struct platform_device *pdev)
 			uart->rts_pin = -1;
 		else
 			uart->rts_pin = res->start;
-# if defined(CONFIG_SERIAL_BFIN_CTSRTS)
-		if (uart->rts_pin >= 0)
-			gpio_request(uart->rts_pin, DRIVER_NAME);
-# endif
 #endif
 	}
 
@@ -1421,10 +1424,6 @@ static int __devexit bfin_serial_remove(struct platform_device *pdev)
 
 	if (uart) {
 		uart_remove_one_port(&bfin_serial_reg, &uart->port);
-#ifdef CONFIG_SERIAL_BFIN_CTSRTS
-		if (uart->rts_pin >= 0)
-			gpio_free(uart->rts_pin);
-#endif
 		iounmap(uart->port.membase);
 		peripheral_free_list(
 			(unsigned short *)pdev->dev.platform_data);
-- 
1.7.0.4


