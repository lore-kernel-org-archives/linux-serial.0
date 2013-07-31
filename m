From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 6/9] serial: tegra: move to generic dma DT binding
Date: Wed, 31 Jul 2013 15:32:37 -0600
Message-ID: <51F98275.6020906@wwwdotorg.org>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com> <1374639002-16753-7-git-send-email-rizhao@nvidia.com> <51F2D063.5010505@wwwdotorg.org> <20130730033134.GM15855@rizhao-lap> <51F7EDF2.60700@wwwdotorg.org> <20130731034541.GQ15855@rizhao-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34333 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab3GaVck (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Jul 2013 17:32:40 -0400
In-Reply-To: <20130731034541.GQ15855@rizhao-lap>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Zhao <rizhao@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>

On 07/30/2013 09:45 PM, Richard Zhao wrote:
> On Wed, Jul 31, 2013 at 12:46:42AM +0800, Stephen Warren wrote:
>> On 07/29/2013 09:31 PM, Richard Zhao wrote:
>>> On Sat, Jul 27, 2013 at 03:39:15AM +0800, Stephen Warren wrote:
>>>> On 07/23/2013 10:09 PM, Richard Zhao wrote:
>>>>> - driver: remove use of nvidia,dma-request-selector
>>>>> 	  use dma_request_slave_channel to request channel
>>>>> - update binding doc
>>>>
>>>> This patch needs to be amended so that the DMA channel is looked up
>>>> during probe() rather than open(), to guarantee that deferred probe
>>>> works. It's possible to hold off probe, but not possible AFAIK to hold
>>>> off opening the port.
>>>
>>> How about avoid return -EPROBE_DEFER at open() time? It can be in
>>> another patch.
>>
>> I don't really understand what you mean. -EPROBE_DEFER is something that
>> only makes sense for probe() to return (or functions used by probe()).
>> It doesn't make sense to return it anywhere else, since probe deferral
>> is something that can only happen for probe().
>
> What I meant is, it might not worth to move request channel to probe
> only because we need to check error and return -EPROBE_DEFER.

If probe() doesn't attempt to validate that the/a DMA channel provider
exists, then there's no guarantee that the DMA provider has probed
before the DMA client driver either probes or executes any later code.
So, you could quite easily end up with a situation where the serial
driver's open fails because the DMA provider has not yet probed. This is
exactly what deferred probe was intended to avoid. This reason alone is
enough to make it worth fixing this.

> dma_request_slave_channel is better to be called as late as possible to
> make better dynamic use of dma channels.

probe() could validate that the provider exists in a way that doesn't
permanently hold ownership of the DMA channel. For example, request it
then immediately release it, in the absence of a dedicated "validate my
DMA providers exist" API.

> Actually, I searched the kernel code, most drivers don't return EPROBE_DEFER
> when dma_request_slave_channel failed. dma_request_slave_channel can
> fail in many cases, and dma device not probed is only one case.

That sounds like a bug. If a DMA channel /is/ specified, it should be
possible to acquire it. If no DMA channel is specified, and if the
device can do PIO, then it's reasonable to continue.
