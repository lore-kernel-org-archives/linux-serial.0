From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [RFC PATCH] serial: omap: only inform once about missing wakeirq support
Date: Thu, 13 Feb 2014 10:25:10 +0100
Message-ID: <1392283510-16774-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51479 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaBMJZV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 04:25:21 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org
Cc: kernel@pengutronix.de, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@linaro.org>

The unconditional output in serial_omap_startup clutters dmesg quite a
bit when booting with systemd because the console device is opened
repeatedly.

Without this patch, directly after boot + login I get:

	# dmesg | grep -c 'omap_uart 48024000.serial: no wakeirq for uart2'
	79

This was introduced in commit 2a0b965cfb6e (serial: omap: Add support
for optional wake-up) which was applied for v3.13-rc1.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

actually this change is not optimal because it would be nicer to report
once per device instead of not once per driver. But adding a variable t=
o
driver data just for that seems overkill, too. Maybe downgrading the
message to dev_dbg is fine, too?

What do you think?

Best regards
Uwe

 drivers/tty/serial/omap-serial.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap=
-serial.c
index 2116e76b9559..bbcd95360553 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -739,8 +739,13 @@ static int serial_omap_startup(struct uart_port *p=
ort)
 		}
 		disable_irq(up->wakeirq);
 	} else {
-		dev_info(up->port.dev, "no wakeirq for uart%d\n",
-			 up->port.line);
+		static int once =3D 1;
+
+		if (once) {
+			dev_info(up->port.dev, "no wakeirq for uart%d\n",
+				 up->port.line);
+			once =3D 0;
+		}
 	}
=20
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
--=20
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
