From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: /proc/stat btime accuracy problem
Date: Mon, 6 Jun 2011 23:20:46 -0600
Message-ID: <BANLkTimGfwqvhOKXCGqJUvMU7jozqQT8=g@mail.gmail.com>
References: <BANLkTiniq6GVMJPO_-efKrWHQg9V9Dod9g@mail.gmail.com>
 <1306967733.11492.11.camel@work-vm> <BANLkTi=yEMDLEo99WZm2Bt4pi_pog5igww@mail.gmail.com>
 <1306972711.11492.23.camel@work-vm> <BANLkTimuPrqN1euyOqAGm2m4Ea1PdbrzDQ@mail.gmail.com>
 <1306975745.11492.30.camel@work-vm> <BANLkTikR4HNnFsYm2ymm1+FTbeeXtvH51g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTikR4HNnFsYm2ymm1+FTbeeXtvH51g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

I'm still spinning my wheels on this, so I guess the only thing left
is to ask even more stupid questions :)

I'm only concerned about the early boot sequence, and I think only
about the period when we're using the jiffies clocksource.  My
understanding is:

  - I'm using the jiffies clocksource during early boot.
  - Jiffies depends on a periodic (1000 HZ in my case) interrupt that
updates xtime via the tick_periodic -> do_timer -> update_wall_time
path.
  - If those periodic interrupts are lost, those xtime updates are forever lost.
  - An interrupt would be lost if interrupts are disabled for an
interval that covers two or more ticks (my guess ... I'm thinking that
if interrupts were re-enabled before the second tick, the first one
would be delayed but not lost).
  - The RTC runs independently of CPU interrupts being disabled, so
its time is not lost.
  - User-space will typically reset xtime to match the RTC

And my sequence of events is:

  - xtime = RTC reading #1
  - wall_to_monotonic = -xtime
  - periodic tick increments xtime
  -  some ticks are lost while interrupts are disabled
  - by the time we switch from jiffies to hpet and eventually tsc
clock source, the RTC is ahead of xtime by several seconds (1-2 in a
normal boot, 30+ in more extreme cases)
  - user-space resets xtime to RTC ("hwclock -hctosys" in my case),
which adds the delta to xtime and subtracts it from wall_to_monotonic
  - getboottime() returns -wall_to_monotonic (should be RTC reading
#1, but now "reading #1 + delta")

It seems like we're throwing away information here at the time we
switch from jiffies to a more capable clocksource -- at that point, we
know the RTC - xtime delta, and we know that delta represents time
when interrupts were disabled.  (Obviously this only applies during
early boot, before we do any RTC updates.)

My naive thought was "well, what if we just use the RTC directly as a
clocksource."  It's crappy resolution, but at least it doesn't lose
time, so I tried the following, which didn't work at all (hangs during
boot).  But I don't know enough to know *why* this isn't feasible.
Seems like jiffies can be different sizes, so why not 1 Hz?

+static cycle_t rtc_read(struct clocksource *cs)
+{
+       static struct timespec base;
+       struct timespec now;
+       static int first = 1;
+
+       read_persistent_clock(&now);
+       if (first) {
+               first = 0;
+               base = now;
+       }
+
+       return (cycle_t) (now.tv_sec - base.tv_sec);
+}
+
+struct clocksource clocksource_rtc = {
+       .name           = "rtc",
+       .rating         = 1,
+       .read           = rtc_read,
+       .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+       .mask           = CLOCKSOURCE_MASK(64),
+       .mult           = NSEC_PER_SEC,
+};
+
+struct clocksource * __init clocksource_default_clock(void)
+{
+       return &clocksource_rtc;
+}

Bjorn
