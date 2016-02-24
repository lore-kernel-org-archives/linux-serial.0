From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Tue, 23 Feb 2016 19:20:36 -0800
Message-ID: <56CD2184.40304@hurleysoftware.com>
References: <87lh7hrjsg.fsf@linutronix.de>
 <56A66FCB.1000507@hurleysoftware.com> <87y4b85onp.fsf@linutronix.de>
 <56B15603.80807@hurleysoftware.com> <87wpqbihel.fsf@linutronix.de>
 <20160211210050.GY19432@atomide.com> <874md0yd81.fsf@linutronix.de>
 <56CC2D83.3090900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56CC2D83.3090900@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: gregkh@linuxfoundation.org, vinod.koul@intel.com, dan.j.williams@intel.com, bigeasy@linutronix.de, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 02/23/2016 01:59 AM, Sekhar Nori wrote:
> On Monday 22 February 2016 09:00 PM, John Ogness wrote:
>> Hi Tony,
>>
>> On 2016-02-11, Tony Lindgren <tony@atomide.com> wrote:
>>>> At these speeds, nearly every DMA interrupt is accompanied by a
>>>> spurious UART interrupt. So, sadly, the interrupts are doubled.
>>>>
>>>> It is on my TODO list to verify if the spurious UART interrupts
>>>> exactly match the recently added [0] spurious interrupt detection in
>>>> omap-intc.
>>>
>>> If you're seeing spurious interrupts you may want try adding
>>> a flush of posted write at the end of the 8250_omap interrupt
>>> handler. Basically read back some register from the 8250. This
>>> has fixed so far pretty much all the spurious IRQ issues for
>>> omaps using the drivers/irqchip/irq-omap-intc.c, meaning omap3
>>> and am335x and ti81xx variants too most likely.
>>
>> I have done significant testing with this using linux-next-20160219. The
>> only changes I made were to disable the "rx_dma_broken" feature so that
>> DMA would definately be used. I created a simple test where I send 48000
>> bytes at 230400bps over UART from one device to another. Several
>> different target devices and configurations were used to test the RX-DMA
>> feature of the 8250_omap. The expected result is 1000 DMA interrupts and
>> 0 UART interrupts.
>>
>> With the am335x (Beaglebone Black, eDMA engine) I see 1000 DMA
>> interrupts and 1000 spurious UART interrupts. The spurious UART
>> interrupts arrive 30-50us _before_ the DMA interrupts. Always.
>>
>> If I disable UART timeout interrupts (RDI), the same test generates no
>> spurious UART interrupts. Only 1000 DMA interrupts.
> 
> To be clear, these interrupts are not caught as spurious by the
> interrupt controller (INTC). They are detected by INTC as UART
> interrupts. Just that you don't expect a timeout interrupt to happen at
> the time you see the interrupt, correct?

Just to follow-up on what Sebastian wrote.

As he pointed out, these spurious interrupts are not timeout interrupts.
Since IIR_UART[0] == 1, no uart interrupt is pending.

As he wrote, these count as spurious interrupts and trigger
interrupt shutdown at 100000 (unless acked as uart interrupts).

These spurious interrupts very nearly correspond 1:1 (but not quite)
with each dma submission. So, for example, one test run had:

    @3Mbaud line rate
    195826 submits
    195823 completions

    195704 spurious interrupts (ie., interrupts with IIR_UART[0] == 1)
         0 RLSI interrupts (no line errors) (IIR_UART == 0xc6)
         2 RX timeout interrupts (IIR_UART == 0xcc),
           one during i/o test and one at the end of i/o test
         6 RDI interrupts (IIR_UART == 0xc4)

The spurious interrupts occur with nearly 1:1 correspondence at _all_
line rates.

Presumbably, the 6 RDI interrupts are from too-slow submission of
the next DMA and the uart rx fifo has reached rx trigger level already.
[NOTE: we should at least be using ping-pong dma buffers for rx so that
there is always a next DMA buffer when the current buffer is completed].

There is no documentation in any of the OMAP TRMs regarding RDI
interrupts while in DMA mode. Some guidance from TI would be appreciated.


Regards,
Peter Hurley
