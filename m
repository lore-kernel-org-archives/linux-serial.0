From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL calls
Date: Sat, 4 Mar 2017 16:35:46 +0100
Message-ID: <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
 <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
 <20170303191248.wlwjri55ip2x5pgg@pengutronix.de> <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>
List-Id: linux-serial@vger.kernel.org

Hi Uwe,

On Fri, Mar 3, 2017 at 8:44 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Mar 03, 2017 at 08:21:05PM +0100, Geert Uytterhoeven wrote:
>> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> > index 91e7dddbf72c..2f4cdd4e7b4f 100644
>> > --- a/drivers/tty/serial/sh-sci.c
>> > +++ b/drivers/tty/serial/sh-sci.c
>> > @@ -3022,7 +3022,7 @@ static int sci_probe_single(struct platform_devi=
ce *dev,
>> >                 return ret;
>> >
>> >         sciport->gpios =3D mctrl_gpio_init(&sciport->port, 0);
>> > -       if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) !=3D -EN=
OSYS)
>> > +       if (IS_ERR(sciport->gpios))
>> >                 return PTR_ERR(sciport->gpios);
>>
>> Now the sh-sci driver fails to probe on legacy platforms where GPIOLIB=
=3Dn.
>> The check for -ENOSYS made it succeed before.
>
> That's right, intended and the only option that's save (for some
> definition of save; the obvious downside is that there is no
> /dev/tty$whatever for you).

That's not just a downside, but a plain regression on legacy platforms that
do not use GPIO flow control.

> Ignoring -ENOSYS is only ok if your device doesn't have a cts-gpio. If
> it has, ignoring -ENOSYS hides bugs because the driver sends data while
> it shouldn't or cannot signal the other side that it should stop (or
> start) a transmission.

Mctrl_gpio supports modern platforms with GPIOLIB and DT or ACPI only.
On legacy platforms, you cannot use GPIO flow control (except when using a
custom implementation, which is out-of-scope here), so the issue of silentl=
y
running without cts-gpio on these platforms is moot.

> So the options are:
>  - enable GPIOLIB (maybe enforce that by letting the driver select it)
>  - introduce a CONFIG_HALFGPIOLIB that makes gpiod_get_optional and
>    mctrl_gpio_init return only then -ENOSYS if there is a gpio specified
>    and NULL otherwise.
>
>> > Then mctrl_gpio_to_gpiod isn't called. I don't have a machine to test
>> > this, but I think currently this makes the machine barf to continue
>> > here because with sciport->gpios =3D ERR_PTR(-ENOSYS) calling
>> >
>> >         mctrl_gpio_to_gpiod(sciport->gpios, ...)
>> >
>> > is a bad idea.
>>
>> If sciport->gpios =3D=3D ERR_PTR(-ENOSYS), CONFIG_GPIOLIB is not enabled=
, the
>> feature is not available, and mctrl_gpio_to_gpiod() will not
>> dereference the error
>> pointer.
>
> Ah, makes sense.
>
>> >> Perhaps mctrl_gpio_to_gpiod() should always return NULL if !CONFIG_GP=
IOLIB?
>> >
>> > No, mctrl_gpio_to_gpiod is right. You are only supposed to call it if
>> > mctrl_gpio_init succeeded.
>>
>> Then I have to add checks for sciport->gpios =3D=3D ERR_PTR(-ENOSYS)...
>
> No, ignoring -ENOSYS is wrong.

How else to handle this in a driver that supports both modern (DT && GPIOLI=
B)
and legacy platforms?

sh-sci is not only used on DT-only architectures like arm, arm64, and h8300=
,
but also on SuperH, where some platforms use GPIOLIB, others don't, and non=
e
of them use DT yet (jcore doesn't matter, as it doesn't use sh-sci).

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
