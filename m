From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] serial: efm32: use $vendor,$device scheme for compatible string
Date: Tue, 25 Mar 2014 15:53:12 +0100
Message-ID: <1395759192-10797-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1395755954-18988-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59174 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbaCYOx2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Mar 2014 10:53:28 -0400
In-Reply-To: <1395755954-18988-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
Changes since (implicit) v1, sent with
Message-id:1395755954-18988-1-git-send-email-u.kleine-koenig@pengutroni=
x.de:
 - fix binding doc accordingly

 Documentation/devicetree/bindings/serial/efm32-uart.txt | 4 ++--
 drivers/tty/serial/efm32-uart.c                         | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/efm32-uart.txt b/=
Documentation/devicetree/bindings/serial/efm32-uart.txt
index 1984bdfbd545..3ca01336b837 100644
--- a/Documentation/devicetree/bindings/serial/efm32-uart.txt
+++ b/Documentation/devicetree/bindings/serial/efm32-uart.txt
@@ -1,7 +1,7 @@
 * Energymicro efm32 UART
=20
 Required properties:
-- compatible : Should be "efm32,uart"
+- compatible : Should be "energymicro,efm32-uart"
 - reg : Address and length of the register set
 - interrupts : Should contain uart interrupt
=20
@@ -13,7 +13,7 @@ Optional properties:
 Example:
=20
 uart@0x4000c400 {
-	compatible =3D "efm32,uart";
+	compatible =3D "energymicro,efm32-uart";
 	reg =3D <0x4000c400 0x400>;
 	interrupts =3D <15>;
 	efm32,location =3D <0>;
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
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
