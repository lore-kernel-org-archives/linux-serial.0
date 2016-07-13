From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH RFC] serial: imx: support an enable-gpio
Date: Wed, 13 Jul 2016 11:01:35 +0200
Message-ID: <1468400495-10471-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

A part of my machine looks as follows (simplified):

,------------------------.
| ,---------.            |
| |  imx25  o--RX----=E2=97=81---o---
| |         o--GPIO--'   |
| `---------'            |
`------------------------'

that is, there is a driver on the RX line that must be enabled before
the UART can be used. (That is necessary because the default mux of the
RX pad after reset is an output.)

To represent this in the device tree I do:

	pinctrl_uart5: uart5 {
		fsl,pins =3D <
			...
			MX25_PAD_LBA__UART5_RXD		0x00000000
			MX25_PAD_CS5__GPIO_3_21		0x00002001
			...
	};

	&uart5 {
		pinctrl-names =3D "default";
		pinctrl-0 =3D <&pinctrl_uart5>;

		enable-gpio =3D <&gpio3 21 GPIO_ACTIVE_LOW>;
		...
	};

This way it's ensured that the gpio is only enabled when the LBA pad is
muxed as RX (together with the bootloader that sets the GPIO high).

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Hello,

I'm not sure about the naming. Do you have a better suggestion how to h=
andle
this situation?

Best regards
Uwe

 drivers/tty/serial/imx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0df2b1c091ae..56eaa18aa5be 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -39,6 +39,7 @@
 #include <linux/of_device.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
+#include <linux/gpio/consumer.h>
=20
 #include <asm/irq.h>
 #include <linux/platform_data/serial-imx.h>
@@ -1987,7 +1988,9 @@ static int serial_imx_probe_dt(struct imx_port *s=
port,
 	if (of_get_property(np, "fsl,dte-mode", NULL))
 		sport->dte_mode =3D 1;
=20
-	return 0;
+	ret =3D PTR_ERR_OR_ZERO(devm_gpiod_get_optional(&pdev->dev, "enable",=
 GPIOD_OUT_HIGH));
+	dev_info(&pdev->dev, "Tralala: ret =3D %d\n", ret);
+	return ret;
 }
 #else
 static inline int serial_imx_probe_dt(struct imx_port *sport,
--=20
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
