From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: ST16C554 Serial device driver
Date: Tue, 21 Sep 2004 13:09:57 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040921130957.B16836@flint.arm.linux.org.uk>
References: <41500508.9010004@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16137 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267601AbUIUMKB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Sep 2004 08:10:01 -0400
Content-Disposition: inline
In-Reply-To: <41500508.9010004@free.fr>; from eric.valette@free.fr on Tue, Sep 21, 2004 at 12:40:08PM +0200
List-Id: linux-serial@vger.kernel.org
To: Eric Valette <eric.valette@free.fr>
Cc: linux-serial@vger.kernel.org

On Tue, Sep 21, 2004 at 12:40:08PM +0200, Eric Valette wrote:
> Sorry to annoy you with one small question : I'm currently working as a
> contractor to port an application from LynxOS to linux 2.6 and I'm
> annoyed with the serial driver code. I need to find a driver for a 
> ST16C554 quad serial ISA board. I've tried to use setserial with the 
> relevant IO ports and irq but cannot manage to output annything on the 
> PC 104 board.

The kernel 8250 driver is expected to drive this port.

What is the result of an autodetect at the correct address?  What are
the commands you're issuing to tell the kernel where this port is?
Do you get any kernel messages, and what are they?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
