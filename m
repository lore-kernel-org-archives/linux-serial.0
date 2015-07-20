From: Juergen Borleis <jbe@pengutronix.de>
Subject: Re: [PATCH v3] serial: mxs-auart: keep the AUART unit in reset state when not in use
Date: Mon, 20 Jul 2015 10:04:02 +0200
Message-ID: <201507201004.02646.jbe@pengutronix.de>
References: <1437032458-8577-1-git-send-email-jbe@pengutronix.de> <55A8FEAE.9010502@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55A8FEAE.9010502@hurleysoftware.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Friday 17 July 2015 15:10:06 Peter Hurley wrote:
> On 07/16/2015 03:40 AM, Juergen Borleis wrote:
> > Whenever the UART device driver gets closed from userland, the driv=
er
> > disables the UART unit and then stops its clock to save power.
> >
> > The bit which disabled the UART unit is described as:
> >
> >   "UART Enable. If this bit is set to 1, the UART is enabled. Data
> >   transmission and reception occurs for the UART signals. When the
> >   UART is disabled in the middle of transmission or reception, it
> >   completes the current character before stopping."
> >
> > The important part is the "it completes the current character". Whe=
never
> > a reception is ongoing when the UART gets disabled (including the c=
lock
> > off) the statemachine freezes and "remembers" this state on the nex=
t
> > open() and re-enabling of the unit's clock.
> >
> > In this case we end up receiving an additional bogus character
> > immediately.
> >
> > The solution in this change is to move the AUART unit into its rese=
t
> > state on close() and only release it from its reset state on the ne=
xt
> > open().
> >
> > Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> > ---
> >
> > Notes:
> >     v3:
> >      - missing newline added to an error message
> >
> >     v2:
> >      - rename mxs_auart_do_reset() to mxs_auart_keep_reset() to bet=
ter
> > reflect what it really does
> >      - adapt the delay in mxs_auart_keep_reset() to wait for the re=
set of
> > the AURAT unit to what is used in mxs_auart_reset()
>
> The function names and semantics are not clear. See below.
>
> >      - typo fixed
> >
> >  drivers/tty/serial/mxs-auart.c | 38
> > ++++++++++++++++++++++++++++++-------- 1 file changed, 30 insertion=
s(+),
> > 8 deletions(-)
> >
> > diff --git a/drivers/tty/serial/mxs-auart.c
> > b/drivers/tty/serial/mxs-auart.c index 13cf773..135ee6c 100644
> > --- a/drivers/tty/serial/mxs-auart.c
> > +++ b/drivers/tty/serial/mxs-auart.c
> > @@ -858,6 +858,30 @@ static void mxs_auart_reset(struct uart_port *=
u)
> >  	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
> >  }
> >
> > +static void mxs_auart_keep_reset(struct uart_port *u)
> > +{
> > +	int i;
> > +	u32 reg;
> > +
> > +	reg =3D readl(u->membase + AUART_CTRL0);
> > +	/* if already in reset state, keep it untouched */
> > +	if (reg & AUART_CTRL0_SFTRST)
> > +		return;
> > +
> > +	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
> > +	writel(AUART_CTRL0_SFTRST, u->membase + AUART_CTRL0_SET);
> > +
> > +	for (i =3D 0; i < 10000; i++) {
> > +		reg =3D readl(u->membase + AUART_CTRL0);
> > +		/* reset is finished when the clock is gated */
> > +		if (reg & AUART_CTRL0_CLKGATE)
> > +			return;
> > +		udelay(3);
> > +	}
> > +
> > +	dev_err(u->dev, "Failed to reset the unit.\n");
> > +}
> > +
> >  static int mxs_auart_startup(struct uart_port *u)
> >  {
> >  	int ret;
> > @@ -867,7 +891,10 @@ static int mxs_auart_startup(struct uart_port =
*u)
> >  	if (ret)
> >  		return ret;
> >
> > -	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
> > +	/* reset the unit if not aleady done */
> > +	mxs_auart_keep_reset(u);
>
> Why is this performing a soft-reset on open now? Didn't
> mxs_auart_shutdown() already leave it in this state?

The probe function let the device left without reset. That is why I do =
a reset=20
here (which is skipped if the device is already in reset state).

> Because if you're performing a soft-reset deliberately as part of the
> initial condition, you make no mention of that in the changelog.

If I switch the device into the reset state immediately after the probe=
=20
function has finished, I could skip this additional reset.

> > +	/* bring it out of reset now */
> > +	mxs_auart_reset(u);
>
> mxs_auart_reset() is really not resetting but simply performing a blo=
ck
> enable. Isn't there a generic block enable for the iMX.2x SoCs? (Mayb=
e
> there should be)
>
> The names of these functions don't match expected operations of start=
up().
> Start up should be enabling the device, not keeping it in reset.
>
> And "keep reset" immediately followed by "reset" makes no sense.

mxs_auart_reset() is a bad name from the beginning. But I just wanted t=
o keep=20
this change small and only change things that are really required.
I will try with a V4.

Regards,
Juergen

--=20
Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Juergen Borleis =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
Linux Solutions for Science and Industry =C2=A0 =C2=A0 =C2=A0| Phone: +=
49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany =C2=A0 =C2=A0| Fax: =C2=A0 +=
49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| http://www.pengutronix.de/ =C2=A0|
