From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 09/11] serial: 8250_lpss: move Quark code from PCI
 driver
Date: Wed, 04 May 2016 17:55:10 +0300
Message-ID: <1462373710.17131.257.camel@linux.intel.com>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1461764894-14891-10-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1462354262.27858.153.camel@nexus-software.ie>
	 <CAHp75VcgRi2wuBoZ8iQaKTCrv2p4sY5G9wcXgBtW=6_4pWv6Sg@mail.gmail.com>
	 <1462355477.27858.161.camel@nexus-software.ie>
	 <CAHp75VfW3UVLEvnPoG1AzeYrQ=GRgqZ-pJWbVgSfMs5j2hEwCA@mail.gmail.com>
	 <1462359696.27858.184.camel@nexus-software.ie>
	 <1462360835.17131.224.camel@linux.intel.com>
	 <1462372640.27858.192.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462372640.27858.192.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-05-04 at 15:37 +0100, Bryan O'Donoghue wrote:
> On Wed, 2016-05-04 at 14:20 +0300, Andy Shevchenko wrote:
> >=20
> > On Wed, 2016-05-04 at 12:01 +0100, Bryan O'Donoghue wrote:
> > >=20
> > > On Wed, 2016-05-04 at 13:03 +0300, Andy Shevchenko wrote:
> > > >=20
> > > >=20
> > > > On Wed, May 4, 2016 at 12:51 PM, Bryan O'Donoghue
> > > > <pure.logic@nexus-software.ie> wrote:
> > > > >=20
> > > > >=20
> > > > > The default may be set to SERIAL_8250 but, without the QRK
> > > > > specific
> > > > > entry in 8250_pci.c you won't get console output.
> > That's, by the way, not true.
> Since when ? We don't have an I/O bar so mapping the MMIO bar @ the
> right register width is required.

Since this series.
8250_lpss will be enabled as long as user doesn't enable EXPERT and
_explicitly_ _disables_ it.

Same is applied to SERIAL_8250_PCI. If you look at the default kernel
configurations such as i386_default you don't find that option there.

Btw, I have to clean up such in my branches.

>=C2=A0
> > > > > So if you are going to remove the QRK entry from 8250_pci.c
> > > > > and
> > > > > stuff
> > > > > it into 8250_lpss.c then 8250_lpss needs to be selected by
> > > > > CONFIG_SERIAL_8250_PCI.
> > > > Why?!
> > > >=20
> > > > Now it should be enough to have SERIAL_8250 set to non-n to hav=
e
> > > > 8250_lpss compiled.
> > > > Can you check it?
> > > I'm sure that's true.
> > >=20
> > > My point to you is that - its a highly non-intuitive thing to do
> > > on
> > > a
> > > reading of the datasheet for this part.
> > >=20
> > > LPSS is, ostensibly at least, for passing processor resources via
> > > APCI.
> > >=20
> > > If you look at a QRK datasheet it says "enumerate all this stuff
> > > via
> > > PCI" - there's not a single mention of LPSS. Its reasonable,
> > > correct
> > > and currently required for QRK to set CONFIG_8250_PCI.
> > User has no such item even visible until enable CONFIG_EXPERT.
> >=20
> > Heikki sent an answer to you (and to the list, but by some reason
> > it's
> > not yet there) an hour ago.
> >=20
> > >=20
> > >=20
> > > To move away from a valid/standard PCI probe routine into a new
> > > special
> > > LPSS/PCI shim (which the hardware doesn't actually mandate) I do
> > > think
> > > you should to setup the dependency CONFIG_8250_PCI =3D>
> > > CONFIG_8250_LPSS.
> > No, this is what we try avoiding, thus it will not happen.
> >=20
> > If user selects CONFIG_SERIAL_8250_PCI, the CONFIG_SERIAL_8250_LPSS
> > will
> > be selected as well since it has same dependencies.
> Hmm. I think what you mean to say is that a user (expert or not)
> *would* select SERIAL_8250_LPSS since (at least in your branch
> =C2=A009c4268121a39eb3973823dd9225b650df726f67) both options may be
> individually selected/deselected.

So, currently it works in such way that user enables SERIAL_8250 and
_dependencies_, which are PCI (for SERIAL_8250_PCI) or PCI && X86 (for
SERIAL_8250_LPSS) and drivers will be built automatically on the same
level (m or y) as SERIAL_8250.

Nevertheless, user may _disable_ them if needed using EXPERT option.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
