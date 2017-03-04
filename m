From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Sat, 4 Mar 2017 18:48:19 +0100
Message-ID: <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
 <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
 <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
 <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello,

Cc +=3D linux-gpio@vger.kernel.org

On Sat, Mar 04, 2017 at 04:35:46PM +0100, Geert Uytterhoeven wrote:
> On Fri, Mar 3, 2017 at 8:44 PM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Mar 03, 2017 at 08:21:05PM +0100, Geert Uytterhoeven wrote:
> >> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci=
.c
> >> > index 91e7dddbf72c..2f4cdd4e7b4f 100644
> >> > --- a/drivers/tty/serial/sh-sci.c
> >> > +++ b/drivers/tty/serial/sh-sci.c
> >> > @@ -3022,7 +3022,7 @@ static int sci_probe_single(struct platform_de=
vice *dev,
> >> >                 return ret;
> >> >
> >> >         sciport->gpios =3D mctrl_gpio_init(&sciport->port, 0);
> >> > -       if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) !=3D -=
ENOSYS)
> >> > +       if (IS_ERR(sciport->gpios))
> >> >                 return PTR_ERR(sciport->gpios);
> >>
> >> Now the sh-sci driver fails to probe on legacy platforms where GPIOLIB=
=3Dn.
> >> The check for -ENOSYS made it succeed before.
> >
> > That's right, intended and the only option that's save (for some
> > definition of save; the obvious downside is that there is no
> > /dev/tty$whatever for you).
> =

> That's not just a downside, but a plain regression on legacy platforms th=
at
> do not use GPIO flow control.

The only sane way out is that the driver somehow finds out that no gpios
are supposed to be needed. So you can pass in via platform_data that no
gpios are supposed to be used if you don't want to enable GPIOLIB (or
implement CONFIG_HALFGPIOLIB). But I'd say this is a quirk that should
better be fixed globally. So I think we should implement HALFGPIOLIB
that includes the lookup stuff and so can make gpiod_get_optional and
friends return NULL if there is really no GPIO.

> > Ignoring -ENOSYS is only ok if your device doesn't have a cts-gpio. If
> > it has, ignoring -ENOSYS hides bugs because the driver sends data while
> > it shouldn't or cannot signal the other side that it should stop (or
> > start) a transmission.
> =

> Mctrl_gpio supports modern platforms with GPIOLIB and DT or ACPI only.

That's wrong. Even for a legacy device you can make use of GPIOs. See
arch/arm/mach-tegra/board-paz00.c for a simple example.

> On legacy platforms, you cannot use GPIO flow control (except when using a
> custom implementation, which is out-of-scope here), so the issue of silen=
tly
> running without cts-gpio on these platforms is moot.

Given that mctrl-gpio can be useful on legacy platforms, a device could
silently run without cts-gpio even there.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
