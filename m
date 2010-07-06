From: Richard =?ISO-8859-1?Q?R=F6jfors?=
	<richard.rojfors@pelagicore.com>
Subject: [PATCH] timbuart: Use __devinit and __devexit macros for probe and
 remove
Date: Tue, 06 Jul 2010 09:52:04 +0200
Message-ID: <1278402724.18630.3.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:49920 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab0GFIPf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Jul 2010 04:15:35 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id C84DAD487
	for <linux-serial@vger.kernel.org>; Tue,  6 Jul 2010 09:52:05 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org

This patch moves the probe and remove functions to the devinit and deve=
xit sections.

Signed-off-by: Richard R=C3=B6jfors <richard.rojfors@pelagicore.com>
---
diff --git a/drivers/serial/timbuart.c b/drivers/serial/timbuart.c
index 67ca642..1f36b7e 100644
--- a/drivers/serial/timbuart.c
+++ b/drivers/serial/timbuart.c
@@ -423,7 +423,7 @@ static struct uart_driver timbuart_driver =3D {
 	.nr =3D 1
 };
=20
-static int timbuart_probe(struct platform_device *dev)
+static int __devinit timbuart_probe(struct platform_device *dev)
 {
 	int err, irq;
 	struct timbuart_port *uart;
@@ -489,7 +489,7 @@ err_mem:
 	return err;
 }
=20
-static int timbuart_remove(struct platform_device *dev)
+static int __devexit timbuart_remove(struct platform_device *dev)
 {
 	struct timbuart_port *uart =3D platform_get_drvdata(dev);
=20
@@ -507,7 +507,7 @@ static struct platform_driver timbuart_platform_dri=
ver =3D {
 		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D timbuart_probe,
-	.remove		=3D timbuart_remove,
+	.remove		=3D __devexit_p(timbuart_remove),
 };
=20
 /*--------------------------------------------------------------------=
------*/

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
