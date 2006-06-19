From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
Date: Mon, 19 Jun 2006 20:40:24 +0100 (BST)
Message-ID: <20060619194024.99464.qmail@web52903.mail.yahoo.com>
References: <20060619184706.GH3479@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web52903.mail.yahoo.com ([206.190.49.13]:42838 "HELO
	web52903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964863AbWFSTk0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Jun 2006 15:40:26 -0400
In-Reply-To: <20060619184706.GH3479@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

--- Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> This seems to be an invalid situation - you appear to have an _ISA_
> NE2000 card using IRQ3, trying to share the same interrupt as a
> serial port.
> 
> ISA interrupts aren't sharable without additional hardware support
> or specific software support in the Linux kernel interrupt
> architecture.

Hmm, I see what you mean. Except that I thought that I'd manually disabled the motherboard's
serial device on IRQ 3, via the BIOS:

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: Device 00:07 activated.
00:07: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
pnp: Device 00:08 activated.
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

Does Linux reenable all motherboard devices, regardless?

Cheers,
Chris



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
