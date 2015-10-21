From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: console vs earlycon ?
Date: Wed, 21 Oct 2015 16:13:08 +0200
Message-ID: <4963882.HSXu6hF7zO@wuerfel>
References: <CAK7LNARem16fTim8Ds_y8ezMusz_aRtv6c59KoxyC0rLV-RBWw@mail.gmail.com> <5490682.zH2vAEO2id@wuerfel> <562798EB.7060202@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <562798EB.7060202@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wednesday 21 October 2015 09:53:47 Peter Hurley wrote:
> On 10/21/2015 06:36 AM, Arnd Bergmann wrote:
> > On Wednesday 21 October 2015 18:30:05 Masahiro Yamada wrote:
> >>>
> >>>> I am trying to implement OF_EARLYCON_DECLARE() for that.
> >>>>
> >>>> I was just wondering if console_initcall() should work as well.
> >>>>
> >>>>
> >>>> As I said, I noticed the console_initcall() in 8250_core.c
> >>>> only works on very limited platforms.
> >>>
> >>> It works with all those that use of_serial.c, right?
> >>
> >> I doubt it.
> >>
> >>
> >> I have a board with a pure 8250-compat device working.
> >> (  compatible = "ns16550a")
> >> It uses of_serial.c, of course.
> >>
> >>
> >> As far as I tested, it would never enable the console at console_init().
> > 
> > Ok, that sounds like a bug. Peter and others have changed that code
> > a lot in the last year. I wonder if this has never worked then or
> > if it has regressed.
> 
> No, not a bug. console_init() is only for legacy platforms, not for
> probed drivers.

Ah, I had no idea we were moving in this direction. So I guess the idea
is not to add another for_each_compatible_node() loop when we already have
two places (earlycon and tty) in the code that do this?

> > * arch/powerpc/kernel/legacy_serial.c does everything we need, but
> >   does not live in architecture independent code and does a few
> >   things that we probably don't need or want there. It relies
> >   on scanning the device tree for known UART device nodes before
> >   the platform devices are added.
> > 
> > * for console_initcall() to do the right thing, we want both the
> >   ttyS devices to get added early for console=ttyS1 to work, as well
> >   as having the preferred console work based on the stdout-property.
> > 
> > * we parse the /chosen/stdout-path property in drivers/of/base and
> >   store the device node pointer in the global 'of_stdout' variable,
> >   but do not use it until the uart is added by the tty driver
> >   and calls of_console_check() to add the default console device.
> 
> I'm assuming the issue with trying to get console_init() working
> is because the dummy color console causes the earlycon to be disabled?

I don't think so.

My line of thinking was more about usability: earlycon requires that
you edit the kernel command line at the moment, while console_init()
doesn't require any user interaction and just uses the stdout-path.

I guess we could enable earlycon using a Kconfig symbol if we want
to, or make it a per-architecture decision whether it's enabled even
in the absence of the command line flag.

	Arnd
