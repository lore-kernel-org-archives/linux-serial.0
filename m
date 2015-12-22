From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Tue, 22 Dec 2015 09:57:07 +0530
Message-ID: <20151222042707.GA3250@sudip-pc>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20151220164353.6ef29f77@lxorguk.ukuu.org.uk>
 <20151220172841.GB8471@sudip-laptop>
 <20151220174208.1447d2f3@lxorguk.ukuu.org.uk>
 <20151221151904.GA23780@sudip-pc>
 <CAHp75VfF_f=4MFmk9D1eLYanVyQyr+Fr8RBY81Pw+dyGZ7e0xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfF_f=4MFmk9D1eLYanVyQyr+Fr8RBY81Pw+dyGZ7e0xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 21, 2015 at 08:28:51PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 21, 2015 at 5:19 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
>=20
> > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8=
250/Kconfig
> > index 6412f14..ec3d287 100644
> > --- a/drivers/tty/serial/8250/Kconfig
> > +++ b/drivers/tty/serial/8250/Kconfig
> > @@ -378,3 +378,11 @@ config SERIAL_8250_MID
> >           Selecting this option will enable handling of the extra f=
eatures
> >           present on the UART found on Intel Medfield SOC and vario=
us other
> >           Intel platforms.
> > +
> > +config SERIAL_8250_EXAR_GPIO
> > +       bool "Support for GPIO pins on XR17V352/354/358"
> > +       depends on SERIAL_8250_PCI && GPIOLIB
> > +       select GPIO_SYSFS
> > +       help
> > +         Selecting this option will enable handling of GPIO pins p=
resent
> > +         on Exar XR17V352/354/358 chips.
> > diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/=
8250/Makefile
> > index e177f86..1d0fce0 100644
> > --- a/drivers/tty/serial/8250/Makefile
> > +++ b/drivers/tty/serial/8250/Makefile
> > @@ -28,5 +28,8 @@ obj-$(CONFIG_SERIAL_8250_MT6577)      +=3D 8250_m=
tk.o
> >  obj-$(CONFIG_SERIAL_8250_UNIPHIER)     +=3D 8250_uniphier.o
> >  obj-$(CONFIG_SERIAL_8250_INGENIC)      +=3D 8250_ingenic.o
> >  obj-$(CONFIG_SERIAL_8250_MID)          +=3D 8250_mid.o
> > +obj-$(CONFIG_SERIAL_8250_EXAR_GPIO)    +=3D exar_gpio.o
> > +exar_gpio-y                            :=3D 8250_pci.o 8250_gpio.o
> > +
> >
> >  CFLAGS_8250_ingenic.o +=3D -I$(srctree)/scripts/dtc/libfdt
> >
> >
> > But I am getting:
> > ERROR: "xr17v35x_gpio_exit" [drivers/tty/serial/8250/8250_pci.ko] u=
ndefined!
> > ERROR: "xr17v35x_gpio_init" [drivers/tty/serial/8250/8250_pci.ko] u=
ndefined!
> >
> > I will need little hint for the Makefile, please. Its clear that i =
have
> > messed up.
>=20
> Yes, read my previous mail.
>=20
> There are at least two approaches:
>  - use 8250_pci, etc as a library (see example: 8250_mid.c)
>  - force 8250_pci to use external libraries in some cases (seems your=
 approach)
>=20
> In the latter you have to extend 8250_pci and rename it. I have no
> idea if Greg or anyone else gives a green light for that.

I am sure Greg will give a big red light for this. :)

>=20
> Something like this (forget syntax of ifs in Makefile though
> obj-(=E2=80=A68250_PCI) +=3D 8250_pci.o
> obj-8250_pci =3D 8250_pci_orig.o
> ifneq (=E2=80=A6EXAR_GPIO,)
> obj-8250_pci +=3D exar_gpio.o
> endif
>=20
> But what I can recommend is to split exar parts out of 8250_pci first
> to a separate driver, do your part as a part of that new driver.

Ok, same approach what 8250_mid.c has done. But in the initial design
discussions Greg was against the idea of having it as a separate driver=
=2E

> Of course better to gather maintainer's opinion first.

Greg, can you please give some idea here about the best way to approach=
=2E..
I personally think, having it as a module with the minor changes that
Alan and Andy has suggested is the best approach. The only downside is
that the module gets loaded even if the device is not there. But for
arguments sake, the module will be enabled in the config only if someon=
e
is interested to build it. Everyone has the option to disable it if
required.

regards
sudip
