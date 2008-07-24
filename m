From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 24 Jul 2008 13:24:02 +0100
Message-ID: <20080724122402.GC9327@flint.arm.linux.org.uk>
References: <200807241347.33261.laurentp@cse-semaphore.com> <20080724125706.19844a96@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60457 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbYGXMYS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 08:24:18 -0400
Content-Disposition: inline
In-Reply-To: <20080724125706.19844a96@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Laurent Pinchart <laurentp@cse-semaphore.com>, linux-serial@vger.kernel.org

On Thu, Jul 24, 2008 at 12:57:06PM +0100, Alan Cox wrote:
> On Thu, 24 Jul 2008 13:47:29 +0200
> Laurent Pinchart <laurentp@cse-semaphore.com> wrote:
> 
> > This patch adds support for the automatic RS485 direction control feature
> > present in 16850 UARTs.
> > 
> > A new termios c_cflag, CARTS, is introduced to configure automatic direction
> > control from userspace.
> > 
> > This is a first proposal. I'm open to suggestions regarding the CARTS name.
> > I assume the CARTS flag will have to be added to all asm/termbits.h headers.
> > Why are the termios bits definitions platform specific ?
> 
> Because many of them are made to match up with the existing previous
> OS on those systems (eg to match with Alpha OSF).
> 
> I've no fundamental objection to this but I do wonder whether this
> feature belongs in setserial rather than termios as it is so chip
> specific ?

It may be specific to certain chips, but of those drivers which support
hardware RS485 modes to date, everyone has invented their own ioctl to
switch to RS485 mode.  There's no unification between any of the serial
drivers for this.

On devices which don't support hardware RS485, what should be done is
the termios bit remains clear, so that programs can tell if the port
doesn't support it (as per POSIX.)

I would also stress that this feature should be limited to enabling
_hardware_ RS485 support, and not software emulation of that.  The
reason being is that with plain 16550 UARTs, the best you can do 
with interrupts is to know when the last character is transferred out
of the transmit holding register into the transmit shift register - in
other words, before the last character has finished transmission.

Knowing when that character has been transmitted involves polling the
LSR - and having the kernel sit in a loop waiting for that event is
extremely wasteful.  Scheduling to other processes... well, you don't
know if there's some timing constraint - eg, must deassert RTS 1us
after the stop bit of the last character.

Basically, software RS485 is very yucky, and we've always resisted
having that support in the kernel.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
