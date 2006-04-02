From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Hang in uart_block_til_ready()
Date: Sun, 2 Apr 2006 16:23:50 +0100
Message-ID: <20060402152350.GA5283@flint.arm.linux.org.uk>
References: <20060402135138.GC2954@hansmi.ch> <20060402143827.GA3565@flint.arm.linux.org.uk> <20060402151739.GA402@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32019 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750855AbWDBPXz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Apr 2006 11:23:55 -0400
Content-Disposition: inline
In-Reply-To: <20060402151739.GA402@hansmi.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-serial@vger.kernel.org

On Sun, Apr 02, 2006 at 05:17:39PM +0200, Michael Hanselmann wrote:
> Hello Russell
> 
> On Sun, Apr 02, 2006 at 03:38:27PM +0100, Russell King wrote:
> > On Sun, Apr 02, 2006 at 03:51:38PM +0200, Michael Hanselmann wrote:
> > > I've discovered a problem where I'm not sure wether it's an error in the
> > > kernel or in the hardware.
> 
> > It's neither - it's a bug in your test program.  If you want "callout"
> > semantics, open the port using O_NONBLOCK mode.
> 
> I've now patched screen(1) and it works, but one thing is amazing me.
> The other computer I wrote about has the serial console on ttyS0 and
> starting screen(1) on the serial console works. Here's the relevant
> strace part:

Have you checked the state of the DCD line in both cases?  Look in
/proc/tty/driver/serial.

> Am I going correct that this is a bug in screen(1) and it only works on
> the first box by some mysterious reason? Mabye some timing issue?

Probably "works" on the first box because it happens to have DCD asserted
on the real serial port.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
