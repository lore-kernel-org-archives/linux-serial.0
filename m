From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH 0/3] 8250: Split Fintek PCIE to UART to independent file
Date: Wed, 20 Jan 2016 16:24:36 +0800
Message-ID: <569F4444.3040104@gmail.com>
References: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20160119035649.GA1696@windriver.com> <569DF7C3.5050306@gmail.com>
 <20160119123327.3b519062@lxorguk.ukuu.org.uk>
 <1453209684.2521.115.camel@linux.intel.com> <569EF810.1000304@gmail.com>
 <20160120062214.GB3747@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160120062214.GB3747@sudip-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Rob Groner <rgroner@rtd.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Paul Gortmaker <paul.gortmaker@windriver.com>, gregkh@linuxfoundation.org, jslaby@suse.com, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, yamada.masahiro@socionext.com, mans@mansr.com, scottwood@freescale.com, paul.burton@imgtec.com, matthias.bgg@gmail.com, manabian@gmail.com, peter.ujfalusi@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Sudip,

Sudip Mukherjee =E6=96=BC 2016/1/20 =E4=B8=8B=E5=8D=88 02:22 =E5=AF=AB=E9=
=81=93:
> On Wed, Jan 20, 2016 at 10:59:28AM +0800, Peter Hung wrote:

> But my personal opinion, if we move out the serial port related code
> into a new driver (a new Kconfig symbol) userspace of many system wil=
l
> break if this new symbol is not enabled by the distributions. But in =
the
> way I have done the new symbol needs to be enabled only if the user
> wants to use the GPIO capability. If that is not enabled GPIO cannot =
be
> used but it will never break the serial port related code for them.
> I think we should give a thought to that before splitting out the cod=
es
> from 8250_pci.

I agree with your opinion. I'm trying to implement GPIO with 2 ways,
One is like yours, add platform_device with in 8250_pci.c and implement
GPIOLIB platform driver with in 'driver/gpio", and the other is trying
split out from 8250_pci.c to MFD.

In my personal opinion, the first method is less impact with compatible
old system.
--=20
With Best Regards,
Peter Hung
