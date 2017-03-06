From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Mon, 6 Mar 2017 11:02:20 +0100
Message-ID: <20170306100220.droey65uq2ew3mzu@pengutronix.de>
References: <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
 <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
 <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
 <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
 <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
 <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
 <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
 <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-serial@vger.kernel.org

Cc += LinusW

On Mon, Mar 06, 2017 at 10:53:27AM +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 6, 2017 at 10:30 AM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Mar 06, 2017 at 10:09:50AM +0100, Geert Uytterhoeven wrote:
> >> On Mon, Mar 6, 2017 at 9:58 AM, Uwe Kleine-König
> >> <u.kleine-koenig@pengutronix.de> wrote:
> >> > On Mon, Mar 06, 2017 at 09:49:39AM +0100, Geert Uytterhoeven wrote:
> >> >> > Given that mctrl-gpio can be useful on legacy platforms, a device could
> >> >> > silently run without cts-gpio even there.
> >> >>
> >> >> On platforms were CONFIG_GPIOLIB=n, this is not true, so the issue is moot.
> >> >>
> >> >> All serial drivers using (optional) mctrl-gpio have this in Kconfig:
> >> >>
> >> >>     select SERIAL_MCTRL_GPIO if GPIOLIB
> >> >>
> >> >> So they will use mctrl-gpio when GPIOLIB is enabled.
> >> >> If GPIOPLIB is disabled, no flow control GPIOs are expected, and the
> >> >> driver should not break that case.
> >> >
> >> > So it all boils down to the question: Is GPIOLIB=n enough to assume no
> >> > gpio is needed?
> >> >
> >> > I'd say it is not.
> >>
> >> How does the platform register these GPIOs when GPIOPLIB is not enabled by
> >> the platform, and gpiod_add_lookup_table() is thus not available?
> >
> > Obviously the platformcode cannot. In this case you could argue that
> > platformcode shouldn't register the device if a gpio is necessary. But
> > this reasoning doesn't work for (DT=y || ACPI=y) && GPIOLIB=n.
> >
> > I wouldn't want to code this in each driver (something like:
> >
> >         if (IS_ENABLED(GPIOLIB) || device_is_instantiated_by_dt(dev) || device_is_instantiated_by_acpi(dev))
> >                 gpios = mctrl_gpio_init(...);
> >         else
> >                 gpios = NULL;
> >
> > ). Putting this into GPIOLIB is the right approach, and so this is
> > another argument for HALFGPIOLIB. This would fix mctrl_gpio_init en
> > passant.
> 
> Do we have platforms where DT=y || ACPI=y, but GPIOLIB=n?
> Ah, x86 ;-)

Yeah, and I think rm -r arch/x86 won't be acceptable :-) I assume you
can also configure some arm or powerpc systems without GPIOLIB.

> Anyway, for sh-sci.c, platforms either have DT and GPIOLIB, or they do not
> need mctrl-gpio.

So we're in agreement now that HALFGPIOLIB is the way to go?
Linus, what do you think?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
