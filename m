From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: ST16C554 Serial device driver
Date: Tue, 21 Sep 2004 13:54:14 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040921135414.C16836@flint.arm.linux.org.uk>
References: <41500508.9010004@free.fr> <20040921130957.B16836@flint.arm.linux.org.uk> <4150200F.7020407@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14602 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267653AbUIUMyR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Sep 2004 08:54:17 -0400
Content-Disposition: inline
In-Reply-To: <4150200F.7020407@free.fr>; from eric.valette@free.fr on Tue, Sep 21, 2004 at 02:35:27PM +0200
List-Id: linux-serial@vger.kernel.org
To: Eric Valette <eric.valette@free.fr>
Cc: linux-serial@vger.kernel.org

On Tue, Sep 21, 2004 at 02:35:27PM +0200, Eric Valette wrote:
> Russell King wrote:
> > What is the result of an autodetect at the correct address?  What are
> > the commands you're issuing to tell the kernel where this port is?
> > Do you get any kernel messages, and what are they?
> 
> What is more suspect is the 0x287 (0x2a7) and register address that is 
> described in the manufacturer documentation of the PC104 board that says 
> : "When the same IRQ is shared by the 4 ports, the card uses 2 registers 
> at 287H, one to valid the interrupts and the other to read back the 4 
> interrupt status". The attached pictures gives the signification of the 
> register.

Ok the above shouldn't be a problem.

> regarding configuration I basically said :
> 	setserial /dev/ttyS2 port 0x280 irq 10 autoconfig
> 
> (same with the four ports) and
> 
> 	setserial /dev/ttyS6 port 0x2a0 irq 11 autoconfig
> 
> (same with the four ports)

Can you run:

	setserial -bav /dev/ttyS2

so we can see what the kernel has done?

Do you get any kernel messages, either when you ask it to do the
autoconfig or when you try to use the port(s)?

In addition, looking at /proc/tty/driver/serial and /proc/interrupts
may provide some extra information, especially the before and after
sending characters.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
