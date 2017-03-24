From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL calls
Date: Fri, 24 Mar 2017 09:58:28 +0100
Message-ID: <CACRpkdYBesafyhp0=W-cnOncYJ-1eNHZ4E_nv_f0AkWrhUk41Q@mail.gmail.com>
References: <20170320110718.e44s2gip36m75bqj@pengutronix.de>
 <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
 <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de> <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
 <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de> <CAMuHMdUWybAZXc2RbGMGyp4DYQZU9BS8MxXKE5Kfd+aH8+w9sA@mail.gmail.com>
 <20170323123437.uqdwhfmmsjke3f7s@pengutronix.de> <CACRpkdZRfLh9RXRycW_cAxuTYE6tPd7LR32EkAW8y2fh=AxhXA@mail.gmail.com>
 <20170323144325.GA952@dtor-ws> <20170323154441.GA9460@dtor-ws> <20170323191020.nrstp2cfh7cuqvf3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170323191020.nrstp2cfh7cuqvf3@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 23, 2017 at 8:10 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Mar 23, 2017 at 08:44:41AM -0700, Dmitry Torokhov wrote:
>> On Thu, Mar 23, 2017 at 07:43:25AM -0700, Dmitry Torokhov wrote:
>> > On Thu, Mar 23, 2017 at 02:41:53PM +0100, Linus Walleij wrote:
>> > > On Thu, Mar 23, 2017 at 1:34 PM, Uwe Kleine-K=C3=B6nig
>> > > <u.kleine-koenig@pengutronix.de> wrote:
>> > >
>> > > > Maybe we can make gpiod_get_optional look like this:
>> > > >
>> > > >         if (!dev->of_node && isnt_a_acpi_device(dev) && !IS_ENABLE=
D(GPIOLIB))
>> > > >                 return NULL;
>> > > >         else
>> > > >                 return -ENOSYS;
>> > > >
>> > > > I don't know how isnt_a_acpi_device looks like, probably it involv=
es
>> > > > CONFIG_ACPI and/or dev->acpi_node.
>> > > >
>> > > > This should be safe and still comfortable for legacy platforms, is=
n't it?
>> > >
>> > > I like the looks of this.
>> > >
>> > > Can we revert Dmitry's patch and apply something like this instead?
>> > >
>> > > Dmitry, how do you feel about this?
>> >
>> > I frankly do not see the point. It still makes driver code more comple=
x
>
> Note that this code is in the gpio header, and not in driver code. So
> the driver just does
>
>         gpiod =3D gpiod_get_optional(...)
>         if (IS_ERR(gpiod))
>                 return PTR_ERR(gpiod);
>
> (as it is supposed to do now). I think that's nice.

It does look nice. Compare this to what we must do for optional regulators:

        st->reg =3D devm_regulator_get_optional(&spi->dev, "vref");
        if (IS_ERR(st->reg)) {
                /* Any other error indicates that the regulator does exist =
*/
                if (PTR_ERR(st->reg) !=3D -ENODEV)
                        return PTR_ERR(st->reg);
                /* Use internal reference */
        }

So for optional regulators we get -ENODEV if we don't have it,
and then proceed on an alternate path, such as using an internal
reference voltage.

However the fact that regulators and GPIO optionals are already
handled differently is creating "cognitive dissonance" or what I
should call it.

Yours,
Linus Walleij
