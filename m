From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
Date: Mon, 4 Jul 2011 18:26:59 +0800
Message-ID: <20110704102657.GI10245@S2100-06.ap.freescale.net>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
 <1309679760-22796-2-git-send-email-shawn.guo@linaro.org>
 <20110703211007.GB13742@ponder.secretlab.ca>
 <20110704021923.GA10245@S2100-06.ap.freescale.net>
 <20110704073320.GB4338@pengutronix.de>
 <20110704084324.GE10245@S2100-06.ap.freescale.net>
 <20110704092805.GH4338@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:38681 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab1GDKUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jul 2011 06:20:41 -0400
Content-Disposition: inline
In-Reply-To: <20110704092805.GH4338@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org

On Mon, Jul 04, 2011 at 11:28:05AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Shawn,
>=20
> On Mon, Jul 04, 2011 at 04:43:25PM +0800, Shawn Guo wrote:
> > On Mon, Jul 04, 2011 at 09:33:20AM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Mon, Jul 04, 2011 at 10:19:25AM +0800, Shawn Guo wrote:
> > > > > > +static struct platform_device_id imx_uart_devtype[] =3D {
> > > > > > +	{
> > > > > > +		.name =3D "imx1-uart",
> > > > > > +		.driver_data =3D IMX1_UART,
> > > > > > +	}, {
> > > > > > +		.name =3D "imx-uart",
> > > > > > +		.driver_data =3D IMX2_UART,
> > > It feels strange to introduce IMX2 today meaning
> > > i.MX{21,25,27,31,35,50,51,53}. I didn't check the changes in deta=
il, but
> > > if the only relevant change is that the UTS register is at a diff=
erent
> >=20
> > No, it's not the only relevant change.  The patch also changes a co=
uple of
> > 'if (!cpu_is_imx1())' to 'if (IS_IMX2_UART())'.
> >=20
> > The 'IMX2' in 'IMX2_UART' does not necessarily mean i.MX{21,25,27,
> > 31,35,50,51,53}.  It actually means i.MX{21,25,27,31,35,50,51,53} a=
ll
> > have the same UART block which was firstly introduced on IMX2.
> This is ugly. IMHO something like imx_uart_v2 would be much better.

I will be very careful to define version number for IP block while
hardware people do not.  When some day they do, we will probably have
the version number we defined today conflicting with the one they
will define.

> For a driver that supports all i.MX generations
>=20
> 	if (IS_IMX2_UART())
>=20
> is simply misleading. Even if you had documented at the definition
> of imx_uart_type (and/or IS_IMX2_UART) that IMX2_UART means everythin=
g
> currently known but MX1, just looking at the if condition yields wron=
g
> expectations.
>=20
To address your concern, I will rename IMX2_UART to IMX_UART.

--=20
Regards,
Shawn

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
