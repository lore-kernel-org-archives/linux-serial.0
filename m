From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] serial: 8250_dma: no need to set tx_err twice
Date: Thu,  6 Nov 2014 13:28:17 +0200
Message-ID: <1415273297-23323-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1415273297-23323-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53672 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbaKFL2T (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 06:28:19 -0500
In-Reply-To: <1415273297-23323-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

In the serial8250_tx_dma() the tx_err flag is set in case of error. Thus, there
is no need to repeat this in __dma_tx_complete().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index b16f9b1..fcd7ac6 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -39,7 +39,6 @@ static void __dma_tx_complete(void *param)
 
 	ret = serial8250_tx_dma(p);
 	if (ret) {
-		dma->tx_err = 1;
 		p->ier |= UART_IER_THRI;
 		serial_port_out(&p->port, UART_IER, p->ier);
 	}
@@ -93,7 +92,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	}
 
 	dma->tx_running = 1;
-
 	desc->callback = __dma_tx_complete;
 	desc->callback_param = p;
 
-- 
2.1.1

