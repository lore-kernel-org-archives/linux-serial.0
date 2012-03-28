From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] sh-sci: fix a race of DMA submit_tx on transfer
Date: Wed, 28 Mar 2012 15:11:38 +0900
Message-ID: <20120328061138.GT26543@linux-sh.org>
References: <4F5DC485.8020607@renesas.com> <Pine.LNX.4.64.1203121109360.3744@axis700.grange> <4F5F2AC1.8060305@renesas.com> <Pine.LNX.4.64.1203131227470.14461@axis700.grange> <4F604563.90000@renesas.com> <20120315060938.GB10046@linux-sh.org> <Pine.LNX.4.64.1203151127030.2988@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:49256 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab2C1GLp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Mar 2012 02:11:45 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1203151127030.2988@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Takashi Yoshii <takashi.yoshii.zj@renesas.com>, SH-Linux <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org

On Thu, Mar 15, 2012 at 11:50:28AM +0100, Guennadi Liakhovetski wrote:
> On Thu, 15 Mar 2012, Paul Mundt wrote:
> > Looks good to me. I'll apply it unless Guennadi has any other concerns.
> 
> No, I don't - my ack holds:) However, I do have some concerns regarding a 
> couple of other possible issues with SCI DMA:
> 
Ok, I've queued it up now (it was too late for -final, so we'll have to
rely on the stable backport later).

> 1. As I mentioned earlier, I think, sci_start_tx() should always be called 
> under the port spinlock to get consistent ->cookie_tx and ->chan_tx 
> values. This is the case, when called from serial core as 
> ->start_tx() from most locations, but not from uart_handle_cts_change(), 
> which is an exported function. It is also called internally in the SCI 
> driver itself several times - with no locking. This might need fixing, 
> especially in sci_tx_dma_release().
> 
The bulk of the uart_handle_cts_change() callers do so with the lock
held, the only exception seems to be a few drivers that call it directly
from their interrupt handlers.

At first glance, the sci_tx/rx_dma_release() cases will probably need a
bit of reordering given that dma_release_channel() is taking a list
mutex, but I don't see too many issues otherwise. Having said that,
the whole DMA enable/disable path could probably be split up a bit with
individual toggle logic pushed down in to ->start/stop_tx as well as
->stop_rx for some finer-grained control. This would at least help make
the locking a bit more obvious.

> 2. The DMA Tx work might need to be cancelled from time to time... E.g., 
> when DMA is disabled to switch to PIO, or when shutting down the port.
> 
Yes, this is something that needs to be done. I've tried to use the
driver as a module before in the past, and it does blow up rather
spectacularly in the remove case, this is hardly limited to the DMA
case though (and is also not a configuration most people are going to
ever really use, which is why we've largely ignored it thus far). The
PIO<->DMA transition on the other hand we're far more likely to hit,
especially if we end up exposing something like a userspace knob for
enabling/disabling arbitrarily for testing.

Most of the DMA cancelling looks it should be pretty easy to do via
->flush_buffer, unless I'm missing something. The amba-pl011.c driver
does just this for the dmaengine case.
