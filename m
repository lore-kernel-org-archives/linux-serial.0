From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] sh-sci: fix a race of DMA submit_tx on transfer
Date: Thu, 15 Mar 2012 11:50:28 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203151127030.2988@axis700.grange>
References: <4F5DC485.8020607@renesas.com> <Pine.LNX.4.64.1203121109360.3744@axis700.grange>
 <4F5F2AC1.8060305@renesas.com> <Pine.LNX.4.64.1203131227470.14461@axis700.grange>
 <4F604563.90000@renesas.com> <20120315060938.GB10046@linux-sh.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120315060938.GB10046@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Takashi Yoshii <takashi.yoshii.zj@renesas.com>, SH-Linux <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Paul

On Thu, 15 Mar 2012, Paul Mundt wrote:

> On Wed, Mar 14, 2012 at 04:14:43PM +0900, Takashi Yoshii wrote:
> >     serial: sh-sci: fix a race of DMA submit_tx on transfer
> >     
> >     When DMA is enabled, sh-sci transfer begins with
> >      uart_start()
> >       sci_start_tx()
> >         if (cookie_tx < 0) schedule_work()
> >     Then, starts DMA when wq scheduled, -- (A)
> >      process_one_work()
> >       work_fn_rx()
> >        cookie_tx = desc->submit_tx()
> >     And finishes when DMA transfer ends, -- (B)
> >      sci_dma_tx_complete()
> >       async_tx_ack()
> >       cookie_tx = -EINVAL
> >       (possible another schedule_work())
> >     
> >     This A to B sequence is not reentrant, since controlling variables
> >     (for example, cookie_tx above) are not queues nor lists. So, they
> >     must be invoked as A B A B..., otherwise results in kernel crash.
> >     
> >     To ensure the sequence, sci_start_tx() seems to test if cookie_tx < 0
> >     (represents "not used") to call schedule_work().
> >     But cookie_tx will not be set (to a cookie, also means "used") until
> >     in the middle of work queue scheduled function work_fn_tx().
> >     
> >     This gap between the test and set allows the breakage of the sequence
> >     under the very frequently call of uart_start().
> >     Another gap between async_tx_ack() and another schedule_work() results
> >     in the same issue, too.
> >     
> >     This patch introduces a new condition "cookie_tx == 0" just to mark
> >     it is "busy" and assign it within spin-locked region to fill the gaps.
> >     
> >     Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> >     Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Looks good to me. I'll apply it unless Guennadi has any other concerns.

No, I don't - my ack holds:) However, I do have some concerns regarding a 
couple of other possible issues with SCI DMA:

1. As I mentioned earlier, I think, sci_start_tx() should always be called 
under the port spinlock to get consistent ->cookie_tx and ->chan_tx 
values. This is the case, when called from serial core as 
->start_tx() from most locations, but not from uart_handle_cts_change(), 
which is an exported function. It is also called internally in the SCI 
driver itself several times - with no locking. This might need fixing, 
especially in sci_tx_dma_release().

2. The DMA Tx work might need to be cancelled from time to time... E.g., 
when DMA is disabled to switch to PIO, or when shutting down the port.

Both of these might require a bit more thinking and testing.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
