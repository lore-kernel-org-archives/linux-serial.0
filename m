From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: problems with serial driver
Date: Wed, 4 Sep 2002 08:57:43 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <073901c25412$a8b9f960$294b82ce@connecttech.com>
References: <Pine.LNX.4.44.0209040919280.25638-100000@scil.sinp.msu.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: slack@slackware.ru
Cc: linux-serial@vger.kernel.org

From: <slack@slackware.ru>
> Hm... Hardware problem on different chipsets, different processors,
> different kernels(only chip is 16550A). I understand, that this can
> indicate hardware problems.

That certainly indicates a driver problem. Interesting.

> OK, I know that. It is clear. Can You tell me, why usleep(100) totally
> eliminates the problem with garbage?

No idea, except that you're getting lucky. Always start the receiver
first.

> :) Ok, Ok. Have You ever got in touch with 2xP4 Xeon Mother with ISA slots
> from Supermicro? The problem is in fact, that I ve get total kernel halts
> when often open/close/startprog with serial ports. For example, running
> script, that launches the prog and killing it, can kill the comp in a
> short period of time with overruns.

Double check that you don't have any irq conflicts. An overrun can
happen when the driver's handler is delayed too long. It used to be
that the IDE interrupt handler was very long, and that would delay
other handlers, including the serial driver's. Also, double check that
the resources (irq, memory, etc) you're using for the ISA slots is
reserved by the bios so that the PCI system doesn't also use it.

Hm, actually, I've assumed that you have serial ports on an ISA card.
If you're having problems with the on-board serial ports on your
motherboard, you'll need to contact the serial driver maintainer (Ted
T'so, although he hasn't done much with it recently), or perhaps
Russell King (likely the next serial maintainer). I'm just a serial
driver hacker. :-)

> Sorry, I'm short in deep HW knowledge, and, also, I have no much time
> to debug such problem(but like to do that). :( Also, I don't know, how to
> debug it in a better way in the kernel.

I don't have any quick n easy tips on how to determine if the
interrupt routine is being delayed. There is a low latency patch (or
possibly config option) that speeds up the handling of bytes in the
serial/tty drivers; you could try that and see if it helps.

..Stu


