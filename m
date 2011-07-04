From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] serial/imx: add device tree probe support
Date: Mon, 4 Jul 2011 09:33:25 -0600
Message-ID: <20110704153325.GC29977@ponder.secretlab.ca>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
 <1309679760-22796-3-git-send-email-shawn.guo@linaro.org>
 <20110704065820.GY6069@pengutronix.de>
 <20110704073826.GC4338@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48229 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab1GDPd3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jul 2011 11:33:29 -0400
Received: by pvg12 with SMTP id 12so4450848pvg.19
        for <linux-serial@vger.kernel.org>; Mon, 04 Jul 2011 08:33:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110704073826.GC4338@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Jason Liu <jason.hui@linaro.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Jeremy Kerr <jeremy.kerr@canonical.com>, linux-arm-kernel@lists.infradead.org

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

If the newer parts claim compatibility with the older, then have a
terse of_device_id table is just fine.  ie, the compatible property
for an imx51 would be:

	compatible =3D "fsl,imx51-uart", "fsl,imx21-uart";

It would only be wrong if the device tree node omitted the
"fsl,imx51-uart" value from the list.

g.

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
