From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/5] ARM: dts: imx6: rename the uart's compatible
 property
Date: Tue, 2 Jul 2013 12:11:18 +0100
Message-ID: <20130702111118.GE31358@e106331-lin.cambridge.arm.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
 <1372746628-20092-4-git-send-email-b32955@freescale.com>
 <20130702095645.GD31358@e106331-lin.cambridge.arm.com>
 <51D2AEC1.6030004@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:64178 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755704Ab3GBLL5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jul 2013 07:11:57 -0400
Content-Disposition: inline
In-Reply-To: <51D2AEC1.6030004@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Jul 02, 2013 at 11:43:13AM +0100, Huang Shijie wrote:
> =E4=BA=8E 2013=E5=B9=B407=E6=9C=8802=E6=97=A5 17:56, Mark Rutland =E5=
=86=99=E9=81=93:
> > On Tue, Jul 02, 2013 at 07:30:26AM +0100, Huang Shijie wrote:
> >> >  The imx6 uart can supports the DMA, imx uart driver has added a=
 new
> >> >  compatible property for the imx6 uart.
> >> > =20
> >> >  In order to enable the DMA for some uart port in imx6, we renam=
e the
> >> >  uart's compatible property to "fsl,imx6-uart".
> > Doesn't this change break using these dts with an older kernel? You
> is it reasonable to use a new dts with an old kernel?

As long as everything required to boot is described in a fashion the ol=
d
kernel understands, I see no reason it shouldn't be. I certainly see no
reason to break compatibility with an old kernel by *removing* a
compatible string ("fsl,imx21-uart") that should not break newer
kernels if they choose to use the more-specific compatible string.

>=20
>=20
> > remove the "fsl,imx21-uart" string older kernels understand.
> >
> > Given you already had "fsl,imx6q-uart" and "fsl,imx6sl-uart" string=
s,
> > would it not have made more sense to just add these to the driver?
> I think it's not a good idea.

Are there instances of "fsl-imx6q-uart" or "fsl,imx6sl-uart" that aren'=
t
compatible with this new "fsl,imx6-uart" (i.e. are any not DMA capable)=
?

If not, then using the existing binding gives the same behaviour withou=
t
confusing everyone by adding a slightly different compatible string,
without the churn caused by modifying the dts, and the cost to Linux is
a single line. Boards with a pre-built dtb will get the new
functionality by just changing the Linux image.

I don't see what's wrong with this.

Thanks,
Mark.

>=20
> Shawn, what's your opinion about this?
>=20
> thanks
> Huang Shijie
>=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
