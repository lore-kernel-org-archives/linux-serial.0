From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial: omap: fix rs485 probe on defered pinctrl
Date: Thu, 13 Feb 2014 10:52:03 +0100
Message-ID: <1392285123-13207-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38427 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbaBMJw1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 04:52:27 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org
Cc: kernel@pengutronix.de, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@linaro.org>, Michael Grzeschik <m.grzeschik@pengutronix.de>

=46rom: Michael Grzeschik <m.grzeschik@pengutronix.de>

If the gpio is not yet available we better also
defer the probing in the rs485 case.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/omap-serial.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap=
-serial.c
index fa511ebab67c..2116e76b9559 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1604,8 +1604,11 @@ static int serial_omap_probe_rs485(struct uart_o=
map_port *up,
 					    flags & SER_RS485_RTS_AFTER_SEND);
 		if (ret < 0)
 			return ret;
-	} else
+	} else if (up->rts_gpio =3D=3D -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else {
 		up->rts_gpio =3D -EINVAL;
+	}
=20
 	if (of_property_read_u32_array(np, "rs485-rts-delay",
 				    rs485_delay, 2) =3D=3D 0) {
--=20
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
