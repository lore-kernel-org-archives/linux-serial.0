From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Tue, 04 Apr 2017 14:58:44 -0500
Message-ID: <1491335924.7125.87.camel@tzanussi-mobl.amr.corp.intel.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
         <87pogur0y9.fsf@firstfloor.org>
         <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
         <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
         <CAMuHMdUTW7Fh+3kWKFCToqhaz-+58--=Sx1Zv0KRnVY4bDKOGQ@mail.gmail.com>
         <CAHp75VdCPHW-jZ7FCrEjqHQ6ULxH_U9EsBHTjb4a=Nhs_kYFGg@mail.gmail.com>
         <1491325150.7125.62.camel@tzanussi-mobl.amr.corp.intel.com>
         <CAHp75VcUorx5D2ive8eNWhtu2BzSbYAm+y9_KeFYdkTMgsg0SA@mail.gmail.com>
         <1491328749.7125.66.camel@tzanussi-mobl.amr.corp.intel.com>
         <CAHp75VfQVdMRZnbDFyH9m=HfSuoiUxqhf2y+H07u4u6xPd7DUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfQVdMRZnbDFyH9m=HfSuoiUxqhf2y+H07u4u6xPd7DUA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Stuart Longland <stuartl@longlandclan.id.au>, Nicolas Pitre <nicolas.pitre@linaro.org>, Andi Kleen <andi@firstfloor.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2017-04-04 at 21:04 +0300, Andy Shevchenko wrote:
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
> 
> I believe you did some research during time of that project…
> 

Yes, as a matter of fact I did, and just found some notes I took at the
time.  I didn't dive into the code in detail - that level of analysis
was supposed to come later but I did have these notes mentioning that I
thought it would show the largest savings for a single item (outside of
networking) 'if we could do it':

"- Largest is still drivers

- drivers/tty and serial is the biggest obvious win if we can do it
  - break down into granular config options
    - leave simplest possible tty/serial functionality
    - allow tailoring to specific hardware
  - also helps in effort to get rid of char devices
  - 65740/815190"

Basically 65k out of an 800k text size could be partially or mostly
saved by addressing that one item, which looks like it pretty much
matches Nicolas' numbers...

So no doubt it would be worthwhile to address one way or the other.
Whether to do that by refactoring the tty layer or partial refactoring
and creation of a parallel minimal version would best be left up to
someone who actually understands it I would think...

BTW, since I'm quoting my own notes on the subject, I thought I'd just
include the whole thing, which covers a bunch of other areas possibly
ripe for tinification, in case anyone might be interested (some of it
should be taken with a grain of salt though ;-)

Tom

--------

galileo SMALLEST_SIZE

$ size vmlinux
   text	          data			       bss	    dec	    hex	filename
 699668		   186432		       2271592	    3157692  302ebc	vmlinux

Not using this, because
 $ size xxx.o shows all 0s with LTO

----

Using this:

galileo SMALLEST_SIZE with LTO off

$ size vmlinux
   text	          data			       bss	    dec	    hex	filename
 815190		   165696		       2272760	    3253646  31a58e	vmlinux

This corresponds to LTO size:

$ size vmlinux
   text	          data			       bss	    dec	    hex	filename
 677183		   179528		       1207280	    2063991  1f7e77	vmlinux

$ ls -al arch/x86/boot/bzImage 
-rw-r--r--. 1 427264 Mar 12 22:34 arch/x86/boot/bzImage

And booted size:

Memory: 235388K/245240K available (534K kernel code, 100K rwdata, 52K rodata, 14
8K init, 64K bss, 3172K reserved, 0K cma-reserved)
virtual kernel memory layout:
    fixmap  : 0xfffa4000 - 0xfffff000   ( 364 kB)
    vmalloc : 0xd05f0000 - 0xfffa2000   ( 761 MB)
    lowmem  : 0xc0000000 - 0xcfdf0000   ( 253 MB)
      .init : 0xc10af000 - 0xc10d4000   ( 148 kB)
      .data : 0xc1085b9c - 0xc10ad120   ( 157 kB)
      .text : 0xc1000000 - 0xc1085b9c   ( 534 kB)

------
Totals - details below
------

- make ptrace configurable - this should help the hw breakpoints and x86 perf disable patches upstream
  - 5k
- remove things not needed for CONFIG_SMP
  - 5k
- support configuring out kswapd
  - about 5k in vmscan
- support configuring out vmstat
  - 0
- kernel capabilities
  - 1k
- exec domains
  - 1k
- tsc
     3030	    284	     40	   3354	    d1a	./arch/x86/kernel/tsc.o
    332		          0        0	        332	    14c	./arch/x86/kernel/tsc_msr.o
- support configuring out signals
  11852	       36           4	  11892	   2e74	./kernel/signal.o
   3188	             1	          0	      3189	    c75	./arch/x86/kernel/signal.o
  - about 15k
- kernel/pid.o simplification - more for dynamic memory - simpler pidhash
  1868	    160	      4	   2032	    7f0	./kernel/pid.o
  - about 2k
- remove kernel/exit.o
  - assume processes never exit
- remove lib/kfifo
  - about 2k
- remove kernel/irq/spurious
  - about 1k
- make sys configurable
  - about 7k
- remove xattr
  - about 4k
- /drivers total possible savings, some percentage of:
  - 136000/815190
- /kernel savings
  - say 30000/815190 savings
- /fs savings
  - 30000/815190 savings
- /arch/x86 savings
  - 20000/815190
- /mm
  - 5000/815190
- /lib
  - 10000/815190

Totals without mmu:
  146k + (2/3)*136k = 235k

  235k/815190 = 30% savings

- x86 nommu
  - about 50k

Totals with mmu:

  285k/815190 = 35% savings


Applied to the 534k boot figure, we end up with text size of:

  374k mmu
  347k nommu

We could probably go lower with more fine-grained analysis, but we may
also need to add drivers, etc.

-----
NONET details
-----

- Largest is still drivers

- drivers/tty and serial is the biggest obvious win if we can do it
  - break down into granular config options
    - leave simplest possible tty/serial functionality
    - allow tailoring to specific hardware
  - also helps in effort to get rid of char devices
  - 65740/815190 

- pci is next largest
  - assume we can break down into granular config options
    - leave simplest possible pci functionality
    - allow tailoring to specific hardware e.g. no discovery
  - 47144/815190

- drivers/base
  - simplify driver core for a small set of drivers
    - simple_char: New infrastructure to simplify chardev management
  - 25389/815190

- total possible savings, some percentage of:
  - 136000/815190

 206992	  29331	   6556	 242879	  3b4bf	./drivers/built-in.o

 65740	  16888	   3132	  85760	  14f00	./drivers/tty/built-in.o
 32077	  16680	   2688	  51445	   c8f5	./drivers/tty/serial/built-in.o
 21628	  15892	   2644	  40164	   9ce4	./drivers/tty/serial/8250/built-in.o
  47144	   1172	   2100	  50416	   c4f0	./drivers/pci/built-in.o
  25389	   1324	    112	  26825	   68c9	./drivers/base/built-in.o
  15733	    636	     20	  16389	   4005	./drivers/spi/built-in.o
  11504	    136	     28	  11668	   2d94	./drivers/clk/built-in.o
   9605	    460	     72	  10137	   2799	./drivers/thermal/built-in.o
   5066	    624	    912	   6602	   19ca	./drivers/char/built-in.o
   8531	    480	     36	   9047	   2357	./drivers/i2c/built-in.o

- 2nd largest is kernel

  - should be able to cut *something* from time and sched
    - we have a handful of processes at most
    - we have very simple time needs
  - say 30000/815190 savings

 150742	   6376	   8209	 165327	  285cf	./kernel/built-in.o

  40951	   1105	   4720	  46776	   b6b8	./kernel/time/built-in.o
  21760	   1318	    112	  23190	   5a96	./kernel/sched/built-in.o
   9800	    388	   1328	  11516	   2cfc	./kernel/irq/built-in.o
   4956	      4	      4	   4964	   1364	./kernel/locking/built-in.o
   1847	     88	    184	   2119	    847	./kernel/printk/built-in.o
   1757	     33	      0	   1790	    6fe	./kernel/rcu/built-in.o
   1408	    356	     44	   1808	    710	./kernel/power/built-in.o

- next is fs

  - completely turn off proc
    - requires userspace changes to cope with it
    - 22046/815190, 100% of this

  - simplify/featurize some core vfs?
    - e.g. namei, small set of file names, no need for complexity

  - disable vfs completely?
    - init reads executables directly from storage
    - all state in memory, no need to save anything

 133526	   1506	   1552	 136584	  21588	./fs/built-in.o
  22046	    140	     40	  22226	   56d2	./fs/proc/built-in.o

- next is arch/x86, mostly in arch/x86/kernel
  - not much to save here, maybe 10 here and there
  - maybe 3k in boot: video*
  - maybe 5k in cpu: amd, transmeta, cachinfo, etc
  - cut about 10k in arch/x86/mm for nommu

 120755	  50209	  52712	 223676	  369bc	./arch/x86/built-in.o

 100201	  29261	  19828	 149290	  2472a	./arch/x86/kernel/built-in.o

  21713	   8693	    720	  31126	   7996	./arch/x86/kernel/cpu/built-in.o
  17480	   5486	   6324	  29290	   726a	./arch/x86/kernel/apic/built-in.o
  10385	   4365	    532	  15282	   3bb2	./arch/x86/kernel/cpu/mcheck/built-in.o

  18237	    208	  30776	  49221	   c045	./arch/x86/mm/built-in.o
  14276	    412	    256	  14944	   3a60	./arch/x86/pci/built-in.o
   1345	      8	     28	   1381	    565	./arch/x86/platform/intel-quark/built-in.o
   1345	      8	     28	   1381	    565	./arch/x86/platform/built-in.o
    590	   8228	     16	   8834	   2282	./arch/x86/vdso/built-in.o
    379	  12500	      8	  12887	   3257	./arch/x86/realmode/built-in.o
    477	      0	      0	    477	    1dd	./arch/x86/lib/built-in.o

- next is mm
 
  - cut about 5k for percpu
  - cut about 40k for nommu

 119008	  13688	   1824	 134520	  20d78	./mm/built-in.o

   1358	      0        0	     1358	    54e	./mm/gup.o
  10612	     32	      24       10668	       29ac	./mm/memory.o
   1072	      0        0     1072	           430	./mm/mincore.o
   2453	      0        0		      2453	    995	./mm/mlock.o
   9918	    176        8	        10102	       2776	./mm/mmap.o
   1403	      0	      0		   1403	           57b	./mm/mprotect.o
   2155	      0          0	      2155	       86b	./mm/mremap.o
    520	      0          0       520	           208	./mm/msync.o
   4358	      0	        8    4366	      110e	./mm/rmap.o
   6355	      57	     28		         6440	   1928	./mm/vmalloc.o
    710	      0          0		     710       2c6	./mm/pagewalk.o
     92	      0	         0	          92        5c	./mm/pgtable-generic.o

- next is lib

  - no need for vsprintf if printk off, 10k

  30654	  24647	      5	  55306	   d80a	./lib/built-in.o

   9964	      0	      0	   9964	   26ec	./lib/zlib_inflate/built-in.o

-next is init

   8456	  16437	     81	  24974	   618e	./init/built-in.o



----
Net sizes, maybe later...

galileo SMALLEST_SIZE_NET with LTO off

- this is without ipv4 net-diet
- includes ipv6

$ size vmlinux
   text	          data			       bss	    dec	    hex	filename
1368973		   181184		       2288560	    3838717  3a92fd	vmlinux

---
NET details
---


- net now largest, larger than drivers (and drivers goes up too)

 465384	  13818	  17364	 496566	  793b6	./net/built-in.o

 183144	   5409	   7948	 196501	  2ff95	./net/ipv4/built-in.o
 128583	   4648	   6432	 139663	  2218f	./net/ipv6/built-in.o
 108158	   2092	   2804	 113054	  1b99e	./net/core/built-in.o
  15268	    264	      0	  15532	   3cac	./net/packet/built-in.o
  14787	    465	    148	  15400	   3c28	./net/netlink/built-in.o
   4011	    676	      0	   4687	   124f	./net/sched/built-in.o
    967	     12	      0	    979	    3d3	./net/ethernet/built-in.o

- drivers second largest

 255026	  30512	   6604	 292142	  4752e	./drivers/built-in.o

    359	     20	      0	    379	    17b	./drivers/reset/built-in.o
   2155	    152	     32	   2339	    923	./drivers/pps/built-in.o
   8870	    580	      0	   9450	   24ea	./drivers/net/phy/built-in.o
  42421	    861	      8	  43290	   a91a	./drivers/net/built-in.o
  30650	    233	      8	  30891	   78ab	./drivers/net/ethernet/stmicro/stmmac/built-in.o
  30650	    233	      8	  30891	   78ab	./drivers/net/ethernet/stmicro/built-in.o
  30650	    233	      8	  30891	   78ab	./drivers/net/ethernet/built-in.o
  47144	   1172	   2100	  50416	   c4f0	./drivers/pci/built-in.o
  11504	    136	     28	  11668	   2d94	./drivers/clk/built-in.o
  25389	   1324	    112	  26825	   68c9	./drivers/base/built-in.o
  15733	    636	     20	  16389	   4005	./drivers/spi/built-in.o
   5066	    624	    912	   6602	   19ca	./drivers/char/built-in.o
   9931	    548	     76	  10555	   293b	./drivers/thermal/built-in.o
   4927	    224	     36	   5187	   1443	./drivers/ptp/built-in.o
  65740	  16888	   3132	  85760	  14f00	./drivers/tty/built-in.o
  32077	  16680	   2688	  51445	   c8f5	./drivers/tty/serial/built-in.o
  21628	  15892	   2644	  40164	   9ce4	./drivers/tty/serial/8250/built-in.o
   8531	    480	     36	   9047	   2357	./drivers/i2c/built-in.o

- kernel next

 157407	   6376	   8209	 171992	  29fd8	./kernel/built-in.o

   9800	    388	   1328	  11516	   2cfc	./kernel/irq/built-in.o
  40951	   1105	   4720	  46776	   b6b8	./kernel/time/built-in.o
   6665	      0	      0	   6665	   1a09	./kernel/bpf/built-in.o
   1408	    356	     44	   1808	    710	./kernel/power/built-in.o
  21760	   1318	    112	  23190	   5a96	./kernel/sched/built-in.o
   4956	      4	      4	   4964	   1364	./kernel/locking/built-in.o
   1757	     33	      0	   1790	    6fe	./kernel/rcu/built-in.o
   1847	     88	    184	   2119	    847	./kernel/printk/built-in.o

- fs next

 134562	   1534	   1552	 137648	  219b0	./fs/built-in.o

   1395	    276	      4	   1675	    68b	./fs/ramfs/built-in.o
  22743	    168	     40	  22951	   59a7	./fs/proc/built-in.o
   1446	     44	      8	   1498	    5da	./fs/devpts/built-in.o

- arch/x86 next

 120755	  50209	  52712	 223676	  369bc	./arch/x86/built-in.o

    379	  12500	      8	  12887	   3257	./arch/x86/realmode/built-in.o
  14276	    412	    256	  14944	   3a60	./arch/x86/pci/built-in.o
    590	   8228	     16	   8834	   2282	./arch/x86/vdso/built-in.o
  18237	    208	  30776	  49221	   c045	./arch/x86/mm/built-in.o
    477	      0	      0	    477	    1dd	./arch/x86/lib/built-in.o
   1345	      8	     28	   1381	    565	./arch/x86/platform/intel-quark/built-in.o
   1345	      8	     28	   1381	    565	./arch/x86/platform/built-in.o
  17480	   5486	   6324	  29290	   726a	./arch/x86/kernel/apic/built-in.o
  21713	   8693	    720	  31126	   7996	./arch/x86/kernel/cpu/built-in.o
  10385	   4365	    532	  15282	   3bb2	./arch/x86/kernel/cpu/mcheck/built-in.o
 100201	  29261	  19828	 149290	  2472a	./arch/x86/kernel/built-in.o

- mm next

 119008	  13688	   1824	 134520	  20d78	./mm/built-in.o

- lib next

  33042	  24647	      5	  57694	   e15e	./lib/built-in.o

   9964	      0	      0	   9964	   26ec	./lib/zlib_inflate/built-in.o

- crypto next

  30068	    284	      0	  30352	   7690	./crypto/built-in.o

- init next

   8456	  16437	     81	  24974	   618e	./init/built-in.o
