From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/2] drivers: make early_platform code SuperH-specific
Date: Fri, 4 Oct 2019 15:00:31 +0200
Message-ID: <20191004130031.GA596158@kroah.com>
References: <20191003092913.10731-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191003092913.10731-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Oct 03, 2019 at 11:29:11AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Some time ago I started a discussion about the need for a proper early device
> probing mechanism[1]. One that would be based on real platform drivers and
> support both platform data and device tree.
> 
> While we're far from reaching any consensus on the implementation, Arnd
> suggested that I start off by moving the SuperH-specific early platform
> drivers implementation to arch/sh[2].
> 
> This series is the first attempt at making way for a new, less hacky
> implementation.
> 
> The first patch moves all the early_platform code to arch/sh.
> 
> The second patch prefixes all early_platform symbols with 'sh_'.
> 
> [1] https://lkml.org/lkml/2018/4/26/657
> [2] https://lkml.org/lkml/2018/4/27/239
> 
> v1 -> v2:
> - certain drivers are compiled for arm/mach-shmobile too - we need to
>   add ifdefs for CONFIG_SUPERH around early_platform calls
> 
> v2 -> v3:
> - added a stub for is_early_platform_device() which always returns false
>   on non-SuperH architectures
> 
> v3 -> v4:
> - rebased on top of v5.4-rc1
> - removed patches that are already upstream from the series
> 
> Bartosz Golaszewski (2):
>   drivers: move the early platform device support to arch/sh
>   sh: add the sh_ prefix to early platform symbols

I like this, any objection from anyone if I take this in my driver-core
tree for 5.5-rc1?

thanks,

greg k-h
