From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 6/9] serial: tegra: move to generic dma DT binding
Date: Tue, 30 Jul 2013 10:46:42 -0600
Message-ID: <51F7EDF2.60700@wwwdotorg.org>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com> <1374639002-16753-7-git-send-email-rizhao@nvidia.com> <51F2D063.5010505@wwwdotorg.org> <20130730033134.GM15855@rizhao-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130730033134.GM15855@rizhao-lap>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <rizhao-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 07/29/2013 09:31 PM, Richard Zhao wrote:
> On Sat, Jul 27, 2013 at 03:39:15AM +0800, Stephen Warren wrote:
>> On 07/23/2013 10:09 PM, Richard Zhao wrote:
>>> - driver: remove use of nvidia,dma-request-selector
>>> 	  use dma_request_slave_channel to request channel
>>> - update binding doc
>>
>> This patch needs to be amended so that the DMA channel is looked up
>> during probe() rather than open(), to guarantee that deferred probe
>> works. It's possible to hold off probe, but not possible AFAIK to hold
>> off opening the port.
>
> How about avoid return -EPROBE_DEFER at open() time? It can be in
> another patch.

I don't really understand what you mean. -EPROBE_DEFER is something that
only makes sense for probe() to return (or functions used by probe()).
It doesn't make sense to return it anywhere else, since probe deferral
is something that can only happen for probe().
