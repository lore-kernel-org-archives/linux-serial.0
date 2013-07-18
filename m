From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial/efm32-uart: don't slur over failure in probe_dt
Date: Thu, 18 Jul 2013 21:55:42 +0200
Message-ID: <1374177342-23129-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34950 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933070Ab3GRTzw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Jul 2013 15:55:52 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/efm32-uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32=
-uart.c
index 0d38034..551a629 100644
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
