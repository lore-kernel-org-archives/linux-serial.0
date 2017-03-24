From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL calls
Date: Fri, 24 Mar 2017 10:44:50 +0100
Message-ID: <CAMuHMdWp+e4gmRYYV=kzpUjdkbJUX3UfXGp0zC_LBK0-7+thLQ@mail.gmail.com>
References: <20170323123437.uqdwhfmmsjke3f7s@pengutronix.de>
 <CACRpkdZRfLh9RXRycW_cAxuTYE6tPd7LR32EkAW8y2fh=AxhXA@mail.gmail.com>
 <20170323144325.GA952@dtor-ws> <20170323154441.GA9460@dtor-ws>
 <20170323191020.nrstp2cfh7cuqvf3@pengutronix.de> <20170323195804.GA2502@dtor-ws>
 <20170324080006.tbhyqlgk35xybsna@pengutronix.de> <CAMuHMdXnUzjb5wzMtmzY2ojpGbhr_3KFGDYd2QKEawVipBhdbw@mail.gmail.com>
 <20170324083905.h5uhdgiycchcjcgs@pengutronix.de> <CAMuHMdVoYyDUvQuoPoY347b8tbcuOJK5o7GXoSngiX3LQYekAQ@mail.gmail.com>
 <20170324091558.l2gmqqyced3d345o@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170324091558.l2gmqqyced3d345o@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-serial@vger.kernel.org

Hi Uwe,

On Fri, Mar 24, 2017 at 10:15 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Mar 24, 2017 at 09:59:04AM +0100, Geert Uytterhoeven wrote:
>> On Fri, Mar 24, 2017 at 9:39 AM, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > On Fri, Mar 24, 2017 at 09:29:02AM +0100, Geert Uytterhoeven wrote:
>> >> On Fri, Mar 24, 2017 at 9:00 AM, Uwe Kleine-K=C3=B6nig
>> >> <u.kleine-koenig@pengutronix.de> wrote:
>> >> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> >> > Subject: [PATCH] gpiod: let get_optional return NULL in some cases =
with GPIOLIB disabled
>> >> >
>> >> > People disagree if gpiod_get_optional should return NULL or
>> >> > ERR_PTR(-ENOSYS) if GPIOLIB is disabled. The argument for NULL is t=
hat
>> >> > the person who decided to disable GPIOLIB is assumed to know that t=
here
>> >> > is no GPIO. The reason to stick to ERR_PTR(-ENOSYS) is that it migh=
t
>> >> > introduce hard to debug problems if that decision is wrong.
>> >> >
>> >> > So this patch introduces a compromise and let gpiod_get_optional (a=
nd
>> >> > its variants) return NULL if the device in question cannot have an
>> >> > associated GPIO because it is neither instantiated by a device tree=
 nor
>> >> > by ACPI.
>> >> >
>> >> > This should handle most cases that are argued about.
>> >> >
>> >> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
>> >> > ---
>> >> >  include/linux/gpio/consumer.h | 55 +++++++++++++++++++++++++++++++=
+++++-------
>> >> >  1 file changed, 46 insertions(+), 9 deletions(-)
>> >> >
>> >> > diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/con=
sumer.h
>> >> > index fb0fde686cb1..0ca29889290d 100644
>> >> > --- a/include/linux/gpio/consumer.h
>> >> > +++ b/include/linux/gpio/consumer.h
>> >> > @@ -161,20 +161,48 @@ gpiod_get_index(struct device *dev,
>> >> >         return ERR_PTR(-ENOSYS);
>> >> >  }
>> >> >
>> >> > -static inline struct gpio_desc *__must_check
>> >> > -gpiod_get_optional(struct device *dev, const char *con_id,
>> >> > -                  enum gpiod_flags flags)
>> >> > +static inline bool __gpiod_no_optional_possible(struct device *dev=
)
>> >> >  {
>> >> > -       return ERR_PTR(-ENOSYS);
>> >> > +       /*
>> >> > +        * gpiod_get_optional et al can only provide a GPIO if at l=
east one of
>> >> > +        * the backends for specifing a GPIO is available. These ar=
e device
>> >> > +        * tree, ACPI and gpiolib's lookup tables. The latter isn't=
 available if
>> >> > +        * GPIOLIB is disabled (which is the case here).
>> >> > +        * So if the provided device is unrelated to device tree an=
d ACPI, we
>> >> > +        * can be sure that there is no optional GPIO and let gpiod=
_get_optional
>> >> > +        * safely return NULL.
>> >> > +        * Otherwise there is still a chance that there is no GPIO =
but we cannot
>> >> > +        * be sure without having to enable a part of GPIOLIB (i.e.=
 the lookup
>> >> > +        * part). So lets play safe and return an error. (Though th=
ere are also
>> >> > +        * arguments that returning NULL then would be beneficial.)
>> >> > +        */
>> >> > +
>> >> > +       if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
>> >> > +               return false;
>> >>
>> >> At first sight, I though this was OK:
>> >>
>> >>   1. On ARM with DT, we can assume CONFIG_GPIOLOB=3Dy.
>> >>
>> >>   2. I managed to configure an SH kernel with CONFIG_GPIOLOB=3Dn, CON=
FIG_OF=3Dy,
>> >>      and CONFIG_SERIAL_SH_SCI=3Dy, but since SH boards with SH-SCI UA=
RTs do
>> >>      not use DT (yet), the check for dev->of_node (false) should hand=
le
>> >>      that.
>> >>
>> >>   3. However, I managed to do the same for h8300, which does use DT. =
Hence
>> >>      if mctrl_gpio would start relying on gpiod_get_optional(), this =
would
>> >>      break the sh-sci driver on h8300 :-(
>> >>      Note that h8300 doesn't have any GPIO drivers (yet?), so
>> >>      CONFIG_GPIPOLIB=3Dn makes perfect sense!
>> >
>> > Thanks for your efforts.
>>
>> You're welcome.
>>
>> >> So I'm afraid the only option is to always return NULL, and put the
>> >> responsability on the shoulders of the system integrator...
>> >
>> > The gpio lines could be provided by an i2c gpio adapter, right? So IMH=
O
>> > you don't need platform gpios to justify -ENODEV. So I guess that's a
>> > case where we don't come to an agreement.
>>
>> While you can enable I2C without further dependencies, no I2C GPIO expan=
der
>> will be offered... unless you have enabled CONFIG_GPIOLIB first.
>
> And that is expected, still the device tree could reference such a GPIO
> and thus create a situation where Dmitry's and my judgement disagree.

If the device tree references such a GPIO, and CONFIG_GPIOLIB is not set,
the I2C GPIO expander device will not be bound.
Frank Rowand's DT scripts (http://elinux.org/Device_Tree_frowand) will come
to the rescue, and inform the user which driver(s) to enable.

> So I think my suggestion is the best we could do now. It minimizes the
> number of cases where we disagree. The next best thing would be to
> implement that half gpiolib stuff (i.e. do the full lookup to be sure
> there is no gpio) but this comes at a price: We need some time to
> implement it and it adds a bit to the kernel size.

So I still have to handle -ENOSYS in sh-sci.c, to avoid regressions...

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
