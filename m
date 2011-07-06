From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
Date: Wed, 6 Jul 2011 08:36:48 +0200
Message-ID: <20110706063648.GM6069@pengutronix.de>
References: <1309878338-25697-1-git-send-email-shawn.guo@linaro.org>
 <1309878338-25697-2-git-send-email-shawn.guo@linaro.org>
 <CACxGe6v+izZiANbzvhnTvrLU9+XgXD=W8FNGfTLzGXLNuCjZcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39275 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab1GFGgu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Jul 2011 02:36:50 -0400
Content-Disposition: inline
In-Reply-To: <CACxGe6v+izZiANbzvhnTvrLU9+XgXD=W8FNGfTLzGXLNuCjZcg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-serial@vger.kernel.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Tue, Jul 05, 2011 at 11:27:55AM -0600, Grant Likely wrote:
> On Tue, Jul 5, 2011 at 9:05 AM, Shawn Guo <shawn.guo@linaro.org> wrot=
e:
> > The patch removes all the uses of cpu_is_mx1(). =A0Instead, it uses
> > the .id_table of platform_driver to distinguish the uart device typ=
e.
> >
> > A couple of !cpu_is_mx1() logic gets turned into IS_IMX_UART, as th=
e
> > codes wrapped there are really IMX specific.
> >
> > It also removes macro MX1_UCR3_REF25 and MX1_UCR3_REF30 which are
> > not used anywhere.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
>=20
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>=20
> Who's tree is this one going to get merged through?

Before we merge this through any tree I'd like to have a policy how
the bindings are named. With the gpio part we agreed that we name
the bindings after the oldest i.MX they are compatible with. For exampl=
e
the last change in the gpios was on the i.MX31, so every newer i.MX
claims to be compatible with this the i.MX31.

The patch below instead follows the approach that the currently newest
i.MX gets a generic name (imx-uart instead of imx21-uart). This decisio=
n
may look silly when another change to the uart core comes and we have
given the generic name to some arbitrary version of the core.

I really like to have a consistent scheme across all devices and we hav=
e
the same problem with spi, nand and several others.

Sascha

>=20
> g.
>=20
> > ---
> > =A0arch/arm/mach-imx/clock-imx1.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A06 +-
> > =A0arch/arm/plat-mxc/devices/platform-imx-uart.c | =A0 =A02 +-
> > =A0drivers/tty/serial/imx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 65 ++++++++++++++++++++-----
> > =A03 files changed, 56 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/clock-imx1.c b/arch/arm/mach-imx/clo=
ck-imx1.c
> > index dcc4172..4aabeb2 100644
> > --- a/arch/arm/mach-imx/clock-imx1.c
> > +++ b/arch/arm/mach-imx/clock-imx1.c
> > @@ -587,9 +587,9 @@ static struct clk_lookup lookups[] __initdata =3D=
 {
> > =A0 =A0 =A0 =A0_REGISTER_CLOCK(NULL, "mma", mma_clk)
> > =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx_udc.0", NULL, usbd_clk)
> > =A0 =A0 =A0 =A0_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
> > - =A0 =A0 =A0 _REGISTER_CLOCK("imx-uart.0", NULL, uart_clk)
> > - =A0 =A0 =A0 _REGISTER_CLOCK("imx-uart.1", NULL, uart_clk)
> > - =A0 =A0 =A0 _REGISTER_CLOCK("imx-uart.2", NULL, uart_clk)
> > + =A0 =A0 =A0 _REGISTER_CLOCK("imx1-uart.0", NULL, uart_clk)
> > + =A0 =A0 =A0 _REGISTER_CLOCK("imx1-uart.1", NULL, uart_clk)
> > + =A0 =A0 =A0 _REGISTER_CLOCK("imx1-uart.2", NULL, uart_clk)
> > =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
> > =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx1-cspi.0", NULL, spi_clk)
> > =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx1-cspi.1", NULL, spi_clk)
> > diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/a=
rm/plat-mxc/devices/platform-imx-uart.c
> > index cfce8c9..477271a 100644
> > --- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
> > +++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
> > @@ -152,7 +152,7 @@ struct platform_device *__init imx_add_imx_uart=
_3irq(
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> > =A0 =A0 =A0 =A0};
> >
> > - =A0 =A0 =A0 return imx_add_platform_device("imx-uart", data->id, =
res,
> > + =A0 =A0 =A0 return imx_add_platform_device("imx1-uart", data->id,=
 res,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(res), pda=
ta, sizeof(*pdata));
> > =A0}
> >
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 22fe801..ddebb5c 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -48,7 +48,6 @@
> >
> > =A0#include <asm/io.h>
> > =A0#include <asm/irq.h>
> > -#include <mach/hardware.h>
> > =A0#include <mach/imx-uart.h>
> >
> > =A0/* Register definitions */
> > @@ -66,8 +65,9 @@
> > =A0#define UBIR =A00xa4 /* BRM Incremental Register */
> > =A0#define UBMR =A00xa8 /* BRM Modulator Register */
> > =A0#define UBRC =A00xac /* Baud Rate Count Register */
> > -#define MX2_ONEMS 0xb0 /* One Millisecond register */
> > -#define UTS (cpu_is_mx1() ? 0xd0 : 0xb4) /* UART Test Register */
> > +#define IMX_ONEMS 0xb0 /* One Millisecond register */
> > +#define IMX1_UTS 0xd0 /* UART Test Register on i.mx1 */
> > +#define IMX_UTS 0xb4 /* UART Test Register on all other i.mx*/
> >
> > =A0/* UART Control Register Bit Fields.*/
> > =A0#define =A0URXD_CHARRDY =A0 =A0(1<<15)
> > @@ -87,7 +87,7 @@
> > =A0#define =A0UCR1_RTSDEN =A0 =A0 (1<<5) =A0 =A0 =A0 =A0 /* RTS del=
ta interrupt enable */
> > =A0#define =A0UCR1_SNDBRK =A0 =A0 (1<<4) =A0 =A0 =A0 =A0 /* Send br=
eak */
> > =A0#define =A0UCR1_TDMAEN =A0 =A0 (1<<3) =A0 =A0 =A0 =A0 /* Transmi=
tter ready DMA enable */
> > -#define =A0MX1_UCR1_UARTCLKEN =A0(1<<2) =A0 =A0 /* UART clock enab=
led, mx1 only */
> > +#define =A0IMX1_UCR1_UARTCLKEN =A0(1<<2) =A0/* UART clock enabled,=
 i.mx1 only */
> > =A0#define =A0UCR1_DOZE =A0 =A0 =A0 (1<<1) =A0 =A0 =A0 =A0 /* Doze =
*/
> > =A0#define =A0UCR1_UARTEN =A0 =A0 (1<<0) =A0 =A0 =A0 =A0 /* UART en=
abled */
> > =A0#define =A0UCR2_ESCI =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<15) /* Escap=
e seq interrupt enable */
> > @@ -113,9 +113,7 @@
> > =A0#define =A0UCR3_RXDSEN =A0 =A0(1<<6) =A0/* Receive status interr=
upt enable */
> > =A0#define =A0UCR3_AIRINTEN =A0 (1<<5) =A0/* Async IR wake interrup=
t enable */
> > =A0#define =A0UCR3_AWAKEN =A0 =A0(1<<4) =A0/* Async wake interrupt =
enable */
> > -#define =A0MX1_UCR3_REF25 =A0 =A0 =A0 =A0 (1<<3) =A0/* Ref freq 25=
 MHz, only on mx1 */
> > -#define =A0MX1_UCR3_REF30 =A0 =A0 =A0 =A0 (1<<2) =A0/* Ref Freq 30=
 MHz, only on mx1 */
> > -#define =A0MX2_UCR3_RXDMUXSEL =A0 =A0 (1<<2) =A0/* RXD Muxed Input=
 Select, on mx2/mx3 */
> > +#define =A0IMX_UCR3_RXDMUXSEL =A0 =A0 (1<<2) =A0/* RXD Muxed Input=
 Select */
> > =A0#define =A0UCR3_INVT =A0 =A0 =A0(1<<1) =A0/* Inverted Infrared t=
ransmission */
> > =A0#define =A0UCR3_BPEN =A0 =A0 =A0(1<<0) =A0/* Preset registers en=
able */
> > =A0#define =A0UCR4_CTSTL_SHF =A010 =A0 =A0 =A0/* CTS trigger level =
shift */
> > @@ -181,6 +179,17 @@
> >
> > =A0#define UART_NR 8
> >
> > +enum imx_uart_type {
> > + =A0 =A0 =A0 IMX1_UART,
> > + =A0 =A0 =A0 IMX_UART,
> > +};
> > +
> > +/* device type dependent stuff */
> > +struct imx_uart_data {
> > + =A0 =A0 =A0 unsigned uts_reg;
> > + =A0 =A0 =A0 enum imx_uart_type devtype;
> > +};
> > +
> > =A0struct imx_port {
> > =A0 =A0 =A0 =A0struct uart_port =A0 =A0 =A0 =A0port;
> > =A0 =A0 =A0 =A0struct timer_list =A0 =A0 =A0 timer;
> > @@ -192,6 +201,7 @@ struct imx_port {
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0irda_inv_tx:1;
> > =A0 =A0 =A0 =A0unsigned short =A0 =A0 =A0 =A0 =A0trcv_delay; /* tra=
nsceiver delay */
> > =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> > + =A0 =A0 =A0 struct imx_uart_data =A0 =A0*devdata;
> > =A0};
> >
> > =A0#ifdef CONFIG_IRDA
> > @@ -200,6 +210,33 @@ struct imx_port {
> > =A0#define USE_IRDA(sport) =A0 =A0 =A0 =A0(0)
> > =A0#endif
> >
> > +#define UTS (sport->devdata->uts_reg)
> > +#define IS_IMX1_UART() (sport->devdata->devtype =3D=3D IMX1_UART)
> > +#define IS_IMX_UART() =A0(sport->devdata->devtype =3D=3D IMX_UART)
> > +
> > +static struct imx_uart_data imx_uart_devdata[] =3D {
> > + =A0 =A0 =A0 [IMX1_UART] =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .uts_reg =3D IMX1_UTS,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devtype =3D IMX1_UART,
> > + =A0 =A0 =A0 },
> > + =A0 =A0 =A0 [IMX_UART] =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .uts_reg =3D IMX_UTS,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devtype =3D IMX_UART,
> > + =A0 =A0 =A0 },
> > +};
> > +
> > +static struct platform_device_id imx_uart_devtype[] =3D {
> > + =A0 =A0 =A0 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "imx1-uart",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =3D (kernel_ulong_t) &im=
x_uart_devdata[IMX1_UART],
> > + =A0 =A0 =A0 }, {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "imx-uart",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =3D (kernel_ulong_t) &im=
x_uart_devdata[IMX_UART],
> > + =A0 =A0 =A0 }, {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* sentinel */
> > + =A0 =A0 =A0 }
> > +};
> > +
> > =A0/*
> > =A0* Handle any change of modem status signal since we were last ca=
lled.
> > =A0*/
> > @@ -689,9 +726,9 @@ static int imx_startup(struct uart_port *port)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 if (!cpu_is_mx1()) {
> > + =A0 =A0 =A0 if (IS_IMX_UART()) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp =3D readl(sport->port.membase +=
 UCR3);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D MX2_UCR3_RXDMUXSEL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D IMX_UCR3_RXDMUXSEL;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writel(temp, sport->port.membase + U=
CR3);
> > =A0 =A0 =A0 =A0}
> >
> > @@ -923,9 +960,9 @@ imx_set_termios(struct uart_port *port, struct =
ktermios *termios,
> > =A0 =A0 =A0 =A0writel(num, sport->port.membase + UBIR);
> > =A0 =A0 =A0 =A0writel(denom, sport->port.membase + UBMR);
> >
> > - =A0 =A0 =A0 if (!cpu_is_mx1())
> > + =A0 =A0 =A0 if (IS_IMX_UART())
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writel(sport->port.uartclk / div / 1=
000,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sport=
->port.membase + MX2_ONEMS);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sport=
->port.membase + IMX_ONEMS);
> >
> > =A0 =A0 =A0 =A0writel(old_ucr1, sport->port.membase + UCR1);
> >
> > @@ -1062,8 +1099,8 @@ imx_console_write(struct console *co, const c=
har *s, unsigned int count)
> > =A0 =A0 =A0 =A0ucr1 =3D old_ucr1 =3D readl(sport->port.membase + UC=
R1);
> > =A0 =A0 =A0 =A0old_ucr2 =3D readl(sport->port.membase + UCR2);
> >
> > - =A0 =A0 =A0 if (cpu_is_mx1())
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucr1 |=3D MX1_UCR1_UARTCLKEN;
> > + =A0 =A0 =A0 if (IS_IMX1_UART())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucr1 |=3D IMX1_UCR1_UARTCLKEN;
> > =A0 =A0 =A0 =A0ucr1 |=3D UCR1_UARTEN;
> > =A0 =A0 =A0 =A0ucr1 &=3D ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDE=
N);
> >
> > @@ -1262,6 +1299,7 @@ static int serial_imx_probe(struct platform_d=
evice *pdev)
> > =A0 =A0 =A0 =A0init_timer(&sport->timer);
> > =A0 =A0 =A0 =A0sport->timer.function =3D imx_timeout;
> > =A0 =A0 =A0 =A0sport->timer.data =A0 =A0 =3D (unsigned long)sport;
> > + =A0 =A0 =A0 sport->devdata =3D (struct imx_uart_data =A0*) pdev->=
id_entry->driver_data;
> >
> > =A0 =A0 =A0 =A0sport->clk =3D clk_get(&pdev->dev, "uart");
> > =A0 =A0 =A0 =A0if (IS_ERR(sport->clk)) {
> > @@ -1340,6 +1378,7 @@ static struct platform_driver serial_imx_driv=
er =3D {
> >
> > =A0 =A0 =A0 =A0.suspend =A0 =A0 =A0 =A0=3D serial_imx_suspend,
> > =A0 =A0 =A0 =A0.resume =A0 =A0 =A0 =A0 =3D serial_imx_resume,
> > + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D imx_uart_devtype,
> > =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "imx-uart",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> > --
> > 1.7.4.1
> >
> >
> > _______________________________________________
> > devicetree-discuss mailing list
> > devicetree-discuss@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/devicetree-discuss
> >
>=20
>=20
>=20
> --=20
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>=20

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
