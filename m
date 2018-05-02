From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/3] platform: move the early platform device support
 to arch/sh
Date: Wed, 2 May 2018 23:01:36 +0200
Message-ID: <CAMuHMdUAaJbZH2nFpBOCYz_xqBfdjRP=PZW8qtk6Zp1mKd61VA@mail.gmail.com>
References: <20180502094821.2907-1-brgl@bgdev.pl> <20180502094821.2907-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502094821.2907-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, open list
List-Id: linux-serial@vger.kernel.org

Hi Bartosz,

On Wed, May 2, 2018 at 11:48 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
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

Thanks for your patch!

> --- a/drivers/clocksource/sh_cmt.c
> +++ b/drivers/clocksource/sh_cmt.c

> @@ -1043,10 +1047,12 @@ static int sh_cmt_probe(struct platform_device *pdev)
>         struct sh_cmt_device *cmt = platform_get_drvdata(pdev);
>         int ret;
>
> +#ifdef CONFIG_SUPERH
>         if (!is_early_platform_device(pdev)) {
>                 pm_runtime_set_active(&pdev->dev);
>                 pm_runtime_enable(&pdev->dev);
>         }
> +#endif

I think the above is not correct: on ARM/ARM64, is_early_platform_device()
used to return false, so the pm_runtime_*() functions must be called.

Perhaps you should keep a dummy is_early_platform_device(), always
returning false on !SUPERH? That would reduce the number of #ifdefs you
have to add, too.

> --- a/drivers/clocksource/sh_mtu2.c
> +++ b/drivers/clocksource/sh_mtu2.c
> @@ -450,10 +454,12 @@ static int sh_mtu2_probe(struct platform_device *pdev)
>         struct sh_mtu2_device *mtu = platform_get_drvdata(pdev);
>         int ret;
>
> +#ifdef CONFIG_SUPERH
>         if (!is_early_platform_device(pdev)) {
>                 pm_runtime_set_active(&pdev->dev);
>                 pm_runtime_enable(&pdev->dev);
>         }
> +#endif

Likewise.

> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -606,10 +610,12 @@ static int sh_tmu_probe(struct platform_device *pdev)
>         struct sh_tmu_device *tmu = platform_get_drvdata(pdev);
>         int ret;
>
> +#ifdef CONFIG_SUPERH
>         if (!is_early_platform_device(pdev)) {
>                 pm_runtime_set_active(&pdev->dev);
>                 pm_runtime_enable(&pdev->dev);
>         }
> +#endif

Likewise.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
