From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: serial driver cleanups v2
Date: Fri, 15 Mar 2019 11:20:58 +0200
Message-ID: <CAHp75Vf+f-b+px__ekdDZPFHtmMwoBVw-itoTtxfELesfSciXg@mail.gmail.com>
References: <1552602855-26086-1-git-send-email-info@metux.net> <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Tobias Klauser <tklauser@distanz.ch>, Richard Genoud <richard.genoud@gmail.com>, macro@linux-mips.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@g
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 15, 2019 at 11:12 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Mar 15, 2019 at 12:40 AM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>
> > here's v2 of my serial cleanups queue - part I:
> >
> > essentially using helpers to code more compact and switching to
> > devm_*() functions for mmio management.
> >
> > Part II will be about moving the mmio range from mapbase and
> > mapsize (which are used quite inconsistently) to a struct resource
> > and using helpers for that. But this one isn't finished yet.
> > (if somebody likes to have a look at it, I can send it, too)
>
> Let's do that way you are preparing a branch somewhere and anounce
> here as an RFC, since this was neither tested nor correct.
> And selling point for many of them is not true: it doesn't make any
> difference in the size in code, but increases a time to run
> (devm_ioremap_resource() does more than plain devm_iomap() call).

And one more thing, perhaps you can run existing and / or contribute
to coccinelle since this all scriptable and maintainers can decide if
this or that coccinelle script is useful.

-- 
With Best Regards,
Andy Shevchenko
