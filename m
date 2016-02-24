From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Wed, 24 Feb 2016 16:46:34 +0100
Message-ID: <56CDD05A.7050402@linutronix.de>
References: <87lh7hrjsg.fsf@linutronix.de>
 <56A66FCB.1000507@hurleysoftware.com> <87y4b85onp.fsf@linutronix.de>
 <56B15603.80807@hurleysoftware.com> <87wpqbihel.fsf@linutronix.de>
 <20160211210050.GY19432@atomide.com> <874md0yd81.fsf@linutronix.de>
 <56CC2D83.3090900@ti.com> <56CD2184.40304@hurleysoftware.com>
 <56CDCE2A.30809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56CDCE2A.30809@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Peter Hurley <peter@hurleysoftware.com>, John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: gregkh@linuxfoundation.org, vinod.koul@intel.com, dan.j.williams@intel.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 02/24/2016 04:37 PM, Sekhar Nori wrote:
> I don't see the error interrupt count in /proc/interrupts go up although
> the code is returning IRQ_NONE when this happens. I initially thought
> that must be because of the interrupt being IRQF_SHARED. But getting rid
> of IRQF_SHARED still does not lead to error count going up. I need to
> spend some more time to see what is going on.

that error counter goes up if the interrupt controller can not find an
interrupt number. That means a HW interrupt was raised but after
checking the interrupt source (by the GIC) there is none. In this case
we have one: the UART.

> Regards,
> Sekhar

Sebastian
