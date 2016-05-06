From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 03/11] dmaengine: dw: set polarity of handshake
 interface
Date: Fri, 06 May 2016 13:42:00 +0300
Message-ID: <1462531320.17131.277.camel@linux.intel.com>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1461764894-14891-4-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1462470851.2404.6.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462470851.2404.6.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 2016-05-05 at 18:54 +0100, Bryan O'Donoghue wrote:
> On Wed, 2016-04-27 at 16:48 +0300, Andy Shevchenko wrote:
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0polarity;
> So this variable is not very intuitively named.

There is a help above. This is a property of the Synopsys DesignWare DM=
A
engine. Anyone familiar with datasheet easily understands this.

>=20
> You end up setting somepointer->polarity =3D true; in a later patch.=C2=
=A0
>=20
> Since you're respining a V4 I'd suggest a name that describes a littl=
e
> bit better than polarity. Setting polarity =3D true is a little bit
> liked
> being asked "you you like ice-cream or apple pie" and then saying "ye=
s
> please".

It's about handshake interface polarity, so, what about hs_polarity?

--=C2=A0
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
