From: slack@slackware.ru
Subject: Re: problems with serial driver
Date: Wed, 4 Sep 2002 18:21:23 +0400 (MSD)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0209041734310.26018-100000@scil.sinp.msu.ru>
References: <073901c25412$a8b9f960$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <073901c25412$a8b9f960$294b82ce@connecttech.com>
List-Id: linux-serial@vger.kernel.org
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: linux-serial@vger.kernel.org


On Wed, 4 Sep 2002, Stuart MacDonald wrote:

> From: <slack@slackware.ru>
> > Hm... Hardware problem on different chipsets, different processors,
> > different kernels(only chip is 16550A). I understand, that this can
> > indicate hardware problems.
> That certainly indicates a driver problem. Interesting.

> > OK, I know that. It is clear. Can You tell me, why usleep(100) totally
> > eliminates the problem with garbage?
> No idea, except that you're getting lucky. Always start the receiver
> first.
:) Starting sender, starting receiver, CtrlC (kill -15, getting KILL
signal in the prog). One note: both ports are on the same comp.

> > when often open/close/startprog with serial ports. For example, running
> > script, that launches the prog and killing it, can kill the comp in a
> > short period of time with overruns.
> Double check that you don't have any irq conflicts.
Quatro check. I do not know how, but serverworks defines IRQs after 16 for
side devices. But I have pure computers, without any devices. Of cource,
I've got bad results on well-weaponed comp (audio, video IO etc.).
With another chipset (860). Then, checkin new computers, that are virgin.

> An overrun can
> happen when the driver's handler is delayed too long.
I see this, in the driver. But do not know what to do.

> It used to be
> that the IDE interrupt handler was very long, and that would delay
> other handlers, including the serial driver's.
Ah! Those old discussion about slow(long) and fast(short) interrupts?

> Also, double check that
> the resources (irq, memory, etc) you're using for the ISA slots is
> reserved by the bios so that the PCI system doesn't also use it.
Hm... Where riside COM on-board ports? On which BUS (PCI/ISA)?

> Hm, actually, I've assumed that you have serial ports on an ISA card.
> T'so, although he hasn't done much with it recently), or perhaps
> Russell King (likely the next serial maintainer). I'm just a serial
> driver hacker. :-)
:-)
OK.

> interrupt routine is being delayed. There is a low latency patch (or
> possibly config option) that speeds up the handling of bytes in the
> serial/tty drivers; you could try that and see if it helps.
Thanx!


