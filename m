From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: pmac serial_pci_guess_board problem
Date: Fri, 4 Nov 2005 22:50:51 +0000
Message-ID: <20051104225051.GC12026@flint.arm.linux.org.uk>
References: <436BD229.3090401@am.sony.com> <1131140861.29195.13.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40203 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751085AbVKDWu6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 Nov 2005 17:50:58 -0500
Content-Disposition: inline
In-Reply-To: <1131140861.29195.13.camel@gaston>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geoff Levand <geoffrey.levand@am.sony.com>, linux-serial@vger.kernel.org

On Sat, Nov 05, 2005 at 08:47:40AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2005-11-04 at 13:27 -0800, Geoff Levand wrote:
> > Russell,
> > 
> > I found that the serial port probe code in drivers/serial/8250_pci.c 
> > no longer works properly for PowerMac G5 in 2.6.14.  It seems some new
> > code now takes the PCI device info directly from the G5's Open 
> > Firmware.  The trouble is that OF sets the address length to 16 bytes, 
> > not the expected 8 bytes.
> > 
> > Here's a fix, but I'd be interested to hear your comments.
> 
> I wouldn't do the ifdef at all ... Why do we bother testing the size
> anyway ? Russell ?

That's the expected size of the ports.  Remember this is a heuristic
for finding the correct details of the ports.  Some cards seem to
have regions of 16 bytes which aren't serial ports.

I'm _very_ nervous about changing this, especially as it pre-dates
my time and you seem to imply that it's an OF problem.  Can't it be
fixed up in a PCI quirk?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
