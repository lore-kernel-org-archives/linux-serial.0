From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial: efm32: properly namespace location property
Date: Fri, 14 Mar 2014 17:03:29 +0100
Message-ID: <1394813009-22796-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51960 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743AbaCNQFb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Mar 2014 12:05:31 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, Wolfram Sang <wsa@the-dreams.de>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

While reviewing an i2c driver for efm32 that needs a similar property
Wolfram Sang pointed out that "location" is a too generic name for some=
thing
that is efm32 specific. So add an appropriate namespace and fall back t=
o the
generic name in case of failure.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/efm32-uart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32=
-uart.c
index 0eb5b5673ede..028582e924a5 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -671,7 +671,10 @@ static int efm32_uart_probe_dt(struct platform_dev=
ice *pdev,
 	if (!np)
 		return 1;
=20
-	ret =3D of_property_read_u32(np, "location", &location);
+	ret =3D of_property_read_u32(np, "efm32,location", &location);
+	if (ret)
+		/* fall back to old and (wrongly) generic property "location" */
+		ret =3D of_property_read_u32(np, "location", &location);
 	if (!ret) {
 		if (location > 5) {
 			dev_err(&pdev->dev, "invalid location\n");
--=20
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
