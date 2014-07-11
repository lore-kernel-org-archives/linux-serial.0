From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial: efm32: correct namespacing of location property
Date: Fri, 11 Jul 2014 10:16:45 +0200
Message-ID: <1405066605-12801-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33584 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaGKIRA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jul 2014 04:17:00 -0400
In-Reply-To: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Olof Johansson <olof@lixom.net>

Olof Johansson pointed out that usually the company name is picked as
namespace prefix to specific properties. So expect "energymicro,locatio=
n"
but fall back to the previously introduced name "efm32,location".

Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/serial/efm32-uart.txt | 4 ++--
 drivers/tty/serial/efm32-uart.c                         | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/efm32-uart.txt b/=
Documentation/devicetree/bindings/serial/efm32-uart.txt
index 3ca01336b837..8adbab268ca3 100644
--- a/Documentation/devicetree/bindings/serial/efm32-uart.txt
+++ b/Documentation/devicetree/bindings/serial/efm32-uart.txt
@@ -6,7 +6,7 @@ Required properties:
 - interrupts : Should contain uart interrupt
=20
 Optional properties:
-- efm32,location : Decides the location of the USART I/O pins.
+- energymicro,location : Decides the location of the USART I/O pins.
   Allowed range : [0 .. 5]
   Default: 0
=20
@@ -16,5 +16,5 @@ uart@0x4000c400 {
 	compatible =3D "energymicro,efm32-uart";
 	reg =3D <0x4000c400 0x400>;
 	interrupts =3D <15>;
-	efm32,location =3D <0>;
+	energymicro,location =3D <0>;
 };
diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32=
-uart.c
index 3b0ee9afd76f..cb007a4f4d15 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -671,10 +671,16 @@ static int efm32_uart_probe_dt(struct platform_de=
vice *pdev,
 	if (!np)
 		return 1;
=20
-	ret =3D of_property_read_u32(np, "efm32,location", &location);
+	ret =3D of_property_read_u32(np, "energymicro,location", &location);
+
+	if (ret)
+		/* fall back to wrongly namespaced property */
+		ret =3D of_property_read_u32(np, "efm32,location", &location);
+
 	if (ret)
 		/* fall back to old and (wrongly) generic property "location" */
 		ret =3D of_property_read_u32(np, "location", &location);
+
 	if (!ret) {
 		if (location > 5) {
 			dev_err(&pdev->dev, "invalid location\n");
--=20
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
