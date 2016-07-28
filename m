From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: debug tip after earlycon is closed?
Date: Thu, 28 Jul 2016 09:44:53 +0200
Message-ID: <7034241.kLArk8ex69@wuerfel>
References: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com> <3860396.RT1mlU0LAT@wuerfel> <CAK7LNARtm_2uT3nbga4X0dMYs9jhKa8a2FTGJrYbVRg8P3vHQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNARtm_2uT3nbga4X0dMYs9jhKa8a2FTGJrYbVRg8P3vHQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thursday, July 28, 2016 11:08:13 AM CEST Masahiro Yamada wrote:
> Hi Arnd,
> 
> 
> 2016-07-27 16:32 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> > On Wednesday, July 27, 2016 10:23:09 AM CEST Masahiro Yamada wrote:
> >> [    0.000004] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps
> >> every 4398046511100ns
> >> [    0.008254] Console: colour dummy device 80x25
> >> [    0.012700] console [tty0] enabled
> >> [    0.016110] bootconsole [uniphier0] disabled
> >
> > I assume that the original console is on a uart, while the new console
> > appears to be on the framebuffer. Maybe you have no screen attached?
> >
> 
> 
> I use 8250-compat serial console for both.
> 
> 
> The following is the full boot log when success.
> 
> 
> I am not sure about:
> [    0.000141] Console: colour dummy device 80x25
> [    0.000550] console [tty0] enabled
> 
> 
> 
> This is the UART console I am really using.
> [    0.234743] 54006800.serial: ttyS0 at MMIO 0x54006800 (irq = 6,
> base_baud = 3676470) is a 16550A
> [    0.994393] console [ttyS0] enabled

I think the problem is that you have three consoles:

- the boot console that stays active until a real console comes up
- the framebuffer console that is initialized early and goes on to
  disable the bootconsole
- the serial console that you are looking at but which doesn't get
  initialized until much later

Clearly something is wrong in this setup and we don't want to
disable the boot console before the serial console is up.

I guess you could work around it by disabling the framebuffer console
at compile time, or by having the serial console initialized earlier
than the framebuffer, but I wonder if this is something that could
use a more general solution.

	Arnd
