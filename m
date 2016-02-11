From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Thu, 11 Feb 2016 13:00:50 -0800
Message-ID: <20160211210050.GY19432@atomide.com>
References: <87lh7hrjsg.fsf@linutronix.de>
 <56A66FCB.1000507@hurleysoftware.com>
 <87y4b85onp.fsf@linutronix.de>
 <56B15603.80807@hurleysoftware.com>
 <87wpqbihel.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87wpqbihel.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, gregkh@linuxfoundation.org, vinod.koul@intel.com, dan.j.williams@intel.com, bigeasy@linutronix.de, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

* John Ogness <john.ogness@linutronix.de> [160211 04:04]:
> 
> At these speeds, nearly every DMA interrupt is accompanied by a spurious
> UART interrupt. So, sadly, the interrupts are doubled.
> 
> It is on my TODO list to verify if the spurious UART interrupts exactly
> match the recently added [0] spurious interrupt detection in omap-intc.

If you're seeing spurious interrupts you may want try adding
a flush of posted write at the end of the 8250_omap interrupt
handler. Basically read back some register from the 8250. This
has fixed so far pretty much all the spurious IRQ issues for
omaps using the drivers/irqchip/irq-omap-intc.c, meaning omap3
and am335x and ti81xx variants too most likely.

Regards,

Tony
