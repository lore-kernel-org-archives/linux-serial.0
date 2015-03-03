From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/6] ARM: at91: fix irq_pm_install_action WARNING
Date: Tue, 3 Mar 2015 16:35:40 +0100
Message-ID: <54F5D4CC.3090805@atmel.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425287898-15093-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Le 02/03/2015 10:18, Boris Brezillon a =E9crit :
> My apologies to those of you who already received this series, but I
> didn't increment the patch version and forgot some subsystem maintain=
ers
> and MLs.
>=20
> Commit cab303be91dc47942bc25de33dc1140123540800 [1] introduced a WARN=
_ON
> test which triggers a WARNING backtrace on at91 platforms.
> While this WARN_ON is absolutely necessary to warn users that they sh=
ould
> not mix request with and without IRQF_NO_SUSPEND flags on shared IRQs=
,
> there is no easy way to solve this issue on at91 platforms.
>=20
> The main reason is that the init timer is often using a shared irq li=
ne
> and thus request this irq with IRQF_NO_SUSPEND flag set, while other
> peripherals request the same irq line without this flag.
>=20
> This problem has recently been addressed by this patch [2] which adds
> a new IRQF_COND_SUSPEND flag, that authorize mixing IRQF_NO_SUSPEND a=
nd
> !IRQF_NO_SUSPEND as long as irq handlers setting IRQF_COND_SUSPEND
> can safely be called in suspended state.
>=20
> Doing this also implies taking care of system wakeup in devices handl=
ers
> if they tag the IRQ line as a wakeup source.
> The first patch of this series exports the pm_system_wakeup symbol so
> that drivers can call pm_system_wakeup from their interrupt handler.
>=20
> This series then patches all at91 drivers that can have devices shari=
ng
> their IRQ line with a timer.
>=20
> This series depends on [2].

I'm okay with all the patches:
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

As it seems easier to keep the whole series together, I'll let Rafael
take it.

Thanks a lot for having taking care of this.

Best regards,


> [1]https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/co=
mmit/kernel/irq/pm.c?id=3Dcab303be91dc47942bc25de33dc1140123540800
> [2]https://lkml.org/lkml/2015/2/26/675
>=20
> Changes since v1:
>  - replaced the IRQF_SUSPEND_NOACTION flag by IRQF_COND_SUSPEND
>  - properly addressed wakeup handling in drivers
>=20
> Boris Brezillon (6):
>   PM / wakeup: export pm_system_wakeup symbol
>   rtc: at91sam9: rework wakeup and interrupt handling
>   rtc: at91rm9200: rework wakeup and interrupt handling
>   clk: at91: implement suspend/resume for the PMC irqchip
>   watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
>   tty: serial: atmel: rework interrupt and wakeup handling
>=20
>  drivers/base/power/wakeup.c       |  1 +
>  drivers/clk/at91/pmc.c            | 20 ++++++++++-
>  drivers/clk/at91/pmc.h            |  1 +
>  drivers/rtc/rtc-at91rm9200.c      | 62 +++++++++++++++++++++++++----=
----
>  drivers/rtc/rtc-at91sam9.c        | 73 +++++++++++++++++++++++++++++=
+++-------
>  drivers/tty/serial/atmel_serial.c | 49 +++++++++++++++++++++++---
>  drivers/watchdog/at91sam9_wdt.c   |  3 +-
>  7 files changed, 177 insertions(+), 32 deletions(-)
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
