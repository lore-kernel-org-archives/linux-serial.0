From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
Date: Wed, 6 Jul 2011 14:57:47 +0800
Message-ID: <20110706065746.GE26324@S2100-06.ap.freescale.net>
References: <1309878338-25697-1-git-send-email-shawn.guo@linaro.org>
 <1309878338-25697-2-git-send-email-shawn.guo@linaro.org>
 <CACxGe6v+izZiANbzvhnTvrLU9+XgXD=W8FNGfTLzGXLNuCjZcg@mail.gmail.com>
 <20110706063648.GM6069@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:30703
	"EHLO CH1EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750930Ab1GFGvp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Jul 2011 02:51:45 -0400
Content-Disposition: inline
In-Reply-To: <20110706063648.GM6069@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wed, Jul 06, 2011 at 08:36:48AM +0200, Sascha Hauer wrote:
> On Tue, Jul 05, 2011 at 11:27:55AM -0600, Grant Likely wrote:
> > On Tue, Jul 5, 2011 at 9:05 AM, Shawn Guo <shawn.guo@linaro.org> wr=
ote:
> > > The patch removes all the uses of cpu_is_mx1(). =A0Instead, it us=
es
> > > the .id_table of platform_driver to distinguish the uart device t=
ype.
> > >
> > > A couple of !cpu_is_mx1() logic gets turned into IS_IMX_UART, as =
the
> > > codes wrapped there are really IMX specific.
> > >
> > > It also removes macro MX1_UCR3_REF25 and MX1_UCR3_REF30 which are
> > > not used anywhere.
> > >
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> >=20
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> >=20
> > Who's tree is this one going to get merged through?
>=20
> Before we merge this through any tree I'd like to have a policy how
> the bindings are named. With the gpio part we agreed that we name
> the bindings after the oldest i.MX they are compatible with. For exam=
ple
> the last change in the gpios was on the i.MX31, so every newer i.MX
> claims to be compatible with this the i.MX31.
>=20
> The patch below instead follows the approach that the currently newes=
t
> i.MX gets a generic name (imx-uart instead of imx21-uart). This decis=
ion
> may look silly when another change to the uart core comes and we have
> given the generic name to some arbitrary version of the core.
>=20
> I really like to have a consistent scheme across all devices and we h=
ave
> the same problem with spi, nand and several others.
>=20
Makes sense.  Will fix it in v3.

--=20
Regards,
Shawn

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
