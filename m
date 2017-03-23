From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL calls
Date: Thu, 23 Mar 2017 13:44:19 +0100
Message-ID: <CAMuHMdVcALm_iLiTgs7GL5S77ur+iGVhyD0yB9FxCfKFpw7uug@mail.gmail.com>
References: <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
 <CAMuHMdXGn35bEsJKnUi5o3AytL4AJN2fBfoB79v5W-jOVFQx6g@mail.gmail.com>
 <20170320103113.tpveoq2onzrwmkdt@pengutronix.de> <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
 <20170320110718.e44s2gip36m75bqj@pengutronix.de> <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
 <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de> <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
 <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de> <CAMuHMdUWybAZXc2RbGMGyp4DYQZU9BS8MxXKE5Kfd+aH8+w9sA@mail.gmail.com>
 <20170323123437.uqdwhfmmsjke3f7s@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170323123437.uqdwhfmmsjke3f7s@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Uwe,

On Thu, Mar 23, 2017 at 1:34 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Mar 23, 2017 at 01:03:56PM +0100, Geert Uytterhoeven wrote:
>> On Thu, Mar 23, 2017 at 12:11 PM, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> >> Make sure to enable all drivers and subsystems you need when building
>> >> your kernel. That's always true. And may indeed be hard to debug (e.g=
. what
>> >> kernel options do I need to make systemd work?).
>> >
>> > It's worse here. If you forget to enable a driver the device isn't bou=
nd
>> > and that's obvious to diagnose. When ignoring an optional GPIO there
>> > might be a device that claims to work but fails to do so. (e.g. you
>> > write to memory, write() returns 0, but the data never landed there.)
>> >
>> >> > write(2) and close(2) succeed most of the time, too. Still it's not=
 a
>> >> > good idea to not check the return value. Or let the kernel return
>> >> > success unconditionally.
>> >>
>> >> Writing all bytes passed in the buffer is "optional" in another sense=
 than
>> >> an "optional" GPIO: you must retry the write, while you can continue =
if
>> >> an optional GPIO is not present.
>> >
>> > And that is the point. You can continue *iff* the optional GPIO is not
>> > present. The patch in question removes the ability to determine if tha=
t
>> > GPIO is present and claims it is not present.
>>
>> If you forget to enable a driver/subsystem, you sometimes cannot determi=
ne
>> if the device is present or not neither.
>>
>> Hence it boils down to "knowing" if there is a GPIO or not.
>> So, when can there be a GPIO?
>>   1. The GPIO is described in DT.
>>      =3D> Not an issue, as DT GPIO implies GPIOLIB,
>>   2. The GPIO is described in legacy platform data.
>>      =3D> The platform code should make sure GPIOLIB is selected when ne=
eded.
>>
>> Issue solved?
>
> I like it better to not rely on platform code to do the right thing.

;-)

> Maybe we can make gpiod_get_optional look like this:
>
>         if (!dev->of_node && isnt_a_acpi_device(dev) && !IS_ENABLED(GPIOL=
IB))
>                 return NULL;
>         else
>                 return -ENOSYS;
>
> I don't know how isnt_a_acpi_device looks like, probably it involves
> CONFIG_ACPI and/or dev->acpi_node.
>
> This should be safe and still comfortable for legacy platforms, isn't it?

Yes, that should do the trick.

No feedback from me about ACPI.

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
