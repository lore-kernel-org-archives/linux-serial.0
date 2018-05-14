From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/3] platform: move the early platform device support
 to arch/sh
Date: Mon, 14 May 2018 13:38:59 +0200
Message-ID: <20180514113859.GA6358@kroah.com>
References: <20180504132731.14574-1-brgl@bgdev.pl>
 <20180504132731.14574-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180504132731.14574-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.k
List-Id: linux-serial@vger.kernel.org

On Fri, May 04, 2018 at 03:27:30PM +0200, Bartosz Golaszewski wrote:
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
