From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Wed, 24 Aug 2016 14:14:23 +0200
Message-ID: <CACRpkda4BmgfuYo0Tj8Rvoq4qvfSz7HT03J0dNPJiL4z7PWx1g@mail.gmail.com>
References: <20160818011445.22726-1-robh@kernel.org> <12886761.WF058qtZp8@wuerfel>
 <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
 <2775954.hrE2UdODgU@wuerfel> <20160822164533.688a6aec@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822164533.688a6aec@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 22, 2016 at 5:45 PM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:

> and if I look at the usermode crapfest on a lot of Android systems it
> looks similar but with the notion of things like being able to describe
>
> -       Use GPIO mode sleeping and assume first char is X to save power

It's really nasty hardware design, or a software hack to solve
a hardware problem: what should have been done is
of course create a UART with an asynchronous low-power mode
that can recieve a character and wake up the system at any time,
handing over the wakeup character(s) to the driver. That is
obviously the usecase they were designing for.

But yeah, I guess we have to contain hacks like that.

> -       Power up, wait n ms, write, read, wait n ms, power down (which
>         has to be driven at the ldisc/user level as only the ldisc
>         understands transactions, or via ioctls (right now Android user
>         space tends to do hardcoded writes to /sys.. gpio to drive power

This kind of abominational abuse of the GPIO sysfs ABI is
partly why I've obsoleted it. The right abstraction is the
fixed regulator with a GPIO line obviously, then some
sequencing along the lines of what you can find in
drivers/mmc/core/pwrseq*

Unfortunately that sysfs ABI crept in during a window of time
when GPIO was unmaintained and I am trying my best to
contain and improve the situation.

Yours,
Linus Walleij
