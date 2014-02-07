From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 2/8] tty/serial: at91: remove unused open/close hooks
Date: Fri,  7 Feb 2014 15:59:09 +0100
Message-ID: <1391785155-18525-3-git-send-email-richard.genoud@gmail.com>
References: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:54035 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbaBGPAQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 10:00:16 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn9so916386wib.12
        for <linux-serial@vger.kernel.org>; Fri, 07 Feb 2014 07:00:14 -0800 (PST)
In-Reply-To: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

commit 95e629b761ce36996d1befe2824d5346b5a220b9 removed the use of board
specific hooks in serial_at91.h, so now, the open/close hook are just
dead code.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index ed9621a21d67..a51b3a762948 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -112,9 +112,6 @@ static void atmel_stop_rx(struct uart_port *port);
 #define UART_PUT_TCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_TCR)
 #define UART_GET_TCR(port)	__raw_readl((port)->membase + ATMEL_PDC_TCR)
 
-static int (*atmel_open_hook)(struct uart_port *);
-static void (*atmel_close_hook)(struct uart_port *);
-
 struct atmel_dma_buffer {
 	unsigned char	*buf;
 	dma_addr_t	dma_addr;
@@ -1569,17 +1566,6 @@ static int atmel_startup(struct uart_port *port)
 		if (retval < 0)
 			atmel_set_ops(port);
 	}
-	/*
-	 * If there is a specific "open" function (to register
-	 * control line interrupts)
-	 */
-	if (atmel_open_hook) {
-		retval = atmel_open_hook(port);
-		if (retval) {
-			free_irq(port->irq, port);
-			return retval;
-		}
-	}
 
 	/* Save current CSR for comparison in atmel_tasklet_func() */
 	atmel_port->irq_status_prev = UART_GET_CSR(port);
@@ -1678,13 +1664,6 @@ static void atmel_shutdown(struct uart_port *port)
 	 * Free the interrupt
 	 */
 	free_irq(port->irq, port);
-
-	/*
-	 * If there is a specific "close" function (to unregister
-	 * control line interrupts)
-	 */
-	if (atmel_close_hook)
-		atmel_close_hook(port);
 }
 
 /*
-- 
1.8.5

