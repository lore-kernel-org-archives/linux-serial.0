From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: /proc/stat btime accuracy problem
Date: Thu, 2 Jun 2011 00:34:58 -0600
Message-ID: <BANLkTikR4HNnFsYm2ymm1+FTbeeXtvH51g@mail.gmail.com>
References: <BANLkTiniq6GVMJPO_-efKrWHQg9V9Dod9g@mail.gmail.com>
 <1306967733.11492.11.camel@work-vm> <BANLkTi=yEMDLEo99WZm2Bt4pi_pog5igww@mail.gmail.com>
 <1306972711.11492.23.camel@work-vm> <BANLkTimuPrqN1euyOqAGm2m4Ea1PdbrzDQ@mail.gmail.com>
 <1306975745.11492.30.camel@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1306975745.11492.30.camel@work-vm>
Sender: linux-kernel-owner@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 1, 2011 at 6:49 PM, john stultz <johnstul@us.ibm.com> wrote=
:
> On Wed, 2011-06-01 at 18:31 -0600, Bjorn Helgaas wrote:
>> On Wed, Jun 1, 2011 at 5:58 PM, john stultz <johnstul@us.ibm.com> wr=
ote:
>> > My first instinct is "don't do that!" to whatever driver is disabl=
ing
>> > irqs for so long. Do you know what's actually causing these long i=
rq off
>> > periods?
>> >
>> > I assume you're noticing this offset by seeing that CLOCK_REALTIME=
 is
>> > off from the RTC right after boot? How severe is this? The RTC rea=
d is
>> > only second granular, so there's a fair amount of error (~1 second=
)
>> > possible right at boot, so this then must be many seconds worth of=
 lost
>> > ticks to be noticeable, right?
>>
>> I'm using 2.6.34, so not really new. =A0I think the major offender i=
s
>> kernel serial printk, which is done in polled mode. =A0A *lot* of it=
,
>> e.g., 30+ seconds' worth.
>
> CC'ing the linux-serial list and Alan for their thoughts: Does the
> serial port is disabling irqs for 30+ seconds during boot seem at all
> sane?
>
> I would think it would periodically enable irqs in the polling loop t=
o
> let things be processed, but maybe not?
>
>> =A0 I wonder if there's some reasonably clean
>> way to resync with the RTC, say at the time we register a clocksourc=
e
>> better than jiffies, or in clocksource_done_booting(), or something.
>
> I definitely think we need to address the long irq disable periods
> instead of trying to hack around the issue in the timekeeping code.

OK, I have a theory.  Here are snippets from my dmesg log (this is
from a current upstream kernel).  The "BH" lines are instrumentation I
added to read the RTC at a few places:

  Linux version 3.0.0-smp-DEV ...
  BH now   rtc 1306992452 (start_kernel, before setup_arch)
      Printk 230K of numa=3Dfake debug stuff (more than seems strictly
      necessary to me, but there it is).  All this data goes into the l=
og
      buffer, not to the UART, because the console hasn't been
      initialized yet.
  Command line: auto BOOT_IMAGE=3D300smpD ro root=3D/dev/hda1,/dev/sda1
ignore_loglevel console=3DttyS0,115200n8 swiotlb=3D16000 numa=3Dfake=3D=
16M

  BH now   rtc 1306992457 (start_kernel, after mm init)

  BH btime rtc 1306992457 xt 1306992457 wtm -1306992457 (timekeeping_in=
it)
      Snapshot btime and init xtime and wall_to_monotonic.  So
      theoretically, we should see 1306992457 in /proc/stat btime.

  Console: colour dummy device 80x25
  console [ttyS0] enabled
      Now ttyS0 is enabled, so we dump the log buffer to the UART.  I t=
hink
      this happens in console_unlock(), with interrupts disabled for th=
e whole
      buffer.

  BH now   rtc 1306992481 xt 1306992459 wtm -1306992457
  clocksource_register jiffies
      This RTC read is in clocksource_register(); note that xtime is no=
w
      22 seconds behind the RTC.  The UART is running at 115200 baud,
      and 230K/(115200/10) =3D about 20 seconds, so this sort of matche=
s
      the time I expect it to take to dump the buffer.

  HPET: 3 timers in total, 0 timers will be used for per-cpu timer
  hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
  hpet0: 3 comparators, 64-bit 14.318180 MHz counter
  Switching to clocksource hpet

  Refined TSC clocksource calibration: 2400.084 MHz.
  Switching to clocksource tsc

  BH <set  rtc 1306992488 xt 1306992465 wtm -1306992457 to 1306992488
  BH settimeofday delta 23
  BH set>  rtc 1306992488 xt 1306992488 wtm -1306992480
      This settimeofday() call happens when userland runs "hwclock --hc=
tosys".
      We adjust xtime and wall_to_monotonic by 23 seconds.

=46inally, we read /proc/stat.  Since we only re-synced the system cloc=
k
to the RTC (we didn't sync to an external source), btime ought to be
the same as it was when we collected it, i.e., 1306992457.  But
instead, we get this, which I assume is the same wall_to_monotonic we
computed in settimeofday(), but rounded:

  btime 1306992479

Things that look interesting to me:
  - numa=3Dfake prints an excessive amount of debug info!
  - We register the ttyS0 console before registering the jiffies clocks=
ource.
    It seems like the jiffies clocksource ought to be registered about =
the
    same time we initialize xtime in timekeeping_init().
  - Interrupts are disabled the entire time we dump the log buffer, whi=
ch
    could be a very long time.  Maybe we could restore/disable interrup=
ts
    periodically there.

Bjorn
