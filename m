From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL calls
Date: Thu, 23 Mar 2017 14:37:51 +0100
Message-ID: <CACRpkdZhLgM=PzUrCwR-gWssVQQ5KAkOS31cTx4xbpbSBpBPXQ@mail.gmail.com>
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
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 23, 2017 at 11:10 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> So you exchanged many obvious and easy to fix problems with a few hard
> ones. I don't agree that's a good idea, but you seem to be willing to
> try it. Good luck.

I think instead of going to sarcastic remarks you can say you NACK the
patch and suggest that it be reverted?

The problem I have here as maintainer is that both you and Dmitry are
very smart people and I have a great deal of trust invested in both of you.

When two valued contributors give me very different advice I get a bit
confused and maybe the best option is not to change anything at all
right now, and just revert Dmitry's patch.

git grep -e 'gpio.*optional(' | wc -l
gives 154 use sites outside drivers/gpio, so it is not impossible to fix
this if we want a good and strict order to it. I'm just a bit overworked to
do it myself right now.

What do you all say, is it better to revert Dmitry's patch and instead go
around and fix the consumers to do it correctly everywhere, after
hammering down the exact semantics?

Yours,
Linus Walleij
