From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v3 3/7] tty/serial: at91: remove unused open/close hooks
Date: Mon, 17 Feb 2014 17:57:23 +0100
Message-ID: <1392656247-3351-4-git-send-email-richard.genoud@gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:58047 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbaBQQ6F (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Feb 2014 11:58:05 -0500
Received: by mail-we0-f177.google.com with SMTP id t61so10684574wes.22
        for <linux-serial@vger.kernel.org>; Mon, 17 Feb 2014 08:58:04 -0800 (PST)
In-Reply-To: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

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

