From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/14] gpio: lpc32xx: allow building on non-lpc32xx targets
Date: Fri, 2 Aug 2019 13:19:55 +0200
Message-ID: <CAK8P3a3KpKvRKXY72toE_5eAp4ER_Mre0GX3guwGeQgsY2HX+g@mail.gmail.com>
References: <20190731195713.3150463-1-arnd@arndb.de>
 <20190731195713.3150463-6-arnd@arndb.de>
 <CAMpxmJWFfT_vrDas2fzW5tnxskk9kmgHQpGnGQ-_C20UaS_jhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMpxmJWFfT_vrDas2fzW5tnxskk9kmgHQpGnGQ-_C20UaS_jhA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Andrew Lunn <andrew@lunn.ch>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gregory Clement <gregory.clement@bootlin.com>, USB list <linux-usb@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Vladimir Zapolskiy <vz@mleia.com>, linux-gpio <linux-gpio@vger.kernel.org>, soc@kernel.org, netdev <netdev@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, linux-serial@vger.kernel.org, Sylvain Lemieux <slemieux.tyco@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 2, 2019 at 9:10 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> > -#include <mach/hardware.h>
> > -#include <mach/platform.h>
> > +#define _GPREG(x)                              (x)
>
> What purpose does this macro serve?
>
> >
> >  #define LPC32XX_GPIO_P3_INP_STATE              _GPREG(0x000)
> >  #define LPC32XX_GPIO_P3_OUTP_SET               _GPREG(0x004)

In the existing code base, this macro converts a register offset to
an __iomem pointer for a gpio register. I changed the definition of the
macro here to keep the number of changes down, but I it's just
as easy to remove it if you prefer.

> > @@ -167,14 +166,26 @@ struct lpc32xx_gpio_chip {
> >         struct gpio_regs        *gpio_grp;
> >  };
> >
> > +void __iomem *gpio_reg_base;
>
> Any reason why this can't be made part of struct lpc32xx_gpio_chip?

It could be, but it's the same for each instance, and not known until
probe() time, so the same pointer would need to be copied into each
instance that is otherwise read-only.

Let me know if you'd prefer me to rework these two things or leave
them as they are.

> > +static inline u32 gpreg_read(unsigned long offset)
>
> Here and elsewhere: could you please keep the lpc32xx_gpio prefix for
> all symbols?

Sure.

      Arnd
