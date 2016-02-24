From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Wed, 24 Feb 2016 21:07:14 +0530
Message-ID: <56CDCE2A.30809@ti.com>
References: <87lh7hrjsg.fsf@linutronix.de>
 <56A66FCB.1000507@hurleysoftware.com> <87y4b85onp.fsf@linutronix.de>
 <56B15603.80807@hurleysoftware.com> <87wpqbihel.fsf@linutronix.de>
 <20160211210050.GY19432@atomide.com> <874md0yd81.fsf@linutronix.de>
 <56CC2D83.3090900@ti.com> <56CD2184.40304@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56CD2184.40304@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: gregkh@linuxfoundation.org, vinod.koul@intel.com, dan.j.williams@intel.com, bigeasy@linutronix.de, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wednesday 24 February 2016 08:50 AM, Peter Hurley wrote:
> Just to follow-up on what Sebastian wrote.
> 
> As he pointed out, these spurious interrupts are not timeout interrupts.
> Since IIR_UART[0] == 1, no uart interrupt is pending.
> 
> As he wrote, these count as spurious interrupts and trigger
> interrupt shutdown at 100000 (unless acked as uart interrupts).

Okay, by adding a printk to where the check for UART_IIR_NO_INT is in
omap_8250_dma_handle_irq(), I do see that UART irq handler is called
when there is apparently no interrupt.

I don't see the error interrupt count in /proc/interrupts go up although
the code is returning IRQ_NONE when this happens. I initially thought
that must be because of the interrupt being IRQF_SHARED. But getting rid
of IRQF_SHARED still does not lead to error count going up. I need to
spend some more time to see what is going on.

> These spurious interrupts very nearly correspond 1:1 (but not quite)
> with each dma submission. So, for example, one test run had:
> 
>     @3Mbaud line rate
>     195826 submits
>     195823 completions
> 
>     195704 spurious interrupts (ie., interrupts with IIR_UART[0] == 1)
>          0 RLSI interrupts (no line errors) (IIR_UART == 0xc6)
>          2 RX timeout interrupts (IIR_UART == 0xcc),
>            one during i/o test and one at the end of i/o test
>          6 RDI interrupts (IIR_UART == 0xc4)
> 
> The spurious interrupts occur with nearly 1:1 correspondence at _all_
> line rates.
> 
> Presumbably, the 6 RDI interrupts are from too-slow submission of
> the next DMA and the uart rx fifo has reached rx trigger level already.
> [NOTE: we should at least be using ping-pong dma buffers for rx so that
> there is always a next DMA buffer when the current buffer is completed].
> 
> There is no documentation in any of the OMAP TRMs regarding RDI
> interrupts while in DMA mode. Some guidance from TI would be appreciated.

UART interrupts triggering while UART_IIR_NO_INT is set is weird enough.
I will check around internally with hardware folks here. Getting an
answer might take time. But this is easily reproducible so I am
optimistic we will get an answer soon.

Regards,
Sekhar
