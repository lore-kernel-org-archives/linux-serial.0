From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 16/48] serial: altera_uart: Scan for a free port if platform device id is -1
Date: Mon, 23 May 2011 12:10:22 -0700
Message-ID: <1306177854-18172-16-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47291 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTKn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:43 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tobias Klauser <tklauser@distanz.ch>, Anton Vorontsov <cbouatmailru@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tobias Klauser <tklauser@distanz.ch>

Devices extracted from device tree all seem to have pdev->id set to -1.
Up until now we mapped all devices with id -1 to the first device.  This
behaviour could lead to problems when using more than one Altera UART in
a system.

This patch changes the behaviour of the driver to scan for the next free
id in case the id is -1.

Because we cannot refer back to the assigned id in altera_uart_remove,
the port instance needs to be stored in device drvdata.

Reported-by: David Smoot <davidsmoot@gmail.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/altera_uart.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 6d5b036..50bc5a5 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -540,11 +540,14 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
 	int i = pdev->id;
 	int ret;
 
-	/* -1 emphasizes that the platform must have one port, no .N suffix */
-	if (i == -1)
-		i = 0;
+	/* if id is -1 scan for a free id and use that one */
+	if (i == -1) {
+		for (i = 0; i < CONFIG_SERIAL_ALTERA_UART_MAXPORTS; i++)
+			if (altera_uart_ports[i].port.mapbase == 0)
+				break;
+	}
 
-	if (i >= CONFIG_SERIAL_ALTERA_UART_MAXPORTS)
+	if (i < 0 || i >= CONFIG_SERIAL_ALTERA_UART_MAXPORTS)
 		return -EINVAL;
 
 	port = &altera_uart_ports[i].port;
@@ -587,6 +590,8 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
 	port->ops = &altera_uart_ops;
 	port->flags = UPF_BOOT_AUTOCONF;
 
+	dev_set_drvdata(&pdev->dev, port);
+
 	uart_add_one_port(&altera_uart_driver, port);
 
 	return 0;
@@ -594,14 +599,13 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
 
 static int __devexit altera_uart_remove(struct platform_device *pdev)
 {
-	struct uart_port *port;
-	int i = pdev->id;
+	struct uart_port *port = dev_get_drvdata(&pdev->dev);
 
-	if (i == -1)
-		i = 0;
-
-	port = &altera_uart_ports[i].port;
-	uart_remove_one_port(&altera_uart_driver, port);
+	if (port) {
+		uart_remove_one_port(&altera_uart_driver, port);
+		dev_set_drvdata(&pdev->dev, NULL);
+		port->mapbase = 0;
+	}
 
 	return 0;
 }
-- 
1.7.4.2

