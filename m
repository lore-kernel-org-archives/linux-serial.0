From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4] serial: 8250_dw: fix wrong logic in dw8250_check_lcr()
Date: Thu, 28 Apr 2016 17:44:27 -0700
Message-ID: <20160429004427.GC31752@kroah.com>
References: <1459827166-13861-1-git-send-email-wangkefeng.wang@huawei.com>
 <1459835585-25751-1-git-send-email-wangkefeng.wang@huawei.com>
 <1459853407.12843.7.camel@linux.intel.com>
 <57061B5E.7040707@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57061B5E.7040707@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Noam Camus <noamc@ezchip.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, xuwei5@hisilicon.com
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 07, 2016 at 04:33:34PM +0800, Kefeng Wang wrote:
> 
> 
> On 2016/4/5 18:50, Andy Shevchenko wrote:
> > On Tue, 2016-04-05 at 13:53 +0800, Kefeng Wang wrote:
> >> Commit cdcea058e510 ("serial: 8250_dw: Avoid serial_outx code
> >> duplicate
> >> with new dw8250_check_lcr()") introduce a wrong logic when write val
> >> to
> >> LCR reg. When CONFIG_64BIT enabled, __raw_writeq is used
> >> unconditionally.
> >>
> >> The __raw_readq/__raw_writeq is introduced by commit bca2092d7897
> >> ("serial:
> >> 8250_dw: Use 64-bit access for OCTEON.") for OCTEON, so for
> >> !PORT_OCTEON,
> >> we better to use coincident write func.
> >>
> >> Fixes: cdcea058e510("serial: 8250_dw: Avoid serial_outx code
> >> duplicate with new dw8250_check_lcr()")
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >> ---
> >>
> >> Changes since v3:
> >> - Add patch change log, suggested by Greg Kroah-Hartman.
> >> Changes since v2:
> >> - Add #ifdef CONFIG_64BIT back, ensure it can be built under 
> > 
> > Oh, true. Since it's a native IO we can't use writeq() helper from io-
> > 64-nonatomic-*. 
> > 
> >> configuration lacking readq/writeq.
> >> Changes since v1:
> >> - Repace '#ifdef CONFIG_64BIT' with IS_ENABLED(CONFIG_64BIT).
> >> - Enrich patch log, and add Fixes tag.
> [...]
> > 
> > So, this changes logic to write the value on any 64 platform, using
> > different (non-64-bit) accessors, so, the case to fix is
> > actually "64BIT && !PORT_OCTEON". Perhaps commit message should be
> > amended to point that clearly.
> 
> Yes, it's more clear. thanks for review and point it out.
> 
> To Greg, should I resend it or can you help me to change the patch log when you merge it. Thanks.

Please resend it in the form you want it to be.

thanks,

greg k-h
