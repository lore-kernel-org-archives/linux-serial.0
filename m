From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v4] serial: 8250: add gpio support to exar
Date: Mon, 18 Jan 2016 19:36:41 +0530
Message-ID: <20160118140641.GA22985@sudip-laptop>
References: <1453119038-11741-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75VdSbd-OSLNyX3mmqC-_tdRNQqR33BPVY1PHibAODNVwRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdSbd-OSLNyX3mmqC-_tdRNQqR33BPVY1PHibAODNVwRA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rob Groner <rgroner@rtd.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 18, 2016 at 03:39:01PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 18, 2016 at 2:10 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs wh=
ich
> > can be controlled using gpio interface.
> > Add support to use these pins.
>=20
> Looks better, but=E2=80=A6
>=20
> >  drivers/gpio/Kconfig                |   7 ++
> >  drivers/gpio/Makefile               |   1 +
>=20
> Why is it here?
>=20
> >  drivers/tty/serial/8250/8250_gpio.c | 243 ++++++++++++++++++++++++=
++++++++++++

OOPS... I am sorry, I have made a complete mess of this patch. :(
This was supposed to have drivers/gpio/gpio-exar.c and
not drivers/tty/serial/8250/8250_gpio.c
The entire gpio related code was moved to drivers/gpio/gpio-exar.c and
8250_pci.c was only adding the platform device.
I will post the correct patch tomorrow.
Sorry again.

regards
sudip
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
