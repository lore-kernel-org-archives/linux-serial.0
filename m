From: Richard Zhao <rizhao-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/9] serial: tegra: move to generic dma DT binding
Date: Thu, 1 Aug 2013 11:30:33 +0800
Message-ID: <20130801033033.GB31469@rizhao-lap>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-7-git-send-email-rizhao@nvidia.com>
 <51F2D063.5010505@wwwdotorg.org>
 <20130730033134.GM15855@rizhao-lap>
 <51F7EDF2.60700@wwwdotorg.org>
 <20130731034541.GQ15855@rizhao-lap>
 <51F98275.6020906@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51F98275.6020906-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Content-Disposition: inline
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 01, 2013 at 05:32:37AM +0800, Stephen Warren wrote:
> On 07/30/2013 09:45 PM, Richard Zhao wrote:
> > On Wed, Jul 31, 2013 at 12:46:42AM +0800, Stephen Warren wrote:
> >> On 07/29/2013 09:31 PM, Richard Zhao wrote:
> >>> On Sat, Jul 27, 2013 at 03:39:15AM +0800, Stephen Warren wrote:
> >>>> On 07/23/2013 10:09 PM, Richard Zhao wrote:
> >>>>> - driver: remove use of nvidia,dma-request-selector
> >>>>> 	  use dma_request_slave_channel to request channel
> >>>>> - update binding doc
> >>>>
> >>>> This patch needs to be amended so that the DMA channel is looked up
> >>>> during probe() rather than open(), to guarantee that deferred probe
> >>>> works. It's possible to hold off probe, but not possible AFAIK to hold
> >>>> off opening the port.
> >>>
> >>> How about avoid return -EPROBE_DEFER at open() time? It can be in
> >>> another patch.
> >>
> >> I don't really understand what you mean. -EPROBE_DEFER is something that
> >> only makes sense for probe() to return (or functions used by probe()).
> >> It doesn't make sense to return it anywhere else, since probe deferral
> >> is something that can only happen for probe().
> >
> > What I meant is, it might not worth to move request channel to probe
> > only because we need to check error and return -EPROBE_DEFER.
> 
> If probe() doesn't attempt to validate that the/a DMA channel provider
> exists, then there's no guarantee that the DMA provider has probed
> before the DMA client driver either probes or executes any later code.

I'm not against defer probe, but dma_request_slave_channel might not be
the right function. Ideally dma channels are allocated at open() time
and dma controller loaded checking is at probe() time. So there's
better some function called check_dma_controller_loaded(), or we could
also use initcalls to let dma driver probe earlier.

This patch intend to be simple to only change the binding.

> So, you could quite easily end up with a situation where the serial
> driver's open fails because the DMA provider has not yet probed. This is
> exactly what deferred probe was intended to avoid. This reason alone is
> enough to make it worth fixing this.
> 
> > dma_request_slave_channel is better to be called as late as possible to
> > make better dynamic use of dma channels.
> 
> probe() could validate that the provider exists in a way that doesn't
> permanently hold ownership of the DMA channel. For example, request it
> then immediately release it, in the absence of a dedicated "validate my
> DMA providers exist" API.

It's ugly but may work. The current driver didn't check dma controller
loaded at probe time. Let's leave the task to another patch?

> 
> > Actually, I searched the kernel code, most drivers don't return EPROBE_DEFER
> > when dma_request_slave_channel failed. dma_request_slave_channel can
> > fail in many cases, and dma device not probed is only one case.
> 
> That sounds like a bug. If a DMA channel /is/ specified, it should be
> possible to acquire it. If no DMA channel is specified, and if the
> device can do PIO, then it's reasonable to continue.
Idealy when dma_request_slave_channel failed at open time, it can also
move to PIO.

Thanks
Richard
