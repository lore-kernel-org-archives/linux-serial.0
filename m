From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors@mocean-labs.com>
Subject: [PATCH] timbuart: Support for beeing probed more than once
Date: Wed, 19 Aug 2009 15:45:42 +0200
Message-ID: <4A8C0206.8040905@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from av7-1-sn3.vrr.skanova.net ([81.228.9.181]:52151 "EHLO
	av7-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbZHSOIU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Aug 2009 10:08:20 -0400
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av7-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 8F9AF383E4
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2009 15:12:24 +0200 (CEST)
Received: from [10.0.1.10] (213-65-251-119-no35.business.telia.com [213.65.251.119])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 1D02937E60
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2009 15:45:42 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

There was a problem in the current implementation where a global static
uart_driver struct was used. The same struct was reused every time the
driver got probed. Since the struct has a state within the serial core
it can not be reused.

A uart_driver struct is added to the timbuart_port struct which is
allocated per platform device.

The probe and remove functions are declared __devinit and __devexit.

Signed-off-by: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com>
---
diff --git a/drivers/serial/timbuart.c b/drivers/serial/timbuart.c
index 063a313..75a741b 100644
--- a/drivers/serial/timbuart.c
+++ b/drivers/serial/timbuart.c
@@ -31,6 +31,7 @@

  struct timbuart_port {
  	struct uart_port	port;
+	struct uart_driver	uart_driver;
  	struct tasklet_struct	tasklet;
  	int			usedma;
  	u32			last_ier;
@@ -410,7 +411,7 @@ static struct uart_ops timbuart_ops =3D {
  	.verify_port =3D timbuart_verify_port
  };

-static struct uart_driver timbuart_driver =3D {
+static const __devinitconst struct uart_driver timbuart_driver_templat=
e =3D {
  	.owner =3D THIS_MODULE,
  	.driver_name =3D "timberdale_uart",
  	.dev_name =3D "ttyTU",
@@ -419,7 +420,7 @@ static struct uart_driver timbuart_driver =3D {
  	.nr =3D 1
  };

-static int timbuart_probe(struct platform_device *dev)
+static int __devinit timbuart_probe(struct platform_device *dev)
  {
  	int err;
  	struct timbuart_port *uart;
@@ -433,6 +434,8 @@ static int timbuart_probe(struct platform_device *d=
ev)
  		goto err_mem;
  	}

+	uart->uart_driver =3D timbuart_driver_template;
+
  	uart->usedma =3D 0;

  	uart->port.uartclk =3D 3250000 * 16;
@@ -461,11 +464,11 @@ static int timbuart_probe(struct platform_device =
*dev)

  	tasklet_init(&uart->tasklet, timbuart_tasklet, (unsigned long)uart);

-	err =3D uart_register_driver(&timbuart_driver);
+	err =3D uart_register_driver(&uart->uart_driver);
  	if (err)
  		goto err_register;

-	err =3D uart_add_one_port(&timbuart_driver, &uart->port);
+	err =3D uart_add_one_port(&uart->uart_driver, &uart->port);
  	if (err)
  		goto err_add_port;

@@ -474,7 +477,7 @@ static int timbuart_probe(struct platform_device *d=
ev)
  	return 0;

  err_add_port:
-	uart_unregister_driver(&timbuart_driver);
+	uart_unregister_driver(&uart->uart_driver);
  err_register:
  	kfree(uart);
  err_mem:
@@ -484,13 +487,13 @@ err_mem:
  	return err;
  }

-static int timbuart_remove(struct platform_device *dev)
+static int __devexit timbuart_remove(struct platform_device *dev)
  {
  	struct timbuart_port *uart =3D platform_get_drvdata(dev);

  	tasklet_kill(&uart->tasklet);
-	uart_remove_one_port(&timbuart_driver, &uart->port);
-	uart_unregister_driver(&timbuart_driver);
+	uart_remove_one_port(&uart->uart_driver, &uart->port);
+	uart_unregister_driver(&uart->uart_driver);
  	kfree(uart);

  	return 0;
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
