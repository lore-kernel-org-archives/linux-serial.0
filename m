From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 0/3] 8250: Split Fintek PCIE to UART to independent file
Date: Fri, 22 Jan 2016 16:23:50 +0530
Message-ID: <20160122105350.GA7023@sudip-pc>
References: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20160119035649.GA1696@windriver.com>
 <569DF7C3.5050306@gmail.com>
 <20160119123327.3b519062@lxorguk.ukuu.org.uk>
 <1453209684.2521.115.camel@linux.intel.com>
 <569EF810.1000304@gmail.com>
 <20160120062214.GB3747@sudip-pc>
 <569F4444.3040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <569F4444.3040104@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: Rob Groner <rgroner@rtd.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Paul Gortmaker <paul.gortmaker@windriver.com>, gregkh@linuxfoundation.org, jslaby@suse.com, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, yamada.masahiro@socionext.com, mans@mansr.com, scottwood@freescale.com, paul.burton@imgtec.com, matthias.bgg@gmail.com, manabian@gmail.com, peter.ujfalusi@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 20, 2016 at 04:24:36PM +0800, Peter Hung wrote:
> Hi Sudip,
>=20
> Sudip Mukherjee =E6=96=BC 2016/1/20 =E4=B8=8B=E5=8D=88 02:22 =E5=AF=AB=
=E9=81=93:
> >On Wed, Jan 20, 2016 at 10:59:28AM +0800, Peter Hung wrote:
>=20
> >But my personal opinion, if we move out the serial port related code
> >into a new driver (a new Kconfig symbol) userspace of many system wi=
ll
> >break if this new symbol is not enabled by the distributions. But in=
 the
> >way I have done the new symbol needs to be enabled only if the user
> >wants to use the GPIO capability. If that is not enabled GPIO cannot=
 be
> >used but it will never break the serial port related code for them.
> >I think we should give a thought to that before splitting out the co=
des
> >from 8250_pci.
>=20
> I agree with your opinion. I'm trying to implement GPIO with 2 ways,
> One is like yours, add platform_device with in 8250_pci.c and impleme=
nt
> GPIOLIB platform driver with in 'driver/gpio", and the other is tryin=
g
> split out from 8250_pci.c to MFD.
>=20
> In my personal opinion, the first method is less impact with compatib=
le
> old system.

Looks like no one else is in support of our opinion. Fair enough, I wil=
l
split out the related code from 8250_pci and create the MFD driver this
weekend for my hardware.

regards
sudip
