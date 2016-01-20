From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 0/3] 8250: Split Fintek PCIE to UART to independent file
Date: Wed, 20 Jan 2016 11:52:14 +0530
Message-ID: <20160120062214.GB3747@sudip-pc>
References: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20160119035649.GA1696@windriver.com>
 <569DF7C3.5050306@gmail.com>
 <20160119123327.3b519062@lxorguk.ukuu.org.uk>
 <1453209684.2521.115.camel@linux.intel.com>
 <569EF810.1000304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <569EF810.1000304@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>, Rob Groner <rgroner@rtd.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Paul Gortmaker <paul.gortmaker@windriver.com>, gregkh@linuxfoundation.org, jslaby@suse.com, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, yamada.masahiro@socionext.com, mans@mansr.com, scottwood@freescale.com, paul.burton@imgtec.com, matthias.bgg@gmail.com, manabian@gmail.com, peter.ujfalusi@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 20, 2016 at 10:59:28AM +0800, Peter Hung wrote:
> Hi Andy, Alan
>=20
> Andy Shevchenko =E6=96=BC 2016/1/19 =E4=B8=8B=E5=8D=88 09:21 =E5=AF=AB=
=E9=81=93:
> >>Your device is multi-function. Create an MFD driver for it. Make th=
e
> >>8250 driver bind to the MFD, and provide your own baud rate methods
> >>within the standard 8250 layer
> >
> >Ouch, somehow I missed this one!
> >
> >Peter, Alan's suggestion is really worth to try.
> >
>=20
> Thanks for point this. It seems good to probe on MFD driver, them MFD
> register platform devices to invoke platform driver to initialize
> sub-parts. I'll try to survey first.
>=20
> But I had a new question, If I really do it with MFD subsystem, it'll
> split into 3 parts, MFD probe(driver/mfd) / GPIO (driver/gpio) / UART
> (drivers/tty/serial/8250). It'll cross more than 2 subsystems and
> maintainers How should I do to organize the patches?
>=20
> For examples, I should remove the probe function in 8250_pci.c and
> move it to new MFD file. It should organize it in the same patch as P=
aul
> said, but this patch will need 2 subsystem maintainer to do with the
> same patch, it seems weird.
>=20
> Andy had cc "[PATCH v5] serial: 8250: add gpio support to exar" to me=
,
> could I use the same way to do GPIOLIB? First add a platform driver
> for F81504 gpio and add platform device into 8250_pci.c? It seems to
> be good and simple to implement.

+ Rob

Your hardware and my hardware both are almost same, so I guess the
discussion and the decision will apply to both of us.
And to have it as MFD, we can have a look at sm501.c it has serial and
gpio both.
But my personal opinion, if we move out the serial port related code
into a new driver (a new Kconfig symbol) userspace of many system will
break if this new symbol is not enabled by the distributions. But in th=
e
way I have done the new symbol needs to be enabled only if the user
wants to use the GPIO capability. If that is not enabled GPIO cannot be
used but it will never break the serial port related code for them.
I think we should give a thought to that before splitting out the codes
from 8250_pci.

regards
sudip
