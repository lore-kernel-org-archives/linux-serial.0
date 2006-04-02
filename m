From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Hang in uart_block_til_ready()
Date: Sun, 2 Apr 2006 15:38:27 +0100
Message-ID: <20060402143827.GA3565@flint.arm.linux.org.uk>
References: <20060402135138.GC2954@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6159 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932349AbWDBOid (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Apr 2006 10:38:33 -0400
Content-Disposition: inline
In-Reply-To: <20060402135138.GC2954@hansmi.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-serial@vger.kernel.org

On Sun, Apr 02, 2006 at 03:51:38PM +0200, Michael Hanselmann wrote:
> I've discovered a problem where I'm not sure wether it's an error in the
> kernel or in the hardware.

It's neither - it's a bug in your test program.  If you want "callout"
semantics, open the port using O_NONBLOCK mode.

If you don't open the port using O_NONBLOCK then the port will wait for
the DCD line (or virtual DCD line) to be asserted by the hardware before
exiting uart_block_til_ready().  This is used for gettys on UARTs so
they don't display the login banner until someone connects to the port.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
