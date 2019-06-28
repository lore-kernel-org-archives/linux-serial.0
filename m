From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 1/5] genirq: Delay deactivation in free_irq()
Date: Fri, 28 Jun 2019 11:28:22 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906281126290.1802@nanos.tec.linutronix.de>
References: <20190625111353.863718167@linutronix.de> <20190625112405.573914765@linutronix.de> <0bb6aae3-744b-7752-04ec-9a0e68fb86e6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0bb6aae3-744b-7752-04ec-9a0e68fb86e6@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>, Vadim Pasternak <vadimp@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Marc,

On Fri, 28 Jun 2019, Marc Zyngier wrote:
> > --- a/kernel/irq/autoprobe.c
> > +++ b/kernel/irq/autoprobe.c
> > @@ -1699,6 +1700,7 @@ static struct irqaction *__free_irq(stru
> >  	/* If this was the last handler, shut down the IRQ line: */
> >  	if (!desc->action) {
> >  		irq_settings_clr_disable_unlazy(desc);
> > +		/* Only shutdown. Deactivate after synchronize_irq() */
> 
> synchronize_hardirq()

Correct.

> >  
> >  	irq_release_resources(desc);
> The patch makes complete sense, so this comment is only a nit, feel free 
> to ignore me: I find it a bit odd that irq_shutdown() doesn't do the 
> full thing anymore, given that it is the "canonical" function, and that 
> __free_irq is the only one that has special needs. Suggestion below.

We have pretty much the same thing with startup, so I made it symmetric.

> Irrespective of which version you prefer:
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks for looking into this!

       tglx
