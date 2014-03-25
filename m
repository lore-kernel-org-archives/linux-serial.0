From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial: efm32: use $vendor,$device scheme for compatible string
Date: Tue, 25 Mar 2014 14:59:14 +0100
Message-ID: <1395755954-18988-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55339 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbaCYN7Y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Mar 2014 09:59:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, Wolfram Sang <wsa@the-dreams.de>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

Wolfgang Sang pointed out that "efm32,$device" is non-standard. So use =
the
common scheme and prefix device with "efm32-". The old compatible strin=
g
is left in place until arch/arm/boot/dts/efm32* is fixed.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/efm32-uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32=
-uart.c
index 028582e924a5..c167a710dc39 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -798,6 +798,9 @@ static int efm32_uart_remove(struct platform_device=
 *pdev)
=20
 static const struct of_device_id efm32_uart_dt_ids[] =3D {
 	{
+		.compatible =3D "energymicro,efm32-uart",
+	}, {
+		/* doesn't follow the "vendor,device" scheme, don't use */
 		.compatible =3D "efm32,uart",
 	}, {
 		/* sentinel */
--=20
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
