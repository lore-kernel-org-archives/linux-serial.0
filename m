From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Thu, 23 Mar 2017 12:11:06 +0100
Message-ID: <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de>
References: <20170306100220.droey65uq2ew3mzu@pengutronix.de>
 <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
 <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
 <CAMuHMdXGn35bEsJKnUi5o3AytL4AJN2fBfoB79v5W-jOVFQx6g@mail.gmail.com>
 <20170320103113.tpveoq2onzrwmkdt@pengutronix.de>
 <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
 <20170320110718.e44s2gip36m75bqj@pengutronix.de>
 <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
 <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de>
 <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hello,

On Thu, Mar 23, 2017 at 11:20:39AM +0100, Geert Uytterhoeven wrote:
> But having the error breaks setups where the GPIO is optional and does
> not exist.

so the right way forward is to check harder in the situation where
-ENOSYS was returned before to determine if there is really no GPIO to
be used. "Oh, there are hints that there is no GPIO (GPIOLIB=n), so lets
assume there isn't." is wrong.

Can we please properly fix the problem instead of papering over it?

> Make sure to enable all drivers and subsystems you need when building
> your kernel. That's always true. And may indeed be hard to debug (e.g. what
> kernel options do I need to make systemd work?).

It's worse here. If you forget to enable a driver the device isn't bound
and that's obvious to diagnose. When ignoring an optional GPIO there
might be a device that claims to work but fails to do so. (e.g. you
write to memory, write() returns 0, but the data never landed there.)

> > write(2) and close(2) succeed most of the time, too. Still it's not a
> > good idea to not check the return value. Or let the kernel return
> > success unconditionally.
> 
> Writing all bytes passed in the buffer is "optional" in another sense than
> an "optional" GPIO: you must retry the write, while you can continue if
> an optional GPIO is not present.

And that is the point. You can continue *iff* the optional GPIO is not
present. The patch in question removes the ability to determine if that
GPIO is present and claims it is not present.

> > So you exchanged many obvious and easy to fix problems with a few hard
> > ones. I don't agree that's a good idea, but you seem to be willing to
> > try it. Good luck.
> 
> Yeah, before drivers had to explicitly ignore -ENOSYS if they want to
> support platforms with and without GPIOLIB. Bad...

Doing things right is sometimes not maximally easy. But that is no
excuse to do it wrong.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
