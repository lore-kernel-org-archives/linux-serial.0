From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/3] 8250: Split Fintek PCIE to UART to independent file
Date: Tue, 19 Jan 2016 11:33:44 +0200
Message-ID: <1453196024.2521.108.camel@linux.intel.com>
References: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
	 <20160119035649.GA1696@windriver.com> <569DF7C3.5050306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <569DF7C3.5050306@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, yamada.masahiro@socionext.com, mans@mansr.com, scottwood@freescale.com, paul.burton@imgtec.com, matthias.bgg@gmail.com, manabian@gmail.com, peter.ujfalusi@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-01-19 at 16:45 +0800, Peter Hung wrote:
> Hi Paul,
>=20
> Paul Gortmaker =E6=96=BC 2016/1/19 =E4=B8=8A=E5=8D=88 11:56 =E5=AF=AB=
=E9=81=93:
> > > The serial ports support from 50bps to 1.5Mbps with Linux
> > > baudrate
> > > define excluding 1.0Mbps due to not support 16MHz clock source.
> >=20
> > How does this differ from what was achieved or possible with the
> > old way
> > of things?=C2=A0=C2=A0What was the limitation in the existing 8250 =
code
> > sharing
> > that required Fintek code to fork and become independent?
>=20
> The architecture of 8250_pci.c is good for PCIE device with 8250
> compatible serial ports. We want to implement all functions of
> F81504/508/512, but it'll make 8250_pci.c bloated and complex if we
> implement GPIOLIB in 8250_pci.c
>=20
> Could I implement GPIOLIB within 8250_pci.c instead of a newer file?

Hm=E2=80=A6 So, can we stick with separate driver, or you're gonna shak=
e for
each reviewer's comment?

>=20
> > How much code was just copied 8250 boilerplate vs. being a new
> > implementation?=C2=A0=C2=A0The diffstat shows approx 500 lines of n=
ew
> > code.=C2=A0=C2=A0What
> > does that add vs. just copying?
>=20
> Due to this IC contains 8250-compatible ports, the most functions is
> copy from fintek section of 8250_pci.c. The differences are highbaud
> rate & GPIOLIB implementations.

I agree with Paul, I think what you have done is to:

1) split out existing code to separate driver (no your changes, but
minimum necessary to this split) =E2=80=94 one patch!
2) clean up it (at least I see the old PM code which should be
refactored)
3) enhance functionality accordingly to what you need.

>=20
> >=20
> > If someone had 8250 (PCI) builtin before, and Fintek stops working,
> > they will most guaranteed bisect to this commit above where you
> > remove
> > support.=C2=A0=C2=A0That is less than ideal.=C2=A0=C2=A0We try to a=
void code deletions
> > or
> > Kconfig addtions that will be obvious bisect magnets.
>=20
> It can be prevented if implements GPIOLIB in 8250_pci.c.

Yeah, see item 1) above.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
