From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] tty: 8250_of: Use software emulated RS485 direction
 control
Date: Fri, 13 Sep 2019 13:24:09 +0300
Message-ID: <20190913102409.GF2680@smile.fi.intel.com>
References: <20190913050105.1132080-1-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190913050105.1132080-1-hs@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: linux-serial@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, John Garry <john.garry@huawei.com>, Linus Walleij <linus.walleij@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 13, 2019 at 07:01:05AM +0200, Heiko Schocher wrote:
> Use software emulated RS485 direction control to provide RS485 API
> 
> Currently it is not possible to use rs485 as pointer to
> rs485_config struct in struct uart_port is NULL in case we
> configure the port through device tree.

Thank you for the patch, few recommendations for the future submissions.

> Patch is based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> commit:
> 505a8ec7e11a - Revert "drm/i915/userptr: Acquire the page lock around set_page_dirty()"

More reliably is to base on corresponding subsystem tree, i.e. tty-next for
this case.

> checkpatch output:
> $ ./scripts/checkpatch.pl 0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch
> total: 0 errors, 0 warnings, 43 lines checked
> 
> 0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch has no obvious style problems and is ready for submission.

There is no need to mention this. It's supposed that submitter did that
themselves.

When you gather people to send the patch to, I recommend to use some threshold,
e.g. `scripts/get_maintainer.pl --git --git-min-percent=67 ...`

-- 
With Best Regards,
Andy Shevchenko
