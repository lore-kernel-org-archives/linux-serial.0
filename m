From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Tue, 4 Apr 2017 14:31:36 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704041411150.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <87pogur0y9.fsf@firstfloor.org> <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr> <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au> <CAMuHMdUTW7Fh+3kWKFCToqhaz-+58--=Sx1Zv0KRnVY4bDKOGQ@mail.gmail.com>
 <CAHp75VdCPHW-jZ7FCrEjqHQ6ULxH_U9EsBHTjb4a=Nhs_kYFGg@mail.gmail.com> <1491325150.7125.62.camel@tzanussi-mobl.amr.corp.intel.com> <CAHp75VcUorx5D2ive8eNWhtu2BzSbYAm+y9_KeFYdkTMgsg0SA@mail.gmail.com> <1491328749.7125.66.camel@tzanussi-mobl.amr.corp.intel.com>
 <CAHp75VfQVdMRZnbDFyH9m=HfSuoiUxqhf2y+H07u4u6xPd7DUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfQVdMRZnbDFyH9m=HfSuoiUxqhf2y+H07u4u6xPd7DUA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Stuart Longland <stuartl@longlandclan.id.au>, Andi Kleen <andi@firstfloor.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 4 Apr 2017, Andy Shevchenko wrote:

> On Tue, Apr 4, 2017 at 8:59 PM, Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> > On Tue, 2017-04-04 at 20:08 +0300, Andy Shevchenko wrote:
> >> On Tue, Apr 4, 2017 at 7:59 PM, Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> >> > On Tue, 2017-04-04 at 00:05 +0300, Andy Shevchenko wrote:
> 
> >> > I was focused at that point mainly on the kernel static size, and using
> >> > a combination of Josh Triplett's tinification tree, Andi Kleen's LTO and
> >> > net-diet patches, and my own miscellaneous patches that I was planning
> >> > on eventually upstreaming, I ended up with a system that I could boot to
> >> > shell with a 455k text size:
> >> >
> >> > Memory: 235636K/245176K available (455K kernel code, 61K rwdata,
> >> > 64K rodata, 132K init, 56K bss, 3056K reserved, 0K cma-reserved)
> 
> >> Thanks for sharing your experience. The question closer to this
> >> discussion what did you do against TTY/UART/(related) layer(s)?
> >>
> >
> > I'd have to go back and take a look, but nothing special AFIAR.
> >
> > No patches or hacks along those lines, and the only related thing I see
> > as far as config is:
> >
> >         cfg/pty-disable.scc \
> >
> > which maps to:
> >
> >         # CONFIG_UNIX98_PTYS is not set
> 
> But on your guestimation how much can we squeeze TTY/UART layer if we
> do some compile-time configuration?
> Does it even make sense or better to introduce something like minitty
> special layer instead?

For the record I more or less came along the same path as Tom, playing 
with LTO, gc-sections, syscall removal, module_param() removal, etc. At 
the end of the day you still have that 45K of TTY code just to send 
debug out, 100K of VFS even if using only ramfs, 54K of timer code even 
if there's only one simple timer available, 28K of IRQ support code even 
if there is only one type of interrupt used, etc. LTO / gc-section 
cannot automatically get rid of those unused functions because they're 
runtime selected callbacks and optimization tools no longer can do their 
magic.

At some point there is no way other than having a parallel 
implementation specifically for a limited scope to reduce both code 
footprint and runtime RAM consumption. Who need a multicore scalable VFS 
cache when there's only 256K of RAM and a single user space process 
running?


Nicolas
