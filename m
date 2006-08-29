From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] RM9000 serial driver
Date: Tue, 29 Aug 2006 20:59:06 +0100
Message-ID: <20060829195906.GA22913@flint.arm.linux.org.uk>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608220057.52213.thomas.koeller@baslerweb.com> <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp> <200608260038.13662.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com> <20060829190426.GA20606@flint.arm.linux.org.uk> <44F4976E.7020702@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:61197 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750846AbWH2T7M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Aug 2006 15:59:12 -0400
Content-Disposition: inline
In-Reply-To: <44F4976E.7020702@ru.mvista.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Thomas Koeller <thomas.koeller@baslerweb.com>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org

On Tue, Aug 29, 2006 at 11:37:18PM +0400, Sergei Shtylyov wrote:
> >>  Not sure the autoconfig code was intended for half-compatible UARTs. 
> >>  Note that it sets up->port.type as its result. However, your change 
> >>  seems correct, it just have nothing to do with RM9000.
> 
> >It's worse than that - this code is there to read the ID from the divisor
> >registers implemented in some UARTs.  If it isn't one of those UARTs, it's
> >expected to return zero.
> 
>    Well, I guess it should still return 0 (or revision) if we use 
>    serial_dl_*()?

Not sure.  Does this code actually even get reached?

> >>  As a side note, I think that the code that sets DLAB before and resets 
> >>  it
> >>after the divisor latch read/write should be part of serial_dl_read() and
> >>serial_dl_write() actually. In the Alchemy UARTs this bit is reserved.
> 
> >Not really, for two reasons.
> 
> >1. We end up with additional pointless writes to undo what serial_dl_*
> >   did.
> 
>    Yes, sometimes.
> 
> >2. setting DLAB might work for a subset of ports, but others require
> >   different magic numbers written to LCR to access the divisor.
> 
>    Indeed, I've spotted one such case. But we could possible RMW the line 
> control reg. so that serial_dl_*() "cleanup" after themselves?

Not really - writing 0xEF is one such magic number, and it doesn't
change the current settings.  If you then clear DLAB (iow, 0x6F),
there's no guarantee that it won't change the settings on you, and,
eg start sending a break condition.  Why?  0xEF is defined to be a
magic number to access additional features, and 0x6f has no such
meaning.

> >3. other ports have additional properties when DLAB is set, to the
> >   extent that you must not write other registers when it's reset to
> >   avoid clearing some features you want to enable.
> 
> >So, really, Moving that stuff into serial_dl_* ends up adding additional
> >code and complexity where it isn't needed.
> 
> Well, alternatively, the checks might be added to the places where DLAB 
> is written preventing the write for UARTs that don't have the bit. Or even 
> such check and LCR masking or even write skipping might be added to 
> serial_out()?

In a similar way to the TSI ports?  Yes, that'd work.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
