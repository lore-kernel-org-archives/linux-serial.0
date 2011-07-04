From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 2/2] serial/imx: add device tree probe support
Date: Mon, 4 Jul 2011 17:05:27 +0800
Message-ID: <20110704090527.GF10245@S2100-06.ap.freescale.net>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
 <1309679760-22796-3-git-send-email-shawn.guo@linaro.org>
 <20110704065820.GY6069@pengutronix.de>
 <20110704073826.GC4338@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:10611
	"EHLO CH1EHSOBE018.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754066Ab1GDI7N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jul 2011 04:59:13 -0400
Content-Disposition: inline
In-Reply-To: <20110704073826.GC4338@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Jason Liu <jason.hui@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Jeremy Kerr <jeremy.kerr@canonical.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Mon, Jul 04, 2011 at 09:38:26AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, Jul 04, 2011 at 08:58:20AM +0200, Sascha Hauer wrote:
> > On Sun, Jul 03, 2011 at 03:56:00PM +0800, Shawn Guo wrote:
> > > It adds device tree probe support for imx tty/serial driver.
> > >=20
> > > Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> > > Signed-off-by: Jason Liu <jason.hui@linaro.org>
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > ---
> > >  .../bindings/tty/serial/fsl-imx-uart.txt           |   19 +++++
> > >  drivers/tty/serial/imx.c                           |   82 ++++++=
+++++++++++---
> > >  2 files changed, 91 insertions(+), 10 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/tty/serial/=
fsl-imx-uart.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx=
-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.t=
xt
> > > new file mode 100644
> > > index 0000000..a9c0406
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.t=
xt
> > > @@ -0,0 +1,19 @@
> > > +* Freescale i.MX Universal Asynchronous Receiver/Transmitter (UA=
RT)
> > > +
> > > +Required properties:
> > > +- compatible : Should be "fsl,<soc>-uart"
> > > +- reg : Address and length of the register set for the device
> > > +- interrupts : Should contain uart interrupt
> > > +
> > > +Optional properties:
> > > +- fsl,uart-has-rtscts : Indicate the uart has rts and cts
> > > +- fsl,irda-mode : Indicate the uart supports irda mode
> > > +
> > > +Example:
> > > +
> > > +uart@73fbc000 {
> > > +	compatible =3D "fsl,imx51-uart", "fsl,imx21-uart";
> > > +	reg =3D <0x73fbc000 0x4000>;
> > > +	interrupts =3D <31>;
> > > +	fsl,uart-has-rtscts;
> > > +};
> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > index 983f3bd..483c447 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -45,6 +45,8 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/rational.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > =20
> > >  #include <asm/io.h>
> > >  #include <asm/irq.h>
> > > @@ -239,6 +241,12 @@ static struct platform_device_id imx_uart_de=
vtype[] =3D {
> > >  	}
> > >  };
> > > =20
> > > +static struct of_device_id imx_uart_dt_ids[] =3D {
> > > +	{ .compatible =3D "fsl,imx1-uart", .data =3D &imx_uart_devdata[=
IMX1_UART], },
> > > +	{ .compatible =3D "fsl,imx21-uart", .data =3D &imx_uart_devdata=
[IMX2_UART], },
> > > +	{ /* sentinel */ },
> > > +};
> >=20
> > Isn't this table a bit too small? What about the other SoCs?
> I'd expect that using fsl,imx21-uart on imx51 would result in a worki=
ng
> port, but it feels stange and if that's the intention the example abo=
ve
> needs fixing.
>=20
Here is what I have in dts file for uart.  The 'compatible' tells
that it's a imx51-uart and compatible with imx21-uart.

uart0: uart@73fbc000 {
	compatible =3D "fsl,imx51-uart", "fsl,imx21-uart";
	reg =3D <0x73fbc000 0x4000>;
	interrupts =3D <31>;
	fsl,uart-has-rtscts;
};

I did not buy it until I got convinced by Grant here [1].  We do not
need this long table until there are some soc specific thing to
distinguish.  Currently, they are all compatible with imx21-uart and
share imx_uart_devdata[IMX2_UART].

{ .compatible =3D "fsl,imx21-uart", .data =3D &imx_uart_devdata[IMX2_UA=
RT], },
{ .compatible =3D "fsl,imx25-uart", .data =3D &imx_uart_devdata[IMX2_UA=
RT], },
{ .compatible =3D "fsl,imx27-uart", .data =3D &imx_uart_devdata[IMX2_UA=
RT], },
{ .compatible =3D "fsl,imx31-uart", .data =3D &imx_uart_devdata[IMX2_UA=
RT], },
{ .compatible =3D "fsl,imx35-uart", .data =3D &imx_uart_devdata[IMX2_UA=
RT], },
{ .compatible =3D "fsl,imx50-uart", .data =3D &imx_uart_devdata[IMX2_UA=
RT], },
{ .compatible =3D "fsl,imx51-uart", .data =3D &imx_uart_devdata[IMX2_UA=
RT], },
{ .compatible =3D "fsl,imx53-uart", .data =3D &imx_uart_devdata[IMX2_UA=
RT], },

[1] http://permalink.gmane.org/gmane.linux.network/198935

--=20
Regards,
Shawn

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
