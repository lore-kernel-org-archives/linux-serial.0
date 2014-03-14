From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] serial: efm32: properly namespace location property
Date: Fri, 14 Mar 2014 21:42:11 +0100
Message-ID: <1394829731-25402-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1394813009-22796-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34579 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbaCNUmZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Mar 2014 16:42:25 -0400
In-Reply-To: <1394813009-22796-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
Changes since (implicit) v1, sent with
Message-Id: 1394813009-22796-1-git-send-email-u.kleine-koenig@pengutron=
ix.de:

 - adapt dt binding document accordingly

 Documentation/devicetree/bindings/serial/efm32-uart.txt | 4 ++--
 drivers/tty/serial/efm32-uart.c                         | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/efm32-uart.txt b/=
Documentation/devicetree/bindings/serial/efm32-uart.txt
index 8e080b893b49..1984bdfbd545 100644
--- a/Documentation/devicetree/bindings/serial/efm32-uart.txt
+++ b/Documentation/devicetree/bindings/serial/efm32-uart.txt
@@ -6,7 +6,7 @@ Required properties:
 - interrupts : Should contain uart interrupt
=20
 Optional properties:
-- location : Decides the location of the USART I/O pins.
+- efm32,location : Decides the location of the USART I/O pins.
   Allowed range : [0 .. 5]
   Default: 0
=20
@@ -16,5 +16,5 @@ uart@0x4000c400 {
 	compatible =3D "efm32,uart";
 	reg =3D <0x4000c400 0x400>;
 	interrupts =3D <15>;
-	location =3D <0>;
+	efm32,location =3D <0>;
 };
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
