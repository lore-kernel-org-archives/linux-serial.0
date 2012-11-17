From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH] serial: atmel_serial: remove atmel open/close hooks
Date: Sat, 17 Nov 2012 01:09:16 +0100
Message-ID: <1353110956-17541-1-git-send-email-manabian@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:36678 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab2KQAKF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 19:10:05 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so2536953lag.19
        for <linux-serial@vger.kernel.org>; Fri, 16 Nov 2012 16:10:04 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux@arm.linux.org.uk, gregkh@linuxfoundation.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, avictor.za@gmail.com, alan@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

After serial_at91.h was removed the atmel_open/close_hook
code is now useless.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi,

This patch depends on [RFC 3/3] ARM/AVR32: get rid of serial_at91.h
patch from Russell King.

Patch based on current linux-next with "[RFC 3/3] ARM/AVR32: get rid of serial_at91.h"
patch on top. There is a small conflict with Russell's patch
in next now due to another header change.

If there is another tree this patch should be based on please
let me know.

regards
Joachim Eastwood

 drivers/tty/serial/atmel_serial.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 76e4c05..5c2337d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -113,9 +113,6 @@ static void atmel_stop_rx(struct uart_port *port);
 #define UART_PUT_TCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_TCR)
 #define UART_GET_TCR(port)	__raw_readl((port)->membase + ATMEL_PDC_TCR)
 
-static int (*atmel_open_hook)(struct uart_port *);
-static void (*atmel_close_hook)(struct uart_port *);
-
 struct atmel_dma_buffer {
 	unsigned char	*buf;
 	dma_addr_t	dma_addr;
@@ -976,18 +973,6 @@ static int atmel_startup(struct uart_port *port)
 		pdc->ofs = 0;
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
-
 	/* Save current CSR for comparison in atmel_tasklet_func() */
 	atmel_port->irq_status_prev = UART_GET_CSR(port);
 	atmel_port->irq_status = atmel_port->irq_status_prev;
@@ -1062,13 +1047,6 @@ static void atmel_shutdown(struct uart_port *port)
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
1.8.0

