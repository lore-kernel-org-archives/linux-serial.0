From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/3] platform: move the early platform device support
 to arch/sh
Date: Tue, 8 May 2018 08:45:01 +0200
Message-ID: <CAMuHMdXbTkOHAGFBAz16zV1NKmejzy1SpO7LuqZUmsasVf0-jg@mail.gmail.com>
References: <20180504132731.14574-1-brgl@bgdev.pl> <20180504132731.14574-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504132731.14574-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>Linux Kernel Mailing List <linu>
List-Id: linux-serial@vger.kernel.org

Hi Bartosz,

On Fri, May 4, 2018 at 3:27 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> SuperH is the only user of the current implementation of early platform
> device support. We want to introduce a more robust approach to early
> probing. As the first step - move all the current early platform code
> to arch/sh.
>
> In order not to export internal drivers/base functions to arch code for
> this temporary solution - copy the two needed routines for driver
> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
>
> Also: call early_platform_cleanup() from subsys_initcall() so that it's
> called after all early devices are probed.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

>  drivers/clocksource/sh_cmt.c           |   7 +
>  drivers/clocksource/sh_mtu2.c          |   7 +
>  drivers/clocksource/sh_tmu.c           |   8 +
>  drivers/tty/serial/sh-sci.c            |   7 +-
>  include/linux/platform_device.h        |  64 +----

The parts used on contemporary ARM/ARM64 Renesas SoCs look fine to me, so
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
