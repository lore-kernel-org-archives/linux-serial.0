From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/3] sh: make early_platform code SuperH-specific
Date: Wed, 2 May 2018 23:05:28 +0200
Message-ID: <CAMuHMdVCrtLm7-sfbhG+o5Wvymgeu8cREtbesuuqFN0U1pc06g@mail.gmail.com>
References: <20180502094821.2907-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502094821.2907-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, open list
List-Id: linux-serial@vger.kernel.org

CC Magnus

On Wed, May 2, 2018 at 11:48 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> I recently started a discussion about the need for a proper early device
> probing mechanism[1]. One that would be based on real platform drivers
> and support both platform data and device tree.
>
> While we're far from reaching any consensus on the implementation, Arnd
> suggested that I start off by moving the SuperH-specific early platform
> drivers implementation to arch/sh[2].
>
> This series is the first attempt at making way for a new, less hacky
> implementation.
>
> The first patch removes the last instance of a non-sh driver using the
> early_platform API. It can be removed since ARM no longer probes early
> drivers.
>
> The second patch moves all the early_platform code to arch/sh.
>
> The last patch prefixes all early_platform symbols with 'sh_'.
>
> [1] https://lkml.org/lkml/2018/4/26/657
> [2] https://lkml.org/lkml/2018/4/27/239
>
> v1 -> v2:
> - certain drivers are compiled for arm/mach-shmobile too - we need to
>   add ifdefs for CONFIG_SUPERH around early_platform calls
>
> Bartosz Golaszewski (3):
>   clocksource: timer-ti-dm: remove the early platform driver
>     registration
>   platform: move the early platform device support to arch/sh
>   sh: add the sh_ prefix to early platform symbols
>
>  arch/sh/drivers/Makefile               |   2 +-
>  arch/sh/drivers/platform_early.c       | 346 +++++++++++++++++++++++++
>  arch/sh/include/asm/platform_early.h   |  61 +++++
>  arch/sh/kernel/cpu/sh2/setup-sh7619.c  |   4 +-
>  arch/sh/kernel/cpu/sh2a/setup-mxg.c    |   3 +-
>  arch/sh/kernel/cpu/sh2a/setup-sh7201.c |   3 +-
>  arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   3 +-
>  arch/sh/kernel/cpu/sh2a/setup-sh7206.c |   3 +-
>  arch/sh/kernel/cpu/sh2a/setup-sh7264.c |   3 +-
>  arch/sh/kernel/cpu/sh2a/setup-sh7269.c |   3 +-
>  arch/sh/kernel/cpu/sh3/setup-sh3.c     |   1 +
>  arch/sh/kernel/cpu/sh3/setup-sh7705.c  |   3 +-
>  arch/sh/kernel/cpu/sh3/setup-sh770x.c  |   3 +-
>  arch/sh/kernel/cpu/sh3/setup-sh7710.c  |   3 +-
>  arch/sh/kernel/cpu/sh3/setup-sh7720.c  |   3 +-
>  arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   3 +-
>  arch/sh/kernel/cpu/sh4/setup-sh7750.c  |   9 +-
>  arch/sh/kernel/cpu/sh4/setup-sh7760.c  |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7734.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7770.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   4 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   3 +-
>  arch/sh/kernel/cpu/sh5/setup-sh5.c     |   3 +-
>  arch/sh/kernel/setup.c                 |   3 +-
>  arch/sh/kernel/time.c                  |   5 +-
>  drivers/base/platform.c                | 288 --------------------
>  drivers/clocksource/sh_cmt.c           |  17 +-
>  drivers/clocksource/sh_mtu2.c          |  17 +-
>  drivers/clocksource/sh_tmu.c           |  18 +-
>  drivers/clocksource/timer-ti-dm.c      |   1 -
>  drivers/tty/serial/sh-sci.c            |  11 +-
>  include/linux/platform_device.h        |  52 ----
>  41 files changed, 526 insertions(+), 388 deletions(-)
>  create mode 100644 arch/sh/drivers/platform_early.c
>  create mode 100644 arch/sh/include/asm/platform_early.h
>
