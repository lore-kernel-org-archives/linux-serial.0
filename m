From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
Date: Mon, 4 Jul 2011 16:43:25 +0800
Message-ID: <20110704084324.GE10245@S2100-06.ap.freescale.net>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
 <1309679760-22796-2-git-send-email-shawn.guo@linaro.org>
 <20110703211007.GB13742@ponder.secretlab.ca>
 <20110704021923.GA10245@S2100-06.ap.freescale.net>
 <20110704073320.GB4338@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:22629
	"EHLO AM1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755436Ab1GDIhM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jul 2011 04:37:12 -0400
Content-Disposition: inline
In-Reply-To: <20110704073320.GB4338@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org

On Mon, Jul 04, 2011 at 09:33:20AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, Jul 04, 2011 at 10:19:25AM +0800, Shawn Guo wrote:
> > Hi Grant,
> >=20
> > Thanks for the review.
> >=20
> > On Sun, Jul 03, 2011 at 03:10:07PM -0600, Grant Likely wrote:
> > > On Sun, Jul 03, 2011 at 03:55:59PM +0800, Shawn Guo wrote:
> > > > The patch removes all the uses of cpu_is_mx1().  Instead, it us=
es
> > > > the .id_table of platform_driver to distinguish the uart device=
 type.
> > > >=20
> > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > > > ---
> > > >  arch/arm/mach-imx/clock-imx1.c                |    6 +-
> > > >  arch/arm/plat-mxc/devices/platform-imx-uart.c |    2 +-
> > > >  drivers/tty/serial/imx.c                      |   51 +++++++++=
+++++++++++++--
> > > >  3 files changed, 50 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/arch/arm/mach-imx/clock-imx1.c b/arch/arm/mach-imx=
/clock-imx1.c
> > > > index dcc4172..4aabeb2 100644
> > > > --- a/arch/arm/mach-imx/clock-imx1.c
> > > > +++ b/arch/arm/mach-imx/clock-imx1.c
> > > > @@ -587,9 +587,9 @@ static struct clk_lookup lookups[] __initda=
ta =3D {
> > > >  	_REGISTER_CLOCK(NULL, "mma", mma_clk)
> > > >  	_REGISTER_CLOCK("imx_udc.0", NULL, usbd_clk)
> > > >  	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
> > > > -	_REGISTER_CLOCK("imx-uart.0", NULL, uart_clk)
> > > > -	_REGISTER_CLOCK("imx-uart.1", NULL, uart_clk)
> > > > -	_REGISTER_CLOCK("imx-uart.2", NULL, uart_clk)
> > > > +	_REGISTER_CLOCK("imx1-uart.0", NULL, uart_clk)
> > > > +	_REGISTER_CLOCK("imx1-uart.1", NULL, uart_clk)
> > > > +	_REGISTER_CLOCK("imx1-uart.2", NULL, uart_clk)
> > > >  	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
> > > >  	_REGISTER_CLOCK("imx1-cspi.0", NULL, spi_clk)
> > > >  	_REGISTER_CLOCK("imx1-cspi.1", NULL, spi_clk)
> > > > diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/ar=
ch/arm/plat-mxc/devices/platform-imx-uart.c
> > > > index cfce8c9..477271a 100644
> > > > --- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
> > > > +++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
> > > > @@ -152,7 +152,7 @@ struct platform_device *__init imx_add_imx_=
uart_3irq(
> > > >  		},
> > > >  	};
> > > > =20
> > > > -	return imx_add_platform_device("imx-uart", data->id, res,
> > > > +	return imx_add_platform_device("imx1-uart", data->id, res,
> > > >  			ARRAY_SIZE(res), pdata, sizeof(*pdata));
> > > >  }
> > > > =20
> > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.=
c
> > > > index 22fe801..983f3bd 100644
> > > > --- a/drivers/tty/serial/imx.c
> > > > +++ b/drivers/tty/serial/imx.c
> > > > @@ -48,7 +48,6 @@
> > > > =20
> > > >  #include <asm/io.h>
> > > >  #include <asm/irq.h>
> > > > -#include <mach/hardware.h>
> > > >  #include <mach/imx-uart.h>
> > > > =20
> > > >  /* Register definitions */
> > > > @@ -67,7 +66,8 @@
> > > >  #define UBMR  0xa8 /* BRM Modulator Register */
> > > >  #define UBRC  0xac /* Baud Rate Count Register */
> > > >  #define MX2_ONEMS 0xb0 /* One Millisecond register */
> > > > -#define UTS (cpu_is_mx1() ? 0xd0 : 0xb4) /* UART Test Register=
 */
> > > > +#define MX1_UTS 0xd0 /* UART Test Register on mx1 */
> > > > +#define MX2_UTS 0xb4 /* UART Test Register on mx2 and later */
> > > > =20
> > > >  /* UART Control Register Bit Fields.*/
> > > >  #define  URXD_CHARRDY    (1<<15)
> > > > @@ -181,6 +181,17 @@
> > > > =20
> > > >  #define UART_NR 8
> > > > =20
> > > > +enum imx_uart_type {
> > > > +	IMX1_UART,
> > > > +	IMX2_UART,
> > > > +};
> > > > +
> > > > +/* device type dependent stuff */
> > > > +struct imx_uart_data {
> > > > +	unsigned uts_reg;
> > > > +	enum imx_uart_type devtype;
> > > > +};
> > > > +
> > > >  struct imx_port {
> > > >  	struct uart_port	port;
> > > >  	struct timer_list	timer;
> > > > @@ -192,6 +203,7 @@ struct imx_port {
> > > >  	unsigned int		irda_inv_tx:1;
> > > >  	unsigned short		trcv_delay; /* transceiver delay */
> > > >  	struct clk		*clk;
> > > > +	struct imx_uart_data	*devdata;
> > > >  };
> > > > =20
> > > >  #ifdef CONFIG_IRDA
> > > > @@ -200,6 +212,33 @@ struct imx_port {
> > > >  #define USE_IRDA(sport)	(0)
> > > >  #endif
> > > > =20
> > > > +#define UTS (sport->devdata->uts_reg)
> > > > +#define IS_IMX1_UART() (sport->devdata->devtype =3D=3D IMX1_UA=
RT)
> > > > +#define IS_IMX2_UART() (sport->devdata->devtype =3D=3D IMX2_UA=
RT)
> > > > +
> > > > +static struct imx_uart_data imx_uart_devdata[] =3D {
> > > > +	[IMX1_UART] =3D {
> > > > +		.uts_reg =3D MX1_UTS,
> > > > +		.devtype =3D IMX1_UART,
> > > > +	},
> > > > +	[IMX2_UART] =3D {
> > > > +		.uts_reg =3D MX2_UTS,
> > > > +		.devtype =3D IMX2_UART,
> > > > +	},
> > > > +};
> > > > +
> > > > +static struct platform_device_id imx_uart_devtype[] =3D {
> > > > +	{
> > > > +		.name =3D "imx1-uart",
> > > > +		.driver_data =3D IMX1_UART,
> > > > +	}, {
> > > > +		.name =3D "imx-uart",
> > > > +		.driver_data =3D IMX2_UART,
> It feels strange to introduce IMX2 today meaning
> i.MX{21,25,27,31,35,50,51,53}. I didn't check the changes in detail, =
but
> if the only relevant change is that the UTS register is at a differen=
t

No, it's not the only relevant change.  The patch also changes a couple=
 of
'if (!cpu_is_imx1())' to 'if (IS_IMX2_UART())'.

The 'IMX2' in 'IMX2_UART' does not necessarily mean i.MX{21,25,27,
31,35,50,51,53}.  It actually means i.MX{21,25,27,31,35,50,51,53} all
have the same UART block which was firstly introduced on IMX2.

It's actually a change respecting the existing code, which defines
MX2_ONEMS for all imx except imx1.

--=20
Regards,
Shawn

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
