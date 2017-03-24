From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Fri, 24 Mar 2017 11:01:18 +0100
Message-ID: <20170324100118.ogvy3qazjksiyc26@pengutronix.de>
References: <20170323144325.GA952@dtor-ws>
 <20170323154441.GA9460@dtor-ws>
 <20170323191020.nrstp2cfh7cuqvf3@pengutronix.de>
 <20170323195804.GA2502@dtor-ws>
 <20170324080006.tbhyqlgk35xybsna@pengutronix.de>
 <CAMuHMdXnUzjb5wzMtmzY2ojpGbhr_3KFGDYd2QKEawVipBhdbw@mail.gmail.com>
 <20170324083905.h5uhdgiycchcjcgs@pengutronix.de>
 <CAMuHMdVoYyDUvQuoPoY347b8tbcuOJK5o7GXoSngiX3LQYekAQ@mail.gmail.com>
 <20170324091558.l2gmqqyced3d345o@pengutronix.de>
 <CAMuHMdWp+e4gmRYYV=kzpUjdkbJUX3UfXGp0zC_LBK0-7+thLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWp+e4gmRYYV=kzpUjdkbJUX3UfXGp0zC_LBK0-7+thLQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert+renesas@glider.be>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello Geert,

On Fri, Mar 24, 2017 at 10:44:50AM +0100, Geert Uytterhoeven wrote:
> On Fri, Mar 24, 2017 at 10:15 AM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Mar 24, 2017 at 09:59:04AM +0100, Geert Uytterhoeven wrote:
> >> On Fri, Mar 24, 2017 at 9:39 AM, Uwe Kleine-König
> >> <u.kleine-koenig@pengutronix.de> wrote:
> >> > On Fri, Mar 24, 2017 at 09:29:02AM +0100, Geert Uytterhoeven wrote:
> >> >> On Fri, Mar 24, 2017 at 9:00 AM, Uwe Kleine-König
> >> >> <u.kleine-koenig@pengutronix.de> wrote:
> >> >> > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >> >> > Subject: [PATCH] gpiod: let get_optional return NULL in some cases with GPIOLIB disabled
> >> >> >
> >> >> > People disagree if gpiod_get_optional should return NULL or
> >> >> > ERR_PTR(-ENOSYS) if GPIOLIB is disabled. The argument for NULL is that
> >> >> > the person who decided to disable GPIOLIB is assumed to know that there
> >> >> > is no GPIO. The reason to stick to ERR_PTR(-ENOSYS) is that it might
> >> >> > introduce hard to debug problems if that decision is wrong.
> >> >> >
> >> >> > So this patch introduces a compromise and let gpiod_get_optional (and
> >> >> > its variants) return NULL if the device in question cannot have an
> >> >> > associated GPIO because it is neither instantiated by a device tree nor
> >> >> > by ACPI.
> >> >> >
> >> >> > This should handle most cases that are argued about.
> >> >> >
> >> >> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >> >> > ---
> >> >> >  include/linux/gpio/consumer.h | 55 ++++++++++++++++++++++++++++++++++++-------
> >> >> >  1 file changed, 46 insertions(+), 9 deletions(-)
> >> >> >
> >> >> > diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> >> >> > index fb0fde686cb1..0ca29889290d 100644
> >> >> > --- a/include/linux/gpio/consumer.h
> >> >> > +++ b/include/linux/gpio/consumer.h
> >> >> > @@ -161,20 +161,48 @@ gpiod_get_index(struct device *dev,
> >> >> >         return ERR_PTR(-ENOSYS);
> >> >> >  }
> >> >> >
> >> >> > -static inline struct gpio_desc *__must_check
> >> >> > -gpiod_get_optional(struct device *dev, const char *con_id,
> >> >> > -                  enum gpiod_flags flags)
> >> >> > +static inline bool __gpiod_no_optional_possible(struct device *dev)
> >> >> >  {
> >> >> > -       return ERR_PTR(-ENOSYS);
> >> >> > +       /*
> >> >> > +        * gpiod_get_optional et al can only provide a GPIO if at least one of
> >> >> > +        * the backends for specifing a GPIO is available. These are device
> >> >> > +        * tree, ACPI and gpiolib's lookup tables. The latter isn't available if
> >> >> > +        * GPIOLIB is disabled (which is the case here).
> >> >> > +        * So if the provided device is unrelated to device tree and ACPI, we
> >> >> > +        * can be sure that there is no optional GPIO and let gpiod_get_optional
> >> >> > +        * safely return NULL.
> >> >> > +        * Otherwise there is still a chance that there is no GPIO but we cannot
> >> >> > +        * be sure without having to enable a part of GPIOLIB (i.e. the lookup
> >> >> > +        * part). So lets play safe and return an error. (Though there are also
> >> >> > +        * arguments that returning NULL then would be beneficial.)
> >> >> > +        */
> >> >> > +
> >> >> > +       if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
> >> >> > +               return false;
> >> >>
> >> >> At first sight, I though this was OK:
> >> >>
> >> >>   1. On ARM with DT, we can assume CONFIG_GPIOLOB=y.
> >> >>
> >> >>   2. I managed to configure an SH kernel with CONFIG_GPIOLOB=n, CONFIG_OF=y,
> >> >>      and CONFIG_SERIAL_SH_SCI=y, but since SH boards with SH-SCI UARTs do
> >> >>      not use DT (yet), the check for dev->of_node (false) should handle
> >> >>      that.
> >> >>
> >> >>   3. However, I managed to do the same for h8300, which does use DT. Hence
> >> >>      if mctrl_gpio would start relying on gpiod_get_optional(), this would
> >> >>      break the sh-sci driver on h8300 :-(
> >> >>      Note that h8300 doesn't have any GPIO drivers (yet?), so
> >> >>      CONFIG_GPIPOLIB=n makes perfect sense!
> >>
> >> >> So I'm afraid the only option is to always return NULL, and put the
> >> >> responsability on the shoulders of the system integrator...
> >> >
> >> > The gpio lines could be provided by an i2c gpio adapter, right? So IMHO
> >> > you don't need platform gpios to justify -ENODEV. So I guess that's a
> >> > case where we don't come to an agreement.
> >>
> >> While you can enable I2C without further dependencies, no I2C GPIO expander
> >> will be offered... unless you have enabled CONFIG_GPIOLIB first.
> >
> > And that is expected, still the device tree could reference such a GPIO
> > and thus create a situation where Dmitry's and my judgement disagree.
> 
> If the device tree references such a GPIO, and CONFIG_GPIOLIB is not set,
> the I2C GPIO expander device will not be bound.
> Frank Rowand's DT scripts (http://elinux.org/Device_Tree_frowand) will come
> to the rescue, and inform the user which driver(s) to enable.
> 
> > So I think my suggestion is the best we could do now. It minimizes the
> > number of cases where we disagree. The next best thing would be to
> > implement that half gpiolib stuff (i.e. do the full lookup to be sure
> > there is no gpio) but this comes at a price: We need some time to
> > implement it and it adds a bit to the kernel size.
> 
> So I still have to handle -ENOSYS in sh-sci.c, to avoid regressions...

How much would it hurt to enable GPIOLIB there now? I assume that the
platform has GPIOs and it's only an intermediate step that there is no
driver for it at present? At some point you have to bite the bullet.
Given that mctrl_gpio is a usage of GPIOs that might be now?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
