From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL calls
Date: Thu, 23 Mar 2017 11:20:39 +0100
Message-ID: <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
References: <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
 <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
 <20170306100220.droey65uq2ew3mzu@pengutronix.de> <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
 <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
 <CAMuHMdXGn35bEsJKnUi5o3AytL4AJN2fBfoB79v5W-jOVFQx6g@mail.gmail.com>
 <20170320103113.tpveoq2onzrwmkdt@pengutronix.de> <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
 <20170320110718.e44s2gip36m75bqj@pengutronix.de> <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
 <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Uwe,

On Thu, Mar 23, 2017 at 11:10 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Mar 23, 2017 at 10:32:01AM +0100, Linus Walleij wrote:
>> On Mon, Mar 20, 2017 at 12:07 PM, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > On Mon, Mar 20, 2017 at 11:38:52AM +0100, Geert Uytterhoeven wrote:
>> >> On Mon, Mar 20, 2017 at 11:31 AM, Uwe Kleine-K=C3=B6nig
>> >> <u.kleine-koenig@pengutronix.de> wrote:
>> >> > On Mon, Mar 20, 2017 at 10:56:14AM +0100, Geert Uytterhoeven wrote:
>> >> >> Documentation/gpio/consumer.txt rightfully sates:
>> >> >> | Note that gpio_get*_optional() functions (and their managed vari=
ants), unlike
>> >> >> | the rest of gpiolib API, also return NULL when gpiolib support i=
s disabled.
>> >> >> | This is helpful to driver authors, since they do not need to spe=
cial case
>> >> >> | -ENOSYS return codes.  System integrators should however be care=
ful to enable
>> >> >> | gpiolib on systems that need it.
>> >> >
>> >> > I cannot find this paragraph in Documentation/gpio/consumer.txt:
>> >> >
>> >> >         $ git grep -e 'ENOSYS' v4.11-rc3 -- Documentation/gpio/
>> >> >         <void>
>> >>
>> >> It was added by commit 22c403676dbbb7c6 ("gpio: return NULL from
>> >> gpiod_get_optional when GPIOLIB is disabled")
>> >
>> > Ah, that's in next.
>> >
>> > I still think this is wrong and I'm a bit disappointed that Linus merg=
ed
>> > this patch (without saying so in the thread even) as I thought Linus a=
nd
>> > I agreed on this being a bad idea.
>>
>> I think it is not good, but what we have before this patch is worse.
>>
>> I.e. it is the lesser evil.
>>
>> Before this patch the API is inconsistent: it gives NULL if GPIOLIB
>> is defined and -ENOSYS if GPIOLIB is not defined.
>
> So old is: it worked as intended with GPIOLIB and produced an error
> without GPIOLIB even if no GPIO is there and NULL would be right.
>
>> After this patch it gives NULL in both cases, and that is at least
>> consistent.
>
> And new is: with GPIOLIB it still works as intended and gives you NULL
> even if a GPIO is there and so -ENOSYS would be right.

If I forget to enable a driver, the corresponding class device is also not
there.

> I admit that most of the time with GPIOLIB NULL is the right answer
> because probably there is no GPIO to handle. But if there is a GPIO you
> run in hard to debug problems instead of being able to see the error
> code and act accordingly.

But having the error breaks setups where the GPIO is optional and does
not exist.

Make sure to enable all drivers and subsystems you need when building
your kernel. That's always true. And may indeed be hard to debug (e.g. what
kernel options do I need to make systemd work?).

> write(2) and close(2) succeed most of the time, too. Still it's not a
> good idea to not check the return value. Or let the kernel return
> success unconditionally.

Writing all bytes passed in the buffer is "optional" in another sense than
an "optional" GPIO: you must retry the write, while you can continue if
an optional GPIO is not present.

> So you exchanged many obvious and easy to fix problems with a few hard
> ones. I don't agree that's a good idea, but you seem to be willing to
> try it. Good luck.

Yeah, before drivers had to explicitly ignore -ENOSYS if they want to
support platforms with and without GPIOLIB. Bad...

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
