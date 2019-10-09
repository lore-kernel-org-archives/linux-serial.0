From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] tty: serial: imx: Only get second/third IRQ when there
 is more than one IRQ
Date: Wed, 9 Oct 2019 09:14:03 +0200
Message-ID: <20191009071403.ugd2wuac6ue5zsd6@pengutronix.de>
References: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
 <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
 <DB3PR0402MB39165F9CE876772F8F94F187F5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39165F9CE876772F8F94F187F5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "festevam@gmail.com" <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "jslaby@suse.com" <jslaby@suse.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello,

On Wed, Oct 09, 2019 at 06:58:24AM +0000, Anson Huang wrote:
> > On Wed, Oct 09, 2019 at 02:18:31PM +0800, Anson Huang wrote:
> > > All i.MX SoCs except i.MX1 have ONLY 1 IRQ, so it is better to check
> > > the IRQ count before getting second/third IRQ to avoid below error
> > > message during probe:
> > >
> > > [    0.726219] imx-uart 30860000.serial: IRQ index 1 not found
> > > [    0.731329] imx-uart 30860000.serial: IRQ index 2 not found
> > =

> > This message was introduced in commit
> > 7723f4c5ecdb8d832f049f8483beb0d1081cedf6 for 5.4-rc1. I added the
> > involved people to the recipents of this mail.
> =

> Yes, I noticed this, thanks.
> =

> > =

> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  drivers/tty/serial/imx.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> > > 504d81c..081fa82 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -2198,6 +2198,7 @@ static int imx_uart_probe(struct platform_device
> > *pdev)
> > >  	u32 ucr1;
> > >  	struct resource *res;
> > >  	int txirq, rxirq, rtsirq;
> > > +	int irq_count;
> > >
> > >  	sport =3D devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
> > >  	if (!sport)
> > > @@ -2220,9 +2221,17 @@ static int imx_uart_probe(struct
> > platform_device *pdev)
> > >  	if (IS_ERR(base))
> > >  		return PTR_ERR(base);
> > >
> > > +	irq_count =3D platform_irq_count(pdev);
> > > +	if (irq_count < 0)
> > > +		return irq_count;
> > > +
> > >  	rxirq =3D platform_get_irq(pdev, 0);
> > > -	txirq =3D platform_get_irq(pdev, 1);
> > > -	rtsirq =3D platform_get_irq(pdev, 2);
> > > +	if (irq_count > 1) {
> > > +		txirq =3D platform_get_irq(pdev, 1);
> > > +		rtsirq =3D platform_get_irq(pdev, 2);
> > > +	} else {
> > > +		txirq =3D rtsirq =3D -ENXIO;
> > > +	}
> > =

> > The patch is fine given the changed behaviour of platform_get_irq. I wo=
nder
> > if it is sensible to introduce a variant of platform_get_irq (say
> > platform_get_irq_nowarn) that behaves like __platform_get_irq does t
> > Then the imx driver would just call platform_get_irq_nowarn without hav=
ing
> > to check the number of available irqs first.
> =

> Agreed, it would be nice if we can fix this from the API level, this
> is to save many patches from various drivers side, let me know if
> agreement is reached and I will do the patch.

I wouldn't expect that most callers actually want an error message and
so these need a different patch (i.e. dropping the error message by the
caller). This type of patch is fine and the normal load when something
is consolidated.

Which other drivers do you have on your radar that don't want an error
message if platform_get_irq() fails?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
