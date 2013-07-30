From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] serial/efm32-uart: don't slur over failure in probe_dt
Date: Tue, 30 Jul 2013 10:23:13 +0200
Message-ID: <1375172593-24345-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20130730082146.GP1754@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43747 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab3G3IXj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Jul 2013 04:23:39 -0400
In-Reply-To: <20130730082146.GP1754@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
=46orwarded: id:1374177342-23129-1-git-send-email-u.kleine-koenig@pengu=
tronix.de
---
 drivers/tty/serial/efm32-uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32=
-uart.c
index ce1ebbb..98adaa1 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -751,7 +751,8 @@ static int efm32_uart_probe(struct platform_device =
*pdev)
=20
 		if (pdata)
 			efm_port->pdata =3D *pdata;
-	}
+	} else if (ret < 0)
+		goto err_probe_dt;
=20
 	line =3D efm_port->port.line;
=20
@@ -764,6 +765,7 @@ static int efm32_uart_probe(struct platform_device =
*pdev)
=20
 		if (line >=3D 0 && line < ARRAY_SIZE(efm32_uart_ports))
 			efm32_uart_ports[line] =3D NULL;
+err_probe_dt:
 err_get_rxirq:
 err_too_small:
 err_get_base:
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
