From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] serial/8250_dw: use platform_get_irq() instead of
 platform_get_resource()
Date: Tue, 03 Mar 2015 17:43:47 +0200
Message-ID: <1425397427.14897.149.camel@linux.intel.com>
References: <1425395474-6762-1-git-send-email-abrodkin@synopsys.com>
	 <1425396362.14897.143.camel@linux.intel.com>
	 <1425396820.17965.16.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425396820.17965.16.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alan@linux.intel.com" <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2015-03-03 at 15:33 +0000, Alexey Brodkin wrote:
> Hi Andy,
> 
> On Tue, 2015-03-03 at 17:26 +0200, Andy Shevchenko wrote:
> > On Tue, 2015-03-03 at 18:11 +0300, Alexey Brodkin wrote:
> > > It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
> > > for requesting IRQ's resources any more, as they can be not ready yet in
> > > case of DT-booting.
> > > 
> > > platform_get_irq() instead is a recommended way for getting IRQ even if
> > > it was not retrieved earlier.
> > > 
> > > It also makes code simpler because we're getting "int" value right away
> > > and no conversion from resource to int is required.
> > > 
> > >  Changes in v2:
> > >   * Suppress error message if platform_get_irq() returns -EPROBE_DEFER
> > 
> > Do we really need that message at all?
> 
> IMHO it makes sense.
> 
> For example it was useful for me when debugging stacked interrupt
> controllers setup - I got explicitly notified why this particular device
> failed on probe.

There are so many device drivers which prints similar message that you
would consider to make a separate patch to platform.c code to do that
stuff there once for all.

> Note that IRQ is a pretty specific resource due to the fact of INTC
> stacking and situations when each and every INTC gets finally probed.
> 
> Still if you believe we may drop this message with no loss of usability
> - I'm fine with that as well.

If no one else has an objection I would prefer to skip it. You always
may get the return code from probe(), though it's not exactly mapped to
the reason why it failed.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
