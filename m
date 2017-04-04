From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Tue, 04 Apr 2017 11:59:10 -0500
Message-ID: <1491325150.7125.62.camel@tzanussi-mobl.amr.corp.intel.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
         <87pogur0y9.fsf@firstfloor.org>
         <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
         <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
         <CAMuHMdUTW7Fh+3kWKFCToqhaz-+58--=Sx1Zv0KRnVY4bDKOGQ@mail.gmail.com>
         <CAHp75VdCPHW-jZ7FCrEjqHQ6ULxH_U9EsBHTjb4a=Nhs_kYFGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdCPHW-jZ7FCrEjqHQ6ULxH_U9EsBHTjb4a=Nhs_kYFGg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Stuart Longland <stuartl@longlandclan.id.au>, Nicolas Pitre <nicolas.pitre@linaro.org>, Andi Kleen <andi@firstfloor.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Tue, 2017-04-04 at 00:05 +0300, Andy Shevchenko wrote:
> +Cc: Tom
> 
> Summon Tom to the discussion. He tried once hard to shrink a Linux
> kernel to something working in 1M+ RAM on x86.
> 

Yes, in a previous project, I had been working toward getting a < 1M
system to boot on Galileo hardware (which it did, but using more than
that - the Galileo2 has 256MB, but it was the target hardware at the
time, and I was hoping eventually to be able to boot out of the 512k
on-chip SRAM).

I was focused at that point mainly on the kernel static size, and using
a combination of Josh Triplett's tinification tree, Andi Kleen's LTO and
net-diet patches, and my own miscellaneous patches that I was planning
on eventually upstreaming, I ended up with a system that I could boot to
shell with a 455k text size:

Memory: 235636K/245176K available (455K kernel code, 61K rwdata,
64K rodata, 132K init, 56K bss, 3056K reserved, 0K cma-reserved)

virtual kernel memory layout:
    fixmap  : 0xfffe5000 - 0xfffff000   ( 104 kB)
    vmalloc : 0xd05f0000 - 0xfffe3000   ( 761 MB)
    lowmem  : 0xc0000000 - 0xcfdf0000   ( 253 MB)
      .init : 0xc1094000 - 0xc10b5000   ( 132 kB)
      .data : 0xc1071fac - 0xc1092760   ( 129 kB)
      .text : 0xc1000000 - 0xc1071fac   ( 455 kB)

That was without networking.  Enabling networking added about 250k, and
at that point I could ssh in and run a webserver, still less than 1M as
far as kernel static size, which of course completely ignores the kernel
dynamic size and userspace.

My goal was to get rid of shell access and dropbear altogether and have
all access be via webserver, which I did by using nostromo, mainly for
convenience, until I could get some 'cgi' added to Alan Cox's µWeb
(about 20k).

Anyway, that work, as I left it a couple years ago, is here, in case
anyone's interested (it's a yocto layer and yocto-based kernel
containing many topic branches, but building it according to the
directions in the README will yield a standard kernel and .config in the
working directory and allow you to ignore all the yocto stuff): 

https://github.com/tzanussi/linux-yocto-micro-4.1  
https://github.com/tzanussi/meta-microlinux/tree/jethro

It's nice to see tinification work being done again - at the time I
stopped working on it it seemed there was no desire from maintainers in
general to merge anything that would create new options designed only
for the purpose of tinification.

In fact, as a kind of backup plan for that, I also played around with
the idea of auto-generating a kernel that would contain only the
functions that were demonstrated to be used by the (single-purpose)
workload.  It was similar to the idea of making every system call
configurable and then including only the ones used by the workload, but
taking it a step further and doing that for every function in the
kernel, not just system calls.

I had a script that would take the output of the function_hist histogram
taken while exhaustively running the workload:

  https://lkml.org/lkml/2015/5/20/994

And with a kernel compiled using -ffunction-sections removing all
functions that were never referenced.  I never got a bootable kernel out
of it, but mainly just because I ran out of time and had to move onto
other things.  I may dust it off and try again, just for fun... ;-)

hth,

Tom

> Tom, sorry, I recall this a bit late, perhaps you might be interested
> in reading discussion from the beginning.
> 
> On Mon, Apr 3, 2017 at 9:14 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Apr 3, 2017 at 12:44 AM, Stuart Longland
> > <stuartl@longlandclan.id.au> wrote:
> >> On 03/04/17 07:41, Nicolas Pitre wrote:
> >>>> No PTYs seems like a big limitation. This means no sshd?
> >>> Again, my ultimate system target is in the sub-megabyte of RAM.  I
> >>> really doubt you'll be able to fit an SSH server in there even if PTYs
> >>> were supported, unless sshd (or dropbear) can be made really tiny.
> >>> Otherwise you most probably have sufficient resources to run the regular
> >>> TTY code.
> >>
> >> Are we talking small microcontrollers here?  The smallest machine in
> >> terms of RAM I ever recall running Linux on was a 386SX/25 MHz with 4MB
> >> RAM, and that had a MMU.
> >
> > Let's halve that. I once tried and ran Linux in 2 MiB, incl. X, twm, and xterm.
> > Of course with swap enabled.  And swapping like hell.
> 
> 
