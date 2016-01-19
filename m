From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v5] serial: 8250: add gpio support to exar
Date: Tue, 19 Jan 2016 16:44:23 +0530
Message-ID: <20160119111344.GA23168@sudip-pc>
References: <1453183595-17996-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75VdopyRUcwSFY=qowoiq6Twkg686oQHed8WU5Ep8QQtL+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdopyRUcwSFY=qowoiq6Twkg686oQHed8WU5Ep8QQtL+A@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Hung <hpeter@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rob Groner <rgroner@rtd.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 19, 2016 at 12:09:08PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 19, 2016 at 8:06 AM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs wh=
ich
> > can be controlled using gpio interface.
> > Add support to use these pins.
>=20
> + Peter Hung.
>=20
> Seems Fintek HW is going similar way you, guys, have to decide how to
> proceed in general. I like this way Sudip made here, though I still
> few comments below.

Just had a look at the Fintek patch. Interestingly high baudrate was ou=
r
next plan. :)

>=20
> First of all, can we split it to two patches like cooking GPIO driver
> first, then extend Exar piece of serial driver?
>=20
> I also would like to vote for splitting out first Exar parts from
> 8250_pci like Peter did for Fintek.

Then maybe instead of splitting out if we have the provision of high
baudrate in 8250_pci? And the way I have done, it is just a matter of f=
ew
function calls from 8250_pci in case the hardware is present. So then,
what may be the advantage of splitting out?

>
<snip>
=20
> > +static void exar_set(struct gpio_chip *chip, unsigned int reg, int=
 val,
> > +                    unsigned int offset)
>=20
> This one by implementation looks like exar_update()

well, I made it exar_set() as it is setting the gpio pins.

>=20
<snip>
> > +
> > +static int gpio_exar_probe(struct platform_device *pdev)
> > +{
> > +       struct pci_dev *dev =3D platform_get_drvdata(pdev);
> > +       struct exar_gpio_chip *exar_gpio, *exar_temp;
> > +       void __iomem *p;
> > +       int index =3D 1;
> > +       int ret;
> > +
> > +       if (dev->vendor !=3D PCI_VENDOR_ID_EXAR)
> > +               return -ENODEV;
> > +
> > +       p =3D pci_ioremap_bar(dev, 0);
>=20
> So, if it would be separate driver for 8250_exar.c (by the way what i=
s
> 8250_exar_st16c554.c?) you will use managed functions here=E2=80=A6

8250_exar_st16c554.c -> Its probe and all other functions are in 8250_c=
ore.c

>=20
<snip>
> > +       sprintf(exar_gpio->name, "exar_gpio%d", index);
> > +       exar_gpio->gpio_chip.label =3D exar_gpio->name;
> > +       exar_gpio->gpio_chip.parent =3D &dev->dev;
> > +       exar_gpio->gpio_chip.direction_output =3D exar_direction_ou=
tput;
> > +       exar_gpio->gpio_chip.direction_input =3D exar_direction_inp=
ut;
> > +       exar_gpio->gpio_chip.get_direction =3D exar_get_direction;
> > +       exar_gpio->gpio_chip.get =3D exar_get_value;
> > +       exar_gpio->gpio_chip.set =3D exar_set_value;
> > +       exar_gpio->gpio_chip.base =3D -1;
> > +       exar_gpio->gpio_chip.ngpio =3D 16;
>=20
> > +       exar_gpio->gpio_chip.owner =3D THIS_MODULE;
>=20
> Does core set it for you?

No, all the gpio drivers are setting it by itself. Maybe we can see if
that feature can be added to gpio core or not..

>=20
<snip>
>=20
> > +static const struct platform_device_id gpio_exar_id[] =3D {
>=20
> > +       { "gpio_exar", 0},
>=20
> This is default fallback. I don't think you need this at all (example
> in my mind is dw_dmac driver, where you can't find such line). But
> please recheck.

somehow in my testing the module was not loading without this. Maybe
module_alias is the key. I will check again while making these
modifications. But now the question is should I split out? What advanta=
ge
will be there in splitting out?

regards
sudip
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
