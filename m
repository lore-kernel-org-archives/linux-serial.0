From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Mon, 21 Dec 2015 20:28:51 +0200
Message-ID: <CAHp75VfF_f=4MFmk9D1eLYanVyQyr+Fr8RBY81Pw+dyGZ7e0xw@mail.gmail.com>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
	<20151220164353.6ef29f77@lxorguk.ukuu.org.uk>
	<20151220172841.GB8471@sudip-laptop>
	<20151220174208.1447d2f3@lxorguk.ukuu.org.uk>
	<20151221151904.GA23780@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151221151904.GA23780@sudip-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 21, 2015 at 5:19 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:

> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/825=
0/Kconfig
> index 6412f14..ec3d287 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -378,3 +378,11 @@ config SERIAL_8250_MID
>           Selecting this option will enable handling of the extra fea=
tures
>           present on the UART found on Intel Medfield SOC and various=
 other
>           Intel platforms.
> +
> +config SERIAL_8250_EXAR_GPIO
> +       bool "Support for GPIO pins on XR17V352/354/358"
> +       depends on SERIAL_8250_PCI && GPIOLIB
> +       select GPIO_SYSFS
> +       help
> +         Selecting this option will enable handling of GPIO pins pre=
sent
> +         on Exar XR17V352/354/358 chips.
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/82=
50/Makefile
> index e177f86..1d0fce0 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -28,5 +28,8 @@ obj-$(CONFIG_SERIAL_8250_MT6577)      +=3D 8250_mtk=
=2Eo
>  obj-$(CONFIG_SERIAL_8250_UNIPHIER)     +=3D 8250_uniphier.o
>  obj-$(CONFIG_SERIAL_8250_INGENIC)      +=3D 8250_ingenic.o
>  obj-$(CONFIG_SERIAL_8250_MID)          +=3D 8250_mid.o
> +obj-$(CONFIG_SERIAL_8250_EXAR_GPIO)    +=3D exar_gpio.o
> +exar_gpio-y                            :=3D 8250_pci.o 8250_gpio.o
> +
>
>  CFLAGS_8250_ingenic.o +=3D -I$(srctree)/scripts/dtc/libfdt
>
>
> But I am getting:
> ERROR: "xr17v35x_gpio_exit" [drivers/tty/serial/8250/8250_pci.ko] und=
efined!
> ERROR: "xr17v35x_gpio_init" [drivers/tty/serial/8250/8250_pci.ko] und=
efined!
>
> I will need little hint for the Makefile, please. Its clear that i ha=
ve
> messed up.

Yes, read my previous mail.

There are at least two approaches:
 - use 8250_pci, etc as a library (see example: 8250_mid.c)
 - force 8250_pci to use external libraries in some cases (seems your a=
pproach)

In the latter you have to extend 8250_pci and rename it. I have no
idea if Greg or anyone else gives a green light for that.

Something like this (forget syntax of ifs in Makefile though
obj-(=E2=80=A68250_PCI) +=3D 8250_pci.o
obj-8250_pci =3D 8250_pci_orig.o
ifneq (=E2=80=A6EXAR_GPIO,)
obj-8250_pci +=3D exar_gpio.o
endif

But what I can recommend is to split exar parts out of 8250_pci first
to a separate driver, do your part as a part of that new driver.
Of course better to gather maintainer's opinion first.

--=20
With Best Regards,
Andy Shevchenko
