From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] tty: serial: altera_uart: Use platform_{get,set}_drvdata
Date: Mon, 20 Aug 2012 15:56:34 +0200
Message-ID: <1345470994-15093-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:53545 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756533Ab2HTOFf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Aug 2012 10:05:35 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

Use the wrapper functions, so we can directly pass a struct
platfrom_device.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_uart.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 1f03309..15d80b9 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -591,7 +591,7 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
 	port->ops = &altera_uart_ops;
 	port->flags = UPF_BOOT_AUTOCONF;
 
-	dev_set_drvdata(&pdev->dev, port);
+	platform_set_drvdata(pdev, port);
 
 	uart_add_one_port(&altera_uart_driver, port);
 
@@ -600,11 +600,11 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
 
 static int __devexit altera_uart_remove(struct platform_device *pdev)
 {
-	struct uart_port *port = dev_get_drvdata(&pdev->dev);
+	struct uart_port *port = platform_get_drvdata(pdev);
 
 	if (port) {
 		uart_remove_one_port(&altera_uart_driver, port);
-		dev_set_drvdata(&pdev->dev, NULL);
+		platform_set_drvdata(pdev, NULL);
 		port->mapbase = 0;
 	}
 
-- 
1.7.5.4

