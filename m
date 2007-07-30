From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: serial flow control appears broken
Date: Mon, 30 Jul 2007 10:59:33 +0100
Message-ID: <20070730095933.GA20417@flint.arm.linux.org.uk>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no> <46A84B4A.6070902@shaw.ca> <46A8C6F1.4080309@howardsilvan.com> <Pine.LNX.4.64N.0707271216410.425@blysk.ds.pg.gda.pl> <46AA2748.80703@howardsilvan.com> <Pine.LNX.4.64N.0707271825220.425@blysk.ds.pg.gda.pl> <46AA3801.7090204@shaw.ca> <20070728092842.GC26443@flint.arm.linux.org.uk> <Pine.LNX.4.64N.0707301040320.12082@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59740 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbXG3KDD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Jul 2007 06:03:03 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0707301040320.12082@blysk.ds.pg.gda.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Lee Howard <faxguy@howardsilvan.com>, linux-serial@vger.kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org

On Mon, Jul 30, 2007 at 10:45:19AM +0100, Maciej W. Rozycki wrote:
> On Sat, 28 Jul 2007, Russell King wrote:
> 
> > Essentially, any complex interrupt handler (such as an IDE interrupt
> > doing a multi-sector PIO transfer _in interrupt context_) can cause this
> > kind of starvation.  That's why Linux 1.x had bottom halves - so that
> > the time consuming work could be moved out of the interrupt handler,
> > thereby causing minimal the blockage of other interrupts.
> > 
> > Unfortunately, that kind of design has been long since forgotten.
> > Apparantly modern machines are fast enough that it doesn't have to be
> > worried about anymore...  Or are they?
> 
>  I would guess it is not that the machines are fast enough, but that this 
> two-level processing makes things more complicated.  Enough that most 
> people would not bother digging into it unless really forced.  Only 
> occasional latency problems are probably not enough of a force.

It's a shame we don't have a way to measure IRQ latency - it would be
very useful to flag up problems.

I think the best we could do is to arrange for the timer interrupt to
complain if it's delayed by more than 1ms or so - but some architectures
already run their timers with IRQF_DISABLED as a work around some of
the latency issues.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
