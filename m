From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
Date: Mon, 19 Jun 2006 21:00:11 -0400
Message-ID: <20060620010011.GA25527@neo.rr.com>
References: <20060619184706.GH3479@flint.arm.linux.org.uk> <20060619194024.99464.qmail@web52903.mail.yahoo.com> <20060619194407.GJ3479@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cpe-71-64-120-181.neo.res.rr.com ([71.64.120.181]:33224 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S965017AbWFTAoc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Jun 2006 20:44:32 -0400
Content-Disposition: inline
In-Reply-To: <20060619194407.GJ3479@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, Jun 19, 2006 at 08:44:07PM +0100, Russell King wrote:
> On Mon, Jun 19, 2006 at 08:40:24PM +0100, Chris Rankin wrote:
> > --- Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > This seems to be an invalid situation - you appear to have an _ISA_
> > > NE2000 card using IRQ3, trying to share the same interrupt as a
> > > serial port.
> > > 
> > > ISA interrupts aren't sharable without additional hardware support
> > > or specific software support in the Linux kernel interrupt
> > > architecture.
> > 
> > Hmm, I see what you mean. Except that I thought that I'd manually disabled the motherboard's
> > serial device on IRQ 3, via the BIOS:
> > 
> > Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> > serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> > pnp: Device 00:07 activated.
> > 00:07: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
> > pnp: Device 00:08 activated.
> > 00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> > 
> > Does Linux reenable all motherboard devices, regardless?
> 
> Question for Adam Belay.

Yes, if a driver is available for the device, it will enable it regardless of
the initial state.  Most manual BIOS configuration options don't actually
disable the device in the commonly understood sense.  Rather, they tell the
BIOS not to waste any time configuring the device, as the operating system
is fully capable of doing so.  On operating systems that aren't PnP capable
these options might have a greater effect.

Thanks,
Adam
