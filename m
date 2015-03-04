From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/6] ARM: at91: fix irq_pm_install_action WARNING
Date: Wed, 04 Mar 2015 02:43:08 +0100
Message-ID: <1459461.VrAQVInSTR@vostro.rjw.lan>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com> <54F5D4CC.3090805@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F5D4CC.3090805@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tuesday, March 03, 2015 04:35:40 PM Nicolas Ferre wrote:
> Le 02/03/2015 10:18, Boris Brezillon a =C3=A9crit :
> > My apologies to those of you who already received this series, but =
I
> > didn't increment the patch version and forgot some subsystem mainta=
iners
> > and MLs.
> >=20
> > Commit cab303be91dc47942bc25de33dc1140123540800 [1] introduced a WA=
RN_ON
> > test which triggers a WARNING backtrace on at91 platforms.
> > While this WARN_ON is absolutely necessary to warn users that they =
should
> > not mix request with and without IRQF_NO_SUSPEND flags on shared IR=
Qs,
> > there is no easy way to solve this issue on at91 platforms.
> >=20
> > The main reason is that the init timer is often using a shared irq =
line
> > and thus request this irq with IRQF_NO_SUSPEND flag set, while othe=
r
> > peripherals request the same irq line without this flag.
> >=20
> > This problem has recently been addressed by this patch [2] which ad=
ds
> > a new IRQF_COND_SUSPEND flag, that authorize mixing IRQF_NO_SUSPEND=
 and
> > !IRQF_NO_SUSPEND as long as irq handlers setting IRQF_COND_SUSPEND
> > can safely be called in suspended state.
> >=20
> > Doing this also implies taking care of system wakeup in devices han=
dlers
> > if they tag the IRQ line as a wakeup source.
> > The first patch of this series exports the pm_system_wakeup symbol =
so
> > that drivers can call pm_system_wakeup from their interrupt handler=
=2E
> >=20
> > This series then patches all at91 drivers that can have devices sha=
ring
> > their IRQ line with a timer.
> >=20
> > This series depends on [2].
>=20
> I'm okay with all the patches:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>=20
> As it seems easier to keep the whole series together, I'll let Rafael
> take it.

OK, I'll queue up the patches for the next PM pull request.

Thanks!
