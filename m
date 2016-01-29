From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 0/3] 8250: Split Fintek PCIE to UART to independent file
Date: Fri, 29 Jan 2016 23:08:08 +0530
Message-ID: <20160129173808.GB18826@sudip-laptop>
References: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20160119035649.GA1696@windriver.com>
 <569DF7C3.5050306@gmail.com>
 <20160119123327.3b519062@lxorguk.ukuu.org.uk>
 <1453209684.2521.115.camel@linux.intel.com>
 <569EF810.1000304@gmail.com>
 <20160120062214.GB3747@sudip-pc>
 <569F4444.3040104@gmail.com>
 <20160122105350.GA7023@sudip-pc>
 <CAHp75Vfk686mhCL4U83vxM4JL_Tn8kTxf960zru2d6wvj3QGpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vfk686mhCL4U83vxM4JL_Tn8kTxf960zru2d6wvj3QGpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Hung <hpeter@gmail.com>, Rob Groner <rgroner@rtd.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, soeren.grunewald@desy.de, Wang YanQing <udknight@gmail.com>, adam.lee@canonical.com, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, scottwood@freescale.com, Paul Burton <paul.burton@imgtec.com>, Matthias Brugger <matthias.bgg@gmail.com>, Joachim Eastwood <manabian@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.or
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 22, 2016 at 03:44:16PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 22, 2016 at 12:53 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > On Wed, Jan 20, 2016 at 04:24:36PM +0800, Peter Hung wrote:
> >> Hi Sudip,
> >>
> >> Sudip Mukherjee =E6=96=BC 2016/1/20 =E4=B8=8B=E5=8D=88 02:22 =E5=AF=
=AB=E9=81=93:
> >> >On Wed, Jan 20, 2016 at 10:59:28AM +0800, Peter Hung wrote:
> >>
> >> >But my personal opinion, if we move out the serial port related c=
ode
> >> >into a new driver (a new Kconfig symbol) userspace of many system=
 will
> >> >break if this new symbol is not enabled by the distributions. But=
 in the
> >> >way I have done the new symbol needs to be enabled only if the us=
er
> >> >wants to use the GPIO capability. If that is not enabled GPIO can=
not be
> >> >used but it will never break the serial port related code for the=
m.
> >> >I think we should give a thought to that before splitting out the=
 codes
> >> >from 8250_pci.
> >>
> >> I agree with your opinion. I'm trying to implement GPIO with 2 way=
s,
> >> One is like yours, add platform_device with in 8250_pci.c and impl=
ement
> >> GPIOLIB platform driver with in 'driver/gpio", and the other is tr=
ying
> >> split out from 8250_pci.c to MFD.
> >>
> >> In my personal opinion, the first method is less impact with compa=
tible
> >> old system.
> >
> > Looks like no one else is in support of our opinion. Fair enough, I=
 will
> > split out the related code from 8250_pci and create the MFD driver =
this
> > weekend for my hardware.
>=20
> Yeah, MFD looks preferable.
>=20
> Btw, don't forget to backlist your devices in 8250_pci since they
> quite possible provide a PCI class which is used by 8250_pci driver
> for default enumeration.

One doubt. If I have understood correctly the main reason you have aske=
d
me to split the code out of 8250_pci so that the size reduces. But
pci_xr17v35x_setup() is also used by another card which has
PCI_VENDOR_ID_COMMTECH. So even if I create a separate file for exar ca=
rds,
almost identical function will still remain in 8250_pci.

regards
sudip
