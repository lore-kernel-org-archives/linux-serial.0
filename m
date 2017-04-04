From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Tue, 04 Apr 2017 12:59:09 -0500
Message-ID: <1491328749.7125.66.camel@tzanussi-mobl.amr.corp.intel.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
         <87pogur0y9.fsf@firstfloor.org>
         <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
         <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
         <CAMuHMdUTW7Fh+3kWKFCToqhaz-+58--=Sx1Zv0KRnVY4bDKOGQ@mail.gmail.com>
         <CAHp75VdCPHW-jZ7FCrEjqHQ6ULxH_U9EsBHTjb4a=Nhs_kYFGg@mail.gmail.com>
         <1491325150.7125.62.camel@tzanussi-mobl.amr.corp.intel.com>
         <CAHp75VcUorx5D2ive8eNWhtu2BzSbYAm+y9_KeFYdkTMgsg0SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcUorx5D2ive8eNWhtu2BzSbYAm+y9_KeFYdkTMgsg0SA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Stuart Longland <stuartl@longlandclan.id.au>, Nicolas Pitre <nicolas.pitre@linaro.org>, Andi Kleen <andi@firstfloor.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2017-04-04 at 20:08 +0300, Andy Shevchenko wrote:
> On Tue, Apr 4, 2017 at 7:59 PM, Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> > On Tue, 2017-04-04 at 00:05 +0300, Andy Shevchenko wrote:
> 
> > Yes, in a previous project, I had been working toward getting a < 1M
> > system to boot on Galileo hardware (which it did, but using more than
> > that - the Galileo2 has 256MB, but it was the target hardware at the
> > time, and I was hoping eventually to be able to boot out of the 512k
> > on-chip SRAM).
> >
> > I was focused at that point mainly on the kernel static size, and using
> > a combination of Josh Triplett's tinification tree, Andi Kleen's LTO and
> > net-diet patches, and my own miscellaneous patches that I was planning
> > on eventually upstreaming, I ended up with a system that I could boot to
> > shell with a 455k text size:
> >
> > Memory: 235636K/245176K available (455K kernel code, 61K rwdata,
> > 64K rodata, 132K init, 56K bss, 3056K reserved, 0K cma-reserved)
> >
> > virtual kernel memory layout:
> >     fixmap  : 0xfffe5000 - 0xfffff000   ( 104 kB)
> >     vmalloc : 0xd05f0000 - 0xfffe3000   ( 761 MB)
> >     lowmem  : 0xc0000000 - 0xcfdf0000   ( 253 MB)
> >       .init : 0xc1094000 - 0xc10b5000   ( 132 kB)
> >       .data : 0xc1071fac - 0xc1092760   ( 129 kB)
> >       .text : 0xc1000000 - 0xc1071fac   ( 455 kB)
> >
> > That was without networking.  Enabling networking added about 250k, and
> > at that point I could ssh in and run a webserver, still less than 1M as
> > far as kernel static size, which of course completely ignores the kernel
> > dynamic size and userspace.
> 
> Thanks for sharing your experience. The question closer to this
> discussion what did you do against TTY/UART/(related) layer(s)?
> 

I'd have to go back and take a look, but nothing special AFIAR.

No patches or hacks along those lines, and the only related thing I see
as far as config is:
	
	cfg/pty-disable.scc \

which maps to:

	# CONFIG_UNIX98_PTYS is not set
