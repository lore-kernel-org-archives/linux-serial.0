From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Mon, 3 Apr 2017 12:40:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704031208320.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <87pogur0y9.fsf@firstfloor.org> <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr> <CAHp75VdgEcyXPxENS87nHLtCEHqB5Z-1_T_W1opSiKqqNpeU2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdgEcyXPxENS87nHLtCEHqB5Z-1_T_W1opSiKqqNpeU2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 3 Apr 2017, Andy Shevchenko wrote:

> On Mon, Apr 3, 2017 at 12:41 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Sun, 2 Apr 2017, Andi Kleen wrote:
> >> No PTYs seems like a big limitation. This means no sshd?
> 
> > Again, my ultimate system target is in the sub-megabyte of RAM.  I
> > really doubt you'll be able to fit an SSH server in there even if PTYs
> > were supported, unless sshd (or dropbear) can be made really tiny.
> 
> Are you sure you need Linux there? There is a nice Zephyr project
> (OpenSource RTOS, POSIX compatible) exactly for microcontrollers.

I know that Zephyr is LF endorsed, aim to slow fragmentation in that 
space, etc.  But it is in itself yet another RTOS. It doesn't look like 
it is really POSIX compatible yet, and is certainly not Linux 
compatible.

I don't pretend that Linux should always be preferred to Zephyr. For 
example, I don't think Linux could ever be used with 32KB of RAM while 
Zephyr easily can.  However, in the hundreds of KB of RAM, given the 
choice between Linux and anything else, I can tell you that many people 
would go with Linux.

The goal is really to be able to leverage the existing Linux knowledge 
and ecosystem. Be able to develop your application on your PC 
workstation, singlestep it, strace it, validate the tiny version of 
those kernel subsystems there too with existing fuzers, etc.  If a 
security issue turns up in your product, you have plenty of people who 
are already familiar with the Linux environment, much more than Zephyr 
or any other RTOSes.

> While I can agree on making Linux stuff less fatty, I can't agree on
> doing this way. We have for now two subsystems to serve for serial
> devices, you are proposing third one for only narrow class of devices.
> From my point of view is better to achive your goal with existing
> system (as a proof of concept maybe even with ugly #ifdef:fery).

Been there already. It doesn't work. The #ifdef:fery in the existing 
code simply doesn't cut it. Because of its flexibility, the existing 
code constitutes a stack of many layers each with its own interface and 
buffering. It uses much more runtime memory simply because it can afford 
it on all existing systems supported by Linux. It can drive a large bank 
of modems without a single hiccup if you're still into running a BBS. 
That's why the existing code is how it is.

I don't want a proof of concept. I want something that is maintainable. 
Adding #ifdef's to the existing code will make the end result way less 
maintainable, either for the standard or the mini use case. By being 
really small, the maintenance cost of a parallel implementation isn't 
very high, certainly much less than trying to maintain a single version 
that can scale to both extremes.


Nicolas
