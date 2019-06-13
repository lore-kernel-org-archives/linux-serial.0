From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2 v5] tty/serial/8250: use mctrl_gpio helpers
Date: Thu, 13 Jun 2019 14:05:29 +0300
Message-ID: <20190613110529.GR9224@smile.fi.intel.com>
References: <20190611105603.4435-1-sr@denx.de>
 <20190611105603.4435-2-sr@denx.de>
 <20190611124415.GT9224@smile.fi.intel.com>
 <85f0d39c-e5d8-320b-e611-d956630a629f@denx.de>
 <20190611144828.GX9224@smile.fi.intel.com>
 <12e5180e-b4a0-e5fa-bcad-ddc8103d644c@denx.de>
 <20190612091621.GA9224@smile.fi.intel.com>
 <6a4f1001-b023-c972-7b36-6d2f8f9a3fa8@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a4f1001-b023-c972-7b36-6d2f8f9a3fa8@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Yegor Yefremov <yegorslists@googlemail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 13, 2019 at 07:32:39AM +0200, Stefan Roese wrote:
> On 12.06.19 11:16, Andy Shevchenko wrote:
> > On Wed, Jun 12, 2019 at 10:13:05AM +0200, Stefan Roese wrote:
> > > On 11.06.19 16:48, Andy Shevchenko wrote:

> > > Do you something like this in mind?
> > 
> > More likely
> > 
> > static inline int serial8250_MCR_to_TIOCM(int mcr)
> 
> MSR_to_TIOCM (see below) ...

Yes. true.

> > {
> > 	int tiocm = 0;
> > 
> > 	if (mcr & ...)
> > 		tiocm |= ...;
> > 	...
> > 
> > 	return tiocm;
> > }
> > 
> > static inline int serial8250_TIOCM_to_MCR(int tiocm)
> > {
> > 	... in a similar way ...
> > }
> 
> While implementing such wrapper functions I noticed, that get_mctrl() /
> set_mctrl() need TIOCM->MCR and MSR->TIOCM (notice MSR vs MCR here) but
> serial8250_in_MCR() needs MCR->TIOCM. So there is not that much
> overlay here.

It seems not only this driver is using such conversion. It's even possible to
move it to serial level for all.

> Additionally the wrappers would need to handle all bits
> and only some of them are needed in serial8250_in/out_MCR(),
> so I would
> need to add masking here as well.

I don't see this. You will get a value for exclusive bits only. No additional
mask would be needed.

> For my taste its not really worth adding these wrappers as they won't
> make things much clearer (if at all).

Hmm.. For me it would be quite clear if something with proposed name would be
called in the code.

-- 
With Best Regards,
Andy Shevchenko
