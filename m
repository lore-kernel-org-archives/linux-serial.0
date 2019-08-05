From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 05/14] gpio: lpc32xx: allow building on non-lpc32xx targets
Date: Mon, 5 Aug 2019 10:27:48 +0200
Message-ID: <CAMpxmJUdSnp0QNwWB0rJ1opFrYs9R2KSVS64Tz8X5GDYAJYLpg@mail.gmail.com>
References: <20190731195713.3150463-1-arnd@arndb.de> <20190731195713.3150463-6-arnd@arndb.de>
 <CAMpxmJWFfT_vrDas2fzW5tnxskk9kmgHQpGnGQ-_C20UaS_jhA@mail.gmail.com> <CAK8P3a3KpKvRKXY72toE_5eAp4ER_Mre0GX3guwGeQgsY2HX+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3KpKvRKXY72toE_5eAp4ER_Mre0GX3guwGeQgsY2HX+g@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, arm-soc <linux-arm-kernel@lists.infradead.org>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, linux-gpio <linux-gpio@vger.kernel.org>, netdev <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

pt., 2 sie 2019 o 13:20 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> On Fri, Aug 2, 2019 at 9:10 AM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> > > -#include <mach/hardware.h>
> > > -#include <mach/platform.h>
> > > +#define _GPREG(x)                              (x)
> >
> > What purpose does this macro serve?
> >
> > >
> > >  #define LPC32XX_GPIO_P3_INP_STATE              _GPREG(0x000)
> > >  #define LPC32XX_GPIO_P3_OUTP_SET               _GPREG(0x004)
>
> In the existing code base, this macro converts a register offset to
> an __iomem pointer for a gpio register. I changed the definition of the
> macro here to keep the number of changes down, but I it's just
> as easy to remove it if you prefer.

Could you just add a comment so that it's clear at first glance?

>
> > > @@ -167,14 +166,26 @@ struct lpc32xx_gpio_chip {
> > >         struct gpio_regs        *gpio_grp;
> > >  };
> > >
> > > +void __iomem *gpio_reg_base;
> >
> > Any reason why this can't be made part of struct lpc32xx_gpio_chip?
>
> It could be, but it's the same for each instance, and not known until
> probe() time, so the same pointer would need to be copied into each
> instance that is otherwise read-only.
>
> Let me know if you'd prefer me to rework these two things or leave
> them as they are.

I would prefer not to have global state in the driver, let's just
store the pointer in the data passed to gpiochip_add_data().

Bart

>
> > > +static inline u32 gpreg_read(unsigned long offset)
> >
> > Here and elsewhere: could you please keep the lpc32xx_gpio prefix for
> > all symbols?
>
> Sure.
>
>       Arnd
