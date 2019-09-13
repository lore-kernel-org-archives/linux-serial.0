From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] tty: 8250_of: Use software emulated RS485 direction
 control
Date: Fri, 13 Sep 2019 18:05:50 +0300
Message-ID: <20190913150550.GS2680@smile.fi.intel.com>
References: <20190913050105.1132080-1-hs@denx.de>
 <20190913102409.GF2680@smile.fi.intel.com>
 <51a21dde-a471-6e8e-8048-50437d740f7f@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51a21dde-a471-6e8e-8048-50437d740f7f@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: linux-serial@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, John Garry <john.garry@huawei.com>, Linus Walleij <linus.walleij@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 13, 2019 at 04:51:30PM +0200, Heiko Schocher wrote:
> Am 13.09.2019 um 12:24 schrieb Andy Shevchenko:
> > On Fri, Sep 13, 2019 at 07:01:05AM +0200, Heiko Schocher wrote:

> > > Patch is based on:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > commit:
> > > 505a8ec7e11a - Revert "drm/i915/userptr: Acquire the page lock around set_page_dirty()"
> > 
> > More reliably is to base on corresponding subsystem tree, i.e. tty-next for
> > this case.
> 
> Ok, should I send a rebased v2 (I tend to wait for other comments)?

I didn't give any comments WRT patch itself, so, I don't see any needs to send
v2 right now.

-- 
With Best Regards,
Andy Shevchenko
