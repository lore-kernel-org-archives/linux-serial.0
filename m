From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/5] ARM: dts: imx6: rename the uart's compatible property
Date: Wed, 3 Jul 2013 09:46:24 +0800
Message-ID: <20130703014623.GB9145@S2101-09.ap.freescale.net>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
 <1372746628-20092-4-git-send-email-b32955@freescale.com>
 <20130702095645.GD31358@e106331-lin.cambridge.arm.com>
 <51D2AEC1.6030004@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:46335
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281Ab3GCBqI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jul 2013 21:46:08 -0400
Content-Disposition: inline
In-Reply-To: <51D2AEC1.6030004@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Jul 02, 2013 at 06:43:13PM +0800, Huang Shijie wrote:
> =E4=BA=8E 2013=E5=B9=B407=E6=9C=8802=E6=97=A5 17:56, Mark Rutland =E5=
=86=99=E9=81=93:
> >On Tue, Jul 02, 2013 at 07:30:26AM +0100, Huang Shijie wrote:
> >>>  The imx6 uart can supports the DMA, imx uart driver has added a =
new
> >>>  compatible property for the imx6 uart.
> >>>  >  In order to enable the DMA for some uart port in imx6, we
> >>rename the
> >>>  uart's compatible property to "fsl,imx6-uart".
> >Doesn't this change break using these dts with an older kernel? You
> is it reasonable to use a new dts with an old kernel?
>=20
>=20
> >remove the "fsl,imx21-uart" string older kernels understand.
> >
> >Given you already had "fsl,imx6q-uart" and "fsl,imx6sl-uart" strings=
,
> >would it not have made more sense to just add these to the driver?
> I think it's not a good idea.
>=20
> Shawn, what's your opinion about this?

I agree with Mark.  I think all we need is to add "fsl,imx6q-uart"
into both driver matching table and imx6sl uart compatible property,
something like the below.

Shawn

---8<-------

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.d=
tsi
index c5e5da0..078dfc7 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -152,7 +152,8 @@
                                };

                                uart5: serial@02018000 {
-                                       compatible =3D "fsl,imx6sl-uart=
", "fsl,imx21-uart";
+                                       compatible =3D "fsl,imx6sl-uart=
", "fsl,imx6q-uart",
+                                                    "fsl,imx21-uart";
                                        reg =3D <0x02018000 0x4000>;
                                        interrupts =3D <0 30 0x04>;
                                        clocks =3D <&clks IMX6SL_CLK_UA=
RT>,
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8cdfbd3..457984d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -249,6 +249,7 @@ MODULE_DEVICE_TABLE(platform, imx_uart_devtype);
 static struct of_device_id imx_uart_dt_ids[] =3D {
        { .compatible =3D "fsl,imx1-uart", .data =3D &imx_uart_devdata[=
IMX1_UART], },
        { .compatible =3D "fsl,imx21-uart", .data =3D &imx_uart_devdata=
[IMX21_UART], },
+       { .compatible =3D "fsl,imx6q-uart", .data =3D &imx_uart_devdata=
[IMX6Q_UART], },
        { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
