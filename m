From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 09/11] serial: 8250_lpss: move Quark code from PCI
 driver
Date: Wed, 04 May 2016 20:43:12 +0300
Message-ID: <1462383792.17131.265.camel@linux.intel.com>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1461764894-14891-10-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1462354262.27858.153.camel@nexus-software.ie>
	 <CAHp75VcgRi2wuBoZ8iQaKTCrv2p4sY5G9wcXgBtW=6_4pWv6Sg@mail.gmail.com>
	 <1462355477.27858.161.camel@nexus-software.ie>
	 <CAHp75VfW3UVLEvnPoG1AzeYrQ=GRgqZ-pJWbVgSfMs5j2hEwCA@mail.gmail.com>
	 <1462359696.27858.184.camel@nexus-software.ie>
	 <1462360835.17131.224.camel@linux.intel.com>
	 <1462373469.27858.203.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462373469.27858.203.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-05-04 at 15:51 +0100, Bryan O'Donoghue wrote:
> On Wed, 2016-05-04 at 14:20 +0300, Andy Shevchenko wrote:
>=20
> >=20
> > >=20
> > > To move away from a valid/standard PCI probe routine into a new
> > > special
> > > LPSS/PCI shim (which the hardware doesn't actually mandate) I do
> > > think
> > > you should to setup the dependency CONFIG_8250_PCI =3D>
> > > CONFIG_8250_LPSS.
> > No, this is what we try avoiding
> Fine.
>=20
> Could you then select CONFIG_SERIAL_8250_LPSS when
> CONFIG_X86_INTEL_QUARK is true - since it will be a dependency.

Answered to this in the other email, but can repeat my question. Do you
propose a new behaviour? Otherwise how does it work right now?

>=20
> >=20
> > If user selects CONFIG_SERIAL_8250_PCI, the CONFIG_SERIAL_8250_LPSS
> > will
> > be selected as well since it has same dependencies.
> I still think the change is not an obvious one i.e. LPSS (as an ACPI
> enumeration concept)

LPSS is a hardware concept. It might be not exactly one island on the
SoC, but it pretty much includes all those serial bus controllers and
DMA.

>  is not a requirement to enumerate on Quark X1000.
>=20
> So I understand why you want to separate out the code from 8250_pci -
> however I think the *minimum* here should be a descriptive comment in
> kconfig listing which PCI-enumerated SoCs now require the 8250_LPSS
> work-around if just selecting 8250_LPSS isn't possible.
>=20
> So how about listing out those SoCs - something like
>=20
> "Selecting this option will enable handling of the extra features=C2=A0
> =C2=A0present on the UART found on Intel Braswell SoC and various=C2=A0=
=C2=A0other
> =C2=A0Intel platforms."
>=20
> =3D>
>=20
> "Selecting this option will enable handling of the extra features=C2=A0
> =C2=A0present on the UART found on
> =C2=A0- Intel Braswell SoC
> =C2=A0- Intel Quark x1000 SoC
> =C2=A0- etc
> "
> If you make those changes - please add.

That would work for me. Will update it in next version. I'm still give =
a
time to answer for the questions above. I want us to be on the same
page.

> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@nexus-software.ie>

Thanks for review!

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
