From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Tue, 23 Feb 2016 15:29:31 +0530
Message-ID: <56CC2D83.3090900@ti.com>
References: <87lh7hrjsg.fsf@linutronix.de>
 <56A66FCB.1000507@hurleysoftware.com> <87y4b85onp.fsf@linutronix.de>
 <56B15603.80807@hurleysoftware.com> <87wpqbihel.fsf@linutronix.de>
 <20160211210050.GY19432@atomide.com> <874md0yd81.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <874md0yd81.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, gregkh@linuxfoundation.org, vinod.koul@intel.com, dan.j.williams@intel.com, bigeasy@linutronix.de, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Monday 22 February 2016 09:00 PM, John Ogness wrote:
> Hi Tony,
> 
> On 2016-02-11, Tony Lindgren <tony@atomide.com> wrote:
>>> At these speeds, nearly every DMA interrupt is accompanied by a
>>> spurious UART interrupt. So, sadly, the interrupts are doubled.
>>>
>>> It is on my TODO list to verify if the spurious UART interrupts
>>> exactly match the recently added [0] spurious interrupt detection in
>>> omap-intc.
>>
>> If you're seeing spurious interrupts you may want try adding
>> a flush of posted write at the end of the 8250_omap interrupt
>> handler. Basically read back some register from the 8250. This
>> has fixed so far pretty much all the spurious IRQ issues for
>> omaps using the drivers/irqchip/irq-omap-intc.c, meaning omap3
>> and am335x and ti81xx variants too most likely.
> 
> I have done significant testing with this using linux-next-20160219. The
> only changes I made were to disable the "rx_dma_broken" feature so that
> DMA would definately be used. I created a simple test where I send 48000
> bytes at 230400bps over UART from one device to another. Several
> different target devices and configurations were used to test the RX-DMA
> feature of the 8250_omap. The expected result is 1000 DMA interrupts and
> 0 UART interrupts.
> 
> With the am335x (Beaglebone Black, eDMA engine) I see 1000 DMA
> interrupts and 1000 spurious UART interrupts. The spurious UART
> interrupts arrive 30-50us _before_ the DMA interrupts. Always.
> 
> If I disable UART timeout interrupts (RDI), the same test generates no
> spurious UART interrupts. Only 1000 DMA interrupts.

To be clear, these interrupts are not caught as spurious by the
interrupt controller (INTC). They are detected by INTC as UART
interrupts. Just that you don't expect a timeout interrupt to happen at
the time you see the interrupt, correct?

Thanks,
Sekhar
