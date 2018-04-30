From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH 0/3] sh: make early_platform code SuperH-specific
Date: Mon, 30 Apr 2018 12:42:50 -0400
Message-ID: <20180430164250.GN1392@brightrain.aerifal.cx>
References: <20180430163556.2560-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180430163556.2560-1-brgl@bgdev.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Lechner <david@lechnology.com>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Marc Zyngier <marc.zyngier@arm.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, linux-sh@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 30, 2018 at 06:35:53PM +0200, Bartosz Golaszewski wrote:
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
> Bartosz Golaszewski (3):
>   clocksource: timer-ti-dm: remove the early platform driver
>     registration
>   platform: move the early platform device support to arch/sh
>   sh: add the sh_ prefix to early platform symbols

I can't say I like it, because I really want to be just removing all
this code, but I don't necessarily object and it might be the most
appropriate short-term action to clean up this mess without breaking
things.

Rich
