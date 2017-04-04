From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Tue, 4 Apr 2017 14:53:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704041433000.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <87pogur0y9.fsf@firstfloor.org> <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr> <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au> <CAMuHMdUTW7Fh+3kWKFCToqhaz-+58--=Sx1Zv0KRnVY4bDKOGQ@mail.gmail.com>
 <CAHp75VdCPHW-jZ7FCrEjqHQ6ULxH_U9EsBHTjb4a=Nhs_kYFGg@mail.gmail.com> <1491325150.7125.62.camel@tzanussi-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-589372803-1491331993=:1847"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491325150.7125.62.camel@tzanussi-mobl.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Stuart Longland <stuartl@longlandclan.id.au>, Andi Kleen <andi@firstfloor.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-589372803-1491331993=:1847
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 4 Apr 2017, Tom Zanussi wrote:

> Yes, in a previous project, I had been working toward getting a < 1M
> system to boot on Galileo hardware (which it did, but using more than
> that - the Galileo2 has 256MB, but it was the target hardware at the
> time, and I was hoping eventually to be able to boot out of the 512k
> on-chip SRAM).
> 
> I was focused at that point mainly on the kernel static size, and using
> a combination of Josh Triplett's tinification tree, Andi Kleen's LTO and
> net-diet patches, and my own miscellaneous patches that I was planning
> on eventually upstreaming, I ended up with a system that I could boot to
> shell with a 455k text size:
> 
> Memory: 235636K/245176K available (455K kernel code, 61K rwdata,
> 64K rodata, 132K init, 56K bss, 3056K reserved, 0K cma-reserved)
> 
> virtual kernel memory layout:
>     fixmap  : 0xfffe5000 - 0xfffff000   ( 104 kB)
>     vmalloc : 0xd05f0000 - 0xfffe3000   ( 761 MB)
>     lowmem  : 0xc0000000 - 0xcfdf0000   ( 253 MB)
>       .init : 0xc1094000 - 0xc10b5000   ( 132 kB)
>       .data : 0xc1071fac - 0xc1092760   ( 129 kB)
>       .text : 0xc1000000 - 0xc1071fac   ( 455 kB)
> 
> That was without networking.  Enabling networking added about 250k, and
> at that point I could ssh in and run a webserver, still less than 1M as
> far as kernel static size, which of course completely ignores the kernel
> dynamic size and userspace.
> 
> My goal was to get rid of shell access and dropbear altogether and have
> all access be via webserver, which I did by using nostromo, mainly for
> convenience, until I could get some 'cgi' added to Alan Cox's µWeb
> (about 20k).
> 
> Anyway, that work, as I left it a couple years ago, is here, in case
> anyone's interested (it's a yocto layer and yocto-based kernel
> containing many topic branches, but building it according to the
> directions in the README will yield a standard kernel and .config in the
> working directory and allow you to ignore all the yocto stuff): 
> 
> https://github.com/tzanussi/linux-yocto-micro-4.1  
> https://github.com/tzanussi/meta-microlinux/tree/jethro

Thanks for sharing I'll certainly have a look.

> It's nice to see tinification work being done again - at the time I
> stopped working on it it seemed there was no desire from maintainers in
> general to merge anything that would create new options designed only
> for the purpose of tinification.

I successfully provided an option to disable POSIX timers lately. A 
round trip into the Kconfig parser was required to achieve that though.

Many maintainers are resistant to change as their role is to preserve 
stability of their code. Adding special cases in existing code makes it 
much harder to maintain and validate. Sometimes it is way better to have 
a parallel implementation rather that destabilizing the one version 
available... as long as the interface is the same and that the big and 
tiny versions can be used interchangeably.

> In fact, as a kind of backup plan for that, I also played around with
> the idea of auto-generating a kernel that would contain only the
> functions that were demonstrated to be used by the (single-purpose)
> workload.  It was similar to the idea of making every system call
> configurable and then including only the ones used by the workload, but
> taking it a step further and doing that for every function in the
> kernel, not just system calls.

I thought about that too... and dismissed the idea as being too 
frightening!

> I had a script that would take the output of the function_hist histogram
> taken while exhaustively running the workload:
> 
>   https://lkml.org/lkml/2015/5/20/994
> 
> And with a kernel compiled using -ffunction-sections removing all
> functions that were never referenced.  I never got a bootable kernel out
> of it, but mainly just because I ran out of time and had to move onto
> other things.  I may dust it off and try again, just for fun... ;-)

That would be great.

I really wish to stir up interest from more people and have Linux gain 
momentum in the tiny system space.


Nicolas
--8323328-589372803-1491331993=:1847--
