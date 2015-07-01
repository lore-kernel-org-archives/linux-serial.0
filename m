From: Paul Osmialowski <pawelo@king.net.pl>
Subject: Re: [PATCH v2 4/9] arm: twr-k70f120m: timer driver for Kinetis SoC
Date: Wed, 1 Jul 2015 16:20:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507011619250.13307@localhost.localdomain>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl> <1435667250-28299-5-git-send-email-pawelo@king.net.pl> <alpine.DEB.2.11.1507010944580.3916@nanos> <alpine.LNX.2.00.1507011031050.9009@localhost.localdomain>
 <alpine.DEB.2.11.1507011527380.3916@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1507011527380.3916@nanos>
Sender: linux-gpio-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Osmialowski <pawelo@king.net.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Paul Bolle <pebolle@tiscali.nl>Uwe Kleine-Koenig <u>
List-Id: linux-serial@vger.kernel.org



On Wed, 1 Jul 2015, Thomas Gleixner wrote:

>>
>> As I removed this kinetis_pit_enable() line, the timer did not start,
>> therefore the system became unusable. What could be possible reason for that?
>
> Well, you need to move both, the init and the enable into
> set_periodic().
>

Indeed, something like this worked:

diff --git a/drivers/clocksource/timer-kinetis.c 
b/drivers/clocksource/timer-kinetis.c
index 1424308..41ef94f 100644
--- a/drivers/clocksource/timer-kinetis.c
+++ b/drivers/clocksource/timer-kinetis.c
@@ -61,6 +61,7 @@ struct kinetis_clock_event_ddata {
         struct clock_event_device evtdev;
         void __iomem *base;
         void __iomem *mcr;
+       unsigned long rate;
         spinlock_t lock;
  };

@@ -115,6 +116,7 @@ static int kinetis_clockevent_tmr_set_state_periodic(
         struct kinetis_clock_event_ddata *pit =
                 container_of(evt, struct kinetis_clock_event_ddata, 
evtdev);

+       kinetis_pit_init(pit, (pit->rate / HZ) - 1);
         kinetis_pit_enable(pit, 1);

         return 0;
@@ -235,6 +237,7 @@ static void __init kinetis_clockevent_init(struct 
device_node *np)
                                 kinetis_clockevent_tmr_set_state_oneshot;
                 kinetis_tmr->base = base;
                 kinetis_tmr->mcr = mcr;
+               kinetis_tmr->rate = rate;
                 spin_lock_init(&kinetis_tmr->lock);

                 /*
@@ -250,9 +253,6 @@ static void __init kinetis_clockevent_init(struct 
device_node *np)

                 clockevents_register_device(&kinetis_tmr->evtdev);

-               kinetis_pit_init(kinetis_tmr, (rate / HZ) - 1);
-               kinetis_pit_enable(kinetis_tmr, 1);
-
                 if (request_irq(irq, kinetis_clockevent_tmr_irq_handler,
                                         IRQF_TIMER | IRQF_IRQPOLL,
                                         "kinetis-timer",

