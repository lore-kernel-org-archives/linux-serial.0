From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] zs: Move to the serial subsystem
Date: Wed, 30 May 2007 11:09:35 +0100
Message-ID: <20070530100935.GC19552@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64N.0705291258390.14456@blysk.ds.pg.gda.pl> <20070530011224.bf36d2df.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2299 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbXE3KJr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 May 2007 06:09:47 -0400
Content-Disposition: inline
In-Reply-To: <20070530011224.bf36d2df.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>

On Wed, May 30, 2007 at 01:12:24AM -0700, Andrew Morton wrote:
> > +			if (status & (Rx_SYS | Rx_BRK))
> > +				icount->brk++;
> > +			else if (status & FRM_ERR)
> > +				icount->frame++;
> > +			else if (status & PAR_ERR)
> > +				icount->parity++;
> 
> FRM_ERR and PAR_ERR are mutually exclusive, and cannot be set if either
> Rx_SYS or Rx_BRK are set?

That's actually fairly normal.  A break condition is by definition
a framing error, and possibly a parity error as well.  Also, a break
condition is not an error per-se.

Also, if you do add in the associated framing or parity errors, you're
likely to get different results from different hardware - some hardware
mask off the framing and parity errors when detecting a break condition.
Others don't.

> > +/*
> > + * Finally, routines used to initialize the serial port.
> > + */
> > +static int zs_startup(struct uart_port *uport)
> > +{
> > +	struct zs_port *zport = to_zport(uport);
> > +	struct zs_scc *scc = zport->scc;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	if (!scc->irq_guard) {
> > +		ret = request_irq(zport->port.irq, zs_interrupt,
> > +				  IRQF_SHARED, "scc", scc);
> > +		if (ret) {
> > +			printk(KERN_ERR "zs: can't get irq %d\n",
> > +			       zport->port.irq);
> > +			return ret;
> > +		}
> > +	}
> > +	scc->irq_guard++;
> 
> The ->irq_guard handling looks a little racy?
> 
> Perhaps higher-level locks prevent this.  If so, a comment explaining this
> would be reassuring.

Does look racy if "scc" is shared between several ports.  The locking
here is only per-port, so this is racy.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
