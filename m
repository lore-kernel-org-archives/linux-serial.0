From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] tty: serial: altera_uart: Check for NULL platform_data in probe.
Date: Thu, 29 Mar 2012 09:55:27 +0200
Message-ID: <1333007727-24045-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:43306 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab2C2IER (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Mar 2012 04:04:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Yuriy Kozlov <ykozlov@ptcusa.com>

From: Yuriy Kozlov <ykozlov@ptcusa.com>

Follow altera_jtag_uart.  This fixes a crash if there is a mistake in the DTS.

Signed-off-by: Yuriy Kozlov <ykozlov@ptcusa.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_uart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index e790375..1f03309 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -556,7 +556,7 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res_mem)
 		port->mapbase = res_mem->start;
-	else if (platp->mapbase)
+	else if (platp)
 		port->mapbase = platp->mapbase;
 	else
 		return -EINVAL;
@@ -564,7 +564,7 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
 	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res_irq)
 		port->irq = res_irq->start;
-	else if (platp->irq)
+	else if (platp)
 		port->irq = platp->irq;
 
 	/* Check platform data first so we can override device node data */
-- 
1.7.5.4

