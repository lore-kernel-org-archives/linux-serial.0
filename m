From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Thu, 16 Mar 2017 17:37:31 +0100
Message-ID: <20170316163731.xfx7ybtgdadzbh3m@pengutronix.de>
References: <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
 <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
 <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
 <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
 <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
 <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
 <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
 <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
 <20170306100220.droey65uq2ew3mzu@pengutronix.de>
 <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 16, 2017 at 04:18:52PM +0100, Linus Walleij wrote:
> On Mon, Mar 6, 2017 at 11:02 AM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Mar 06, 2017 at 10:53:27AM +0100, Geert Uytterhoeven wrote:
> >> On Mon, Mar 6, 2017 at 10:30 AM, Uwe Kleine-K=F6nig
> =

> >> > I wouldn't want to code this in each driver (something like:
> >> >
> >> >         if (IS_ENABLED(GPIOLIB) || device_is_instantiated_by_dt(dev)=
 || device_is_instantiated_by_acpi(dev))
> >> >                 gpios =3D mctrl_gpio_init(...);
> >> >         else
> >> >                 gpios =3D NULL;
> >> >
> >> > ). Putting this into GPIOLIB is the right approach, and so this is
> >> > another argument for HALFGPIOLIB. This would fix mctrl_gpio_init en
> >> > passant.
> >>
> >> Do we have platforms where DT=3Dy || ACPI=3Dy, but GPIOLIB=3Dn?
> >> Ah, x86 ;-)
> >
> > Yeah, and I think rm -r arch/x86 won't be acceptable :-) I assume you
> > can also configure some arm or powerpc systems without GPIOLIB.
> >
> >> Anyway, for sh-sci.c, platforms either have DT and GPIOLIB, or they do=
 not
> >> need mctrl-gpio.
> >
> > So we're in agreement now that HALFGPIOLIB is the way to go?
> > Linus, what do you think?
> =

> OK modem lines over GPIO.
> =

> So the problem is that GPIOLIB is needed (obviously) for mctrl_gpio_init(=
) to
> work properly, and then there are some stubs in
> drivers/tty/serial/serial_mctrl_gpio.h
> for !GPIOLIB.
> =

> And this whole discussion is all about that !GPIOLIB case really,
> whether DT, ACPI, SFI or board files machine data is used doesn't
> really matter.
> =

> We're talking about:
> =

> > git grep mctrl_gpio_init
> drivers/tty/serial/atmel_serial.c:      atmel_port->gpios =3D
> mctrl_gpio_init(&atmel_port->uart, 0);
> drivers/tty/serial/clps711x.c:  s->gpios =3D
> mctrl_gpio_init_noauto(&pdev->dev, 0);
> drivers/tty/serial/etraxfs-uart.c:      up->gpios =3D
> mctrl_gpio_init_noauto(&pdev->dev, 0);
> drivers/tty/serial/imx.c:       sport->gpios =3D mctrl_gpio_init(&sport->=
port, 0);
> drivers/tty/serial/mxs-auart.c: s->gpios =3D mctrl_gpio_init_noauto(dev, =
0);
> drivers/tty/serial/sh-sci.c:    sciport->gpios =3D
> mctrl_gpio_init(&sciport->port, 0);
> =

> Atmel, ARM, ETRAX, ARM, ARM, Super-H, all have GPIOLIB.
> Right now no x86, correct?
> =

> They actually all even do things like this in Kconfig:
> =

> config SERIAL_ATMEL
> (...)
>         select SERIAL_MCTRL_GPIO if GPIOLIB
> =

> What stops us from removing all the stubs in
> drivers/tty/serial/serial_mctrl_gpio.h
> and just make SERIAL_MCTRL_GPIO depends on GPIOLIB?

Would be ok for me, too. People seem to object to that though.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
