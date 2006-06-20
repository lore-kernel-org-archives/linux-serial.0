From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
Date: Tue, 20 Jun 2006 19:03:13 +0100
Message-ID: <20060620180313.GC7463@flint.arm.linux.org.uk>
References: <6pwmi-8mW-1@gated-at.bofh.it> <6px8R-Y7-43@gated-at.bofh.it> <6pxV5-2ci-13@gated-at.bofh.it> <6pz12-3Rg-67@gated-at.bofh.it> <6pzX4-5jE-19@gated-at.bofh.it> <6pA6B-5K8-33@gated-at.bofh.it> <E1FshOP-0000pd-No@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63497 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750755AbWFTSDW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jun 2006 14:03:22 -0400
Content-Disposition: inline
In-Reply-To: <E1FshOP-0000pd-No@be1.lrz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 7eggert@gmx.de
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <lkml@rtr.ca>, Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, Jun 20, 2006 at 04:39:49PM +0200, Bodo Eggert wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Ar Llu, 2006-06-19 am 17:52 -0400, ysgrifennodd Mark Lord:
> 
> >> Eh?  The vast majority of ISA bus devices have open-collector IRQ lines,
> > 
> > Not in my experience. In the network work at least very few are, they
> > all drive the chip lines all the time. Thats why Don Becker made sure
> > such drivers grab the lines at startup. Those which can share IRQ or
> > move IRQ grab at open
> 
> There are thousands of NE2K-clones, the driver can't know if sharing the IRQ
> will be OK for a given card. Is the change for sharing IRQs trivial enough
> to allow an if/else based on a load-time module parameter?

Not if it's an ISA card.  You need to loop over all interrupt source
devices until you're certain that they have released the interrupt
line before returning, otherwise you will end up with the IRQ line
stuck in a state where it can't cause any further interrupts.

The kernel has no such infrastructure, except within the serial driver
to allow multiple serial ports to share a common interrupt.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
