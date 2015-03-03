From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] serial/8250_dw: use platform_get_irq() instead of
 platform_get_resource()
Date: Tue, 03 Mar 2015 17:59:34 +0200
Message-ID: <1425398374.14897.155.camel@linux.intel.com>
References: <1425395474-6762-1-git-send-email-abrodkin@synopsys.com>
	 <1425396362.14897.143.camel@linux.intel.com>
	 <1425396820.17965.16.camel@synopsys.com>
	 <1425397427.14897.149.camel@linux.intel.com>
	 <1425397657.17965.28.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425397657.17965.28.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alan@linux.intel.com" <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2015-03-03 at 15:47 +0000, Alexey Brodkin wrote:
> > > For example it was useful for me when debugging stacked interrupt
> > > controllers setup - I got explicitly notified why this particular device
> > > failed on probe.
> > 
> > There are so many device drivers which prints similar message that you
> > would consider to make a separate patch to platform.c code to do that
> > stuff there once for all.

> Then we may want to do another massive clean-up because there're lots of
> other drivers that have this message in some form :)

Yeah, you may do that and it will be (by my opinion) more useful than
introducing one more place with the duplicate message.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
