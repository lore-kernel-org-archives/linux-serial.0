From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Tue, 23 Feb 2016 13:43:53 +0100
Message-ID: <56CC5409.2050609@linutronix.de>
References: <87lh7hrjsg.fsf@linutronix.de>
 <56A66FCB.1000507@hurleysoftware.com> <87y4b85onp.fsf@linutronix.de>
 <56B15603.80807@hurleysoftware.com> <87wpqbihel.fsf@linutronix.de>
 <20160211210050.GY19432@atomide.com> <874md0yd81.fsf@linutronix.de>
 <56CC2D83.3090900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56CC2D83.3090900@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, gregkh@linuxfoundation.org, vinod.koul@intel.com, dan.j.williams@intel.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 02/23/2016 10:59 AM, Sekhar Nori wrote:
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

>From what I remember the INTC says it is UART, correct.
But UART's status register says "no interrupt" (IIR has UART_IIR_NO_INT
set). So the UART driver returns IRQ_NONE which counts as spurious.

It is just that once you disable RDI there are no more interrupts coming
during DMA transfer.

> Thanks,
> Sekhar
> 
Sebastian
