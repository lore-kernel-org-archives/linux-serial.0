From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
Date: Mon, 4 Jul 2011 11:28:05 +0200
Message-ID: <20110704092805.GH4338@pengutronix.de>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
 <1309679760-22796-2-git-send-email-shawn.guo@linaro.org>
 <20110703211007.GB13742@ponder.secretlab.ca>
 <20110704021923.GA10245@S2100-06.ap.freescale.net>
 <20110704073320.GB4338@pengutronix.de>
 <20110704084324.GE10245@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38443 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756822Ab1GDJ2O (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jul 2011 05:28:14 -0400
Content-Disposition: inline
In-Reply-To: <20110704084324.GE10245@S2100-06.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org

Hello Shawn,

On Mon, Jul 04, 2011 at 04:43:25PM +0800, Shawn Guo wrote:
> On Mon, Jul 04, 2011 at 09:33:20AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jul 04, 2011 at 10:19:25AM +0800, Shawn Guo wrote:
> > > > > +static struct platform_device_id imx_uart_devtype[] =3D {
> > > > > +	{
> > > > > +		.name =3D "imx1-uart",
> > > > > +		.driver_data =3D IMX1_UART,
> > > > > +	}, {
> > > > > +		.name =3D "imx-uart",
> > > > > +		.driver_data =3D IMX2_UART,
> > It feels strange to introduce IMX2 today meaning
> > i.MX{21,25,27,31,35,50,51,53}. I didn't check the changes in detail=
, but
> > if the only relevant change is that the UTS register is at a differ=
ent
>=20
> No, it's not the only relevant change.  The patch also changes a coup=
le of
> 'if (!cpu_is_imx1())' to 'if (IS_IMX2_UART())'.
>=20
> The 'IMX2' in 'IMX2_UART' does not necessarily mean i.MX{21,25,27,
> 31,35,50,51,53}.  It actually means i.MX{21,25,27,31,35,50,51,53} all
> have the same UART block which was firstly introduced on IMX2.
This is ugly. IMHO something like imx_uart_v2 would be much better.
=46or a driver that supports all i.MX generations

	if (IS_IMX2_UART())

is simply misleading. Even if you had documented at the definition
of imx_uart_type (and/or IS_IMX2_UART) that IMX2_UART means everything
currently known but MX1, just looking at the if condition yields wrong
expectations.

	if (cpu_is_imx1())

is much better (in this aspect). (At least until Freescale comes up wit=
h
a new SOC in the mx1 family that includes a completely new UART block
:-)

With

	if (somehow_get_current_driver_data() & SOME_FLAG)
		do_the(things, that, "are only needed with SOME_FLAG");

you can have both, even local understandable code and no dependency on
the cpu_is_... stuff.

> It's actually a change respecting the existing code, which defines
> MX2_ONEMS for all imx except imx1.
IMHO that's a bad excuse. Take it the other way 'round: You can do
better than the existing code (and even fix it on the go if you're
motivated).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
