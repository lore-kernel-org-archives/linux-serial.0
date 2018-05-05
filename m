From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 3/3] sh: add the sh_ prefix to early platform symbols
Date: Fri, 4 May 2018 20:04:52 -0400
Message-ID: <CAK8P3a3-2jyajsN+p0X_VEVG3B3GJ5fL0T90FV5_Sraz+Lzp4Q@mail.gmail.com>
References: <20180504132731.14574-1-brgl@bgdev.pl> <20180504132731.14574-4-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504132731.14574-4-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>Linux
List-Id: linux-serial@vger.kernel.org

On Fri, May 4, 2018 at 9:27 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Old early platform device support is now sh-specific. Before moving on
> to implementing new early platform framework based on real platform
> devices, prefix all early platform symbols with 'sh_'.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Looks good. I was thinking of something shorter as the new namespace,
but actually using a longer name like you do seems appropriate since
we don't want anyone to actually use it. ;-)

        Arnd
