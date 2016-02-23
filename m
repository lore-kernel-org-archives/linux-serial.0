From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Tue, 23 Feb 2016 18:56:23 +0200
Message-ID: <CAHp75VeZiySV1ZzVNORYWUJ1_fiaSk9_sHNBR0w_ACNdwaHcwA@mail.gmail.com>
References: <87lh7hrjsg.fsf@linutronix.de>
	<56A66FCB.1000507@hurleysoftware.com>
	<87y4b85onp.fsf@linutronix.de>
	<56B15603.80807@hurleysoftware.com>
	<87wpqbihel.fsf@linutronix.de>
	<20160211210050.GY19432@atomide.com>
	<874md0yd81.fsf@linutronix.de>
	<56CC2D83.3090900@ti.com>
	<56CC5409.2050609@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56CC5409.2050609@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sekhar Nori <nsekhar@ti.com>, John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine <dmaengine@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 23, 2016 at 2:43 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 02/23/2016 10:59 AM, Sekhar Nori wrote:
>>> With the am335x (Beaglebone Black, eDMA engine) I see 1000 DMA
>>> interrupts and 1000 spurious UART interrupts. The spurious UART
>>> interrupts arrive 30-50us _before_ the DMA interrupts. Always.
>>>
>>> If I disable UART timeout interrupts (RDI), the same test generates no
>>> spurious UART interrupts. Only 1000 DMA interrupts.
>>
>> To be clear, these interrupts are not caught as spurious by the
>> interrupt controller (INTC). They are detected by INTC as UART
>> interrupts. Just that you don't expect a timeout interrupt to happen at
>> the time you see the interrupt, correct?
>
> From what I remember the INTC says it is UART, correct.
> But UART's status register says "no interrupt" (IIR has UART_IIR_NO_INT
> set). So the UART driver returns IRQ_NONE which counts as spurious.
>
> It is just that once you disable RDI there are no more interrupts coming
> during DMA transfer.

Hmm... How I missed this discussion?

I'm trying to resolve few issues I found on 8250_dw using higher baud
rates and DMA on internal loopback.
One of the issue I got is the set of spurious interrupts which lead to
"too much work for irq" message.

Reading deeply Intel's documentation on some UART I found the following:

"Receive Data Available Interrupt
...
It is recommended to disable this interrupt when running with DMA mode."

The problem is that we have no separate bit to control timeout
interrupts from UART.

-- 
With Best Regards,
Andy Shevchenko
