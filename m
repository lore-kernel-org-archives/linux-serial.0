From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 24 Jul 2008 13:27:46 +0100
Message-ID: <20080724132746.1a961584@lxorguk.ukuu.org.uk>
References: <200807241347.33261.laurentp@cse-semaphore.com>
	<20080724125706.19844a96@lxorguk.ukuu.org.uk>
	<20080724122402.GC9327@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37425 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754114AbYGXMpE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 08:45:04 -0400
In-Reply-To: <20080724122402.GC9327@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Laurent Pinchart <laurentp@cse-semaphore.com>, linux-serial@vger.kernel.org

> On devices which don't support hardware RS485, what should be done is
> the termios bit remains clear, so that programs can tell if the port
> doesn't support it (as per POSIX.)

Or the serial layer should do it in software.

> I would also stress that this feature should be limited to enabling
> _hardware_ RS485 support, and not software emulation of that.  The
> reason being is that with plain 16550 UARTs, the best you can do 
> with interrupts is to know when the last character is transferred out
> of the transmit holding register into the transmit shift register - in
> other words, before the last character has finished transmission.

So the 16550 sucks, that's not true of everyone elses uarts.

> Basically, software RS485 is very yucky, and we've always resisted
> having that support in the kernel.

Agreed entirely. Which takes us more and more to the setserial path even
if it means standardising some setserial bit to get everyone back in line.

Alan
