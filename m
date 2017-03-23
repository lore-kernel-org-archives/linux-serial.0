From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Thu, 23 Mar 2017 11:10:45 +0100
Message-ID: <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de>
References: <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
 <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
 <20170306100220.droey65uq2ew3mzu@pengutronix.de>
 <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
 <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
 <CAMuHMdXGn35bEsJKnUi5o3AytL4AJN2fBfoB79v5W-jOVFQx6g@mail.gmail.com>
 <20170320103113.tpveoq2onzrwmkdt@pengutronix.de>
 <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
 <20170320110718.e44s2gip36m75bqj@pengutronix.de>
 <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 23, 2017 at 10:32:01AM +0100, Linus Walleij wrote:
> On Mon, Mar 20, 2017 at 12:07 PM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > Hello Geert,
> >
> > On Mon, Mar 20, 2017 at 11:38:52AM +0100, Geert Uytterhoeven wrote:
> >> On Mon, Mar 20, 2017 at 11:31 AM, Uwe Kleine-König
> >> <u.kleine-koenig@pengutronix.de> wrote:
> >> > On Mon, Mar 20, 2017 at 10:56:14AM +0100, Geert Uytterhoeven wrote:
> >> >> Documentation/gpio/consumer.txt rightfully sates:
> >> >> | Note that gpio_get*_optional() functions (and their managed variants), unlike
> >> >> | the rest of gpiolib API, also return NULL when gpiolib support is disabled.
> >> >> | This is helpful to driver authors, since they do not need to special case
> >> >> | -ENOSYS return codes.  System integrators should however be careful to enable
> >> >> | gpiolib on systems that need it.
> >> >
> >> > I cannot find this paragraph in Documentation/gpio/consumer.txt:
> >> >
> >> >         $ git grep -e 'ENOSYS' v4.11-rc3 -- Documentation/gpio/
> >> >         <void>
> >>
> >> It was added by commit 22c403676dbbb7c6 ("gpio: return NULL from
> >> gpiod_get_optional when GPIOLIB is disabled")
> >
> > Ah, that's in next.
> >
> > I still think this is wrong and I'm a bit disappointed that Linus merged
> > this patch (without saying so in the thread even) as I thought Linus and
> > I agreed on this being a bad idea.
> 
> I think it is not good, but what we have before this patch is worse.
> 
> I.e. it is the lesser evil.
> 
> Before this patch the API is inconsistent: it gives NULL if GPIOLIB
> is defined and -ENOSYS if GPIOLIB is not defined.

So old is: it worked as intended with GPIOLIB and produced an error
without GPIOLIB even if no GPIO is there and NULL would be right.
 
> After this patch it gives NULL in both cases, and that is at least
> consistent.

And new is: with GPIOLIB it still works as intended and gives you NULL
even if a GPIO is there and so -ENOSYS would be right.

I admit that most of the time with GPIOLIB NULL is the right answer
because probably there is no GPIO to handle. But if there is a GPIO you
run in hard to debug problems instead of being able to see the error
code and act accordingly.

write(2) and close(2) succeed most of the time, too. Still it's not a
good idea to not check the return value. Or let the kernel return
success unconditionally.

So you exchanged many obvious and easy to fix problems with a few hard
ones. I don't agree that's a good idea, but you seem to be willing to
try it. Good luck.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
