From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL calls
Date: Fri, 24 Mar 2017 09:59:04 +0100
Message-ID: <CAMuHMdVoYyDUvQuoPoY347b8tbcuOJK5o7GXoSngiX3LQYekAQ@mail.gmail.com>
References: <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de>
 <CAMuHMdUWybAZXc2RbGMGyp4DYQZU9BS8MxXKE5Kfd+aH8+w9sA@mail.gmail.com>
 <20170323123437.uqdwhfmmsjke3f7s@pengutronix.de> <CACRpkdZRfLh9RXRycW_cAxuTYE6tPd7LR32EkAW8y2fh=AxhXA@mail.gmail.com>
 <20170323144325.GA952@dtor-ws> <20170323154441.GA9460@dtor-ws>
 <20170323191020.nrstp2cfh7cuqvf3@pengutronix.de> <20170323195804.GA2502@dtor-ws>
 <20170324080006.tbhyqlgk35xybsna@pengutronix.de> <CAMuHMdXnUzjb5wzMtmzY2ojpGbhr_3KFGDYd2QKEawVipBhdbw@mail.gmail.com>
 <20170324083905.h5uhdgiycchcjcgs@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170324083905.h5uhdgiycchcjcgs@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-serial@vger.kernel.org

Hi Uwe,

On Fri, Mar 24, 2017 at 9:39 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Mar 24, 2017 at 09:29:02AM +0100, Geert Uytterhoeven wrote:
>> On Fri, Mar 24, 2017 at 9:00 AM, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> > Subject: [PATCH] gpiod: let get_optional return NULL in some cases wit=
h GPIOLIB disabled
>> >
>> > People disagree if gpiod_get_optional should return NULL or
>> > ERR_PTR(-ENOSYS) if GPIOLIB is disabled. The argument for NULL is that
>> > the person who decided to disable GPIOLIB is assumed to know that ther=
e
>> > is no GPIO. The reason to stick to ERR_PTR(-ENOSYS) is that it might
>> > introduce hard to debug problems if that decision is wrong.
>> >
>> > So this patch introduces a compromise and let gpiod_get_optional (and
>> > its variants) return NULL if the device in question cannot have an
>> > associated GPIO because it is neither instantiated by a device tree no=
r
>> > by ACPI.
>> >
>> > This should handle most cases that are argued about.
>> >
>> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> > ---
>> >  include/linux/gpio/consumer.h | 55 ++++++++++++++++++++++++++++++++++=
++-------
>> >  1 file changed, 46 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consum=
er.h
>> > index fb0fde686cb1..0ca29889290d 100644
>> > --- a/include/linux/gpio/consumer.h
>> > +++ b/include/linux/gpio/consumer.h
>> > @@ -161,20 +161,48 @@ gpiod_get_index(struct device *dev,
>> >         return ERR_PTR(-ENOSYS);
>> >  }
>> >
>> > -static inline struct gpio_desc *__must_check
>> > -gpiod_get_optional(struct device *dev, const char *con_id,
>> > -                  enum gpiod_flags flags)
>> > +static inline bool __gpiod_no_optional_possible(struct device *dev)
>> >  {
>> > -       return ERR_PTR(-ENOSYS);
>> > +       /*
>> > +        * gpiod_get_optional et al can only provide a GPIO if at leas=
t one of
>> > +        * the backends for specifing a GPIO is available. These are d=
evice
>> > +        * tree, ACPI and gpiolib's lookup tables. The latter isn't av=
ailable if
>> > +        * GPIOLIB is disabled (which is the case here).
>> > +        * So if the provided device is unrelated to device tree and A=
CPI, we
>> > +        * can be sure that there is no optional GPIO and let gpiod_ge=
t_optional
>> > +        * safely return NULL.
>> > +        * Otherwise there is still a chance that there is no GPIO but=
 we cannot
>> > +        * be sure without having to enable a part of GPIOLIB (i.e. th=
e lookup
>> > +        * part). So lets play safe and return an error. (Though there=
 are also
>> > +        * arguments that returning NULL then would be beneficial.)
>> > +        */
>> > +
>> > +       if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
>> > +               return false;
>>
>> At first sight, I though this was OK:
>>
>>   1. On ARM with DT, we can assume CONFIG_GPIOLOB=3Dy.
>>
>>   2. I managed to configure an SH kernel with CONFIG_GPIOLOB=3Dn, CONFIG=
_OF=3Dy,
>>      and CONFIG_SERIAL_SH_SCI=3Dy, but since SH boards with SH-SCI UARTs=
 do
>>      not use DT (yet), the check for dev->of_node (false) should handle
>>      that.
>>
>>   3. However, I managed to do the same for h8300, which does use DT. Hen=
ce
>>      if mctrl_gpio would start relying on gpiod_get_optional(), this wou=
ld
>>      break the sh-sci driver on h8300 :-(
>>      Note that h8300 doesn't have any GPIO drivers (yet?), so
>>      CONFIG_GPIPOLIB=3Dn makes perfect sense!
>
> Thanks for your efforts.

You're welcome.

>> So I'm afraid the only option is to always return NULL, and put the
>> responsability on the shoulders of the system integrator...
>
> The gpio lines could be provided by an i2c gpio adapter, right? So IMHO
> you don't need platform gpios to justify -ENODEV. So I guess that's a
> case where we don't come to an agreement.

While you can enable I2C without further dependencies, no I2C GPIO expander
will be offered... unless you have enabled CONFIG_GPIOLIB first.

>> >  static inline struct gpio_desc *__must_check
>> >  gpiod_get_index_optional(struct device *dev, const char *con_id,
>> >                          unsigned int index, enum gpiod_flags flags)
>> >  {
>> > +       if (__gpiod_no_optional_possible(dev))
>> > +               return NULL;
>> > +
>> >         return ERR_PTR(-ENOSYS);
>>
>> Regardless of the above, given you use the exact same construct in four
>> locations, what about letting __gpiod_no_optional_possible() return the =
NULL
>> or ERR_PTR itself, and renaming it to e.g. __gpiod_no_optional_return_va=
lue()?
>
> I thought about that but didn't find a good name and so considered it
> more clear this way. Another optimisation would be to unconditionally
> define get_optional in terms of get_index_optional which would simplify
> my patch a bit.
>
> I'd consider __gpiod_optional_return_value a better name than
> __gpiod_no_optional_return_value but I'm still not convinced.

No hard feelings about the name from my side.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
