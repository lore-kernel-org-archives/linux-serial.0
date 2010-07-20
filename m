From: akpm@linux-foundation.org
Subject: [patch 6/7] timbuart: use __devinit and __devexit macros for probe and remove
Date: Tue, 20 Jul 2010 15:26:53 -0700
Message-ID: <201007202226.o6KMQrG8021538@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41849 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932915Ab0GTWcX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jul 2010 18:32:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, richard.rojfors@pelagicore.com

=46rom: Richard R=F6jfors <richard.rojfors@pelagicore.com>

Move the probe and remove functions to the devinit and devexit sections=
=2E

Signed-off-by: Richard R=F6jfors <richard.rojfors@pelagicore.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/serial/timbuart.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/serial/timbuart.c~timbuart-use-__devinit-and-__devexi=
t-macros-for-probe-and-remove drivers/serial/timbuart.c
--- a/drivers/serial/timbuart.c~timbuart-use-__devinit-and-__devexit-ma=
cros-for-probe-and-remove
+++ a/drivers/serial/timbuart.c
@@ -423,7 +423,7 @@ static struct uart_driver timbuart_drive
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
@@ -507,7 +507,7 @@ static struct platform_driver timbuart_p
 		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D timbuart_probe,
-	.remove		=3D timbuart_remove,
+	.remove		=3D __devexit_p(timbuart_remove),
 };
=20
 /*--------------------------------------------------------------------=
------*/
_
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
