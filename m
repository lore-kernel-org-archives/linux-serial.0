From: "Maarten Brock" <m.brock@vanmierlo.com>
Subject: Re: [PATCH v3 03/11] dmaengine: dw: set polarity of handshake
 interface
Date: Fri, 06 May 2016 13:20:19 +0200
Message-ID: <20160506132019.019e5db0@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

----- Original Message -----
=46rom: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
To: Bryan O'Donoghue [mailto:pure.logic@nexus-software.ie], Peter Hurle=
y [mailto:peter@hurleysoftware.com], linux-serial@vger.kernel.org, Vino=
d Koul [mailto:vinod.koul@intel.com], linux-kernel@vger.kernel.org, dma=
engine@vger.kernel.org, Greg Kroah-Hartman [mailto:gregkh@linuxfoundati=
on.org], ismo.puustinen@intel.com, Heikki Krogerus [mailto:heikki.kroge=
rus@linux.intel.com]
Sent: Fri, 06 May 2016 12:42:00 +0200
Subject: Re: [PATCH v3 03/11] dmaengine: dw: set polarity of handshake =
interface


> On Thu, 2016-05-05 at 18:54 +0100, Bryan O'Donoghue wrote:
> > On Wed, 2016-04-27 at 16:48 +0300, Andy Shevchenko wrote:
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0polarity;
> > So this variable is not very intuitively named.
>=20
> There is a help above. This is a property of the Synopsys DesignWare =
DMA
> engine. Anyone familiar with datasheet easily understands this.
>=20
> >=20
> > You end up setting somepointer->polarity =3D true; in a later patch=
=2E=C2=A0
> >=20
> > Since you're respining a V4 I'd suggest a name that describes a lit=
tle
> > bit better than polarity. Setting polarity =3D true is a little bit
> > liked being asked "you you like ice-cream or apple pie" and then
> > saying "yes please".
>=20
> It's about handshake interface polarity, so, what about hs_polarity?

So it means: handshake has polarity (true) or handshake has no polarity
(omnidirectional?) (false), right?

Maarten
