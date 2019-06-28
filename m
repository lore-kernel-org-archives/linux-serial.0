From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 2/5] genirq: Add optional hardware synchronization for
 shutdown
Date: Fri, 28 Jun 2019 11:41:00 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906281128310.1802@nanos.tec.linutronix.de>
References: <20190625111353.863718167@linutronix.de> <20190625112405.666964552@linutronix.de> <dbcd11d3-c967-a0a0-02a6-86d162f93a56@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dbcd11d3-c967-a0a0-02a6-86d162f93a56@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>, Vadim Pasternak <vadimp@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Marc,

On Fri, 28 Jun 2019, Marc Zyngier wrote:
> On 25/06/2019 12:13, Thomas Gleixner wrote:
> >  
> >  	int		(*irq_set_affinity)(struct irq_data *data, const struct cpumask *dest, bool force);
> >  	int		(*irq_retrigger)(struct irq_data *data);
> > +	int		(*irq_inflight)(struct irq_data *data);
> 
> I wonder how different this irq_inflight() is from the irq_get_irqchip_state()
> that can already report a number of states from the HW.
> 
> It is also unclear to me how "in flight" maps to the internal state of
> the interrupt controller: Is it pending? Acked? If the interrupt has been
> masked already, pending should be harmless (the interrupt won't fire anymore).
> But seeing it in the acked would probably mean that it is on its way to being
> handled, with a potential splat.

in flight means that the interrupt chip (in the offending case the IO-APIC)
has that interrupt raised internally _AND_ already propagated to the
destination CPU (in this case the local APIC of the destination). The CPU
has accepted the interrupt and now the chip is in a state where it waits
for it to be acknowledged. If we proceed in that state then the destination
CPU will eventually handle it _after_ all the resources are freed. But that
means that the in flight/wait for acknowledge state becomes stale because
the handling CPU does not find the connection to that chip anymore.

> > +		/*
> > +		 * If requested and supported, check at the chip whether it
> > +		 * is in flight at the hardware level:
> > +		 */
> > +		if (!inprogress && sync_chip && chip && chip->irq_inflight)
> > +			inprogress = chip->irq_inflight(irqd);
> 
> To expand on what I was trying to exptree above, I wonder if that would 
> be similar to in effect to:
> 
> 		if (!inprogress && sync_chip && chip && chip->irq_get_irqchip_state)
> 			chip->irq_get_irqchip_state(irqd, IRQCHIP_STATE_ACTIVE, &inprogress);

Ah, indeed that could be mapped to it.

I'm happy to get rid of the extra callback. Now the question is whether
this would would give an headache for any of the chips which already
implement that callback and whether it needs to become conditional on the
trigger type at the core level. For the IO-APIC this state is only defined
for level type which makes sense as edge is fire and forget.

Thanks,

	tglx
