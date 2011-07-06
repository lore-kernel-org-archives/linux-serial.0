From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
Date: Wed, 6 Jul 2011 13:53:32 +0800
Message-ID: <20110706055331.GD26324@S2100-06.ap.freescale.net>
References: <1309878338-25697-1-git-send-email-shawn.guo@linaro.org>
 <1309878338-25697-2-git-send-email-shawn.guo@linaro.org>
 <CACxGe6v+izZiANbzvhnTvrLU9+XgXD=W8FNGfTLzGXLNuCjZcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:34562 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751093Ab1GFFrL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Jul 2011 01:47:11 -0400
Content-Disposition: inline
In-Reply-To: <CACxGe6v+izZiANbzvhnTvrLU9+XgXD=W8FNGfTLzGXLNuCjZcg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Shawn Guo <shawn.guo@linaro.org>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>

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
>=20
I think it will be easier to go Sascha's tree.  Alan, Sascha, what
do you think?

--=20
Regards,
Shawn

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
