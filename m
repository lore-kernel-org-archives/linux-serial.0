From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 04/12] serial: clps711x: Using CPU clock subsystem for getting base UART speed
Date: Sun, 14 Oct 2012 11:05:26 +0400
Message-ID: <1350198334-18737-4-git-send-email-shc_work@mail.ru>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:43987 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHGC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:06:02 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 3b17d19..0884939 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -37,6 +37,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
@@ -58,6 +59,7 @@
 
 struct clps711x_port {
 	struct uart_driver	uart;
+	struct clk		*uart_clk;
 	struct uart_port	port[UART_CLPS711X_NR];
 	int			tx_enabled[UART_CLPS711X_NR];
 #ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
@@ -299,10 +301,9 @@ clps711xuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	termios->c_cflag |= CREAD;
 
-	/*
-	 * Ask the core to calculate the divisor for us.
-	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	/* Ask the core to calculate the divisor for us */
+	baud = uart_get_baud_rate(port, termios, old, port->uartclk / 4096,
+						      port->uartclk / 16);
 	quot = uart_get_divisor(port, baud);
 
 	switch (termios->c_cflag & CSIZE) {
@@ -487,6 +488,13 @@ static int __devinit uart_clps711x_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, s);
 
+	s->uart_clk = devm_clk_get(&pdev->dev, "uart");
+	if (IS_ERR(s->uart_clk)) {
+		dev_err(&pdev->dev, "Can't get UART clocks\n");
+		ret = PTR_ERR(s->uart_clk);
+		goto err_out;
+	}
+
 	s->uart.owner		= THIS_MODULE;
 	s->uart.dev_name	= "ttyCL";
 	s->uart.major		= UART_CLPS711X_MAJOR;
@@ -505,6 +513,7 @@ static int __devinit uart_clps711x_probe(struct platform_device *pdev)
 	ret = uart_register_driver(&s->uart);
 	if (ret) {
 		dev_err(&pdev->dev, "Registering UART driver failed\n");
+		devm_clk_put(&pdev->dev, s->uart_clk);
 		goto err_out;
 	}
 
@@ -516,7 +525,7 @@ static int __devinit uart_clps711x_probe(struct platform_device *pdev)
 		s->port[i].type		= PORT_CLPS711X;
 		s->port[i].fifosize	= 16;
 		s->port[i].flags	= UPF_SKIP_TEST | UPF_FIXED_TYPE;
-		s->port[i].uartclk	= 3686400;
+		s->port[i].uartclk	= clk_get_rate(s->uart_clk);
 		s->port[i].ops		= &uart_clps711x_ops;
 		WARN_ON(uart_add_one_port(&s->uart, &s->port[i]));
 	}
@@ -537,6 +546,7 @@ static int __devexit uart_clps711x_remove(struct platform_device *pdev)
 	for (i = 0; i < UART_CLPS711X_NR; i++)
 		uart_remove_one_port(&s->uart, &s->port[i]);
 
+	devm_clk_put(&pdev->dev, s->uart_clk);
 	uart_unregister_driver(&s->uart);
 	platform_set_drvdata(pdev, NULL);
 
-- 
1.7.8.6

