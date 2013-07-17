From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] serial/efm32-uart: don't use pdev->id to determine the port's line
Date: Wed, 17 Jul 2013 08:48:40 +0200
Message-ID: <1374043721-30677-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38561 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab3GQGsx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Jul 2013 02:48:53 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

pdev->id is not a valid choice for device-tree probed devices. So use
the (properly determined) line from efm32_uart_probe consistenly.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/efm32-uart.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32=
-uart.c
index 7d199c8..cc77970 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -698,6 +698,7 @@ static int efm32_uart_probe(struct platform_device =
*pdev)
 {
 	struct efm32_uart_port *efm_port;
 	struct resource *res;
+	unsigned int line;
 	int ret;
=20
 	efm_port =3D kzalloc(sizeof(*efm_port), GFP_KERNEL);
@@ -752,16 +753,17 @@ static int efm32_uart_probe(struct platform_devic=
e *pdev)
 			efm_port->pdata =3D *pdata;
 	}
=20
-	if (efm_port->port.line >=3D 0 &&
-			efm_port->port.line < ARRAY_SIZE(efm32_uart_ports))
-		efm32_uart_ports[efm_port->port.line] =3D efm_port;
+	line =3D efm_port->port.line;
+
+	if (line >=3D 0 && line < ARRAY_SIZE(efm32_uart_ports))
+		efm32_uart_ports[line] =3D efm_port;
=20
 	ret =3D uart_add_one_port(&efm32_uart_reg, &efm_port->port);
 	if (ret) {
 		dev_dbg(&pdev->dev, "failed to add port: %d\n", ret);
=20
-		if (pdev->id >=3D 0 && pdev->id < ARRAY_SIZE(efm32_uart_ports))
-			efm32_uart_ports[pdev->id] =3D NULL;
+		if (line >=3D 0 && line < ARRAY_SIZE(efm32_uart_ports))
+			efm32_uart_ports[line] =3D NULL;
 err_get_rxirq:
 err_too_small:
 err_get_base:
@@ -777,13 +779,14 @@ err_get_base:
 static int efm32_uart_remove(struct platform_device *pdev)
 {
 	struct efm32_uart_port *efm_port =3D platform_get_drvdata(pdev);
+	unsigned int line =3D efm_port->port.line;
=20
 	platform_set_drvdata(pdev, NULL);
=20
 	uart_remove_one_port(&efm32_uart_reg, &efm_port->port);
=20
-	if (pdev->id >=3D 0 && pdev->id < ARRAY_SIZE(efm32_uart_ports))
-		efm32_uart_ports[pdev->id] =3D NULL;
+	if (line >=3D 0 && line < ARRAY_SIZE(efm32_uart_ports))
+		efm32_uart_ports[line] =3D NULL;
=20
 	kfree(efm_port);
=20
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
