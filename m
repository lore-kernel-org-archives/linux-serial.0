From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Tue, 4 Apr 2017 16:27:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704041607130.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <87pogur0y9.fsf@firstfloor.org> <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr> <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au> <CAMuHMdUTW7Fh+3kWKFCToqhaz-+58--=Sx1Zv0KRnVY4bDKOGQ@mail.gmail.com>
 <CAHp75VdCPHW-jZ7FCrEjqHQ6ULxH_U9EsBHTjb4a=Nhs_kYFGg@mail.gmail.com> <1491325150.7125.62.camel@tzanussi-mobl.amr.corp.intel.com> <CAHp75VcUorx5D2ive8eNWhtu2BzSbYAm+y9_KeFYdkTMgsg0SA@mail.gmail.com> <1491328749.7125.66.camel@tzanussi-mobl.amr.corp.intel.com>
 <CAHp75VfQVdMRZnbDFyH9m=HfSuoiUxqhf2y+H07u4u6xPd7DUA@mail.gmail.com> <1491335924.7125.87.camel@tzanussi-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1549118461-1491337631=:1847"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491335924.7125.87.camel@tzanussi-mobl.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Stuart Longland <stuartl@longlandclan.id.au>, Andi Kleen <andi@firstfloor.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1549118461-1491337631=:1847
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 4 Apr 2017, Tom Zanussi wrote:

> On Tue, 2017-04-04 at 21:04 +0300, Andy Shevchenko wrote:
> > I believe you did some research during time of that project…
> > 
> 
> Yes, as a matter of fact I did, and just found some notes I took at the
> time.  I didn't dive into the code in detail - that level of analysis
> was supposed to come later but I did have these notes mentioning that I
> thought it would show the largest savings for a single item (outside of
> networking) 'if we could do it':
> 
> "- Largest is still drivers
> 
> - drivers/tty and serial is the biggest obvious win if we can do it
>   - break down into granular config options
>     - leave simplest possible tty/serial functionality
>     - allow tailoring to specific hardware
>   - also helps in effort to get rid of char devices
>   - 65740/815190"
> 
> Basically 65k out of an 800k text size could be partially or mostly
> saved by addressing that one item, which looks like it pretty much
> matches Nicolas' numbers...

One thing on x86 that inflates the size is the 8250 driver itself. I'm 
looking at some ARM targets with their own UART whose driver is much 
smaller.

> BTW, since I'm quoting my own notes on the subject, I thought I'd just
> include the whole thing, which covers a bunch of other areas possibly
> ripe for tinification, in case anyone might be interested (some of it
> should be taken with a grain of salt though ;-)
> 
[...]
> 
> - 2nd largest is kernel
> 
>   - should be able to cut *something* from time and sched
>     - we have a handful of processes at most
>     - we have very simple time needs
>   - say 30000/815190 savings
> 
>  150742	   6376	   8209	 165327	  285cf	./kernel/built-in.o
> 
>   40951	   1105	   4720	  46776	   b6b8	./kernel/time/built-in.o

Commit baa73d9e47 allows for shaving off 25K here. More could probably 
be done.

>   21760	   1318	    112	  23190	   5a96	./kernel/sched/built-in.o

I already have an alternative scheduler implementation that weights 9K. 
It is on the backburner for now though. But don't let the scheduler 
guys know just yet.  ;-)


Nicolas
--8323328-1549118461-1491337631=:1847--
