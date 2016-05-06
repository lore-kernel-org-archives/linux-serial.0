From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 03/11] dmaengine: dw: set polarity of handshake
 interface
Date: Fri, 06 May 2016 21:08:03 +0300
Message-ID: <1462558083.17131.287.camel@linux.intel.com>
References: <20160506174805.61f64dba@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160506174805.61f64dba@kerio.vanmierlo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maarten Brock <m.brock@vanmierlo.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-05-06 at 17:48 +0200, Maarten Brock wrote:

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0polarity;
> > > > > So this variable is not very intuitively named.
> > > > There is a help above. This is a property of the Synopsys
> > > > DesignWare DMA
> > > > engine. Anyone familiar with datasheet easily understands this.
> > > >=20
> > > > >=20
> > > > >=20
> > > > > You end up setting somepointer->polarity =3D true; in a later
> > > > > patch.
> > > > >=20
> > > > > Since you're respining a V4 I'd suggest a name that describes
> > > > > a little
> > > > > bit better than polarity. Setting polarity =3D true is a litt=
le
> > > > > bit
> > > > > liked being asked "you you like ice-cream or apple pie" and
> > > > > then
> > > > > saying "yes please".
> > > > It's about handshake interface polarity, so, what about
> > > > hs_polarity?
> > > So it means: handshake has polarity (true) or handshake has no
> > > polarity
> > > (omnidirectional?) (false), right?
> > It means that handshake polarity _signal_ is inverted (true) or
> > default (false) in terms of hardware gates.
> Would it not be better then to name it handshake_inverted ? That is
> something you can ask and answer with true or false.
>=20

I would stick for now with hs_polarity as agreed with Bryan. Without
specification any (more or less short) name will suck anyway.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
